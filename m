Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC85E710BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbjEYMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbjEYMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:10:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39049C;
        Thu, 25 May 2023 05:10:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso3994505a12.2;
        Thu, 25 May 2023 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016605; x=1687608605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB+lfwPJ6+4o7RQeb0vcEyQtsD+Ddm0kRPNNohX3Hqg=;
        b=aCPHY8Fs8pUtdIZyoS5xQc5KsAKrLdSygCXYe7EdcX7jFgGe4AnK2V0jHWkDWUMhmn
         3ByfK1HqA+mP4Qjm849pr8uuOZcmhGLQmAb6BvYNag82EwrjeqdaguPE/ZpBbw4abXME
         2TG8zAUVO0H/xET1u6qut9MwCC9GNbdNzzNFkJycJx7mn8pvjBy6lFlMAtKWaOWxa58O
         BC4alUtagV93NyVx3njWgKkqE2CC2/Ryht4CteXWfYs0oCHvckxiJEl8ag9Hgk7QVTTE
         Qz8EN6lcfUc/RKJqnyXM+GPjzX4gBVXgFgoIs2UMjbbz1r+XXTSkEwZRPcGaiG+TxiFO
         nT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016605; x=1687608605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB+lfwPJ6+4o7RQeb0vcEyQtsD+Ddm0kRPNNohX3Hqg=;
        b=hjiNADUx0tK8XKfRsHuB+8t5CPKGatXyGFZWah0aZtQhyl6fISPrjb1HHZlEC4GIo9
         9+yyudN2ZTuZc5WAYMqFLtvGUroq98yJ9cZrWCnYQpcCVh7mzenBzd6/3kWa4dwGyqx6
         5tW2KpvodcF6PM74fTCHnyrdgb0DHekKrsu2soImDdva4NuzrjRb1F6EbeiV0GDu+Xpq
         DrhSdgmdyBopCSeN1uP2KcJZjihjnFr+ZdFzQCXynSTYr3mAKs7SADXSWMo0DyfoupT0
         hll/soheyQELtqwkyrlkGn+omEEIeGryKsbtIZh+rtJFKHTbWAAmir9cBk+nN4sodsgz
         mH8w==
X-Gm-Message-State: AC+VfDxa3/TA8xo8XF0tavo3r7h1EQtg0N1Zf4dUtveym5lJNr91Nsx3
        n5/Ij2WGcCWW8OmgXAvItCQ=
X-Google-Smtp-Source: ACHHUZ62HXKiBvds6Zc2xBIvzq0omQBhvCqoCbi+RzXy6Zb5ylUSSbcge4HU2Xvl9/faCsrkEXBgLg==
X-Received: by 2002:a17:906:6a2a:b0:961:be96:b0e6 with SMTP id qw42-20020a1709066a2a00b00961be96b0e6mr1631797ejc.68.1685016604848;
        Thu, 25 May 2023 05:10:04 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm765216ejm.219.2023.05.25.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:10:04 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Date:   Thu, 25 May 2023 14:09:56 +0200
Message-Id: <20230525120956.3095317-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525120956.3095317-1-robimarko@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
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
directly on the SMEM SoC ID as returned by qcom_smem_get_msm_id().

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes in v3:
* Adapt to helper using argument now

Changes in v2:
* Utilize helper exported by SMEM instead of refactoring
qcom_cpufreq_get_msm_id()
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 60e99be2d3db..ba001ebcba11 100644
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
+	ret = qcom_smem_get_msm_id(&msm_id);
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

