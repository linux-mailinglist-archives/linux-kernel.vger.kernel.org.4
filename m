Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE14676609
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAULaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjAUL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:29:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C813BDB8;
        Sat, 21 Jan 2023 03:29:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z11so9565654ede.1;
        Sat, 21 Jan 2023 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5mKLuXoQEg2LlBl5cTmg4HRlZTc66MypE0lBCnDK2k=;
        b=hWNgPQHz5DT7YEs2CEn+12uqj+eFooNyCxxghHL4SZmuyF0iu+57QAVH/Lk+D76xeg
         8XlVNXk06vM/WiAd77+E5EvvQLJlChV0Wac1eI5Sk1aDbcJpVFJz0jF+4rU0e5SuQuT2
         WXZqtJfRha3gwgs+E7V2/dvQo6nEE1GhHzXuxE8xmMotoYXFPs4+urJxI0AILPZ8VNE1
         QMJSgNK57306oL4oEP9U/cDs/qDC7zVOh6vCJ8OTz1/LO+2F3cvT69LjPnpvSInWc9WO
         fB++rE16bcZRb3ZviM0WJQLk5hFoxMXXgyAFf1Q1HzHV83TxcIz3otCZQW6jzKZ33r0o
         /C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5mKLuXoQEg2LlBl5cTmg4HRlZTc66MypE0lBCnDK2k=;
        b=1r4GW9D2tzsOtnU6RXdDz8QP0kiijb3q0jFMG2iXUYbBTdQkYSsysrNK2cdwpave9O
         sEXgP9zC3UJikp7P1lqoyKy+SxsCh/t1U6sJAQaSujEO4pJb3WvxXaR3ZEh4WXUuGbJn
         FVZdF3btAesRfp2c2rUchDyrXt3b0YL6SbRLAA82I1CDL/4WBRnlTPA8XlYIX+Vk+JZY
         5djohUPDE/a4Ngat4ydEuLMZeQU+oQJrLPYfGV7DOnWTpsZJVjlq5Vz1FI0xeqbfg+Vp
         wWXCw1Lytf93mZtjTqv2UACFN3CEU+t5yHcpjPVhlwL2/xjlzypQDjJuhXHtaTfT8Fo1
         p22w==
X-Gm-Message-State: AFqh2kp1sl5uPuG0EenzohnvQOIIYCq6uZrxfiBzaP8z6ziDrj2lU6pc
        YQjV0Kw7Ja97jMO1R1OoJh4=
X-Google-Smtp-Source: AMrXdXsh7ggzctLoccLy3vZx8Sz0N2IZzlexzElftxpuKcFvoijh7wdY9JKsoJZgD946kAVA8b4sZg==
X-Received: by 2002:aa7:c9c5:0:b0:49e:f591:d8d2 with SMTP id i5-20020aa7c9c5000000b0049ef591d8d2mr3997269edt.16.1674300590690;
        Sat, 21 Jan 2023 03:29:50 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm5152151eda.17.2023.01.21.03.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:29:50 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/4] cpufreq: qcom-nvmem: reuse socinfo SMEM item struct
Date:   Sat, 21 Jan 2023 12:29:45 +0100
Message-Id: <20230121112947.53433-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121112947.53433-1-robimarko@gmail.com>
References: <20230121112947.53433-1-robimarko@gmail.com>
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

Now that socinfo SMEM item struct and defines have been moved to a header
so we can utilize that instead.

Now the SMEM value can be accesed directly, there is no need for defining
the ID for the SMEM request as well.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a577586b23be..c0a7841a56c1 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -28,8 +28,7 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
-
-#define MSM_ID_SMEM	137
+#include <linux/soc/qcom/socinfo.h>
 
 enum _msm_id {
 	MSM8996V3 = 0xF6ul,
@@ -143,17 +142,14 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
-	u32 *msm_id;
+	struct socinfo *info;
 	enum _msm8996_version version;
 
-	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-	if (IS_ERR(msm_id))
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
+	if (IS_ERR(info))
 		return NUM_OF_MSM8996_VERSIONS;
 
-	/* The first 4 bytes are format, next to them is the actual msm-id */
-	msm_id++;
-
-	switch ((enum _msm_id)*msm_id) {
+	switch (info->id) {
 	case MSM8996V3:
 	case APQ8096V3:
 		version = MSM8996_V3;
-- 
2.39.1

