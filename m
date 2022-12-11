Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65EA649225
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiLKC5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLKC5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:57:17 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E04113FA7;
        Sat, 10 Dec 2022 18:57:13 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id A6C6A20366; Sun, 11 Dec 2022 10:57:11 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670727431;
        bh=2KxYV7qUxfmM3CWkNEq3vFHfqI4ATKEVxtdwDMBLNnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hS6BXVkMEY41Wt/K6t1Z2qIvZ9AuamPWJ+GUMHue5nkJaSD1VzBXs80BwoRN7Te06
         IrTKkIZMSk1DzVXZ/HY5RQ/OKlgAs+SJ/KHfkkdK0O1owKN7+6J9m4Sf+W/XH1UI6j
         8yiY2n4z/pqZI+6uSNgNbhVPsHN6/IHC0LsGqzyicOmO7D8VUxNJiwFnGpcDEvfgaA
         SOY5RnB4r90PhrjRTG6Bcjn+PYW+UJR1UudQFGHK43A+oXSUtVLr+D9+SDL2UtPLjz
         6sE/Chba2SUlvZ05ZRhkiesVRUjVqs9EaVil1Lir5EVeILUzZe2n/EcL/KBQ7BQGkZ
         U8JKJ4fUWzZ/g==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v3 2/2] mfd: syscon: allow reset control for syscon devices
Date:   Sun, 11 Dec 2022 10:57:00 +0800
Message-Id: <20221211025700.1180843-3-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221211025700.1180843-1-jk@codeconstruct.com.au>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple syscon devices may require deassertion of a reset signal in order
to access their register set. Rather than requiring a custom driver to
implement this, we can use the generic "resets" specifiers to link a
reset line to the syscon.

This change adds an optional reset line to the syscon device
description, and deasserts the reset if detected.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 * do reset control in the early of_syscon_register() path, rather than
   the platform device init, which isn't used.
v3:
 * use a direct reset_control_deassert rather than handling in the
   regmap
---
 drivers/mfd/syscon.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index bdb2ce7ff03b..05e286a69dbe 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -20,6 +20,7 @@
 #include <linux/platform_data/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
 
@@ -31,6 +32,7 @@ static LIST_HEAD(syscon_list);
 struct syscon {
 	struct device_node *np;
 	struct regmap *regmap;
+	struct reset_control *reset;
 	struct list_head list;
 };
 
@@ -40,7 +42,7 @@ static const struct regmap_config syscon_regmap_config = {
 	.reg_stride = 4,
 };
 
-static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
+static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 {
 	struct clk *clk;
 	struct syscon *syscon;
@@ -50,6 +52,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	int ret;
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
+	struct reset_control *reset;
 
 	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
@@ -114,7 +117,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		goto err_regmap;
 	}
 
-	if (check_clk) {
+	if (check_res) {
 		clk = of_clk_get(np, 0);
 		if (IS_ERR(clk)) {
 			ret = PTR_ERR(clk);
@@ -124,7 +127,17 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		} else {
 			ret = regmap_mmio_attach_clk(regmap, clk);
 			if (ret)
-				goto err_attach;
+				goto err_attach_clk;
+		}
+
+		reset = of_reset_control_get_optional_exclusive(np, NULL);
+		if (IS_ERR(reset)) {
+			ret = PTR_ERR(reset);
+			goto err_attach_clk;
+		} else {
+			ret = reset_control_deassert(reset);
+			if (ret)
+				goto err_reset;
 		}
 	}
 
@@ -137,7 +150,9 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 
 	return syscon;
 
-err_attach:
+err_reset:
+	reset_control_put(reset);
+err_attach_clk:
 	if (!IS_ERR(clk))
 		clk_put(clk);
 err_clk:
@@ -150,7 +165,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 }
 
 static struct regmap *device_node_get_regmap(struct device_node *np,
-					     bool check_clk)
+					     bool check_res)
 {
 	struct syscon *entry, *syscon = NULL;
 
@@ -165,7 +180,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	spin_unlock(&syscon_list_slock);
 
 	if (!syscon)
-		syscon = of_syscon_register(np, check_clk);
+		syscon = of_syscon_register(np, check_res);
 
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
-- 
2.35.1

