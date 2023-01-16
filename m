Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DC66BB96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjAPKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAPKUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:20:06 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244D1ABDF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:20:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o15so19602550wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydHIuW52vlpU58xyr8GkPLXOGJ/n+sHnOJ6tjYV+1kM=;
        b=mdlrc+DQzeu/CNGDnqOq5ti+V/zM3FFwrmq+SyRsLr5WOMmfdeKj2gqOrBTE7t9RjU
         CDOniMI5Y7P73serbD8eddbXgsEvNTNxJYBP29vSi3NiQEfZWCw7q2hQMPNwPqPkmumx
         mhOwfrEV6kmwySOgIhamRehAkBt243Yq/OwVUtWsMwv+wPOF26NrbWX6uyobdshY3Lsr
         E5NZN27KbRLXzFWx00ypMZ2Id/gyBcM/V8xOGoVBTZNCkw6GLJtiHsT0LlDxXcJuOLtL
         7Zj7N9eDwCZh96UkWQH72Za/dqaAOwF5hUMAsCyZtfOYx6fA5iVM4HhDDEIW32bgKpNX
         9vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydHIuW52vlpU58xyr8GkPLXOGJ/n+sHnOJ6tjYV+1kM=;
        b=BsxzjP2uPdgLa/ZxZgSbcu1ayH6314CjF2ZC2cllEvbHvrhIaqJWYnmswP4DpeG66p
         Ik+dwsx/YoOrbsQDwKGWbbU22RiZCkbx64CS9smfm7eEdOjlswFLtenih5bWkO4u2jmC
         CYDRYQJD/ISQewqFcfW9MYvPnF6fAjI/OUD61LNpOSqCu/i9X8rG+7qU5Gj9ZyQTcBHX
         Z+Fn2HxsG6ls95vXNKMoWQ80kc/IU2Fd7WJuUEAZtGTC+nWvHkS3Z3EocZqph1AZtkXO
         I28rvAbPQVlvFl/PioDM8rwK2oTUS/DXq8Pgan34ZENLJQEF6d1z1KIIUDYOTfEOrSQk
         qyjg==
X-Gm-Message-State: AFqh2krckDdlXzpK0j9tAni+MkGttWzEtccQVKFD1zvb16AMLuXyxHvd
        U34J8FLmnaK+6kx/ekpCEVDlFQ==
X-Google-Smtp-Source: AMrXdXv8ze6K8DQ5Z0ZElA4plC7SmPqh6d0btvuTMhhQ2fNiLLi5IGU6o+ZVEm4848L2AJcq3jFCLw==
X-Received: by 2002:a05:600c:a4e:b0:3d1:baf7:ceae with SMTP id c14-20020a05600c0a4e00b003d1baf7ceaemr66199576wmq.39.1673864403273;
        Mon, 16 Jan 2023 02:20:03 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm37121541wmr.21.2023.01.16.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 02:20:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] thermal/drivers/qcom: Remove duplicate set next trip point interrupt code
Date:   Mon, 16 Jan 2023 11:19:54 +0100
Message-Id: <20230116101955.3961427-1-daniel.lezcano@linaro.org>
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

The tsens driver reprogram the next trip points in the irq
handler. This function then call thermal_zone_device_update().

However, thermal_zone_device_update() calls thermal_zone_set_trips()
and from there it calls the backend 'set_trips' ops. This one in turn
reprogram the next trip points (low/high).

Consequently, the code setting the next trip points interrupt in the
interrupt handle is not needed and could be removed.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  v2:
    - Removed unused delcared variables
---
 drivers/thermal/qcom/tsens.c | 51 ++----------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b5b136ff323f..9dd69754dd63 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -459,12 +459,9 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 {
 	struct tsens_priv *priv = data;
 	struct tsens_irq_data d;
-	bool enable = true, disable = false;
-	unsigned long flags;
-	int temp, ret, i;
+	int i;
 
 	for (i = 0; i < priv->num_sensors; i++) {
-		bool trigger = false;
 		const struct tsens_sensor *s = &priv->sensor[i];
 		u32 hw_id = s->hw_id;
 
@@ -472,52 +469,8 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
 			continue;
 		if (!tsens_threshold_violated(priv, hw_id, &d))
 			continue;
-		ret = get_temp_tsens_valid(s, &temp);
-		if (ret) {
-			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
-				hw_id, __func__);
-			continue;
-		}
 
-		spin_lock_irqsave(&priv->ul_lock, flags);
-
-		tsens_read_irq_state(priv, hw_id, s, &d);
-
-		if (d.up_viol &&
-		    !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
-			tsens_set_interrupt(priv, hw_id, UPPER, disable);
-			if (d.up_thresh > temp) {
-				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
-					hw_id, __func__);
-				tsens_set_interrupt(priv, hw_id, UPPER, enable);
-			} else {
-				trigger = true;
-				/* Keep irq masked */
-			}
-		} else if (d.low_viol &&
-			   !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
-			tsens_set_interrupt(priv, hw_id, LOWER, disable);
-			if (d.low_thresh < temp) {
-				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
-					hw_id, __func__);
-				tsens_set_interrupt(priv, hw_id, LOWER, enable);
-			} else {
-				trigger = true;
-				/* Keep irq masked */
-			}
-		}
-
-		spin_unlock_irqrestore(&priv->ul_lock, flags);
-
-		if (trigger) {
-			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
-				hw_id, __func__, temp);
-			thermal_zone_device_update(s->tzd,
-						   THERMAL_EVENT_UNSPECIFIED);
-		} else {
-			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
-				hw_id, __func__, temp);
-		}
+		thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 		if (tsens_version(priv) < VER_0_1) {
 			/* Constraint: There is only 1 interrupt control register for all
-- 
2.34.1

