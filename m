Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0596BA5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCODpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCODo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:44:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427C91BAC9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:44:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u5so18695616plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678851897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgOQZSMS8pPlt6XQyt85uPffzzE60v4WG1PXi+ygQM=;
        b=lgxwc8QzbhhRGX2ipj56laXav+/xC1sxXICdT3C8eFkuHwW7YsZ78gsYfY/vNm3QUr
         O4/kgZsxsEqYxWg3rcEzsyYMG+Hq5f8qZeHL4LasPHHVmha1rEtpLUzp88o2jPsrHxUj
         0WQblNF7LH6ij+/Qtk9t+MLRQOQVDCv4DdUrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678851897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCgOQZSMS8pPlt6XQyt85uPffzzE60v4WG1PXi+ygQM=;
        b=0JwJgum7NjSCgFb8Mko3bwr7gdl9XBQJx5VRmfnNdwwl+p1884kg/uZH4RiWbc9Ygl
         8xtiVXNTacs++1z6F93f2iSGu9kQy+hLD4SOlSm4ZIQnbIvV1dd7eB10z8Q5xIyU+VRq
         ja/5IruR+2yfpXvCl0atRMKq5prDk49MLRIquGwNQljKGS31/CfSIs0anJ1dmc2Y5SO/
         vThcGoSn7cAfXIo49WO+m6hMrnr1jJ3liSUvojdUqQm007vhvgcfJ+UamXNGpGxgHDXM
         NmvDpcLJa8wDUBvy4TWuFqkjKyCmbRWZK7HO49jggxB3XypQ47yi41XRlXmZ6LfZZ8ir
         kNxQ==
X-Gm-Message-State: AO0yUKWEXjEQjuH9Epipy4Fuyw+xK+eWwM/ybkgnfqNVZ0cT1FYhJvnY
        BRel/u/BlsmVRXZ+kKzWHkOPfA==
X-Google-Smtp-Source: AK7set8vm6w9RioA2nfhGaRBt/IA500jhyRIi/xVskISt1EDsZtETEiCXHOgMd0uL/e3yQrbH3RrAg==
X-Received: by 2002:a05:6a20:5493:b0:d5:e681:15c2 with SMTP id i19-20020a056a20549300b000d5e68115c2mr2170861pzk.0.1678851896791;
        Tue, 14 Mar 2023 20:44:56 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d05c:f360:99cd:4be2])
        by smtp.gmail.com with ESMTPSA id c11-20020a62e80b000000b005abbfa874d9sm2349107pfi.88.2023.03.14.20.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:44:56 -0700 (PDT)
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
Subject: [PATCH RESEND] thermal/drivers/mediatek/lvts_thermal: Register thermal zones as hwmon sensors
Date:   Wed, 15 Mar 2023 11:44:49 +0800
Message-Id: <20230315034449.2604197-1-wenst@chromium.org>
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
Resending due to lists.infradead.org outage yesterday.

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

