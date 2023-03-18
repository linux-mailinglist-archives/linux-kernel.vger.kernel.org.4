Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A446BF8BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCRH6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCRH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:58:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7972D34C2D;
        Sat, 18 Mar 2023 00:58:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w9so28650366edc.3;
        Sat, 18 Mar 2023 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679126305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9kflyUcTWOTgsVwiqFTEkSUTt2K/ujv6iGh8wMMvAQ=;
        b=l8plMcCPzCZtCNBthUUK+41tDhVCAYgiH4aDsOcZpsnNoPr7C/IrE8GTOruwU897mZ
         JaFzYC1xuFQbMuOgq1+bng+0aR36hJWmPqLSFhmKuyOTBudmLiXxMFYXnwI7FqBkc0C/
         KijF8RsXZAnLuJNiYSZc3jjb1GsMOa3S4OuebkTMfdl14Nf2n+jgP6I0ts0jkMeR3Je6
         Qu5DXuVxIdUyOGz1tjqXbgSIwXHtwHblbzl6RD0Eb/yJSHYCABe5+OjPiUng6ZFyP3j8
         0PtPN7vtg6WQNAUlLzoNUBhwEl7KO+/nkOQIPGoSqM7aAr2o9PLP5/SQseXuUYl6tPZk
         dmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9kflyUcTWOTgsVwiqFTEkSUTt2K/ujv6iGh8wMMvAQ=;
        b=VTeEWEhVeIZapaznsyBEV818z9sxpINHDPt9sAKsz03ms7qTGLZTI7ZZQtU/kb1IJm
         mlZuf6LiNVvK4fNrVdBcuoFoijJTXqJ0f3ZtGxk0yEROm1zVC7yiR0AmJf6jf+C5R/Yh
         wuUnmre+RgijdN577iGf5o7/5raV4Gweuq19rj5I+QuPnquWSMX/8BdMmZ2JRQdeu0h3
         aaWP9lzBqjAf3Y5MEtm4DV8n35WBSTFSLSQOG/O+UlRIOczEvnWikKYd1FjqJBS9O+Xg
         vJ6lzm6sy4835p3YyTdW1PnmTTgXvGI9yhplSsAeNntOTYDte/sliMJBDW23YhMWWBN5
         5AIg==
X-Gm-Message-State: AO0yUKXX26/0N+KRxKcQ25AqPa2JkjlaBw04E8nKkSZHSfM9MZEx9EZq
        QhEl0VHtii6o+H25AKWSUyA=
X-Google-Smtp-Source: AK7set/+wd8GvkU+GWt8EQFwAYDXiruK5Y/G5wh4Q6eZzERrvFCmP2DEItDmgOokh3JCyB3Wf3+HYQ==
X-Received: by 2002:a17:906:4c8b:b0:8b1:3131:76e9 with SMTP id q11-20020a1709064c8b00b008b1313176e9mr2597465eju.46.1679126304867;
        Sat, 18 Mar 2023 00:58:24 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00933356c681esm374615eji.150.2023.03.18.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 00:58:24 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mtd: Drop unneeded quotes
Date:   Sat, 18 Mar 2023 08:58:22 +0100
Message-ID: <2275127.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230317233631.3968509-1-robh@kernel.org>
References: <20230317233631.3968509-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 18. marec 2023 ob 00:36:30 CET je Rob Herring napisal(a):
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml     | 2 +-

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  .../devicetree/bindings/mtd/arasan,nand-controller.yaml       | 2 +-
>  .../devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml          | 2 +-
>  Documentation/devicetree/bindings/mtd/gpmi-nand.yaml          | 2 +-
>  Documentation/devicetree/bindings/mtd/intel,lgm-ebunand.yaml  | 2 +-
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml      | 2 +-
>  Documentation/devicetree/bindings/mtd/mtd-physmap.yaml        | 2 +-
>  Documentation/devicetree/bindings/mtd/mxc-nand.yaml           | 2 +-
>  Documentation/devicetree/bindings/mtd/nand-chip.yaml          | 2 +-
>  Documentation/devicetree/bindings/mtd/nand-controller.yaml    | 2 +-
>  .../bindings/mtd/partitions/brcm,bcm4908-partitions.yaml      | 2 +-
>  .../bindings/mtd/partitions/linksys,ns-partitions.yaml        | 2 +-
>  Documentation/devicetree/bindings/mtd/qcom,nandc.yaml         | 2 +-
>  Documentation/devicetree/bindings/mtd/renesas-nandc.yaml      | 2 +-
>  .../devicetree/bindings/mtd/rockchip,nand-controller.yaml     | 2 +-
>  Documentation/devicetree/bindings/mtd/spi-nand.yaml           | 2 +-
>  Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml | 2 +-
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml       | 4 ++--
>  Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml    | 4 ++--
>  19 files changed, 21 insertions(+), 21 deletions(-)



