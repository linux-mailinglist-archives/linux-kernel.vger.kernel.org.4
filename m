Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC66B144C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCHVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCHVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:17 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880825941B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:40:47 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g18so18062461ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxGQmrbmKZnzoGW/Ytl5lAqej/buXyMdlfBaOCC/0jg=;
        b=jyVpLRSOYHYSJg5LcwjygKcYSq55/TMbyEOvrTMe23OT0NoPeVlzPTgrddgSOA9spC
         s46eOU7dGqBgZJ56JA1uvEMzZP4Y2wXZj+FA6/fi2hKIveHwRR0LlYK+mdOVTWo/IJjk
         KJCYNlzp4KB+jUa23io2VoYYpR6tadlC2cjlWizZiCKXgpYdHSxxyBUJUiNCvnldvYCV
         4Vh1mRCU65gTlleSuam54Prk9L/jWs1jggmFgouUpRl/yOtdxYJdIQ73FvWBfZqg9++m
         sfGZj81tTnSeNB4gDmgDjqSrF7CCRROTodg/QXBVUWVUEvBEpnk2wNRhHuI8Lq4di2Ir
         Wj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxGQmrbmKZnzoGW/Ytl5lAqej/buXyMdlfBaOCC/0jg=;
        b=HpnLjAevGfKpjnJLV/jJRW8XKHzuzj6OZyebU7WvgqEFQ+3XBF05sInDWY0Ia4Ufpi
         jRT6UVP9r1Q7CTl6EQioltadLaFjIChmNXzP/tR90GsVqfUfwbIelIR/jM1NE/KzPrKr
         Ca4CLFhltW8hV/fuH5U7YKe5e65z5vDEpS1mcasVhDOfREY9914hu3BZ9ufGC4SWi0oG
         Dzh0RPhcXK666H5BiIKR6XcSwFfha4QBkJ0J4aP1yAJAgf6D/6GEoWbrVM5Xt8e6HjEI
         3TOqR2cqOy9ivaG6u4Bni3x90e1tNwWOhmRt9VpCK9EzOtjMhh6LseBJ/LfHdwMw7VfI
         Ryng==
X-Gm-Message-State: AO0yUKUPPmu/7pqB6jhNABw9QUfVmkli3rBdMxSXjXdpCYtX0S6eouK4
        Lpggvt614kcDHJHPFB091y3LwVEA7dM5QF08WDk=
X-Google-Smtp-Source: AK7set9FXHSxMQ857o6klpDSMN/vTFqmg7+O42zTmUOz/vHX4pkbjQiI51SJAJ+cV1245VdB3W49sQ==
X-Received: by 2002:a2e:b5b8:0:b0:295:b1af:d269 with SMTP id f24-20020a2eb5b8000000b00295b1afd269mr5073057ljn.43.1678311612289;
        Wed, 08 Mar 2023 13:40:12 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:07 +0100
Subject: [PATCH v7 1/9] interconnect: qcom: rpm: make QoS INVALID default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-1-815606092fff@linaro.org>
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=3885;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LVE+/4VEPlESfpraQPOmUutEh9JBL8Wa+LXrVkmoSRk=;
 b=gJMwz8piyTMvm2V36mHRd1dkdTSh+p4qkELYhIGdbDREHPK7I6YqfPxrqS/NhkZp/dmG8Wb4cqXM
 bZkKQiAPDqYbOwiy1yMXt4nmmqvHVaquYbkEmYNc/TMAk3w6d2LG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index 4d0997b210f7..35fd75ae70e3 100644
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

