Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5036FFE11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjELAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjELAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 20:40:10 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3BF59ED
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:40:08 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-780bb3b96e0so4401949241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683852008; x=1686444008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH4ppR/YImqXRCtEui/eyufHAaFxL08S2yugceeQpQw=;
        b=aUcCBc3nacUromPCYUcTOUffpMJtnLw224rrn4TS6Bcw/VWfT1LggqJ1FJ16Eefj3R
         Epw0k+jGFP1KZt2HLS8D204u5xiUqSVKTVq+scEZovCd4mdI0XKHTHnJVtEY6/oONSDH
         2qiPekrL4qh6monUKwvmU6uhhq7jN9ycdfBRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683852008; x=1686444008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH4ppR/YImqXRCtEui/eyufHAaFxL08S2yugceeQpQw=;
        b=c3nam1BzOVT1xmkKEO4dagAD20wqS/FKmM1eDzexarFSbyvJGnPn2nxjs+TnYQk4Bc
         UwoVpMPyRnVigwMgA3RnKzwK7e04QUs6n1YORLOo+ZKnqiJWccqWsabrwK+stntcJEQ2
         YoJU+iDDXARSjjTvUfTzpe6Chs6BI4izZHbegvYffEZCLrpu8bc7cknA98hqBC3hbg/A
         T9cY9VivhFbdxcc6NEE7uOArICJcqITrfc1UEElRdEB8jo1DX9PyrySCMcDtoJhhOafd
         q54Yd3/4nqpbgQx072dIYwi1Vw5xdAud/S3/BknajdEQ1AG7H05K3Fqs+XwWINLdg189
         pU5g==
X-Gm-Message-State: AC+VfDwzUesTDC2TEdsRJGdc4mP6Cp12QYvdMSV5eJr66vbqgHZfOoSK
        /csZVRieyK+PKetZEqd8qPIQK7gw8wzGDdHigj2OOQ==
X-Google-Smtp-Source: ACHHUZ7CJRLkBoOoXB2ebsy/eMzziU9dqHDjIi6dtiQ/z9qVxlIHckT/so67HALGLdwGNm/ISSZScafI9Zz3gusQTLs=
X-Received: by 2002:a1f:5f46:0:b0:440:8b67:dba6 with SMTP id
 t67-20020a1f5f46000000b004408b67dba6mr9468363vkb.4.1683852007778; Thu, 11 May
 2023 17:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230509021214.17105-1-gehao@kylinos.cn>
In-Reply-To: <20230509021214.17105-1-gehao@kylinos.cn>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 12 May 2023 09:39:56 +0900
Message-ID: <CAGXv+5Gvw0QsOa-7E==61WUiJ-q=9qAqN9E0L9hsmk+t12RJ9A@mail.gmail.com>
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: use devm_of_iomap to
 avoid resource leak in clk_mt8173_apmixed_probe
To:     Hao Ge <gehao@kylinos.cn>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, gehao618@163.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 11:12=E2=80=AFAM Hao Ge <gehao@kylinos.cn> wrote:
>
> Use devm_platform_ioremap_resource to take the place of of_iomap for
> avoid that we don't called iounmap when return some error or remove
> device.
>
> Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and=
 allow module build")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8173-apmixedsys.c
> index 8c2aa8b0f39e..8a2a88c63d15 100644
> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> @@ -146,8 +146,8 @@ static int clk_mt8173_apmixed_probe(struct platform_d=
evice *pdev)
>         struct clk_hw *hw;
>         int r;
>
> -       base =3D of_iomap(node, 0);
> -       if (!base)
> +       base =3D devm_of_iomap(&pdev->dev, node, 0, NULL);
> +       if (IS_ERR(base))

From lib/devres.c:

 * Please Note: This is not a one-to-one replacement for of_iomap() because=
 the
 * of_iomap() function does not track whether the region is already mapped.=
  If
 * two drivers try to map the same memory, the of_iomap() function will suc=
ceed
 * but the devm_of_iomap() function will return -EBUSY.

The register range for apmixedsys given in mt8173.dtsi overlaps with
the HDMI phy. I'm concerned that would cause issues.

ChenYu

>                 return PTR_ERR(base);
>
>         clk_data =3D mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
