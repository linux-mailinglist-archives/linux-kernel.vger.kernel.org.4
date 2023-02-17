Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA569A941
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBQKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBQKqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890AD6359A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z18so1329086lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2YOWjcFWDSCJRKhThoreWlOz8b57o2c2Tr6FolnlTU=;
        b=AM4e3DmweDpeDr8ruXbKbiVj8XWXKpU5flwVYy/YhpnO000xRVs6X6yK7AbbNwlioF
         St5R9Iy4zjrCjw6bxBCfIiWIHg0NDzDZdWbXcPAQ1mL/gOSXLo8rme4RA9OvfW6j831f
         LGeuUtipI1WM9uQ/Y+PRLfAke37IDkyxg6Avukc3W+yFy5NUmtadfRmXwRT0iUHXl8Wc
         +ZapnwvGshKcIueUz9LVEB+xOZ9hwA1CLCcKMSqfuFudkNHcSzgxf3RP7R8EHH7rtUW2
         02UvvznH78j9EIFatZSkV9lpII0vRNJeWimgYi3HctuVCZVYzm3nMnnJViL6MiQcpSyG
         PvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2YOWjcFWDSCJRKhThoreWlOz8b57o2c2Tr6FolnlTU=;
        b=jH+xVMHOwDs2d26D97UPGL+5iXils2on0h04WTXRvSA1pMwe14pQehExlsILnD8F3K
         Skwbj14DWrh8nPY9RQAbtA53HEQG1wC/uWrAiSijdcbrxF8y8/47dEZkM052BWVzTBkH
         yYNGnFmX35Rx1ppwwTWpdGzdskr83wumGFublbnyxRO4NQti9UK8hfm9HHqUfDbczUHh
         bHomj3ucW8d5Fk4rxVh9R+zykGz1B+pJXOiwh4PdhJ4Q/j9d6U19s8QZtGhta5R+dleF
         eQAEoF2psa5iAgzaIh1pxRNPAbXv/27iuVjfDELCxHCFk8sMjmlwzLBvj4IP3mteM02S
         3meA==
X-Gm-Message-State: AO0yUKVgukG0rASTzu0t4Yf7cJTrKUhZwxcWGG7Yh+XOOmBIkIACYNxz
        8YX0Vhffp2sw1EsFrhu/Uyp0LQ==
X-Google-Smtp-Source: AK7set9CFybII5DzWno5W84GW/eIYkkvmlI9Pc5UoP4WoeAp2y/z9KTGNal3UcfDdXwOMDoqW8CSHQ==
X-Received: by 2002:ac2:551c:0:b0:4d8:6255:265f with SMTP id j28-20020ac2551c000000b004d86255265fmr273340lfk.20.1676630793936;
        Fri, 17 Feb 2023 02:46:33 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:22 +0100
Subject: [PATCH v5 01/10] interconnect: qcom: rpm: make QoS INVALID
 default, separate out driver data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-1-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=4821;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fW0/q7Y4jn5JjCXEuz/icnbq3YzHFaKCGchWxIjH/5g=;
 b=bt6O8yFpjiliV9Zv1OUdqyf7xnDMzvo5ML+awQqSYLp1ox69/UDILp79tKZRQVLGLIksa1r0umto
 SjEjjpxyDZS6Im456TbIQ+6OXQE3YaiYsKwBfon71vp8nK9cdXwR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/icc-rpm.c | 24 +++++++++++++-----------
 drivers/interconnect/qcom/icc-rpm.h | 10 ++++++----
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index df3196f72536..ffbeeca8c2b0 100644
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
@@ -244,7 +246,7 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 		ret = qcom_icc_rpm_set(qn->mas_rpm_id, qn->slv_rpm_id, sum_bw);
 		if (ret)
 			return ret;
-	} else if (qn->qos.qos_mode != -1) {
+	} else if (qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
 		/* set bandwidth directly from the AP */
 		ret = qcom_icc_qos_set(n, sum_bw);
 		if (ret)
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
2.39.1

