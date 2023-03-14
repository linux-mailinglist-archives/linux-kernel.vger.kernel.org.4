Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5596B90BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCNKyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:54:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F610AA6;
        Tue, 14 Mar 2023 03:54:31 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbVlC4kLBzKn3l;
        Tue, 14 Mar 2023 18:54:15 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 18:54:28 +0800
Subject: Re: [PATCH -next 5/5] md: protect md_thread with a new disk level
 spin lock
To:     Yu Kuai <yukuai1@huaweicloud.com>, <agk@redhat.com>,
        <snitzer@kernel.org>, <song@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
 <20230311093148.2595222-6-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <69e04735-b3f6-2d82-9920-eac330a69792@huawei.com>
Date:   Tue, 14 Mar 2023 18:54:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230311093148.2595222-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, song!

ÔÚ 2023/03/11 17:31, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test reports a uaf for 'mddev->sync_thread':
> 
> T1                      T2
> md_start_sync
>   md_register_thread
> 			raid1d
> 			 md_check_recovery
> 			  md_reap_sync_thread
> 			   md_unregister_thread
> 			    kfree
> 
>   md_wakeup_thread
>    wake_up
>    ->sync_thread was freed
> 
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem for other md_thread, and I really don't like the idea to
> borrow a global lock.
> 
> This patch use a disk level spinlock to protect md_thread in relevant apis.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 23 ++++++++++-------------
>   drivers/md/md.h |  1 +
>   2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index ab9299187cfe..a952978884a5 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -663,6 +663,7 @@ void mddev_init(struct mddev *mddev)
>   	atomic_set(&mddev->active, 1);
>   	atomic_set(&mddev->openers, 0);
>   	spin_lock_init(&mddev->lock);
> +	spin_lock_init(&mddev->thread_lock);
>   	atomic_set(&mddev->flush_pending, 0);
>   	init_waitqueue_head(&mddev->sb_wait);
>   	init_waitqueue_head(&mddev->recovery_wait);
> @@ -801,13 +802,8 @@ void mddev_unlock(struct mddev *mddev)
>   	} else
>   		mutex_unlock(&mddev->reconfig_mutex);
>   
> -	/* As we've dropped the mutex we need a spinlock to
> -	 * make sure the thread doesn't disappear
> -	 */
> -	spin_lock(&pers_lock);
>   	md_wakeup_thread(&mddev->thread, mddev);
>   	wake_up(&mddev->sb_wait);
> -	spin_unlock(&pers_lock);
>   }
>   EXPORT_SYMBOL_GPL(mddev_unlock);
>   
> @@ -7895,13 +7891,16 @@ static int md_thread(void *arg)
>   
>   void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev)
>   {
> -	struct md_thread *thread = *threadp;
> +	struct md_thread *thread;
>   
> +	spin_lock(&mddev->thread_lock);
> +	thread = *threadp;
>   	if (thread) {
>   		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
>   		set_bit(THREAD_WAKEUP, &thread->flags);
>   		wake_up(&thread->wqueue);
>   	}
> +	spin_unlock(&mddev->thread_lock);

I just found that md_wakeup_thread can be called from irq context:

md_safemode_timeout
  md_wakeup_thread

And I need to use irq safe spinlock apis here.

Can you drop this verion from md-next? I'll send a new version after I
verified that there are no new regression, at least for mdadm tests.

Thanks,
Kuai
>   }
>   EXPORT_SYMBOL(md_wakeup_thread);
>   
> @@ -7929,7 +7928,9 @@ int md_register_thread(struct md_thread **threadp,
>   		return err;
>   	}
>   
> +	spin_lock(&mddev->thread_lock);
>   	*threadp = thread;
> +	spin_unlock(&mddev->thread_lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL(md_register_thread);
> @@ -7938,18 +7939,14 @@ void md_unregister_thread(struct md_thread **threadp, struct mddev *mddev)
>   {
>   	struct md_thread *thread;
>   
> -	/*
> -	 * Locking ensures that mddev_unlock does not wake_up a
> -	 * non-existent thread
> -	 */
> -	spin_lock(&pers_lock);
> +	spin_lock(&mddev->thread_lock);
>   	thread = *threadp;
>   	if (!thread) {
> -		spin_unlock(&pers_lock);
> +		spin_unlock(&mddev->thread_lock);
>   		return;
>   	}
>   	*threadp = NULL;
> -	spin_unlock(&pers_lock);
> +	spin_unlock(&mddev->thread_lock);
>   
>   	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
>   	kthread_stop(thread->tsk);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8f4137ad2dde..ca182d21dd8d 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -367,6 +367,7 @@ struct mddev {
>   	int				new_chunk_sectors;
>   	int				reshape_backwards;
>   
> +	spinlock_t			thread_lock;
>   	struct md_thread		*thread;	/* management thread */
>   	struct md_thread		*sync_thread;	/* doing resync or reconstruct */
>   
> 
