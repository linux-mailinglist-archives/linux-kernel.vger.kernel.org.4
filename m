Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080D76DB4FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDGUOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDGUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB45BBA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y20so55741453lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9z0aVMBBsZdRPEvNfuPfiehLWAE2y+k1IJImXazA+8=;
        b=ykIoOEnZZFRW29GcpUJJgS6XJcD/9wEvX7Ziuq4ikJe36Iei/vhcLU1eGaJfjpfMj/
         22YDJJa+vZyiyTlA3XDKnCZV5jXNp/uQDFS2FDKWMlO3iqXWYGYj1mCFvNXmu4XneTJo
         NUjPjAsFgVzVPgPIU8WjwwIMKOl0yemsHmKfnyGJiLeySX/yQwI2tN2mBB4H8/dqhNXN
         OuUulpi++Q5nSEaIppjg2DWPE+R2l3D8eWOcSS8kywRtC99E7Y8hGN8UvTchxCI6JsFT
         5n+yYodlA6kBCwvCiZg4npLMNibabufYDWVgZGjWwDOg+ZyAYO5jxtdWvsqavtMHhnaH
         hUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9z0aVMBBsZdRPEvNfuPfiehLWAE2y+k1IJImXazA+8=;
        b=VMzYNKphKXuG5w7pSMZeNjSW8X1CLMFFSGfMcazQRBscMl6OEDtMUdnvvh9LaH/pOc
         jPxWhzy2seEBd4cAGYCRkuG5XPPA6PvTxXNGAr8aGLiG+CpCbNVTmmgD32wEh3jn1CAw
         DIeAMBo+jAfLLlJuT608mU2VkUxeajutu1Ljvemd4FNeA2Ed8qsazxtATGUCLpMiYcVi
         LwsurgqjrRN1JEOV940oSiu8i2Od/JhErjSH17k4HwqOjqNypAYhREe6afGdS8mQSGQB
         1dCg4jQe5cD4fxr2q/kPLLLNegvMekl0eo2X1ld6kgd0k0m5hgeXxrAU6x13jHKmwFel
         nZAA==
X-Gm-Message-State: AAQBX9d+9LwOebx4ycL4TQ8QqA5fqu4OdFGR83vK+uPLzf7vX2Zj2LK4
        8b9+qtTjniVaxk+vQFYPILQYPQ==
X-Google-Smtp-Source: AKy350bePN08sNZfdl2hvuBdMqPHdyTpmH0ZD39kYnUZ3URGUAXAdwrikRbltxkwIgExQxKTNAPDkA==
X-Received: by 2002:a19:5503:0:b0:4d5:ae35:b221 with SMTP id n3-20020a195503000000b004d5ae35b221mr815021lfe.34.1680898486754;
        Fri, 07 Apr 2023 13:14:46 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:43 +0200
Subject: [PATCH v8 1/8] interconnect: qcom: rpm: Rename icc desc clocks to
 bus_blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-1-ee696a2c15a9@linaro.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=4017;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mQ36FvJbMCQvBQ0eF8VcxwSFpsUfeIXlhNbu3V6MP2M=;
 b=gN5Gn8/ZVeVJSPAfPBNSp1QLDyDW9tKyaitI3yL8CAaK7CwYoW1xu5gzNq874cKVoEPdh7quGHkw
 YrqHPplnDPFgb/XxGZAcsGtZqehqtEppQX6x8xRo9axDyEUq2Jsv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 5341fa169dbf..ee3d09a6850e 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -440,9 +440,9 @@ int qnoc_probe(struct platform_device *pdev)
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
index 22bdb1e4bb12..689300a2fd4e 100644
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
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 14efd2761b7a..21f998cd19f0 100644
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
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
@@ -1865,8 +1865,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.clocks = bus_a2noc_clocks,
-	.num_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.bus_clocks = bus_a2noc_clocks,
+	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2004,8 +2004,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
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
2.40.0

