Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50946701F12
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjENSq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjENSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:46:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B63AA7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 11:46:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yGjOpRl6UIsg1yGjOpZsJM; Sun, 14 May 2023 20:46:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684089981;
        bh=Lq4t2RwZUg9fe1YN6jfcFon281FtXbX0H4guo24wo8k=;
        h=From:To:Cc:Subject:Date;
        b=hXeuGLKNFeHpsYz+fvzZqeiCvPflHPwRkHXULJ8mRGrX2/heUijF1P8r73TpJx1gZ
         aqtjB4mpQ2tixtMWiQgqK2069ugLiudfgr/DFS1R99EuQS+AltGot/3LPEpLqtJiw0
         dO/vfAZA1ojigki+G6qRjyy7MdPPLFULTNnywkBzD6VF7qfQhZX+1iG+qgFsl+JX9N
         Ykdy4FtAKZe9BJIxjVSTQLxMhSK2DpRRtjp+a8lOhnAJZxHZwOJjbhaVQ6uQ6B8vTZ
         pe3S28Cq0HnliU4Y0B+pDC8zuVctzlN3DJ0v9i7nfM9JxjvgODMRKb5Smr0qlnBY4j
         jI1BCynuUTmvw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 20:46:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
Date:   Sun, 14 May 2023 20:46:05 +0200
Message-Id: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should an error occur after calling sun8i_ths_resource_init() in the probe
function, some resources need to be released, as already done in the
.remove() function.

Switch to the devm_clk_get_enabled() helper and add a new devm_action to
turn sun8i_ths_resource_init() into a fully managed function.

Move the place where reset_control_deassert() is called so that the
recommended order of reset release/clock enable steps is kept.
A64 manual states that:

	3.3.6.4. Gating and reset

	Make sure that the reset signal has been released before the release of
	module clock gating;

This fixes the issue and removes some LoC at the same time.

Fixes: dccc5c3b6f30 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
   - move reset_control_deassert() next to devm_reset_control_get()

v1: https://lore.kernel.org/all/26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr/
---
 drivers/thermal/sun8i_thermal.c | 55 +++++++++++----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..d4d241686c81 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -319,6 +319,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
+static void sun8i_ths_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -339,47 +344,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		ret = reset_control_deassert(tmdev->reset);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
+					       tmdev->reset);
+		if (ret)
+			return ret;
+
+		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
 	}
 
 	if (tmdev->chip->has_mod_clk) {
-		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
 		if (IS_ERR(tmdev->mod_clk))
 			return PTR_ERR(tmdev->mod_clk);
 	}
 
-	ret = reset_control_deassert(tmdev->reset);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(tmdev->bus_clk);
-	if (ret)
-		goto assert_reset;
-
 	ret = clk_set_rate(tmdev->mod_clk, 24000000);
 	if (ret)
-		goto bus_disable;
-
-	ret = clk_prepare_enable(tmdev->mod_clk);
-	if (ret)
-		goto bus_disable;
+		return ret;
 
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
-		goto mod_disable;
+		return ret;
 
 	return 0;
-
-mod_disable:
-	clk_disable_unprepare(tmdev->mod_clk);
-bus_disable:
-	clk_disable_unprepare(tmdev->bus_clk);
-assert_reset:
-	reset_control_assert(tmdev->reset);
-
-	return ret;
 }
 
 static int sun8i_h3_thermal_init(struct ths_device *tmdev)
@@ -530,17 +523,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun8i_ths_remove(struct platform_device *pdev)
-{
-	struct ths_device *tmdev = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(tmdev->mod_clk);
-	clk_disable_unprepare(tmdev->bus_clk);
-	reset_control_assert(tmdev->reset);
-
-	return 0;
-}
-
 static const struct ths_thermal_chip sun8i_a83t_ths = {
 	.sensor_num = 3,
 	.scale = 705,
@@ -642,7 +624,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
 
 static struct platform_driver ths_driver = {
 	.probe = sun8i_ths_probe,
-	.remove = sun8i_ths_remove,
 	.driver = {
 		.name = "sun8i-thermal",
 		.of_match_table = of_ths_match,
-- 
2.34.1

