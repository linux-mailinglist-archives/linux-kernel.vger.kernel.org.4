Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824326DFBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDLQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDLQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DC83DA;
        Wed, 12 Apr 2023 09:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4335A60BC9;
        Wed, 12 Apr 2023 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F78C433D2;
        Wed, 12 Apr 2023 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681317852;
        bh=NYMpdWKijNTKUJTvOHW69ko7yQoyS64ISQbBDv7RnVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=funbCDrYYgj3QHdngt+ehRvaUi6Z0gCdC5trabL90JDqaux9Kq5hMdfsvNchRa1Xh
         gBwsOFILb6QTUS8Ul8eEJxYp8m2qh3hrjZ9B3a7xh6Vy3Nyy3XDYNrmDlN29sJQEed
         nIdiMntYsaD6cLFToCMJbJTZkiU3gJ6WKJgs9EpdCG4l1TrD0pcL3Fpomi2NRMnUP7
         GilID6n504eCL+L6/a7S0kBCs8RbDiV1sYa+3lqPkohCH8TF0r7UMOMJRIvreEPc57
         f8ZO0xbwdqbTmIApLs+/9D9/il5LTNxtm+ByraXd9JaUrN/pGIst758RYpdN1oLQsI
         B1r8qzxsfQomg==
Date:   Wed, 12 Apr 2023 22:14:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 5/7] phy: phy-rockchip-inno-usb2: add rk3588 phy tuning
 support
Message-ID: <ZDbf2At0EakD09af@matsya>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
 <20230403202307.120562-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403202307.120562-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-23, 22:23, Sebastian Reichel wrote:
> On RK3588 some registers need to be tweaked to support waking up from
> suspend when a USB device is plugged into a port from a suspended PHY.
> Without this change USB devices only work when they are plugged at
> boot time.
> 
> Apart from that it optimizes settings to avoid devices toggling
> between fullspeed and highspeed mode.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 3a78c5bf11d4..9f6d09da7fbd 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -33,6 +33,8 @@
>  #define SCHEDULE_DELAY		(60 * HZ)
>  #define OTG_SCHEDULE_DELAY	(2 * HZ)
>  
> +struct rockchip_usb2phy;
> +
>  enum rockchip_usb2phy_port_id {
>  	USB2PHY_PORT_OTG,
>  	USB2PHY_PORT_HOST,
> @@ -163,6 +165,7 @@ struct rockchip_usb2phy_port_cfg {
>   * struct rockchip_usb2phy_cfg - usb-phy configuration.
>   * @reg: the address offset of grf for usb-phy config.
>   * @num_ports: specify how many ports that the phy has.
> + * @phy_tuning: phy default parameters tuning.
>   * @clkout_ctl: keep on/turn off output clk of phy.
>   * @port_cfgs: usb-phy port configurations.
>   * @chg_det: charger detection registers.
> @@ -170,6 +173,7 @@ struct rockchip_usb2phy_port_cfg {
>  struct rockchip_usb2phy_cfg {
>  	unsigned int	reg;
>  	unsigned int	num_ports;
> +	int (*phy_tuning)(struct rockchip_usb2phy *rphy);
>  	struct usb2phy_reg	clkout_ctl;
>  	const struct rockchip_usb2phy_port_cfg	port_cfgs[USB2PHY_NUM_PORTS];
>  	const struct rockchip_chg_det_reg	chg_det;
> @@ -1400,6 +1404,12 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  		goto disable_clks;
>  	}
>  
> +	if (rphy->phy_cfg->phy_tuning) {
> +		ret = rphy->phy_cfg->phy_tuning(rphy);
> +		if (ret)
> +			goto disable_clks;
> +	}
> +
>  	index = 0;
>  	for_each_available_child_of_node(np, child_np) {
>  		struct rockchip_usb2phy_port *rport = &rphy->ports[index];
> @@ -1468,6 +1478,55 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
> +{
> +	int ret = 0;

superfluous init

> +	bool usb3otg = false;
> +	/*
> +	 * utmi_termselect = 1'b1 (en FS terminations)
> +	 * utmi_xcvrselect = 2'b01 (FS transceiver)
> +	 */
> +	int suspend_cfg = 0x14;
> +
> +	if (rphy->phy_cfg->reg == 0x0000 || rphy->phy_cfg->reg == 0x4000) {
> +		/* USB2 config for USB3_0 and USB3_1 */
> +		suspend_cfg |= 0x01; /* utmi_opmode = 2'b01 (no-driving) */
> +		usb3otg = true;
> +	} else if (rphy->phy_cfg->reg == 0x8000 || rphy->phy_cfg->reg == 0xc000) {
> +		/* USB2 config for USB2_0 and USB2_1 */
> +		suspend_cfg |= 0x00; /* utmi_opmode = 2'b00 (normal) */
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* Deassert SIDDQ to power on analog block */
> +	ret = regmap_write(rphy->grf, 0x0008, GENMASK(29, 29) | 0x0000);
> +	if (ret)
> +		return ret;
> +
> +	/* Do reset after exit IDDQ mode */
> +	ret = rockchip_usb2phy_reset(rphy);
> +	if (ret)
> +		return ret;
> +
> +	/* suspend configuration */
> +	ret |= regmap_write(rphy->grf, 0x000c, GENMASK(20, 16) | suspend_cfg);
> +
> +	/* HS DC Voltage Level Adjustment 4'b1001 : +5.89% */
> +	ret |= regmap_write(rphy->grf, 0x0004, GENMASK(27, 24) | 0x0900);
> +
> +	/* HS Transmitter Pre-Emphasis Current Control 2'b10 : 2x */
> +	ret |= regmap_write(rphy->grf, 0x0008, GENMASK(20, 19) | 0x0010);
> +
> +	if (!usb3otg)
> +		return ret;
> +
> +	/* Pullup iddig pin for USB3_0 OTG mode */
> +	ret |= regmap_write(rphy->grf, 0x0010, GENMASK(17, 16) | 0x0003);
> +
> +	return ret;
> +}
> +
>  static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
>  	{
>  		.reg = 0x760,
> @@ -1785,6 +1844,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>  	{
>  		.reg = 0x0000,
>  		.num_ports	= 1,
> +		.phy_tuning	= rk3588_usb2phy_tuning,
>  		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>  		.port_cfgs	= {
>  			[USB2PHY_PORT_OTG] = {
> @@ -1821,6 +1881,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>  	{
>  		.reg = 0x4000,
>  		.num_ports	= 1,
> +		.phy_tuning	= rk3588_usb2phy_tuning,
>  		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>  		.port_cfgs	= {
>  			[USB2PHY_PORT_OTG] = {
> @@ -1857,6 +1918,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>  	{
>  		.reg = 0x8000,
>  		.num_ports	= 1,
> +		.phy_tuning	= rk3588_usb2phy_tuning,
>  		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>  		.port_cfgs	= {
>  			[USB2PHY_PORT_HOST] = {
> @@ -1877,6 +1939,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
>  	{
>  		.reg = 0xc000,
>  		.num_ports	= 1,
> +		.phy_tuning	= rk3588_usb2phy_tuning,
>  		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
>  		.port_cfgs	= {
>  			[USB2PHY_PORT_HOST] = {
> -- 
> 2.39.2

-- 
~Vinod
