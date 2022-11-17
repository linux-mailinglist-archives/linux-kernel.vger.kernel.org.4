Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306A62D9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiKQLuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiKQLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:36 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ED245A6C5;
        Thu, 17 Nov 2022 03:49:34 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,171,1665414000"; 
   d="scan'208";a="140372943"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Nov 2022 20:49:33 +0900
Received: from mulinux.example.org (unknown [10.226.93.80])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B4F5400C75F;
        Thu, 17 Nov 2022 20:49:29 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Date:   Thu, 17 Nov 2022 11:49:07 +0000
Message-Id: <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per section 48.4 of the HW User Manual, IPs in the RZ/V2M
SoC need either a TYPE-A reset sequence or a TYPE-B reset
sequence. More specifically, the watchdog IP needs a TYPE-B
reset sequence.

If the proper reset sequence isn't implemented, then resetting
IPs may lead to undesired behaviour. In the restart callback of
the watchdog driver the reset has basically no effect on the
desired funcionality, as the register writes following the reset
happen before the IP manages to come out of reset.

Implement the TYPE-B reset sequence in the watchdog driver to
address the issues with the restart callback on RZ/V2M.

Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index ceca42db0837..d404953d0e0f 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -35,6 +36,8 @@
 
 #define F2CYCLE_NSEC(f)			(1000000000 / (f))
 
+#define RZV2M_A_NSEC			730
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -51,11 +54,35 @@ struct rzg2l_wdt_priv {
 	struct reset_control *rstc;
 	unsigned long osc_clk_rate;
 	unsigned long delay;
+	unsigned long minimum_assertion_period;
 	struct clk *pclk;
 	struct clk *osc_clk;
 	enum rz_wdt_type devtype;
 };
 
+static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
+{
+	int err, status;
+
+	if (priv->devtype == WDT_RZV2M) {
+		/* WDT needs TYPE-B reset control */
+		err = reset_control_assert(priv->rstc);
+		if (err)
+			return err;
+		ndelay(priv->minimum_assertion_period);
+		err = reset_control_deassert(priv->rstc);
+		if (err)
+			return err;
+		err = read_poll_timeout(reset_control_status, status,
+					status != 1, 0, 1000, false,
+					priv->rstc);
+	} else {
+		err = reset_control_reset(priv->rstc);
+	}
+
+	return err;
+}
+
 static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
 {
 	/* delay timer when change the setting register */
@@ -115,7 +142,7 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	reset_control_reset(priv->rstc);
+	rzg2l_wdt_reset(priv);
 	pm_runtime_put(wdev->parent);
 
 	return 0;
@@ -154,6 +181,7 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
+		rzg2l_wdt_reset(priv);
 
 		wdev->timeout = 0;
 
@@ -251,6 +279,13 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
+	if (priv->devtype == WDT_RZV2M) {
+		priv->minimum_assertion_period = RZV2M_A_NSEC +
+			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
+			max(F2CYCLE_NSEC(priv->osc_clk_rate),
+			    F2CYCLE_NSEC(pclk_rate));
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
-- 
2.34.1

