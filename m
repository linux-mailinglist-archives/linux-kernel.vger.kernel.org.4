Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC403643811
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiLEW1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiLEW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:27:07 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63C6BAE72;
        Mon,  5 Dec 2022 14:27:04 -0800 (PST)
Received: from kbox (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id F1BA120B83CB;
        Mon,  5 Dec 2022 14:27:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1BA120B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670279224;
        bh=D6tbGpBcifLcSRDxvrkONCMPp1mHIGU4dakcTbKQPqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXQv0I9f+buIUuMo4l7Z+u16d90GrMa2hdHU3N/gbAlMaXl4QkHP+U1wPucKFadjJ
         EOo3Pihk1Z77ZTpC/BAIW8+q1/kVzBTmYL2l0xvUmTKLraHEXhYlrozR0ts9GbqGbB
         jNQowNHH15VhMSUc+vhbTJ9uAtQ9kj1QqmW7ldtk=
Date:   Mon, 5 Dec 2022 14:26:57 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/11] tracing/user_events: Use remote writes for
 event enablement
Message-ID: <20221205222657.GA2270@kbox>
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-4-beaub@linux.microsoft.com>
 <acd9c1b1-e56f-e49c-6092-d53d51cd8d4c@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd9c1b1-e56f-e49c-6092-d53d51cd8d4c@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:28:03PM -0500, Mathieu Desnoyers wrote:
> On 2022-12-05 16:00, Beau Belgrave wrote:
> [...]
> >   #ifdef CONFIG_USER_EVENTS
> >   struct user_event_mm {
> > +	struct list_head link;
> > +	struct list_head enablers;
> > +	struct mm_struct *mm;
> > +	struct user_event_mm *next;
> > +	refcount_t refcnt;
> > +	refcount_t tasks;
> >   };
> > -#endif
> > +extern void user_event_mm_dup(struct task_struct *t,
> > +			      struct user_event_mm *old_mm);
> > +
> > +extern void user_event_mm_remove(struct task_struct *t);
> > +
> > +static inline void user_events_fork(struct task_struct *t,
> > +				    unsigned long clone_flags)
> > +{
> > +	struct user_event_mm *old_mm;
> > +
> > +	if (!t || !current->user_event_mm)
> > +		return;
> > +
> > +	old_mm = current->user_event_mm;
> > +
> > +	if (clone_flags & CLONE_VM) {
> > +		t->user_event_mm = old_mm;
> > +		refcount_inc(&old_mm->tasks);
> > +		return;
> > +	}
> > +
> > +	user_event_mm_dup(t, old_mm);
> > +}
> > +
> > +static inline void user_events_execve(struct task_struct *t)
> > +{
> > +	if (!t || !t->user_event_mm)
> > +		return;
> > +
> > +	user_event_mm_remove(t);
> > +}
> > +
> > +static inline void user_events_exit(struct task_struct *t)
> > +{
> > +	if (!t || !t->user_event_mm)
> > +		return;
> > +
> > +	user_event_mm_remove(t);
> > +}
> 
> So this is adding user_event_mm_remove() calls on each execve and each
> process exit, correct ?
> 

Yes, as long as the process has registered a user_event. If it has not,
nothing happens.

> [...]
> 
> 
> > +
> > +void user_event_mm_remove(struct task_struct *t)
> > +{
> > +	struct user_event_mm *mm;
> > +	unsigned long flags;
> > +
> > +	might_sleep();
> > +
> > +	mm = t->user_event_mm;
> > +	t->user_event_mm = NULL;
> > +
> > +	/* Clone will increment the tasks, only remove if last clone */
> > +	if (!refcount_dec_and_test(&mm->tasks))
> > +		return;
> > +
> > +	/* Remove the mm from the list, so it can no longer be enabled */
> > +	spin_lock_irqsave(&user_event_mms_lock, flags);
> > +	list_del_rcu(&mm->link);
> > +	spin_unlock_irqrestore(&user_event_mms_lock, flags);
> > +
> > +	/*
> > +	 * Put for mm must be done after RCU sync to handle new refs in
> > +	 * between the list_del_rcu() and now. This ensures any get refs
> > +	 * during rcu_read_lock() are accounted for during list removal.
> > +	 *
> > +	 * CPU A			|	CPU B
> > +	 * ---------------------------------------------------------------
> > +	 * user_event_mm_remove()	|	rcu_read_lock();
> > +	 * list_del_rcu()		|	list_for_each_entry_rcu();
> > +	 * synchronize_rcu()		|	refcount_inc();
> > +	 * .				|	rcu_read_unlock();
> > +	 * user_event_mm_put()		|	.
> > +	 */
> > +	synchronize_rcu();
> 
> This means a synchronize_rcu() is added on each execve and each process exit
> ? I am really worried about the performance impact of this big hammer
> synchronization in those key points of process lifetime.
> 

Agreed, I can move this into a call_rcu() at the cost of an alloc.
Perhaps that will work better? I could have these in memcaches.

Thanks,
-Beau

> Thanks,
> 
> Mathieu
> 
> > +
> > +	/*
> > +	 * We need to wait for currently occurring writes to stop within
> > +	 * the mm. This is required since exit_mm() snaps the current rss
> > +	 * stats and clears them. On the final mmdrop(), check_mm() will
> > +	 * report a bug if these increment.
> > +	 *
> > +	 * All writes/pins are done under mmap_read lock, take the write
> > +	 * lock to ensure in-progress faults have completed. Faults that
> > +	 * are pending but yet to run will check the task count and skip
> > +	 * the fault since the mm is going away.
> > +	 */
> > +	mmap_write_lock(mm->mm);
> > +	mmap_write_unlock(mm->mm);
> > +
> > +	/* MM is still alive, but won't be updated anymore */
> > +	user_event_mm_put(mm);
> > +}
> > +
> > +void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> >   {
> > -	int i = user->index;
> > +	struct user_event_mm *mm = user_event_mm_create(t);
> > +	struct user_event_enabler *enabler;
> > +
> > +	if (!mm)
> > +		return;
> > +
> > +	rcu_read_lock();
> > -	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
> > +	list_for_each_entry_rcu(enabler, &old_mm->enablers, link)
> > +		if (!user_event_enabler_dup(enabler, mm))
> > +			goto error;
> > +
> > +	rcu_read_unlock();
> > +
> > +	return;
> > +error:
> > +	rcu_read_unlock();
> > +	user_event_mm_remove(t);
> >   }
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
