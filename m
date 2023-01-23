Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB25678759
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjAWUPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjAWUPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:15:13 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168D303FD;
        Mon, 23 Jan 2023 12:15:10 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15bb8ec196aso15343000fac.3;
        Mon, 23 Jan 2023 12:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9JOc294Un2/0rB0FUKryYqic16naXseJPC92bOtRF0=;
        b=TFugDuwwVpBY+jJEIKbuxoYP7oCrGmKv3g0a/mKEIbywee4wXzlEDUp/YtL6T7tq8x
         wVRrbGRjfJpgvEg/KSKgiBCBY2wWJDalnkPNEgkX1wpObPkZj/z/dkGM0QsUg5DuX6bd
         jYIn67roGkkX2NvuRDe3r7rzRTzzKQ4IIFCvL9gcyWvrCGtZrQn0gufEx27YJ9gios6m
         qw6yzBZiF/6xAWYHUB4Zohir4HbiUL46oNTT77vzYOp1CPijvF/TWMEqEqYmG48XyBpc
         iIMwkfToRVETERnnTAff6w6gnQ1GvIyvgrlzvTmfg1N/y99ZJGzEO2eF7zE3myzFvFl8
         3nFg==
X-Gm-Message-State: AFqh2kqOphnNSGO+vqzbfqVC/4874+l4TeWg1aiTTKPGkghyjmnqaWCz
        6psyhaQjoh6AQ0jWRZKa3A==
X-Google-Smtp-Source: AMrXdXv7/0UWYAVSm7F28zXqx2erH3WvlYts86KO/fBElTBfrToCx8V4nVQwijpoo96jnpY39d8zVA==
X-Received: by 2002:a05:6871:4506:b0:154:988a:d32d with SMTP id nj6-20020a056871450600b00154988ad32dmr14480326oab.27.1674504910165;
        Mon, 23 Jan 2023 12:15:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b10-20020a056870390a00b001435fe636f2sm25818920oap.53.2023.01.23.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:15:09 -0800 (PST)
Received: (nullmailer pid 2450508 invoked by uid 1000);
        Mon, 23 Jan 2023 20:15:07 -0000
Date:   Mon, 23 Jan 2023 14:15:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Bert Vermeulen <bert@biot.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        =?UTF-8?B?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Samuel Holland <samuel@sholland.org>,
        linux-rockchip@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>, linux-sunxi@lists.linux.dev,
        Palmer Dabbelt <palmer@dabbelt.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Han Xu <han.xu@nxp.com>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-riscv@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        openbmc@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-aspeed@lists.ozlabs.org,
        Parshuram Thombare <pthombar@cadence.com>,
        linux-amlogic@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-tegra@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
Message-ID: <167450490674.2450465.12158974323906034097.robh@kernel.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 18:39:31 +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
>  .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
>  .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---
>  .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml |  2 +-
>  .../devicetree/bindings/spi/cdns,xspi.yaml     |  6 +++---
>  .../bindings/spi/fsl,spi-fsl-qspi.yaml         |  2 +-
>  .../devicetree/bindings/spi/fsl-imx-cspi.yaml  |  2 +-
>  .../bindings/spi/mediatek,spi-mt65xx.yaml      |  2 +-
>  .../spi/mediatek,spi-slave-mt27xx.yaml         |  2 +-
>  .../bindings/spi/mikrotik,rb4xx-spi.yaml       |  2 +-
>  .../bindings/spi/mxicy,mx25f0a-spi.yaml        |  2 +-
>  .../devicetree/bindings/spi/mxs-spi.yaml       |  2 +-
>  .../bindings/spi/nvidia,tegra210-quad.yaml     |  2 +-
>  .../bindings/spi/qcom,spi-qcom-qspi.yaml       |  5 ++---
>  .../bindings/spi/realtek,rtl-spi.yaml          |  2 +-
>  .../bindings/spi/snps,dw-apb-ssi.yaml          |  2 +-
>  .../devicetree/bindings/spi/spi-cadence.yaml   |  2 +-
>  .../devicetree/bindings/spi/spi-fsl-lpspi.yaml |  2 +-
>  .../devicetree/bindings/spi/spi-gpio.yaml      |  4 ++--
>  .../devicetree/bindings/spi/spi-mux.yaml       |  4 ++--
>  .../devicetree/bindings/spi/spi-nxp-fspi.yaml  |  2 +-
>  .../devicetree/bindings/spi/spi-pl022.yaml     | 18 +++++++++---------
>  .../devicetree/bindings/spi/spi-rockchip.yaml  |  2 +-
>  .../devicetree/bindings/spi/spi-sifive.yaml    |  6 +++---
>  .../bindings/spi/spi-sunplus-sp7021.yaml       |  2 +-
>  .../devicetree/bindings/spi/spi-xilinx.yaml    |  2 +-
>  .../bindings/spi/spi-zynqmp-qspi.yaml          |  2 +-
>  .../devicetree/bindings/spi/sprd,spi-adi.yaml  |  5 ++---
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml |  2 +-
>  .../devicetree/bindings/spi/st,stm32-spi.yaml  |  2 +-
>  .../bindings/spi/xlnx,zynq-qspi.yaml           |  2 +-
>  33 files changed, 53 insertions(+), 55 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
