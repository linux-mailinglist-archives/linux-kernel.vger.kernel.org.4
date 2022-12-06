Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F643DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiLFH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiLFH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:56:10 -0500
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 23:56:06 PST
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4D164BD;
        Mon,  5 Dec 2022 23:56:05 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 44EC52024D; Tue,  6 Dec 2022 15:39:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670312393;
        bh=lP2H0rsOAxY33TRBDl1BU0Pc1uc9tW/ct6bXhJl98YA=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=K6hrDV+xVhnjOZBiyvJ2zqEafHBgRPN/SET/47guQ2zGTVqOckq2wQ59RnRAFDhwe
         5l07IPlnI0JvNjP8vOrr2LaaTlw8bocAXmi9G6WLy+9NASQwLAtFw7lw8DeOqeuDhm
         oBEXDkK3pV8ZiRsTaATSUuSzvuUJttenoayK+AprI1MwfMMkhb+kYejCVKiKPDb+X/
         H2YOMmkgyHDlm+FmhNbSaouS6eNgoKcOw3V73qNAoHKkW5OQQ2VcBI/cVYL8pLMmth
         v8NGHrqwVK3JKuuPbqdgw583E2fY+iBNgm2gZUcXLveVXqIucIG0XIZF4/tYUM7j17
         pMNCQNpzZSEGA==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon devices
Date:   Tue,  6 Dec 2022 15:39:16 +0800
Message-Id: <20221206073916.1606125-3-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221206073916.1606125-1-jk@codeconstruct.com.au>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
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
description, and code to perform the deassertion/assertion on
probe/remove.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/mfd/syscon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index bdb2ce7ff03b..a0483dbfe17a 100644
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
 
@@ -280,6 +282,7 @@ static int syscon_probe(struct platform_device *pdev)
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource *res;
 	void __iomem *base;
+	int rc;
 
 	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
@@ -302,13 +305,32 @@ static int syscon_probe(struct platform_device *pdev)
 		return PTR_ERR(syscon->regmap);
 	}
 
+	syscon->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								  "reset");
+	if (IS_ERR(syscon->reset))
+		return PTR_ERR(syscon->reset);
+
 	platform_set_drvdata(pdev, syscon);
 
+	rc = reset_control_deassert(syscon->reset);
+	if (rc) {
+		dev_err(dev, "failed to deassert reset line! rc: %d\n", rc);
+		return rc;
+	}
+
 	dev_dbg(dev, "regmap %pR registered\n", res);
 
 	return 0;
 }
 
+static int syscon_remove(struct platform_device *pdev)
+{
+	struct syscon *syscon = platform_get_drvdata(pdev);
+
+	reset_control_assert(syscon->reset);
+	return 0;
+}
+
 static const struct platform_device_id syscon_ids[] = {
 	{ "syscon", },
 	{ }
@@ -319,6 +341,7 @@ static struct platform_driver syscon_driver = {
 		.name = "syscon",
 	},
 	.probe		= syscon_probe,
+	.remove		= syscon_remove,
 	.id_table	= syscon_ids,
 };
 
-- 
2.35.1

