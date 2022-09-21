Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C45BFB89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIUJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiIUJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E592F68
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so849354wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=K14JYYfltM5e6DhctguBDMDG6gANKg/guX6Cskv0XezmqFtEwuxu+qtRKjkfivm9wE
         GEQvfu/oZlIt2txxz313ppgPFTB9HDYKgj1lNuTuKvAXyKvOD5IEUi7PJBnuXftziyjM
         8mpWzqCEECtawpB+YbJf8cTKRc+8pJR5srNt/2YwRunzgnKDXx5NdHvZ8JKMIUgNYMr9
         6oT/hsWfHgrASf72ALGQmnaQSZBRCXFxm7p4EUuec54RU+1bGtfSYsxp+JbzVywJG3EA
         6qQgsxtwn3YgME8FxBnTF7CLw9GgBanBQHJj9ZqUgbqWaKQNyctL9dS8KGfqD5iS9sTz
         WV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OHXbaNWdyZ0Wkkc1xL/nI14ReQ0AVnlGlwSXS+lV7dA=;
        b=tHAX0v7LPuDrrwYApkF2zgp48pRjSiYTr8PqkPPR/63r0rz5iQzVCk9ojyLKU6+0mU
         Yc0IaJ9SJKGzGT4HDAa2cmnOjq3N5De6L8YnV/sXF1Ta9ipwwHwflcBMTiH6KQ5RJrXT
         StXyJuobrOVwSGDazxxIATl5oIG35atkVKTh9xg5X499Mpo5cwDmACy1sxcDXeCVPndO
         Ia3eXa0GQvLk2djAInnRJ7ZyWzXgZsPmf1/KaktcPTZBf83AyxUnkmnGta6lBUllsO/6
         BarsGvh4b2yqvGUJjDEmg0uthQPcQXp49cNrpetHG4nwaTV2oMTa4jlEG3Yhm5mqWMn3
         R6mg==
X-Gm-Message-State: ACrzQf1Vl/j+Q8Pc0mC9ryCZCJOoygy5tz/wy1Q88/32saOy7jUMNwF0
        aKfTT94PSmZJCrdrRgrAXdcLAQ==
X-Google-Smtp-Source: AMsMyM64H/u/UhdGI3J638/N7/v1XbmrbMisCRv4KeCvuIVxsawhquL+yrAorxkMb480hr9M6LWvXQ==
X-Received: by 2002:a05:600c:3d8d:b0:3b4:cd96:171b with SMTP id bi13-20020a05600c3d8d00b003b4cd96171bmr5365658wmb.43.1663753430445;
        Wed, 21 Sep 2022 02:43:50 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 20/30] thermal/of: Remove of_thermal_get_crit_temp()
Date:   Wed, 21 Sep 2022 11:42:33 +0200
Message-Id: <20220921094244.606948-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic version of of_thermal_get_crit_temp() can be used. Let's
remove this ops which is pointless.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 494e9c319541..bd872183e521 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,20 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
-				    int *temp)
-{
-	int i;
-
-	for (i = 0; i < tz->num_trips; i++)
-		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = tz->trips[i].temperature;
-			return 0;
-		}
-
-	return -EINVAL;
-}
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
@@ -529,7 +515,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-- 
2.34.1

