Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05856AE69B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCGQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCGQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:33 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D98585A6B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=n
        MY5bp/F1Kn36OJqLi8QTMaLHuNLJdfOvyLRKL/dfXI=; b=dKsH9dmTF5NW5Pq15
        dDiu59gIoegD8bIv8XjwHOAdxhvUTYJ20c+A+ZmGn9DQojqDbaWWjQDEANvOv0io
        qQI3k/s91plKOYXSXQia4cnVRPWd06KwhDHpsj4xsSv10RNrYvDQn7tLD2N1nX8L
        dq33zlAgKwpq/6pAgpm4irwXIM=
Received: (qmail 752052 invoked from network); 7 Mar 2023 17:31:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:06 +0100
X-UD-Smtp-Session: l3s3148p1@1Bwt8FH2bo0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] thermal/drivers/rcar_gen3_thermal: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:34 +0100
Message-Id: <20230307163041.3815-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/thermal/rcar_gen3_thermal.c | 52 ++---------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index d6b5b59c5c53..e97d1798b5a3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -14,7 +14,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/sys_soc.h>
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
@@ -27,7 +26,6 @@
 #define REG_GEN3_IRQTEMP1	0x14
 #define REG_GEN3_IRQTEMP2	0x18
 #define REG_GEN3_IRQTEMP3	0x1C
-#define REG_GEN3_CTSR		0x20
 #define REG_GEN3_THCTR		0x20
 #define REG_GEN3_TEMP		0x28
 #define REG_GEN3_THCODE1	0x50
@@ -46,14 +44,6 @@
 #define IRQ_TEMPD2		BIT(4)
 #define IRQ_TEMPD3		BIT(5)
 
-/* CTSR bits */
-#define CTSR_PONM	BIT(8)
-#define CTSR_AOUT	BIT(7)
-#define CTSR_THBGR	BIT(5)
-#define CTSR_VMEN	BIT(4)
-#define CTSR_VMST	BIT(1)
-#define CTSR_THSST	BIT(0)
-
 /* THCTR bits */
 #define THCTR_PONM	BIT(6)
 #define THCTR_THSST	BIT(0)
@@ -88,8 +78,6 @@ struct rcar_gen3_thermal_priv {
 	struct rcar_gen3_thermal_tsc *tscs[TSC_MAX_NUM];
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
-	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
-			     struct rcar_gen3_thermal_tsc *tsc);
 	int ptat[3];
 };
 
@@ -248,11 +236,6 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct soc_device_attribute r8a7795es1[] = {
-	{ .soc_id = "r8a7795", .revision = "ES1.*" },
-	{ /* sentinel */ }
-};
-
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
 	unsigned int i;
@@ -311,34 +294,6 @@ static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 	return true;
 }
 
-static void rcar_gen3_thermal_init_r8a7795es1(struct rcar_gen3_thermal_priv *priv,
-					      struct rcar_gen3_thermal_tsc *tsc)
-{
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
-
-	usleep_range(1000, 2000);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR, CTSR_PONM);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQCTL, 0x3F);
-	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQMSK, 0);
-	if (priv->ops.set_trips)
-		rcar_gen3_thermal_write(tsc, REG_GEN3_IRQEN,
-					IRQ_TEMPD1 | IRQ_TEMP2);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
-				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN);
-
-	usleep_range(100, 200);
-
-	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,
-				CTSR_PONM | CTSR_AOUT | CTSR_THBGR | CTSR_VMEN |
-				CTSR_VMST | CTSR_THSST);
-
-	usleep_range(1000, 2000);
-}
-
 static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 				   struct rcar_gen3_thermal_tsc *tsc)
 {
@@ -474,9 +429,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->ops = rcar_gen3_tz_of_ops;
-	priv->thermal_init = rcar_gen3_thermal_init;
-	if (soc_device_match(r8a7795es1))
-		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
 
 	platform_set_drvdata(pdev, priv);
 
@@ -516,7 +468,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		priv->thermal_init(priv, tsc);
+		rcar_gen3_thermal_init(priv, tsc);
 		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
@@ -564,7 +516,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 	for (i = 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
-		priv->thermal_init(priv, tsc);
+		rcar_gen3_thermal_init(priv, tsc);
 	}
 
 	return 0;
-- 
2.35.1

