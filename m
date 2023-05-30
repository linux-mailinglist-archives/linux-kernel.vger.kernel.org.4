Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF915715BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjE3KWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjE3KVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:21:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78523E60
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so4604569e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442028; x=1688034028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7GQk+ou9OB44xwbYDIlivurnEcqmt+au9N5o4Lk7iA=;
        b=VcnoElJuvFUywVcPUADHqAUoNvjn0qgiU8KZVzbNIDso6aCBfyTFWgRhdr4qi6vUIK
         Yl5uDOCiHxwXhuIEEfkEaDee9Y5xhBfjRp2UuGuMLviI4yUyCrxbpvL2oA4lXx4P+8Lc
         Xg03hfsVmt/yjf0vxBCJvOySntJUYBWHzFz4CyypgscJ1IM9iOTKHJGjFlaHR8MHbj1Z
         4b06olGxGoO0IGt8ZkbHnd51UebWt7p9VgpoX3oM+0+zXEuXLgT5o61ed6EF59X0zW9r
         8YWyVlyEXPB8WECtXob1Or5l+4238YVg2ZztHi0z+mqtfK+ovuhB6j16mNKga5nQR6h6
         H9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442028; x=1688034028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7GQk+ou9OB44xwbYDIlivurnEcqmt+au9N5o4Lk7iA=;
        b=boMb7Dz/mMdp/HndLARF0b9F1gYvHHuw73OZtEJIK4PYc943+IGFcmCXWoo3ZiEdCD
         F57mhKFk133pWRFW5wpHzhZYw2G3nb5svvKBts3cuh5OLPlbgtRer4xt5gh6bBXg3rlZ
         vKPjGzVLMg76ApK864C3WS7J9u3WEuf9dEiws1W4P7dZHIwmFbatoeclHGiwmLalyD3r
         MMpHyKZRGFfiTTDgUbqjuM0lJZVR2e99hyUh23au/Px/kmD97begPzBqbsJAqrl33q+w
         XXJ0SdLAf3bb4N6GK+GOuqGlIIlPCdSY+5Zp481VwcgcKwMTMFNG4532DffBKt3h6N0t
         278w==
X-Gm-Message-State: AC+VfDxic+brBj6gfpm5Zx4wePCilVqCsy/XUqfGm/uq2mGZdXT1G8FQ
        qKgD9UaV8Dj5Na7OsQo9SBLUWA==
X-Google-Smtp-Source: ACHHUZ4p9v1ciDMKb1Rtm8msxSHfHFjB6pVqVWdYGha3UAPIv96pLAVd7LH9cf4ZBHSv52Gd5txVJQ==
X-Received: by 2002:a19:c216:0:b0:4f0:1124:8b2a with SMTP id l22-20020a19c216000000b004f011248b2amr579157lfc.46.1685442028816;
        Tue, 30 May 2023 03:20:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:18 +0200
Subject: [PATCH 19/20] interconnect: qcom: icc-rpm: Set bandwidth on both
 contexts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-19-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=3312;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qwy/rjk4gKlt7mY7+plyZcBiZlb68NtNwjzvIjVvGOU=;
 b=TSrtQgnLSkKbMLjsdHmWuil358LrQjiLY6mWR3H//Z/UJ07p68RNaRM0lPXg4jcFrEXb/r+cX
 DY94IAx3ZplBbeDRplEwqZVhac08z3sjaDGhy0NnLzHj+j54KpfmbyU
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
index db84bf56bde3..59be704364bb 100644
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
2.40.1

