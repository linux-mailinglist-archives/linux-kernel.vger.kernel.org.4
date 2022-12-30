Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B09653ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiLVCsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiLVCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:48:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98F1AA14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A4D619A2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDCC433EF;
        Thu, 22 Dec 2022 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671677314;
        bh=ioQP7BdKoCQzYScolgYNHmzEqHjWvZA+Dx6rHvT72+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNcz2Z2p5ejNlCmn4IHzA/qP4Bf/7asJUxOYY4W21+MC6W+RuJQ1MowAsx4R6c0yg
         2g2V4Sq30uRvxwm0BFfZgXgwKafzM3YsCcuQ4bkvt5Fr2lwisKj5Eb+rklEgV0X6sz
         h+FnelKcC+3OHll4oi0OjpWOgPTh9FnU1BAdJ2FOWVcmF/MfM04+sVwQ94J2OqyYEt
         0PJtKwpmFKf3QFpm2x7qXDAoYPjyIN/PQOnfF6bmYP5j9MYLhwkaz5iIfypCywaxd2
         ybvKCgUj4eoz5kNtATUHF7VgZ77ma2FroTv7qVxwWnKeaokzU3vVNwceX81viA//v+
         qdlDnF629jRXA==
Date:   Thu, 22 Dec 2022 10:48:28 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        kernel-team@android.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EROFS: Replace erofs_unzipd workqueue with per-cpu
 threads
Message-ID: <Y6PFfEnJE3g98X/e@debian>
Mail-Followup-To: Sandeep Dhavale <dhavale@google.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        kernel-team@android.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20221222011529.3471280-1-dhavale@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222011529.3471280-1-dhavale@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeen,

On Thu, Dec 22, 2022 at 01:15:29AM +0000, Sandeep Dhavale wrote:
> Using per-cpu thread pool we can reduce the scheduling latency compared
> to workqueue implementation. With this patch scheduling latency and
> variation is reduced as per-cpu threads are SCHED_FIFO kthread_workers.
> 
> The results were evaluated on arm64 Android devices running 5.10 kernel.
> 
> The table below shows resulting improvements of total scheduling latency
> for the same app launch benchmark runs with 50 iterations. Scheduling
> latency is the latency between when the task (workqueue kworker vs
> kthread_worker) became eligible to run to when it actually started
> running.
> +-------------------------+-----------+----------------+---------+
> |                         | workqueue | kthread_worker |  diff   |
> +-------------------------+-----------+----------------+---------+
> | Average (us)            |     15253 |           2914 | -80.89% |
> | Median (us)             |     14001 |           2912 | -79.20% |
> | Minimum (us)            |      3117 |           1027 | -67.05% |
> | Maximum (us)            |     30170 |           3805 | -87.39% |
> | Standard deviation (us) |      7166 |            359 |         |
> +-------------------------+-----------+----------------+---------+
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Thanks for the patch.  Generally, This path looks good to me (compared
with softirq context.)

With the background at LPC 22, I can see how important such low latency
requirement is needed for Android upstream and AOSP.  However, could you
add some link or some brief background to other folks without such
impression?

> ---
>  fs/erofs/zdata.c | 84 +++++++++++++++++++++++++++++++++++-------------
>  fs/erofs/zdata.h |  4 ++-
>  2 files changed, 64 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index ccf7c55d477f..646667dbe615 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -8,6 +8,7 @@
>  #include "compress.h"
>  #include <linux/prefetch.h>
>  #include <linux/psi.h>
> +#include <linux/slab.h>
>  
>  #include <trace/events/erofs.h>
>  
> @@ -184,26 +185,56 @@ typedef tagptr1_t compressed_page_t;
>  #define tag_compressed_page_justfound(page) \
>  	tagptr_fold(compressed_page_t, page, 1)
>  
> -static struct workqueue_struct *z_erofs_workqueue __read_mostly;
> +static struct kthread_worker **z_erofs_kthread_pool;
>  
> -void z_erofs_exit_zip_subsystem(void)
> +static void z_erofs_destroy_kthread_pool(void)
>  {
> -	destroy_workqueue(z_erofs_workqueue);
> -	z_erofs_destroy_pcluster_pool();
> +	unsigned long cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (z_erofs_kthread_pool[cpu]) {
> +			kthread_destroy_worker(z_erofs_kthread_pool[cpu]);
> +			z_erofs_kthread_pool[cpu] = NULL;
> +		}
> +	}
> +	kfree(z_erofs_kthread_pool);
>  }
>  
> -static inline int z_erofs_init_workqueue(void)
> +static int z_erofs_create_kthread_workers(void)
>  {
> -	const unsigned int onlinecpus = num_possible_cpus();
> +	unsigned long cpu;
> +	struct kthread_worker *worker;
> +
> +	for_each_possible_cpu(cpu) {
> +		worker = kthread_create_worker_on_cpu(cpu, 0, "z_erofs/%ld", cpu);

how about calling them as erofs_worker/%ld, since in the future they
can also be used for other uses (like verification or decryption).

> +		if (IS_ERR(worker)) {
> +			z_erofs_destroy_kthread_pool();
> +			return -ENOMEM;
> +		}
> +		sched_set_fifo(worker->task);

Could we add some kernel configuration option to enable/disable this,
since I'm not sure if all users need RT threads.

> +		z_erofs_kthread_pool[cpu] = worker;
> +	}
> +	return 0;
> +}
>  
> -	/*
> -	 * no need to spawn too many threads, limiting threads could minimum
> -	 * scheduling overhead, perhaps per-CPU threads should be better?
> -	 */
> -	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
> -					    WQ_UNBOUND | WQ_HIGHPRI,
> -					    onlinecpus + onlinecpus / 4);
> -	return z_erofs_workqueue ? 0 : -ENOMEM;
> +static int z_erofs_init_kthread_pool(void)
> +{
> +	int err;
> +
> +	z_erofs_kthread_pool = kcalloc(num_possible_cpus(),
> +			sizeof(struct kthread_worker *), GFP_ATOMIC);
> +	if (!z_erofs_kthread_pool)
> +		return -ENOMEM;
> +	err = z_erofs_create_kthread_workers();
> +
> +	return err;
> +}
> +
> +
> +void z_erofs_exit_zip_subsystem(void)
> +{
> +	z_erofs_destroy_kthread_pool();
> +	z_erofs_destroy_pcluster_pool();
>  }
>  
>  int __init z_erofs_init_zip_subsystem(void)
> @@ -211,10 +242,16 @@ int __init z_erofs_init_zip_subsystem(void)
>  	int err = z_erofs_create_pcluster_pool();
>  
>  	if (err)
> -		return err;
> -	err = z_erofs_init_workqueue();
> +		goto out_error_pcluster_pool;
> +
> +	err = z_erofs_init_kthread_pool();
>  	if (err)
> -		z_erofs_destroy_pcluster_pool();
> +		goto out_error_kthread_pool;
> +
> +	return err;
> +out_error_kthread_pool:
> +	z_erofs_destroy_pcluster_pool();
> +out_error_pcluster_pool:
>  	return err;
>  }
>  
> @@ -1143,7 +1180,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>  	}
>  }
>  
> -static void z_erofs_decompressqueue_work(struct work_struct *work)
> +static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
>  {
>  	struct z_erofs_decompressqueue *bgq =
>  		container_of(work, struct z_erofs_decompressqueue, u.work);
> @@ -1170,15 +1207,16 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>  
>  	if (atomic_add_return(bios, &io->pending_bios))
>  		return;
> -	/* Use workqueue and sync decompression for atomic contexts only */
> +	/* Use kthread_workers and sync decompression for atomic contexts only */
>  	if (in_atomic() || irqs_disabled()) {
> -		queue_work(z_erofs_workqueue, &io->u.work);
> +		kthread_queue_work(z_erofs_kthread_pool[raw_smp_processor_id()],
> +			       &io->u.work);

Should we need to handle cpu online/offline as well?

Thanks,
Gao Xiang
