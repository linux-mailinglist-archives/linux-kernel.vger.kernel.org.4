Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C288372CE13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjFLSZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbjFLSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:25:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7B196
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so5277181e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594307; x=1689186307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiXNUpKstCZigcjDwi6CczeSWZkgKbJft9NnoaSwCv0=;
        b=lEn0atd1doB+7QTFowfl+HhHhteJyAGWaVvMnNhyva0OFHYzVaz+rEvNXPK4nnF/qb
         OXqXnUXrIxcu+48zMpxkZ/iF0GoN66mbp253q3VSgUP+DUwT0A6biWiDhO5W6KrSHuSm
         K2e5n0TFzpenRtoOY3AUj+l0c2ahkBHy1OJ+O0KqEYYLWLrQgezhM3cUX1lMj96a8mG8
         RFbU6TFp0Gaea0gk6ALlAnXTEj2zXu+XLI4WjsYvnxCjY4OeYRVCSmq/cUKC02ib2rb3
         ycKjs7HPsLuzaNTIr91dM3tbFp5QJSkNZzXeFjg8TJf4ItCUSEGdOZp/GjWZPks6S2py
         IClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594307; x=1689186307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiXNUpKstCZigcjDwi6CczeSWZkgKbJft9NnoaSwCv0=;
        b=f9sZK87tRA7vXGSX8UR3tWoUF4/UYmuP137Yn0MmvFG3gWQhcH0ad+zfXV95WxPh3f
         ur/bSMQK4+zA3w5Bq2jz4JnfEO3b2NENH8Bc62nT0noilZlUYL//U0eJzO8tyhqTXstE
         9dnT1y3Y+OirGNxMgevotVEPuNSw2lsv16/rAt2H4NQwNUiH9IrXj93OgkIHmCj4/9VM
         Fh5hIsZfVDLnPhBDpQv1DYFXCblxgbK7wNcj+sHzxPTHGNy/Llkz6HBicjk6QP40ngWf
         QUr9pd0EqQRkGf//ybvUTp2gwy+6JmUSsEt73hFvZuNJ58f4UtLzKfO86+PwD82UKj7c
         5L5Q==
X-Gm-Message-State: AC+VfDzSX6TGhy3LWeglRIsOqVXcH9prIO5T64us1BOIV/UNq2n7Gt5F
        OPrB7v7znAdTdPBdsmSOEko32Q==
X-Google-Smtp-Source: ACHHUZ6tJKAZ/32SEpPvH5W6VV042H+9Lzqm4bS3asjGMYhSIoJuKjiS+gIeWmMzAcZPZyaXRMG2Tg==
X-Received: by 2002:a19:380e:0:b0:4f6:19c8:ef13 with SMTP id f14-20020a19380e000000b004f619c8ef13mr4055980lfa.30.1686594306942;
        Mon, 12 Jun 2023 11:25:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:25:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:38 +0200
Subject: [PATCH v3 21/23] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-21-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=3312;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MPi+rwYIYXZeBklOmqYOa88kWKK0Onm3BmECSi8XRMM=;
 b=gSI0Vjygc3kx3sImdlVouSfbLgogi2nszhA+a7YtqjZEdiRejhd14GhdUsf5L7xeLTiOoWwMT
 KSBTal+45RdB8X9+wPLC0rGe7OpoZ4BC5jbbFGjDoohNrn69w9IE87C
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, for some reason we've only been setting bandwidth values
on the active-only context. That pretty much meant that RPM could lift
all votes when entering sleep mode. Or never sleep at all.

That in turn could potentially break things like USB wakeup, as the
connection between APSS and SNoC/PNoC would simply be dead.

Set the values appropriately.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 54a9999fe55d..8e4eb0b90905 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -205,34 +205,39 @@ static int qcom_icc_qos_set(struct icc_node *node)
 	}
 }
 
-static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 sum_bw)
+static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 {
-	int ret = 0;
+	int ret, rpm_ctx = 0;
+	u64 bw_bps;
 
 	if (qn->qos.ap_owned)
 		return 0;
 
-	if (qn->mas_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_MASTER_REQ,
-					    qn->mas_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-			       qn->mas_rpm_id, ret);
-			return ret;
+	for (rpm_ctx = 0; rpm_ctx < QCOM_SMD_RPM_STATE_NUM; rpm_ctx++) {
+		bw_bps = icc_units_to_bps(bw[rpm_ctx]);
+
+		if (qn->mas_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(rpm_ctx,
+						    RPM_BUS_MASTER_REQ,
+						    qn->mas_rpm_id,
+						    bw_bps);
+			if (ret) {
+				pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
+				qn->mas_rpm_id, ret);
+				return ret;
+			}
 		}
-	}
 
-	if (qn->slv_rpm_id != -1) {
-		ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
-					    RPM_BUS_SLAVE_REQ,
-					    qn->slv_rpm_id,
-					    sum_bw);
-		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-			       qn->slv_rpm_id, ret);
-			return ret;
+		if (qn->slv_rpm_id != -1) {
+			ret = qcom_icc_rpm_smd_send(rpm_ctx,
+						    RPM_BUS_SLAVE_REQ,
+						    qn->slv_rpm_id,
+						    bw_bps);
+			if (ret) {
+				pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
+				qn->slv_rpm_id, ret);
+				return ret;
+			}
 		}
 	}
 
@@ -337,7 +342,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
-	u64 sum_bw;
 	u64 active_rate, sleep_rate;
 	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
@@ -351,14 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
-	sum_bw = icc_units_to_bps(max_agg_avg);
-
-	ret = qcom_icc_rpm_set(src_qn, sum_bw);
+	ret = qcom_icc_rpm_set(src_qn, agg_avg);
 	if (ret)
 		return ret;
 
 	if (dst_qn) {
-		ret = qcom_icc_rpm_set(dst_qn, sum_bw);
+		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
 		if (ret)
 			return ret;
 	}

-- 
2.41.0

