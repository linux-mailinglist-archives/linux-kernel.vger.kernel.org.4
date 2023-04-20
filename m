Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895276E8DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjDTJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjDTJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:22:06 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E834C18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=G
        1gdfaITo3Jw/A5jJmrtnT8TVweoCrtk68o8grCzOXk=; b=LwJq4GMTt7jYJHaXI
        1BzBbdS5IUqQvFPkxtWOKWCuLVaWX23fRkodeAL2ZMype5IlCf7Gzm9FyJobrIDn
        H0sk+2I1bkJc2e4fQDXpog4filbKE16w6soOD5GuHnw+FYSBx5g0BOYR1XF1aso9
        l1evIkoPS9LGZ0kvMGlp9JqqUc=
Received: (qmail 4000074 invoked from network); 20 Apr 2023 11:21:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Apr 2023 11:21:46 +0200
X-UD-Smtp-Session: l3s3148p1@3zPHEcH5zs0ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 1/3] drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
Date:   Thu, 20 Apr 2023 11:21:25 +0200
Message-Id: <20230420092128.6073-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
References: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More items to describe the TSCs are needed soon, so encapsulate the
current 'ths_tj_1' item into a struct.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 41 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 42a4724d3920..e9b0aa0a2016 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -66,6 +66,10 @@ struct equation_coefs {
 	int b2;
 };
 
+struct rcar_thermal_info {
+	int ths_tj_1;
+};
+
 struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
@@ -79,6 +83,7 @@ struct rcar_gen3_thermal_priv {
 	struct thermal_zone_device_ops ops;
 	unsigned int num_tscs;
 	int ptat[3];
+	const struct rcar_thermal_info *info;
 };
 
 static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc,
@@ -318,52 +323,58 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_priv *priv,
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
@@ -418,7 +429,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	unsigned int i;
@@ -430,6 +440,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	priv->ops = rcar_gen3_tz_of_ops;
 
+	priv->info = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, priv);
 
 	if (rcar_gen3_thermal_request_irqs(priv, pdev))
@@ -469,7 +480,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		rcar_gen3_thermal_init(priv, tsc);
-		rcar_gen3_thermal_calc_coefs(priv, tsc, *ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(priv, tsc, priv->info->ths_tj_1);
 
 		zone = devm_thermal_of_zone_register(dev, i, tsc, &priv->ops);
 		if (IS_ERR(zone)) {
-- 
2.30.2

