Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD86BE561
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCQJTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCQJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:19:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED415566;
        Fri, 17 Mar 2023 02:19:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BFEE6603062;
        Fri, 17 Mar 2023 09:18:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679044738;
        bh=cFTcgO/jwZqd6gFedmY0z01cOUn9ANPFQ2AN0eTUm84=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MiYYaeMYXeXZr1HxSIxXXxI8B+D0AaHxVsROVVWhtRYHeXZmTo1HZd5KF8fJYjWiJ
         yUYoWyaTs5h5F8Vkiljq656/pkM7EwsKaUj/8C8AtFPx+P3t5IT1a3p+ygy8ovYUzc
         DilF/5B1neWt2s0rkj2fo1uVn2toY+xo3p+pDqxpqwpKGRtJSq0nfoflsNH7+qxPqY
         qiPrTYFWkduHu1ipEVs/jU7OKljPMnJGagvw1O/8//PLhwUherwavGLsiymr+EXPt2
         BeIva06NkDfQMLcjLOaT/6frebbnq2A8CfStkxBOvmm5RQzZFUV7YWNKySzwIcY14x
         dRo9zr1immHVw==
Message-ID: <baa1dbbc-14a7-d9fb-33f0-d5f22b32282a@collabora.com>
Date:   Fri, 17 Mar 2023 10:18:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 7/7] arm64: dts: mediatek: mt8186: Add display nodes
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20230317060917.15175-1-allen-kh.cheng@mediatek.com>
 <20230317060917.15175-8-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317060917.15175-8-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/23 07:09, Allen-KH Cheng ha scritto:
> Add display nodes and the GCE (Global Command Engine) properties
> to the display nodes in order to enable the usage of the CMDQ
> (Command Queue), which is required for operating the display.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 125 +++++++++++++++++++++++
>   1 file changed, 125 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index b9d5af26771e..29fb970e174e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -20,6 +20,13 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	aliases {
> +		ovl0 = &ovl0;
> +		ovl_2l0 = &ovl_2l0;
> +		rdma0 = &rdma0;
> +		rdma1 = &rdma1;
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> @@ -1251,6 +1258,20 @@
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
>   			#reset-cells = <1>;
> +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST>;

Fits in one line.

> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
> +		};
> +
> +		mutex: mutex@14001000 {
> +			compatible = "mediatek,mt8186-disp-mutex";
> +			reg = <0 0x14001000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
> +			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
> +			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
> +					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>   		};
>   
>   		smi_common: smi@14002000 {
> @@ -1284,6 +1305,49 @@
>   			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
>   		};
>   
> +		ovl0: ovl@14005000 {
> +			compatible = "mediatek,mt8186-disp-ovl",
> +				     "mediatek,mt8192-disp-ovl";

Fits in one line.

> +			reg = <0 0x14005000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0>;
> +			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu_mm IOMMU_PORT_L0_OVL_RDMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		ovl_2l0: ovl@14006000 {
> +			compatible = "mediatek,mt8186-disp-ovl-2l",
> +				     "mediatek,mt8192-disp-ovl-2l";

Same

> +			reg = <0 0x14006000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
> +			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu_mm IOMMU_PORT_L1_OVL_2L_RDMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		rdma0: rdma@14007000 {
> +			compatible = "mediatek,mt8186-disp-rdma",
> +				     "mediatek,mt8183-disp-rdma";

ditto

> +			reg = <0 0x14007000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH 0>;
> +			iommus = <&iommu_mm IOMMU_PORT_L1_DISP_RDMA0>;
> +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x7000 0x1000>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		color: color@14009000 {
> +			compatible = "mediatek,mt8186-disp-color",
> +				     "mediatek,mt8173-disp-color";

again.... and again, and again, and again :-)

Please compress the compatible strings in one single line here and in other
instances of the same (ccorr/aal/gamma/dither/rdma). Postmask doesn't fit.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


