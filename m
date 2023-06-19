Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4847357D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjFSNGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFSNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF86E7A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so3746598e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179896; x=1689771896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3iwd6rHqsg8HTsIHqkjHpgKU8rjtKazN66jALoshMs=;
        b=b308CGdxlNA5eCfCK15z2UMBieaQCBllJgpSgFtWLQL5hhj0F0e664l8Ux6iSaz1jp
         R8bxbe0BTMogcPtJovHvi9xY8Ih+UaLrtRnktwrFolaksnP6cvvJEpgWoCa9T71jJ9NZ
         NfxPRWc6FjexpzZZ0z1Orkj2QsPkxT5cgFapje8YnG6MC56ieidacjNeY16BpXCA/S83
         7SpAg0oi7Ta2HNRgsrIbBSa7V0HltPFRdaPwOxdjGeC+e3n9Vf4LGfVZMtxDZk2Wd7eY
         VPnGyMYyc5B84fIWH6tNJAdLoA0Zi/7B3gQuO0ZPlCcVNPUxnAbOfMM4TqmDPH9HxWoc
         IKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179896; x=1689771896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3iwd6rHqsg8HTsIHqkjHpgKU8rjtKazN66jALoshMs=;
        b=ZRx+5lQurStjEHfXrnZYMKqppz5aypuk7P3WXv/34gO5WizFy85jA730DiLWwot3AQ
         udP4bnH4bYbTio4IacWJQSivm7CV8yDdZawS7+p5oCuEZejxaMKSDD4cAMkI5w6bx1dL
         tqJaR68Pn2P9+g4VyGM1ew7ouocWpTPOmmY1csawCr0Dv6xyv4Cst5gBsqhw0XDyvnV4
         Xyvhb8cGOxD9I4/UbRCyWcoPRTILdApq1Nm9JF406gZoCSRDGJyCvLzHc5hMAUhisxIx
         0JVuH+tWHO+Wf9gEp2feQGj8zFdyJw2yWD9XUwcVo2Ty83Vjeaj7U9OL92So584dJan+
         7g1Q==
X-Gm-Message-State: AC+VfDwg3OgtOJmsKzf0XukrxzKr1mnDz1SWB+5NW8TU1xutq5b+2HQV
        GC1m+ra5YRCHW0ERAaVg7dh7Mg==
X-Google-Smtp-Source: ACHHUZ4nGd2lpz7WS+XRILEc9KV94K24N/DCLbGXuQq9TxREFohOp0PPb6Sy7Yypg7AaqtCBT/R4nQ==
X-Received: by 2002:a05:6512:60a:b0:4f8:5635:2ccf with SMTP id b10-20020a056512060a00b004f856352ccfmr5524974lfe.8.1687179896620;
        Mon, 19 Jun 2023 06:04:56 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:41 +0200
Subject: [PATCH v7 16/22] interconnect: qcom: qcm2290: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-16-09c78c175546@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=2388;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y5vzxfTOafvaW8mPCP2rmWXwcfrcZgL9XrNa/4uLTOM=;
 b=w6s2YQ+WGCot18LvoGsmdJsa5Lcz3MyIVCQc5Cb7h7I2idTjH7umMtCR2AJLMKekbFH78JZHz
 QU9iAZ8DVqRCOYo9w6FemAqWwdfxZXE69nCulgs+O0FCVc+jZVnH3d9
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 36a53add866d..8fc4acc4220b 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1195,6 +1195,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = qcm2290_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
@@ -1250,6 +1251,7 @@ static const struct qcom_icc_desc qcm2290_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = qcm2290_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &qcm2290_cnoc_regmap_config,
 };
 
@@ -1291,6 +1293,7 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
 	.qos_offset = 0x15000,
@@ -1305,6 +1308,7 @@ static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
+	.bus_clk_desc = &qup_clk,
 };
 
 static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
@@ -1318,6 +1322,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmnrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };
@@ -1332,6 +1337,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };

-- 
2.41.0

