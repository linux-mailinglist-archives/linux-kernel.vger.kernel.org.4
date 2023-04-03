Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFB6D5246
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjDCUXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjDCUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:23:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA251BF4;
        Mon,  3 Apr 2023 13:23:16 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-192.ewe-ip-backbone.de [91.248.212.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB18D6603161;
        Mon,  3 Apr 2023 21:23:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680553394;
        bh=skQehSyjADh+Hmg49bUp5beSk9f0LyInxN05A6rHyU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHYEevNO6ngY82LXCjdFut8i94fOG0cnvk/M7cZEM08niT3tjO40ZrXeNnjjOBpxb
         jg6N6M6OSiPvaziwtffNTRNFF2OahdkBFmTcgTYAWfoHeSkfOrfUAdwV/W4viDcZTD
         FzYbtaFDhyKoVhKlfitWd7Mqlvf8KAs3clcX69Zy0CIz6iLD2VRSSHPow5zLBErdUl
         PnhbODflnwY3dBYWvVz2J8Bv0XIU0obDW9hXpTTe+hZGkoquIiciR/oENnnfrcKk7u
         IpNNodXTGict/hSsxpaf8Bg29l5ogVQnPvFHv6XnZUmGf+j4V3Vf+Fn1CesLofk4ru
         i1BOVQdriPO0w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 12F884807F1; Mon,  3 Apr 2023 22:23:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 5/7] phy: phy-rockchip-inno-usb2: add rk3588 phy tuning support
Date:   Mon,  3 Apr 2023 22:23:05 +0200
Message-Id: <20230403202307.120562-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403202307.120562-1-sebastian.reichel@collabora.com>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RK3588 some registers need to be tweaked to support waking up from
suspend when a USB device is plugged into a port from a suspended PHY.
Without this change USB devices only work when they are plugged at
boot time.

Apart from that it optimizes settings to avoid devices toggling
between fullspeed and highspeed mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 3a78c5bf11d4..9f6d09da7fbd 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -33,6 +33,8 @@
 #define SCHEDULE_DELAY		(60 * HZ)
 #define OTG_SCHEDULE_DELAY	(2 * HZ)
 
+struct rockchip_usb2phy;
+
 enum rockchip_usb2phy_port_id {
 	USB2PHY_PORT_OTG,
 	USB2PHY_PORT_HOST,
@@ -163,6 +165,7 @@ struct rockchip_usb2phy_port_cfg {
  * struct rockchip_usb2phy_cfg - usb-phy configuration.
  * @reg: the address offset of grf for usb-phy config.
  * @num_ports: specify how many ports that the phy has.
+ * @phy_tuning: phy default parameters tuning.
  * @clkout_ctl: keep on/turn off output clk of phy.
  * @port_cfgs: usb-phy port configurations.
  * @chg_det: charger detection registers.
@@ -170,6 +173,7 @@ struct rockchip_usb2phy_port_cfg {
 struct rockchip_usb2phy_cfg {
 	unsigned int	reg;
 	unsigned int	num_ports;
+	int (*phy_tuning)(struct rockchip_usb2phy *rphy);
 	struct usb2phy_reg	clkout_ctl;
 	const struct rockchip_usb2phy_port_cfg	port_cfgs[USB2PHY_NUM_PORTS];
 	const struct rockchip_chg_det_reg	chg_det;
@@ -1400,6 +1404,12 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		goto disable_clks;
 	}
 
+	if (rphy->phy_cfg->phy_tuning) {
+		ret = rphy->phy_cfg->phy_tuning(rphy);
+		if (ret)
+			goto disable_clks;
+	}
+
 	index = 0;
 	for_each_available_child_of_node(np, child_np) {
 		struct rockchip_usb2phy_port *rport = &rphy->ports[index];
@@ -1468,6 +1478,55 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
+{
+	int ret = 0;
+	bool usb3otg = false;
+	/*
+	 * utmi_termselect = 1'b1 (en FS terminations)
+	 * utmi_xcvrselect = 2'b01 (FS transceiver)
+	 */
+	int suspend_cfg = 0x14;
+
+	if (rphy->phy_cfg->reg == 0x0000 || rphy->phy_cfg->reg == 0x4000) {
+		/* USB2 config for USB3_0 and USB3_1 */
+		suspend_cfg |= 0x01; /* utmi_opmode = 2'b01 (no-driving) */
+		usb3otg = true;
+	} else if (rphy->phy_cfg->reg == 0x8000 || rphy->phy_cfg->reg == 0xc000) {
+		/* USB2 config for USB2_0 and USB2_1 */
+		suspend_cfg |= 0x00; /* utmi_opmode = 2'b00 (normal) */
+	} else {
+		return -EINVAL;
+	}
+
+	/* Deassert SIDDQ to power on analog block */
+	ret = regmap_write(rphy->grf, 0x0008, GENMASK(29, 29) | 0x0000);
+	if (ret)
+		return ret;
+
+	/* Do reset after exit IDDQ mode */
+	ret = rockchip_usb2phy_reset(rphy);
+	if (ret)
+		return ret;
+
+	/* suspend configuration */
+	ret |= regmap_write(rphy->grf, 0x000c, GENMASK(20, 16) | suspend_cfg);
+
+	/* HS DC Voltage Level Adjustment 4'b1001 : +5.89% */
+	ret |= regmap_write(rphy->grf, 0x0004, GENMASK(27, 24) | 0x0900);
+
+	/* HS Transmitter Pre-Emphasis Current Control 2'b10 : 2x */
+	ret |= regmap_write(rphy->grf, 0x0008, GENMASK(20, 19) | 0x0010);
+
+	if (!usb3otg)
+		return ret;
+
+	/* Pullup iddig pin for USB3_0 OTG mode */
+	ret |= regmap_write(rphy->grf, 0x0010, GENMASK(17, 16) | 0x0003);
+
+	return ret;
+}
+
 static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 	{
 		.reg = 0x760,
@@ -1785,6 +1844,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg = 0x0000,
 		.num_ports	= 1,
+		.phy_tuning	= rk3588_usb2phy_tuning,
 		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
@@ -1821,6 +1881,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg = 0x4000,
 		.num_ports	= 1,
+		.phy_tuning	= rk3588_usb2phy_tuning,
 		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
@@ -1857,6 +1918,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg = 0x8000,
 		.num_ports	= 1,
+		.phy_tuning	= rk3588_usb2phy_tuning,
 		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_HOST] = {
@@ -1877,6 +1939,7 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg = 0xc000,
 		.num_ports	= 1,
+		.phy_tuning	= rk3588_usb2phy_tuning,
 		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_HOST] = {
-- 
2.39.2

