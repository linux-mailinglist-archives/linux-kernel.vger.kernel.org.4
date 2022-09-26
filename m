Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294D25EAA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiIZPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiIZPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED383042
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so10432558wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G/YO0fJeKfkSzRqdgqFU3ij4yJaDOnZPHmbsRpXJf/A=;
        b=HpElmg1xiU/vguSyDzJ1AVanARz2FCVZ1PxbcRCFVeKyhTaIHkeqfn/IojyB2w0HO4
         Xi+G2LDqzZOsYp2W0z8luiIbB3njOLZ+B0QGF5MkMKXFHEfqP93A4CKOxQRuniq5PmJm
         pAko7VTCs3uPqq1Ui41khWR2zYnsQShFi9lLPJvfRAWLW5mX/b6GdFUOUk+D5dvKAitz
         u+8WMlbY+bl8Rltp71qjdElQvVsTCdAcnMUXYoHxMX7w72U0hCyrjdQwcel3+TpuiFf0
         BfCe9H28ZLWf3TMdlTuP8pJ1oiehJEIgkAkG+IkBeaXC+nfBdtKcZp8o4bYEi4IoTy9A
         8fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G/YO0fJeKfkSzRqdgqFU3ij4yJaDOnZPHmbsRpXJf/A=;
        b=xk4QFPzW6+DJ2yQaiHBYJxGJAvwAsJnuf1BEdD45PGIwgnUF50g3q9KeTb46BHH6vl
         zwTI1MJWTichRr0Kwov8qeDYQ+miO686iDYG9NmovOnmKHjz+mB+02BEPaRCh+7hFayy
         oh+ioECoxez392DxgFvxoBki1rALTMpBtOV0cRZJ8fGUdUMPl7c7NTzzw37tew9sQsOE
         5KRUPtW8Wlg9E7pVJr0fEfhMnciwA2jNbCVgieaZ/QWSvkMjwV277lA5bF1TAomteBlT
         dGwRpiYaVctd8z8JP13BYtRNNMh2QtXk/MZPh5Fnr/CAd3WTi0rvv+bjxvMKtyvieymI
         djXw==
X-Gm-Message-State: ACrzQf28xgoVRPos/xGb8ckyao4gZ2oGT1NkqtcZ+GCElZkto484SO2t
        JwRqqaAlNqOp4W5dmn1gsOVluQ==
X-Google-Smtp-Source: AMsMyM4R1nrXWrLOxDa4zUaQAaa+sznK9GNS8ItYzxSWCtLIvEau8p5ub7y1UiUcsuWn2pS6FtTlQw==
X-Received: by 2002:a5d:5089:0:b0:229:3151:2865 with SMTP id a9-20020a5d5089000000b0022931512865mr13264139wrt.81.1664201200781;
        Mon, 26 Sep 2022 07:06:40 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 17/30] thermal/of: Remove of_thermal_get_ntrips()
Date:   Mon, 26 Sep 2022 16:05:51 +0200
Message-Id: <20220926140604.4173723-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

The thermal OF code uses the generic trip points to initialize the
thermal zone. Consequently thermal_zone_get_num_trips() can be used
and the of_thermal_get_ntrips() is no longer needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h |  5 -----
 drivers/thermal/thermal_of.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c5990a3fcf8a..b00fc1913734 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -139,13 +139,8 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 /* device tree support */
 #ifdef CONFIG_THERMAL_OF
-int of_thermal_get_ntrips(struct thermal_zone_device *);
 bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
 #else
-static inline int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return 0;
-}
 static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
 					    int trip)
 {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 2f533fc94917..89afa59c4915 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,22 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_get_ntrips - function to export number of available trip
- *			   points.
- * @tz: pointer to a thermal zone
- *
- * This function is a globally visible wrapper to get number of trip points
- * stored in the local struct __thermal_zone
- *
- * Return: number of available trip points, -ENODEV when data not available
- */
-int of_thermal_get_ntrips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
-
 /**
  * of_thermal_is_trip_valid - function to check if trip point is valid
  *
-- 
2.34.1

