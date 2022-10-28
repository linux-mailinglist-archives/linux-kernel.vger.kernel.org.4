Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D8611D59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJ1WTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ1WTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:19:09 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FA24D891;
        Fri, 28 Oct 2022 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666995547;
        bh=7fGGTJiBnBwoOzWOY+OrfZgCSiiHtsd/IqDjU+qNNFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uWts0J68AVvRNslRuA09DiQH4RNCub/3+XelVs/vnZ0uAKVzlZstImBPaJCGDAHpl
         tok01SdDtXyY7fErphN0+DRQrUH3HL5LC259Oei+wcE8X3cAiGwupFjrl3mOfqr+F5
         lxNWXK3MhGYdD3Fte2Ni6x80s1hYH2jHB5L4RwFql0AcwL5u+wTrNjjdw40qCLu4+J
         rRBGsHu9/WvClWWuMrvVT6gK8s5sCyl7kxT4Taohh4BifxoshtBlsLgi7m2nLWPSnM
         hWvn+V9LJvYIb53BiyH9JJOi2qDSFVh3usibd+acV7Ms1riKBgh/+8EfgmFuiv44+9
         qmPDFVHCI2NVw==
Received: from [172.16.0.156] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MzcQg4GTGz16MQ;
        Fri, 28 Oct 2022 18:19:07 -0400 (EDT)
Message-ID: <a18e940d-8423-0294-23b4-f2702313f3eb@efficios.com>
Date:   Fri, 28 Oct 2022 18:19:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221027224011.2075-3-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-27 18:40, Beau Belgrave wrote:
> When events are enabled within the various tracing facilities, such as
> ftrace/perf, the event_mutex is held. As events are enabled pages are
> accessed. We do not want page faults to occur under this lock. Instead
> queue the fault to a workqueue to be handled in a process context safe
> way without the lock.
> 
> The enable address is disabled while the async fault-in occurs. This
> ensures that we don't attempt fault-in more than is necessary. Once the
> page has been faulted in, the address write is attempted again. If the
> page couldn't fault-in, then we wait until the next time the event is
> enabled to prevent any potential infinite loops.

I'm also unclear about how the system call initiating the enabled state 
change is delayed (or not) when a page fault is queued.

I would expect that when a page fault is needed, after enqueuing work to 
the worker thread, the system call initiating the state change would 
somehow wait for a completion (after releasing the user events mutex). 
That completion would be signaled by the worker thread either if the 
page fault fails, or if the state change is done.

Thoughts ?

Thanks,

Mathieu

> 
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
>   kernel/trace/trace_events_user.c | 125 ++++++++++++++++++++++++++++++-
>   1 file changed, 121 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 633f24c2a1ac..f1eb8101e053 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -81,11 +81,22 @@ struct user_event_enabler {
>   	struct list_head link;
>   	struct mm_struct *mm;
>   	struct file *file;
> +	refcount_t refcnt;
>   	unsigned long enable_addr;
>   	unsigned int enable_bit: 5,
> -		     __reserved: 27;
> +		     __reserved: 26,
> +		     disabled: 1;
>   };
>   
> +/* Used for asynchronous faulting in of pages */
> +struct user_event_enabler_fault {
> +	struct work_struct work;
> +	struct user_event_enabler *enabler;
> +	struct user_event *event;
> +};
> +
> +static struct kmem_cache *fault_cache;
> +
>   /*
>    * Stores per-event properties, as users register events
>    * within a file a user_event might be created if it does not
> @@ -236,6 +247,19 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler)
>   	kfree(enabler);
>   }
>   
> +static __always_inline struct user_event_enabler
> +*user_event_enabler_get(struct user_event_enabler *enabler)
> +{
> +	refcount_inc(&enabler->refcnt);
> +	return enabler;
> +}
> +
> +static void user_event_enabler_put(struct user_event_enabler *enabler)
> +{
> +	if (refcount_dec_and_test(&enabler->refcnt))
> +		user_event_enabler_destroy(enabler);
> +}
> +
>   static void user_event_enabler_remove(struct file *file,
>   				      struct user_event *user)
>   {
> @@ -249,13 +273,93 @@ static void user_event_enabler_remove(struct file *file,
>   		if (enabler->file != file)
>   			continue;
>   
> +		enabler->disabled = 0;
>   		list_del(&enabler->link);
> -		user_event_enabler_destroy(enabler);
> +		user_event_enabler_put(enabler);
>   	}
>   
>   	mutex_unlock(&event_mutex);
>   }
>   
> +static void user_event_enabler_write(struct user_event_enabler *enabler,
> +				     struct user_event *user);
> +
> +static void user_event_enabler_fault_fixup(struct work_struct *work)
> +{
> +	struct user_event_enabler_fault *fault = container_of(
> +		work, struct user_event_enabler_fault, work);
> +	struct user_event_enabler *enabler = fault->enabler;
> +	struct user_event *user = fault->event;
> +	struct mm_struct *mm = enabler->mm;
> +	unsigned long uaddr = enabler->enable_addr;
> +	bool unlocked = false;
> +	int ret;
> +
> +	might_sleep();
> +
> +	mmap_read_lock(mm);
> +
> +	ret = fixup_user_fault(mm, uaddr, FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
> +			       &unlocked);
> +
> +	mmap_read_unlock(mm);
> +
> +	if (ret)
> +		pr_warn("user_events: Fixup fault failed with %d "
> +			"for mm: 0x%pK offset: 0x%llx event: %s\n", ret, mm,
> +			(unsigned long long)uaddr, EVENT_NAME(user));
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
> +	enabler->disabled = 0;
> +
> +	if (!ret)
> +		user_event_enabler_write(enabler, user);
> +
> +	mutex_unlock(&event_mutex);
> +
> +	refcount_dec(&user->refcnt);
> +	user_event_enabler_put(enabler);
> +	kmem_cache_free(fault_cache, fault);
> +}
> +
> +static bool user_event_enabler_queue_fault(struct user_event_enabler *enabler,
> +					   struct user_event *user)
> +{
> +	struct user_event_enabler_fault *fault;
> +
> +	fault = kmem_cache_zalloc(fault_cache, GFP_NOWAIT | __GFP_NOWARN);
> +
> +	if (!fault)
> +		return false;
> +
> +	INIT_WORK(&fault->work, user_event_enabler_fault_fixup);
> +	fault->enabler = user_event_enabler_get(enabler);
> +	fault->event = user;
> +
> +	refcount_inc(&user->refcnt);
> +	enabler->disabled = 1;
> +
> +	if (!schedule_work(&fault->work)) {
> +		enabler->disabled = 0;
> +		refcount_dec(&user->refcnt);
> +		user_event_enabler_put(enabler);
> +		kmem_cache_free(fault_cache, fault);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   static void user_event_enabler_write(struct user_event_enabler *enabler,
>   				     struct user_event *user)
>   {
> @@ -266,6 +370,11 @@ static void user_event_enabler_write(struct user_event_enabler *enabler,
>   	void *kaddr;
>   	int ret;
>   
> +	lockdep_assert_held(&event_mutex);
> +
> +	if (unlikely(enabler->disabled))
> +		return;
> +
>   	mmap_read_lock(mm);
>   
>   	ret = pin_user_pages_remote(mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
> @@ -273,8 +382,10 @@ static void user_event_enabler_write(struct user_event_enabler *enabler,
>   
>   	mmap_read_unlock(mm);
>   
> -	if (ret <= 0) {
> -		pr_warn("user_events: Enable write failed\n");
> +	if (unlikely(ret <= 0)) {
> +		if (!user_event_enabler_queue_fault(enabler, user))
> +			pr_warn("user_events: Unable to queue fault handler\n");
> +
>   		return;
>   	}
>   
> @@ -321,6 +432,7 @@ static struct user_event_enabler
>   	enabler->file = file;
>   	enabler->enable_addr = (unsigned long)reg->enable_addr;
>   	enabler->enable_bit = reg->enable_bit;
> +	refcount_set(&enabler->refcnt, 1);
>   
>   	/* Prevents state changes from racing with new enablers */
>   	mutex_lock(&event_mutex);
> @@ -1902,6 +2014,11 @@ static int __init trace_events_user_init(void)
>   {
>   	int ret;
>   
> +	fault_cache = KMEM_CACHE(user_event_enabler_fault, 0);
> +
> +	if (!fault_cache)
> +		return -ENOMEM;
> +
>   	init_group = user_event_group_create(&init_user_ns);
>   
>   	if (!init_group)

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

