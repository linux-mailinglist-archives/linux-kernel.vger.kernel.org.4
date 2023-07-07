Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21974ACF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjGGId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGGIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04E113;
        Fri,  7 Jul 2023 01:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B770061873;
        Fri,  7 Jul 2023 08:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19613C433C8;
        Fri,  7 Jul 2023 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688718830;
        bh=jzj5w4oOeYiwchkKteHy4c/sygfhMRwo5+CFBhqVTR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IVwdS5MCk0nWjr6mRLAbGmU/vVF/Iy537G9Vr7zinEoHnLUng6bo59HSpH2cPO45+
         d3Jl8B8EtWBN8JJT/uYjsH/pt99mGjvo4w7/jSDl28IUmkGhIBdu+bQ/qqYBD1u0Nb
         dga1xTAU8X+vcJe/PlnI8025d0P0UQFhv2yJmEFWXUoyY8GIeSU4JH30vkuY07ouT3
         RfWRUYbhgLzHELFPCj4nReqdCoPLOhUrHbR/dZe5Wbggjx4szXYiWpwQDgmMYwgBkX
         rHoNW9hQvL3eRfnXsQhiDkugiUK686gADMV+qy2jpYsLBHSYsAwcCOiOIcHKORH/AO
         YHnbLPGTAQUwA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so2386879e87.2;
        Fri, 07 Jul 2023 01:33:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLYfKzKzIPWBRvyxe9ivk0RV/tisZBXEnKolKg0pCDMmotP0ToN6
        7ujnFI2tCuUa7Rg3LcnuCojs0qNNyr21Z4ywmFE=
X-Google-Smtp-Source: APBJJlGuN5+W3WHpU1kMZ9BacN5ZgkNQyPVHGATgB/4QCbBY4VybJ6kNHMQaPFsCqHJRKmJW2PJYUmq3OpiCmQKMqwU=
X-Received: by 2002:a19:7114:0:b0:4f9:56aa:26c5 with SMTP id
 m20-20020a197114000000b004f956aa26c5mr3180376lfc.25.1688718828033; Fri, 07
 Jul 2023 01:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230627034127.4000994-1-linan666@huaweicloud.com> <20230627034127.4000994-3-linan666@huaweicloud.com>
In-Reply-To: <20230627034127.4000994-3-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 16:33:35 +0800
X-Gmail-Original-Message-ID: <CAPhsuW7+bWe9YDMnjRgb657Fz7Vs_4wnBcU9jVSXuofKhaO38Q@mail.gmail.com>
Message-ID: <CAPhsuW7+bWe9YDMnjRgb657Fz7Vs_4wnBcU9jVSXuofKhaO38Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] md/raid10: handle replacement devices in fix_recovery_read_error
To:     linan666@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
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

On Tue, Jun 27, 2023 at 11:42=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> In fix_recovery_read_error(), the handling of replacement devices is
> missing. Add it. If io error is from replacement, error this device
> directly. If io error is from other device, just set badblocks for
> replacement.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/raid10.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 5105273f60e9..6d9025089455 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2551,7 +2551,7 @@ static void fix_recovery_read_error(struct r10bio *=
r10_bio)
>
>         while (sectors) {
>                 int s =3D sectors;
> -               struct md_rdev *rdev;
> +               struct md_rdev *rdev, *repl;
>                 sector_t addr;
>                 int ok;
>
> @@ -2559,6 +2559,7 @@ static void fix_recovery_read_error(struct r10bio *=
r10_bio)
>                         s =3D PAGE_SIZE >> 9;
>
>                 rdev =3D conf->mirrors[dr].rdev;
> +               repl =3D conf->mirrors[dw].replacement;
>                 addr =3D r10_bio->devs[0].addr + sect,
>                 ok =3D sync_page_io(rdev,
>                                   addr,
> @@ -2580,6 +2581,9 @@ static void fix_recovery_read_error(struct r10bio *=
r10_bio)
>                                         set_bit(MD_RECOVERY_NEEDED,
>                                                 &rdev->mddev->recovery);
>                         }
> +                       if (repl && !sync_page_io(repl, addr, s << 9,
> +                           pages[idx], REQ_OP_WRITE, false))
> +                               md_error(mddev, repl);
>                 }
>                 if (!ok) {
>                         /* We don't worry if we cannot set a bad block -
> @@ -2592,7 +2596,9 @@ static void fix_recovery_read_error(struct r10bio *=
r10_bio)
>                                 /* need bad block on destination too */
>                                 rdev =3D conf->mirrors[dw].rdev;
>                                 addr =3D r10_bio->devs[1].addr + sect;
> -                               if (!rdev_set_badblocks(rdev, addr, s, 0)=
) {
> +                               if (!rdev_set_badblocks(rdev, addr, s, 0)=
 ||
> +                                   (repl &&
> +                                   !rdev_set_badblocks(repl, addr, s, 0)=
)) {

Do we really want this in the if () statement? Shall we always set
badblock on both rdev and repl?

Thanks,
Song

>                                         /* just abort the recovery */
>                                         pr_notice("md/raid10:%s: recovery=
 aborted due to read error\n",
>                                                   mdname(mddev));
> --
> 2.39.2
>
