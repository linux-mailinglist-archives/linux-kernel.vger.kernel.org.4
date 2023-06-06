Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF0724A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjFFRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbjFFRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BFE47;
        Tue,  6 Jun 2023 10:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D17160E17;
        Tue,  6 Jun 2023 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0887C4339C;
        Tue,  6 Jun 2023 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072864;
        bh=Ken7Lthmq4vWaJHWOL6NFlhsA8XHBKQDa4bMq2P6Ujw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LOnIvVpDU1R/BopIXlmyljxx2H366piqfK/hMefLlVeRkYUMHvCLdTNDYjZHBz/Ov
         l8O534AfZydQNlQ8TkOvVE6C2J8nwI+BArZRNXt03lZyOH7dQUJ3PSpkUWNNYiHbgY
         iqqGFpiXBeH81yXOCu/7hwYIEPI2qv7tdsu3lp2tC0pNZZ9wXkuj5cxlny9k6jenv3
         UALj9o83XHmMLXbdgR4V5dup48sH1jRP9vVXtoSpCqG3XH/vw8BAm5yArY6sX+qYzi
         RGwk9zXn1qISTh2dqDN6Li6vFoJ9HH/h9h4RSeuJC5sIaXHMyobYFdQQjy288S0tPC
         PnW4l6b7H4IkA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2af2db78b38so78753131fa.3;
        Tue, 06 Jun 2023 10:34:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDxSWYufLy9BrQMqomIm32TKJCUrsw1d3/o6E6Zum+AsHtH2aPS4
        1RyK3d+2i+5/qy76Pm7w+HVUjWV6K0oE5sNWHbM=
X-Google-Smtp-Source: ACHHUZ6pvM5ddbQPhePepzi5ETYI0YwDkrGxLERjaOsq6gx2nEmUufcJWB8/MAUJep+ck7UhJQqq7fseV7Egq67m7SU=
X-Received: by 2002:a2e:9cd1:0:b0:2b1:eca3:4e8d with SMTP id
 g17-20020a2e9cd1000000b002b1eca34e8dmr1575420ljj.12.1686072862594; Tue, 06
 Jun 2023 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com> <20230529131106.2123367-6-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-6-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Jun 2023 10:34:10 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7tK2waJdJ9NbfEPkL448xZx_ssr7d34Ug7uGfXa8MVNg@mail.gmail.com>
Message-ID: <CAPhsuW7tK2waJdJ9NbfEPkL448xZx_ssr7d34Ug7uGfXa8MVNg@mail.gmail.com>
Subject: Re: [PATCH -next v3 5/7] md/md-bitmap: add a new helper to unplug
 bitmap asynchrously
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 6:14=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> If bitmap is enabled, bitmap must update before submitting write io, this
> is why unplug callback must move these io to 'conf->pending_io_list' if
> 'current->bio_list' is not empty, which will suffer performance
> degradation.
>
> A new helper md_bitmap_unplug_async() is introduced to submit bitmap io
> in a kworker, so that submit bitmap io in raid10_unplug() doesn't require
> that 'current->bio_list' is empty.
>
> This patch prepare to limit the number of plugged bio.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c | 29 +++++++++++++++++++++++++++++
>  drivers/md/md-bitmap.h |  1 +
>  drivers/md/md.c        |  9 +++++++++
>  drivers/md/md.h        |  1 +
>  4 files changed, 40 insertions(+)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 3ee590cf12a7..25cd72b317f1 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1054,6 +1054,35 @@ void md_bitmap_unplug(struct bitmap *bitmap)
>  }
>  EXPORT_SYMBOL(md_bitmap_unplug);
>
> +struct bitmap_unplug_work {
> +       struct work_struct work;
> +       struct bitmap *bitmap;
> +       struct completion *done;
> +};
> +
> +static void md_bitmap_unplug_fn(struct work_struct *work)
> +{
> +       struct bitmap_unplug_work *unplug_work =3D
> +               container_of(work, struct bitmap_unplug_work, work);
> +
> +       md_bitmap_unplug(unplug_work->bitmap);
> +       complete(unplug_work->done);
> +}
> +
> +void md_bitmap_unplug_async(struct bitmap *bitmap)
> +{
> +       DECLARE_COMPLETION_ONSTACK(done);
> +       struct bitmap_unplug_work unplug_work;
> +
> +       INIT_WORK(&unplug_work.work, md_bitmap_unplug_fn);
> +       unplug_work.bitmap =3D bitmap;
> +       unplug_work.done =3D &done;
> +
> +       queue_work(md_bitmap_wq, &unplug_work.work);
> +       wait_for_completion(&done);
> +}
> +EXPORT_SYMBOL(md_bitmap_unplug_async);

I updated the patch with:

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 25cd72b317f1..1ff712889a3b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1074,7 +1074,7 @@ void md_bitmap_unplug_async(struct bitmap *bitmap)
        DECLARE_COMPLETION_ONSTACK(done);
        struct bitmap_unplug_work unplug_work;

-       INIT_WORK(&unplug_work.work, md_bitmap_unplug_fn);
+       INIT_WORK_ONSTACK(&unplug_work.work, md_bitmap_unplug_fn);
        unplug_work.bitmap =3D bitmap;
        unplug_work.done =3D &done;

Otherwise, we will get the following warning with mdadm test
05r1-add-internalbitmap.

Thanks,
Song



[  135.072374] ODEBUG: object ffffc90005adf500 is on stack
ffffc90005ad8000, but NOT annotated.
[  135.074994] ------------[ cut here ]------------
[  135.075770] WARNING: CPU: 1 PID: 1115 at lib/debugobjects.c:548
lookup_object_or_alloc+0x294/0x560
[  135.077085] Modules linked in:
[  135.077571] CPU: 1 PID: 1115 Comm: mkfs.ext3 Not tainted 6.4.0-rc2+ #737
[  135.078542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[  135.080398] RIP: 0010:lookup_object_or_alloc+0x294/0x560
[  135.081165] Code: 2d b1 24 15 09 65 48 8b 2c 25 80 9e 1f 00 48 8d
7d 20 e8 7f 19 a9 ff 48 8b 55 20 48 89 de 48 c7 c7 00 f2 05 83 e8 5c
97 70 ff <0f> 0b 48 83 c4 58 4c 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3
cc cc
[  135.083830] RSP: 0018:ffffc90005adf398 EFLAGS: 00010082
[  135.084568] RAX: 0000000000000050 RBX: ffffc90005adf500 RCX: 00000000000=
00000
[  135.085582] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffff8a7=
dea40
[  135.086687] RBP: 0000000000000001 R08: fffff52000b5be3d R09: fffff52000b=
5be3d
[  135.087684] R10: ffffc90005adf1e7 R11: fffff52000b5be3c R12: ffff888103e=
e0040
[  135.088725] R13: ffff888103ee0060 R14: ffff888df71f7c40 R15: ffff88815eb=
90060
[  135.089780] FS:  00007fa1f1c85780(0000) GS:ffff888df7000000(0000)
knlGS:0000000000000000
[  135.090920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.091751] CR2: 000055add4915f44 CR3: 000000011227a002 CR4: 00000000003=
70ee0
[  135.092775] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  135.093812] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  135.094838] Call Trace:
[  135.095178]  <TASK>
[  135.095528]  ? _raw_spin_lock_irqsave+0x6d/0x90
[  135.096197]  __debug_object_init+0x63/0x130
[  135.096853]  md_bitmap_unplug_async+0x9c/0x180
[  135.097512]  ? __pfx_md_bitmap_unplug_async+0x10/0x10
[  135.098267]  ? bio_associate_blkg_from_css+0x446/0xb10
[  135.099043]  ? update_io_ticks+0xad/0x180
[  135.099636]  ? __pfx_update_io_ticks+0x10/0x10
[  135.100355]  flush_bio_list+0x60/0x1c0
[  135.100922]  raid1_unplug+0x64/0x120
[  135.101460]  raid1_make_request+0xfd7/0x1e10
[  135.102125]  ? __pfx_raid1_make_request+0x10/0x10
[  135.102806]  ? lock_release+0x27a/0x690
[  135.103368]  ? __pfx_lock_release+0x10/0x10
[  135.103963]  ? md_handle_request+0x2b3/0x7c0
[  135.104570]  ? __pfx_rcu_read_lock_held+0x10/0x10
[  135.105232]  ? md_handle_request+0x2b3/0x7c0
[  135.105886]  md_handle_request+0x365/0x7c0
[  135.106492]  ? __pfx_md_handle_request+0x10/0x10
[  135.107177]  __submit_bio+0x1dc/0x5d0
[  135.107770]  submit_bio_noacct_nocheck+0x2c2/0x5b0
[  135.108457]  ? lock_is_held_type+0xd8/0x130
[  135.109076]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  135.109872]  ? submit_bio_noacct+0x283/0x750
[  135.110533]  __block_write_full_page+0x45f/0xbb0
[  135.111200]  ? __pfx_blkdev_get_block+0x10/0x10
[  135.111901]  ? __pfx_end_buffer_async_write+0x10/0x10
[  135.112741]  writepage_cb+0x3e/0xc0
[  135.113285]  write_cache_pages+0x2d8/0x730
[  135.113906]  ? __pfx_writepage_cb+0x10/0x10
[  135.114531]  ? __pfx_write_cache_pages+0x10/0x10
[  135.115196]  ? lock_release+0x27a/0x690
[  135.115819]  do_writepages+0x190/0x310
[  135.116370]  ? __pfx_do_writepages+0x10/0x10
[  135.116995]  ? preempt_count_sub+0x14/0xc0
[  135.117596]  ? _raw_spin_unlock+0x29/0x50
[  135.118171]  ? wbc_attach_and_unlock_inode+0x216/0x410
[  135.118934]  filemap_fdatawrite_wbc+0x93/0xc0
[  135.119574]  __filemap_fdatawrite_range+0x99/0xd0
[  135.120246]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[  135.121055]  ? ktime_get_coarse_real_ts64+0xec/0x100
[  135.121789]  file_write_and_wait_range+0x67/0xd0
[  135.122578]  blkdev_fsync+0x35/0x60
[  135.123095]  do_fsync+0x38/0x70
[  135.123587]  ? syscall_trace_enter.isra.15+0x15c/0x1f0
[  135.124318]  __x64_sys_fsync+0x1d/0x30
[  135.124924]  do_syscall_64+0x3a/0x90
[  135.125481]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  135.126197] RIP: 0033:0x7fa1efef4478
[  135.126765] Code: 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
00 90 f3 0f 1e fa 48 8d 05 25 01 2d 00 8b 00 85 c0 75 17 b8 4a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 40 c3 0f 1f 80 00 00 00 00 53 89 fb 48
83 ec
[  135.129424] RSP: 002b:00007fffb2176318 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[  135.130498] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa1efe=
f4478
[  135.131493] RDX: 0000000000000400 RSI: 0000559e026969e0 RDI: 00000000000=
00003
[  135.132491] RBP: 0000559e026950d0 R08: 0000559e026969e0 R09: 00007fa1eff=
80620
[  135.133496] R10: 0000000000800800 R11: 0000000000000246 R12: 00007fffb21=
76390
[  135.134491] R13: 00007fffb2176398 R14: 0000559e02698e70 R15: 0000559e026=
944f0
[  135.135515]  </TASK>
[  135.135843] irq event stamp: 141152
[  135.136349] hardirqs last  enabled at (141151):
[<ffffffff827778e0>] _raw_spin_unlock_irqrestore+0x30/0x60
[  135.137721] hardirqs last disabled at (141152):
[<ffffffff827775cd>] _raw_spin_lock_irqsave+0x6d/0x90
[  135.139031] softirqs last  enabled at (139890):
[<ffffffff827793fb>] __do_softirq+0x3eb/0x531
[  135.140249] softirqs last disabled at (139885):
[<ffffffff810d8f45>] irq_exit_rcu+0x115/0x160
[  135.141503] ---[ end trace 0000000000000000 ]---




> +
>  static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t of=
fset, int needed);
>  /* * bitmap_init_from_disk -- called at bitmap_create time to initialize
>   * the in-memory bitmap from the on-disk bitmap -- also, sets up the
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index 3a4750952b3a..8a3788c9bfef 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -264,6 +264,7 @@ void md_bitmap_sync_with_cluster(struct mddev *mddev,
>                                  sector_t new_lo, sector_t new_hi);
>
>  void md_bitmap_unplug(struct bitmap *bitmap);
> +void md_bitmap_unplug_async(struct bitmap *bitmap);
>  void md_bitmap_daemon_work(struct mddev *mddev);
>
>  int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e592f37a1071..a5a7af2f4e59 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -83,6 +83,7 @@ static struct module *md_cluster_mod;
>  static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
>  static struct workqueue_struct *md_wq;
>  static struct workqueue_struct *md_misc_wq;
> +struct workqueue_struct *md_bitmap_wq;
>
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this);
> @@ -9636,6 +9637,11 @@ static int __init md_init(void)
>         if (!md_misc_wq)
>                 goto err_misc_wq;
>
> +       md_bitmap_wq =3D alloc_workqueue("md_bitmap", WQ_MEM_RECLAIM | WQ=
_UNBOUND,
> +                                      0);
> +       if (!md_bitmap_wq)
> +               goto err_bitmap_wq;
> +
>         ret =3D __register_blkdev(MD_MAJOR, "md", md_probe);
>         if (ret < 0)
>                 goto err_md;
> @@ -9654,6 +9660,8 @@ static int __init md_init(void)
>  err_mdp:
>         unregister_blkdev(MD_MAJOR, "md");
>  err_md:
> +       destroy_workqueue(md_bitmap_wq);
> +err_bitmap_wq:
>         destroy_workqueue(md_misc_wq);
>  err_misc_wq:
>         destroy_workqueue(md_wq);
> @@ -9950,6 +9958,7 @@ static __exit void md_exit(void)
>         spin_unlock(&all_mddevs_lock);
>
>         destroy_workqueue(md_misc_wq);
> +       destroy_workqueue(md_bitmap_wq);
>         destroy_workqueue(md_wq);
>  }
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index a50122165fa1..bfd2306bc750 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -852,6 +852,7 @@ struct mdu_array_info_s;
>  struct mdu_disk_info_s;
>
>  extern int mdp_major;
> +extern struct workqueue_struct *md_bitmap_wq;
>  void md_autostart_arrays(int part);
>  int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info=
);
>  int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info);
> --
> 2.39.2
>
