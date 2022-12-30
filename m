Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7191D659613
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiL3IGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiL3IGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:06:47 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5D1570C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:06:46 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id p30so15000655vsr.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQdcqRijxUkHsak+jAfhkkvLukBS0vcYzdFtrdyXflw=;
        b=hJrOI48JiYR65s9nCvSCbLB6/evML3aOoc6h+o+f3sjNM430ssdY4mTfsfoOuqiE77
         SfnNNqM26q/P0n106if0Zu2bwW9SvUE5hjv4D9piG3JN02D1FVQl65JpTXlhhT0mEDhD
         lf0+C7oAiy61ZM+ycfbYEnO9A6aiVYZIH5934=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQdcqRijxUkHsak+jAfhkkvLukBS0vcYzdFtrdyXflw=;
        b=eoDTToS0NVRQcOfnk+Gp5H1LY2DnBIUbdKJUyDHXdnYxt+RrgvNRrXusNzC511bkyW
         tQ568B6lKNyZuBSe2l3Adn4/3PnfIMS5vi8CszTAMDuljMTD8L99qCaIiF2xDsHR16Gk
         /5iThP6Q8pyTgueEjh8OZEY14oSQNL/h6Sl+WLKgYcWiOhVo6Mn6/Kt/5AuCMxtNeeBd
         U79YSkZdztyWONDc+FvC1ZqCIh+X3PCTRHvcefd46Q5Ft2MH0viWj0Loyq30/73mFZul
         AHVjq/0SqM+4Zi7KntmwkB2+0JxBX/NCYZkw4bpkT1g60upwiyIHp7+KboZqiOQuGQrE
         2yAQ==
X-Gm-Message-State: AFqh2kokr1m/6gHv4QMnuCg6URN1/Ru+IWmFtK+pEJr3sFP8dNcnjKDx
        zTN55aEFTy/mc5cMoNP+6D71x4VtndwRHTqL/Wb4RA==
X-Google-Smtp-Source: AMrXdXtUtwb9Xd2cX7zaHUb5ee4VgtB+nh99Dg/x/skgVf2ZCGUYciWzd1E+Ypz1KXO3wscCEMwAn2Ze8MjLtrhpUfM=
X-Received: by 2002:a05:6102:74b:b0:3ad:3d65:22b with SMTP id
 v11-20020a056102074b00b003ad3d65022bmr4417228vsg.65.1672387606063; Fri, 30
 Dec 2022 00:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com> <20221223094259.87373-16-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221223094259.87373-16-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:06:35 +0800
Message-ID: <CAGXv+5H9FqFeng+dev2A-W6FPuWvVuLMgSgVcubwE7NLCy58pw@mail.gmail.com>
Subject: Re: [PATCH v2 15/23] clk: mediatek: mt8192: Join top_adj_divs and top_muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> These two are both mtk_composite arrays, one dependent on another, but
> that's something that the clock framework is supposed to sort out and
> anyway registering them separately isn't going to ease the framework's
> job in checking dependencies.
>
> Put the contents of top_adj_divs in top_muxes to join them together
> and register them in one shot.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/clk-mt8192.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index ec9dc7fe848e..702770326286 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -698,9 +698,7 @@ static struct mtk_composite top_muxes[] = {
>         MUX(CLK_TOP_APLL_I2S7_M_SEL, "apll_i2s7_m_sel", apll_i2s_m_parents, 0x320, 23, 1),
>         MUX(CLK_TOP_APLL_I2S8_M_SEL, "apll_i2s8_m_sel", apll_i2s_m_parents, 0x320, 24, 1),
>         MUX(CLK_TOP_APLL_I2S9_M_SEL, "apll_i2s9_m_sel", apll_i2s_m_parents, 0x320, 25, 1),
> -};
> -
> -static const struct mtk_composite top_adj_divs[] = {
> +       /* APLL_DIV */

This would be CLK_AUDDIV_2 ~ 4 actually. 4 dividers per register.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
