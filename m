Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B16689F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjAMDOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjAMDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:14:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214E625F2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:14:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so31230571lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPjbB3FK1NBMvplGNfsEp/AEDsK3/EIymSBWqMhhO+g=;
        b=DezL/d3trZVr4HXL/SAVamVvqujPUjBDNHJnlARdY09fq9HYIx6oGUqPe6l+LxI/eh
         ifAU3gYz2BA36XzT9cLzaQd9qLTcGTuf4wzI3YFDCwM4+49CdeaHxs8mcXPWihTznWyT
         VVVmeEuWRNV6Lf3kjm28nifW/uJeyEdcUNCMjaKORkgrT0eJYJ4woI8/vPBXBOwXPt15
         CWGE6ua9fTkHxswFRvZ8uBuBnty0zCsHzVbTghKe6lMUJWESJuK491DSlBGv7yYK9ntD
         3Q6QUrf1XSmx8ng9LkddahZzWTjvWrxnAu5zzujKhcG9NlSiMYK8eESnqASJrMnsTu9N
         T4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPjbB3FK1NBMvplGNfsEp/AEDsK3/EIymSBWqMhhO+g=;
        b=jS+ULYg96etcpUQnxVMSIbMBdHyRqwBTKvl19d+O7tEAFvp/TsPYiMzhsYG9HXNh7b
         cv4YjDGUnN0Hf6u6OvztVQXraHw9UNdmQMK69DTJSBDT0ECnVrh2Zg5m9oxvQZGrlPSq
         +4sb9FE8o6nC/koxi/pYu7II9UA+1bHlYkgtSa2gPm1YwO6jxq1kCOPAA85z5PVVR6wk
         IxTOOS4ZblCMwpcL7dJuXsxFz0dtuzSgSncew1EJzYe02mA0xVVphdnwhRw0/Sr1mZqN
         db/kdv8ERtQQTu7BgWOfGXWArYYA0NIaYA0364+rXLNmRA7mCr1OIJBFfALlRvo7tO4u
         5zDw==
X-Gm-Message-State: AFqh2kq0rgXDfFclJ1HkaR2EIu3Q4Yxik2C+jXjxeJ1Tje9wILkfgvGR
        WAC1F/Fs+bXX1ONHZHEyDlcyXw==
X-Google-Smtp-Source: AMrXdXuwnrKyJC+g4abuntp+z7g60CE4WM5LJiayATlVFNlo2sO8dPJsZn8M3RdLcB+18kQk/4wtDw==
X-Received: by 2002:a19:700e:0:b0:4cd:afbf:c206 with SMTP id h14-20020a19700e000000b004cdafbfc206mr886608lfc.22.1673579655859;
        Thu, 12 Jan 2023 19:14:15 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b004cb09fd48ebsm3584858lfr.149.2023.01.12.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 19:14:13 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] firmware: qcom_scm: Fully implement qcom_scm_lmh_dcvsh()
Date:   Fri, 13 Jan 2023 04:14:01 +0100
Message-Id: <20230113031401.2336157-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
References: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom_scm_lmh_dcvsh call can actually pass two values to the
secure world. The second value is used for example with the
LMH_FREQ_CAP function, which limits the maximum achievable frequency
directly from LMh. Add the missing arguments, handle them and update
the current usages of this function.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/qcom_scm.c | 13 ++++++++-----
 drivers/thermal/qcom/lmh.c  | 28 ++++++++++++++--------------
 include/linux/qcom_scm.h    |  5 +++--
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54c8146..58a19a47e442 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1252,12 +1252,13 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
 }
 EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
 
-int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
-		       u64 limit_node, u32 node_id, u64 version)
+int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
+		       u32 payload_val1, u64 limit_node, u32 node_id,
+		       u64 version, bool has_val1)
 {
 	dma_addr_t payload_phys;
 	u32 *payload_buf;
-	int ret, payload_size = 5 * sizeof(u32);
+	int ret, payload_size = (5 + has_val1) * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_LMH,
@@ -1278,8 +1279,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[0] = payload_fn;
 	payload_buf[1] = 0;
 	payload_buf[2] = payload_reg;
-	payload_buf[3] = 1;
-	payload_buf[4] = payload_val;
+	payload_buf[3] = has_val1 ? 2 : 1;
+	payload_buf[4] = payload_val0;
+	if (has_val1)
+		payload_buf[5] = payload_val1;
 
 	desc.args[0] = payload_phys;
 
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 5e8ff196c9a6..d2b5ea8322eb 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -147,23 +147,23 @@ static int lmh_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	if (flags & LMH_ENABLE_ALGOS) {
-		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
-					 LMH_NODE_DCVS, node_id, 0);
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1, 0,
+					 LMH_NODE_DCVS, node_id, 0, false);
 		if (ret)
 			dev_err(dev, "Error %d enabling current subfunction\n", ret);
 
-		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
-					 LMH_NODE_DCVS, node_id, 0);
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1, 0,
+					 LMH_NODE_DCVS, node_id, 0, false);
 		if (ret)
 			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
 
-		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
-					 LMH_NODE_DCVS, node_id, 0);
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1, 0,
+					 LMH_NODE_DCVS, node_id, 0, false);
 		if (ret)
 			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
 
-		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
-					 LMH_NODE_DCVS, node_id, 0);
+		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1, 0,
+					 LMH_NODE_DCVS, node_id, 0, false);
 		if (ret) {
 			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
 			return ret;
@@ -177,22 +177,22 @@ static int lmh_probe(struct platform_device *pdev)
 	}
 
 	/* Set default thermal trips */
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
-				 LMH_NODE_DCVS, node_id, 0);
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm, 0,
+				 LMH_NODE_DCVS, node_id, 0, false);
 	if (ret) {
 		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
 		return ret;
 	}
 
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
-				 LMH_NODE_DCVS, node_id, 0);
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high, 0,
+				 LMH_NODE_DCVS, node_id, 0, false);
 	if (ret) {
 		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
 		return ret;
 	}
 
-	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
-				 LMH_NODE_DCVS, node_id, 0);
+	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low, 0,
+				 LMH_NODE_DCVS, node_id, 0, false);
 	if (ret) {
 		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
 		return ret;
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 1e449a5d7f5c..9fd798d17fdd 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -117,8 +117,9 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
 extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
 extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
 
-extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
-			      u64 limit_node, u32 node_id, u64 version);
+extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
+			      u32 payload_val1, u64 limit_node, u32 node_id,
+			      u64 version, bool has_val1);
 extern int qcom_scm_lmh_profile_change(u32 profile_id);
 extern bool qcom_scm_lmh_dcvsh_available(void);
 
-- 
2.39.0

