Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E455BFB60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIUJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiIUJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340AE92F65
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e18so4009597wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yxHcU1hX4elGm4XFMd+giLQwBSqd0y+6MVuYVIhVRhA=;
        b=AGE6SlQC5fST7A8hLnGpiw3pw13JnBLmPaet5nBFAAp77pCQG76vl5OFYX64iXA2Mu
         v0z1XM3WybDKlhnrc9QDIpDytfEd9ef4wKMA3ODtSxjp3ZbmZkvZ52TfxHeEIolylul6
         gzukVQXOR7KgaP8PtSeQQMMiFccqAZsTKEPfNyTqvAbzhJMfv2PO7aT+6upg2XQ3M+uN
         cMQ1EYtGQ/B/mpAC7Q9Z/QpR8vhWEevKMysnFjdqRzH17bRS7NZ4Pn82s3ROcAvKt3Fl
         qC6psXuz70Jtb6h88NxvL45ufzrPThRDHtjkaTaR0Q9Z2Djzgq/gJCpZYbPO8qN5Xeeh
         6l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yxHcU1hX4elGm4XFMd+giLQwBSqd0y+6MVuYVIhVRhA=;
        b=2ZDThOhanLYlQkLKdpwKvlIdHiMyRRBJAM6GDDJk/GlmSGkxyd0jP6Y1IrVsnOeoFp
         0q2Y8pJcheZPvQlEAfTQjd2uKE6vix17V1/vKj9y9m4XxVpcxAoRKBSSdI2iA27m95qm
         D9iaFX20+r3mhhpbpKqNcjaGc+5EYA2QymogZZNA/igQbW8hpwOxCHUGybcPm+kiwlyt
         FPzkyATx4UBzXCH04yxFkV0y+vDnwkoupmfKtL9xzfnrJAG7PJ+1hSh2aQqB9FEpqsHp
         CHiP21nn8RPq/eOTFUqCs9SQHaQ6rc2+kV3M3dyxp9xlq8oPlMwagJfuclELIqCaYzV/
         jLRg==
X-Gm-Message-State: ACrzQf0R1bbrVn0adQ0CPFCmquNLlZAViN5+Tr4v+0GLrnRU9u7/ZNBH
        EPtuiS9Da/kyXELdevsJHls93A==
X-Google-Smtp-Source: AMsMyM697CfXTEn1H2PKV8IVJAJaEW+EcQzErjxWZg1L2SnxXcL6qAFfz9aDQQvfCfivZBpnSV5KTg==
X-Received: by 2002:a05:600c:a47:b0:3a6:5848:4bde with SMTP id c7-20020a05600c0a4700b003a658484bdemr5140977wmq.189.1663753405269;
        Wed, 21 Sep 2022 02:43:25 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 04/30] thermal/core: Add a generic thermal_zone_get_crit_temp() function
Date:   Wed, 21 Sep 2022 11:42:17 +0200
Message-Id: <20220921094244.606948-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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

The thermal zone ops defines a callback to retrieve the critical
temperature. As the trip handling is being reworked, all the trip
points will be the same whatever the driver and consequently finding
the critical trip temperature will be just a loop to search for a
critical trip point type.

Provide such a generic function, so we encapsulate the ops
get_crit_temp() which can be removed when all the backend drivers are
using the generic trip points handling.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
 include/linux/thermal.h        |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fa0f89a24b68..2495c174a226 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1144,6 +1144,33 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
 
+int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int i, ret = 0;
+
+	if (tz->ops->get_crit_temp)
+		return tz->ops->get_crit_temp(tz, temp);
+	
+	if (!tz->trips)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	for (i = 0; i < tz->num_trips; i++) {
+		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->trips[i].temperature;
+			goto out;
+		}
+	}
+
+	ret = -EINVAL;
+out:
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
+
 static int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 				   struct thermal_trip *trip)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5350a437f245..66373f872237 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -343,6 +343,8 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
+int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
+
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-- 
2.34.1

