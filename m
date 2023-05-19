Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2020070A1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjESVVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjESVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846719A5;
        Fri, 19 May 2023 14:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B5665B4A;
        Fri, 19 May 2023 21:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9FC433A0;
        Fri, 19 May 2023 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684531226;
        bh=Hx9YxDvnmiuLLsAPDd2ZBc/YZmExH97fLGn0ryg0wbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E2OoWc4mFCxQs4OOViJWKQUvGuPvRpSTW5QO1LpeR90qzptifJZzz0cGtAKeWlrEq
         CSKpRr4rmcU1QNucIDXe7aYEOw9a4ZUkqoRpseNHQnp1owGs6Dv+2JU0ctwd/7tokk
         8wK9o9JH9S+mJOsTg3FPtcvroyLY1Wzdq0Ef2CjP+cYTDFuUSEdZoMhnVjnLMiQBjj
         vi5NwBxAgMwedDj7y9LWv7XgDxH13BkwFqYSdwlpW+FPWfvJwStj7DWqNg8p4k2hDf
         Fo9LZr7EoCgQAgeRMaCg3hlXA26ftcDxy5IHSWuhdLGUzXNu8teOkXM87rkjOVYaSS
         plUKLVyj9yrIg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f00d41df22so1614980e87.1;
        Fri, 19 May 2023 14:20:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDzWreugUqGoEo4HYRIi9WIhLPh4Tc4UAAwcP+7QmwvHot/IOi0E
        MpBU+oT3yL3fpkBEzc6TcuYWDDGrq3K55n84eKw=
X-Google-Smtp-Source: ACHHUZ6Zdk+ZYWMf7/0dgtkwTjYsk7+tB3MdzH1u1nvfCHTXpfmxvjhPUIYRsjULOTKH6D5fpF9hD/LPo2FgU6Qky2k=
X-Received: by 2002:a05:6512:3ca3:b0:4f3:7889:7603 with SMTP id
 h35-20020a0565123ca300b004f378897603mr1355316lfv.24.1684531223886; Fri, 19
 May 2023 14:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230515134808.3936750-1-linan666@huaweicloud.com> <20230515134808.3936750-2-linan666@huaweicloud.com>
In-Reply-To: <20230515134808.3936750-2-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 14:20:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5AuCPm1kL9f-R1fdPMqs3OEfZR2UUF3AkqC3Y0T_=snQ@mail.gmail.com>
Message-ID: <CAPhsuW5AuCPm1kL9f-R1fdPMqs3OEfZR2UUF3AkqC3Y0T_=snQ@mail.gmail.com>
Subject: Re: [PATCH OLK-5.10 v3 1/4] md/raid10: fix slab-out-of-bounds in md_bitmap_get_counter
To:     linan666@huaweicloud.com
Cc:     neilb@suse.de, Rob.Becker@riverbed.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 6:49=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> If we write a large number to md/bitmap_set_bits, md_bitmap_checkpage()
> will return -EINVAL because 'page >=3D bitmap->pages', but the return val=
ue
> was not checked immediately in md_bitmap_get_counter() in order to set
> *blocks value and slab-out-of-bounds occurs.
>
> Move check of 'page >=3D bitmap->pages' to md_bitmap_get_counter() and
> return directly if true.
>
> Fixes: ef4256733506 ("md/bitmap: optimise scanning of empty bitmaps.")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-bitmap.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 920bb68156d2..e122b19c124d 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -46,6 +46,7 @@ static inline char *bmname(struct bitmap *bitmap)
>   *
>   * if we find our page, we increment the page's refcount so that it stay=
s
>   * allocated while we're using it
> + * the caller must make sure 'page < bimap->pages'
>   */

I removed this comment, and added WARN_ON_ONCE().

Thanks,
Song

>  static int md_bitmap_checkpage(struct bitmap_counts *bitmap,
>                                unsigned long page, int create, int no_hij=
ack)
> @@ -54,14 +55,6 @@ __acquires(bitmap->lock)
>  {
>         unsigned char *mappage;
>
> -       if (page >=3D bitmap->pages) {
> -               /* This can happen if bitmap_start_sync goes beyond
> -                * End-of-device while looking for a whole page.
> -                * It is harmless.
> -                */
> -               return -EINVAL;
> -       }
> -
>         if (bitmap->bp[page].hijacked) /* it's hijacked, don't try to all=
oc */
>                 return 0;
>
> @@ -1387,6 +1380,14 @@ __acquires(bitmap->lock)
>         sector_t csize;
>         int err;
>
> +       if (page >=3D bitmap->pages) {
> +               /*
> +                * This can happen if bitmap_start_sync goes beyond
> +                * End-of-device while looking for a whole page or
> +                * user set a huge number to sysfs bitmap_set_bits.
> +                */
> +               return NULL;
> +       }
>         err =3D md_bitmap_checkpage(bitmap, page, create, 0);
>
>         if (bitmap->bp[page].hijacked ||
> --
> 2.31.1
>
