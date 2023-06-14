Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2280730710
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjFNSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjFNSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918E211F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f655293a38so8762428e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765903; x=1689357903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99eTqcvgBaxUe9wKghnaXt5XusNnY2akCNbpdNNpTEY=;
        b=KM8mzwJJLTIOXAdX+zo6TJQ7C4krxBOV8/7YVT5ywpIS4pBNpzlABXAgyRhkL8As7Y
         qQWRe4lsCGeQr5tP8UjHd3L9qyd8BxAwYJ7SsWj/WpFTWcC6oKd1o7EFBU+FSmj5kgNX
         ICuxNHHLrJPqG/YmtYexL1xjJuCJCxy5rHXVgKtBJL7z3QTY+oiMTy+YwAL9eFLFn+vw
         i10JgIL409eRLge5tApqDZ/qtq7Rd7PEo2g87fSE77ZGJPVD1urQqd74i6XZVu0Yi5jW
         doGv3GiG8vCr7mf7NrX1doQToyEB75boWxUj2w6eR6qmNhKtSgi/rWw0BADjA4GuSqwY
         QDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765903; x=1689357903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99eTqcvgBaxUe9wKghnaXt5XusNnY2akCNbpdNNpTEY=;
        b=Uar79VZ02xBjGectoywHoAyppIi38d8L9VJBdGpOxZpObSHi8F9OZrtDYWqhZZuchi
         OsfGHyO0fwLrScFQ9eFhRyDR3jM1OEb4cWUgL+ptls993gEwcUClCyfi8Y847BcTSTP+
         1WiYFOjNdhvDQWXX/4ym7NzC5hbAPBdgDhe0i6eL2zuRt7B6bajGSH45Nq/kaEpJQ9T3
         JpETDCx9klJIyjQHdNK/zb3rBIYZc+cV0qgaGd1lTFVRxJkI+PITHfCjw8pB8lyJ2sWY
         uhIi15CFDLZXq5i/FaCvCdivZj+SeQmLmp0GLPBl1bJgdpEO05SQPKBm8LU0LKyLe29h
         J2mA==
X-Gm-Message-State: AC+VfDwW7QtPtx6ytwjP7b+i3OpfspjTVbI2TiyeWjeKrbMymx9DYVHB
        G6YAH78gC1wB3LBmwVt8u4Lwyw==
X-Google-Smtp-Source: ACHHUZ5JxwrPXlITisajET4KEUTM8goA4wa0QSIoC8b7kFUU17AEf42Eu6hZAEV7UweOhGGD4iC17Q==
X-Received: by 2002:a05:6512:458:b0:4f3:a0f5:92e5 with SMTP id y24-20020a056512045800b004f3a0f592e5mr9019503lfk.31.1686765902837;
        Wed, 14 Jun 2023 11:05:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:05:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:38 +0200
Subject: [PATCH v6 19/22] interconnect: qcom: icc-rpm: Fix bucket number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-19-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765873; l=4064;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mN8q2qvO4mMd/JKi78DO37g2U1aTQESNDTlLHNHgtNU=;
 b=lNsPsigredB7X48DopX1qYkaLDR7R22vZUUdwIzHmM5rhhxEPZG3XkthhwVRWGtZcTl8SMXCF
 /bieo0wE1r3ClaB2Kqx9dyrMME1uC7hU72A9gD6MNyT0KA0J/FegPK/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMD RPM only provides two buckets, one each for the active-only and
active-sleep RPM contexts. Use the correct constant to allocate and
operate on them.

This will make the qcom,icc.h header no longer work with this driver,
mostly because.. it was never meant to! The commit that introduced
bucket support to SMD RPM was trying to shove a square into a round
hole and it did not work out very well. That said, there are no
active users of SMD RPM ICC + qcom,icc.h, so that doesn't hurt.

Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 16 ++++++++--------
 drivers/interconnect/qcom/icc-rpm.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 60e4eab8855a..5f3bbe7e6a0d 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -248,7 +248,7 @@ static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
 	size_t i;
 
 	qn = node->data;
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		qn->sum_avg[i] = 0;
 		qn->max_peak[i] = 0;
 	}
@@ -272,9 +272,9 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	qn = node->data;
 
 	if (!tag)
-		tag = QCOM_ICC_TAG_ALWAYS;
+		tag = RPM_ALWAYS_TAG;
 
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		if (tag & BIT(i)) {
 			qn->sum_avg[i] += avg_bw;
 			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
@@ -299,11 +299,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 {
 	struct icc_node *node;
 	struct qcom_icc_node *qn;
-	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
+	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
 	int i;
 
 	/* Initialise aggregate values */
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		agg_avg[i] = 0;
 		agg_peak[i] = 0;
 	}
@@ -316,7 +316,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
-		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 			if (qn->channels)
 				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
 			else
@@ -327,7 +327,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	}
 
 	/* Find maximum values across all buckets */
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
 		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
 }
 
@@ -338,7 +338,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct icc_provider *provider;
 	u64 sum_bw;
 	u64 active_rate, sleep_rate;
-	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
 	int ret;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index e3b0aa9fff3e..eed3451af3e6 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -8,7 +8,7 @@
 
 #include <linux/soc/qcom/smd-rpm.h>
 
-#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <linux/clk.h>
 #include <linux/interconnect-provider.h>
 #include <linux/platform_device.h>
@@ -106,8 +106,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
-	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
+	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;

-- 
2.41.0

