Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7696FD79C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjEJG6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbjEJG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:58:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E05C7693;
        Tue,  9 May 2023 23:57:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (softbank126090219015.bbtec.net [126.90.219.15])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51741547;
        Wed, 10 May 2023 08:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683701868;
        bh=7+/BXts4qDsEHDqAfZ4l9gAHxpVe8kPgSlt0NSiOyS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuFbFpEjeSeT1D11a6LOhy8cDMe1K7vQ3ZdSTFa1t8ccFPGCVNsxqRwX29xlc9skO
         4tHZoar+ch28sXVYQDZtAdQ1HoMDkst2B1GmVicdY1xi87LpB0BjFE9n26B5RR7fZx
         NW1jzJODc3OUdPJ2c/b+bAVZ+b7fZzz16rT7+4Sk=
Date:   Wed, 10 May 2023 09:57:50 +0300
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
Message-ID: <20230510065750.GD11711@pendragon.ideasonboard.com>
References: <cover.1683034376.git.michal.simek@amd.com>
 <cf4ced33cb7dc8d43b79bb9d4ad6acd3b8ecc09b.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf4ced33cb7dc8d43b79bb9d4ad6acd3b8ecc09b.1683034376.git.michal.simek@amd.com>
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

Thank you for the patch.

On Tue, May 02, 2023 at 03:35:33PM +0200, Michal Simek wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
> CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
> node and let each CPU point to it.

The commit message should focus on how this change brings the DT in line
with the hardware, not on what the Linux kernel does.

> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index bb0d0be30aa0..c2d80c7967e9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -33,6 +33,7 @@ cpu0: cpu@0 {
>  			operating-points-v2 = <&cpu_opp_table>;
>  			reg = <0x0>;
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -42,6 +43,7 @@ cpu1: cpu@1 {
>  			reg = <0x1>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>  		};
>  
>  		cpu2: cpu@2 {
> @@ -51,6 +53,7 @@ cpu2: cpu@2 {
>  			reg = <0x2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
>  		};
>  
>  		cpu3: cpu@3 {
> @@ -60,6 +63,12 @@ cpu3: cpu@3 {
>  			reg = <0x3>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		L2: l2-cache {

Shouldn't labels be lower-case ?

> +			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		idle-states {

-- 
Regards,

Laurent Pinchart
