Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C247D5FD6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJMJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJMJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:07:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55FF120BDF;
        Thu, 13 Oct 2022 02:07:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b2so1246031plc.7;
        Thu, 13 Oct 2022 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRGJpqFdbfE6yJesxokWxqFXp0bV66QSzDLdJwmnCDM=;
        b=R58txszMESc+23Mv9odsA87SnlDiQrEpUg+n4maXgIT9iQ5NemaFExRIbaa/qv0UDG
         HKXeBEnAfzKdkJ4RoqHW2gC9PwVY66CNS0cpG3dP0KwX1QjeeD8I/EWHdcYeVaSdIS98
         n1Dg8ZOidv9ef1XlvMW6rgSpkPsxGJSkM8kO96uQcOeLH+sm/sq5sFn9TVPwm2qPOPGE
         YI2BPU6ESPoPvb90iF8nxBoT/w6C+hFd8App/2IlzKuGCjAm0qe2uW6lrdX8jlKcrY7V
         rrsjZaAt+p4JUDcHZ5B1HLKzj9kMmbyV02EUQt7/SikmUV8gRBvpMSqebztOmmJ84Utk
         yiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRGJpqFdbfE6yJesxokWxqFXp0bV66QSzDLdJwmnCDM=;
        b=4d+XhL6LMT3YUh9hAEen30YJRu2obGt7QyS+T6OMoJcEKHlOjKGK/C8w1QQ1bGeJlQ
         pMeepTLQNAQftiqRWrA6ybOHDo/H0T3Gwf0382LgOI5hsUA5uaiV5CSEq2JSZvScugZu
         mWgxy7vyFuAKEUlbuaLKUyfBW2YU1cy/kAE/bfo90AzcGS1lLovFW9eIJJ6uDLayqjdN
         33MclrBzu8ezftLUlInVHkbMKJmXK7uOeiGgBZUZ5Fxe/EatM1R+cLDgrUEkualbw2NI
         kpyhkVNEqVUEftfESXdWgFM57r+ctGPRh9ivFzU731zxihSkeTmHyvyYoUQB1XppeaF8
         Ydyw==
X-Gm-Message-State: ACrzQf18H3AwGhOyWtPnd9Y0ZfDpmLxRoBaY71wZ6xKMRoNVosw+mTmj
        bBid4ZYynGuboyxWt0ZGhPU=
X-Google-Smtp-Source: AMsMyM7vZ//2NNlI1b2QH0QgSN2mTYPshPy+LJufwxwlgcqlBZqYz87kMipJoLdqGkCLZ+IO9f4dtg==
X-Received: by 2002:a17:902:7c8a:b0:17b:6eaa:5da3 with SMTP id y10-20020a1709027c8a00b0017b6eaa5da3mr22759230pll.33.1665652061034;
        Thu, 13 Oct 2022 02:07:41 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090aa61100b0020063e7d63asm2785957pjq.30.2022.10.13.02.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:07:40 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     lukasz.luba@arm.com
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/governors: Remove integral_cutoff parameter, IPA is more regulated
Date:   Thu, 13 Oct 2022 17:07:33 +0800
Message-Id: <20221013090733.28462-1-huangqibo.tech@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reason 1: If the integral_cutoff parameter is 0,
the current temperature is greater than the control
temperature, and err_integral continues to increase.
If an abnormal situation occurs suddenly, the err_integral
value will become very large. Even if the current
temperature is lower than the control temperature,
err_integral will always exist, which will cause the
IPA to run out of control and cannot return to normal.
This is the problem I'm actually having.

Reason 2: The integral_cutoff parameter is difficult to
confirm the optimal, and can not bring good results.

Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
---
 drivers/thermal/gov_power_allocator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 2bdf8d797e3c..87e87ce71ff3 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -221,6 +221,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	s64 p, i, d, power_range;
 	s32 err, max_power_frac;
 	u32 sustainable_power;
+	s64 i_next;
 	struct power_allocator_params *params = tz->governor_data;
 
 	max_power_frac = int_to_frac(max_allocatable_power);
@@ -241,13 +242,11 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 */
 	i = mul_frac(tz->tzp->k_i, params->err_integral);
 
-	if (err < int_to_frac(tz->tzp->integral_cutoff)) {
-		s64 i_next = i + mul_frac(tz->tzp->k_i, err);
+	i_next = i + mul_frac(tz->tzp->k_i, err);
 
-		if (abs(i_next) < max_power_frac) {
-			i = i_next;
-			params->err_integral += err;
-		}
+	if (abs(i_next) < max_power_frac) {
+		i = i_next;
+		params->err_integral += err;
 	}
 
 	/*
-- 
2.37.1

