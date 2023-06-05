Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391A17224E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjFELtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjFELth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:49:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F320DE9;
        Mon,  5 Jun 2023 04:49:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355BnPM4122948;
        Mon, 5 Jun 2023 06:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685965765;
        bh=KmeppYSzjhnTpjhlknmqIYVjpLAg8iwCiN9kkzil5Po=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rzuBFDvxGTklZPQbUA+EnMHCnO893f+FUUw6RdIgpejH9a28MfrB8bKluQ5i/3lG1
         LZjNazZ28TbsYR2r74qR/pCavB30IruTdTPMvvaAlSEZMJzh98WHLgfzQMsx2iBcA+
         LUeFo9KB0dnysXCSzOCs3N8HP1OV+1Tew3j6IGmk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355BnPLN000485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 06:49:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 06:49:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 06:49:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355BnO2n029775;
        Mon, 5 Jun 2023 06:49:24 -0500
Date:   Mon, 5 Jun 2023 06:49:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Change CPTS clock parent
Message-ID: <20230605114924.56ccpd6rvddnr463@undying>
References: <20230605110443.84568-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230605110443.84568-1-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:34-20230605, Neha Malcom Francis wrote:
> MAIN_PLL0 has a flag set in DM (Device Manager) that removes it's
> capability to re-initialise clock frequencies. CPTS and RGMII has
> MAIN_PLL3 as their parent which does not have this flag. While RGMII
> needs this reinitialisation to default frequency to be able to get
> 250MHz with its divider, CPTS can not get its required 200MHz with its
> divider. Thus, move CPTS clock parent on J721S2 from MAIN_PLL3_HSDIV1 to
> MAIN_PLL0_HSDIV6.
> 
> (Note: even GTC will be moved from MAIN_PLL3 to MAIN_PLL0 in U-Boot side
> for the same reason)
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 2 ++
>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 ++


Is this the only device with this change? or are we doing that across
the board? if so, could you please do this in a single series so that we
don't have a mix?

>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> index 2dd7865f7654..331e0c9b4db8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -738,6 +738,8 @@ cpts@310d0000 {
>  			reg-names = "cpts";
>  			clocks = <&k3_clks 226 5>;
>  			clock-names = "cpts";
> +			assigned-clocks = <&k3_clks 226 5>; /* NAVSS0_CPTS_0_RCLK */
> +			assigned-clock-parents = <&k3_clks 226 7>; /* MAIN_0_HSDIVOUT6_CLK */
>  			interrupts-extended = <&main_navss_intr 391>;
>  			interrupt-names = "cpts";
>  			ti,cpts-periodic-outputs = <6>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index a353705a7463..b55a3e9daf85 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -333,6 +333,8 @@ cpts@3d000 {
>  			reg = <0x0 0x3d000 0x0 0x400>;
>  			clocks = <&k3_clks 29 3>;
>  			clock-names = "cpts";
> +			assigned-clocks = <&k3_clks 29 3>; /* CPTS_RFT_CLK */
> +			assigned-clock-parents = <&k3_clks 29 5>; /* MAIN_0_HSDIVOUT6_CLK */
>  			interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "cpts";
>  			ti,cpts-ext-ts-inputs = <4>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
