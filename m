Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F986EE315
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjDYNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjDYNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:31:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E36CC29
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:31:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so28019865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682429461; x=1685021461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFvArtlR5+rlBUjon8HfYa6K8wJfRUe/bNSEGRANSLs=;
        b=XXZ7Ysee351VlTUNkhXn7v7oZuxuOr36GtvGq+CeRtDXSgcWvI8IPgVtHmrUusOh3d
         ezFI814ADuoJO/AHyp7IAt6TOvPl9fdUzx7+0XuIWKfR/UPUKs4YeEmr5eCZ69XvH2qR
         pBAgiuARI5JxfSytACt1UJHd0QV0oopjp6JTLIq3mrNMljKjZLXYGcaLZEeN1Ih2EsST
         xDVYwJN5u8T1iqKBEUwQTy2NwDPmuMyu4qlKhFbgNLGvRyJYWP0jv94ik4zH+jZtLLE0
         qnRhx5Ms64indTFTAm7A/UoyJKWiZL7H6fHMQnpHKQWZGpfJ/4RIe3rwoW8gxiBzbCDN
         XSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682429461; x=1685021461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFvArtlR5+rlBUjon8HfYa6K8wJfRUe/bNSEGRANSLs=;
        b=Bfx7gusOwS8zmDfcEBIIPkIzOiec3ZxpBdRLjLTdZ4XlYUeKTeKnzDnnvaga9/aZVN
         7o3+82VMtBmNfhiskSsrlIcB+iKapBQmXaRPhe90Ap693e1M1liDYicSCDeqfRgg2j/k
         ihfloB3M8dkC7DpIhoS2UGNLLD8TmbkJvlOEmlvahYz9Q4RCvNz+/A1QST22JbXvmsuZ
         IkfXdrTO3pBYr/tFG0zoyLIwzmSkD5prdz03720QobqO44OdiAoWgXvhpZl4wcd5fXch
         7maIXJ2Vx5Hanj4vMyq0yGDBY4AAxbrWMaCWeAO3mAV5yi8rkIX5kHwJGZxez/QbkKeA
         3SIQ==
X-Gm-Message-State: AC+VfDymnWEv4PG1IqFkqugHenHrnfghIXC0XRMeQyyuySWOVUta0VqW
        0PMJeJKsCHOmdpXF3Pjs61O2ww==
X-Google-Smtp-Source: ACHHUZ7z2aTUvi9HjEh9faDXgMiwLfPm+xyJFiCW754v6AxmPj55eGl0fWVY5yCGrbv/XK+0EQ+AbA==
X-Received: by 2002:a7b:c046:0:b0:3f2:5be3:cd67 with SMTP id u6-20020a7bc046000000b003f25be3cd67mr175363wmc.18.1682429461317;
        Tue, 25 Apr 2023 06:31:01 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b003f16932fe7dsm18575434wmq.38.2023.04.25.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:31:01 -0700 (PDT)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v2 5/5] thermal/drivers/mediatek/lvts_thermal: Update calibration data documentation
Date:   Tue, 25 Apr 2023 15:30:52 +0200
Message-Id: <20230425133052.199767-6-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425133052.199767-1-bchihi@baylibre.com>
References: <20230425133052.199767-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Update LVTS calibration data documentation for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 59 ++++++++++++++++++-------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 8df7b4c72a658..3df4989f9902b 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -531,30 +531,57 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- * stream index map for MCU Domain :
+ * MT8195 :
+ * Stream index map for MCU Domain mt8195 :
  *
- * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
- *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
+ * <-----sensor#0-----> <-----sensor#1----->
+ *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
  *
- * <-----mcu-tc#1-----> <-----sensor#2-----> <-----sensor#3----->
- *  0x0A | 0x0B | 0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12
+ * <-----sensor#2-----> <-----sensor#3----->
+ *  0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12
  *
- * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
- *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
+ * <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
+ *  0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
  *
- * stream index map for AP Domain :
+ * Stream index map for AP Domain mt8195 :
  *
- * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
- *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
+ * <-----sensor#0-----> <-----sensor#1----->
+ *  0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
  *
- * <-----ap--tc#1-----> <-----sensor#2-----> <-----sensor#3----->
- *  0x2B | 0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ * <-----sensor#2-----> <-----sensor#3----->
+ *  0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
  *
- * <-----ap--tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6----->
- *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B | 0x3C | 0x3D | 0x3E | 0x3F
+ * <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6----->
+ *  0x37 | 0x38 | 0x39 | 0x3A | 0x3B | 0x3C | 0x3D | 0x3E | 0x3F
  *
- * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
- *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
+ * <-----sensor#7-----> <-----sensor#8----->
+ *  0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
+ *
+ * MT8192 :
+ * Stream index map for MCU Domain mt8192 :
+ *
+ * <--------sensor#0---------> <--------sensor#1--------->
+ *  0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <--------sensor#2---------> <--------sensor#3--------->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <--------sensor#4---------> <--------sensor#5---------> <--------sensor#6---------> <--------sensor#7--------->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for AP Domain mt8192 :
+ *
+ * <--------sensor#0---------> <--------sensor#1--------->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * <--------sensor#2---------> <--------sensor#3--------->
+ *  0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <--------sensor#4---------> <--------sensor#5--------->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B
+ *
+ * <--------sensor#6---------> <--------sensor#7---------> <--------sensor#8--------->
+ *  0x3C | 0x3D | 0x3E | 0x3F | 0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47
  *
  * The data description gives the offset of the calibration data in
  * this bytes stream for each sensor.
-- 
2.34.1

