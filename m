Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2C611D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJ1WIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJ1WHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:07:33 -0400
X-Greylist: delayed 1042 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 15:07:31 PDT
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C65124D888;
        Fri, 28 Oct 2022 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1666994850;
        bh=whPI/KIUTRxaWwwrcsT77u1cmm6f9BaRgnsCYOkRfgo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tQE1l/+kdoU4cXEVHBKAphA++HpTNqiMIHao2vSx0eSpDk8s8lomM5UA329Fim9h+
         I21QoB41Jpn9OwfC+XsC9p09TGxq2g6pmZ7hlG9oc9aK+MHLDm85a6+mz273TQGxvm
         0x+2F/F8H1hm+ROS6VvmMF9O6NY0iSAFbkJIVD08QPTSJkrprCsU3rVLaHB4pwrDQd
         73nLSZPz5p0pA4kPVPV5pAG64M07XzFeSYCsCyAvWmPxSO9yoxGke0yNGE8el76SKT
         ifhSRzApscXzizM6ySK5lUkRQwVJdL+bPk18oaGfrCVoqOIWwXck79yPT8gt2ebDmA
         b919PkBVauJPg==
Received: from [172.16.0.185] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Mzc9G3v77z15Yk;
        Fri, 28 Oct 2022 18:07:30 -0400 (EDT)
Message-ID: <7697b674-1dab-4995-9589-9dfb2a65bb73@efficios.com>
Date:   Fri, 28 Oct 2022 18:07:34 -0400
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

Good stuff! On my end, I've progressed on the "side" userspace 
instrumentation library prototype. It implements the static 
instrumentation layer to which a simple userspace printf-based tracer 
connects (for testing purposes). All moving parts are wired up now, 
including the type system and RCU to protect callback iteration against 
concurrent userspace tracer registration/unregistration.

The top bit of the "enable" words are reserved for user events. So you 
can see the "TODO" where the user events ioctl/writev would be expected:

https://github.com/compudj/side

I'm still slightly unsure about using "uint32_t" for enable check, or 
going for "unsigned long". The core question there is whether a 32-bit 
word test would cause partial register stalls on 64-bit architectures. 
Going for unsigned long would require that user events receives 
information about the bitness of the word as input from userspace. 
(bit=63 rather than 31). Perhaps this is something the user events ABI 
should accommodate by reserving more than 5 bits to express the target bit ?

> 
> The enable address is disabled while the async fault-in occurs. This
> ensures that we don't attempt fault-in more than is necessary. Once the
> page has been faulted in, the address write is attempted again. If the
> page couldn't fault-in, then we wait until the next time the event is
> enabled to prevent any potential infinite loops.

So if the page is removed from the page cache between the point where it 
is faulted in and the moment the write is re-attempted, that will not 
trigger another attempt at paging in the page, am I correct ?

I would think this is unexpected. I would expect that failing to fault 
in the page would stop any further attempts, but simply failing to pin 
the page after faulting it in should simply try again.

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

