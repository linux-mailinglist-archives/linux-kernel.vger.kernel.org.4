Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739E679ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjAXQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjAXQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:35:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9D4C6C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:35:16 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so11404876wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWY8t6MGSD+ddhFLpUPHcH1FizkiNtOJ0a7ycgsdp9A=;
        b=tRFUEFCqosQ2VLKNFVJlOmLwDyAusvTvviijp1YiLfpIrYW8hO4cHDzGlFF65sb5aY
         +1GcO9Nnoam06P9O7wKozz7TFIkiry+R5z9UnSQd/T2u+l60RcSM7wWCZDAg0z5keo2F
         erIicnRZXjv9FaegvYDEKRyvGPJrMm6cOOjBb3AvfdAABcbEN6K5ogQgLNYWK0xKHuUY
         VOq9cXmbyheFAJjhRDcuHKF7MCuFDeWS5wAWXK2/d+4K4LQygxuk10CVLxHV6NSdTSZ7
         7JTDTLF7duMsu/ccWK1DVxAlz8WQU/OX4ayXinWlAzSFPBX7FP6WqUosOre+N7t9g+n2
         uWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWY8t6MGSD+ddhFLpUPHcH1FizkiNtOJ0a7ycgsdp9A=;
        b=zI2cvg74HbnFZFme+jMZaFN210+OdhY8JYVEevL3B+fIGsM44fXq/UZVqV5CKgInUm
         kaoDHMrUlmIgXqPY1u9Zfe9xbxcdnmYf6Xd8f1imyF//mfcytGK+S43HbRIt8HSEvb7h
         Pwd90FzjwE6mM/FN5Zld9BqyCLc5ECyxJshTB26mXpkRfLTzTlaTVcha7eY7Qb1C45+b
         8LeXU26oaxuPao4a0WevtJI1JyM3/IPwRWlt23UtY6hJRspnrcss9c/Hnng5eNeumH83
         T0eZgd/sJBMwRym83/CoCsO+Fcc4sEYzZkpYSRcvfUdjDgRuPjYSxlNGVqkAlmgOA0J+
         hqqw==
X-Gm-Message-State: AFqh2ko64S7hTA66aaW1FeuTAjvhQ0f1sfJRIY0Esg9utPZ2bDZWz0e3
        3pUclhJeZ7RPFxnRAme39xeeNg==
X-Google-Smtp-Source: AMrXdXtEsvhEpSWe+OLcAKIsAFoPG7UhBOBeQiMUSEIqblkGFiizLQINmdJP1+ZtFxCkSQrR4HSX3Q==
X-Received: by 2002:a05:600c:c0c:b0:3db:1caf:1044 with SMTP id fm12-20020a05600c0c0c00b003db1caf1044mr22587617wmb.13.1674578113098;
        Tue, 24 Jan 2023 08:35:13 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bcb9a000000b003db2dede1a2sm13605171wmi.26.2023.01.24.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:35:12 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     error27@gmail.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/int340x: Fix uninitialized trip_cnt variable
Date:   Tue, 24 Jan 2023 17:31:25 +0100
Message-Id: <20230124163127.445942-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y8/1ccQLn41w+Vek@kili>
References: <Y8/1ccQLn41w+Vek@kili>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion to the generic trip points missed to initializes the
extra trip points to zero in case the _PATC method is not found.

Set by default the trip_cnt to zero.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 7ff5d9b1c490..c113962a599e 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -121,7 +121,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 {
 	struct int34x_thermal_zone *int34x_thermal_zone;
 	acpi_status status;
-	unsigned long long trip_cnt;
+	unsigned long long trip_cnt = 0;
 	int trip_mask = 0;
 	int i, ret;
 
-- 
2.34.1

