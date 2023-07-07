Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78274ACE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjGGI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGGI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74121BF0;
        Fri,  7 Jul 2023 01:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31610618A0;
        Fri,  7 Jul 2023 08:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9318CC433CA;
        Fri,  7 Jul 2023 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688718479;
        bh=/iMTveEZljwI52ZgRhzAV3MJbhOZeyccgkmJqsyS8YE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aI1YoY01SDjOdgitZwrSRiZWNOTQkAnU6ml4/KwFwNBUsHLUaMI+b5Ux/izMOsaOV
         U9cMExCoLKws5B7v4T5x+fs9OKsY+MLopWdwUgbGPPtk9sgrO8jFHj3qdSzVmfH2qh
         zvYYctwngFpqn+hbISe+KFy65pGisGSEmD0Sxw17gKYTPRTM2+FPXd7aCyPbCRIR18
         XwVyqgG7adZFW9awjv7XvYBrc+2jjHq3v09KUf3lFgr0DCtbVsQrieTK2A3dRKZi2C
         QXNEyQ6aOrenHVxE6mocDAYPbyHno3PImOVFIwE6hh7uYFlx/vfKBrgOBnel8j9xOL
         a04U3EmHDhfYQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso2519833e87.0;
        Fri, 07 Jul 2023 01:27:59 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ5wPUayZafVkYM8/08GvmdXypOdX9t6f+v0JW/XoL7wc1Pn8Ys
        oKSm5zCsFvtyX8tXOQSi2vB+e94icEWC1juV74g=
X-Google-Smtp-Source: APBJJlGL3fSpvVkBbl0Ya71Bb0Fg8XyhXiCunqnfu3VBHNGClDcDXc2vFXNpdP5hh/q43YiuixwngBDo8FsB1mRxMY0=
X-Received: by 2002:ac2:5b9d:0:b0:4fb:9fa7:dcda with SMTP id
 o29-20020ac25b9d000000b004fb9fa7dcdamr3183778lfn.26.1688718477551; Fri, 07
 Jul 2023 01:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230627034127.4000994-1-linan666@huaweicloud.com> <20230627034127.4000994-2-linan666@huaweicloud.com>
In-Reply-To: <20230627034127.4000994-2-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 16:27:45 +0800
X-Gmail-Original-Message-ID: <CAPhsuW65svKXS4GDL6-tuFOEhEwst+0aLd-NA1_gf2LiOuKr_A@mail.gmail.com>
Message-ID: <CAPhsuW65svKXS4GDL6-tuFOEhEwst+0aLd-NA1_gf2LiOuKr_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] md/raid10: a simple cleanup for fix_recovery_read_error
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

On Tue, Jun 27, 2023 at 11:42=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> There is no need to use a new variable 'rdev2' for write device since
> 'rdev' is not used again later. Use 'rdev' directly. Assigning return
> value to 'ok' is also unnecessary. Clean it up.

I actually think rdev2 here makes the code easier to read. And the
'ok' variable doesn't hurt the code readability either.

Thanks,
Song

>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/raid10.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..5105273f60e9 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2590,10 +2590,9 @@ static void fix_recovery_read_error(struct r10bio =
*r10_bio)
>
>                         if (rdev !=3D conf->mirrors[dw].rdev) {
>                                 /* need bad block on destination too */
> -                               struct md_rdev *rdev2 =3D conf->mirrors[d=
w].rdev;
> +                               rdev =3D conf->mirrors[dw].rdev;
>                                 addr =3D r10_bio->devs[1].addr + sect;
> -                               ok =3D rdev_set_badblocks(rdev2, addr, s,=
 0);
> -                               if (!ok) {
> +                               if (!rdev_set_badblocks(rdev, addr, s, 0)=
) {
>                                         /* just abort the recovery */
>                                         pr_notice("md/raid10:%s: recovery=
 aborted due to read error\n",
>                                                   mdname(mddev));
> --
> 2.39.2
>
