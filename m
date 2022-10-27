Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9873E60F127
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiJ0Hca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiJ0Hc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:32:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8AA165509
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:32:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n14so332631wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HOFnbsaMjj+z0QevarG84ke4eXp98Xi5RLnaRZADVG8=;
        b=JijJgT1N/Pkpag73UjzE9AE7TzOg/CBoMBHYIQZZpOFuSqjMxDLd+ZphHNzknTCjFM
         CY5RIk/L7hru6tivh63LiMxr0oTClgyEgvWkt4FgJ6jQkEmpG54binJTkyVxgDR8sjn8
         3vjM0WtfQPy9paY9Ch+htY6gliRlzEjN5xL+ZmRs4kA1npvKDU1Mck5xxAjTMoCxgiZf
         KeiQxcA9qxxxbZ6OY9I+Lezzun0pZchu2vRSXHVJWW73D6eMedjsBN9d1sg+KBoasTLn
         soByV6hbvatP/U21JJUednK9uQA5BWv6+bf3M1+FKPYrDi309lMpUtDIDjwjPwUJSe4e
         2Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOFnbsaMjj+z0QevarG84ke4eXp98Xi5RLnaRZADVG8=;
        b=H2GzjhWiThgUhKbsSAOAt5a4U1F7wIaiZPc6OWnmNDyx3cDJW0ncv+3df4pq5923/8
         eHv+BKkDRryfefM2crD3rojms/pEEytXxc7+6LKfurM/rv1vDRe00xoDT/19MVja9WSE
         U3LFWt2rMvOgzDTO9UqcmmRHO1YbTsfpwTZNB1hec6CVl3O2XmFXrQ0FRakW3jpvTUOc
         kf3Nm4e7Cne2FAajPlNmzo+CKWKLhOW3wt2+WGkPhE7k5d3dgBpZiwOGaUx7D+uEu2aS
         xFR3IRtJ6vpcen1sBz2ycFNLKdU/2kqWaVcp8PEHXpyis7/zgy8Bsvnc2O9sJIP0j+Y2
         Tk4w==
X-Gm-Message-State: ACrzQf1iV7QJXtGifWbuj3wtI5gvK96iLowFUyWeVMnZh76LOU//r/Df
        1Kz+h3qiNSTWL8vvNV32VTd9jaeukXbJhf1o
X-Google-Smtp-Source: AMsMyM5CNPLBPwYMeOSiOvpEWq3RexpoSGSYWI1DAbksmu+zJlzw6rBgv2uRY92+0KJaZMe+7fcvxQ==
X-Received: by 2002:a05:600c:524c:b0:3cc:ed19:707 with SMTP id fc12-20020a05600c524c00b003cced190707mr4951714wmb.80.1666855945320;
        Thu, 27 Oct 2022 00:32:25 -0700 (PDT)
Received: from centennial.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6b12000000b0022e47b57735sm398251wrw.97.2022.10.27.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:32:24 -0700 (PDT)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v2] drm/lima: Fix opp clkname setting in case of missing regulator
Date:   Thu, 27 Oct 2022 09:32:00 +0200
Message-Id: <20221027073200.3885839-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Commit d8c32d3971e4 ("drm/lima: Migrate to dev_pm_opp_set_config()")
introduced a regression as it may undo the clk_names setting in case
the optional regulator is missing. This resulted in test and performance
regressions with lima.

Restore the old behavior where clk_names is set separately so it is not
undone in case of a missing optional regulator.

Fixes: d8c32d3971e4 ("drm/lima: Migrate to dev_pm_opp_set_config()")
Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
v2: revert back to using devm_pm_opp_set_clkname and
devm_pm_opp_set_regulators
---
 drivers/gpu/drm/lima/lima_devfreq.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index 011be7ff51e1..bc8fb4e38d0a 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -112,11 +112,6 @@ int lima_devfreq_init(struct lima_device *ldev)
 	unsigned long cur_freq;
 	int ret;
 	const char *regulator_names[] = { "mali", NULL };
-	const char *clk_names[] = { "core", NULL };
-	struct dev_pm_opp_config config = {
-		.regulator_names = regulator_names,
-		.clk_names = clk_names,
-	};
 
 	if (!device_property_present(dev, "operating-points-v2"))
 		/* Optional, continue without devfreq */
@@ -124,7 +119,15 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	spin_lock_init(&ldevfreq->lock);
 
-	ret = devm_pm_opp_set_config(dev, &config);
+	/*
+	 * clkname is set separately so it is not affected by the optional
+	 * regulator setting which may return error.
+	 */
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_set_regulators(dev, regulator_names);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
-- 
2.37.3

