Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA776AE4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjCGPhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCGPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:36:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6423CE3C;
        Tue,  7 Mar 2023 07:36:36 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-248-189-073.ewe-ip-backbone.de [91.248.189.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA4FB6602FF1;
        Tue,  7 Mar 2023 15:36:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678203384;
        bh=ZQ/T8MJuQX09A1tGzbRQ4ENDhRkPn5npxjDPMRKuSs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEm1loiXWRFVuRH0aivajzoBX3Lnloq+AtnWWcUPKDI1vsPB9wUlJMXaw9Aay+TgA
         9yHBdfcPViLA9n5qtixSmxTp/8GhWNNnqNvHC3pnNorxZorWNPdet+M6D3iEfBc9iu
         ACtyMBrJyb/HrmshhNJ+Pm9rsIXNfyAZePAIEUEKws2yqmCLcWCqz7nkcUbuUVTStX
         Xrh0FXDebflhk9S1wvC73NJAcLZdyngbTiJXa6n8f7o0CYdI+NYEozU0k9lyoYupzL
         8So9mNrG1A3DEd//lOLlUktUS5qANycx6M12trpq0sbf9KNq0q4R4TDQqzRLGowHtg
         dw6fTi+P4v5qQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 36E64480122; Tue,  7 Mar 2023 16:36:19 +0100 (CET)
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
Subject: [PATCHv7 10/11] regulator: expose regulator_find_closest_bigger
Date:   Tue,  7 Mar 2023 16:36:16 +0100
Message-Id: <20230307153617.643260-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307153617.643260-1-sebastian.reichel@collabora.com>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/regulator/helpers.c      | 22 ++++++++++++++++++----
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index ad2237a95572..586f42e378ee 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -902,8 +902,21 @@ bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 }
 EXPORT_SYMBOL_GPL(regulator_is_equal);
 
-static int find_closest_bigger(unsigned int target, const unsigned int *table,
-			       unsigned int num_sel, unsigned int *sel)
+/**
+ * regulator_find_closest_bigger - helper to find offset in ramp delay table
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
+int regulator_find_closest_bigger(unsigned int target, const unsigned int *table,
+				  unsigned int num_sel, unsigned int *sel)
 {
 	unsigned int s, tmp, max, maxsel = 0;
 	bool found = false;
@@ -933,6 +946,7 @@ static int find_closest_bigger(unsigned int target, const unsigned int *table,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(regulator_find_closest_bigger);
 
 /**
  * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
@@ -951,8 +965,8 @@ int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
 	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
 		return -EINVAL;
 
-	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
-				  rdev->desc->n_ramp_values, &sel);
+	ret = regulator_find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+					    rdev->desc->n_ramp_values, &sel);
 
 	if (ret) {
 		dev_warn(rdev_get_dev(rdev),
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d3b4a3d4514a..c6ef7d68eb9a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -758,6 +758,8 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
+int regulator_find_closest_bigger(unsigned int target, const unsigned int *table,
+				  unsigned int num_sel, unsigned int *sel);
 int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
 int regulator_sync_voltage_rdev(struct regulator_dev *rdev);
 
-- 
2.39.2

