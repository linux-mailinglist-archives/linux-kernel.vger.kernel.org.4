Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A166418C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAJNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjAJNWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961361B1F9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so18356215lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eopF37r4F26RIQkQPr5Re4R97smck9636TYDpPDGFN4=;
        b=Tz8JEQMsD8UlqDrlwMWLBJ+WeW7rE7R3QPQYGKSVgq8Wgc2ESSVGACEzXv/+O/D/vg
         /qadqL4x5iZzKTAXJDM17RCgGWM4h1rK5oMEW/Pdv5SazZGbwwPYsfeiWXIOnq0iIsCA
         89g0z+K8GQ6/l0dmOiAbxVpJudxmKpIwUkYAxPoVo8tBaNVwPfsTh2BLqO7/pr0xG1b3
         iNnc5mIsEYgMzGaSY0aGQg/cBb4gTMqEcCdeJHJ2bVsDtswR2XwgTWReyOwx+xuk5V71
         TQHs1AfuuJjitNYYHC8e0HRMmjeprUD/RQ7Csp/FlmKk9bpsOIrlysNwnCx4ssLALBAI
         8uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eopF37r4F26RIQkQPr5Re4R97smck9636TYDpPDGFN4=;
        b=0a8aiuYP8NYZU8SDYXbnfktIQ4aLjiI1lDn9gr5LxBpDlQg5BiO3XXakIj9C5ywW79
         SJV0gVvqGSdOr9IpJObyLDhK0F4JxdtMTOVGx2MekaWNUfIpU9zPAvrgN+mn6K0/MQsP
         Gy3g2JeQob0NovNwf5Yp3/75TCNb5Ge3XIeF7TVqKUdlKox7Xr+iig+22sjMqUvzEKP5
         Q6ngA+KmAoAm6jsEnu6JYUSw3ykY+NXn40tTksmXIVSAcqrHav3fGT55GPRFp3TzGe/1
         A/1eRkRgPWbcAzc7gl0azhjR7+GJx8YgJcxP5uhRUVetBsRGG8TXXhBf8RBd/xWlAUbq
         y+jg==
X-Gm-Message-State: AFqh2kpkDHcG9HYkpXGExcin0YP32cKHvmf60fxUTNvsLiUXRFBSIrwK
        N0UFjS+I/vMNiBVsqcFmtnAPcA==
X-Google-Smtp-Source: AMrXdXu/tX/vk2v4CFFFwu6l0yPQ6gFWoouP07+7c8t9vfiXgtNURYYm+elcPNtW9g3cT7HFVV2q6w==
X-Received: by 2002:a05:6512:2987:b0:4b1:3960:4cf8 with SMTP id du7-20020a056512298700b004b139604cf8mr17722938lfb.28.1673356929926;
        Tue, 10 Jan 2023 05:22:09 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
Date:   Tue, 10 Jan 2023 14:21:54 +0100
Message-Id: <20230110132202.956619-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, NOC_QOS_MODE_FIXED is defined as 0x0, which makes it the
"default" option (as that's what uninitialized members of partially
initialized structs are set to), which should really have been
NOC_QOS_MODE_INVALID, and that's what people (wrongly) assumed was
the case when .qos.qos_mode was not defined and what really makes
the most sense..

That resulted in {port 0, prio 0, areq_prio 0, urg_fwd = false, rpm-voted}
QoS being always voted for, because the code flow assumed "hey, it's fixed
QoS, so let's just roll with whatever parameters are set" [again, set by
partial struct initialization, as these fields were left unfilled by the
developers]. That is of course incorrect, and on many of these platforms
port 0 is MAS_APPS_PROC, which 9/10 times is supposed to be handled by
the ap_owned path, not to mention the rest of the parameters may differ.
Arguably, the APPS node is the most important one, next to EBI0..

The modes are defined as preprocessor constants. They are not used
anywhere outside the driver or sent to any remote processor outside
qcom_icc_set_noc_qos(), which is easily worked around.
Separate the type specified in driver data from the value sent to msmbus.
Make the former an enum for better mainainability.

This is an implicit fix for every SMD RPM ICC driver that didn't
explicitly specify NOC_QOS_MODE_INVALID on non-AP_owned nodes that
don't have QoS settings.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Fixes: 6c6fe5d3dc5e ("interconnect: qcom: Add MSM8939 interconnect provider driver")
Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 23 +++++++++++++----------
 drivers/interconnect/qcom/icc-rpm.h | 10 ++++++----
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 361dcbf3386f..cd1eab3d93ba 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -48,6 +48,10 @@
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
 
+#define NOC_QOS_MODE_INVALID_VAL	-1
+#define NOC_QOS_MODE_FIXED_VAL		0x0
+#define NOC_QOS_MODE_BYPASS_VAL		0x2
+
 static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
 {
 	struct icc_provider *provider = src->provider;
@@ -153,7 +157,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
 	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
+	u32 mode = NOC_QOS_MODE_BYPASS_VAL;
 	int rc = 0;
 
 	qn = src->data;
@@ -167,18 +171,17 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 		return 0;
 	}
 
-	if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID)
-		mode = qn->qos.qos_mode;
-
-	if (mode == NOC_QOS_MODE_FIXED) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n",
-			qn->name);
+	if (qn->qos.qos_mode == NOC_QOS_MODE_FIXED) {
+		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Fixed mode\n", qn->name);
+		mode = NOC_QOS_MODE_FIXED_VAL;
 		rc = qcom_icc_noc_set_qos_priority(qp, &qn->qos);
 		if (rc)
 			return rc;
-	} else if (mode == NOC_QOS_MODE_BYPASS) {
-		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n",
-			qn->name);
+	} else if (qn->qos.qos_mode == NOC_QOS_MODE_BYPASS) {
+		dev_dbg(src->provider->dev, "NoC QoS: %s: Set Bypass mode\n", qn->name);
+		mode = NOC_QOS_MODE_BYPASS_VAL;
+	} else {
+		/* How did we get here? */
 	}
 
 	return regmap_update_bits(qp->regmap,
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 13d5252f08a5..3762648f9d47 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -97,10 +97,12 @@ struct qcom_icc_desc {
 	int qos_offset;
 };
 
-/* Valid for both NoC and BIMC */
-#define NOC_QOS_MODE_INVALID		-1
-#define NOC_QOS_MODE_FIXED		0x0
-#define NOC_QOS_MODE_BYPASS		0x2
+/* Valid for all bus types */
+enum qos_mode {
+	NOC_QOS_MODE_INVALID = 0,
+	NOC_QOS_MODE_FIXED,
+	NOC_QOS_MODE_BYPASS,
+};
 
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
-- 
2.39.0

