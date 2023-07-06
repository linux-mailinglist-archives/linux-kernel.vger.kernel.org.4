Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E355874A142
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjGFPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjGFPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:39:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E11FE3;
        Thu,  6 Jul 2023 08:38:55 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8D716606FD9;
        Thu,  6 Jul 2023 16:38:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688657934;
        bh=dJTr4Fra6XCnvElvkzfEUd21h3YHU5NwbyqkcQSlbsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRKd3WJg5vhbUiSg1waIao8H9x5rZYlMgv88Fx80VTSw6lixB1dGsJ0g91Lm8dIad
         SfWcvn+fp14BnsOfutfnlEaga1h9J9RT3P/Rba50IW/jWelTIPP2Adn70kYDDtbxQM
         gpbzPK9rqbCvqr6oEH5Ypioonhjiw8RZG32yG6JvI8SV1e+6PtQxnC3sN7H5KASAU1
         QxVyyZ7DGe6+M5va+UXSVjtE+KirLJb2Br6eH6UoTzW1YMcJlkG+lJzN5RPI/4jmAa
         ww3lssaBFps/NJKUCC0cgnlalmV69Xuhm64GUyRR+pgb0n7rl73++8gtWdHg74hGLt
         enJp4Q8bam8Bw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 5/6] thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
Date:   Thu,  6 Jul 2023 11:37:36 -0400
Message-ID: <20230706153823.201943-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706153823.201943-1-nfraprado@collabora.com>
References: <20230706153823.201943-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework might leave the low threshold unset if there
aren't any lower trip points. This leaves the register zeroed, which
translates to a very high temperature for the low threshold. The
interrupt for this threshold is then immediately triggered, and the
state machine gets stuck, preventing any other temperature monitoring
interrupts to ever trigger.

(The same happens by not setting the Cold or Hot to Normal thresholds
when using those)

Set the unused threshold to a valid low value. This value was chosen so
that for any valid golden temperature read from the efuse, when the
value is converted to raw and back again to milliCelsius, the result
doesn't underflow.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Converted MINIMUM_THRESHOLD earlier to eliminate need for extra branch
- Fixed typo: MINIUM -> MINIMUM

Changes in v2:
- Added this commit

 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index e6dd4d120e54..7552e1d59dc9 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -83,6 +83,8 @@
 
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 
+#define LVTS_MINIMUM_THRESHOLD		20000
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int coeff_b = LVTS_COEFF_B;
 
@@ -294,7 +296,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *base = lvts_sensor->base;
-	u32 raw_low = lvts_temp_to_raw(low);
+	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD);
 	u32 raw_high = lvts_temp_to_raw(high);
 
 	/*
@@ -306,11 +308,9 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 *
 	 * 14-0 : Raw temperature for threshold
 	 */
-	if (low != -INT_MAX) {
-		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
-			 thermal_zone_device_type(tz), low);
-		writel(raw_low, LVTS_OFFSETL(base));
-	}
+	pr_debug("%s: Setting low limit temperature interrupt: %d\n",
+		 thermal_zone_device_type(tz), low);
+	writel(raw_low, LVTS_OFFSETL(base));
 
 	/*
 	 * High offset temperature threshold
-- 
2.41.0

