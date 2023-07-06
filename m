Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37132749A38
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGFLGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGFLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:06:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F882DC;
        Thu,  6 Jul 2023 04:06:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B3B1480;
        Thu,  6 Jul 2023 04:07:12 -0700 (PDT)
Received: from [10.57.27.160] (unknown [10.57.27.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21363F663;
        Thu,  6 Jul 2023 04:06:26 -0700 (PDT)
Message-ID: <49ef52b7-0269-898c-7cc2-096f2f1037fc@arm.com>
Date:   Thu, 6 Jul 2023 12:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: remove arm, primecell-periphid at
 etm nodes
Content-Language: en-GB
To:     Lucas Stach <l.stach@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Li <Frank.Li@nxp.com>
References: <20230705205954.4159781-1-Frank.Li@nxp.com>
 <9405224.NyiUUSuA9g@steina-w>
 <0125c54fd1617f3f945bc3f4bbef5b914b701c24.camel@pengutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0125c54fd1617f3f945bc3f4bbef5b914b701c24.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-06 09:23, Lucas Stach wrote:
> Hi Alexander,
> 
> Am Donnerstag, dem 06.07.2023 um 07:06 +0200 schrieb Alexander Stein:
>> Hi Frank,
>>
>> Am Mittwoch, 5. Juli 2023, 22:59:53 CEST schrieb Frank Li:
>>> The reg size of etm nodes is incorrectly set to 64k instead of 4k. This
>>> leads to a crash when calling amba_read_periphid().  After corrected reg
>>> size, amba_read_periphid() retrieve the correct periphid.
>>> arm,primecell-periphid were removed from the etm nodes.
>>
>> So this means the reference manual is wrong here? It clearly states the size
>> is 64kiB. Reference Manual i.MX8MP Rev 1. 06/2021
>> On a side note: Is imx8mq affected by this as well? The DAP memory table lists
>> similar sizes in the RM .
>>
> Note that the 64K MMIO space per device is really an alignment thing.
> It's a recommendation from ARM to allow individual device MMIO regions
> to be mapped on kernels with 64K page size. Most of the time the real
> MMIO space occupied by the device is actually much smaller than 64K.

Indeed, it's quite common for TRM memory maps to be written in terms of 
the interconnect configuration, i.e. from the point of view of the 
interconnect itself, that whole range of address space is assigned to 
that peripheral, and it may even be true that the entire range is routed 
to the port where that peripheral is connected. However what's of more 
interest for DT is how much of that range the peripheral itself actually 
decodes.

Robin.

> 
> Regards,
> Lucas
> 
>> Best regards,
>> Alexander
>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
>>> cc406bb338fe..e0ca82ff6f15 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> @@ -306,8 +306,7 @@ soc: soc@0 {
>>>
>>>   		etm0: etm@28440000 {
>>>   			compatible = "arm,coresight-etm4x",
>> "arm,primecell";
>>> -			reg = <0x28440000 0x10000>;
>>> -			arm,primecell-periphid = <0xbb95d>;
>>> +			reg = <0x28440000 0x1000>;
>>>   			cpu = <&A53_0>;
>>>   			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>>>   			clock-names = "apb_pclk";
>>> @@ -323,8 +322,7 @@ etm0_out_port: endpoint {
>>>
>>>   		etm1: etm@28540000 {
>>>   			compatible = "arm,coresight-etm4x",
>> "arm,primecell";
>>> -			reg = <0x28540000 0x10000>;
>>> -			arm,primecell-periphid = <0xbb95d>;
>>> +			reg = <0x28540000 0x1000>;
>>>   			cpu = <&A53_1>;
>>>   			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>>>   			clock-names = "apb_pclk";
>>> @@ -340,8 +338,7 @@ etm1_out_port: endpoint {
>>>
>>>   		etm2: etm@28640000 {
>>>   			compatible = "arm,coresight-etm4x",
>> "arm,primecell";
>>> -			reg = <0x28640000 0x10000>;
>>> -			arm,primecell-periphid = <0xbb95d>;
>>> +			reg = <0x28640000 0x1000>;
>>>   			cpu = <&A53_2>;
>>>   			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>>>   			clock-names = "apb_pclk";
>>> @@ -357,8 +354,7 @@ etm2_out_port: endpoint {
>>>
>>>   		etm3: etm@28740000 {
>>>   			compatible = "arm,coresight-etm4x",
>> "arm,primecell";
>>> -			reg = <0x28740000 0x10000>;
>>> -			arm,primecell-periphid = <0xbb95d>;
>>> +			reg = <0x28740000 0x1000>;
>>>   			cpu = <&A53_3>;
>>>   			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
>>>   			clock-names = "apb_pclk";
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
