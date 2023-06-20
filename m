Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7E5736707
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjFTJI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFTJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33014118
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687252078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u89KDtFujgbOaugYBCeOSK6tTLWa4RqxaoIKqf8zGz0=;
        b=Y9NxJVxk4aQrX1zwg43ctoyXmlyJWezInGHt+zzN1CXl35xGhkQa/iw+oS4VtqPqSr0k7R
        bET41cJ+n9Gr6eAh9BKTdqWO2hwX5i5I7y+jwplH7hibLF/hc9bLIu2Yy/UsPxphiWk0re
        RmGKxwmSx0JhTsmeFmP35dzmW58yqOM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Nymf3LOrPbqK9BCK6F50Eg-1; Tue, 20 Jun 2023 05:07:56 -0400
X-MC-Unique: Nymf3LOrPbqK9BCK6F50Eg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cb2a0b57aso3199786b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252075; x=1689844075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u89KDtFujgbOaugYBCeOSK6tTLWa4RqxaoIKqf8zGz0=;
        b=ZNfmL8azKs24NUzNQptj4g49eox3GHe1fYILxG68xp6uhRLque4FYNJrQZxM711d1c
         f2e56OkeBxSLW5n7KVNzIbPq01VnbORC6SvWv6lOuv56PY9bqeBUuazHwEb+13gumHIb
         fChHxW1edYxlhxnutSpL2vs9BYLRU48Ek+FXSwkpXwry013Q7w61ic7+/S7Lw1RSf9Lk
         914Wabk27WQgchtWjEf9O0JQLn9McfqTmcK3EHWB5JmKnvrjzKCaUmz1mTqZnG4bJTCD
         5Ve2R8cEZxf0UEjD0SLNdUospw5AX6cLljCOGYg4fMhVXYusmKrOzf/RdFlNHmTiVMqI
         CKoA==
X-Gm-Message-State: AC+VfDxjwOxw5M+i4boFb3d/Hk9g/sTInMuKfZnRkn3qJfZo2oKJUU7I
        vP5Ty5cfgKmyiqW8TEZQy5EwsuUcOwrXSJr1OqDlXkjyf1uo+GyHJ1N9g/uqY1CC7NvQiD9mGEV
        xdWfuaGYi5HzQS8u1TlP7qbupGIbEweDsVEPkZOSdSdNSNuTnHIArbQ==
X-Received: by 2002:a05:6808:1901:b0:3a0:3476:ac97 with SMTP id bf1-20020a056808190100b003a03476ac97mr3273660oib.52.1687252075118;
        Tue, 20 Jun 2023 02:07:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6T26dtBdTUdqEBBapqGQKcAxmd3pstGOLPCeF17m31P3jBQvT58Twa1/gT4auFglazfm0AwH0df5je0w2Gykw=
X-Received: by 2002:a05:6808:1901:b0:3a0:3476:ac97 with SMTP id
 bf1-20020a056808190100b003a03476ac97mr3273652oib.52.1687252074859; Tue, 20
 Jun 2023 02:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230619204826.755559-1-yukuai1@huaweicloud.com> <20230619204826.755559-5-yukuai1@huaweicloud.com>
In-Reply-To: <20230619204826.755559-5-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 20 Jun 2023 17:07:43 +0800
Message-ID: <CALTww28AYb3Gi0qKHqsRuFrS0_P9-Fo1BYhsvTsrTFKnu084SA@mail.gmail.com>
Subject: Re: [PATCH -next 4/8] md/raid1: switch to use md_account_bio() for io accounting
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> Two problems can be fixed this way:
>
> 1) 'active_io' will represent inflight io instead of io that is
> dispatching.
>
> 2) If io accounting is enabled or disabled while io is still inflight,
> bio_start_io_acct() and bio_end_io_acct() is not balanced and io
> inflight counter will be leaked.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 14 ++++++--------
>  drivers/md/raid1.h |  1 -
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..06fa1580501f 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -304,8 +304,6 @@ static void call_bio_endio(struct r1bio *r1_bio)
>         if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
>                 bio->bi_status =3D BLK_STS_IOERR;
>
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> -               bio_end_io_acct(bio, r1_bio->start_time);
>         bio_endio(bio);
>  }
>
> @@ -1303,10 +1301,10 @@ static void raid1_read_request(struct mddev *mdde=
v, struct bio *bio,
>         }
>
>         r1_bio->read_disk =3D rdisk;
> -
> -       if (!r1bio_existed && blk_queue_io_stat(bio->bi_bdev->bd_disk->qu=
eue))
> -               r1_bio->start_time =3D bio_start_io_acct(bio);
> -
> +       if (!r1bio_existed) {
> +               md_account_bio(mddev, &bio);
> +               r1_bio->master_bio =3D bio;
> +       }
>         read_bio =3D bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
>                                    &mddev->bio_set);
>
> @@ -1500,8 +1498,8 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>                 r1_bio->sectors =3D max_sectors;
>         }
>
> -       if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
> -               r1_bio->start_time =3D bio_start_io_acct(bio);
> +       md_account_bio(mddev, &bio);
> +       r1_bio->master_bio =3D bio;
>         atomic_set(&r1_bio->remaining, 1);
>         atomic_set(&r1_bio->behind_remaining, 0);
>
> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
> index 468f189da7a0..14d4211a123a 100644
> --- a/drivers/md/raid1.h
> +++ b/drivers/md/raid1.h
> @@ -157,7 +157,6 @@ struct r1bio {
>         sector_t                sector;
>         int                     sectors;
>         unsigned long           state;
> -       unsigned long           start_time;
>         struct mddev            *mddev;
>         /*
>          * original bio going to /dev/mdx
> --
> 2.39.2
>

Hi Kuai

After this patch, raid1 will have one more memory allocation in the
I/O path. Not sure if it can affect performance. Beside this, the
patch is good for me.

Reviewed-by: Xiao Ni <xni@redhat.com>

