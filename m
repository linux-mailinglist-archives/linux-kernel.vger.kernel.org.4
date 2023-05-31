Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041771860C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjEaPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjEaPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B729123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685546410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnX9Gnk7ZK6e1v97vSi/RZM3h6QLWe89mhnvVr8zu8c=;
        b=NLcIVZ5RIGE3Xuz0EuNhVw5oOSqEGBi0Ej20pKcR9GgONcrxx5Mj3X61E4NcAIbOHRK/kl
        PlVSH54OZAGCiokFvbDuyFUVRoS5bJhr03VtQHhmIUrXyvj6ucidUMnKSFgISm5m33qAYx
        mqwHkUgkL5D/pzCCbvZWyf2vMGhbNDQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-jckMgDclPJiKrx8X_Ybf0Q-1; Wed, 31 May 2023 11:20:06 -0400
X-MC-Unique: jckMgDclPJiKrx8X_Ybf0Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b0116fefffso32170365ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685546405; x=1688138405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnX9Gnk7ZK6e1v97vSi/RZM3h6QLWe89mhnvVr8zu8c=;
        b=bQJaT98JPc+Kfx8g4i0CoK7uj8HyCaRJP/HUF/3+pAoVl3zKVjUldQRZdHNI4mPqIr
         zv4EeDEmQEZ4M6/GhD7vnrwSOxDnARnlBlUWttmk1AU/zjjy0/hxQ5rujw3We979Wbye
         xGroBSZ8oZ5Jrzq0SR4jLCaRMWjhq6dntz6/oHksb/4KjK/Byd93JsrSm8E1nIrn223p
         s7RcEObJeO2WzLFOc24ohj1lg+1tmjGoQ1igcTD0VmY/MlED8slkFJcH6l1T+yIY1bUH
         yr3nuT3EIrI0VFbleA2fQV0bMLxcpBQrVEqmrJlUPt4LlfpcH/Kw/GUb9HeGKHwP/3tB
         a51Q==
X-Gm-Message-State: AC+VfDxrCyVIVWZUHCDQSBK6NR+cjVDdXeu1yYbj9+yk6TL81L9I85Nx
        xTqcVI26ntNOjtDzngabKU3epDD9IZNLSZ3jT5ZxuvVpuO+J4p9q6MVW9UTz1WOTzc4maBpa+E4
        r7CiGF6X8ypQlCCeL8B6MZiNkT+9raBzGhEFKlLKh
X-Received: by 2002:a17:903:2310:b0:1ae:2013:4bc8 with SMTP id d16-20020a170903231000b001ae20134bc8mr5684784plh.18.1685546404686;
        Wed, 31 May 2023 08:20:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7z6W4n3IIHMxGNSSbs8RTtLgv6LU01UODycwCecNrFbNGE+C3sDnb7JOju+XBBRAtFZo/8V9bVOZfQ5Ozzl5Y=
X-Received: by 2002:a17:903:2310:b0:1ae:2013:4bc8 with SMTP id
 d16-20020a170903231000b001ae20134bc8mr5684759plh.18.1685546404368; Wed, 31
 May 2023 08:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
 <20230529131106.2123367-5-yukuai1@huaweicloud.com> <CALTww2-mOkQR+Qu0s=TE-TFoR7D0tDaA=gOOJ75r-Z_43X1yEg@mail.gmail.com>
 <0f01b4dc-8eea-f3e9-43a4-c33084fa72a1@huaweicloud.com>
In-Reply-To: <0f01b4dc-8eea-f3e9-43a4-c33084fa72a1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 31 May 2023 23:19:53 +0800
Message-ID: <CALTww29QrNLbKLp6F6d9cx2Abk3y9NT1UmBVgaDM20CTisGHDA@mail.gmail.com>
Subject: Re: [PATCH -next v3 4/7] md/raid1-10: submit write io directly if
 bitmap is not enabled
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, akpm@osdl.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
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

On Wed, May 31, 2023 at 4:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/31 15:26, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 29, 2023 at 9:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Commit 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid=
10")
> >> add bitmap support, and it changed that write io is submitted through
> >> daemon thread because bitmap need to be updated before write io. And
> >> later, plug is used to fix performance regression because all the writ=
e io
> >> will go to demon thread, which means io can't be issued concurrently.
> >>
> >> However, if bitmap is not enabled, the write io should not go to daemo=
n
> >> thread in the first place, and plug is not needed as well.
> >>
> >> Fixes: 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid=
10")
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md-bitmap.c |  4 +---
> >>   drivers/md/md-bitmap.h |  7 +++++++
> >>   drivers/md/raid1-10.c  | 13 +++++++++++--
> >>   3 files changed, 19 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> >> index ad5a3456cd8a..3ee590cf12a7 100644
> >> --- a/drivers/md/md-bitmap.c
> >> +++ b/drivers/md/md-bitmap.c
> >> @@ -1016,7 +1016,6 @@ static int md_bitmap_file_test_bit(struct bitmap=
 *bitmap, sector_t block)
> >>          return set;
> >>   }
> >>
> >> -
> >>   /* this gets called when the md device is ready to unplug its underl=
ying
> >>    * (slave) device queues -- before we let any writes go down, we nee=
d to
> >>    * sync the dirty pages of the bitmap file to disk */
> >> @@ -1026,8 +1025,7 @@ void md_bitmap_unplug(struct bitmap *bitmap)
> >>          int dirty, need_write;
> >>          int writing =3D 0;
> >>
> >> -       if (!bitmap || !bitmap->storage.filemap ||
> >> -           test_bit(BITMAP_STALE, &bitmap->flags))
> >> +       if (!md_bitmap_enabled(bitmap))
> >>                  return;
> >>
> >>          /* look at each page to see if there are any set bits that ne=
ed to be
> >> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> >> index cfd7395de8fd..3a4750952b3a 100644
> >> --- a/drivers/md/md-bitmap.h
> >> +++ b/drivers/md/md-bitmap.h
> >> @@ -273,6 +273,13 @@ int md_bitmap_copy_from_slot(struct mddev *mddev,=
 int slot,
> >>                               sector_t *lo, sector_t *hi, bool clear_b=
its);
> >>   void md_bitmap_free(struct bitmap *bitmap);
> >>   void md_bitmap_wait_behind_writes(struct mddev *mddev);
> >> +
> >> +static inline bool md_bitmap_enabled(struct bitmap *bitmap)
> >> +{
> >> +       return bitmap && bitmap->storage.filemap &&
> >> +              !test_bit(BITMAP_STALE, &bitmap->flags);
> >> +}
> >> +
> >>   #endif
> >>
> >>   #endif
> >> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> >> index 506299bd55cb..73cc3cb9154d 100644
> >> --- a/drivers/md/raid1-10.c
> >> +++ b/drivers/md/raid1-10.c
> >> @@ -131,9 +131,18 @@ static inline bool raid1_add_bio_to_plug(struct m=
ddev *mddev, struct bio *bio,
> >>                                        blk_plug_cb_fn unplug)
> >>   {
> >>          struct raid1_plug_cb *plug =3D NULL;
> >> -       struct blk_plug_cb *cb =3D blk_check_plugged(unplug, mddev,
> >> -                                                  sizeof(*plug));
> >> +       struct blk_plug_cb *cb;
> >> +
> >> +       /*
> >> +        * If bitmap is not enabled, it's safe to submit the io direct=
ly, and
> >> +        * this can get optimal performance.
> >> +        */
> >> +       if (!md_bitmap_enabled(mddev->bitmap)) {
> >> +               raid1_submit_write(bio);
> >> +               return true;
> >> +       }
> >
> > Can we check this out of raid1_add_bio_to_plug and call
> > raid1_submit_write directly in make_request function?
>
> Of course we can, I'm trying to avoid redundant code here...

I know. But it doesn't fit the name of the function.

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Regards
> > Xiao
> >>
> >> +       cb =3D blk_check_plugged(unplug, mddev, sizeof(*plug));
> >>          if (!cb)
> >>                  return false;
> >>
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>

