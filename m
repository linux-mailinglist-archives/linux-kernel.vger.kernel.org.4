Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10172E4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbjFMOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjFMOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:04:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A7F1FC2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1bdfe51f8so79569561fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665026; x=1689257026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsWP/MKPuzAW2k3Y/XHkP1kPdqPneev/nQtMKrAeCF0=;
        b=gB17vr9VTPzaWYZ/3C20IlM79+P/WgWhGsIeQlNxtSNyT+afL7jJphPwVP1wbzBTdk
         jADzNy5M6D18jpCPpl7lbsYBiu2mPXgMV37HrR6JWLUurFVDqAZN0vzbSXHKkspMvn/+
         6jJWS+JYnkoExbZoWVzYWhMxI93hoUSA/DWiUj38LqnJhdjY9Kq4Rrj3oE2JeTUXn/Qc
         0c6Pjv6c6Mwi+pno6k8hWO3mYTwQM43Ab3rWsB1JYM8+djZmDpbOgvQOEG5Cs05m11Dh
         5vxnVE7eJTURQOqNBJhQjs186LL/8BZgwaYepCOxrlRpo/o4KTcEoNTTxoDob5b0CACS
         TunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665026; x=1689257026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsWP/MKPuzAW2k3Y/XHkP1kPdqPneev/nQtMKrAeCF0=;
        b=jgkhQwzaZJdBypeAld19zFEkJiIaTKsJ+HyxvGI1/ebp14TXTNG+2VVqvWt1DUq01z
         ieOcYxtc+oP+TSfqQkjxGAeaG0Oxfmgi2MB2juLkw969VupVMRXwVNrHYbZvqQR13jku
         z1mw9KBrrYTCsnAZHFzdTTuU+G+WhhrJfR8qJpogH66/XS7ybzPVrv6HOedl32Gxtns2
         jnE1eLS7FN7DEO7T5HpMIdN3Tb5t6D06NC821NS6PBvu4GHyuzYCLI9vXvPePqxCMZAC
         /b0l0Z2VEIyql3JB+Vk3bgKIROVdp7JjkBNajyHmW/tHWghd7qlKOGsui2mhRp9w68oP
         ZiiA==
X-Gm-Message-State: AC+VfDxSeG554fFWoqxzXzR/X4ex6S7gk+T60r1yEDpBHyfG8VgoY0Nx
        XRvjKtGLFj/56umNdBiGTAIDyw==
X-Google-Smtp-Source: ACHHUZ7GLCXdGQgDBzu36jcvj/3jvgagJC6Or6i5PW9jyN7uxMpGvOU4CcZg0AaSLnr2VjKJCbdZjw==
X-Received: by 2002:a05:651c:118a:b0:2ac:6d95:301f with SMTP id w10-20020a05651c118a00b002ac6d95301fmr3088468ljo.2.1686665026411;
        Tue, 13 Jun 2023 07:03:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:19 +0200
Subject: [PATCH v4 19/22] interconnect: qcom: icc-rpm: Fix bucket number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-19-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=4025;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0JHzXALCs1xT53OxmryBlD7xvY46taMop15UV4z+ukc=;
 b=GEy68O2wwEDALb0Yz+kMZhQ3Iu7uQJTMmoRdcJi8N64tGR8a0BdUUCIfqNDSHTlclvS/o43gU
 MIX8Ng/Djx5BbbXvuHOhlkX9vzwdMigqziFiZP0wMDK3wWscrlD3GxL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 16 ++++++++--------
 drivers/interconnect/qcom/icc-rpm.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index f9d0ecba5631..01e14b8ced64 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -249,7 +249,7 @@ static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
 	size_t i;
 
 	qn = node->data;
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		qn->sum_avg[i] = 0;
 		qn->max_peak[i] = 0;
 	}
@@ -273,9 +273,9 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 	qn = node->data;
 
 	if (!tag)
-		tag = QCOM_ICC_TAG_ALWAYS;
+		tag = RPM_ALWAYS_TAG;
 
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 		if (tag & BIT(i)) {
 			qn->sum_avg[i] += avg_bw;
 			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
@@ -300,11 +300,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
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
@@ -317,7 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	 */
 	list_for_each_entry(node, &provider->nodes, node_list) {
 		qn = node->data;
-		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
 			if (qn->channels)
 				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
 			else
@@ -328,7 +328,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
 	}
 
 	/* Find maximum values across all buckets */
-	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
+	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
 		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
 }
 
@@ -339,7 +339,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	struct icc_provider *provider;
 	u64 sum_bw;
 	u64 active_rate, sleep_rate;
-	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
+	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_agg_avg;
 	int ret;
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index a4588a3aebf3..fe928ab6b878 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -10,7 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
-#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,rpm-icc.h>
 
 #define RPM_BUS_MASTER_REQ	0x73616d62
 #define RPM_BUS_SLAVE_REQ	0x766c7362
@@ -105,8 +105,8 @@ struct qcom_icc_node {
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

