Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1676692089
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjBJOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjBJOJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C887405C;
        Fri, 10 Feb 2023 06:09:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D125E66020E9;
        Fri, 10 Feb 2023 14:09:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676038171;
        bh=pFrTCC7DRf148QSpFOVkQrb6mUMqtPZiFny6QHbySyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jHl0QRG/yGbw9Gzc6p6UkO4OcCuobFrTlhyYDOZzWJeQt8KPhwVDMQe5ZMvbHjdit
         9qCVu4bwO3u6mPt+hWtHvKyr7CeeSDvCfV7mnQbLL3OZQW6UnMj3IsmCIdaBK6E2mh
         1jFe0FOYU/lTlhZ+96OGQZtC9+3EizLpFwU8Nakp3MYHAvK94t7GsxME1YAO17b3AV
         HLmk53qxhfo7VpkEbDVNmT4EYQAr8udfiJb31tprcoDltn9ysJa6KhJtwcOWurUZ6n
         f8BEcB5QkfBbuaTQPhDN/bI8WYdyEA8QtQK8fh0d4f5gg9Q+o/c9xSvEUb+RC9skg8
         DJXOSUPerRdZw==
Message-ID: <db22c545-da11-9869-ef20-31d5a7a33318@collabora.com>
Date:   Fri, 10 Feb 2023 15:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 12/12] arm64: dts: mediatek: mt8195: Add SCP 2nd core
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230210085931.8941-1-tinghan.shen@mediatek.com>
 <20230210085931.8941-13-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230210085931.8941-13-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/23 09:59, Tinghan Shen ha scritto:
> Rewrite the MT8195 SCP device node as a cluster and
> add the SCP 2nd core in it.
> 
> Since the SCP device node is changed to multi-core structure,
> enable SCP cluster to enable probing SCP core 0.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |  4 +++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 30 ++++++++++++++-----
>   2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 56749cfe7c33..4f9bc7581adb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -933,6 +933,10 @@
>   	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>   };
>   
> +&scp_cluster {
> +	status = "okay";
> +};
> +
>   &scp {
>   	status = "okay";
>   
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 8f1264d5290b..87e49f5fb7b3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -826,14 +826,30 @@
>   			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
>   		};
>   
> -		scp: scp@10500000 {
> -			compatible = "mediatek,mt8195-scp";
> -			reg = <0 0x10500000 0 0x100000>,
> -			      <0 0x10720000 0 0xe0000>,
> -			      <0 0x10700000 0 0x8000>;
> -			reg-names = "sram", "cfg", "l1tcm";
> -			interrupts = <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH 0>;
> +		scp_cluster: scp@10500000 {
> +			compatible = "mediatek,mt8195-scp-dual";
> +			reg = <0 0x10720000 0 0xe0000>, <0 0x10700000 0 0x8000>;
> +			reg-names = "cfg", "l1tcm";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x10500000 0x100000>;
>   			status = "disabled";
> +
> +			scp: scp@0 {

Minor nit: Please change this to `scp_c0:`.
Like that, we keep consistency and increase readability, as we're clearly then
reading that one node is for core 0, the other is for core 1.

This is fine even on devices using only a single SCP core, because in devicetree
we are describing the hardware, not the software implemetation of it - and the
MT8195 SoC does, by hardware, have two SCP cores anyway :-)

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


