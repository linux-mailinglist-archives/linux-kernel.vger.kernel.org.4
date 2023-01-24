Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3875D679AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjAXNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjAXNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:53:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99649549
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:51:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m15so11481935wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdNKBm9dCMT5uwH0jJSmOk/S2BVD6poXI4UEU8hMcS4=;
        b=lx/21U8jUJGqSVM9i0svqPlaaG3+0DuV1wZ6usLlLKooLymgkn2yujl6xNPqW7Zvh9
         9hfPkIDo7UW9c/xCwVawPbhZTYmVHn297MrmAjg3e7bTVZ/MUPZ19JsmjUOH+uwW4mzI
         hY8Z3E6rV1ybpHQTapr7tWZUA0mgoYr9XmGQ0JLN0DwMfpXyUcjD0fhSNT4/nmbY2Xtz
         uM7Xf9/FUp7LVaikISToWjm5fFb284ZeSj6pxXs0I4/ZraPjaxf2+xuyEGGeMgrK5bLo
         LTc2rAIlHhQ6Z8Eo6cg6HKsoGZ7bKEhOEr9OxSpQbFuhj0TFRVsOVYcSgVxb9TV7Jwq6
         NFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdNKBm9dCMT5uwH0jJSmOk/S2BVD6poXI4UEU8hMcS4=;
        b=2lOgiYsZmZkEs+dUMyu3WXaiYJkW/KswC67RpOHytwNuRNRBt24mhVWArTb+I0GEVR
         vSdOp+Cb7ISXXMShuMN7F6h+l4uu7s9iJylBOYxBpd7fPZm6UujiL/4BXhvfyeXq9hGt
         5GLuoMnq0vzDsiXvNuLpQ5E2FDXJhYwROiDvN53WeMseg9PZr7ZTpw8rtasM2lwvB/OU
         GkyLSbhki+FEEHWHGBzbyX/tFRcF4H1MhqYg4bSM3uqtjeKzGAcgeGimLJjV9YqkDY//
         /WKPZTnNXXNGuso8+CV3aLkOtu4hg9dIdcatXlJhH2q5lHPuyphlPj71pz/qML79FkPU
         1yZw==
X-Gm-Message-State: AFqh2kp1BeFDIPSDJEvCQZg+S88xUe+UXJyNtVU7KVPpDJUzhARCIQ5m
        UmNaS/5arZUrvmJnaCrciy3qxGq0F+qYJ//9
X-Google-Smtp-Source: AMrXdXunikjcS9s0xgheXf7NKMfZtNWludHny4GcAoKNgTN3yRN01dPUYcB1LKn6hvPPJlC32/KJQQ==
X-Received: by 2002:a05:600c:5108:b0:3d3:49db:d84 with SMTP id o8-20020a05600c510800b003d349db0d84mr27336962wms.20.1674568235876;
        Tue, 24 Jan 2023 05:50:35 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c42c400b003db1ca20170sm1972507wme.37.2023.01.24.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:50:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 1/3] thermal/drivers/imx: Remove get_trip_temp ops
Date:   Tue, 24 Jan 2023 14:50:21 +0100
Message-Id: <20230124135024.366486-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The i.MX thermal sensor uses the generic trip points. The thermal
framework can return the critical temperature directly.

Remove the pointless get_trip_temp ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb0d5cab70af..0d94d4baea33 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -332,13 +332,6 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
-{
-	*temp = trips[IMX_TRIP_CRITICAL].temperature;
-
-	return 0;
-}
-
 static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 			     int temp)
 {
@@ -406,7 +399,6 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
-	.get_crit_temp = imx_get_crit_temp,
 	.set_trip_temp = imx_set_trip_temp,
 };
 
-- 
2.34.1

