Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480D460469F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiJSNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiJSNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:15:38 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF8303EF;
        Wed, 19 Oct 2022 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZIxTik8qCVScEWj5sC/9qAFim//UicDvI+RfOQzsGsQ=; b=Blppzso/pr2nGSHf+R1U1YeYg2
        JADA3gtzViPRS5E6/JCew3xPWqEXj4sG39/Ume+6UlIlnSYqoTrzm72yTMxSW4SFkWyhgr6yhdVMK
        V6LUd9d2qMNVA/4tJs04U2VIdwx8FkZkBtqs25dpBPK4gdO0tXfBT9+saANuArPeCZSzK1VNPsg3i
        x/M2Hz+Lxf5Pp7CZ49FsyOmjgBP9nh+YBvp75kBUQ3de2zSflCTIzwecH0LZI6TdC3DR6jIblHvE9
        BEACG1uEWcfOEH8AeHDbVhSWJsfSnCW/JSsbVPD0/E6lA0sajEa5QNZT3QM+mSnjQKs4AZN9ABs+B
        FEeIazLA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:45936 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1ol74W-007ZXa-AK;
        Wed, 19 Oct 2022 13:17:16 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     shawnguo@kernel.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Subject: [PATCH 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Date:   Wed, 19 Oct 2022 13:17:12 +0200
Message-Id: <20221019111714.1953262-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019111714.1953262-1-andrej.picej@norik.com>
References: <20221019111714.1953262-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting device into the "Suspend-To-Idle" mode causes watchdog to
trigger and reset the board after set watchdog timeout period elapses.

Introduce new device-tree property "fsl,suspend-in-wait" which suspends
watchdog in WAIT mode. This is done by setting WDW bit in WCR
(Watchdog Control Register) Watchdog operation is restored after exiting
WAIT mode as expected. WAIT mode coresponds with Linux's
"Suspend-To-Idle".

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/watchdog/imx2_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index d0c5d47ddede..150ba83ce176 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -35,6 +35,7 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
 #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
 #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
@@ -67,6 +68,7 @@ struct imx2_wdt_device {
 	bool ext_reset;
 	bool clk_is_on;
 	bool no_ping;
+	bool sleep_wait;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -129,6 +131,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 
 	/* Suspend timer in low power mode, write once-only */
 	val |= IMX2_WDT_WCR_WDZST;
+	/* Suspend timer in low power WAIT mode, write once-only */
+	if (wdev->sleep_wait)
+		val |= IMX2_WDT_WCR_WDW;
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate internal chip-level reset if WDOG times out */
@@ -313,6 +318,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 
 	wdev->ext_reset = of_property_read_bool(dev->of_node,
 						"fsl,ext-reset-output");
+	wdev->sleep_wait = of_property_read_bool(dev->of_node,
+						"fsl,suspend-in-wait");
 	/*
 	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
 	 * during suspend.
-- 
2.25.1

