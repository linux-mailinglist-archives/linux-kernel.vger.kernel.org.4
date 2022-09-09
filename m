Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462305B3E62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiIIR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiIIRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:55:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1FF0AAA;
        Fri,  9 Sep 2022 10:55:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-168-128.ewe-ip-backbone.de [95.33.168.128])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29F7B6601FDD;
        Fri,  9 Sep 2022 18:55:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662746131;
        bh=kzk3PENOBXyzcLbtO9AejMO4H0OZ0Ng5+GZx5DRtbtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLvAGZAOWH9Dh3mFAsovgdhPLnvlcCj+7jBmSUCTClvBllpaXTNvsItwYkKPIoF2/
         NNBHLMEmx1nJ6+GbrpC5mc2rR0hXo2hl3ffMTyLMraPFbuI6w5InFEUPygZjcziqA4
         A3+iYb5Xq344FvTQEl78b1f7COgFqJ6qFvr7wIieLQq0wuJSNAx7uNQeYl/z5OZQbB
         zLM9qHoS7N3BiGzlUYbdBGjD5rRVRO7yVsr2BgOJZMbp/N9tBpFfckdoalBqi+kWsW
         cEIKhiZUogtUF8inHYE+bKLQ42ZUen8dYnEroo0YkenLA4KOZ4ul6Sb71PWNKu4d8b
         6y9HRTZYiQsXg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2C5EE4805A5; Fri,  9 Sep 2022 19:55:27 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 12/14] regulator: expose regmap_find_closest_bigger
Date:   Fri,  9 Sep 2022 19:55:20 +0200
Message-Id: <20220909175522.179175-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909175522.179175-1-sebastian.reichel@collabora.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
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

Expose and document the table lookup logic used by
regulator_set_ramp_delay_regmap, so that it can be
reused for devices that cannot be configured via
regulator_set_ramp_delay_regmap.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/helpers.c      | 20 +++++++++++++++++---
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index ad2237a95572..eb1f18917d05 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -902,7 +902,20 @@ bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 }
 EXPORT_SYMBOL_GPL(regulator_is_equal);
 
-static int find_closest_bigger(unsigned int target, const unsigned int *table,
+/**
+ * regmap_find_closest_bigger - helper to find offset in ramp delay table
+ *
+ * @target: targeted ramp_delay
+ * @table: table with supported ramp delays
+ * @num_sel: number of entries in the table
+ * @sel: Pointer to store table offset
+ *
+ * This is the internal helper used by regulator_set_ramp_delay_regmap to
+ * map ramp delay to register value. It should only be used directly if
+ * regulator_set_ramp_delay_regmap cannot handle a specific device setup
+ * (e.g. because the value is split over multiple registers).
+ */
+int regmap_find_closest_bigger(unsigned int target, const unsigned int *table,
 			       unsigned int num_sel, unsigned int *sel)
 {
 	unsigned int s, tmp, max, maxsel = 0;
@@ -933,6 +946,7 @@ static int find_closest_bigger(unsigned int target, const unsigned int *table,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(regmap_find_closest_bigger);
 
 /**
  * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
@@ -951,8 +965,8 @@ int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
 	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
 		return -EINVAL;
 
-	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
-				  rdev->desc->n_ramp_values, &sel);
+	ret = regmap_find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+					 rdev->desc->n_ramp_values, &sel);
 
 	if (ret) {
 		dev_warn(rdev_get_dev(rdev),
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index f9a7461e72b8..9501dbec64da 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -757,6 +757,8 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
+int regmap_find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel);
 int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
 int regulator_sync_voltage_rdev(struct regulator_dev *rdev);
 
-- 
2.35.1

