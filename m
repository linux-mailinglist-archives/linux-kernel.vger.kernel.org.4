Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE57333AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjFPOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjFPOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:34:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA230E7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:34:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso546790f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686926066; x=1689518066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0BhKifrGZP5OZWlKIsZeamhkVEABjFj9lFeY4ksW7M=;
        b=h3W0Zy4f2HUF8wotQ3ce709URxdY0hAEyJb3M8k3yMQpdG4hGYwZUKMzASKXcXcWEL
         oUsFDqyOTegR8JitFcYwQP6qxITaijXonMpq8MVsCzcHd7SOSa+BkaFeoNx54AyGmpem
         TF5rtlc2tL9/It1QdOCJ+rw7PxOM7KuSuNsvLIq9gXjy1OBhGbdIk6ThwGmvjWI1Fcf+
         IQpcCJKx/XG8DmsDoasfUluoJRmQGidogDWVh5UslgkDV9o4w+Qw4YN17/vJpbZpNaYl
         BGje+1RQuRo/isJqqwETpbOC6merAbWVddQIB1Lj9advMPKe/dZFB0jtwj07kgYpCdTK
         lXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926066; x=1689518066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0BhKifrGZP5OZWlKIsZeamhkVEABjFj9lFeY4ksW7M=;
        b=RGQ1IquIHUNNNAxV5OKGSgx5fQt18HE9YeLY7nX4ItlXtMXZ4JDFeOPXP3xqWgXBmu
         521F5X1ZkrDsQQ29YPbYsqNBBVCwnRbvUJSSyEQT3COTh5LRpYKj6Ufw0jUpMm2ODs9v
         kakb64jFnBf3aeeCu5LwiM1Tvm3WYOyzz0Vvts1+3xPm4gA4Is97nr69VwfJCoYgn38j
         F0D9d+KGjgIGlD6m5EJKgOzmiusxQmSra9EItTMCpeJNbm9nsWHZ3gNWRsUBK7ee1xfW
         NVU1mEsxLe5oNDRHPNAo27FyZ3LUVycyKTa6t9bL8V6ZyDKPsiJyOeYFpC3gTxxgJSCT
         sC/A==
X-Gm-Message-State: AC+VfDyEN0zhYEr3UohlbfwOLCtUgqy3mEM56z96YGY55531cbJT1CJH
        HFflU21VwmnYcpW2FURkdKEaaA==
X-Google-Smtp-Source: ACHHUZ7B9eVOhaXE4pBU+0rUh8FmNUqYijle3OGMXnKhyXSI8Yi1/tNByxXskqTrhcpUfklt3TEmJg==
X-Received: by 2002:adf:de8a:0:b0:30f:bc8f:6d49 with SMTP id w10-20020adfde8a000000b0030fbc8f6d49mr1814518wrl.13.1686926065921;
        Fri, 16 Jun 2023 07:34:25 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0030903371ef9sm23626149wru.22.2023.06.16.07.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:34:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     zhuyinbo@loongson.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] thermal/drivers/loongson2: Fix thermal zone private data access
Date:   Fri, 16 Jun 2023 16:34:07 +0200
Message-Id: <20230616143407.689515-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
References: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone device won't be accessible directly anymore.

Use the private data accessor.

Cc: zhuyinbo <zhuyinbo@loongson.cn>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/loongson2_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 6a338e6e490e..9a07409c3bd2 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -56,7 +56,7 @@ static int loongson2_thermal_set(struct loongson2_thermal_data *data,
 static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	u32 reg_val;
-	struct loongson2_thermal_data *data = tz->devdata;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
 	reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
 	*temp = ((reg_val & 0xff) - 100) * 1000;
@@ -67,7 +67,7 @@ static int loongson2_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 {
 	struct thermal_zone_device *tzd = dev;
-	struct loongson2_thermal_data *data = tzd->devdata;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
 	/* clear interrupt */
 	writeb(0x3, data->regs + LOONGSON2_TSENSOR_STATUS);
@@ -79,7 +79,7 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 
 static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct loongson2_thermal_data *data = tz->devdata;
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
 	return loongson2_thermal_set(data, low/1000, high/1000, true);
 }
-- 
2.34.1

