Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58026FFA15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbjEKTWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbjEKTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:22:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9017EE8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=G
        7Fp/9JaQTJP0QCT0OfcvzIGyQ3ciiYzkRomf4h+i28=; b=NBnbQHjkg5ax5Sqw1
        wHYzfN3po4gvT83g4gzPa8gZpa7ac4JnbwpnAqx1g8ofMHy1NjfBPVSljf4hKXAa
        jOTHWA6wg9Y0XJHtvdu4KIMsEH48k9ADDlC2hhRLPKxcRpbogIWtJ+FvWKR7/gD+
        LiWhxrOJ19tmhcBB3VlR6vJbI0=
Received: (qmail 2935254 invoked from network); 11 May 2023 21:22:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2023 21:22:30 +0200
X-UD-Smtp-Session: l3s3148p1@LunX6G/7fuAujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v3 3/3] drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4
Date:   Thu, 11 May 2023 21:22:19 +0200
Message-Id: <20230511192220.7523-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
References: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
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

The registers are differently named and at different offsets, but their
functionality is the same as for Gen3.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 44 +++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 39b382ee08c8..9029d01e029b 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -35,6 +35,12 @@
 #define REG_GEN3_PTAT2		0x60
 #define REG_GEN3_PTAT3		0x64
 #define REG_GEN3_THSCP		0x68
+#define REG_GEN4_THSFMON00	0x180
+#define REG_GEN4_THSFMON01	0x184
+#define REG_GEN4_THSFMON02	0x188
+#define REG_GEN4_THSFMON15	0x1BC
+#define REG_GEN4_THSFMON16	0x1C0
+#define REG_GEN4_THSFMON17	0x1C4
 
 /* IRQ{STR,MSK,EN} bits */
 #define IRQ_TEMP1		BIT(0)
@@ -55,6 +61,7 @@
 
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
+#define GEN4_FUSE_MASK	0xFFF
 
 #define TSC_MAX_NUM	5
 
@@ -272,6 +279,34 @@ static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_priv *pri
 	}
 }
 
+static void rcar_gen3_thermal_read_fuses_gen4(struct rcar_gen3_thermal_priv *priv)
+{
+	unsigned int i;
+
+	/*
+	 * Set the pseudo calibration points with fused values.
+	 * PTAT is shared between all TSCs but only fused for the first
+	 * TSC while THCODEs are fused for each TSC.
+	 */
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON16) &
+		GEN4_FUSE_MASK;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON17) &
+		GEN4_FUSE_MASK;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON15) &
+		GEN4_FUSE_MASK;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON01) &
+			GEN4_FUSE_MASK;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON02) &
+			GEN4_FUSE_MASK;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON00) &
+			GEN4_FUSE_MASK;
+	}
+}
+
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
 	unsigned int i;
@@ -343,6 +378,11 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
 	.read_fuses = rcar_gen3_thermal_read_fuses_gen3,
 };
 
+static const struct rcar_thermal_info rcar_gen4_thermal_info = {
+	.ths_tj_1 = 126,
+	.read_fuses = rcar_gen3_thermal_read_fuses_gen4,
+};
+
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	{
 		.compatible = "renesas,r8a774a1-thermal",
@@ -382,11 +422,11 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 	},
 	{
 		.compatible = "renesas,r8a779f0-thermal",
-		.data = &rcar_gen3_thermal_info,
+		.data = &rcar_gen4_thermal_info,
 	},
 	{
 		.compatible = "renesas,r8a779g0-thermal",
-		.data = &rcar_gen3_thermal_info,
+		.data = &rcar_gen4_thermal_info,
 	},
 	{},
 };
-- 
2.35.1

