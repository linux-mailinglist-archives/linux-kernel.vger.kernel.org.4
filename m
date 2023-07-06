Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7056974A201
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGFQPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:15:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F710C;
        Thu,  6 Jul 2023 09:15:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45AEE6606FC4;
        Thu,  6 Jul 2023 17:15:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688660118;
        bh=j4Ff8jZjJXo7I/FQ5lBog+vo+xtKrEJKPXvRjQjs67g=;
        h=From:To:Cc:Subject:Date:From;
        b=TvWdYc4hqW5CowqNu/0c/JhbwtCGD3WTQS8ADenSlLyffsiXemx2i1bd/M+y0aGsM
         IiAcCyioCzgtgKQ5Y184uaTbo+oGie9yuPyJ358Jvv4CsC1OFloX3gcNjepCfSSojE
         UFr0ciczt0GV+LBORO3oAD3NUv7WdVxXzblawz2jVWpcI8XdB8jlWleB1++VnWTMAc
         B0B1IOqd8mULvYFHFUdL4VFzetSWz0MU9ui4jGfRHrGZmgrF6/ZaId457ZZgSm2jMh
         DBh5XGqsG+uruHm2l4UKEIDLBjAY0fCXeZGYBTx8VjhbS6kLE2AmRior76CVCJVOD5
         5zNVnrqBHkW1g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make readings valid in filtered mode
Date:   Thu,  6 Jul 2023 12:14:33 -0400
Message-ID: <20230706161509.204546-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
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

Currently, when a controller is configured to use filtered mode, thermal
readings are valid only about 30% of the time.

Upon testing, it was noticed that lowering any of the interval settings
resulted in an improved rate of valid data. The same was observed when
decreasing the number of samples for each sensor (which also results in
quicker measurements).

Retrying the read with a timeout longer than the time it takes to
resample (about 344us with these settings and 4 sensors) also improves
the rate.

Lower all timing settings to the minimum, configure the filtering to
single sample, and poll the measurement register for at least one period
to improve the data validity on filtered mode.  With these changes in
place, out of 100000 reads, a single one failed, ie 99.999% of the data
was valid.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/thermal/mediatek/lvts_thermal.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1e11defe4f35..b5fb1d8bc3d8 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -58,11 +58,11 @@
 #define LVTS_PROTTC(__base)		(__base + 0x00CC)
 #define LVTS_CLKEN(__base)		(__base + 0x00E4)
 
-#define LVTS_PERIOD_UNIT			((118 * 1000) / (256 * 38))
-#define LVTS_GROUP_INTERVAL			1
-#define LVTS_FILTER_INTERVAL		1
-#define LVTS_SENSOR_INTERVAL		1
-#define LVTS_HW_FILTER				0x2
+#define LVTS_PERIOD_UNIT			0
+#define LVTS_GROUP_INTERVAL			0
+#define LVTS_FILTER_INTERVAL		0
+#define LVTS_SENSOR_INTERVAL		0
+#define LVTS_HW_FILTER				0x0
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
 #define LVTS_MONINT_CONF			0x9FBF7BDE
@@ -257,6 +257,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
+	int rc;
 
 	/*
 	 * Measurement registers:
@@ -269,7 +270,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * 16	: Valid temperature
 	 * 15-0	: Raw temperature
 	 */
-	value = readl(msr);
+	rc = readl_poll_timeout(msr, value, value & BIT(16), 240, 400);
 
 	/*
 	 * As the thermal zone temperature will read before the
@@ -282,7 +283,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 	 * functionning temperature and directly jump to a system
 	 * shutdown.
 	 */
-	if (!(value & BIT(16)))
+	if (rc)
 		return -EAGAIN;
 
 	*temp = lvts_raw_to_temp(value & 0xFFFF);
-- 
2.41.0

