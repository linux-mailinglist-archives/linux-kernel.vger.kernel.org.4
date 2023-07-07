Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A974AC6F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGGICR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9DA1B6;
        Fri,  7 Jul 2023 01:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9910D617C5;
        Fri,  7 Jul 2023 08:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DFC433C8;
        Fri,  7 Jul 2023 08:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688716935;
        bh=XbeilgU8Ic2ceNjEbWhib7f0IugPG6YZI+tOX8MQnMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TJ3D1PGrl8gxvouFNW7jXtCYUmSkxMheFtdm3PHfjozbf2S0D0+fMn+lLvrmwc4Tb
         nAtwMwEs2UTAVX7/3qDnEfR4S+btxOwryQJtfpOKRJEddpkGa9ItWTA5p3SpjnY21Y
         tBAlFi0vFFgzNgpN+Xmk5LfkWGBUHTYII4k91FBgkR9C0iBNodESRdZR2gFYxd35WH
         oiIumACWachmH7jYAtEUOdstWn6o9uyVZq6GYNlykeq9l7vFZx6D7OdrgCqL1W6i0Z
         0sFiv7DsOxJrsflJ2HtghCXPsOsr8G64KflgKn9ErhrUtO8rR2W2Rr/DvFb1a955z/
         UWf8uKeLCeVOQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so24001091fa.2;
        Fri, 07 Jul 2023 01:02:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLa4vIkUAN8NCoeD+moem8Il8x6nOdmv3s34dgjEy2f9S5G66/iS
        ouea8RyMIwd1RA+N8K+roORodWJDc0sX9ocsHtM=
X-Google-Smtp-Source: APBJJlG457VU/NsI9QcteOdHwIAM4v4Gfzi0F6Q6DGjEs80P1F7aLcEogNYB1k8ba8WZoUAxZjpR3lcCpTE4jLyM21M=
X-Received: by 2002:a2e:9011:0:b0:2b6:e0b5:b76d with SMTP id
 h17-20020a2e9011000000b002b6e0b5b76dmr3791293ljg.45.1688716932998; Fri, 07
 Jul 2023 01:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230627014332.3810102-1-linan666@huaweicloud.com>
In-Reply-To: <20230627014332.3810102-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 16:01:59 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5cO4q+XZm=XwKzG6Npot5m5T5ECtWaXuOLU-d5st3boA@mail.gmail.com>
Message-ID: <CAPhsuW5cO4q+XZm=XwKzG6Npot5m5T5ECtWaXuOLU-d5st3boA@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid1: prioritize adding disk to 'removed' mirror
To:     linan666@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
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

On Tue, Jun 27, 2023 at 9:44=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> New disk should be added to "removed" position first instead of to be a
> replacement. Commit 6090368abcb4 ("md/raid10: prioritize adding disk to
> 'removed' mirror") has fixed this issue for raid10. Fix it for raid1 now.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next. Thanks!

Song

> ---
> Changes in v2:
>  - improve commit log.
>
>  drivers/md/raid1.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 68a9e2d9985b..320bede4bfab 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1782,7 +1782,7 @@ static int raid1_add_disk(struct mddev *mddev, stru=
ct md_rdev *rdev)
>  {
>         struct r1conf *conf =3D mddev->private;
>         int err =3D -EEXIST;
> -       int mirror =3D 0;
> +       int mirror =3D 0, repl_slot =3D -1;
>         struct raid1_info *p;
>         int first =3D 0;
>         int last =3D conf->raid_disks - 1;
> @@ -1825,17 +1825,21 @@ static int raid1_add_disk(struct mddev *mddev, st=
ruct md_rdev *rdev)
>                         break;
>                 }
>                 if (test_bit(WantReplacement, &p->rdev->flags) &&
> -                   p[conf->raid_disks].rdev =3D=3D NULL) {
> -                       /* Add this device as a replacement */
> -                       clear_bit(In_sync, &rdev->flags);
> -                       set_bit(Replacement, &rdev->flags);
> -                       rdev->raid_disk =3D mirror;
> -                       err =3D 0;
> -                       conf->fullsync =3D 1;
> -                       rcu_assign_pointer(p[conf->raid_disks].rdev, rdev=
);
> -                       break;
> -               }
> +                   p[conf->raid_disks].rdev =3D=3D NULL && repl_slot < 0=
)
> +                       repl_slot =3D mirror;
>         }
> +
> +       if (err && repl_slot >=3D 0) {
> +               /* Add this device as a replacement */
> +               p =3D conf->mirrors + repl_slot;
> +               clear_bit(In_sync, &rdev->flags);
> +               set_bit(Replacement, &rdev->flags);
> +               rdev->raid_disk =3D repl_slot;
> +               err =3D 0;
> +               conf->fullsync =3D 1;
> +               rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
> +       }
> +
>         print_conf(conf);
>         return err;
>  }
> --
> 2.39.2
>
