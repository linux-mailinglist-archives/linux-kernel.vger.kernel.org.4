Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A096F6277
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEDAtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDAtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:49:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686CE43;
        Wed,  3 May 2023 17:49:11 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F95066056D2;
        Thu,  4 May 2023 01:49:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161350;
        bh=6J6LMnKpHiGqfs9BHMBviwpoqYtRSSctQEOfYYuBIvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbTkggtm998jC6/iaKX1i1wb0W5Bj+rTrttzGDfK8si+eszoYOCmA/xuNOiQv7N5O
         ERQjUNd7NEnlcXce0kiTxTAuYTvOkx2dHQ45slzenpKFzb5GDpNusFIfFXK2WVUjh+
         7GrLr2VJYbrEq35+qaZ9vsArI2Ea5sEaBW1sQp3MumrbS5fQCZv5b+pf8DEJ1HADIA
         MlkFV1iAYgPCheENbkGzN9sOm9nu96XoasmQTWcreUY16YlHyx1OVMH9/wopTuBCRY
         +9GSDjZpLWE6eCU1xkfRHwnXWbZcsHu4LIvzIlh1ez8SO/17Axv6EDxYyx40VUCArF
         m0z1KNUaEwcyA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 5/6] thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
Date:   Wed,  3 May 2023 20:48:51 -0400
Message-Id: <20230504004852.627049-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504004852.627049-1-nfraprado@collabora.com>
References: <20230504004852.627049-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v2:
- Added this commit

 drivers/thermal/mediatek/lvts_thermal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index efd1e938e1c2..951a4cb75ef6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -82,6 +82,8 @@
 #define LVTS_HW_SHUTDOWN_MT8195		105000
 #define LVTS_HW_SHUTDOWN_MT8192		105000
 
+#define LVTS_MINIUM_THRESHOLD		20000
+
 static int golden_temp = LVTS_GOLDEN_TEMP_DEFAULT;
 static int coeff_b = LVTS_COEFF_B;
 
@@ -309,6 +311,11 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
 			 thermal_zone_device_type(tz), low);
 		writel(raw_low, LVTS_OFFSETL(base));
+	} else {
+		pr_debug("%s: Setting low limit temperature to minimum\n",
+			 thermal_zone_device_type(tz));
+		raw_low = lvts_temp_to_raw(LVTS_MINIUM_THRESHOLD);
+		writel(raw_low, LVTS_OFFSETL(base));
 	}
 
 	/*
-- 
2.40.1

