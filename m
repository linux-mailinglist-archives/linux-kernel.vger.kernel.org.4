Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA3678A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjAWWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:04:21 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531EE4489;
        Mon, 23 Jan 2023 14:04:20 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r9so11651174oie.13;
        Mon, 23 Jan 2023 14:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpuxLyhBst2nOzeGBnZjMCF3/gd2HElPUlYwXSvlCHQ=;
        b=XAWPeFQnPUi/8xV8vvsULRen/GOjlpqCCvHxp7gzmIeJpVhrh9aa9YoeZmDHK0qpPg
         HVNzeLdfOgw0WnapElD5P6LvtHHgzzFOcatOVL+h0eKlUhJWVK0m5lMGS5TXhFMesnj2
         RDIIAzX/28cDoOz/m7gaLBXWrMMhuuEN7/+m7xe7EXuGwXl7Bhou081oyx0U6+IqX7Xi
         kNTKXOraT0++Cj0Spn9x+Va6zbJEJZ866ldezDoVvbXEimJphvRpMzBFNEplUkNJQMqt
         zlZZDR5PiU1X/MvuiPoHIj7bBcvUg9tD97+rD32iOsFqcRWjR8OY0UM6Ciaz8k1QnXex
         7Jag==
X-Gm-Message-State: AFqh2krY/D04ECzlDbmnqxQctZBsLMgPJB0vVraF9b6MOhJXCpm+acEW
        sRkhpYXH39kOGSNEqhrE9w==
X-Google-Smtp-Source: AMrXdXvgQ12re4a3YxVwTSF0Qz/NX5WxqeUHb2/GhWU5TZhVunu5BYf8mwhHnwtYWmXTwGSj1UfgUA==
X-Received: by 2002:aca:b882:0:b0:35e:d30c:e918 with SMTP id i124-20020acab882000000b0035ed30ce918mr10351484oif.39.1674511459544;
        Mon, 23 Jan 2023 14:04:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j88-20020a9d17e1000000b00684ccbfe012sm184800otj.27.2023.01.23.14.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:04:19 -0800 (PST)
Received: (nullmailer pid 2719397 invoked by uid 1000);
        Mon, 23 Jan 2023 22:04:17 -0000
Date:   Mon, 23 Jan 2023 16:04:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Steen Hegelund <Steen.Hegelund@microchip.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        ", Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        UNGLinuxDriver@microchip.com, linux-tegra@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "linux-rockchip@lists.infradead.org , Tony Huang" 
        <tonyhuang.sunplus@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-actions@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Li-hao Kuo <lhjeff911@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: drop unneeded quotes
Message-ID: <167451145691.2719339.9543782878107648705.robh@kernel.org>
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 09:57:21 +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |  2 +-
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |  2 +-
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |  6 ++--
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 22 ++++++------
>  .../bindings/mmc/fsl-imx-esdhc.yaml           |  4 +--
>  .../devicetree/bindings/mmc/fsl-imx-mmc.yaml  |  2 +-
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        |  4 +--
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  2 +-
>  .../devicetree/bindings/mmc/mxs-mmc.yaml      |  2 +-
>  .../bindings/mmc/nvidia,tegra20-sdhci.yaml    | 36 +++++++++----------
>  .../devicetree/bindings/mmc/owl-mmc.yaml      |  2 +-
>  .../bindings/mmc/renesas,mmcif.yaml           |  2 +-
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  6 ++--
>  .../bindings/mmc/rockchip-dw-mshc.yaml        |  2 +-
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml  |  2 +-
>  .../bindings/mmc/synopsys-dw-mshc-common.yaml |  2 +-
>  17 files changed, 50 insertions(+), 50 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
