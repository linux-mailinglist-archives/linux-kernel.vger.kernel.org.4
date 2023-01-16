Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6266BFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjAPNWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjAPNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBEE193C9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so42694798lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL6ky7ln9z3Ny11Hz0y0oGyiLhESeJRVbwJhDtGdLow=;
        b=baQMKjZ2KalTi8UpSKroWPRUEPOt1v9ORTOvw5DPvLkThdM94gMFWW16eRTldi4Ity
         4AE6AD4apFOzxQr6Y5Qp9NqDVI+HpJAX4/4Pjsjy5/AdbtXmKIscElQdC5CJK2JsvBPM
         z5hCX7FIhwtqGdbjA7IYDZT/HqaKPtyTDTtvb9g4XAgzRT8ZWTQwnv8dqT+eWpAubJhT
         Y0bmV4GCNOiFftVJ7kMoTuihMzEioCfJEks1n8msvx8UVtHpd0eb9rgh6RCBEdmpZumr
         wdbGL5dj9rJGpAdMasukCvmYli5djWjZmOfvPOJ8T2zTftcUWMRoV5WbITywVwSlDrFo
         Kw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL6ky7ln9z3Ny11Hz0y0oGyiLhESeJRVbwJhDtGdLow=;
        b=cKGSFvONEqcWmyCAmZKpFACbOn5q4SzCWY3m5hJIa23iaeWW+KMXeGThPZzXBvxJ/X
         eaPdwCrL0KoLI4kqvFPCbZy3RuP1BDrT5D4zrEn+HBgAU9472yvCAbWGyhjiSifPs40x
         kOCnm6tOotUmm1BEJ0galExd4IfIHcmpgwJNenoUjIn7lBIo2tUAoDORrZCD2VjoECR8
         Fddvl60o487Us16ripvsUE5Has+6eGGeo/JPzHVD8gqCFSWBDGsbt3Y99koaOxtNzXoU
         TvxYfBeBRiO7BHOwW+CaoT02xr4MCEh1ycieaUDH+OyLlpu95dXeIYrOxieyvrNIN2rQ
         hJkg==
X-Gm-Message-State: AFqh2krj/PHdfzmjgQ2+ytX3U3tyh4b1Hnd2m/IrhuLXO6je4qh8hZtJ
        yVaqFnbT8+CcrBt3HaYM+RRqJg==
X-Google-Smtp-Source: AMrXdXuPD0SV3TJa9h1X/Y3lOd0DUV4CrD+Z7j05mTpnnrWhcx5h49rJxU5939VVinUHq1R507ameA==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cc with SMTP id t4-20020ac243a4000000b004cb3a6065ccmr12933367lfl.5.1673875320156;
        Mon, 16 Jan 2023 05:22:00 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:21:59 -0800 (PST)
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
Subject: [PATCH v3 1/9] interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
Date:   Mon, 16 Jan 2023 14:21:44 +0100
Message-Id: <20230116132152.405535-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
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
 drivers/interconnect/qcom/icc-rpm.c | 22 ++++++++++++----------
 drivers/interconnect/qcom/icc-rpm.h | 10 ++++++----
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index df3196f72536..385a67c20956 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -48,6 +48,9 @@
 #define NOC_QOS_MODEn_ADDR(n)		(0xc + (n * 0x1000))
 #define NOC_QOS_MODEn_MASK		0x3
 
+#define NOC_QOS_MODE_FIXED_VAL		0x0
+#define NOC_QOS_MODE_BYPASS_VAL		0x2
+
 static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
 {
 	struct icc_provider *provider = src->provider;
@@ -153,7 +156,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
 	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
+	u32 mode = NOC_QOS_MODE_BYPASS_VAL;
 	int rc = 0;
 
 	qn = src->data;
@@ -167,18 +170,17 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
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
index a49af844ab13..8ba1918d7997 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -97,10 +97,12 @@ struct qcom_icc_desc {
 	unsigned int qos_offset;
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

