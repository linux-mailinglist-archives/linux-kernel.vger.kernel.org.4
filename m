Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67F62D9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiKQLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiKQLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:26 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6BA29591;
        Thu, 17 Nov 2022 03:49:25 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,171,1665414000"; 
   d="scan'208";a="142991208"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Nov 2022 20:49:25 +0900
Received: from mulinux.example.org (unknown [10.226.93.80])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 280CE400C75F;
        Thu, 17 Nov 2022 20:49:20 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 1/2] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
Date:   Thu, 17 Nov 2022 11:49:06 +0000
Message-Id: <20221117114907.138583-2-fabrizio.castro.jz@renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
reset the system.

The procedure described in the HW manual (Procedure for Activating Modules)
for activating the target module states we need to start supply of the
clock module before applying the reset signal. This patch makes sure we
follow the same procedure to clear the registers of the WDT module, fixing
the issues seen on RZ/Five SoC.

While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as it has
the same function calls.

Fixes: 4055ee81009e ("watchdog: rzg2l_wdt: Add set_timeout callback")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 974a4194a8fd..ceca42db0837 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -115,25 +115,23 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	pm_runtime_put(wdev->parent);
 	reset_control_reset(priv->rstc);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
 
 static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
 {
-	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
-
 	wdev->timeout = timeout;
 
 	/*
 	 * If the watchdog is active, reset the module for updating the WDTSET
-	 * register so that it is updated with new timeout values.
+	 * register by calling rzg2l_wdt_stop() (which internally calls reset_control_reset()
+	 * to reset the module) so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		pm_runtime_put(wdev->parent);
-		reset_control_reset(priv->rstc);
+		rzg2l_wdt_stop(wdev);
 		rzg2l_wdt_start(wdev);
 	}
 
-- 
2.34.1

