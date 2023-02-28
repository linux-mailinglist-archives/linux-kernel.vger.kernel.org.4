Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5576A5A28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjB1Noa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjB1No1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735402CFE5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f16so10259580ljq.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgcRqq5hFGEX3BEro6fthR6P07V21dEOCMjIIXnOPY0=;
        b=av/SAEHha3iPD2uss5t1mt4KAHHpScXr7aiCMuieRJ0WhLXLv6kaga8vKKjgUdqvXy
         tC13tOnXH4ien+XIsyMxwGuEL6vxts0UZQmbS2TB2t+4y/MgLfo+GSKPQGi27zK7SyqS
         VxCXNWRAH6N6OoCRtxanxb/ynGHsw1dWAzC54zNHyrzuYeL77YfJ57RwS3EEiLLyYWAC
         daZvh3Lo1fiJimEjXiCz07cqxGSHG27vr4EDhpoyl+mDJBH63RBH5a8I9cXbQuN8uTIU
         90iub/xojlkhX72PPR2dLsrTzDrSmtV/xlu+pNaX1w57fnJk2gzZ2i4csxzIZplwpBXI
         tMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgcRqq5hFGEX3BEro6fthR6P07V21dEOCMjIIXnOPY0=;
        b=ecNFDluLNBJ5yvrp1IzxaFpmuyWQc9cZZoNYfgy4yzbjBdNHHLmkaIeV/TiXcJ/YzQ
         VvBsKz0tU8jk0sAc3KHFHncaEr68b7lsyXvum4/QiqUqUZBrjIuUIy3/R36S9wqf07oq
         KECdtlzjWNlDQ6tajDf20uSMkZ4FcS2UYXQb+2fbDKGGU0Zqh50uETYzzEu/o7N2k8q6
         e3mhJjfmV4az9Qz51iRqlZmZXASBWfbitVoUEVXC/lDWL0nr2whV/EoeP1bsxIwNsp2P
         fjisnVHYUh6LFw1v75ASo9X3upCzBakDTH1zQvrEYiV0sAQm5G9+8faBh+S2Ao2UnALB
         L9kw==
X-Gm-Message-State: AO0yUKVZcLvdjsFJNFdB4DANx8djXO/ps0fQZxBjyycn8EpGoyHjMxfQ
        hqgbsawCEo4oLUgt1qYnlI3XuQ==
X-Google-Smtp-Source: AK7set+oy0MWrzMbmigtyjvYvu32OfeesLtpCcGBMYD11xPUjlgh71wgPcN5Gp3AsQomDXI1Xq419w==
X-Received: by 2002:a2e:7c0b:0:b0:295:941d:76fa with SMTP id x11-20020a2e7c0b000000b00295941d76famr793479ljc.40.1677591863665;
        Tue, 28 Feb 2023 05:44:23 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:43:58 +0100
Subject: [PATCH v6 1/9] interconnect: qcom: rpm: make QoS INVALID default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-1-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=3885;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uWME2VC3uqK55iDqVPz0UNlT1NXsdJFrQS1F8gIjU68=;
 b=UW1+3PAtFkCnoPCZYU1ZKYicBpoTW1M+yUDZLEtdsa0iUN0oIuyMr+FK80/HpqWj/s0mcJNKo95Y
 sEUTinmjDrYaQsunaBvFK21iNDwwBw73lV69pfsfqwk3qUsFjvPY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently NOC_QOS_MODE_FIXED is defined as 0x0 which makes it the
default option (partial struct initialization). The default option
however should be NOC_QOS_MODE_INVALID.

That results in bogus QoS configurations being sent for port 0 (which
is used for the DRAM endpoint on BIMC, for example) coming from all nodes
with .qos.ap_owned = true and uninitialized .qos.qos_mode. It's also an
issue for newer SoCs where all nodes are treated as if they were ap_owned,
but not all of them have QoS configuration.

The NOC_QOS_MODEs are defined as preprocessor constants and are not used
anywhere outside qcom_icc_set_noc_qos(), which is easily worked around.
Separate the desc->type values from the values sent to msmbus in the
aforementioned function. Make the former an enum for better mainainability.

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
2.39.2

