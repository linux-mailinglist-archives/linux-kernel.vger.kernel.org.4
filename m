Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5DB67660B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAULaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAUL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:29:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E343E098;
        Sat, 21 Jan 2023 03:29:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b4so9601421edf.0;
        Sat, 21 Jan 2023 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAzkTMFTURCBIwS+2F7U3D+gzMtPsw23R5CfBmpjqS8=;
        b=Zzg50d2ng+fh9mPVnpQbbDtTySnGNyO/jedqCs2/Es98lpd3YFECRzPHFHhqssXw7v
         wIqC6YOgD8p2Ol8JWzMkhF+2OUcTasBby7X9TPwEcwPvBTGDcKaHBz901k8ZBJY9Lkrr
         AJAypfRxKTTagvA6dwbAPqn+a1wde9QExRkbxKIqoo0oLw3laDAJ6yPDOkg18poZYh5J
         u2c/z0xRFEqG+WltV5GNGQZ3dQ89AMsYgPQTmvwC5Vak7DAj2nLZtmUYrKguVNRNoDRB
         hxzyIGQLaHjyByErHUP1UAjYXMQd1+2UaXe6bIDVbCeyDIHSzOj/QGMLor7kSjLscI6f
         BRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAzkTMFTURCBIwS+2F7U3D+gzMtPsw23R5CfBmpjqS8=;
        b=ZuummYeFuGFRHPTGkPid7RT6tOhJ94LTgBoBKU/8Gmkoa45142ekKRBDzGFmUwMMnY
         TXRADkL4bnjFMGl8KuJ9qdMiv+d5zJ8W4Ue+wvpzyYiRcOtN9Na0vTtc7zPN+KqMNQ7H
         616jb2qRqqVnTspl7Irkzma2KSA8+4rHY8SIksaphE22hVRK/Q43I4kE+CDDavdrhvGw
         CDPZEFpClSIiXHXowq47ctlM0BmFqsz4oGbFiLYIMd7e14oqCeh5Xf+/6f7i6xUUxo+2
         o32xmTI6telKZz+fVhd8BhG3WPDXRwg/2qxUdUQEQ++CvpeQj/Vhs1cTXMHyVq7iJr2G
         i6YA==
X-Gm-Message-State: AFqh2kr6yQ83fa5twlAhoGmChyYjRJrpAALlmY7FDaZ46rRkis9+FURp
        6k1xhDw3U2tAuI7WWl6McbXgRuVHLCnoTA==
X-Google-Smtp-Source: AMrXdXuHC+RuV0isDZSh49wKfLwS2hWhJfDrCuWw5+VVR5nn1OzQFOoDtd762ssGkJ3eM3ZbRIU2gw==
X-Received: by 2002:a05:6402:43cf:b0:49b:b1ab:f216 with SMTP id p15-20020a05640243cf00b0049bb1abf216mr20175430edc.11.1674300592949;
        Sat, 21 Jan 2023 03:29:52 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm5152151eda.17.2023.01.21.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:29:52 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id() return the SoC ID
Date:   Sat, 21 Jan 2023 12:29:47 +0100
Message-Id: <20230121112947.53433-4-robimarko@gmail.com>
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

Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
after getting it via SMEM call but instead uses an enum to encode the
matched SMEM ID to 2 variants of MSM8996 which are then used in
qcom_cpufreq_kryo_name_version() to set the supported version.

This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
more than its name suggests, so lets make it just return the SoC ID
directly which allows matching directly on the SoC ID and removes the need
for msm8996_version enum which simplifies the driver.
It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index da55d2e1925a..9deaf9521d6d 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -32,12 +32,6 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
-enum _msm8996_version {
-	MSM8996_V3,
-	MSM8996_SG,
-	NUM_OF_MSM8996_VERSIONS,
-};
-
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }
 
-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
+static int qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
 	struct socinfo *info;
-	enum _msm8996_version version;
 
 	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
 	if (IS_ERR(info))
-		return NUM_OF_MSM8996_VERSIONS;
+		return PTR_ERR(info);
 
-	switch (info->id) {
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
+	return info->id;
 }
 
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
@@ -166,25 +146,25 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
+	int msm_id;
 	u8 *speedbin;
-	enum _msm8996_version msm8996_version;
 	*pvs_name = NULL;
 
-	msm8996_version = qcom_cpufreq_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
-		return -ENODEV;
-	}
+	msm_id = qcom_cpufreq_get_msm_id();
+	if (msm_id < 0)
+		return msm_id;
 
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
2.39.1

