Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29422741BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjF1WnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1WnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343B1715;
        Wed, 28 Jun 2023 15:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43E16146C;
        Wed, 28 Jun 2023 22:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8DCC433C0;
        Wed, 28 Jun 2023 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687992195;
        bh=INtXuUPK7Fk3jGmi227QlhLtHf1S0Baq4RVjHzVkPT4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulLkkCTYDA3NZHgl3sYRVLP844Rmq6rzly2Ozo9EpwEFbK/G+UAsr4oG/txHtoqnX
         GUxwHP7nW2yr0tjKZ4nBCBrOYCHkxjZ88yKnkF0Hdm3fSv9x32HTzrkG/HlNbOmL77
         F5cXwVkWWhXhnesYaY/QQqFpkoY4WFFiyrxkyof84+IezT0Ce81+eFce1TjtS6FVsM
         HfWGept2BBzCuiyxVgisHn/l/yMUZRLausDLsVnbJ9jk67upfdfy7gNY9ERRgZrK4A
         Eu9RaiiUpXypRYdfmjHiIblcUedb8pTz1wXFKPL6uhJ7QwVnMHvnITJFo1gCHRdrzJ
         Ng3jWTj2Wdz/g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f122ff663eso69458e87.2;
        Wed, 28 Jun 2023 15:43:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDwneYkqvonvPFFGMTw9cc8uVsVAYG1FH2yixocQDmWX+3ZhV5TF
        HLuRv30YqFCFhIfYZoe+XY75fdM2cJxuPnU5UKE=
X-Google-Smtp-Source: ACHHUZ6OGGVeeXJJwzPdiiQPmx4Gr2Ey3oXdLrRW0fVzKeGzVC06OdDwXHJFlYcErl5ZF5s5UB9nhtTNsvSFeuw68UA=
X-Received: by 2002:a19:5619:0:b0:4f8:6d53:a68f with SMTP id
 k25-20020a195619000000b004f86d53a68fmr17252714lfb.64.1687992193189; Wed, 28
 Jun 2023 15:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230628143201.1522227-1-jbaron@akamai.com>
In-Reply-To: <20230628143201.1522227-1-jbaron@akamai.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 28 Jun 2023 15:43:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-vrNh1MSCznEk_AmahBw9iq+jyG=Kmyi0N5m-T2dByA@mail.gmail.com>
Message-ID: <CAPhsuW6-vrNh1MSCznEk_AmahBw9iq+jyG=Kmyi0N5m-T2dByA@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: drop discard support past the first zone for
 the original layout (stable fix)
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for the fix!

On Wed, Jun 28, 2023 at 7:32=E2=80=AFAM Jason Baron <jbaron@akamai.com> wro=
te:
>
> We've found that using raid0 with the 'original' layout and discard
> enabled with different disk sizes (such that at least two zones are
> created) can result in data corruption. This is due to the fact that
> the discard handling in 'raid0_handle_discard()' assumes the 'alternate'
> layout. We've seen this corruption using ext4 but other filesystems are
> likely susceptible as well.
>
> More specifically, while multiple zones are necessary to create the
> corruption, the corruption may not occur with multiple zones if they
> layout in such a way the layout matches what the 'alternate' layout
> would have produced. Thus, not all raid0 devices with the 'original'
> layout, different size disks and discard enabled will encounter this
> corruption.
>
> The 3.14 kernel inadvertently changed the raid0 disk layout for different
> size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
> same raid0 array could corrupt data. This lead to the creation of the
> 'original' layout (to match the pre-3.14 layout) and the 'alternate' layo=
ut
> (to match the post 3.14 layout) in the 5.4 kernel time frame and an optio=
n
> to tell the kernel which layout to use (since it couldn't be autodetected=
).
> However, when the 'original' layout was added back to 5.4 discard support
> for the 'original' layout was not added leading this issue.
>
> I've been able to reliably reproduce the corruption with the following
> test case:
>
> 1. create raid0 array with different size disks using original layout
> 2. mkfs
> 3. mount -o discard
> 4. create lots of files
> 5. remove 1/2 the files
> 6. fstrim -a (or just the mount point for the raid0 array)
> 7. umount
> 8. fsck -fn /dev/md0 (spews all sorts of corruptions)
>
> The fix here is a minimal fix intended for stable trees which doesn't do
> discard if we have the original layout and we are not in first zone or
> if the i/o crosses zones (we either do the entire discard or none of it).
> The proper fix to actually perform discard to all zones for the original
> layout will land in upstream versions. We have implemented the minimal
> fix here for stable branches to reduce risk.
>
> I've verified the change using the reproducer mentioned above. Typically,
> the corruption is seen after less than 3 iterations, while the patch has
> run 500+ iterations.
>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <song@kernel.org>
> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout=
 confusion.")
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---
>  drivers/md/raid0.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f8ee9a95e25d..2713a4acb44f 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -444,10 +444,25 @@ static void raid0_handle_discard(struct mddev *mdde=
v, struct bio *bio)
>         sector_t end_disk_offset;
>         unsigned int end_disk_index;
>         unsigned int disk;
> +       bool bio_zone_overlap =3D false;
>
>         zone =3D find_zone(conf, &start);
> +       if (bio_end_sector(bio) > zone->zone_end)
> +               bio_zone_overlap =3D true;
> +
> +       /* The discard code below doesn't properly support the original
> +        * layout for the zones above the first one. We are adding
> +        * proper support in later kernel versions but have decided
> +        * that dropping discard support here is the lower risk option
> +        * to avoid data corruption for stable versions.
> +        */
> +       if ((conf->layout =3D=3D RAID0_ORIG_LAYOUT) &&
> +           ((zone !=3D conf->strip_zone) || (bio_zone_overlap))) {
> +               bio_endio(bio);
> +               return;
> +       }

For bio_zone_overlap case, I think we can still do the split below and
send discard to the first zone?

Song

>
> -       if (bio_end_sector(bio) > zone->zone_end) {
> +       if (bio_zone_overlap) {
>                 struct bio *split =3D bio_split(bio,
>                         zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO=
,
>                         &mddev->bio_set);
> --
> 2.25.1
>
