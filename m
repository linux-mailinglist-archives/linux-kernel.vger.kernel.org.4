Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6E714D27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2Pfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjE2Pfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:35:44 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1AC9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ad458f085so2244711f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685374541; x=1687966541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6KztWxfOQw7uIdLc2nfQ4eiSQgNkopQmfDWyk3B1pA=;
        b=Z/5vpH68gfM2Ty2Ec0/olSNrF62z+MjGSGvYcxO/T5RFeSI7y4z78JOiOkT8C5lHvu
         odfYG21AkP/qg7t/V39xpytr/gb43qVoeMiNbwqIqOnBfPNlC0/pRWen2T4OIkGcpAfn
         Nc6elGSJRgGhppzsrffnFHBNlMy62eCnshaj4bpIKVeewTOQBgGjAwXUZyVj82LWgAP1
         s+NgSJ50l6j2vMNi3Gdb2tOeklNDF/FuuWVpvoKBSG/i0G1CN7sqplEsoGKWQJZVHFlZ
         OoHZG0JuFHiC5U5MH7VKcYwXPQxX2sQ5+cmO+HgeHgLJnbnOBmY0DWaqbODWWO+OZu4/
         wSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374541; x=1687966541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6KztWxfOQw7uIdLc2nfQ4eiSQgNkopQmfDWyk3B1pA=;
        b=UPmpnJbYMtCDyqY0s7zUdsBY3JWoVY4QHgYWEniYnO1I1YG0ki7Bmqg/VNcCa9YHmc
         FGTTBUtF/LsJXNS1ADcj16HtRwlJisoEOjXjJk+htavFjmEjH+snScGx3ZcdCqmHoner
         xNvHZKfawnbMvaTYrHgnd1r67g8d3fmFmxcQWEKOnMXVzvRpVXFo5Gd9OqRL4sgtWFVZ
         0u36A+qz5St1KK4GXAn6huPXcjXXLI0am9WgVF6NKBpxg/Cllx4O2BP4D02eDrP8FweA
         G3Xamsx8qT6xFgATeQCxufYVSfkj00GDTmTUKMxvdAb+9ExrzJsVSElr24ihoO+exSfv
         H7lQ==
X-Gm-Message-State: AC+VfDwWrThPiUcA7+jGk2TznU5U/B3GQPON1s6SrVTrYbVf6kqyjvw1
        IOicJy0d3GMLiCMPedrQJTdVNgqJv7/sLA5b5pDFwA==
X-Google-Smtp-Source: ACHHUZ4iluD/nMcdT4wH1pwxlqw2W2qqyXc2nIq400406PfuiYEVls27Yxb0nakKynMHxLpe0DI2cw==
X-Received: by 2002:a05:6000:1050:b0:30a:aeb3:f3b0 with SMTP id c16-20020a056000105000b0030aaeb3f3b0mr6698603wrx.17.1685374541302;
        Mon, 29 May 2023 08:35:41 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j27-20020a5d453b000000b003095a329e90sm269781wra.97.2023.05.29.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:35:40 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzystof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v3 5/5] thermal/drivers/mediatek/lvts_thermal: Update calibration data documentation
Date:   Mon, 29 May 2023 17:35:32 +0200
Message-ID: <20230529153532.3541327-6-bero@baylibre.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <20230529153532.3541327-1-bero@baylibre.com>
References: <20230529153532.3541327-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Update LVTS calibration data documentation for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: Fix issues pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 31 +++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d5e5214784ece..9185d02003633 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -531,7 +531,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- * stream index map for MCU Domain :
+ * MT8195 :
+ * Stream index map for MCU Domain mt8195 :
  *
  * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
@@ -542,7 +543,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
  *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
  *
- * stream index map for AP Domain :
+ * Stream index map for AP Domain mt8195 :
  *
  * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
@@ -556,6 +557,32 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----ap--tc#3-----> <-----sensor#7-----> <-----sensor#8----->
  *  0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47 | 0x48
  *
+ * MT8192 :
+ * Stream index map for MCU Domain mt8192 :
+ *
+ * <-----mcu-tc#0-----> <-----sensor#0----->        <-----sensor#1----->
+ *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <-----sensor#4----->        <-----sensor#5----->        <-----sensor#6----->        <-----sensor#7----->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for AP Domain mt8192 :
+ *
+ * <-----sensor#0----->        <-----sensor#1----->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <-----sensor#4----->        <-----sensor#5----->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B
+ *
+ * <-----sensor#6----->        <-----sensor#7----->        <-----sensor#8----->
+ *  0x3C | 0x3D | 0x3E | 0x3F | 0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47
+ *
  * The data description gives the offset of the calibration data in
  * this bytes stream for each sensor.
  */
-- 
2.41.0.rc2

