Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8505EFC63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiI2RyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiI2RyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:54:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071EE153A50;
        Thu, 29 Sep 2022 10:54:07 -0700 (PDT)
X-QQ-mid: bizesmtp87t1664474038tj1dvpe4
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 01:53:56 +0800 (CST)
X-QQ-SSF: 01000000002000303000B00A0000000
X-QQ-FEAT: HMFEffFGMPGBL3l3Ij6k0E2v5J9Ylr9nwMFjgO0MAKRNRxUmgtbbpWV6IIT1D
        O9miAkhuqaG3fnMJtFlKWs0d++ZmndFZRRUKvEf2NM8YQDkxMuiEp3zqaDqtBO2ZsOh64B1
        rEw3hJJ82c3ZtLvQLs7yFAfSp6nxqPPEFudUMDqrJ3Ur5VSOj6voks1dXKbKjgsfoHGSfLN
        Mc0HfiWRfKLBi1noxWyUmWJpvbRwB63OVKiuxgxVMF41JUZRhBRqisF5W+s/D2q6im+PA3/
        DnW293cyCAiv5M6y9MwAPKf6U0UhjVy/0yNnkH+6MtqoLPYl0q/kmOU3eAqcvLFMg8M8MsP
        MtU7DTfilOxwDIX2LzG2vnsG2FxPXdEM254WFCdnwcp0czHgPpwoyv/+mBrbEBMzmHN3oZI
        V09ySIDgpb4=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/30] reset: starfive: Add StarFive JH7110 SoC support
Date:   Fri, 30 Sep 2022 01:53:52 +0800
Message-Id: <20220929175352.19821-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the driver be compatible with StarFive JH7110 SoC.
Note that the register base address of clock controller is the
same with the reset controller one. So we store the property
'reg' in the parent node of node 'reset-controller' and use
syscon APIs to get regmap structure.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 drivers/reset/reset-starfive.c | 35 +++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-starfive.c b/drivers/reset/reset-starfive.c
index 56d07bafadd7..a953fed711fd 100644
--- a/drivers/reset/reset-starfive.c
+++ b/drivers/reset/reset-starfive.c
@@ -8,7 +8,7 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
@@ -134,7 +134,7 @@ static const struct reset_control_ops starfive_reset_ops = {
 	.status		= starfive_reset_status,
 };
 
-static int __init starfive_reset_probe(struct platform_device *pdev)
+static int reset_starfive_register(struct platform_device *pdev, const u32 *asserted)
 {
 	struct starfive_reset *data;
 	int ret;
@@ -145,9 +145,12 @@ static int __init starfive_reset_probe(struct platform_device *pdev)
 
 	data->regmap = device_node_to_regmap(pdev->dev.of_node);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&pdev->dev, "failed to get regmap (error %ld)\n",
-			PTR_ERR(data->regmap));
-		return PTR_ERR(data->regmap);
+		data->regmap = syscon_node_to_regmap(pdev->dev.of_node->parent);
+		if (IS_ERR(data->regmap)) {
+			dev_err(&pdev->dev, "failed to get regmap (error %ld)\n",
+				PTR_ERR(data->regmap));
+			return PTR_ERR(data->regmap);
+		}
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "starfive,assert-offset",
@@ -177,16 +180,34 @@ static int __init starfive_reset_probe(struct platform_device *pdev)
 	data->rcdev.dev = &pdev->dev;
 	data->rcdev.of_node = pdev->dev.of_node;
 
-	data->asserted = jh7100_reset_asserted;
+	data->asserted = asserted;
 
 	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
 }
 
 static const struct of_device_id starfive_reset_dt_ids[] = {
-	{ .compatible = "starfive,jh7100-reset" },
+	{
+		.compatible = "starfive,jh7100-reset",
+		.data = jh7100_reset_asserted,
+	},
+	{
+		.compatible = "starfive,jh7110-reset",
+		.data = NULL,
+	},
 	{ /* sentinel */ }
 };
 
+static int __init starfive_reset_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+
+	match = of_match_device(starfive_reset_dt_ids, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
+	return reset_starfive_register(pdev, (u32 *)(match->data));
+}
+
 static struct platform_driver starfive_reset_driver = {
 	.driver = {
 		.name = "starfive-reset",
-- 
2.17.1

