Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684145BBB3C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIRDOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIRDOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:14:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6413F49
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 198D0B808BE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0795C433B5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663470845;
        bh=Y9FHsBbI7CNPRKhfCvmq4BIFyaa1dC1WylWyfszKy4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZC6AiZl5zbZmsPoTnRaHmLCF1K78RvN57gFeZD5Y5OkFRyZAHUfVqlnpG8um7Ki+x
         F45/ngOd69C83qSsvfYTYNT4KW14z0TjlLFYKazYzR/10J4aAUDPBVDXP2Z0cTCpoG
         +rMmYxW4FuFOHZxC+gaLtnWwZAvEcpiWhSxoHP5UX6JZnm08osBXBUie2qPh7bL0YC
         ZaF/mrOeRPZreA4aWSMadtG4XkPlEK//6Bkt5C8p1zugh7LmSeFFoyiBO/7y1d6bqn
         84IxB2F8jNDnIfb9r4OoZAnLpQwQ/5eiXcIfvpErNgcJr0RfpeRM2fOHfbNJq+tkfJ
         u0ZPG5n0lySgw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-12c8312131fso7334087fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:14:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo20QxPfZiGt3HWBTN9nRkH1n+b2fuo9UyhWDPoQ8PUSY7rXOyBJ
        Hkwa3dRaXAYhLjDPV+4S7X/ClqJrzXh8SBYSCg==
X-Google-Smtp-Source: AA6agR4cU7YVJerUEM7KKKNcBT86A+GPNcDzuOehKm1I3RQK4reVXmD7SmAQEHy95VJ9wK0JduW2mWCcc1rx+Wpm70A=
X-Received: by 2002:a05:6871:96:b0:11d:ca1b:db19 with SMTP id
 u22-20020a056871009600b0011dca1bdb19mr12989922oaa.74.1663470844989; Sat, 17
 Sep 2022 20:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133821.27980-1-rex-bc.chen@mediatek.com> <20220916133821.27980-4-rex-bc.chen@mediatek.com>
In-Reply-To: <20220916133821.27980-4-rex-bc.chen@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 18 Sep 2022 11:13:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Q=yiDMA8UrkaCKDEpxf=KwZtr-sJ+na5Qtuk4kqPY3A@mail.gmail.com>
Message-ID: <CAAOTY_9Q=yiDMA8UrkaCKDEpxf=KwZtr-sJ+na5Qtuk4kqPY3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/mediatek: dp: Fix warning in mtk_dp_video_mute()
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jitao Shi <jitao.shi@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, liangxu.xu@mediatek.com,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

Bo-Chen Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E6=99=9A=E4=B8=8A9:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Warning:
> ../drivers/gpu/drm/mediatek/mtk_dp.c: In function =E2=80=98mtk_dp_video_m=
ute=E2=80=99:
> ../drivers/gpu/drm/mediatek/mtk_dp.c:947:23: warning: format =E2=80=98%x=
=E2=80=99
> expects argument of type =E2=80=98unsigned int=E2=80=99, but argument 4 h=
as type =E2=80=98long
> unsigned int=E2=80=99 [-Wformat=3D]
>   947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\=
n",
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> ../include/linux/dev_printk.h:129:27: note: in definition of macro =E2=80=
=98dev_printk=E2=80=99
>   129 |   _dev_printk(level, dev, fmt, ##__VA_ARGS__);  \
>       |                           ^~~
> ../include/linux/dev_printk.h:163:31: note: in expansion of macro =E2=80=
=98dev_fmt=E2=80=99
>   163 |   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
>       |                               ^~~~~~~
> ../drivers/gpu/drm/mediatek/mtk_dp.c:947:2: note: in expansion of
> macro =E2=80=98dev_dbg=E2=80=99
>   947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\=
n",
>       |  ^~~~~~~
> ../drivers/gpu/drm/mediatek/mtk_dp.c:947:36: note: format string is defin=
ed here
>   947 |  dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\=
n",
>       |                                   ~^
>       |                                    |
>       |                                    unsigned int
>       |                                   %lx
>
> To fix this issue, we use %s to replace 0x%x.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort drive=
r")
> Reported-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index c72c646e25e9..d58e98b2f83a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1222,8 +1222,8 @@ static void mtk_dp_video_mute(struct mtk_dp *mtk_dp=
, bool enable)
>                       mtk_dp->data->smc_cmd, enable,
>                       0, 0, 0, 0, 0, &res);
>
> -       dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-0x%lx\n=
",
> -               mtk_dp->data->smc_cmd, enable, res.a0, res.a1);
> +       dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: %s, ret: 0x%lx-0x%lx\n",
> +               mtk_dp->data->smc_cmd, enable ? "enable" : "disable", res=
.a0, res.a1);
>  }
>
>  static void mtk_dp_audio_mute(struct mtk_dp *mtk_dp, bool mute)
> --
> 2.18.0
>
