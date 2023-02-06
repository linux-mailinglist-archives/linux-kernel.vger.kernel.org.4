Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987F68C6F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBFTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:41:28 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE012861
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:41:26 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15fe106c7c7so16439946fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2Bf4wq4/zezzG9BG6Kf75W2e7iATbvMxix763S9Fn0=;
        b=ZbF8DX672sF14r5R40d3H97rrkRBKJx+JUOTwokElxvwXwmn0YV6lQWPHWNTxndrWR
         9rcs28o2zt/9eP19WccT8QLzkGRF42mfFMTRwBrDrY/LNHAvsKUTGps2lkcwvmOHr7uY
         Si+VtV/THD8e//BDMSue0UK5sRWDH6TSD+fv7g3iOvez0KwevvGUnTtdNs9VOVQLoW/V
         qF3hbkI6ChIqb2MHGYAosxJnhmzvfa9C15lUeQ7+ihZ8pXJkWwwR9jh9JMpCdSzMKWYc
         QyBKBG4xrSMIb8bmKM+luKAdr5+sNDmqgNx1GWpmnNPUrNbM7arBVAQR7OikfvAWqvCz
         HREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2Bf4wq4/zezzG9BG6Kf75W2e7iATbvMxix763S9Fn0=;
        b=170Kz6fwubchqTKpzpmRNQb5hjp+H6vRSv3jA1zOS+GRJuyyytY8H6Rf6BeLWs5Shn
         /E+atvGFgep3kKKDGu7eKWRzEFYRsZILRCEm+FcqAZbtqYt9ffLS9vfwfbD2P2yFDbZ1
         CqJvy9+ZkG95FBELzoJQvAuD9sYUo/93mmgluAXDwqrw/KBJkFYej0186uu7nC8sIp9J
         3IaplvHAkMgYXl+kgsIcEXefYq7HeniOGoNLT4QXpAtQF0zYATRDN7S/Pd9WSmZjJPbL
         yMA7yl0MXkYsQZE+ZCrQTph8UH3OsDOr5wlbA+zSqGraYx/GXsOlhIdJLA54fwvntout
         uMbg==
X-Gm-Message-State: AO0yUKU+jObvOD75jioA0Fltpy96dIwwGV4G8lomyVtStlVbo8vPHRZP
        xw37mJLsAbia0ycJTM2V4PEaaqEOQiWwL+aOMGzfHw==
X-Google-Smtp-Source: AK7set+xGzfaT6JBfXxIXxKhWJrSVs7CUCLAiWUooh/C9etB0EQhN1QGt6ECF9lIlVLucumzM6zfTWmTeYUPPwTgFXg=
X-Received: by 2002:a05:6870:e0d3:b0:163:2f91:53b2 with SMTP id
 a19-20020a056870e0d300b001632f9153b2mr1410373oab.228.1675712485638; Mon, 06
 Feb 2023 11:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20230106073502.4017276-1-dhavale@google.com> <Y+DP6V9fZG7XPPGy@debian>
In-Reply-To: <Y+DP6V9fZG7XPPGy@debian>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 6 Feb 2023 11:41:14 -0800
Message-ID: <CAB=BE-Ttt6mO6x+xNv+VSWnoRgzXd_VyQuYiuz55uR3zqxWMFA@mail.gmail.com>
Subject: Re: [PATCH v4] erofs: replace erofs_unzipd workqueue with per-cpu threads
To:     Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        kernel-team@android.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 2:01 AM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Sandeep,
>
> On Fri, Jan 06, 2023 at 07:35:01AM +0000, Sandeep Dhavale wrote:
> > Using per-cpu thread pool we can reduce the scheduling latency compared
> > to workqueue implementation. With this patch scheduling latency and
> > variation is reduced as per-cpu threads are high priority kthread_workers.
> >
> > The results were evaluated on arm64 Android devices running 5.10 kernel.
> >
> > The table below shows resulting improvements of total scheduling latency
> > for the same app launch benchmark runs with 50 iterations. Scheduling
> > latency is the latency between when the task (workqueue kworker vs
> > kthread_worker) became eligible to run to when it actually started
> > running.
> > +-------------------------+-----------+----------------+---------+
> > |                         | workqueue | kthread_worker |  diff   |
> > +-------------------------+-----------+----------------+---------+
> > | Average (us)            |     15253 |           2914 | -80.89% |
> > | Median (us)             |     14001 |           2912 | -79.20% |
> > | Minimum (us)            |      3117 |           1027 | -67.05% |
> > | Maximum (us)            |     30170 |           3805 | -87.39% |
> > | Standard deviation (us) |      7166 |            359 |         |
> > +-------------------------+-----------+----------------+---------+
> >
> > Background: Boot times and cold app launch benchmarks are very
> > important to the android ecosystem as they directly translate to
> > responsiveness from user point of view. While erofs provides
> > a lot of important features like space savings, we saw some
> > performance penalty in cold app launch benchmarks in few scenarios.
> > Analysis showed that the significant variance was coming from the
> > scheduling cost while decompression cost was more or less the same.
> >
> > Having per-cpu thread pool we can see from the above table that this
> > variation is reduced by ~80% on average. This problem was discussed
> > at LPC 2022. Link to LPC 2022 slides and
> > talk at [1]
> >
> > [1] https://lpc.events/event/16/contributions/1338/
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> > ---
> > V3 -> V4
> > * Updated commit message with background information
> > V2 -> V3
> > * Fix a warning Reported-by: kernel test robot <lkp@intel.com>
> > V1 -> V2
> > * Changed name of kthread_workers from z_erofs to erofs_worker
> > * Added kernel configuration to run kthread_workers at normal or
> >   high priority
> > * Added cpu hotplug support
> > * Added wrapped kthread_workers under worker_pool
> > * Added one unbound thread in a pool to handle a context where
> >   we already stopped per-cpu kthread worker
> > * Updated commit message
>
> I've just modified your v4 patch based on erofs -dev branch with
> my previous suggestion [1], but I haven't tested it.
>
> Could you help check if the updated patch looks good to you and
> test it on your side?  If there are unexpected behaviors, please
> help update as well, thanks!
Thanks Xiang, I was working on the same. I see that you have cleaned it up.
I will test it and report/fix any problems.

Thanks,
Sandeep.

>
> [1] https://lore.kernel.org/r/5e1b7191-9ea6-3781-7928-72ac4cd88591@linux.alibaba.com/
>
> Thanks,
> Gao Xiang
>
> From 2e87235abc745c0fef8e32abcd3a51546b4378ad Mon Sep 17 00:00:00 2001
> From: Sandeep Dhavale <dhavale@google.com>
> Date: Mon, 6 Feb 2023 17:53:39 +0800
> Subject: [PATCH] erofs: add per-cpu threads for decompression
>
> Using per-cpu thread pool we can reduce the scheduling latency compared
> to workqueue implementation. With this patch scheduling latency and
> variation is reduced as per-cpu threads are high priority kthread_workers.
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
> Background: Boot times and cold app launch benchmarks are very
> important to the android ecosystem as they directly translate to
> responsiveness from user point of view. While erofs provides
> a lot of important features like space savings, we saw some
> performance penalty in cold app launch benchmarks in few scenarios.
> Analysis showed that the significant variance was coming from the
> scheduling cost while decompression cost was more or less the same.
>
> Having per-cpu thread pool we can see from the above table that this
> variation is reduced by ~80% on average. This problem was discussed
> at LPC 2022. Link to LPC 2022 slides and
> talk at [1]
>
> [1] https://lpc.events/event/16/contributions/1338/
>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/Kconfig |  18 +++++
>  fs/erofs/zdata.c | 190 ++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 189 insertions(+), 19 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 85490370e0ca..704fb59577e0 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -108,3 +108,21 @@ config EROFS_FS_ONDEMAND
>           read support.
>
>           If unsure, say N.
> +
> +config EROFS_FS_PCPU_KTHREAD
> +       bool "EROFS per-cpu decompression kthread workers"
> +       depends on EROFS_FS_ZIP
> +       help
> +         Saying Y here enables per-CPU kthread workers pool to carry out
> +         async decompression for low latencies on some architectures.
> +
> +         If unsure, say N.
> +
> +config EROFS_FS_PCPU_KTHREAD_HIPRI
> +       bool "EROFS high priority per-CPU kthread workers"
> +       depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> +       help
> +         This permits EROFS to configure per-CPU kthread workers to run
> +         at higher priority.
> +
> +         If unsure, say N.
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 384f64292f73..73198f494a6a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -7,6 +7,8 @@
>  #include "compress.h"
>  #include <linux/prefetch.h>
>  #include <linux/psi.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
>
>  #include <trace/events/erofs.h>
>
> @@ -109,6 +111,7 @@ struct z_erofs_decompressqueue {
>         union {
>                 struct completion done;
>                 struct work_struct work;
> +               struct kthread_work kthread_work;
>         } u;
>         bool eio, sync;
>  };
> @@ -341,24 +344,128 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
>
>  static struct workqueue_struct *z_erofs_workqueue __read_mostly;
>
> -void z_erofs_exit_zip_subsystem(void)
> +#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> +static struct kthread_worker __rcu **z_erofs_pcpu_workers;
> +
> +static void erofs_destroy_percpu_workers(void)
>  {
> -       destroy_workqueue(z_erofs_workqueue);
> -       z_erofs_destroy_pcluster_pool();
> +       struct kthread_worker *worker;
> +       unsigned int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               worker = rcu_dereference_protected(
> +                                       z_erofs_pcpu_workers[cpu], 1);
> +               rcu_assign_pointer(z_erofs_pcpu_workers[cpu], NULL);
> +               if (worker)
> +                       kthread_destroy_worker(worker);
> +       }
> +       kfree(z_erofs_pcpu_workers);
>  }
>
> -static inline int z_erofs_init_workqueue(void)
> +static struct kthread_worker *erofs_init_percpu_worker(int cpu)
>  {
> -       const unsigned int onlinecpus = num_possible_cpus();
> +       struct kthread_worker *worker =
> +               kthread_create_worker_on_cpu(cpu, 0, "erofs_worker/%u", cpu);
>
> -       /*
> -        * no need to spawn too many threads, limiting threads could minimum
> -        * scheduling overhead, perhaps per-CPU threads should be better?
> -        */
> -       z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
> -                                           WQ_UNBOUND | WQ_HIGHPRI,
> -                                           onlinecpus + onlinecpus / 4);
> -       return z_erofs_workqueue ? 0 : -ENOMEM;
> +       if (IS_ERR(worker))
> +               return worker;
> +       if (IS_ENABLED(CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI))
> +               sched_set_fifo_low(worker->task);
> +       else
> +               sched_set_normal(worker->task, 0);
> +       return worker;
> +}
> +
> +static int erofs_init_percpu_workers(void)
> +{
> +       struct kthread_worker *worker;
> +       unsigned int cpu;
> +
> +       z_erofs_pcpu_workers = kcalloc(num_possible_cpus(),
> +                       sizeof(struct kthread_worker *), GFP_ATOMIC);
> +       if (!z_erofs_pcpu_workers)
> +               return -ENOMEM;
> +
> +       for_each_online_cpu(cpu) {      /* could miss cpu{off,on}line? */
> +               worker = erofs_init_percpu_worker(cpu);
> +               if (!IS_ERR(worker))
> +                       rcu_assign_pointer(z_erofs_pcpu_workers[cpu], worker);
> +       }
> +       return 0;
> +}
> +#else
> +static inline void erofs_destroy_percpu_workers(void) {}
> +static inline int erofs_init_percpu_workers(void) { return 0; }
> +#endif
> +
> +#if defined(CONFIG_HOTPLUG_CPU) && defined(EROFS_FS_PCPU_KTHREAD)
> +static DEFINE_SPINLOCK(z_erofs_pcpu_worker_lock);
> +static enum cpuhp_state erofs_cpuhp_state;
> +
> +static int erofs_cpu_online(unsigned int cpu)
> +{
> +       struct kthread_worker *worker, *old;
> +
> +       worker = erofs_init_percpu_worker(cpu);
> +       if (IS_ERR(worker))
> +               return ERR_PTR(worker);
> +
> +       spin_lock(&z_erofs_pcpu_worker_lock);
> +       old = rcu_dereference_protected(z_erofs_pcpu_workers[cpu],
> +                       lockdep_is_held(&z_erofs_pcpu_worker_lock));
> +       if (!old)
> +               rcu_assign_pointer(z_erofs_pcpu_workers[cpu], worker);
> +       spin_unlock(&z_erofs_pcpu_worker_lock);
> +       if (old)
> +               kthread_destroy_worker(worker);
> +       return 0;
> +}
> +
> +static int erofs_cpu_offline(unsigned int cpu)
> +{
> +       struct kthread_worker *worker;
> +
> +       spin_lock(&z_erofs_pcpu_worker_lock);
> +       worker = rcu_dereference_protected(z_erofs_pcpu_workers[cpu],
> +                       lockdep_is_held(&z_erofs_pcpu_worker_lock));
> +       rcu_assign_pointer(worker_pool.workers[cpu], NULL);
> +       spin_unlock(&z_erofs_pcpu_worker_lock);
> +
> +       synchronize_rcu();
> +       if (worker)
> +               kthread_destroy_worker(worker);
> +       return 0;
> +}
> +
> +static int erofs_cpu_hotplug_init(void)
> +{
> +       int state;
> +
> +       state = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +                       "fs/erofs:online", erofs_cpu_online, erofs_cpu_offline);
> +       if (state < 0)
> +               return state;
> +
> +       erofs_cpuhp_state = state;
> +       return 0;
> +}
> +
> +static void erofs_cpu_hotplug_destroy(void)
> +{
> +       if (erofs_cpuhp_state)
> +               cpuhp_remove_state_nocalls(erofs_cpuhp_state);
> +}
> +#else /* !CONFIG_HOTPLUG_CPU || !CONFIG_EROFS_FS_PCPU_KTHREAD */
> +static inline int erofs_cpu_hotplug_init(void) { return 0; }
> +static inline void erofs_cpu_hotplug_destroy(void) {}
> +#endif
> +
> +void z_erofs_exit_zip_subsystem(void)
> +{
> +       erofs_cpu_hotplug_destroy();
> +       erofs_destroy_percpu_workers();
> +       destroy_workqueue(z_erofs_workqueue);
> +       z_erofs_destroy_pcluster_pool();
>  }
>
>  int __init z_erofs_init_zip_subsystem(void)
> @@ -366,10 +473,29 @@ int __init z_erofs_init_zip_subsystem(void)
>         int err = z_erofs_create_pcluster_pool();
>
>         if (err)
> -               return err;
> -       err = z_erofs_init_workqueue();
> +               goto out_error_pcluster_pool;
> +
> +       z_erofs_workqueue = alloc_workqueue("erofs_worker",
> +                       WQ_UNBOUND | WQ_HIGHPRI, num_possible_cpus());
> +       if (!z_erofs_workqueue)
> +               goto out_error_workqueue_init;
> +
> +       err = erofs_init_percpu_workers();
>         if (err)
> -               z_erofs_destroy_pcluster_pool();
> +               goto out_error_pcpu_worker;
> +
> +       err = erofs_cpu_hotplug_init();
> +       if (err < 0)
> +               goto out_error_cpuhp_init;
> +       return err;
> +
> +out_error_cpuhp_init:
> +       erofs_destroy_percpu_workers();
> +out_error_pcpu_worker:
> +       destroy_workqueue(z_erofs_workqueue);
> +out_error_workqueue_init:
> +       z_erofs_destroy_pcluster_pool();
> +out_error_pcluster_pool:
>         return err;
>  }
>
> @@ -1305,11 +1431,17 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
>
>         DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
>         z_erofs_decompress_queue(bgq, &pagepool);
> -
>         erofs_release_pages(&pagepool);
>         kvfree(bgq);
>  }
>
> +#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> +static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
> +{
> +       z_erofs_decompressqueue_work((struct work_struct *)work);
> +}
> +#endif
> +
>  static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>                                        int bios)
>  {
> @@ -1324,9 +1456,24 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>
>         if (atomic_add_return(bios, &io->pending_bios))
>                 return;
> -       /* Use workqueue and sync decompression for atomic contexts only */
> +       /* Use (kthread_)work and sync decompression for atomic contexts only */
>         if (in_atomic() || irqs_disabled()) {
> +#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> +               struct kthread_worker *worker;
> +
> +               rcu_read_lock();
> +               worker = rcu_dereference(
> +                               z_erofs_pcpu_workers[raw_smp_processor_id()]);
> +               if (!worker) {
> +                       INIT_WORK(&io->u.work, z_erofs_decompressqueue_work);
> +                       queue_work(z_erofs_workqueue, &io->u.work);
> +               } else {
> +                       kthread_queue_work(worker, &io->u.kthread_work);
> +               }
> +               rcu_read_unlock();
> +#else
>                 queue_work(z_erofs_workqueue, &io->u.work);
> +#endif
>                 /* enable sync decompression for readahead */
>                 if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
>                         sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
> @@ -1455,7 +1602,12 @@ static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
>                         *fg = true;
>                         goto fg_out;
>                 }
> +#ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> +               kthread_init_work(&q->u.kthread_work,
> +                                 z_erofs_decompressqueue_kthread_work);
> +#else
>                 INIT_WORK(&q->u.work, z_erofs_decompressqueue_work);
> +#endif
>         } else {
>  fg_out:
>                 q = fgq;
> @@ -1640,7 +1792,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>
>         /*
>          * although background is preferred, no one is pending for submission.
> -        * don't issue workqueue for decompression but drop it directly instead.
> +        * don't issue decompression but drop it directly instead.
>          */
>         if (!*force_fg && !nr_bios) {
>                 kvfree(q[JQ_SUBMIT]);
> --
> 2.30.2
>
