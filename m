Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A954692F92
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBKIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBKIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:47:53 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A795FF0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=7jcF/omJnwxC/i
        6JNLhKdL2UNNtPjvGVIvLcMusdQ2Q=; b=gt80nmDQsq6E8qMN6VW8xtOK5Yo3tB
        HXcEh63VVERc/9DFJ4Jqwt/hkSDF6zVnONQ86gi6M03FQMm27o+ol54YnWBMMNix
        5yVl48aRsKSW3EWIUKr9zxdIbugS4VQnH3+ec/PlNHuXNTLBSLTrnTgLg7OioWh3
        /qEasfEudw1do=
Received: (qmail 2337537 invoked from network); 11 Feb 2023 09:47:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Feb 2023 09:47:30 +0100
X-UD-Smtp-Session: l3s3148p1@qLMNqmj0CJcujntl
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Duy Nguyen <duy.nguyen.rh@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT 1/3] drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
Date:   Sat, 11 Feb 2023 09:47:25 +0100
Message-Id: <20230211084728.27832-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230211084728.27832-1-wsa+renesas@sang-engineering.com>
References: <20230211084728.27832-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More items to describe the TSCs are needed soon, so encapsulate the
current 'ths_tj_1' item into a struct.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 41 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 2bd69d613d99..bfccb91bda21 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -77,6 +77,10 @@ struct equation_coefs {
 	int b2;
 };
 
+struct rcar_thermal_info {
+	int ths_tj_1;
+};
+
 struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
@@ -92,6 +96,7 @@ struct rcar_gen3_thermal_priv {
 	void (*thermal_init)(struct rcar_gen3_thermal_priv *priv,
 			     struct rcar_gen3_thermal_tsc *tsc);
 	int ptat[3];
+	const struct rcar_thermal_info *info;
 };
 
 static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
@@ -364,52 +369,58 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
 	usleep_range(1000, 2000);
 }
 
-static const int rcar_gen3_ths_tj_1 = 126;
-static const int rcar_gen3_ths_tj_1_m3_w = 116;
+static const struct rcar_thermal_info rcar_m3w_thermal_info = {
+	.ths_tj_1 = 116,
+};
+
+static const struct rcar_thermal_info rcar_gen3_thermal_info = {
+	.ths_tj_1 = 126,
+};
+
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	{
 		.compatible = "renesas,r8a774a1-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_m3w_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a774b1-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a774e1-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a7795-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a7796-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_m3w_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a77961-thermal",
-		.data = &rcar_gen3_ths_tj_1_m3_w,
+		.data = &rcar_m3w_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a77965-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a77980-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779a0-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779f0-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779g0-thermal",
-		.data = &rcar_gen3_ths_tj_1,
+		.data = &rcar_gen3_thermal_info,
 	},
 	{},
 };
@@ -464,7 +475,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	unsigned int i;
@@ -479,6 +489,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	if (soc_device_match(r8a7795es1))
 		priv->thermal_init = rcar_gen3_thermal_init_r8a7795es1;
 
+	priv->info = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, priv);
 
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
@@ -518,7 +529,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		priv->thermal_init(priv, tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(priv, tsc, priv->info->ths_tj_1);
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
-- 
2.30.2

