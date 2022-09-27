Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E05EC4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiI0Nkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiI0Nkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:40:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB66639BA1;
        Tue, 27 Sep 2022 06:40:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D23086602265;
        Tue, 27 Sep 2022 14:40:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664286045;
        bh=l0r0ZaX9YZdqDz2RvEUsZ5NEBzsjJi9GrROUQaXEGsQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PJE93JHEO7cWrmml9ztx3rkOfFWah/FwdZGzTfwUIQ2w7hQSt++Kt8QMso/okg+gJ
         bU35vtHR0wFh8Lni+XwK8+VKqwEelaZex29NnvukvV3iTYn0XzguZq/v4LTKhyINVv
         mQhq041uL42occFBaGzGJCm/sVnRhFmudSliD1DF0k0kig/AbPS6+3YZ5VE6iPdFO8
         Msy4Fn8M2FAaAFa/lEV/aTzwJAPPwhDqfCDYoCsRE7i9HlDR96yiUSAvIpH4CqqDI4
         4/xqVfOI0tHIgLreg0030IY4Em5y5iSM4KrBL19bylYxu4kLPNPGyhgh/shBIvP9YF
         mT4XwODwKfkZg==
Message-ID: <6f1deed3-87e5-6d73-74b7-f5123c7f4362@collabora.com>
Date:   Tue, 27 Sep 2022 15:40:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/5] arm64: dts: mt8186: Add IOMMU and SMI nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
 <20220923131148.6678-4-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220923131148.6678-4-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/22 15:11, Allen-KH Cheng ha scritto:
> Add iommu and smi nodes for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 173 +++++++++++++++++++++++
>   1 file changed, 173 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 833e7037fe22..68f06bef88f3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/clock/mt8186-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/memory/mt8186-memory-port.h>
>   #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
>   #include <dt-bindings/power/mt8186-power.h>
>   #include <dt-bindings/phy/phy.h>
> @@ -944,24 +945,113 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		smi_common: smi@14002000 {
> +			compatible = "mediatek,mt8186-smi-common";
> +			reg = <0 0x14002000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_GALS>, <&mmsys CLK_MM_SMI_GALS>;
> +			clock-names = "apb", "smi", "gals0", "gals1";
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		larb0: smi@14003000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,larb-id = <0>;
> +			mediatek,smi = <&smi_common>;

Order by name after reg please...

compatible
reg
clocks
clock-names
mediatek,larb-id
mediatek,smi
power-domains

> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		larb1: smi@14004000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,larb-id = <1>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		iommu_mm: iommu@14016000 {
> +			compatible = "mediatek,mt8186-iommu-mm";
> +			reg = <0 0x14016000 0 0x1000>;
> +			mediatek,larbs = <&larb0 &larb1 &larb2 &larb4
> +					  &larb7 &larb8 &larb9 &larb11
> +					  &larb13 &larb14 &larb16 &larb17
> +					  &larb19 &larb20>;
> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_SMI_IOMMU>;
> +			clock-names = "bclk";

clocks
clock-names
interrupts
mediatek,larbs
power-domains

...etc :-)

P.S.: Same comment for the other commits, too!

Regards,
Angelo


