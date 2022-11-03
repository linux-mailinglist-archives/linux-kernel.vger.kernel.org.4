Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347EB618BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiKCWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiKCWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:40:17 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C731EEC7;
        Thu,  3 Nov 2022 15:40:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,135,1665414000"; 
   d="scan'208";a="141405070"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2022 07:40:15 +0900
Received: from mulinux.home (unknown [10.226.92.174])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 41EFA400A8BF;
        Fri,  4 Nov 2022 07:40:09 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Date:   Thu,  3 Nov 2022 22:39:54 +0000
Message-Id: <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting for the RZ/V2M watchdog cannot be changed once
the watchdog has been enabled, unless the IP gets reset.
The current implementation of the restart callback assumes
that the watchdog is not enabled, but that's not always the
case, and it leads to longer than necessary reboot times if
the watchdog is already running.

Always reset the RZ/V2M watchdog first, so that we can always
restart quickly.

Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 974a4194a8fd..00438ceed17a 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	clk_prepare_enable(priv->pclk);
-	clk_prepare_enable(priv->osc_clk);
-
 	if (priv->devtype == WDT_RZG2L) {
+		clk_prepare_enable(priv->pclk);
+		clk_prepare_enable(priv->osc_clk);
+
 		/* Generate Reset (WDTRSTB) Signal on parity error */
 		rzg2l_wdt_write(priv, 0, PECR);
 
@@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
 
+		reset_control_reset(priv->rstc);
+
+		clk_prepare_enable(priv->pclk);
+		clk_prepare_enable(priv->osc_clk);
+
 		wdev->timeout = 0;
 
 		/* Initialize time out */
-- 
2.34.1

