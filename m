Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51A6436DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLEV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiLEV1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:27:50 -0500
X-Greylist: delayed 626 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 13:27:48 PST
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E66565;
        Mon,  5 Dec 2022 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1670275665;
        bh=IForlXy/HN1JxKlZ7ZKBLkhWSJNsqziLiIPYlvcsIxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uOs7a9CfXS37lHi9FvVbkGXEunA7XgSgSmgrh7pDGJiiP2LpNCCDVdrMUx8iRsFHT
         XFiBsfrD1jiaN2TaJ16lbXmvUpfiZZfy8xsSGD25DzSHPmD6aXMn9coSgMGkQ/cbha
         uM10Oq33zyCHfUupKeG+SqIDX1UMTZ0Qjuhy/CRnE40OvpHDQcxsiSW3csjWlfexQB
         MN8o2E8AoaG4EHDUOZ2Yr4FK3qhm6LJNKXnH5BFks8mxokZc5D0dcCcnmDlE8ngrNM
         Gal+jmaxxj3TZUXtt6RljdJeAcNdhdgVj9PnohNDaPDCME6E4A6kYYgLekXNOpwEW4
         tUkHWaNPIfwxA==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NQxTr5nnNzZr4;
        Mon,  5 Dec 2022 16:27:44 -0500 (EST)
Message-ID: <acd9c1b1-e56f-e49c-6092-d53d51cd8d4c@efficios.com>
Date:   Mon, 5 Dec 2022 16:28:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 03/11] tracing/user_events: Use remote writes for event
 enablement
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
 <20221205210017.23440-4-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221205210017.23440-4-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 16:00, Beau Belgrave wrote:
[...]
>   #ifdef CONFIG_USER_EVENTS
>   struct user_event_mm {
> +	struct list_head link;
> +	struct list_head enablers;
> +	struct mm_struct *mm;
> +	struct user_event_mm *next;
> +	refcount_t refcnt;
> +	refcount_t tasks;
>   };
> -#endif
>   
> +extern void user_event_mm_dup(struct task_struct *t,
> +			      struct user_event_mm *old_mm);
> +
> +extern void user_event_mm_remove(struct task_struct *t);
> +
> +static inline void user_events_fork(struct task_struct *t,
> +				    unsigned long clone_flags)
> +{
> +	struct user_event_mm *old_mm;
> +
> +	if (!t || !current->user_event_mm)
> +		return;
> +
> +	old_mm = current->user_event_mm;
> +
> +	if (clone_flags & CLONE_VM) {
> +		t->user_event_mm = old_mm;
> +		refcount_inc(&old_mm->tasks);
> +		return;
> +	}
> +
> +	user_event_mm_dup(t, old_mm);
> +}
> +
> +static inline void user_events_execve(struct task_struct *t)
> +{
> +	if (!t || !t->user_event_mm)
> +		return;
> +
> +	user_event_mm_remove(t);
> +}
> +
> +static inline void user_events_exit(struct task_struct *t)
> +{
> +	if (!t || !t->user_event_mm)
> +		return;
> +
> +	user_event_mm_remove(t);
> +}

So this is adding user_event_mm_remove() calls on each execve and each 
process exit, correct ?

[...]


> +
> +void user_event_mm_remove(struct task_struct *t)
> +{
> +	struct user_event_mm *mm;
> +	unsigned long flags;
> +
> +	might_sleep();
> +
> +	mm = t->user_event_mm;
> +	t->user_event_mm = NULL;
> +
> +	/* Clone will increment the tasks, only remove if last clone */
> +	if (!refcount_dec_and_test(&mm->tasks))
> +		return;
> +
> +	/* Remove the mm from the list, so it can no longer be enabled */
> +	spin_lock_irqsave(&user_event_mms_lock, flags);
> +	list_del_rcu(&mm->link);
> +	spin_unlock_irqrestore(&user_event_mms_lock, flags);
> +
> +	/*
> +	 * Put for mm must be done after RCU sync to handle new refs in
> +	 * between the list_del_rcu() and now. This ensures any get refs
> +	 * during rcu_read_lock() are accounted for during list removal.
> +	 *
> +	 * CPU A			|	CPU B
> +	 * ---------------------------------------------------------------
> +	 * user_event_mm_remove()	|	rcu_read_lock();
> +	 * list_del_rcu()		|	list_for_each_entry_rcu();
> +	 * synchronize_rcu()		|	refcount_inc();
> +	 * .				|	rcu_read_unlock();
> +	 * user_event_mm_put()		|	.
> +	 */
> +	synchronize_rcu();

This means a synchronize_rcu() is added on each execve and each process 
exit ? I am really worried about the performance impact of this big 
hammer synchronization in those key points of process lifetime.

Thanks,

Mathieu

> +
> +	/*
> +	 * We need to wait for currently occurring writes to stop within
> +	 * the mm. This is required since exit_mm() snaps the current rss
> +	 * stats and clears them. On the final mmdrop(), check_mm() will
> +	 * report a bug if these increment.
> +	 *
> +	 * All writes/pins are done under mmap_read lock, take the write
> +	 * lock to ensure in-progress faults have completed. Faults that
> +	 * are pending but yet to run will check the task count and skip
> +	 * the fault since the mm is going away.
> +	 */
> +	mmap_write_lock(mm->mm);
> +	mmap_write_unlock(mm->mm);
> +
> +	/* MM is still alive, but won't be updated anymore */
> +	user_event_mm_put(mm);
> +}
> +
> +void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>   {
> -	int i = user->index;
> +	struct user_event_mm *mm = user_event_mm_create(t);
> +	struct user_event_enabler *enabler;
> +
> +	if (!mm)
> +		return;
> +
> +	rcu_read_lock();
>   
> -	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
> +	list_for_each_entry_rcu(enabler, &old_mm->enablers, link)
> +		if (!user_event_enabler_dup(enabler, mm))
> +			goto error;
> +
> +	rcu_read_unlock();
> +
> +	return;
> +error:
> +	rcu_read_unlock();
> +	user_event_mm_remove(t);
>   }
>   
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

