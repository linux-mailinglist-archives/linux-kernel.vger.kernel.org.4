Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BC963EFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiLALpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiLALpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:45:09 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750ACA0579
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:45:07 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 128so1262439vsz.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE/q8OTGX/vukPXHLJF5f0ZobL7IbidYs5xkC1/4Glo=;
        b=EzvNjsK/64biWBOqAzlM7ZmFo/qswGF8E2psYeSj0xdD6287yOJeqmtxtWiDCeeRne
         HLae+HG1stNZu59moUdMxeVYOQDp9sfWFNA6V3VypSXCAVupelhw74Ch1etHO5XDWI0m
         ybBlh0c2Z/irb2/MSL4MDBPlinBeHrffEoJ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE/q8OTGX/vukPXHLJF5f0ZobL7IbidYs5xkC1/4Glo=;
        b=6CNjBzd2uXBXxzpykE19RF8z1v8T/5elGcgpUsIU1wUur1/zz5FCqobSKJmV1jJTtn
         jnM30P7oSMzF/dW6yqxbB4nRbtk3YpsaBfPC80C+lmdVmbitGSGDMQn4Rk+byQIN8Psx
         UVg/s1eI84McSd4KX58p05uJxehgro0uq0RscvW9DHhG2S0n5nBC4jdZKmu3tWCpO4me
         ZbKoMgW0B9+Lit4yyXul0KY4rLajmED5JERh5U2KVMAfi50rouzpFzsG8kC6qcWg+RaP
         HuBdICNBfVLyu+KoQnLh71wrCRfSLRN/wlQWpcmMf40dw4lkz3wYjxAs3WURFUF/om49
         KO1Q==
X-Gm-Message-State: ANoB5ple/l8VoSVu4XoBv6n1BuQA/t+TQ5+o9fL67TGGsreTxqpX5FDZ
        /hjG3qcDe0uyiVVWMJ3d80cQ6AhlcKgEBr/GDGHBYw==
X-Google-Smtp-Source: AA0mqf4u5I2OZaSiq21veOJJ1DavEQccozE6Z/lEVW/v7HrTmm4H19hg9RZ5yAmVKH9lnRtk1UUPSAMKL03w0XsTCgg=
X-Received: by 2002:a67:c98e:0:b0:3ad:3d65:22b with SMTP id
 y14-20020a67c98e000000b003ad3d65022bmr28646035vsk.65.1669895106580; Thu, 01
 Dec 2022 03:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20221107072243.15748-1-nancy.lin@mediatek.com> <20221107072243.15748-6-nancy.lin@mediatek.com>
In-Reply-To: <20221107072243.15748-6-nancy.lin@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 19:44:55 +0800
Message-ID: <CAGXv+5Hj-H6Q3N+j2tEntd9M=9p0o7TxWYn_4aawhqFUbX7+PQ@mail.gmail.com>
Subject: Re: [PATCH v28 05/11] soc: mediatek: refine code to use
 mtk_mmsys_update_bits API
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        nfraprado@collabora.com, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        singo.chang@mediatek.com, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 3:23 PM Nancy.Lin <nancy.lin@mediatek.com> wrote:
>
> Simplify code for update  mmsys reg.
>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-mmsys.c | 45 ++++++++++++--------------------
>  1 file changed, 16 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 9a327eb5d9d7..73c8bd27e6ae 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c

[...]

> @@ -124,27 +129,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>  {
>         struct mtk_mmsys *mmsys =3D dev_get_drvdata(dev);
>         const struct mtk_mmsys_routes *routes =3D mmsys->data->routes;
> -       u32 reg;
>         int i;
>
>         for (i =3D 0; i < mmsys->data->num_routes; i++)
> -               if (cur =3D=3D routes[i].from_comp && next =3D=3D routes[=
i].to_comp) {
> -                       reg =3D readl_relaxed(mmsys->regs + routes[i].add=
r);
> -                       reg &=3D ~routes[i].mask;
> -                       writel_relaxed(reg, mmsys->regs + routes[i].addr)=
;
> -               }
> +               if (cur =3D=3D routes[i].from_comp && next =3D=3D routes[=
i].to_comp)
> +                       mtk_mmsys_update_bits(mmsys, routes[i].addr, rout=
es[i].mask, 0);
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>
> -static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u=
32 mask, u32 val)
> -{
> -       u32 tmp;
> -
> -       tmp =3D readl_relaxed(mmsys->regs + offset);
> -       tmp =3D (tmp & ~mask) | val;
> -       writel_relaxed(tmp, mmsys->regs + offset);
> -}
> -
>  void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
>  {
>         if (val)

This hunk now doesn't apply due to

    soc: mediatek: Add all settings to mtk_mmsys_ddp_dpi_fmt_config func

touching mtk_mmsys_ddp_dpi_fmt_config() as well. It's trivial to resolve
though.

ChenYu
