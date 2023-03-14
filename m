Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22DC6B8ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCNJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCNJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:32:28 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4220562334
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:32:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ja10so6260135plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678786343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQBaP6NNs1+swFBxxR3m2gMTZaTzSsPIhqbxCO9Jwuc=;
        b=KEUhY5Lnh3J0DfiMK/EIpX4abofPH1BNKrhl7lM+LBfivflYuX7vmODvAnf9+hFFFN
         1EjfpCxBU+y2SMGhQd0cgFV/41bFJzmo2HvS+s7M4IcOc3KnroS5/27+X9wvRQtfS+5G
         t5T5t4SGEfzJZHlgULAmcqmwvhNfytBPGmuHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678786343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQBaP6NNs1+swFBxxR3m2gMTZaTzSsPIhqbxCO9Jwuc=;
        b=jFia82j2vYbtmj18WvV08H2l5Hj48mmClpdiQS3dkPDZRagZyAZTYATO69/tR9Hgl/
         PRShIJgJSo63IfuFnD4otrXlMESEwfkqmMiMFzcalWt0IgXc1i6XB2OmedyBmehs1JAt
         Zvxny7FHb3idLXyI8KyKrTVIbgeyrhBZcuYU078vwNIp5s7eqlmpyab1oG+w2rPgkTzJ
         K1/OMi+P2/AtNUCLO514WJUzkJ8C6Ooos9XMxlWIS3JHvgRrXLLaykXdg9MKRTckIKNq
         2NDaE3+K8dIigff8oMbDgNjtQuWZJbVv7W0I4tPyVya+CDRwzNa7ttUsQZ8QSfzojM/M
         P92A==
X-Gm-Message-State: AO0yUKW3BElkfEUZ79LivbPAkt82wRCBLxI9tl8xZ+pXRht9Sjy/ST1R
        F2kkMvYqzOSXrNji5/GW51oeWw==
X-Google-Smtp-Source: AK7set/DIpXFg0newybBhwUu3htmas9rXlgHCKNwPgT0x6mYJsVvNIA4lbPT2rnDfNRIEmKjoj8xgg==
X-Received: by 2002:a05:6a20:bb29:b0:d5:9a0c:ef31 with SMTP id fc41-20020a056a20bb2900b000d59a0cef31mr698214pzb.62.1678786342779;
        Tue, 14 Mar 2023 02:32:22 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:99b4:e339:ed01:f0c1])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78e58000000b00593e4e6516csm1158851pfr.124.2023.03.14.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:32:22 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Register thermal zones as hwmon sensors
Date:   Tue, 14 Mar 2023 17:32:13 +0800
Message-Id: <20230314093213.2450396-1-wenst@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0557d1c61b9e..15f317c42718 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -19,6 +19,8 @@
 #include <linux/thermal.h>
 #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
+#include "../thermal_hwmon.h"
+
 #define LVTS_MONCTL0(__base)	(__base + 0x0000)
 #define LVTS_MONCTL1(__base)	(__base + 0x0004)
 #define LVTS_MONCTL2(__base)	(__base + 0x0008)
@@ -996,6 +998,9 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			return PTR_ERR(tz);
 		}
 
+		if (devm_thermal_add_hwmon_sysfs(dev, chip->tz_dev))
+			dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
+
 		/*
 		 * The thermal zone pointer will be needed in the
 		 * interrupt handler, we store it in the sensor
-- 
2.40.0.rc1.284.g88254d51c5-goog

