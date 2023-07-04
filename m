Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D774752B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGDPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:20:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E69FDBD;
        Tue,  4 Jul 2023 08:20:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25D831576;
        Tue,  4 Jul 2023 08:21:04 -0700 (PDT)
Received: from [10.57.34.139] (unknown [10.57.34.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0DCF3F73F;
        Tue,  4 Jul 2023 08:20:19 -0700 (PDT)
Message-ID: <33362029-3d5b-b16a-27e7-578df34f0ede@arm.com>
Date:   Tue, 4 Jul 2023 16:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: Add coresight trace components
To:     Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     coresight@lists.linaro.org
References: <20230505195151.1874071-1-Frank.Li@nxp.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230505195151.1874071-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 20:51, Frank Li wrote:
> Add coresight trace components (ETM, ETF, ETB and Funnel).
> 
> ┌───────┐  ┌───────┐  ┌───────┐
> │ CPU0  ├─►│ ETM0  ├─►│       │
> └───────┘  └───────┘  │       │
>                        │       │
> ┌───────┐  ┌───────┐  │  ATP  │
> │ CPU1  ├─►│ ETM1  ├─►│       │
> └───────┘  └───────┘  │       │
>                        │ FUNNEL│
> ┌───────┐  ┌───────┐  │       │
> │ CPU2  ├─►│ ETM2  ├─►│       │
> └───────┘  └───────┘  │       │   ┌─────┐  ┌─────┐
>                        │       │   │     │  │     │
> ┌───────┐  ┌───────┐  │       │   │ M7  │  │ DSP │
> │ CPU3  ├─►│ ETM3  ├─►│       │   │     │  │     │
> └───────┘  └───────┘  └───┬───┘   └──┬──┘  └──┬──┘               AXI
>                            │          │        │                   ▲
>                            ▼          ▼        ▼                   │
>                        ┌───────────────────────────┐   ┌─────┐   ┌─┴──┐
>                        │          ATP FUNNEL       ├──►│ETF  ├─► │ETR │
>                        └───────────────────────────┘   └─────┘   └────┘
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 179 ++++++++++++++++++++++
>   1 file changed, 179 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index a19224fe1a6a..0fa74477b9e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -304,6 +304,185 @@ soc: soc@0 {
>   		nvmem-cells = <&imx8mp_uid>;
>   		nvmem-cell-names = "soc_unique_id";
>   
> +		etm0: etm@28440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0x28440000 0x10000>;
> +			arm,primecell-periphid = <0xbb95d>;

Why is this needed (and for all the ETMs) ?

Suzuki

