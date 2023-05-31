Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447BE717827
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjEaH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjEaH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07220125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685517988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJ69H8OwkNROgGo3hgzQjdLL4qgWQK91VNRhhvwKcMs=;
        b=Q91VgnKyZr/i2JJXbF/FFJcX9yrofhXPn8cMX4t/FTceIkKK9iYeylCia3u3QoAIwG1bwE
        Lqz6y1WUcshgHePq7P2gsY/JjPwhYdOooezTHQc+DrcCfiZe9f1TctotS2Zm6JyYUcEA/Z
        E5siHwag8AQHAgXNElE0rdZZzequv90=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-0SLRbUF5Pf2quMr0d-Ug1g-1; Wed, 31 May 2023 03:26:27 -0400
X-MC-Unique: 0SLRbUF5Pf2quMr0d-Ug1g-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso12528672276.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517987; x=1688109987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ69H8OwkNROgGo3hgzQjdLL4qgWQK91VNRhhvwKcMs=;
        b=HTGxYrTkSFp+LunI2iWBI3CBE1FUn1X6xQigwt+hzD/YrviHYQciZCvIjabz1JFOdh
         3kyvWixVTiMAFArI9HOtWm5CrdHdUPbD6NLbNkuhvqCOqkFko9jtDLJtQjBoUGC+Xzqk
         FlxK6lhSF08x2SyyuKm9wZeRaqh6Ngm81KwjAEzwpzsG7tG6OXqAtu+6G05cQDt1SpaI
         /fxf7uqfb1alWGKSjxObHwcygqQ24kVj75VzE2749PVdBYCcUEH4YnIeciLbOLDpvwm6
         VEh9ZVTZOT7WQL6RQre8w1kOt38TRK8rZ6Yq7bBMSHF+NmT/HqPHhCGSxI+XtLF3+UIl
         Qrng==
X-Gm-Message-State: AC+VfDzLq2dqUF+ffpOU3YwYyj+KAcKfMf8B6nSYR9hmQTo6W+zQXinF
        KlW/9GBreTmF4AwWgg2Ht9D7K5BEUXOV3ge/ETK9Um6lQhz5qIxgaVjux2Gu/SDHsh4mPA9P+cT
        vF0iDzsjpM0/kh4pa3LbwU6bgFFuvqcuwAUJtF2vY
X-Received: by 2002:a25:74c3:0:b0:bac:7294:4faf with SMTP id p186-20020a2574c3000000b00bac72944fafmr5830571ybc.27.1685517987253;
        Wed, 31 May 2023 00:26:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XLr76L1Km/YFTyFzihehq6bVkfwA3V+9D4X10JGfmRNAo4wi2AqM8Py7Wl/VSrnRZMFnpdyAQsMcwKXANCl8=
X-Received: by 2002:a25:74c3:0:b0:bac:7294:4faf with SMTP id
 p186-20020a2574c3000000b00bac72944fafmr5830556ybc.27.1685517987025; Wed, 31
 May 2023 00:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com> <20230529131106.2123367-5-yukuai1@huaweicloud.com>
In-Reply-To: <20230529131106.2123367-5-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 15:26:16 +0800
Message-ID: <CALTww2-mOkQR+Qu0s=TE-TFoR7D0tDaA=gOOJ75r-Z_43X1yEg@mail.gmail.com>
Subject: Re: [PATCH -next v3 4/7] md/raid1-10: submit write io directly if
 bitmap is not enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> Commit 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10"=
)
> add bitmap support, and it changed that write io is submitted through
> daemon thread because bitmap need to be updated before write io. And
> later, plug is used to fix performance regression because all the write i=
o
> will go to demon thread, which means io can't be issued concurrently.
>
> However, if bitmap is not enabled, the write io should not go to daemon
> thread in the first place, and plug is not needed as well.
>
> Fixes: 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10"=
)
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c |  4 +---
>  drivers/md/md-bitmap.h |  7 +++++++
>  drivers/md/raid1-10.c  | 13 +++++++++++--
>  3 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index ad5a3456cd8a..3ee590cf12a7 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -1016,7 +1016,6 @@ static int md_bitmap_file_test_bit(struct bitmap *b=
itmap, sector_t block)
>         return set;
>  }
>
> -
>  /* this gets called when the md device is ready to unplug its underlying
>   * (slave) device queues -- before we let any writes go down, we need to
>   * sync the dirty pages of the bitmap file to disk */
> @@ -1026,8 +1025,7 @@ void md_bitmap_unplug(struct bitmap *bitmap)
>         int dirty, need_write;
>         int writing =3D 0;
>
> -       if (!bitmap || !bitmap->storage.filemap ||
> -           test_bit(BITMAP_STALE, &bitmap->flags))
> +       if (!md_bitmap_enabled(bitmap))
>                 return;
>
>         /* look at each page to see if there are any set bits that need t=
o be
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index cfd7395de8fd..3a4750952b3a 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -273,6 +273,13 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, in=
t slot,
>                              sector_t *lo, sector_t *hi, bool clear_bits)=
;
>  void md_bitmap_free(struct bitmap *bitmap);
>  void md_bitmap_wait_behind_writes(struct mddev *mddev);
> +
> +static inline bool md_bitmap_enabled(struct bitmap *bitmap)
> +{
> +       return bitmap && bitmap->storage.filemap &&
> +              !test_bit(BITMAP_STALE, &bitmap->flags);
> +}
> +
>  #endif
>
>  #endif
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index 506299bd55cb..73cc3cb9154d 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -131,9 +131,18 @@ static inline bool raid1_add_bio_to_plug(struct mdde=
v *mddev, struct bio *bio,
>                                       blk_plug_cb_fn unplug)
>  {
>         struct raid1_plug_cb *plug =3D NULL;
> -       struct blk_plug_cb *cb =3D blk_check_plugged(unplug, mddev,
> -                                                  sizeof(*plug));
> +       struct blk_plug_cb *cb;
> +
> +       /*
> +        * If bitmap is not enabled, it's safe to submit the io directly,=
 and
> +        * this can get optimal performance.
> +        */
> +       if (!md_bitmap_enabled(mddev->bitmap)) {
> +               raid1_submit_write(bio);
> +               return true;
> +       }

Can we check this out of raid1_add_bio_to_plug and call
raid1_submit_write directly in make_request function?

Regards
Xiao
>
> +       cb =3D blk_check_plugged(unplug, mddev, sizeof(*plug));
>         if (!cb)
>                 return false;
>
> --
> 2.39.2
>

