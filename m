Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5372DDB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbjFMJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjFMJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:31:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0618E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:31:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-650352b89f6so4053501b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686648671; x=1689240671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc080pZonONkhSsubLG/knzeXyUNBhLK5ILmHhWW6gY=;
        b=F5lwH/cp1FKK1VmvuKHlk391kR8oaI/Gw53UTVgdZp4Bvu5DWRhyYKwbhIxte7QsXo
         aTcMjBXzirBtr5LzsxRvjqXnou8A4EvWuAx0Ja+JVeLThbN63hlwoXfUnnl/PX7XnIZf
         pn9NbU31FXmX9FA0w1O/4zA0Y8vTxsnMH9MSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648671; x=1689240671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gc080pZonONkhSsubLG/knzeXyUNBhLK5ILmHhWW6gY=;
        b=CrMoBhjT+UTZx19yvxeGE+06zFmq4xCCWLQLckZWCk0dvz6BB7UQ9kbndBvoOiC+KG
         RPL5T04XIHFi7Pkg6Bv+T50uHV6LEcug87BvHDoQhEVW8vFCJbKWubVAOO2HZYN9TSDA
         WIa/UuFebGrwNIgBn3FNsXY2z6P9Umr9sFUPkqmN5VYBMlTykPL0GdSY262YhBqckkZc
         A4r819Gh0G5JW/zn06Ck0lp7jOagaS0iYFPc4eepGAclvO/+t1JEUo9qbgfCwglcsBsG
         ChviWdnTG9oxVoOd5+SJQFlxhm9HQNgRzbRTJlmMpeN7/JGDbItdlCNa1TJGEOs9605n
         mqng==
X-Gm-Message-State: AC+VfDwiYUNpMEJHbUGVhkDRe66PwGet3+uN/KKUhs9KWgx+nMTaHdvw
        0jOd2lojDy3Qk5f4NSi1Z+WKEA==
X-Google-Smtp-Source: ACHHUZ6x1E9VGgJFIYX58bAoFbw/BYTrc7hIUdhOm9wToy03SWtIstRj+QyZ89bKldxsz8tk+tRqgg==
X-Received: by 2002:a05:6a21:99aa:b0:114:6f3c:4332 with SMTP id ve42-20020a056a2199aa00b001146f3c4332mr13451371pzb.24.1686648670764;
        Tue, 13 Jun 2023 02:31:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2d00:6d98:ebb3:585])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001b3df3ae3f8sm2160680pld.281.2023.06.13.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 02:31:10 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] thermal/drivers/generic-adc: Register thermal zones as hwmon sensors
Date:   Tue, 13 Jun 2023 17:30:52 +0800
Message-ID: <20230613093054.2067340-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register thermal zones as hwmon sensors to let userspace read
temperatures using standard hwmon interface.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/thermal/thermal-generic-adc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 017b0ce52122..e95dc354f192 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
+#include "thermal_hwmon.h"
+
 struct gadc_thermal_info {
 	struct device *dev;
 	struct thermal_zone_device *tz_dev;
@@ -153,6 +155,12 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

