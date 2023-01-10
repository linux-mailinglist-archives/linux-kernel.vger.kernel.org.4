Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EDE664195
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjAJNWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjAJNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:19 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0E21B9C9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so18391812lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZfYbZm1wXQAsPKGM8KADSR1+axbDrBtf4PVKMnqTCU=;
        b=m7nDLkP4C3gD5KGGjgopBy8GcD8SL/W+cN0LBtAdj5LW4o5iWGFhIW4839Db31Gqmh
         no1vUdMGC3k/RRUZOrNNFY0VQpH8CaGWd+9vXtPX90yRjBsWv3kRXAjDIy6KeATSWSoD
         fFjrsRol6YTRHc2czoR+N3IemqSkaOrP6qKdnHiYXfAuGN0zXpqnQfCTtrUdu2jb5L3o
         TqVCjFmVazUGSLM94QPAKEH3VM2tcrF1FWRNhd+1Ec4Ty4MKx2S9XKLKapijuiad0jAT
         hYEVAJKyOMgMHQaObomtEd8HCMV9aanfXehGWgDIzHfirXnOIeH3ZX7BIbSx9b0JCB9B
         FaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZfYbZm1wXQAsPKGM8KADSR1+axbDrBtf4PVKMnqTCU=;
        b=xoF9wB/ul8SmMDamVclR486JiVOk3/EOopogacuxAb6AW42oFNRCN2ACY6fJ44/Yc9
         DaVG/tUvu3cFUNZGXLDnxCLYtBpQYqItH+ilIBySkcYnp7Swhw7k7vb3G6i/B6aKicId
         oBQmTSckj+Pm2oMRhPYjv1SAuvJvx0BNaYcw/xlYut+fpSoCZb9PEJJ6Emk0g0LB3YcP
         9DEWx24mKqn/kny3J7y9IZXFkygXG9SAWbpLyKOrfUQA2kOLCkUFo3xabyrbE62Mg4Q+
         TF//pg7n9HkvDmkPCc1HMOAU1i/vm3jIPDbpLEB1/GgnG1ghXAwpyoObC2L6Ay6xDsaH
         uOkg==
X-Gm-Message-State: AFqh2kohhLEJdeTQHyMcafUQTL1MAK9hiZlfbGQCgmRlgxOnr/lZpxuL
        5IzqxDQcdItDgANwRNKGV7lbzA==
X-Google-Smtp-Source: AMrXdXs/W0eNWnMuJNQyefdYLQB/o9oGfoueZApCY15gAdo+G7Q0TtDE00+9lYMJP6qipkDz2AztdQ==
X-Received: by 2002:a05:6512:3f9c:b0:4b6:e4e7:624c with SMTP id x28-20020a0565123f9c00b004b6e4e7624cmr21336228lfa.0.1673356936310;
        Tue, 10 Jan 2023 05:22:16 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:15 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
Date:   Tue, 10 Jan 2023 14:21:58 +0100
Message-Id: <20230110132202.956619-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
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
index 3207b4c99d04..80b5008c8b43 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -460,9 +460,9 @@ int qnoc_probe(struct platform_device *pdev)
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
index b75e99fa08b8..206a7f8dab0c 100644
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
2.39.0

