Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853D7177F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjEaHWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjEaHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03310F4
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685517674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Meyf/XHmfDbzkq87alDHYkBlXs+wlr8Q7mduutGuIR0=;
        b=EVmqkPVyAM9zIg2jZQ9d7EJvdkqC3OjU91e5+2KBGB93aGsxd7/4d7g/XPrRMyAhWUn/Vj
        5hRa6CWDbJMe7bLMwOLXUhsmy/E7GNn8WysZbhU+tnAKms9uas7RcQ9wtk8tiAH+IfA+DN
        G9AoxyrfwGQfMpJyoZsRiGFWsZRHU6c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-OXKRKI64Pnqal9MsAzjHpA-1; Wed, 31 May 2023 03:21:12 -0400
X-MC-Unique: OXKRKI64Pnqal9MsAzjHpA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-256419413a3so416596a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517671; x=1688109671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Meyf/XHmfDbzkq87alDHYkBlXs+wlr8Q7mduutGuIR0=;
        b=MHNK93fzNEYDD5UqMoCcoPsMJ2xchDTcmwhHhJJrahxB5YAEROMlN+dg6d2PY144x1
         68YI51lgyIQflkSu1A96fA2sNAy74a/5gfRpRQN6URGOw6QvAV/7ysBFit+4ZzlkiL9B
         H4rHvSKh0ylucy7Rmkcg8dZj1PXK9V8AWBCv0OVN0lWeXCY99HDs7Lf8iorT7YgHUb9j
         dlbjXY+4VJZhkboUrWVoaL2Q8O+lRjf3Ir/9umfpzOHlyXwpOZfjP5IipA+Cao6uUWEq
         pKtuwkFIy6PyswcHuIN51mPukMvcfS6nWsjnsR71j6ve6S+oWOPsAKUosLljsFdcVS2A
         XJJw==
X-Gm-Message-State: AC+VfDxBCiWUFOYgoyoFxkWJwoMKu+8AwiTv6XqC2I/acngMBJvRjbIy
        TLH+OMnonIpqVA1dpuRWOCjSJ/7vS7e8PyDIdHxtXZNyzVwGNKr66nwjsbSO19rZ+XN7urVN5Ql
        tPwZtuwJnLSjgYFIJCj5au1w5QQ31wR8YGe+XMESK
X-Received: by 2002:a17:90a:3d43:b0:250:50c5:cabc with SMTP id o3-20020a17090a3d4300b0025050c5cabcmr14294148pjf.3.1685517671322;
        Wed, 31 May 2023 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Xr2yPl0eRj04AKYLMozSgF8t55H6LRqpy/8SnKUtzxcgZY3K/m9auMoo9kMmyTGnPCK6MHDfI9L0x45szauI=
X-Received: by 2002:a17:90a:3d43:b0:250:50c5:cabc with SMTP id
 o3-20020a17090a3d4300b0025050c5cabcmr14294137pjf.3.1685517671046; Wed, 31 May
 2023 00:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com> <20230529131106.2123367-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 15:20:59 +0800
Message-ID: <CALTww29_d7H6DG+qZOOJvQ5A8AieXkDfKWgN38HeCP9W-r5RQg@mail.gmail.com>
Subject: Re: [PATCH -next v3 3/7] md/raid1-10: factor out a helper to submit
 normal write
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 9:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are multiple places to do the same thing, factor out a helper to
> prevent redundant code, and the helper will be used in following patch
> as well.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1-10.c | 17 +++++++++++++++++
>  drivers/md/raid1.c    | 13 ++-----------
>  drivers/md/raid10.c   | 26 ++++----------------------
>  3 files changed, 23 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 9bf19a3409ce..506299bd55cb 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -110,6 +110,23 @@ static void md_bio_reset_resync_pages(struct bio *bi=
o, struct resync_pages *rp,
>         } while (idx++ < RESYNC_PAGES && size > 0);
>  }
>
> +
> +static inline void raid1_submit_write(struct bio *bio)

Hi Kuai

Is it better to change the name to rdev_submit_write? It's just a
suggestion. The patch looks good to me.

Regards
Xiao

> +{
> +       struct md_rdev *rdev =3D (struct md_rdev *)bio->bi_bdev;
> +
> +       bio->bi_next =3D NULL;
> +       bio_set_dev(bio, rdev->bdev);
> +       if (test_bit(Faulty, &rdev->flags))
> +               bio_io_error(bio);
> +       else if (unlikely(bio_op(bio) =3D=3D  REQ_OP_DISCARD &&
> +                         !bdev_max_discard_sectors(bio->bi_bdev)))
> +               /* Just ignore it */
> +               bio_endio(bio);
> +       else
> +               submit_bio_noacct(bio);
> +}
> +
>  static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio=
 *bio,
>                                       blk_plug_cb_fn unplug)
>  {
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index e86c5e71c604..0778e398584c 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -799,17 +799,8 @@ static void flush_bio_list(struct r1conf *conf, stru=
ct bio *bio)
>
>         while (bio) { /* submit pending writes */
>                 struct bio *next =3D bio->bi_next;
> -               struct md_rdev *rdev =3D (void *)bio->bi_bdev;
> -               bio->bi_next =3D NULL;
> -               bio_set_dev(bio, rdev->bdev);
> -               if (test_bit(Faulty, &rdev->flags)) {
> -                       bio_io_error(bio);
> -               } else if (unlikely((bio_op(bio) =3D=3D REQ_OP_DISCARD) &=
&
> -                                   !bdev_max_discard_sectors(bio->bi_bde=
v)))
> -                       /* Just ignore it */
> -                       bio_endio(bio);
> -               else
> -                       submit_bio_noacct(bio);
> +
> +               raid1_submit_write(bio);
>                 bio =3D next;
>                 cond_resched();
>         }
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 18702051ebd1..6640507ecb0d 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -909,17 +909,8 @@ static void flush_pending_writes(struct r10conf *con=
f)
>
>                 while (bio) { /* submit pending writes */
>                         struct bio *next =3D bio->bi_next;
> -                       struct md_rdev *rdev =3D (void*)bio->bi_bdev;
> -                       bio->bi_next =3D NULL;
> -                       bio_set_dev(bio, rdev->bdev);
> -                       if (test_bit(Faulty, &rdev->flags)) {
> -                               bio_io_error(bio);
> -                       } else if (unlikely((bio_op(bio) =3D=3D  REQ_OP_D=
ISCARD) &&
> -                                           !bdev_max_discard_sectors(bio=
->bi_bdev)))
> -                               /* Just ignore it */
> -                               bio_endio(bio);
> -                       else
> -                               submit_bio_noacct(bio);
> +
> +                       raid1_submit_write(bio);
>                         bio =3D next;
>                         cond_resched();
>                 }
> @@ -1134,17 +1125,8 @@ static void raid10_unplug(struct blk_plug_cb *cb, =
bool from_schedule)
>
>         while (bio) { /* submit pending writes */
>                 struct bio *next =3D bio->bi_next;
> -               struct md_rdev *rdev =3D (void*)bio->bi_bdev;
> -               bio->bi_next =3D NULL;
> -               bio_set_dev(bio, rdev->bdev);
> -               if (test_bit(Faulty, &rdev->flags)) {
> -                       bio_io_error(bio);
> -               } else if (unlikely((bio_op(bio) =3D=3D  REQ_OP_DISCARD) =
&&
> -                                   !bdev_max_discard_sectors(bio->bi_bde=
v)))
> -                       /* Just ignore it */
> -                       bio_endio(bio);
> -               else
> -                       submit_bio_noacct(bio);
> +
> +               raid1_submit_write(bio);
>                 bio =3D next;
>                 cond_resched();
>         }
> --
> 2.39.2
>

