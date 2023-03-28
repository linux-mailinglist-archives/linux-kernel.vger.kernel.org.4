Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5B6CCC38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC1VnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1VnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:43:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57DF010F5;
        Tue, 28 Mar 2023 14:43:01 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6DCE820FD93E;
        Tue, 28 Mar 2023 14:43:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DCE820FD93E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680039780;
        bh=+850YOqLoGdgtDg3iL3aEjBqFLOqMf5TEeXHkCzL97I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIzmU5iqR8HdDZffizvvLtEB9Wt/Y9BX4SAEK9yQsNcE5JwqCzAAISeFlMKvopgqf
         5ZJ1LAhKvoQcXr7t2fWrqz+LzhBlsVmr5fiXIDugexcb1rcK9hUjEh1P4dU6mJdcAI
         kk+orsVZCV/HMwHKo9yJQGM/4+cBivYqwU9GU9lE=
Date:   Tue, 28 Mar 2023 14:42:54 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 04/11] tracing/user_events: Fixup enable faults asyncly
Message-ID: <20230328214254.GA85@W11-BEAU-MD.localdomain>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
 <20230221211143.574-5-beaub@linux.microsoft.com>
 <20230328172049.10061257@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328172049.10061257@gandalf.local.home>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:20:49PM -0400, Steven Rostedt wrote:
> On Tue, 21 Feb 2023 13:11:36 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > @@ -263,7 +277,85 @@ static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
> >  }
> >  
> >  static int user_event_enabler_write(struct user_event_mm *mm,
> > -				    struct user_event_enabler *enabler)
> > +				    struct user_event_enabler *enabler,
> > +				    bool fixup_fault);
> > +
> > +static void user_event_enabler_fault_fixup(struct work_struct *work)
> > +{
> > +	struct user_event_enabler_fault *fault = container_of(
> > +		work, struct user_event_enabler_fault, work);
> > +	struct user_event_enabler *enabler = fault->enabler;
> > +	struct user_event_mm *mm = fault->mm;
> > +	unsigned long uaddr = enabler->addr;
> > +	int ret;
> > +
> > +	ret = user_event_mm_fault_in(mm, uaddr);
> > +
> > +	if (ret && ret != -ENOENT) {
> > +		struct user_event *user = enabler->event;
> > +
> > +		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
> > +			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
> > +	}
> > +
> > +	/* Prevent state changes from racing */
> > +	mutex_lock(&event_mutex);
> > +
> > +	/*
> > +	 * If we managed to get the page, re-issue the write. We do not
> > +	 * want to get into a possible infinite loop, which is why we only
> > +	 * attempt again directly if the page came in. If we couldn't get
> > +	 * the page here, then we will try again the next time the event is
> > +	 * enabled/disabled.
> > +	 */
> 
> What case would we not get the page? A bad page mapping? User space doing
> something silly?
> 

A user space program unmapping the page is the most common I can think
of. A silly action would be unmapping the page while forgetting to call
the unregister IOCTL. We would then possibly see this if the event was
enabled in perf/ftrace before the process exited (and the mm getting
cleaned up).

> Or something else, for which how can it go into an infinite loop? Can that
> only happen if userspace is doing something mischievous?
> 

I'm not sure if changing page permissions on the user side would prevent
write permitted mapping in the kernel, but I wanted to ensure if that
type of thing did occur, we wouldn't loop forever. The code lets the mm
decide if a page is ever coming in via fixup_user_fault() with 
FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE set.

My understanding is that fixup_user_fault() will retry to get the page
up until it's decided it's either capable of coming in or not. It will
do this since we pass the unlocked bool as a parameter. I used
fixup_user_fault() since it was created for the futex code to handle
this scenario better.

From what I gather, the fault in should only fail for these reasons:
#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)

If these are hit, I don't believe we want to retry as they aren't likely
to ever get corrected.

Thanks,
-Beau

> -- Steve
> 
> 
> > +	clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> > +
> > +	if (!ret) {
> > +		mmap_read_lock(mm->mm);
> > +		user_event_enabler_write(mm, enabler, true);
> > +		mmap_read_unlock(mm->mm);
> > +	}
> > +
> > +	mutex_unlock(&event_mutex);
> > +
> > +	/* In all cases we no longer need the mm or fault */
> > +	user_event_mm_put(mm);
> > +	kmem_cache_free(fault_cache, fault);
> > +}
> > +
> > +static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
> > +					   struct user_event_enabler *enabler)
> > +{
> > +	struct user_event_enabler_fault *fault;
> > +
> > +	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
> > +
> > +	if (!fault)
> > +		return false;
> > +
> > +	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
> > +	fault->mm = user_event_mm_get(mm);
> > +	fault->enabler = enabler;
> > +
> > +	/* Don't try to queue in again while we have a pending fault */
> > +	set_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> > +
> > +	if (!schedule_work(&fault->work)) {
> > +		/* Allow another attempt later */
> > +		clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> > +
> > +		user_event_mm_put(mm);
> > +		kmem_cache_free(fault_cache, fault);
> > +
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
