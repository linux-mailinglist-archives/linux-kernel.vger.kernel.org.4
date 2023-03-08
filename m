Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B926B145B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCHVls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCHVl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C3AB5FC8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:41:01 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id z42so17988949ljq.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t1kfcvXJ4zvGFbuICYe+GECxTy8J8Qmh6KG/NORR+I=;
        b=mdCjvrrrohBvEGbTqSJDdL9299cbtLlZ53lCF5RyXLjCFRwg46KSCIxOqT/oTDC5KX
         3xcixlDNLdrq6SYy6jAdoI1kc59rcpPKce+fWNi2oTEAs73gmwdRxBlvO4/DTMPopqlp
         BVcfppNdDuFSdi1LhKks3dEkJ44p06ECWNgojLwRm9qLIiHOQquiuTiTo72blq8NhMmI
         sO7M6Ru8O1bf8kVF4XZXvbbeWKQzz64Ay6M1nUbn3N8Sn8W1E3Y/U6jK4u55NGkdamvX
         Q7V6HTaVKiGT6oawOKKSye91E+XtwveWcllDdhBX+4NXeoIipjjzpJESEa6enzmNIvxn
         NKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t1kfcvXJ4zvGFbuICYe+GECxTy8J8Qmh6KG/NORR+I=;
        b=j0VY7UfCF9q1swfc57kOauI/OOOZ6SQu9Vu1Tb3toVu1vpXR9WxdXdViiDFFL0QV3W
         F83FY5lGFpJhn15ULHMsA9WN/SrRq9e5PFn1IrotLbGKevMj8ughuDVU1vfYqU/e6UNi
         4RsvBIZy9SUacBSoP+HwZff82N4JKKoDPrSlPAesDYpeRh2IK4A7Tjmm8hNSQX1sYX4p
         ZhOJPP8s8DHExHpeThTJqGJXCpuFCoBaBpyVVgHJOo4HvisvTgtJaiByADyaJaXvfXA4
         YHDULx1J4O7MsexXPEQEX578St68OtOWzdDIbMvGeA6Fx+CqJcXdPLRw5qywsW9dMLJo
         wX2A==
X-Gm-Message-State: AO0yUKWV77zG+RiaJdQFD8B7pQUCkvk3r0Qh5PKAMhd/ZdGMpbpU1XGS
        GIQ6svyDloDP3+duG8LK7QkUg6FaZ4kdN6/WsuY=
X-Google-Smtp-Source: AK7set8wDKBGSI5V1+fdpFoaHTTqzWP/ohyL6w1yp1yjTx6vmvknaIBSHjpI+6uMO65otVhVm6RU+w==
X-Received: by 2002:a2e:8091:0:b0:293:2ef5:9434 with SMTP id i17-20020a2e8091000000b002932ef59434mr5344078ljg.2.1678311630823;
        Wed, 08 Mar 2023 13:40:30 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:11 +0100
Subject: [PATCH v7 5/9] interconnect: qcom: rpm: Rename icc provider
 num_clocks to num_bus_clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-5-815606092fff@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=3046;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PzS93QUtZWZrTNDO3Fwk1Lsu/LMOgfbQTOZsMendxfs=;
 b=++Ge49gGRG0A2V4Md9NFW09tXmZAdsbP6qY0yPTPPRZ9ktAZweO1wv/wafbiEpZnH56yVKx/OLCa
 yx81tNjqDs3wPjy4maTnxs7XO0czV2ldVvMTfOwv8l9WodlduZkl
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

In preparation for handling non-scaling clocks that we still have to
enable, rename num_clocks to more descriptive num_bus_clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 12 ++++++------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 62c48fb13fbf..b52f788d8f3d 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -380,7 +380,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_clks; i++) {
+	for (i = 0; i < qp->num_bus_clks; i++) {
 		/*
 		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
 		 * for other clocks.  If a platform doesn't set interconnect
@@ -465,7 +465,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
-	qp->num_clks = cd_num;
+	qp->num_bus_clks = cd_num;
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -495,11 +495,11 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
@@ -558,7 +558,7 @@ int qnoc_probe(struct platform_device *pdev)
 err_remove_nodes:
 	icc_nodes_remove(provider);
 err_disable_clks:
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 
 	return ret;
 }
@@ -570,7 +570,7 @@ int qnoc_remove(struct platform_device *pdev)
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 
 	return 0;
 }
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d6b4c56bf02c..d4401f35f6d2 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,7 +23,7 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @num_clks: the total number of clk_bulk_data entries
+ * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
@@ -32,7 +32,7 @@ enum qcom_icc_type {
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	int num_clks;
+	int num_bus_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;

-- 
2.39.2

