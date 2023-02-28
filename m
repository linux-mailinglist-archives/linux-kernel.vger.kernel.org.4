Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB526A57FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjB1LZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjB1LYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:24:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067D20577
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bt28so9332120wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS0guMTDp+HnyAw7+AQL4Z1IASYNHpKANmt65sLAMFo=;
        b=As5cnEs6KbgFzz64hQ+xg783ZBl8nVKUvbDG3lsn7Xxbsgc+d5VLgBw9h8c2bEVmYD
         Q0heWRMa2Z0RnelgQzMkmiEu+6pZfz6z6lZNnPeSpSW29d/425F+G7wPhR3AjBALI9Fp
         LoLvyYA+Ae7tnAxSxdZ8lls8x4a0Vy/y/4AHj/sjTk4H4x5/afakN2wU3/8SsQlR1nQ9
         75wqnM/NAkWSDsqp89Nr/sYttZBTCYCXLCdnG3OGCk13jiI/uOOBmCCQLTZoy7KlmE40
         jLrMIP8BAx1wwJfjDna2h+qWZRhY6xh+d1qOA3hNheEgO0PYKNUGGrXcLdz/DQ/hFh8U
         nmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS0guMTDp+HnyAw7+AQL4Z1IASYNHpKANmt65sLAMFo=;
        b=lTFC36lTy+H4TQRsLizzEu+CUQmF8UEGGazZaXG4B0WObvNob+7yKH+yc3F1kU/TDC
         OpBCwCp1B0DB+uSMDnYOZACSVdXG5RUdc2tNpdR4tfGEyHsvh6Z4HUx/oZvfb4vCy0hR
         BhrClQRagIYPtWMnN9ZLGMXcrHtAI4qho9dGwPVSM3VKqHHArKOJB6LaZRO/yPFe8kx2
         RnNY+vbdxEqfp5CpmrIp3P+9XHVf2Eo43exahL3X+C+AGp2C6qAcQp7sS2HTWgjpAFrM
         nuMLwL/2vXYeSEKGQreFE+x6G5M2z5OR0TtrHhVuTFPdfiLDqj2BhsstM9OtXvj3a9qn
         7gkg==
X-Gm-Message-State: AO0yUKXuxFLC9mavQ5wk25LEstcgVoLPtySkTUxWwHPwbtlpn2Doshxc
        yPa6LziHuViD4F02x+5MNCND9A==
X-Google-Smtp-Source: AK7set939nHNbOmdgT6Wu8HHPjxaaVa2lkIb1WW2vwQOAPYf48dfKkYhJw9q94O+ug1045p75CfkGw==
X-Received: by 2002:a05:6000:18f:b0:2bd:d34e:5355 with SMTP id p15-20020a056000018f00b002bdd34e5355mr1611428wrx.20.1677583418047;
        Tue, 28 Feb 2023 03:23:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.de>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 15/19] thermal/hwmon: Use the thermal_core.h header
Date:   Tue, 28 Feb 2023 12:22:34 +0100
Message-Id: <20230228112238.2312273-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal_hwmon is playing with the thermal core code
internals. Changing the code would be too invasive for now.

We can consider the thermal_hwmon.c is part of the thermal core code
as it provides a glue to tie the hwmon and the thermal zones.

Let's include the thermal_core.h header.

No functional change intended.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/thermal/thermal_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index bc02095b314c..c59db17dddd6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -17,6 +17,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_hwmon.h"
+#include "thermal_core.h"
 
 /* hwmon sys I/F */
 /* thermal zone devices with the same type share one hwmon device */
-- 
2.34.1

