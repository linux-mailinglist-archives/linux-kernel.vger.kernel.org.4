Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6A6C70A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCWTBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCWTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:01:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870F32CE4;
        Thu, 23 Mar 2023 12:01:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so1978194wmr.4;
        Thu, 23 Mar 2023 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679598098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLv+OdWP2/q4icqUygxqdKy5WVqm1CK1qz/X+1uMQ6s=;
        b=cu5m+OlbboTOC7NIqSEcp8iW3kmX+jLP0i9ZshSDb0YwwsjhG1UnGQihGdnCsHvzxT
         E5fzMruGiyGXORVsaVQVBbyi7036u7U5L4qTaq5l56LuyOE9nazVT64HJCGkSLuVN93r
         1B4AKbmo7E/IH5irUJwFpldHtDZ0+Orn/pNa9BAq9838vXVb3y7SkxG89vediufY01gv
         iT/xH+JDL/vm8bbKhZUAcxrvBAsVgYJLNDWRSp5CWvQ6mQIAPqudwQWWgSduywYWAvd6
         ICah9KqPXqaujDhUvMUhzr0TOCO/Cv+vmxBx11QIL752t6GbzmIoKJBQf+QxYLTe/Kgd
         cVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLv+OdWP2/q4icqUygxqdKy5WVqm1CK1qz/X+1uMQ6s=;
        b=C6Hsij6utfA9CyJc46hfE7y/t5sMaQZCIkKIKHk1/bFyVl6wgRW1hVJJI0NTciOwyh
         lLEbJci/8xIWLT8N2PluipkbxjECeH2S10PhFYG+e9iiZbuNtngqOT0jr4dy/tJRTeN7
         +e3NS/2va/OvnKiW+Q64UoE6LavQ/Ym8mbQd+sT1XLJpxfJCtJDhCEUaHw4Ba6oqfwWj
         sigV0rPS+37Q8HW8gz6WC7BN6qjkUifdxrlysrc8qJBRedO4NJnGTYXt4fKaAahDYAXE
         FvqnkXCBV/wQrH/db5DupseVbjapukblrtrXuL2ZE0Q1NpMaCXKgDvJns8DjhMmIY55W
         YZ5w==
X-Gm-Message-State: AO0yUKW+l5licVpScYAPpG4bpB4txIuktVJuR1EXI1bIKmhILeUVJ16y
        24PkFNW6DnAi9XOg0kDPC5M=
X-Google-Smtp-Source: AK7set+rYnmeyHLDI8kRSWajUorF8AQNiBslvOhL1B8d1ZJbljrj8VFTESbYvCOCBRF9m/MSyyRPaw==
X-Received: by 2002:a05:600c:22d4:b0:3ed:b56c:9496 with SMTP id 20-20020a05600c22d400b003edb56c9496mr523314wmg.31.1679598097756;
        Thu, 23 Mar 2023 12:01:37 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x11-20020a05600c21cb00b003ede3e54ed7sm2724420wmj.6.2023.03.23.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:01:37 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: Drop unneeded quotes
Date:   Thu, 23 Mar 2023 20:01:34 +0100
Message-ID: <4814446.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230320233955.2921179-1-robh@kernel.org>
References: <20230320233955.2921179-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 21. marec 2023 ob 00:39:52 CET je Rob Herring napisal(a):
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml          | 4 ++--
>  .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 2 +-

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  .../devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml      | 4 ++--
>  .../bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml         | 4 ++--
>  .../devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml      | 4 ++--
>  .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml | 4 ++--
>  .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml    | 4 ++--
>  .../devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml     | 4 ++--
>  .../devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml | 4 ++--
>  .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml   | 4 ++--
>  .../devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml      | 4 ++--
>  Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml    | 4 ++--
>  Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml   | 4 ++--
>  .../devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml      | 4 ++--
>  .../devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml      | 6 +++---
>  .../bindings/phy/marvell,armada-3700-utmi-phy.yaml          | 4 ++--
>  .../bindings/phy/marvell,armada-cp110-utmi-phy.yaml         | 4 ++--
>  .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml      | 4 ++--
>  .../devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml    | 4 ++--
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml         | 4 ++--
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 4 ++--
>  Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml | 4 ++--
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml     | 4 ++--
>  Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml   | 4 ++--
>  Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml | 4 ++--
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml     | 4 ++--
>  Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml      | 4 ++--
>  .../devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml       | 4 ++--
>  .../devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml    | 4 ++--
>  Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml  | 2 +-
>  .../devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml    | 4 ++--
>  .../devicetree/bindings/phy/ti,phy-am654-serdes.yaml        | 4 ++--
>  Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml  | 4 ++--
>  Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 4 ++--
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml  | 4 ++--
>  35 files changed, 69 insertions(+), 69 deletions(-)



