Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86005692F94
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBKIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBKIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:47:53 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8E1ABD2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Jx7o8QihIEH+So
        U0qPHGJo9go5TwIrNL7ms7y9pC4hg=; b=zW5Mo8ae/jQ3krkTnEBpbIonlYgV7A
        KyDFk2YiGK5VZ4okIRcV8f/3GB+wqrBwJwFfb9HlLssDjEw+P/XNfnL2n3nY4dIi
        4A7OpTLptFJ3vP+jHUHwBBgdvAssuk0dAgqgDHxdPHOuTM3GdMkN0q8qOuH0DpBx
        AcctyjT6I+uYE=
Received: (qmail 2337650 invoked from network); 11 Feb 2023 09:47:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Feb 2023 09:47:31 +0100
X-UD-Smtp-Session: l3s3148p1@zxwiqmj0Fpcujntl
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
Subject: [PATCH RFT 3/3] drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4
Date:   Sat, 11 Feb 2023 09:47:27 +0100
Message-Id: <20230211084728.27832-4-wsa+renesas@sang-engineering.com>
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

The registers are differently named and at different offsets, but their
functionality is the same as for Gen3.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 44 +++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c88ca7e04710..8a02b3d2f8b1 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -38,6 +38,12 @@
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
@@ -66,6 +72,7 @@
 
 #define MCELSIUS(temp)	((temp) * 1000)
 #define GEN3_FUSE_MASK	0xFFF
+#define GEN4_FUSE_MASK	0xFFF
 
 #define TSC_MAX_NUM	5
 
@@ -290,6 +297,34 @@ static void rcar_gen3_thermal_read_fuses_gen3(struct rcar_gen3_thermal_priv *pri
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
+	priv->ptat[0] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON01) &
+		GEN4_FUSE_MASK;
+	priv->ptat[1] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON02) &
+		GEN4_FUSE_MASK;
+	priv->ptat[2] = rcar_gen3_thermal_read(priv->tscs[0], REG_GEN4_THSFMON00) &
+		GEN4_FUSE_MASK;
+
+	for (i = 0; i < priv->num_tscs; i++) {
+		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
+
+		tsc->thcode[0] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON16) &
+			GEN4_FUSE_MASK;
+		tsc->thcode[1] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON17) &
+			GEN4_FUSE_MASK;
+		tsc->thcode[2] = rcar_gen3_thermal_read(tsc, REG_GEN4_THSFMON15) &
+			GEN4_FUSE_MASK;
+	}
+}
+
 static bool rcar_gen3_thermal_read_fuses(struct rcar_gen3_thermal_priv *priv)
 {
 	unsigned int i;
@@ -389,6 +424,11 @@ static const struct rcar_thermal_info rcar_gen3_thermal_info = {
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
@@ -428,11 +468,11 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
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
2.30.2

