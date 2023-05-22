Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E870C3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjEVRDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjEVRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75842102;
        Mon, 22 May 2023 10:03:44 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E81F76606E69;
        Mon, 22 May 2023 18:03:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775023;
        bh=O4ESAX1oWkZABPepXOkCKY7w4k1fSpZvKClJj0JDRNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AISvuS2BSnXpHERZfMru4pssu3VeuPPykVBFscd4PkG8VwQf9aMKyEdMsOmlo9+C6
         juowKS4HCBlXa2WLmnv0SCnZjS6rJ2g/q6SfJ36E7rFS2t+W9cNr0B9nJG/uCIcuAW
         5CfwBBNggFiGuaKRsyk2bTjK7oYVUfXQmGwj7NJBUR/Mig71w0EdaV30iolLCnAKOg
         h62GjIeGetDj4RUa9RJmzaGtrC1GF44Zk5QhB5VSQEbzCTZr84ZpQmFeWgmjDEy1PW
         5lXLeQNXKO+99+IN0UZa/BPbWSiy10VQ7LZwM3zpZB/c6wc2Clzk/163qV3PtM3Uvm
         ekZGfqxxAZuYg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7C96C4807E2; Mon, 22 May 2023 19:03:40 +0200 (CEST)
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
Subject: [PATCH v3 3/7] phy: phy-rockchip-inno-usb2: add reset support
Date:   Mon, 22 May 2023 19:03:20 +0200
Message-Id: <20230522170324.61349-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522170324.61349-1-sebastian.reichel@collabora.com>
References: <20230522170324.61349-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset handling support, which is needed for proper
operation with RK3588.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 2c4683c67a8e..101b46939f0b 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
@@ -223,6 +224,7 @@ struct rockchip_usb2phy_port {
  * @clk: clock struct of phy input clk.
  * @clk480m: clock struct of phy output clk.
  * @clk480m_hw: clock struct of phy output clk management.
+ * @phy_reset: phy reset control.
  * @chg_state: states involved in USB charger detection.
  * @chg_type: USB charger types.
  * @dcd_retries: The retry count used to track Data contact
@@ -239,6 +241,7 @@ struct rockchip_usb2phy {
 	struct clk	*clk;
 	struct clk	*clk480m;
 	struct clk_hw	clk480m_hw;
+	struct reset_control	*phy_reset;
 	enum usb_chg_state	chg_state;
 	enum power_supply_type	chg_type;
 	u8			dcd_retries;
@@ -280,6 +283,25 @@ static inline bool property_enabled(struct regmap *base,
 	return tmp != reg->disable;
 }
 
+static int rockchip_usb2phy_reset(struct rockchip_usb2phy *rphy)
+{
+	int ret;
+
+	ret = reset_control_assert(rphy->phy_reset);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	ret = reset_control_deassert(rphy->phy_reset);
+	if (ret)
+		return ret;
+
+	usleep_range(100, 200);
+
+	return 0;
+}
+
 static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 {
 	struct rockchip_usb2phy *rphy =
@@ -534,6 +556,18 @@ static int rockchip_usb2phy_power_on(struct phy *phy)
 		return ret;
 	}
 
+	/*
+	 * For rk3588, it needs to reset phy when exit from
+	 * suspend mode with common_on_n 1'b1(aka REFCLK_LOGIC,
+	 * Bias, and PLL blocks are powered down) for lower
+	 * power consumption. If you don't want to reset phy,
+	 * please keep the common_on_n 1'b0 to set these blocks
+	 * remain powered.
+	 */
+	ret = rockchip_usb2phy_reset(rphy);
+	if (ret)
+		return ret;
+
 	/* waiting for the utmi_clk to become stable */
 	usleep_range(1500, 2000);
 
@@ -1348,6 +1382,10 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	rphy->phy_reset = devm_reset_control_get_optional(dev, "phy");
+	if (IS_ERR(rphy->phy_reset))
+		return PTR_ERR(rphy->phy_reset);
+
 	rphy->clk = of_clk_get_by_name(np, "phyclk");
 	if (!IS_ERR(rphy->clk)) {
 		clk_prepare_enable(rphy->clk);
-- 
2.39.2

