Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584255B63FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiILXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiILXS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2BE4D4C3;
        Mon, 12 Sep 2022 16:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D4A61248;
        Mon, 12 Sep 2022 23:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8FDC433D6;
        Mon, 12 Sep 2022 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663024736;
        bh=Cbxm+wScoYOf9uPveDUFKU8DcvePcdgz86AWflGIWGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rvTMuQ7WeoupNppQh23rMin98zJBenTTh0ffkK+vAqBMaNLE4c3BzIakEvwtytdTA
         zcFFV8BbKHNLWAnAEwG4o6mYHbTnzD8r+6TIc3Jtz8aS3S68BRvkIuSIZWRX0to0SQ
         orZAAg64mcK9WhsBrPW7i3PyHosRp13pm9ouNzxRhF4B5sF6sZdTQoiPaTr7A6HIpd
         h/XBvDcW7OPYMf73P3PGafLlm+/TLf/b045wwxLeFUhZ+8xcuG2LoLX6CQiFxQ24L2
         J5h91f5jmTXwzBtnKBaq7HAmlrhOvhtIC5x6wjWHGeDgc1An/6BW8XgjlxRxqIND5+
         3Humv28P1fyGQ==
Received: by mail-ot1-f51.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso6931073otb.6;
        Mon, 12 Sep 2022 16:18:56 -0700 (PDT)
X-Gm-Message-State: ACgBeo2vmfbXRwUfpMTcxUlwfUrTrsZmooe1uLWIY4MpBt/2IcbAdGBt
        4V5Pur7OyS2vWQZFwVaq4T3y4ReUqTKpQKFWhw==
X-Google-Smtp-Source: AA6agR55s+Nptinq02WALbixXv8dp5IISYyISRrmH3F234MXAeWMGzIeiugX1fRAbtZ5vhUEAsCawoybA9uXwAw5ejc=
X-Received: by 2002:a05:6830:6999:b0:61d:26f8:94c1 with SMTP id
 cy25-20020a056830699900b0061d26f894c1mr11827454otb.278.1663024735220; Mon, 12
 Sep 2022 16:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220908141205.18256-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220908141205.18256-1-allen-kh.cheng@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 13 Sep 2022 07:18:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9=cNCLhvCAEnPsw3Y4iBE=g9aTS+QLZXDVZH8N3cj+xQ@mail.gmail.com>
Message-ID: <CAAOTY_9=cNCLhvCAEnPsw3Y4iBE=g9aTS+QLZXDVZH8N3cj+xQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix wrong dither settings
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
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

Hi, Allen:

Allen-KH Cheng <allen-kh.cheng@mediatek.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A10:12=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> The width and height arguments in the cmdq packet for mtk_dither_config()
> are inverted. We fix the incorrect width and height for dither settings
> in mtk_dither_config().

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 73d3724745db ("drm/mediatek: Adjust to the alphabetic order for me=
diatek-drm")
> Co-developed-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 2d72cc5ddaba..6b6d5335c834 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -157,7 +157,7 @@ static void mtk_dither_config(struct device *dev, uns=
igned int w,
>  {
>         struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
>
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,=
 DISP_REG_DITHER_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,=
 DISP_REG_DITHER_SIZE);
>         mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv-=
>regs,
>                       DISP_REG_DITHER_CFG);
>         mtk_dither_set_common(priv->regs, &priv->cmdq_reg, bpc, DISP_REG_=
DITHER_CFG,
> --
> 2.18.0
>
