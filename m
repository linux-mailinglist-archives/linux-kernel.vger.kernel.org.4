Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2617B7366A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFTIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFTIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D360510D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687250914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcmocH4bFmjVPRGX3QJnjOB3FQaFAW7Mn3C6eTR0lrA=;
        b=NyvgndK/qJZ+5Qr9vF4bEpQP6f5Un1rm23FxU/uk4LwFS/lUj8Drko0hNq+/Ra4RbrdPBf
        oWGGADVTAJgO2nAHrL36bh4ha3JWehvb/hS94vEHbkEqmodGd3j6ROAjpnbma8u9SlGcm/
        UNKj5k0mhZF9wzxhrZ7QVAwl7yDd2dU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-nODCyKXdM7SgIrtNReT25w-1; Tue, 20 Jun 2023 04:48:31 -0400
X-MC-Unique: nODCyKXdM7SgIrtNReT25w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25e18dac4a3so1854616a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687250911; x=1689842911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcmocH4bFmjVPRGX3QJnjOB3FQaFAW7Mn3C6eTR0lrA=;
        b=jTkO8GIeroPps6e1hcB2ved+y6WyPDi8MovVx1XreHNm6ZsSLy/2Kzx2yv00S0sMdq
         hl+cJKpJaVEDs8lqGW4LYNbcinnnKg+s2+783bvFyL2DJaO5wCzJ2rUmg0RS72tpnhnW
         OTgH6rC3VYG+j8dqsIcyS2gILF3KkCwlME069W1tEI3tZeDtGtKA9WAFg3a4AF2sluLD
         uj0Ihj6WPw6Gli0+LE/cGwGNjLXC8vJvq2u97xH92IcHk7QolB6anyOKljbdMbGzNHEP
         rrChKb7OhlAeUpjcorahAXm1UhjOL56FVj9ywJJYhDP7M8n/PWioui0bW/THX7JBCJWO
         LnEw==
X-Gm-Message-State: AC+VfDzwH+NkJoGJx+p4q0Y8tCokGOGltZRqUA0ynxcGuayoMCQWtSlq
        FkZs4B+PRMUUA7vHDxlYNQuxcuJwcoq8M7jFPKzRQtHpM/QACdDaifbkwbjOes0z1/5gQfXdc6f
        nLlDI4572EkWNrZavOG7COdwQq2u6eTdaJpLDHyct
X-Received: by 2002:a17:90a:3ee2:b0:25b:f273:84ca with SMTP id k89-20020a17090a3ee200b0025bf27384camr8893781pjc.12.1687250910791;
        Tue, 20 Jun 2023 01:48:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k4K214ZP7sgMFpfMciAnNBmMmgpf6wBnzJI1O6MPu+OMl7hp/0mKKTjqFVGSnr8xWgDVzM/zywSnHc0GzwYQ=
X-Received: by 2002:a17:90a:3ee2:b0:25b:f273:84ca with SMTP id
 k89-20020a17090a3ee200b0025bf27384camr8893769pjc.12.1687250910445; Tue, 20
 Jun 2023 01:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-3-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-3-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 16:48:19 +0800
Message-ID: <CALTww2-p6j94zxYfaDe5eHaDJSc+w86LBq1K9jDT1HhKmOOyiQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/8] md: also clone new io if io accounting is disabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 8:49=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, 'active_io' is grabed before make_reqeust() is called, and
> it's dropped immediately make_reqeust() returns. Hence 'active_io'
> actually means io is dispatching, not io is inflight.

Hi Kuai

There are three typo errors in the commit message: s/grabed/grabbed/g

>
> For raid0 and raid456 that io accounting is enabled, 'active_io' will
> also be grabed when bio is cloned for io accounting, and this 'active_io'
> is dropped until io is done.
>
> Always clone new bio so that 'active_io' will mean that io is inflight,
> raid1 and raid10 will switch to use this method in later patches. Once
> these are implemented, it can be cleaned up that 'active_io' is grabed
> twice for one io.
>
> Now that bio will be cloned even if io accounting is disabled, also
> rename related structure from '*_acct_*' to '*_clone_*'.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c    | 61 ++++++++++++++++++++++++----------------------
>  drivers/md/md.h    |  4 +--
>  drivers/md/raid5.c | 18 +++++++-------
>  3 files changed, 43 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 42347289195a..5ad8e7f3aebd 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2314,7 +2314,7 @@ int md_integrity_register(struct mddev *mddev)
>         pr_debug("md: data integrity enabled on %s\n", mdname(mddev));
>         if (bioset_integrity_create(&mddev->bio_set, BIO_POOL_SIZE) ||
>             (mddev->level !=3D 1 && mddev->level !=3D 10 &&
> -            bioset_integrity_create(&mddev->io_acct_set, BIO_POOL_SIZE))=
) {
> +            bioset_integrity_create(&mddev->io_clone_set, BIO_POOL_SIZE)=
)) {
>                 /*
>                  * No need to handle the failure of bioset_integrity_crea=
te,
>                  * because the function is called by md_run() -> pers->ru=
n(),
> @@ -5886,9 +5886,9 @@ int md_run(struct mddev *mddev)
>                         goto exit_bio_set;
>         }
>
> -       if (!bioset_initialized(&mddev->io_acct_set)) {
> -               err =3D bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
> -                                 offsetof(struct md_io_acct, bio_clone),=
 0);
> +       if (!bioset_initialized(&mddev->io_clone_set)) {
> +               err =3D bioset_init(&mddev->io_clone_set, BIO_POOL_SIZE,
> +                                 offsetof(struct md_io_clone, bio_clone)=
, 0);
>                 if (err)
>                         goto exit_sync_set;
>         }
> @@ -6070,7 +6070,7 @@ int md_run(struct mddev *mddev)
>         module_put(pers->owner);
>         md_bitmap_destroy(mddev);
>  abort:
> -       bioset_exit(&mddev->io_acct_set);
> +       bioset_exit(&mddev->io_clone_set);
>  exit_sync_set:
>         bioset_exit(&mddev->sync_set);
>  exit_bio_set:
> @@ -6295,7 +6295,7 @@ static void __md_stop(struct mddev *mddev)
>         percpu_ref_exit(&mddev->active_io);
>         bioset_exit(&mddev->bio_set);
>         bioset_exit(&mddev->sync_set);
> -       bioset_exit(&mddev->io_acct_set);
> +       bioset_exit(&mddev->io_clone_set);
>  }
>
>  void md_stop(struct mddev *mddev)
> @@ -8661,45 +8661,48 @@ void md_submit_discard_bio(struct mddev *mddev, s=
truct md_rdev *rdev,
>  }
>  EXPORT_SYMBOL_GPL(md_submit_discard_bio);
>
> -static void md_end_io_acct(struct bio *bio)
> +static void md_end_clone_io(struct bio *bio)
>  {
> -       struct md_io_acct *md_io_acct =3D bio->bi_private;
> -       struct bio *orig_bio =3D md_io_acct->orig_bio;
> -       struct mddev *mddev =3D md_io_acct->mddev;
> +       struct md_io_clone *md_io_clone =3D bio->bi_private;
> +       struct bio *orig_bio =3D md_io_clone->orig_bio;
> +       struct mddev *mddev =3D md_io_clone->mddev;
>
>         orig_bio->bi_status =3D bio->bi_status;
>
> -       bio_end_io_acct(orig_bio, md_io_acct->start_time);
> +       if (md_io_clone->start_time)
> +               bio_end_io_acct(orig_bio, md_io_clone->start_time);
> +
>         bio_put(bio);
>         bio_endio(orig_bio);
> -
>         percpu_ref_put(&mddev->active_io);
>  }
>
> +static void md_clone_bio(struct mddev *mddev, struct bio **bio)
> +{
> +       struct block_device *bdev =3D (*bio)->bi_bdev;
> +       struct md_io_clone *md_io_clone;
> +       struct bio *clone =3D
> +               bio_alloc_clone(bdev, *bio, GFP_NOIO, &mddev->io_clone_se=
t);
> +
> +       md_io_clone =3D container_of(clone, struct md_io_clone, bio_clone=
);
> +       md_io_clone->orig_bio =3D *bio;
> +       md_io_clone->mddev =3D mddev;
> +       if (blk_queue_io_stat(bdev->bd_disk->queue))
> +               md_io_clone->start_time =3D bio_start_io_acct(*bio);
> +
> +       clone->bi_end_io =3D md_end_clone_io;
> +       clone->bi_private =3D md_io_clone;
> +       *bio =3D clone;
> +}
> +
>  /*
>   * Used by personalities that don't already clone the bio and thus can't
>   * easily add the timestamp to their extended bio structure.
>   */
>  void md_account_bio(struct mddev *mddev, struct bio **bio)
>  {
> -       struct block_device *bdev =3D (*bio)->bi_bdev;
> -       struct md_io_acct *md_io_acct;
> -       struct bio *clone;
> -
> -       if (!blk_queue_io_stat(bdev->bd_disk->queue))
> -               return;
> -
>         percpu_ref_get(&mddev->active_io);
> -
> -       clone =3D bio_alloc_clone(bdev, *bio, GFP_NOIO, &mddev->io_acct_s=
et);
> -       md_io_acct =3D container_of(clone, struct md_io_acct, bio_clone);
> -       md_io_acct->orig_bio =3D *bio;
> -       md_io_acct->start_time =3D bio_start_io_acct(*bio);
> -       md_io_acct->mddev =3D mddev;
> -
> -       clone->bi_end_io =3D md_end_io_acct;
> -       clone->bi_private =3D md_io_acct;
> -       *bio =3D clone;
> +       md_clone_bio(mddev, bio);
>  }
>  EXPORT_SYMBOL_GPL(md_account_bio);
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 11299d94b239..892a598a5029 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -510,7 +510,7 @@ struct mddev {
>         struct bio_set                  sync_set; /* for sync operations =
like
>                                                    * metadata and bitmap =
writes
>                                                    */
> -       struct bio_set                  io_acct_set; /* for raid0 and rai=
d5 io accounting */
> +       struct bio_set                  io_clone_set;
>
>         /* Generic flush handling.
>          * The last to finish preflush schedules a worker to submit
> @@ -738,7 +738,7 @@ struct md_thread {
>         void                    *private;
>  };
>
> -struct md_io_acct {
> +struct md_io_clone {
>         struct mddev    *mddev;
>         struct bio      *orig_bio;
>         unsigned long   start_time;
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 29cf5455d7a5..cef0b400b2ee 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5468,13 +5468,13 @@ static struct bio *remove_bio_from_retry(struct r=
5conf *conf,
>   */
>  static void raid5_align_endio(struct bio *bi)
>  {
> -       struct md_io_acct *md_io_acct =3D bi->bi_private;
> -       struct bio *raid_bi =3D md_io_acct->orig_bio;
> +       struct md_io_clone *md_io_clone =3D bi->bi_private;
> +       struct bio *raid_bi =3D md_io_clone->orig_bio;
>         struct mddev *mddev;
>         struct r5conf *conf;
>         struct md_rdev *rdev;
>         blk_status_t error =3D bi->bi_status;
> -       unsigned long start_time =3D md_io_acct->start_time;
> +       unsigned long start_time =3D md_io_clone->start_time;
>
>         bio_put(bi);
>
> @@ -5506,7 +5506,7 @@ static int raid5_read_one_chunk(struct mddev *mddev=
, struct bio *raid_bio)
>         struct md_rdev *rdev;
>         sector_t sector, end_sector, first_bad;
>         int bad_sectors, dd_idx;
> -       struct md_io_acct *md_io_acct;
> +       struct md_io_clone *md_io_clone;
>         bool did_inc;
>
>         if (!in_chunk_boundary(mddev, raid_bio)) {
> @@ -5544,15 +5544,15 @@ static int raid5_read_one_chunk(struct mddev *mdd=
ev, struct bio *raid_bio)
>         }
>
>         align_bio =3D bio_alloc_clone(rdev->bdev, raid_bio, GFP_NOIO,
> -                                   &mddev->io_acct_set);
> -       md_io_acct =3D container_of(align_bio, struct md_io_acct, bio_clo=
ne);
> +                                   &mddev->io_clone_set);
> +       md_io_clone =3D container_of(align_bio, struct md_io_clone, bio_c=
lone);
>         raid_bio->bi_next =3D (void *)rdev;
>         if (blk_queue_io_stat(raid_bio->bi_bdev->bd_disk->queue))
> -               md_io_acct->start_time =3D bio_start_io_acct(raid_bio);
> -       md_io_acct->orig_bio =3D raid_bio;
> +               md_io_clone->start_time =3D bio_start_io_acct(raid_bio);
> +       md_io_clone->orig_bio =3D raid_bio;
>
>         align_bio->bi_end_io =3D raid5_align_endio;
> -       align_bio->bi_private =3D md_io_acct;
> +       align_bio->bi_private =3D md_io_clone;
>         align_bio->bi_iter.bi_sector =3D sector;
>
>         /* No reshape active, so we can trust rdev->data_offset */
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

