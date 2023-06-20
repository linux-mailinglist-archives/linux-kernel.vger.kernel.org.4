Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1908736656
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjFTIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFTIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451DDD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687250128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXYQs/uNz0dnlzmDz8XfAWv7rf/hCek5/Y0d/udpozM=;
        b=F4PGgGX3VcfLAioyBaidSJStvYdKVcoOonqXgGVrDegwHqjoaNBXpGyLWoQGN8QNstLjRW
        DsGD3eT1qmfjaXd8ssnaKwbfKJwvjqtD63+Fs3IJF6WvtZIn5YDpwNuMXchXaoKDddyzgV
        NgGtHIfpc4uogyJ86wSG5c7I7lNggqI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-AgigK15POI6yla2K0daHiA-1; Tue, 20 Jun 2023 04:35:26 -0400
X-MC-Unique: AgigK15POI6yla2K0daHiA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-25ea9bc1705so3567575a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687250126; x=1689842126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXYQs/uNz0dnlzmDz8XfAWv7rf/hCek5/Y0d/udpozM=;
        b=kch9Zj0kzOrHXZDb8HqSgyKmmXJYX/p0gxOFw5X4D2TwIhza0l+lbIiAPpcKjBBdgJ
         v57KYqgGbLbDrAJP+ShP6B/Zh14uL6X/jByhy0iwMU+PXVP9EU2Nksfrc5rJnKkGSm1W
         RbHEaeJA4nu7xp/f2li2DAYF/w62PxHi+lOLmcGyjKmT9y1nAzo44CeK0zl+aQxGP5rb
         gYV5zwKxGujWblVo86391hWLJaxLZe+S+f4Zn8OveXitMBKnTTtvrcASgkrDj7B00jLU
         2pWuGQiibmV5FJ1b/AWK3eHLFhAPhHoW3diBF/qpW1bzqXkeu9ttGl/I0ZtnFslwOoKU
         Km4A==
X-Gm-Message-State: AC+VfDzlSymcERTZxJVOup0Yrvr7gvumsQt/34Nqeeew4h3fJnpQvyoM
        bdbhAgBHh2u7uElPU7O0gyaVBdOHwr/Q73WncnU1l0va96B+NrFx1Dlm/bVdGqMq8yJfyMXDJrM
        KeoGIb6wxFRXCVNV4NNolXuUthHBZCpPj5Ti0cb9H
X-Received: by 2002:a17:90a:8a0b:b0:256:2cb7:406e with SMTP id w11-20020a17090a8a0b00b002562cb7406emr12428283pjn.45.1687250125750;
        Tue, 20 Jun 2023 01:35:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Cwvw+53HBO5dyT3yBGubAcxESpLj8w1H9mjcbCyyRmlIi6PWSAZAGWDuabTXUpPiSmwrEXWfrGClGaHCf8o4=
X-Received: by 2002:a17:90a:8a0b:b0:256:2cb7:406e with SMTP id
 w11-20020a17090a8a0b00b002562cb7406emr12428268pjn.45.1687250125427; Tue, 20
 Jun 2023 01:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-2-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 16:35:14 +0800
Message-ID: <CALTww281XOxzFXFQmZ-HWcekMzC30bryJ3YtYGRoERTrk2SHCQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/8] md: move initialization and destruction of
 'io_acct_set' to md.c
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 8:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> 'io_acct_set' is only used for raid0 and raid456, prepare to use it for
> raid1 and raid10, so that io accounting from different levels can be
> consistent.
>
> By the way, follow up patches will also use this io clone mechanism to
> make sure 'active_io' represents in flight io, not io that is dispatching=
,
> so that mddev_suspend will wait for io to be done as desgined.

Hi Kuai

typo error: s/desgined/designed/g

Before this patch the personality uses ->quiesce method to wait until
all inflight ios come back. But I like this solution. It makes the
codes simpler. Not sure if it can cause problems because it changes
the meaning of ->active_io. I'm doing regression tests to check.

>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c    | 27 ++++++++++-----------------
>  drivers/md/md.h    |  2 --
>  drivers/md/raid0.c | 16 ++--------------
>  drivers/md/raid5.c | 41 +++++++++++------------------------------
>  4 files changed, 23 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 8d62f85d2ab0..42347289195a 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5886,6 +5886,13 @@ int md_run(struct mddev *mddev)
>                         goto exit_bio_set;
>         }
>
> +       if (!bioset_initialized(&mddev->io_acct_set)) {
> +               err =3D bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
> +                                 offsetof(struct md_io_acct, bio_clone),=
 0);
> +               if (err)
> +                       goto exit_sync_set;
> +       }
> +
>         spin_lock(&pers_lock);
>         pers =3D find_pers(mddev->level, mddev->clevel);
>         if (!pers || !try_module_get(pers->owner)) {
> @@ -6063,6 +6070,8 @@ int md_run(struct mddev *mddev)
>         module_put(pers->owner);
>         md_bitmap_destroy(mddev);
>  abort:
> +       bioset_exit(&mddev->io_acct_set);
> +exit_sync_set:
>         bioset_exit(&mddev->sync_set);
>  exit_bio_set:
>         bioset_exit(&mddev->bio_set);
> @@ -6286,6 +6295,7 @@ static void __md_stop(struct mddev *mddev)
>         percpu_ref_exit(&mddev->active_io);
>         bioset_exit(&mddev->bio_set);
>         bioset_exit(&mddev->sync_set);
> +       bioset_exit(&mddev->io_acct_set);
>  }
>
>  void md_stop(struct mddev *mddev)
> @@ -8651,23 +8661,6 @@ void md_submit_discard_bio(struct mddev *mddev, st=
ruct md_rdev *rdev,
>  }
>  EXPORT_SYMBOL_GPL(md_submit_discard_bio);
>
> -int acct_bioset_init(struct mddev *mddev)
> -{
> -       int err =3D 0;
> -
> -       if (!bioset_initialized(&mddev->io_acct_set))
> -               err =3D bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
> -                       offsetof(struct md_io_acct, bio_clone), 0);
> -       return err;
> -}
> -EXPORT_SYMBOL_GPL(acct_bioset_init);
> -
> -void acct_bioset_exit(struct mddev *mddev)
> -{
> -       bioset_exit(&mddev->io_acct_set);
> -}
> -EXPORT_SYMBOL_GPL(acct_bioset_exit);
> -
>  static void md_end_io_acct(struct bio *bio)
>  {
>         struct md_io_acct *md_io_acct =3D bio->bi_private;
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 7cab9c7c45b8..11299d94b239 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -776,8 +776,6 @@ extern void md_error(struct mddev *mddev, struct md_r=
dev *rdev);
>  extern void md_finish_reshape(struct mddev *mddev);
>  void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>                         struct bio *bio, sector_t start, sector_t size);
> -int acct_bioset_init(struct mddev *mddev);
> -void acct_bioset_exit(struct mddev *mddev);
>  void md_account_bio(struct mddev *mddev, struct bio **bio);
>
>  extern bool __must_check md_flush_request(struct mddev *mddev, struct bi=
o *bio);
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f8ee9a95e25d..38d9209cada1 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -365,7 +365,6 @@ static void raid0_free(struct mddev *mddev, void *pri=
v)
>         struct r0conf *conf =3D priv;
>
>         free_conf(mddev, conf);
> -       acct_bioset_exit(mddev);
>  }
>
>  static int raid0_run(struct mddev *mddev)
> @@ -380,16 +379,11 @@ static int raid0_run(struct mddev *mddev)
>         if (md_check_no_bitmap(mddev))
>                 return -EINVAL;
>
> -       if (acct_bioset_init(mddev)) {
> -               pr_err("md/raid0:%s: alloc acct bioset failed.\n", mdname=
(mddev));
> -               return -ENOMEM;
> -       }
> -
>         /* if private is not null, we are here after takeover */
>         if (mddev->private =3D=3D NULL) {
>                 ret =3D create_strip_zones(mddev, &conf);
>                 if (ret < 0)
> -                       goto exit_acct_set;
> +                       return ret;
>                 mddev->private =3D conf;
>         }
>         conf =3D mddev->private;
> @@ -420,15 +414,9 @@ static int raid0_run(struct mddev *mddev)
>
>         ret =3D md_integrity_register(mddev);
>         if (ret)
> -               goto free;
> +               free_conf(mddev, conf);
>
>         return ret;
> -
> -free:
> -       free_conf(mddev, conf);
> -exit_acct_set:
> -       acct_bioset_exit(mddev);
> -       return ret;
>  }
>
>  static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f8bc74e16811..29cf5455d7a5 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7787,19 +7787,12 @@ static int raid5_run(struct mddev *mddev)
>         struct md_rdev *rdev;
>         struct md_rdev *journal_dev =3D NULL;
>         sector_t reshape_offset =3D 0;
> -       int i, ret =3D 0;
> +       int i;
>         long long min_offset_diff =3D 0;
>         int first =3D 1;
>
> -       if (acct_bioset_init(mddev)) {
> -               pr_err("md/raid456:%s: alloc acct bioset failed.\n", mdna=
me(mddev));
> +       if (mddev_init_writes_pending(mddev) < 0)
>                 return -ENOMEM;
> -       }
> -
> -       if (mddev_init_writes_pending(mddev) < 0) {
> -               ret =3D -ENOMEM;
> -               goto exit_acct_set;
> -       }
>
>         if (mddev->recovery_cp !=3D MaxSector)
>                 pr_notice("md/raid:%s: not clean -- starting background r=
econstruction\n",
> @@ -7830,8 +7823,7 @@ static int raid5_run(struct mddev *mddev)
>             (mddev->bitmap_info.offset || mddev->bitmap_info.file)) {
>                 pr_notice("md/raid:%s: array cannot have both journal and=
 bitmap\n",
>                           mdname(mddev));
> -               ret =3D -EINVAL;
> -               goto exit_acct_set;
> +               return -EINVAL;
>         }
>
>         if (mddev->reshape_position !=3D MaxSector) {
> @@ -7856,15 +7848,13 @@ static int raid5_run(struct mddev *mddev)
>                 if (journal_dev) {
>                         pr_warn("md/raid:%s: don't support reshape with j=
ournal - aborting.\n",
>                                 mdname(mddev));
> -                       ret =3D -EINVAL;
> -                       goto exit_acct_set;
> +                       return -EINVAL;
>                 }
>
>                 if (mddev->new_level !=3D mddev->level) {
>                         pr_warn("md/raid:%s: unsupported reshape required=
 - aborting.\n",
>                                 mdname(mddev));
> -                       ret =3D -EINVAL;
> -                       goto exit_acct_set;
> +                       return -EINVAL;
>                 }
>                 old_disks =3D mddev->raid_disks - mddev->delta_disks;
>                 /* reshape_position must be on a new-stripe boundary, and=
 one
> @@ -7880,8 +7870,7 @@ static int raid5_run(struct mddev *mddev)
>                 if (sector_div(here_new, chunk_sectors * new_data_disks))=
 {
>                         pr_warn("md/raid:%s: reshape_position not on a st=
ripe boundary\n",
>                                 mdname(mddev));
> -                       ret =3D -EINVAL;
> -                       goto exit_acct_set;
> +                       return -EINVAL;
>                 }
>                 reshape_offset =3D here_new * chunk_sectors;
>                 /* here_new is the stripe we will write to */
> @@ -7903,8 +7892,7 @@ static int raid5_run(struct mddev *mddev)
>                         else if (mddev->ro =3D=3D 0) {
>                                 pr_warn("md/raid:%s: in-place reshape mus=
t be started in read-only mode - aborting\n",
>                                         mdname(mddev));
> -                               ret =3D -EINVAL;
> -                               goto exit_acct_set;
> +                               return -EINVAL;
>                         }
>                 } else if (mddev->reshape_backwards
>                     ? (here_new * chunk_sectors + min_offset_diff <=3D
> @@ -7914,8 +7902,7 @@ static int raid5_run(struct mddev *mddev)
>                         /* Reading from the same stripe as writing to - b=
ad */
>                         pr_warn("md/raid:%s: reshape_position too early f=
or auto-recovery - aborting.\n",
>                                 mdname(mddev));
> -                       ret =3D -EINVAL;
> -                       goto exit_acct_set;
> +                       return -EINVAL;
>                 }
>                 pr_debug("md/raid:%s: reshape will continue\n", mdname(md=
dev));
>                 /* OK, we should be able to continue; */
> @@ -7939,10 +7926,8 @@ static int raid5_run(struct mddev *mddev)
>         else
>                 conf =3D mddev->private;
>
> -       if (IS_ERR(conf)) {
> -               ret =3D PTR_ERR(conf);
> -               goto exit_acct_set;
> -       }
> +       if (IS_ERR(conf))
> +               return PTR_ERR(conf);
>
>         if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
>                 if (!journal_dev) {
> @@ -8140,10 +8125,7 @@ static int raid5_run(struct mddev *mddev)
>         free_conf(conf);
>         mddev->private =3D NULL;
>         pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
> -       ret =3D -EIO;
> -exit_acct_set:
> -       acct_bioset_exit(mddev);
> -       return ret;
> +       return -EIO;
>  }
>
>  static void raid5_free(struct mddev *mddev, void *priv)
> @@ -8151,7 +8133,6 @@ static void raid5_free(struct mddev *mddev, void *p=
riv)
>         struct r5conf *conf =3D priv;
>
>         free_conf(conf);
> -       acct_bioset_exit(mddev);
>         mddev->to_remove =3D &raid5_attrs_group;
>  }
>
> --
> 2.39.2
>

The patch is good for me.

Reviewed-by: Xiao Ni <xni@redhat.com>

