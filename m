Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4931735806
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFSNGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjFSNFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF510F3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f849605df4so4368701e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179903; x=1689771903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7wfrKtOuiG3iOR2rZXazcj4Xb5KmwKNQQmAN1Tw0Tc=;
        b=bZy/GStrfUOQMkb14aQs3Yu9KkftasQgdle81VkPsfW5z+9gjC4d2MYG/yP52TNxS0
         f5WX1Jj7Sn/Tr7UNa+35XZPTtBzRW2eoN57SYbxxd6nQyavQ+f9vhhXDHDnRcJAu4QFj
         8HpSNVw6l44FYeN5X/VctwijR2W2V7bAMKFDU9Nkqd+GQGa+FeCDwaNqI1GF6PwyQU93
         Up88lZ+6Aw//fdMmnmPDiBatpNqXKCd6xecPM+RzxE4Swzn+Vu37wX5yUSEc4AixGQwX
         gdsFPXLPOKuzeCX7lwnokXlBmzzMUEiSOUwdV8PVEya/SBXatIL9vmWzt7trqy4IHQFy
         Kq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179903; x=1689771903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7wfrKtOuiG3iOR2rZXazcj4Xb5KmwKNQQmAN1Tw0Tc=;
        b=D/VrI559vyL4Oi8TSjuMjq5eF27TfVuOYsXD++S9XVvFDgpBqjCk/kFf7zoCZC3jfc
         rH0D/h6VCPYbmKt1EzTB/JHrosFP912/9haU0/ico728qYoPsTbGz72ljfrH7g5Mg/Qq
         3Kf4Yv7JLcWKTbMmm3UQjSnytCxebkcavfi9sTY1mR9sZNtE2yjogz22eyXJ6wiI2IHb
         plTBztptCBUMgUHFmAMh+gIkWxpzUX5Cl3KgF6coPbPLh5pqinMe4hIBR448+btZDk6b
         y/Y36tJ8hwEyYVGs+1HsCvLxayzPpoJJ3HJvpfcYplPIIogHYGMPHlx8m+9uq4g6PKai
         bPow==
X-Gm-Message-State: AC+VfDxSGirw/pjYvipNrZIwkLcNCF5XBak5aG+1Sv1G2tI7dbwLQ2+D
        2QKtPIlFXsFmwNqEX3SJNWVlIg==
X-Google-Smtp-Source: ACHHUZ4KOvG/k99V5qR2ohCm71fvloud64ViSAw1Hih+IUAxGToRoFE6akpW1nlB9Jl5tSzSlLHf1w==
X-Received: by 2002:a19:711c:0:b0:4f6:3000:4d5a with SMTP id m28-20020a19711c000000b004f630004d5amr5001166lfc.38.1687179903249;
        Mon, 19 Jun 2023 06:05:03 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:05:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:45 +0200
Subject: [PATCH v7 20/22] interconnect: qcom: icc-rpm: Set bandwidth on
 both contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-20-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=3364;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bsPoz7/6rYieWdNaInRGuWSci4TnSHDkv7Qn8EyapGs=;
 b=CofZ2ulu6FG7k649Sm0Mq4B5F2xwWKTqeEqtVb000gfw8fqTfodHt/Kzz+hGTIKFadvyK1knm
 lBZIVIr2TQ1C84StijWGta6KBzYaaWtSrlIq++kSjM2+Lx2MCeynIxy
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
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 54 +++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 5f3bbe7e6a0d..928dc27c1d93 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -204,34 +204,39 @@ static int qcom_icc_qos_set(struct icc_node *node)
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
 
@@ -336,7 +341,6 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
 	struct icc_provider *provider;
-	u64 sum_bw;
 	u64 active_rate, sleep_rate;
 	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
@@ -350,14 +354,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
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

