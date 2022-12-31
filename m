Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182AE65A537
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiLaPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiLaPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:02:25 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7859F636F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:02:22 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id BdNLpRaYpxN58BdNLp4Muy; Sat, 31 Dec 2022 16:02:20 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Dec 2022 16:02:20 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sander Vanheule <sander@svanheule.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: realtek_otto: Use devm_clk_get_enabled() helper
Date:   Sat, 31 Dec 2022 16:02:17 +0100
Message-Id: <5e4255782fbb43d1b4b5cd03bd12d7a184497134.1672498920.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the need of a dedicated function used
with devm_add_action_or_reset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/realtek_otto_wdt.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
index 2a5298c5e8e4..2c30ddd574c5 100644
--- a/drivers/watchdog/realtek_otto_wdt.c
+++ b/drivers/watchdog/realtek_otto_wdt.c
@@ -235,27 +235,14 @@ static const struct watchdog_info otto_wdt_info = {
 		WDIOF_PRETIMEOUT,
 };
 
-static void otto_wdt_clock_action(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int otto_wdt_probe_clk(struct otto_wdt_ctrl *ctrl)
 {
-	struct clk *clk = devm_clk_get(ctrl->dev, NULL);
-	int ret;
+	struct clk *clk;
 
+	clk = devm_clk_get_enabled(ctrl->dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(ctrl->dev, PTR_ERR(clk), "Failed to get clock\n");
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return dev_err_probe(ctrl->dev, ret, "Failed to enable clock\n");
-
-	ret = devm_add_action_or_reset(ctrl->dev, otto_wdt_clock_action, clk);
-	if (ret)
-		return ret;
-
 	ctrl->clk_rate_khz = clk_get_rate(clk) / 1000;
 	if (ctrl->clk_rate_khz == 0)
 		return dev_err_probe(ctrl->dev, -ENXIO, "Failed to get clock rate\n");
-- 
2.34.1

