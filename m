Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2465C516
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjACRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjACRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:31:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C677A10A2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:31:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g13so46578466lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 09:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3KZjymVYGNEKzZ19NRMYsypVKZnaHDoA/SNQSoa8Wc=;
        b=X9bIaEsxX3GIUmLjf7DQIcOA/N6q5yqI33odD2sZZGiUWAru2F16e6lhmODeJe8WL5
         qRZ/4nAMF5jcsjaOO9iEwJMSUqiMXygEGlqiuMXHrM6IALMBqTCVIxIDsBDVPtI8Wu08
         +9Wt7arlEesfukoZqfsuosSZiMLTIqo9LcgBUgaZSnH7bXc5MaA6v5/RKtaYndmcCBMe
         U0oP5SOEuVln9ifeyuq1vhTcvptL1fY839ZSERkmmFAX16DCFDc/JXxrBk9ynwN7nZFM
         RBXRcxZSUrijpLVlU1+aTQEMqbrCUl4ivOYbM90c1qRf+/hjMkFKWuVS13Kqe9ukb3Vg
         O3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3KZjymVYGNEKzZ19NRMYsypVKZnaHDoA/SNQSoa8Wc=;
        b=X8VsPXWJRbV2Jh33pV2uhCSvkZF32RUNhnLNHBzpxj8L0VpDPitNzBfu4vwYZzxlO5
         YS8DKNsdIO0/phA9jcio1XmPb1R1lOuTWiIO7X/0TbzkZJ7RYLSmysNU5dcGIkUkNq5t
         VVov1jm6V5jAMqjccCquVEbYfY88U7B9Og0F1G29XTJ4vmSRqNr98gMfXMyiil3bdoIT
         3nX2mI3WBBEZBqE9Y7FXcA4z7RTRz1KNXJGIKiY28ySU+uE/O8jmxgyjJh2ynf3R2XpH
         dCaa3oAynqq35RjbHFMwjAYJcY4BOu9v7OIQugh4/+aO6IGoOTBZvTybUDNfHMHQaTSq
         Mwvw==
X-Gm-Message-State: AFqh2kqtTsfUPmKQNlX5z1Jmyns3ME0WlA5B5HVlSqOH62jSXcML+oDQ
        eSf6PP0SQ1JCYxbNHcg6EBC1xA==
X-Google-Smtp-Source: AMrXdXuIBGFoSO7Q/Shu0eNSOZ4yVIcx6NAOU0gKlhjEmh01fBRZ+0dsKy738mqRHeWvdml+bvEqFQ==
X-Received: by 2002:a05:6512:1043:b0:4cb:d3:b81b with SMTP id c3-20020a056512104300b004cb00d3b81bmr15212735lfb.44.1672767070191;
        Tue, 03 Jan 2023 09:31:10 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b004b4b5da5f80sm4916818lfg.219.2023.01.03.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:31:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 3/4] interconnect: qcom: rpm: make QoS INVALID default, separate out driver data
Date:   Tue,  3 Jan 2023 18:30:58 +0100
Message-Id: <20230103173059.265856-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103173059.265856-1-konrad.dybcio@linaro.org>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
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
index a190a0a839c8..8ec1ca17816a 100644
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
@@ -155,7 +159,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
 	struct icc_provider *provider;
-	u32 mode = NOC_QOS_MODE_BYPASS;
+	u32 mode = NOC_QOS_MODE_BYPASS_VAL;
 	int rc = 0;
 
 	qn = src->data;
@@ -169,18 +173,17 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
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

