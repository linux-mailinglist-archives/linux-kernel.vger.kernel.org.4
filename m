Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA866DCD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDJWXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDJWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B0212D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681165362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDXK0If8DoXOXvgzcDzv5QZrpGiI3IRCIb/ZVib9NSU=;
        b=HROQdHcwXT+uGrjxUWspeN1O0V6fiudlnzkluW8mS/ERloWm55k8STqPWJCrdgEVJ8MSzW
        Gq82sNKCvbOO8EAiO2n4Iw1KV2Vuhs/ozwyL0peQ0gUAGHcCkNXcAk1srGX8HmvwwIWkzw
        KX3p05RZ/kT9Io5j+/U30XTU8csSbnM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-WciWe4BCO6OcDyxRfc3M2Q-1; Mon, 10 Apr 2023 18:22:41 -0400
X-MC-Unique: WciWe4BCO6OcDyxRfc3M2Q-1
Received: by mail-qt1-f199.google.com with SMTP id c6-20020ac87d86000000b003e4df699997so3417412qtd.20
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681165360; x=1683757360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDXK0If8DoXOXvgzcDzv5QZrpGiI3IRCIb/ZVib9NSU=;
        b=tg0mmcJHW5ti2uZ/p4qa5Ye0V2AhCNvz1oyCgfpqFZkrn3AUNVvzyaGamaKnBZiYkW
         S5li83ZLJUogXiyaO2aL5utNEjEzN7iaN0ihi6eu1L3q8YjE3WaDfWhCL8X3Zr1H4UZu
         pvJ8vDfhQOJ0rSYAuQfXqrmW0O1mVzcGMwAKugyNal5ZBq63ObfSWXmRe1BAH4C4AFoe
         6IxdFOeOZTclbGE4aJg3lothQfuoHtY0WxyIBJSikhRqb8SFMvVMhqowt26yS76obave
         Rb+kLztaWrLMb9t1D6nLr0J9U6RzCs6mf6runMmCft/m0ocC1eZFctbaqJjF/YmIJ0Ex
         cZqg==
X-Gm-Message-State: AAQBX9d6e/B3vmrAvGxVeBdumYIN3GlkFqNx6jd9zsfBULEvZpMg+X1b
        ht3KkuRodV86nX2F/DorGX1Xlx7ktLMhePynENFkqNymx5a5ZIcw+CIpvvtdAAaNnM9nxvMeTsc
        JEVf/1B//CrzQGfqYE4VbeXgabvAQxFz1
X-Received: by 2002:a05:6214:29e8:b0:5ee:2789:15f9 with SMTP id jv8-20020a05621429e800b005ee278915f9mr5629146qvb.16.1681165360450;
        Mon, 10 Apr 2023 15:22:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZKBe/Xxd6+hWS2XUwBRlzTQf2O4p88eQP66TzprVc8uBmdDZKkFV9xCDVah3jukpTAcOwnAg==
X-Received: by 2002:a05:6214:29e8:b0:5ee:2789:15f9 with SMTP id jv8-20020a05621429e800b005ee278915f9mr5629127qvb.16.1681165360191;
        Mon, 10 Apr 2023 15:22:40 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g5-20020ad457a5000000b005e927555c96sm2254686qvx.30.2023.04.10.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:22:39 -0700 (PDT)
Date:   Mon, 10 Apr 2023 15:22:38 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Message-ID: <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:11:48PM +0800, Peng Zhang wrote:
> There is softlockup under fio pressure test with smmu enabled:
> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
> ...
> Call trace:
>  fq_flush_timeout+0xc0/0x110
>  call_timer_fn+0x34/0x178
>  expire_timers+0xec/0x158
>  run_timer_softirq+0xc0/0x1f8
>  __do_softirq+0x120/0x324
>  irq_exit+0x11c/0x140
>  __handle_domain_irq+0x6c/0xc0
>  gic_handle_irq+0x6c/0x170
>  el1_irq+0xb8/0x140
>  arch_cpu_idle+0x38/0x1c0
>  default_idle_call+0x24/0x44
>  do_idle+0x1f4/0x2d8
>  cpu_startup_entry+0x2c/0x30
>  secondary_start_kernel+0x17c/0x1c8
> 
> Rcu stall may also be triggered:
> 
> rcu: INFO: rcu_sched self-detected stall on CPU
> NMI backtrace for cpu 21
> CPU: 21 PID: 118 Comm: ksoftirqd/21
> ...
> Call trace:
>  fq_flush_timeout+0x6d/0x90
>  ? fq_ring_free+0xc0/0xc0
>  call_timer_fn+0x2b/0x120
>  run_timer_softirq+0x1a6/0x420
>  ? finish_task_switch+0x80/0x280
>  __do_softirq+0xda/0x2da
>  ? sort_range+0x20/0x20
>  run_ksoftirqd+0x26/0x40
>  smpboot_thread_fn+0xb8/0x150
>  kthread+0x110/0x130
>  ? __kthread_cancel_work+0x40/0x40
>  ret_from_fork+0x1f/0x30
> 
> This is because the timer callback fq_flush_timeout may run more than
> 10ms, and timer may be processed continuously in the softirq so trigger
> softlockup and rcu stall. We can use work to deal with fq_ring_free for
> each cpu which may take long time, that to avoid triggering softlockup
> and rcu stall.
> 
> This patch is modified from the patch[1] of openEuler.
> 

Hi Robin,

I was looking at something similar to this recently were in this case
they were beating the heck out the system with the hazard io stress
test, and someone else with some medusa test tool. In one case they
had them force a dump on the soft lockup. On the 384 core genoa, 90
cores were spinning the iovad rb tree lock for one domain, 1 had it,
and the poor flush queue timer handler was having to fight everyone
for the lock. I'm not sure what would be considered a realistic workload
compared to these stressors, but could this be an issue over time as
systems continue to get more cores since the timer handler potentially
grabs and releases the iova domain rb tree lock for each cpu? The only
cases I know of are using io stressors, so I don't know how big a deal
it is.

I think soft lockups could still be produced with this patch, since
there would still be the lock contention.

Regards,
Jerry

> [1] https://mailweb.openeuler.org/hyperkitty/list/kernel@openeuler.org/message/C3KYS4BXTDMVVBQNEQYNAOGOQWFFINHJ/
> 
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> Reviewed-by: Xie XiuQi <xiexiuqi@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  drivers/iommu/dma-iommu.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..bc4c979d7091 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -59,6 +59,8 @@ struct iommu_dma_cookie {
>  			struct timer_list	fq_timer;
>  			/* 1 when timer is active, 0 when not */
>  			atomic_t		fq_timer_on;
> +			/* The work to free iova */
> +			struct work_struct free_iova_work;
>  		};
>  		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
>  		dma_addr_t		msi_iova;
> @@ -155,20 +157,10 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
>  static void fq_flush_timeout(struct timer_list *t)
>  {
>  	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
> -	int cpu;
>  
>  	atomic_set(&cookie->fq_timer_on, 0);
>  	fq_flush_iotlb(cookie);
> -
> -	for_each_possible_cpu(cpu) {
> -		unsigned long flags;
> -		struct iova_fq *fq;
> -
> -		fq = per_cpu_ptr(cookie->fq, cpu);
> -		spin_lock_irqsave(&fq->lock, flags);
> -		fq_ring_free(cookie, fq);
> -		spin_unlock_irqrestore(&fq->lock, flags);
> -	}
> +	schedule_work(&cookie->free_iova_work);
>  }
>  
>  static void queue_iova(struct iommu_dma_cookie *cookie,
> @@ -227,6 +219,7 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
>  		return;
>  
>  	del_timer_sync(&cookie->fq_timer);
> +	cancel_work_sync(&cookie->free_iova_work);
>  	/* The IOVAs will be torn down separately, so just free our queued pages */
>  	for_each_possible_cpu(cpu) {
>  		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
> @@ -238,6 +231,23 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
>  	free_percpu(cookie->fq);
>  }
>  
> +static void free_iova_work_func(struct work_struct *work)
> +{
> +	struct iommu_dma_cookie *cookie;
> +	int cpu;
> +
> +	cookie = container_of(work, struct iommu_dma_cookie, free_iova_work);
> +	for_each_possible_cpu(cpu) {
> +		unsigned long flags;
> +		struct iova_fq *fq;
> +
> +		fq = per_cpu_ptr(cookie->fq, cpu);
> +		spin_lock_irqsave(&fq->lock, flags);
> +		fq_ring_free(cookie, fq);
> +		spin_unlock_irqrestore(&fq->lock, flags);
> +	}
> +}
> +
>  /* sysfs updates are serialised by the mutex of the group owning @domain */
>  int iommu_dma_init_fq(struct iommu_domain *domain)
>  {
> @@ -271,6 +281,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
>  
>  	cookie->fq = queue;
>  
> +	INIT_WORK(&cookie->free_iova_work, free_iova_work_func);
>  	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
>  	atomic_set(&cookie->fq_timer_on, 0);
>  	/*
> -- 
> 2.20.1
> 

