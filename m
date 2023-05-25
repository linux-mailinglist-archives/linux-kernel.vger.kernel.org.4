Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81527118BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbjEYVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjEYVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:02:50 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703901BC;
        Thu, 25 May 2023 14:02:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510e90d785fso4624132a12.2;
        Thu, 25 May 2023 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048542; x=1687640542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nax/DXvV7aPRLv33Egja3ns9F/aEPbpzdpouXsbNQfc=;
        b=OXlXgQBpb4u1NkgDV1i/lhd5SbJunSLkTu8PXxsmdD/qe3nhjw5uMPXdtO7SsuZuze
         5aR2XJx485G4YoTtB2RfnVfRgHMqaWGN6h5ofCax4MsfC3ZHQM8X+V6y0gB4Gp9FC+z2
         XWawyGXLQfSCfT/IBo7/IveX5L/HPWg6swPJ+YcFGUsB8uWzMmE8wMUYo09FInaizaBo
         pOhXUK2gDeiX7CN546KLvqM0tYgm5+GsyHlbAkrjPXsnE1obyAh+OcbZfV6+T1bX2l9a
         N8ZDhmC+gshiqcnN8p7Y3UxmR0ce/UloMo6Jkb+qIqLK9jfU+nTQwAidJMawm6KX+Jck
         g6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048542; x=1687640542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nax/DXvV7aPRLv33Egja3ns9F/aEPbpzdpouXsbNQfc=;
        b=KSVdbeIJYQ8u0YeWcUTuAy7Iyi6oMgcCs1eUpUGHDs5y7OnK7ffIbkrQ365LE4ma/q
         XlvSjRrn7p/MmTO14YmuHN3RNyS1SjzZuCE+g/RFHCCct6VHfXCYtW2+KZ+9JncW+2dY
         6NOer+xd7mj5h0u3l/stT3IyK46JsCy1L8TXgcaXGmHcHIhU4aTpHs8hCZoCI166tjPL
         CE4b5JinW2vF2o1DIiAWma+Dpu71boO5kWn2MBKX4AQ9TGP2sX1gKXg5JmrdTv4CM7gj
         sLtnP/ahX5n0zPucS7zuyj6AWIGzSFP4WfCWVfWdtdczZWibHo9wNLOxX1e4GVlbQnf5
         L8BA==
X-Gm-Message-State: AC+VfDycBH+a5Mzmk5a9b48yr/7CgXZEX9/YNK99UNgRAFthDugTiYko
        4MUa8xkW0Qq9l8+qUuo1ZmocHSNtDt+1Og==
X-Google-Smtp-Source: ACHHUZ7kUlaXG8xtEFiebNPJ+ek33dTWoMyKVbou1e43+fOvN6gaFkMdKNUCudgXYcE3kK6WPAY8Yg==
X-Received: by 2002:a05:6402:10d0:b0:504:894b:1bc9 with SMTP id p16-20020a05640210d000b00504894b1bc9mr5340222edu.26.1685048541916;
        Thu, 25 May 2023 14:02:21 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id c25-20020aa7df19000000b0050e04125a46sm913010edy.10.2023.05.25.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:02:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Date:   Thu, 25 May 2023 23:02:14 +0200
Message-Id: <20230525210214.78235-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525210214.78235-1-robimarko@gmail.com>
References: <20230525210214.78235-1-robimarko@gmail.com>
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

