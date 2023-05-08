Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8928F6FA15C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjEHHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjEHHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E98687;
        Mon,  8 May 2023 00:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39196203B;
        Mon,  8 May 2023 07:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B69C433D2;
        Mon,  8 May 2023 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531979;
        bh=kO6fJ/GkPqwLv735oDhZh3GcxwMT25MvPjdP9/q6LWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsJASFt06VowLI4Mojie4o75uKwK4x8l3NIR2zXGgoXLJisE91lOQtoOs0Aicbx3N
         a6/vQU4f/ARxugTFcJF8XT2PWkjfYEcNUaezefnR7vg5+CsPspqyaGOKQlHVcpF4Z+
         EyHeCKrN3z89UH6lE7hDbJQsxBzakyfXAKBVmQ9eXsKkkGfdWJf/mLbhX4ubY6RGq3
         swjDAfLofuceyifU3rfTQ6pXP+EZSohgGs1Xe61Xnc6U5MU932sKfnRbFfou98b5qx
         kVTq1HwhHjE8xjN5vMN4SFwStCBu4pGRhz+/MgkbCN1zMq8Crc114B8wtj0PGjdl3o
         WFTz/uCmt/0VQ==
Date:   Mon, 8 May 2023 13:16:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
Subject: Re: [PATCH 1/2] phy: cadence: salvo: Add
 usb2-disconnect-threshold-microvolt property
Message-ID: <ZFioxpLaXNeDUnFY@matsya>
References: <20230505185247.1854677-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185247.1854677-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-23, 14:52, Frank Li wrote:
> Add usb2-disconnect-threshold-microvolt property to address fake USB
> disconnection issue during enumeration or suspend state for difference
> platform.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8x-mek.dtsi |  1 +
>  drivers/phy/cadence/phy-cadence-salvo.c      | 30 +++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi b/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
> index 2f8fe59fc131..6a396844c02d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
> @@ -1051,6 +1051,7 @@ &usbotg1 {
>  
>  &usb3_phy {
>  	status = "okay";
> +	usb2-disconnect-threshold-microvolt = <645>;
>  };
>  
>  &usbotg3 {
> diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
> index 23be27a747a9..06e705dbbc3c 100644
> --- a/drivers/phy/cadence/phy-cadence-salvo.c
> +++ b/drivers/phy/cadence/phy-cadence-salvo.c
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2019-2020 NXP
>   */
> -

why this change?

> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -91,9 +91,19 @@
>  
>  /* USB2 PHY register definition */
>  #define UTMI_REG15				0xaf
> +#define UTMI_AFE_RX_REG0			0x0d
>  #define UTMI_AFE_RX_REG5			0x12
>  #define UTMI_AFE_BC_REG4			0x29
>  
> +/* Align UTMI_AFE_RX_REG0 bit[7:6] define */
> +enum usb2_disconn_threshold {
> +	USB2_DISCONN_THRESHOLD_575 = 0x0,
> +	USB2_DISCONN_THRESHOLD_610 = 0x1,
> +	USB2_DISCONN_THRESHOLD_645 = 0x3,
> +};
> +
> +#define RX_USB2_DISCONN_MASK			GENMASK(7, 6)
> +
>  /* TB_ADDR_TX_RCVDETSC_CTRL */
>  #define RXDET_IN_P3_32KHZ			BIT(0)
>  /*
> @@ -125,6 +135,7 @@ struct cdns_salvo_phy {
>  	struct clk *clk;
>  	void __iomem *base;
>  	struct cdns_salvo_data *data;
> +	enum usb2_disconn_threshold usb2_disconn;
>  };
>  
>  static const struct of_device_id cdns_salvo_phy_of_match[];
> @@ -261,6 +272,12 @@ static int cdns_salvo_phy_init(struct phy *phy)
>  
>  	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5,
>  			 0x5);
> +
> +	value = cdns_salvo_read(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0);
> +	value &= ~RX_USB2_DISCONN_MASK;
> +	value = FIELD_PREP(RX_USB2_DISCONN_MASK, salvo_phy->usb2_disconn);
> +	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0, value);
> +
>  	udelay(10);
>  
>  	clk_disable_unprepare(salvo_phy->clk);
> @@ -315,6 +332,7 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct cdns_salvo_phy *salvo_phy;
>  	struct cdns_salvo_data *data;
> +	u32 val;
>  
>  	data = (struct cdns_salvo_data *)of_device_get_match_data(dev);
>  	salvo_phy = devm_kzalloc(dev, sizeof(*salvo_phy), GFP_KERNEL);
> @@ -326,6 +344,16 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
>  	if (IS_ERR(salvo_phy->clk))
>  		return PTR_ERR(salvo_phy->clk);
>  
> +	if (of_property_read_u32(dev->of_node, "usb2-disconnect-threshold-microvolt", &val))
> +		val = 575;
> +
> +	if (val < 610)
> +		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_575;
> +	else if (val < 645)
> +		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_610;
> +	else
> +		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_645;
> +
>  	salvo_phy->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(salvo_phy->base))
>  		return PTR_ERR(salvo_phy->base);
> -- 
> 2.34.1

-- 
~Vinod
