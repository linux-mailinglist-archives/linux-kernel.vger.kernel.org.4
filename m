Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276167BC09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbjAYUFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjAYUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:05:45 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810CB12587;
        Wed, 25 Jan 2023 12:05:43 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-15b9c93848dso22813893fac.1;
        Wed, 25 Jan 2023 12:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kqCnvG5HfBYMdFzmIrllsGYjZVwDWefqF05Cmky4HA=;
        b=1MkdHccN4sTH4t9xBZvyUQIxoYOq7j8fZzdGNnazpcF2mE85RiQc+0HFSP1Z/3DKYS
         WnIb0QEc4RdWG7FAw0qbFSsXDZ4+cdo45vccV7EDix/1G4+hKJ4kgikaoUfV5SE+FbKM
         X+ALhCtuuwtE+QlexxVkbkhd5lOVr3PED0pDep9hs0Gm94/DVYEnW4XINdP6GDm9co/q
         9scVxhpfpOADKuIe6EchvP4EjwDM4tqzgGAJSwjA/oEiZA6qmNhdief8rcSc8kJdV9pv
         3lq5+h28KgV2C/kVO0K9hc8rYCvHxMoaqqFD2DdS2r3v3MJAkGxsSNF15sT012OVOVg4
         sBVg==
X-Gm-Message-State: AO0yUKUD5ZeFxQsUh/9oHbyjsD9L9fqTzkpbEq6ZlOwuB1mr7ICd3rNx
        W2JLtY3BMbx45vM3aVctOQ==
X-Google-Smtp-Source: AK7set+KlYA9hOhKxY3yXbw1+jJFui+axb/K8qUGpNYSrXD6fL93Qjufe/ZRHNh9bIxZbHxYbUPr4A==
X-Received: by 2002:a05:6870:14d5:b0:163:45a2:e276 with SMTP id l21-20020a05687014d500b0016345a2e276mr684576oab.9.1674677142691;
        Wed, 25 Jan 2023 12:05:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n20-20020a056870559400b0010d7242b623sm2325869oao.21.2023.01.25.12.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:05:42 -0800 (PST)
Received: (nullmailer pid 2768672 invoked by uid 1000);
        Wed, 25 Jan 2023 20:05:39 -0000
Date:   Wed, 25 Jan 2023 14:05:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-sunxi@lists.linux.dev, openbmc@lists.ozlabs.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Li-hao Kuo <lhjeff911@gmail.com>, Han Xu <han.xu@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        ", Bert Vermeulen" <bert@biot.com>, Marek Vasut <marex@denx.de>,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        ", Christophe Kerello" <christophe.kerello@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-msm@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        ", Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-spi@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        linux-riscv@lists.infradead.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-aspeed@lists.ozlabs.org, Gabor Juhos <juhosg@openwrt.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>,
        ", Fabio Estevam" <festevam@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
Message-ID: <167467713905.2768614.7865748447151198568.robh@kernel.org>
References: <20230124083342.34869-1-krzysztof.kozlowski@linaro.org>
 <20230124083342.34869-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124083342.34869-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 09:33:42 +0100, Krzysztof Kozlowski wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - drop redundant blank lines,
>  - use lowercase hex.
> 
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au> # aspeed
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # meson
> 
> ---
> 
> Changes since v1:
> 1. Adjust indentation in two more examples (cdns,qspi-nor, st,stm32-spi)
> 2. Add tags
> ---
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
>  .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
>  .../bindings/spi/cdns,qspi-nor.yaml           |  34 ++--
>  .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
>  .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
>  .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
>  .../devicetree/bindings/spi/st,stm32-spi.yaml |  23 ++-
>  10 files changed, 176 insertions(+), 178 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
