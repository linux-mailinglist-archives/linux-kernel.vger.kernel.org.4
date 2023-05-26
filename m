Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3200712E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243585AbjEZUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbjEZUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2CA19D;
        Fri, 26 May 2023 13:48:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so1878573a12.2;
        Fri, 26 May 2023 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134090; x=1687726090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nax/DXvV7aPRLv33Egja3ns9F/aEPbpzdpouXsbNQfc=;
        b=qErUN8wO/o7+mPSK+abk4dbiXgqMGTY4lNyqajrCwaMjOgQ8oeuKVGjrQJWl6MEIvf
         TTlmanszl+SYiyQL7xqVNn5P5xs6Xj7plETMqPnN2j1H3b46t2ZVaQ6KKInvsnlh56s9
         S7Fg9MaQv7y8G9IwwwF7EEFwBIZojFYbXwLN6gPcEL0PtayCwnEHXiBlWvkCLNmlTWrJ
         +Z/FenAitnmtvlZNZz+JWFSsMrSmIcWtFTeIFjp0ELeSnFYrfB7vOvYQFZbHNgUPRJ2z
         LxPctVOtBsNNIgata30YQso8vgQooNQW/IkPFThNp0f+ibUwl3VO0Dp7d+JG2mTP8sQh
         7CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134090; x=1687726090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nax/DXvV7aPRLv33Egja3ns9F/aEPbpzdpouXsbNQfc=;
        b=XE0vyET4CW2sViaGYAWldEmhm00TtYhVvKBpx9uIrgXWRHWg4FBYrIy2wFtxjVCvj1
         ZRGIkcPySofFg3txauIYFuh/WHK/9t9ztOSdCMzdXC7NqdTqk6CZzH2G/yDghJAPO8p+
         pAeMr54wykUJvKei+HA2UGdJRCihKQkLY0O23yBrrUym2fVmZmw+LaXbvY9C676nhQsG
         e+DKE1zvCSWXj6RtryPTazfLLcOaAsPk/zxUsu14x98OUB+77vj98seKYXJicro02K4F
         Xn4yNXzb4NfyK8pjQF0lMMOjjKkeXLrifZNe0YV66WycbLJfUghLYJfYTw1FljelpoQy
         XxSg==
X-Gm-Message-State: AC+VfDyYCLzbIqAmBuS5jXhTOGKETVJU0lg9kJAIeFeudgyeWM6+6n2e
        RE0f/QkSzf3s+SJyi3/gK1ByTujhozL9AA==
X-Google-Smtp-Source: ACHHUZ4z6HWPoyT9/k9E+VkmVtD5LsOYm+2rvPKlOgL9RflARsxvV7k6h/qHqedcXhwL1BPRPhwXrA==
X-Received: by 2002:a17:906:ef07:b0:969:e88a:6071 with SMTP id f7-20020a170906ef0700b00969e88a6071mr3116987ejs.61.1685134089858;
        Fri, 26 May 2023 13:48:09 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906160d00b0095342bfb701sm2604413ejd.16.2023.05.26.13.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:48:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Date:   Fri, 26 May 2023 22:48:02 +0200
Message-Id: <20230526204802.3081168-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526204802.3081168-1-robimarko@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
into an enum, however there is no reason to do so and we can just match
directly on the SMEM SoC ID as returned by qcom_smem_get_soc_id().

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes in v4:
* Adapt to name change to qcom_smem_get_soc_id()

Changes in v3:
* Adapt to helper using argument now

Changes in v2:
* Utilize helper exported by SMEM instead of refactoring
qcom_cpufreq_get_msm_id()
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 60e99be2d3db..a88b6fe5db50 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -29,16 +29,8 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
-#define MSM_ID_SMEM	137
-
 #include <dt-bindings/arm/qcom,ids.h>
 
-enum _msm8996_version {
-	MSM8996_V3,
-	MSM8996_SG,
-	NUM_OF_MSM8996_VERSIONS,
-};
-
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -135,60 +127,32 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }
 
-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
-{
-	size_t len;
-	u32 *msm_id;
-	enum _msm8996_version version;
-
-	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-	if (IS_ERR(msm_id))
-		return NUM_OF_MSM8996_VERSIONS;
-
-	/* The first 4 bytes are format, next to them is the actual msm-id */
-	msm_id++;
-
-	switch ((enum _msm_id)*msm_id) {
-	case QCOM_ID_MSM8996:
-	case QCOM_ID_APQ8096:
-		version = MSM8996_V3;
-		break;
-	case QCOM_ID_MSM8996SG:
-	case QCOM_ID_APQ8096SG:
-		version = MSM8996_SG;
-		break;
-	default:
-		version = NUM_OF_MSM8996_VERSIONS;
-	}
-
-	return version;
-}
-
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  char **pvs_name,
 					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
+	u32 msm_id;
 	u8 *speedbin;
-	enum _msm8996_version msm8996_version;
+	int ret;
 	*pvs_name = NULL;
 
-	msm8996_version = qcom_cpufreq_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
-		return -ENODEV;
-	}
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	switch (msm8996_version) {
-	case MSM8996_V3:
+	switch (msm_id) {
+	case QCOM_ID_MSM8996:
+	case QCOM_ID_APQ8096:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
-	case MSM8996_SG:
+	case QCOM_ID_MSM8996SG:
+	case QCOM_ID_APQ8096SG:
 		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
 		break;
 	default:
-- 
2.40.1

