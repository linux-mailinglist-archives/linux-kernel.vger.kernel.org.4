Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E36CCC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC1VU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC1VU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:20:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB21BC8;
        Tue, 28 Mar 2023 14:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A07761952;
        Tue, 28 Mar 2023 21:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E4EC433EF;
        Tue, 28 Mar 2023 21:20:51 +0000 (UTC)
Date:   Tue, 28 Mar 2023 17:20:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 04/11] tracing/user_events: Fixup enable faults
 asyncly
Message-ID: <20230328172049.10061257@gandalf.local.home>
In-Reply-To: <20230221211143.574-5-beaub@linux.microsoft.com>
References: <20230221211143.574-1-beaub@linux.microsoft.com>
        <20230221211143.574-5-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 13:11:36 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> @@ -263,7 +277,85 @@ static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr)
>  }
>  
>  static int user_event_enabler_write(struct user_event_mm *mm,
> -				    struct user_event_enabler *enabler)
> +				    struct user_event_enabler *enabler,
> +				    bool fixup_fault);
> +
> +static void user_event_enabler_fault_fixup(struct work_struct *work)
> +{
> +	struct user_event_enabler_fault *fault = container_of(
> +		work, struct user_event_enabler_fault, work);
> +	struct user_event_enabler *enabler = fault->enabler;
> +	struct user_event_mm *mm = fault->mm;
> +	unsigned long uaddr = enabler->addr;
> +	int ret;
> +
> +	ret = user_event_mm_fault_in(mm, uaddr);
> +
> +	if (ret && ret != -ENOENT) {
> +		struct user_event *user = enabler->event;
> +
> +		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
> +			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
> +	}
> +
> +	/* Prevent state changes from racing */
> +	mutex_lock(&event_mutex);
> +
> +	/*
> +	 * If we managed to get the page, re-issue the write. We do not
> +	 * want to get into a possible infinite loop, which is why we only
> +	 * attempt again directly if the page came in. If we couldn't get
> +	 * the page here, then we will try again the next time the event is
> +	 * enabled/disabled.
> +	 */

What case would we not get the page? A bad page mapping? User space doing
something silly?

Or something else, for which how can it go into an infinite loop? Can that
only happen if userspace is doing something mischievous?

-- Steve


> +	clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> +
> +	if (!ret) {
> +		mmap_read_lock(mm->mm);
> +		user_event_enabler_write(mm, enabler, true);
> +		mmap_read_unlock(mm->mm);
> +	}
> +
> +	mutex_unlock(&event_mutex);
> +
> +	/* In all cases we no longer need the mm or fault */
> +	user_event_mm_put(mm);
> +	kmem_cache_free(fault_cache, fault);
> +}
> +
> +static bool user_event_enabler_queue_fault(struct user_event_mm *mm,
> +					   struct user_event_enabler *enabler)
> +{
> +	struct user_event_enabler_fault *fault;
> +
> +	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
> +
> +	if (!fault)
> +		return false;
> +
> +	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
> +	fault->mm = user_event_mm_get(mm);
> +	fault->enabler = enabler;
> +
> +	/* Don't try to queue in again while we have a pending fault */
> +	set_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> +
> +	if (!schedule_work(&fault->work)) {
> +		/* Allow another attempt later */
> +		clear_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler));
> +
> +		user_event_mm_put(mm);
> +		kmem_cache_free(fault_cache, fault);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
