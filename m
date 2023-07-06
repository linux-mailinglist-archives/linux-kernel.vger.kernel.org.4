Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D635474A13C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjGFPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjGFPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:38:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F7F19B7;
        Thu,  6 Jul 2023 08:38:47 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC1106606FD9;
        Thu,  6 Jul 2023 16:38:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688657926;
        bh=aPgoUi/+QUCf96kwnPphxcT4zrPIaJAdJ/Os47P4liE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fs5thJ4JWoekCvvCkvl5zqxEhPHJfQbXAXZmLiVmQ6u8sCtHzWLqE+j/Sj34a2hZ0
         G+2Xs1vXGQfoOuTzZZcXKendJ+Alg86ubKoWGvQt3Aul7xcBO4wJIlQqzijCDF9uHb
         b1/scgVxVcu9qzV/EK8oKPmXh5qRn2B+KZuSuZnZj9EeCxRrS4vX5NKWWn4OVAeIWn
         K9V5ABdd3b9wFvBsguXgN0vgXms7FsVEbDt9bbyWHC0Cc8lwebPezlyx+UE5silFDi
         wRfoRffK14OOXaQ1dLOpioedu9XhtT2cJocpw0cYEBtU9CLjwo85lQsZ/ML/cEp1pq
         UOjqmYrrlPtBQ==
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
Subject: [PATCH v3 3/6] thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
Date:   Thu,  6 Jul 2023 11:37:34 -0400
Message-ID: <20230706153823.201943-4-nfraprado@collabora.com>
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

There are two kinds of temperature monitoring interrupts available:
* High Offset, Low Offset
* Hot, Hot to normal, Cold

The code currently uses the hot/h2n/cold interrupts, however in a way
that doesn't work: the cold threshold is left uninitialized, which
prevents the other thresholds from ever triggering, and the h2n
interrupt is used as the lower threshold, which prevents the hot
interrupt from triggering again after the thresholds are updated by the
thermal framework, since a hot interrupt can only trigger again after
the hot to normal interrupt has been triggered.

But better yet than addressing those issues, is to use the high/low
offset interrupts instead. This way only two thresholds need to be
managed, which have a simpler state machine, making them a better match
to the thermal framework's high and low thresholds.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v2)

Changes in v2:
- Added this commit

 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8082195f53ae..e7cbfe0426b5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -298,9 +298,9 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	u32 raw_high = lvts_temp_to_raw(high);
 
 	/*
-	 * Hot to normal temperature threshold
+	 * Low offset temperature threshold
 	 *
-	 * LVTS_H2NTHRE
+	 * LVTS_OFFSETL
 	 *
 	 * Bits:
 	 *
@@ -309,13 +309,13 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	if (low != -INT_MAX) {
 		pr_debug("%s: Setting low limit temperature interrupt: %d\n",
 			 thermal_zone_device_type(tz), low);
-		writel(raw_low, LVTS_H2NTHRE(base));
+		writel(raw_low, LVTS_OFFSETL(base));
 	}
 
 	/*
-	 * Hot temperature threshold
+	 * High offset temperature threshold
 	 *
-	 * LVTS_HTHRE
+	 * LVTS_OFFSETH
 	 *
 	 * Bits:
 	 *
@@ -323,7 +323,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	 */
 	pr_debug("%s: Setting high limit temperature interrupt: %d\n",
 		 thermal_zone_device_type(tz), high);
-	writel(raw_high, LVTS_HTHRE(base));
+	writel(raw_high, LVTS_OFFSETH(base));
 
 	return 0;
 }
-- 
2.41.0

