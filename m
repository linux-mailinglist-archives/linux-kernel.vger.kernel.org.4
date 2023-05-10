Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286996FDCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjEJLeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjEJLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:34:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82503E7E;
        Wed, 10 May 2023 04:34:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 55CBD800;
        Wed, 10 May 2023 13:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683718449;
        bh=sGzDOPmvFTFpaZnjXkMm5j+0zPDP9TPOfOzpGzfrYOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAOIjyAKxGEhIXFc0Vm5J1h3CJYRriNKSp9hg8g91jLEqSVPTXqVemw9HnaGYs6S0
         S4lSp09bDr3kA8haX8vulsIOBjl+8hKZWxABVqJecLaFqprll8SO7GhoVsd8TCbFtI
         l3+z1hP8jP2iIFVh4RdJVjTWez4LjSrI2PnhhCrE=
Date:   Wed, 10 May 2023 14:34:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/23] arm64: zynqmp: Add L2 cache nodes
Message-ID: <20230510113412.GJ11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <cf4ced33cb7dc8d43b79bb9d4ad6acd3b8ecc09b.1683034376.git.michal.simek@amd.com>
 <20230510065750.GD11711@pendragon.ideasonboard.com>
 <9da13d84-b6f0-e606-6467-a545bc308c12@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9da13d84-b6f0-e606-6467-a545bc308c12@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, May 10, 2023 at 09:15:30AM +0200, Michal Simek wrote:
> On 5/10/23 08:57, Laurent Pinchart wrote:
> > On Tue, May 02, 2023 at 03:35:33PM +0200, Michal Simek wrote:
> >> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> >>
> >> Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
> >> CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
> >> node and let each CPU point to it.
> > 
> > The commit message should focus on how this change brings the DT in line
> > with the hardware, not on what the Linux kernel does.
> 
> ok.
> 
> >> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> index bb0d0be30aa0..c2d80c7967e9 100644
> >> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >> @@ -33,6 +33,7 @@ cpu0: cpu@0 {
> >>   			operating-points-v2 = <&cpu_opp_table>;
> >>   			reg = <0x0>;
> >>   			cpu-idle-states = <&CPU_SLEEP_0>;
> >> +			next-level-cache = <&L2>;
> >>   		};
> >>   
> >>   		cpu1: cpu@1 {
> >> @@ -42,6 +43,7 @@ cpu1: cpu@1 {
> >>   			reg = <0x1>;
> >>   			operating-points-v2 = <&cpu_opp_table>;
> >>   			cpu-idle-states = <&CPU_SLEEP_0>;
> >> +			next-level-cache = <&L2>;
> >>   		};
> >>   
> >>   		cpu2: cpu@2 {
> >> @@ -51,6 +53,7 @@ cpu2: cpu@2 {
> >>   			reg = <0x2>;
> >>   			operating-points-v2 = <&cpu_opp_table>;
> >>   			cpu-idle-states = <&CPU_SLEEP_0>;
> >> +			next-level-cache = <&L2>;
> >>   		};
> >>   
> >>   		cpu3: cpu@3 {
> >> @@ -60,6 +63,12 @@ cpu3: cpu@3 {
> >>   			reg = <0x3>;
> >>   			operating-points-v2 = <&cpu_opp_table>;
> >>   			cpu-idle-states = <&CPU_SLEEP_0>;
> >> +			next-level-cache = <&L2>;
> >> +		};
> >> +
> >> +		L2: l2-cache {
> > 
> > Shouldn't labels be lower-case ?
> 
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:220:        L2_0: 
> l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:241: 
> L2_100: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:257: 
> L2_200: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:273: 
> L2_300: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:289: 
> L2_400: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:305: 
> L2_500: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:321: 
> L2_600: l2-cache {
> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:337: 
> L2_700: l2-cache {
> Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml:116: 
> L2_0: l2-cache {
> Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml:151: 
> L2_1: l2-cache {
> Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml:77: 
>               L2_0: l2-cache {
> 
> And in dt spec - 6.2 chapter uppercase letter is valid chars for DTS labels.

Thanks for the clarification. It's all good.

-- 
Regards,

Laurent Pinchart
