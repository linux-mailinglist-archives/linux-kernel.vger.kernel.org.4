Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3718C6D4CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjDCPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjDCPyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:54:11 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A17B30E8;
        Mon,  3 Apr 2023 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=FovVbtJQkc2oFY+2ZjgKu9Sd27VhrqLkGbtdF6cagHM=; b=Sd9falHm9YuBs/YqwnP80xHx+D
        XwBVw9T/FBWqCIMqkf4++rbx8o0IAJsl0KtGM4vRAD9khEvwt4jVQdTFO8PEFeKDP2UlmMG6Ki0yp
        fdLmzEsz2KywaMgDhx5yRoLc/UVuMWMU8w5EQdLxqoqlUMHa17R4IAC+WpgHIQitPFuXBiMXTR/V7
        YoMgIBvZE0pge2jgdSzv2v8SCkhyP6dkW8Iee6ZSo0cUYLfn2Mo9qHhxWRUU35lf6tAzKjOCgnLP2
        B5KaKqO4Rdcpmj2gpN/arXgivt9DyT+LXi8EUpTlXFGz+UbM9t6gNO5Y9Mk66em4O0vlNoG2053w6
        s5DFtcCw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pjMUm-00H56t-6t; Mon, 03 Apr 2023 09:53:25 -0600
Message-ID: <84680f93-5936-4a80-fe9e-aed988654e28@deltatee.com>
Date:   Mon, 3 Apr 2023 09:53:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230402091236.976723-1-yukuai1@huaweicloud.com>
 <20230402091236.976723-6-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230402091236.976723-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 5/5] md: protect md_thread with rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-02 03:12, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test reports a uaf for 'mddev->sync_thread':
> 
> T1                      T2
> md_start_sync
>  md_register_thread
>  // mddev->sync_thread is set
> 			raid1d
> 			 md_check_recovery
> 			  md_reap_sync_thread
> 			   md_unregister_thread
> 			    kfree
> 
>  md_wakeup_thread
>   wake_up
>   ->sync_thread was freed
> 
> Root cause is that there is a small windown between register thread and
> wake up thread, where the thread can be freed concurrently.
> 
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem for other md_thread, and I really don't like the idea to
> borrow a global lock.
> 
> This patch protect md_thread with rcu.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c   | 21 ++++++++++----
>  drivers/md/md.c          | 62 ++++++++++++++++++----------------------
>  drivers/md/md.h          | 14 ++++-----
>  drivers/md/raid1.c       |  4 +--
>  drivers/md/raid1.h       |  2 +-
>  drivers/md/raid10.c      |  4 +--
>  drivers/md/raid10.h      |  2 +-
>  drivers/md/raid5-cache.c |  2 +-
>  drivers/md/raid5.c       |  4 +--
>  drivers/md/raid5.h       |  2 +-
>  10 files changed, 61 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index f670c72d97be..dc2ea2ce0ae9 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1784,6 +1784,7 @@ void md_bitmap_wait_behind_writes(struct mddev *mddev)
>  void md_bitmap_destroy(struct mddev *mddev)
>  {
>  	struct bitmap *bitmap = mddev->bitmap;
> +	struct md_thread *thread;
>  
>  	if (!bitmap) /* there was no bitmap */
>  		return;
> @@ -1797,8 +1798,12 @@ void md_bitmap_destroy(struct mddev *mddev)
>  	mddev->bitmap = NULL; /* disconnect from the md device */
>  	spin_unlock(&mddev->lock);
>  	mutex_unlock(&mddev->bitmap_info.mutex);
> -	if (mddev->thread)
> -		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
> +
> +	rcu_read_lock();
> +	thread = rcu_dereference(mddev->thread);
> +	if (thread)
> +		thread->timeout = MAX_SCHEDULE_TIMEOUT;
> +	rcu_read_unlock();
>  
>  	md_bitmap_free(bitmap);
>  }
> @@ -2433,6 +2438,7 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
>  {
>  	/* timeout can be set at any time */
>  	unsigned long timeout;
> +	struct md_thread *thread;
>  	int rv = strict_strtoul_scaled(buf, &timeout, 4);
>  	if (rv)
>  		return rv;
> @@ -2448,16 +2454,21 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
>  	if (timeout < 1)
>  		timeout = 1;
>  	mddev->bitmap_info.daemon_sleep = timeout;
> -	if (mddev->thread) {
> +
> +	rcu_read_lock();
> +	thread = rcu_dereference(mddev->thread);
> +	if (thread) {
>  		/* if thread->timeout is MAX_SCHEDULE_TIMEOUT, then
>  		 * the bitmap is all clean and we don't need to
>  		 * adjust the timeout right now
>  		 */
> -		if (mddev->thread->timeout < MAX_SCHEDULE_TIMEOUT) {
> -			mddev->thread->timeout = timeout;
> +		if (thread->timeout < MAX_SCHEDULE_TIMEOUT) {
> +			thread->timeout = timeout;
>  			md_wakeup_thread(mddev->thread);
>  		}
>  	}
> +	rcu_read_unlock();
> +
>  	return len;
>  }
>  
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index d5a29ccb24ec..5609b7e3abab 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -70,11 +70,7 @@
>  #include "md-bitmap.h"
>  #include "md-cluster.h"
>  
> -/* pers_list is a list of registered personalities protected
> - * by pers_lock.
> - * pers_lock does extra service to protect accesses to
> - * mddev->thread when the mutex cannot be held.
> - */
> +/* pers_list is a list of registered personalities protected by pers_lock. */
>  static LIST_HEAD(pers_list);
>  static DEFINE_SPINLOCK(pers_lock);
>  
> @@ -92,7 +88,7 @@ static struct workqueue_struct *md_rdev_misc_wq;
>  static int remove_and_add_spares(struct mddev *mddev,
>  				 struct md_rdev *this);
>  static void mddev_detach(struct mddev *mddev);
> -static void md_wakeup_thread_directly(struct md_thread *thread);
> +static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
>  
>  enum md_ro_state {
>  	MD_RDWR,
> @@ -803,13 +799,8 @@ void mddev_unlock(struct mddev *mddev)
>  	} else
>  		mutex_unlock(&mddev->reconfig_mutex);
>  
> -	/* As we've dropped the mutex we need a spinlock to
> -	 * make sure the thread doesn't disappear
> -	 */
> -	spin_lock(&pers_lock);
>  	md_wakeup_thread(mddev->thread);
>  	wake_up(&mddev->sb_wait);
> -	spin_unlock(&pers_lock);
>  }
>  EXPORT_SYMBOL_GPL(mddev_unlock);
>  
> @@ -7893,23 +7884,33 @@ static int md_thread(void *arg)
>  	return 0;
>  }
>  
> -static void md_wakeup_thread_directly(struct md_thread *thread)
> +static void md_wakeup_thread_directly(struct md_thread __rcu *thread)
>  {
> -	if (thread)
> -		wake_up_process(thread->tsk);
> +	struct md_thread *t;
> +
> +	rcu_read_lock();
> +	t = rcu_dereference(thread);
> +	if (t)
> +		wake_up_process(t->tsk);
> +	rcu_read_unlock();
>  }
>  
> -void md_wakeup_thread(struct md_thread *thread)
> +void md_wakeup_thread(struct md_thread __rcu *thread)
>  {
> -	if (thread) {
> -		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
> -		set_bit(THREAD_WAKEUP, &thread->flags);
> -		wake_up(&thread->wqueue);
> +	struct md_thread *t;
> +
> +	rcu_read_lock();
> +	t = rcu_dereference(thread);
> +	if (t) {
> +		pr_debug("md: waking up MD thread %s.\n", t->tsk->comm);
> +		set_bit(THREAD_WAKEUP, &t->flags);
> +		wake_up(&t->wqueue);
>  	}
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(md_wakeup_thread);
>  
> -int md_register_thread(struct md_thread **threadp,
> +int md_register_thread(struct md_thread __rcu **threadp,
>  		       void (*run)(struct md_thread *),
>  		       struct mddev *mddev, const char *name)
>  {
> @@ -7933,27 +7934,20 @@ int md_register_thread(struct md_thread **threadp,
>  		return err;
>  	}
>  
> -	*threadp = thread;
> +	rcu_assign_pointer(*threadp, thread);
>  	return 0;
>  }
>  EXPORT_SYMBOL(md_register_thread);
>  
> -void md_unregister_thread(struct md_thread **threadp)
> +void md_unregister_thread(struct md_thread __rcu **threadp)
>  {
> -	struct md_thread *thread;
> +	struct md_thread *thread = rcu_access_pointer(*threadp);
> -	/*
> -	 * Locking ensures that mddev_unlock does not wake_up a
> -	 * non-existent thread
> -	 */
> -	spin_lock(&pers_lock);
> -	thread = *threadp;
> -	if (!thread) {
> -		spin_unlock(&pers_lock);
> +	if (!thread)
>  		return;
> -	}
> -	*threadp = NULL;
> -	spin_unlock(&pers_lock);
> +
> +	rcu_assign_pointer(*threadp, NULL);
> +	synchronize_rcu();
>  
>  	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
>  	kthread_stop(thread->tsk);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 5acdd704a922..0525f6d66a4d 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -367,8 +367,8 @@ struct mddev {
>  	int				new_chunk_sectors;
>  	int				reshape_backwards;
>  
> -	struct md_thread		*thread;	/* management thread */
> -	struct md_thread		*sync_thread;	/* doing resync or reconstruct */
> +	struct md_thread __rcu		*thread;	/* management thread */
> +	struct md_thread __rcu		*sync_thread;	/* doing resync or reconstruct */
>  
>  	/* 'last_sync_action' is initialized to "none".  It is set when a
>  	 * sync operation (i.e "data-check", "requested-resync", "resync",
> @@ -719,9 +719,9 @@ struct md_io_acct {
>  #define THREAD_WAKEUP  0
>  
>  /* caller need to make sured returned md_thread won't be freed */
> -static inline struct md_thread *get_md_thread(struct md_thread *t)
> +static inline struct md_thread *get_md_thread(struct md_thread __rcu *t)
>  {
> -	return t;
> +	return rcu_access_pointer(t);

This should not be using rcu_access_pointer(). That function is only
appropriate when the value of t is not being dereferenced. This should
be using rcu_dereference_protected() with some reasoning as to why it's
safe to use this function. It might make sense to open code this for
every call site if the reasoning is different in each location.
Preferrably the second argument in the check should be some lockdep
condition that ensures this. If that's not possible, a comment
explaining the reasoning why it is safe in all the call sites should be
added here.

On one hand this is looking like my idea of using RCU is producing more
churn than the spin lock. On the other hand I think it's cleaning up and
documenting more unsafe use cases (like other potentially unsafe
accesses of the the thread pointer). So I still think the RCU is a good
approach here.

Thanks,

Logan
