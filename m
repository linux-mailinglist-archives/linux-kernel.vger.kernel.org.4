Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14006909F0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBIN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjBIN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:28:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F0425EBFF;
        Thu,  9 Feb 2023 05:28:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464641477;
        Thu,  9 Feb 2023 05:29:15 -0800 (PST)
Received: from [192.168.1.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B500B3F703;
        Thu,  9 Feb 2023 05:28:31 -0800 (PST)
Message-ID: <ff471140-5bbb-fb64-f000-eb7ba97dd74e@arm.com>
Date:   Thu, 9 Feb 2023 13:28:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: layerscape: Fix GICv3 ITS node names
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230208183437.2283665-1-robh@kernel.org>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230208183437.2283665-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-08 18:34, Rob Herring wrote:
> The GICv3 ITS is an MSI controller, therefore its node name should be
> 'msi-controller'.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that this exposes an issue that #msi-cells is missing. In turn, the
> use of msi-parent in PCI nodes is wrong and should be msi-map according
> to my sources (Robin M), but I have no idea what is correct there.

This is a funny one, since AIUI those "msi-parent" properties are now 
really only there for the bootloader to pick up the phandle to build a 
proper "msi-map" property[1][2]. As such, I imagine it should *probably* 
be OK to add a dummy argument so that "#msi-cells = <1>" can be 
correctly specified, however I can't claim to be an expert on these 
systems and whether there are any other bootloader behaviours that also 
need to be supported.

Thanks,
Robin.

[1] 
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/net/fsl-mc/mc.c#L328
[2] 
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_layerscape_fixup.c

>   arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
>   arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 1b33cabb4e14..dd1c8f60fad1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -131,7 +131,7 @@ gic: interrupt-controller@6000000 {
>   		interrupt-controller;
>   		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
>   					 IRQ_TYPE_LEVEL_LOW)>;
> -		its: gic-its@6020000 {
> +		its: msi-controller@6020000 {
>   			compatible = "arm,gic-v3-its";
>   			msi-controller;
>   			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 260d045dbd9a..6dd680fb1b22 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -123,7 +123,7 @@ gic: interrupt-controller@6000000 {
>   		#size-cells = <2>;
>   		ranges;
>   
> -		its: gic-its@6020000 {
> +		its: msi-controller@6020000 {
>   			compatible = "arm,gic-v3-its";
>   			msi-controller;
>   			reg = <0x0 0x6020000 0 0x20000>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 348d9e3a9125..d2f5345d0560 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -60,7 +60,7 @@ gic: interrupt-controller@6000000 {
>   		interrupt-controller;
>   		interrupts = <1 9 0x4>;
>   
> -		its: gic-its@6020000 {
> +		its: msi-controller@6020000 {
>   			compatible = "arm,gic-v3-its";
>   			msi-controller;
>   			reg = <0x0 0x6020000 0 0x20000>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 50c19e8405d5..ea6a94b57aeb 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -395,7 +395,7 @@ gic: interrupt-controller@6000000 {
>   		interrupt-controller;
>   		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   
> -		its: gic-its@6020000 {
> +		its: msi-controller@6020000 {
>   			compatible = "arm,gic-v3-its";
>   			msi-controller;
>   			reg = <0x0 0x6020000 0 0x20000>;
