Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826273671F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjFTJLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjFTJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2A1728
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mj8rQ6G1Wvfgkp2HZ99+gywVhjIHpdgY8cdSRKfaGg=;
        b=THbIJ9LNiD+hMLiVvT4JrvVw5FoMcoLavAbvjFPhFcy/pSV4w3q8nrWc5HLCb2rQKztqnW
        SlLVMWWJRyVO6dETQmdLrA2RoaN9KEkqdcQa+E5lX9sYoytqsiDmRh4watKrkbQ0aYD52r
        /vh+B+CSCv4+2+YSf2iIZa9IeR7R08Y=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-XN8Uu9C-MnaAzqgdu10o0Q-1; Tue, 20 Jun 2023 05:10:12 -0400
X-MC-Unique: XN8Uu9C-MnaAzqgdu10o0Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39edd9ffe4bso1425338b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252211; x=1689844211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mj8rQ6G1Wvfgkp2HZ99+gywVhjIHpdgY8cdSRKfaGg=;
        b=VvODcMr6Q/KAUyX2/nBZZGPP4VvTVUEFln4LVAhF8Sm3SxmJzcChyCbMdb7AdL/uXV
         EX+C0AIawzhzvCgsiDrDBdqWotmA1Lc5dSU6nnYIJgr/YLd83vB9tzEPYlP2IED/H2Da
         s+SANahfaCJupJWFqe4TTLeNNkOUQd5/t2T7F8SxqG9lCMZXbcpt9SaBJs3gN+Z1OjxC
         VuY948pf5qAiy4J/kmDErM59v/i/k7qBSpMzu/EgcIcdLBX88flI7RPnKkm7lTDCrIDX
         RF2eEAw851dUTfIrxcX2D5sl9H4aFeqWV64cv4gjh1mFq+cVOdmxcq15/byIxMr59ZYq
         pn3A==
X-Gm-Message-State: AC+VfDxH/EuEtU16QhPfVwZK3//IHm4LGjI3fVUpYMlPegnER4ou5Aw5
        46AFNnNfMmWkTF1RyBvVKYMwkX/c5Lj3RZAi3KWYpBaeQ5Rm2ix1GigD+bIDQk/VCrO46fVMkIm
        jaqHfaWSrRsL1z78imrqSTjf3rrAyNaDJXzUmp/OtfNL108hzPn0=
X-Received: by 2002:a05:6808:14d0:b0:39e:cb40:b705 with SMTP id f16-20020a05680814d000b0039ecb40b705mr6711340oiw.50.1687252211475;
        Tue, 20 Jun 2023 02:10:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69Ww/s13OWG+3SScO6r1O27eBdJ2jR5gEdqRcJT1pBJ378pQ1793OEVfRa8wxvtOKoc6AYS7udNo5N+aZ5q4k=
X-Received: by 2002:a05:6808:14d0:b0:39e:cb40:b705 with SMTP id
 f16-20020a05680814d000b0039ecb40b705mr6711322oiw.50.1687252211184; Tue, 20
 Jun 2023 02:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-6-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-6-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 17:10:00 +0800
Message-ID: <CALTww2-=zUZ7Pf4tVeuAaPbWMagTVj+1r0wYy1HvkUvWoBG0pA@mail.gmail.com>
Subject: Re: [PATCH -next 5/8] md/raid10: switch to use md_account_bio() for
 io accounting
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

On Mon, Jun 19, 2023 at 8:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Make sure that 'active_io' will represent inflight io instead of io that
> is dispatching, and io accounting from all levels will be consistent.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid10.c | 20 +++++++++-----------
>  drivers/md/raid10.h |  1 -
>  2 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 79067769e44b..69f6d7b1e600 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -325,8 +325,6 @@ static void raid_end_bio_io(struct r10bio *r10_bio)
>         if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
>                 bio->bi_status =3D BLK_STS_IOERR;
>
> -       if (r10_bio->start_time)
> -               bio_end_io_acct(bio, r10_bio->start_time);
>         bio_endio(bio);
>         /*
>          * Wake up any possible resync thread that waits for the device
> @@ -1172,7 +1170,7 @@ static bool regular_request_wait(struct mddev *mdde=
v, struct r10conf *conf,
>  }
>
>  static void raid10_read_request(struct mddev *mddev, struct bio *bio,
> -                               struct r10bio *r10_bio)
> +                               struct r10bio *r10_bio, bool io_accountin=
g)
>  {
>         struct r10conf *conf =3D mddev->private;
>         struct bio *read_bio;
> @@ -1243,9 +1241,10 @@ static void raid10_read_request(struct mddev *mdde=
v, struct bio *bio,
>         }
>         slot =3D r10_bio->read_slot;
>
> -       if (!r10_bio->start_time &&
> -           blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> -               r10_bio->start_time =3D bio_start_io_acct(bio);
> +       if (io_accounting) {
> +               md_account_bio(mddev, &bio);
> +               r10_bio->master_bio =3D bio;
> +       }
>         read_bio =3D bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_se=
t);
>
>         r10_bio->devs[slot].bio =3D read_bio;
> @@ -1543,8 +1542,8 @@ static void raid10_write_request(struct mddev *mdde=
v, struct bio *bio,
>                 r10_bio->master_bio =3D bio;
>         }
>
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> -               r10_bio->start_time =3D bio_start_io_acct(bio);
> +       md_account_bio(mddev, &bio);
> +       r10_bio->master_bio =3D bio;
>         atomic_set(&r10_bio->remaining, 1);
>         md_bitmap_startwrite(mddev->bitmap, r10_bio->sector, r10_bio->sec=
tors, 0);
>
> @@ -1571,12 +1570,11 @@ static void __make_request(struct mddev *mddev, s=
truct bio *bio, int sectors)
>         r10_bio->sector =3D bio->bi_iter.bi_sector;
>         r10_bio->state =3D 0;
>         r10_bio->read_slot =3D -1;
> -       r10_bio->start_time =3D 0;
>         memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
>                         conf->geo.raid_disks);
>
>         if (bio_data_dir(bio) =3D=3D READ)
> -               raid10_read_request(mddev, bio, r10_bio);
> +               raid10_read_request(mddev, bio, r10_bio, true);
>         else
>                 raid10_write_request(mddev, bio, r10_bio);
>  }
> @@ -2985,7 +2983,7 @@ static void handle_read_error(struct mddev *mddev, =
struct r10bio *r10_bio)
>
>         rdev_dec_pending(rdev, mddev);
>         r10_bio->state =3D 0;
> -       raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
> +       raid10_read_request(mddev, r10_bio->master_bio, r10_bio, false);
>         /*
>          * allow_barrier after re-submit to ensure no sync io
>          * can be issued while regular io pending.
> diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
> index 63e48b11b552..2e75e88d0802 100644
> --- a/drivers/md/raid10.h
> +++ b/drivers/md/raid10.h
> @@ -123,7 +123,6 @@ struct r10bio {
>         sector_t                sector; /* virtual sector number */
>         int                     sectors;
>         unsigned long           state;
> -       unsigned long           start_time;
>         struct mddev            *mddev;
>         /*
>          * original bio going to /dev/mdx
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

