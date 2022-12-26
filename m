Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF406564A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiLZSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiLZSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:38:36 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30B9BCF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:38:34 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so7002938otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGh9r/jsaAqCGWD2zZzfloJ7Dxl5ALoC+WNsAoZ68QE=;
        b=YZsJ/Wu7AFPAlBVYQOPgdZtWosIzrLAQGlhcflCG2EY4ougLWYFay53fuOXuOFF+Uf
         k5/YnjEKXz8mA+ADDhkA97pZ1ney65rlBPCyulxUjQhtG8nGB312pQoxPfZbZa8wFp5p
         qmHhD2rGafOqIpKInmSXlKp8BVBiiI58KiGUTHr2e6SC4uqt6grugodLPzowZqk8wqCL
         18B6VWuJJLR+TDhl84lf37STtVPu1haz9Qn1c6OH4BGd4RABfnW1HNxIwiizMnHhOdBz
         gPXVVye+lmTgQuks2e4JKdJeFtKPQ2zMvT7zGzZRSPvBD4tmlMO3cez3GiQA6DM6PixG
         I2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGh9r/jsaAqCGWD2zZzfloJ7Dxl5ALoC+WNsAoZ68QE=;
        b=svGYZv7AIO0TpSkv3aq5hLyMD//SItEGS2z5rPS3iCODpgGW/bJIfXJuPMUGpVoRab
         r7NaRmOPlx3cTKufUXjw1uuI3brRuGdIlhfD8w8sQ/0151StytP+o818jz4MnfrV8Xgz
         fqRdWk3ixAze8uNBHJ3HAJOBIHHBzk7jjO57bkc83hL6k4qoQJ0sCpxqoDVASd5wB+d+
         FKwsUdYnTV3mdTlyptM6GfFsqlCabF1AGFva3sgQkGwyqu83TcLmt5gfWr66vTMX/ZG7
         BugZnW5gU2fsxWhpMKNFcNjCykRNFt7p1eQNk24ikRIt4QJwXZAc7UviToBq4Kgk7xTU
         PhyA==
X-Gm-Message-State: AFqh2koB4BFCTN2Nryb0dtFb+D8q0NDObwr/xOs/6tuHuVfjoFSrGvtf
        8GBI/E3y62yQhksE0ssDWortSNkcIRMZgQjFskTa/w==
X-Google-Smtp-Source: AMrXdXt5SjHOi+TWqO0LV+UDUGSbTzxqs+KFHbaCN4ODYEykVdplk0Q24mZQeayTPNtb1D6EbXC1S+xwLm5fcmuv0VA=
X-Received: by 2002:a05:6830:108d:b0:678:202c:1b93 with SMTP id
 y13-20020a056830108d00b00678202c1b93mr1321705oto.160.1672079914091; Mon, 26
 Dec 2022 10:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20221222011529.3471280-1-dhavale@google.com> <Y6PFfEnJE3g98X/e@debian>
In-Reply-To: <Y6PFfEnJE3g98X/e@debian>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 26 Dec 2022 10:38:23 -0800
Message-ID: <CAB=BE-Qh72tB+z9zRxqiC7Jg+RVcip1+vHJXopuzykR08FYiCA@mail.gmail.com>
Subject: Re: [PATCH] EROFS: Replace erofs_unzipd workqueue with per-cpu threads
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

On Wed, Dec 21, 2022 at 6:48 PM Gao Xiang <xiang@kernel.org> wrote:
>
> Hi Sandeen,
>
> On Thu, Dec 22, 2022 at 01:15:29AM +0000, Sandeep Dhavale wrote:
> > Using per-cpu thread pool we can reduce the scheduling latency compared
> > to workqueue implementation. With this patch scheduling latency and
> > variation is reduced as per-cpu threads are SCHED_FIFO kthread_workers.
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
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>
> Thanks for the patch.  Generally, This path looks good to me (compared
> with softirq context.)
>
> With the background at LPC 22, I can see how important such low latency
> requirement is needed for Android upstream and AOSP.  However, could you
> add some link or some brief background to other folks without such
> impression?
>
> > ---
> >  fs/erofs/zdata.c | 84 +++++++++++++++++++++++++++++++++++-------------
> >  fs/erofs/zdata.h |  4 ++-
> >  2 files changed, 64 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index ccf7c55d477f..646667dbe615 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -8,6 +8,7 @@
> >  #include "compress.h"
> >  #include <linux/prefetch.h>
> >  #include <linux/psi.h>
> > +#include <linux/slab.h>
> >
> >  #include <trace/events/erofs.h>
> >
> > @@ -184,26 +185,56 @@ typedef tagptr1_t compressed_page_t;
> >  #define tag_compressed_page_justfound(page) \
> >       tagptr_fold(compressed_page_t, page, 1)
> >
> > -static struct workqueue_struct *z_erofs_workqueue __read_mostly;
> > +static struct kthread_worker **z_erofs_kthread_pool;
> >
> > -void z_erofs_exit_zip_subsystem(void)
> > +static void z_erofs_destroy_kthread_pool(void)
> >  {
> > -     destroy_workqueue(z_erofs_workqueue);
> > -     z_erofs_destroy_pcluster_pool();
> > +     unsigned long cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             if (z_erofs_kthread_pool[cpu]) {
> > +                     kthread_destroy_worker(z_erofs_kthread_pool[cpu]);
> > +                     z_erofs_kthread_pool[cpu] = NULL;
> > +             }
> > +     }
> > +     kfree(z_erofs_kthread_pool);
> >  }
> >
> > -static inline int z_erofs_init_workqueue(void)
> > +static int z_erofs_create_kthread_workers(void)
> >  {
> > -     const unsigned int onlinecpus = num_possible_cpus();
> > +     unsigned long cpu;
> > +     struct kthread_worker *worker;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             worker = kthread_create_worker_on_cpu(cpu, 0, "z_erofs/%ld", cpu);
>
> how about calling them as erofs_worker/%ld, since in the future they
> can also be used for other uses (like verification or decryption).
>
Sure, it makes sense.

> > +             if (IS_ERR(worker)) {
> > +                     z_erofs_destroy_kthread_pool();
> > +                     return -ENOMEM;
> > +             }
> > +             sched_set_fifo(worker->task);
>
> Could we add some kernel configuration option to enable/disable this,
> since I'm not sure if all users need RT threads.
>
Ok, will do.
> > +             z_erofs_kthread_pool[cpu] = worker;
> > +     }
> > +     return 0;
> > +}
> >
> > -     /*
> > -      * no need to spawn too many threads, limiting threads could minimum
> > -      * scheduling overhead, perhaps per-CPU threads should be better?
> > -      */
> > -     z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
> > -                                         WQ_UNBOUND | WQ_HIGHPRI,
> > -                                         onlinecpus + onlinecpus / 4);
> > -     return z_erofs_workqueue ? 0 : -ENOMEM;
> > +static int z_erofs_init_kthread_pool(void)
> > +{
> > +     int err;
> > +
> > +     z_erofs_kthread_pool = kcalloc(num_possible_cpus(),
> > +                     sizeof(struct kthread_worker *), GFP_ATOMIC);
> > +     if (!z_erofs_kthread_pool)
> > +             return -ENOMEM;
> > +     err = z_erofs_create_kthread_workers();
> > +
> > +     return err;
> > +}
> > +
> > +
> > +void z_erofs_exit_zip_subsystem(void)
> > +{
> > +     z_erofs_destroy_kthread_pool();
> > +     z_erofs_destroy_pcluster_pool();
> >  }
> >
> >  int __init z_erofs_init_zip_subsystem(void)
> > @@ -211,10 +242,16 @@ int __init z_erofs_init_zip_subsystem(void)
> >       int err = z_erofs_create_pcluster_pool();
> >
> >       if (err)
> > -             return err;
> > -     err = z_erofs_init_workqueue();
> > +             goto out_error_pcluster_pool;
> > +
> > +     err = z_erofs_init_kthread_pool();
> >       if (err)
> > -             z_erofs_destroy_pcluster_pool();
> > +             goto out_error_kthread_pool;
> > +
> > +     return err;
> > +out_error_kthread_pool:
> > +     z_erofs_destroy_pcluster_pool();
> > +out_error_pcluster_pool:
> >       return err;
> >  }
> >
> > @@ -1143,7 +1180,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
> >       }
> >  }
> >
> > -static void z_erofs_decompressqueue_work(struct work_struct *work)
> > +static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
> >  {
> >       struct z_erofs_decompressqueue *bgq =
> >               container_of(work, struct z_erofs_decompressqueue, u.work);
> > @@ -1170,15 +1207,16 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> >
> >       if (atomic_add_return(bios, &io->pending_bios))
> >               return;
> > -     /* Use workqueue and sync decompression for atomic contexts only */
> > +     /* Use kthread_workers and sync decompression for atomic contexts only */
> >       if (in_atomic() || irqs_disabled()) {
> > -             queue_work(z_erofs_workqueue, &io->u.work);
> > +             kthread_queue_work(z_erofs_kthread_pool[raw_smp_processor_id()],
> > +                            &io->u.work);
>
> Should we need to handle cpu online/offline as well?
>
Ok, let me try to add cpuhp support. I will work on V2.

> Thanks,
> Gao Xiang

Thanks,
Sandeep.
