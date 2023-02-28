Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4A6A5A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjB1Nok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1Noa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD852ED78
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:28 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id j17so10232902ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trqKxHVgto91KGpmwfFi50FtfxdBe4Har0LKdE1pjhM=;
        b=i2sizqKBVvwGwnEBvXN3ga0Mls2xAfOLp9J2H2VC82PEPBGHFG4fxDKvi7A47sWG0B
         Iz/jMvOe2SNl1Tw1flVxjp21m+JShdEBHBTXdjM19i6y2U0JbLDbfmKy9vka9ha28rbl
         Nr06bqKxswjopY+oc/++7+wwNfo7kEOwx4qccufFUe6uU/THqlBXBAYhrLVB3mpKgiDK
         xLTHqe2tM5Vucq9IA6MGhJE40HOwws3br2y/5ahWU0PE7JsSIujxN3yQ43VfiGWzy8iU
         MfhPdVO+Hfg+QOhiWMoFLbMMrP1gdhMnIOnXHhHcGUvlnZqUbS48dF9pVKinST52gV7c
         Hc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trqKxHVgto91KGpmwfFi50FtfxdBe4Har0LKdE1pjhM=;
        b=YRdqkK7CZ+Ig79j6lB+Fo/2cydSvTZYkVjmM/Wy0NASkMHddQ5c15PMoOEHk1TyING
         wDBxBr6pjk4u85HRquuM7srJrHSOZE8+0WDl9001EpIyxSnbonzudivMAMH3RbbYs02r
         IoH2PkSIRYj7zklDHcvDJO/bGdzjZ8cdVTrcBDoYA44rIWrgreR7v5YfH/FyehRca9M5
         JFem20LDd9TBuUEB0A+np25wZEs8zxMBe6wgviuSulLT/GcgNDhhk/5J7fCg1Ww8XxsF
         Lvg3OcLlmoNWMnzppUwSxE3rt24TsATmnMMygOZy5AxFRJQ9j+awrNSxSswvtdVNSjuY
         OqbA==
X-Gm-Message-State: AO0yUKXpxCpSJydtw6V/lMI+dgjgBGYzMCjK67G/aaBx5U7r9mwgxJZS
        yG5am7svpHTODG8yGlDldBzvSw==
X-Google-Smtp-Source: AK7set+MWJZNBx86ZLvLB9pWlgctAiTaOLv1n4UL4eWDJq3JWRIaGXPCKR7FvHRwpieNVK4qAP+kaw==
X-Received: by 2002:a2e:1418:0:b0:295:b1af:d269 with SMTP id u24-20020a2e1418000000b00295b1afd269mr929134ljd.43.1677591867201;
        Tue, 28 Feb 2023 05:44:27 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:26 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:01 +0100
Subject: [PATCH v6 4/9] interconnect: qcom: rpm: Rename icc desc clocks to
 bus_blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-4-3c37a349656f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=4029;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TiHJ8feqrM/9/cy6G2m/OVSUoFJuDJvEz8WPJBFfHhE=;
 b=HwIC6HIHf6kcFSIifEsBPqXB+mPKzOtTqJVlZVN/Xw+ptMGS7rVE9RnNmlKKEi6ErlHIgicrmZP7
 /jQzDgUiAKtMa8pHoDPpSBpvWMXcQdmZm8W3I9B8AL3/H/I7o/sB
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

Rename the "clocks" (and _names) fields of qcom_icc_desc to
"bus_clocks" in preparation for introducing handling of clocks that
need to be enabled but not voted on with aggregate frequency.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c |  6 +++---
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 drivers/interconnect/qcom/msm8996.c | 12 ++++++------
 drivers/interconnect/qcom/sdm660.c  |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 6bd20f62f8ed..7a54fe4ccadd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -441,9 +441,9 @@ int qnoc_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	if (desc->num_clocks) {
-		cds = desc->clocks;
-		cd_num = desc->num_clocks;
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
 	} else {
 		cds = bus_clocks;
 		cd_num = ARRAY_SIZE(bus_clocks);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 21f440beda86..d6b4c56bf02c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -91,8 +91,8 @@ struct qcom_icc_node {
 struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
-	const char * const *clocks;
-	size_t num_clocks;
+	const char * const *bus_clocks;
+	size_t num_bus_clocks;
 	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 25a1a32bc611..69fc50a6fa5c 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1821,8 +1821,8 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
-	.clocks = bus_a0noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
+	.bus_clocks = bus_a0noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a0noc_clocks),
 	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
@@ -1866,8 +1866,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.clocks = bus_a2noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.bus_clocks = bus_a2noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2005,8 +2005,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
-	.clocks = bus_mm_clocks,
-	.num_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.bus_clocks = bus_mm_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 8d879b0bcabc..a22ba821efbf 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1516,8 +1516,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
-	.clocks = bus_a2noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.bus_clocks = bus_a2noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
 };
 
@@ -1659,8 +1659,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
-	.clocks = bus_mm_clocks,
-	.num_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.bus_clocks = bus_mm_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 

-- 
2.39.2

