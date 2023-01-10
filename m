Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF019664198
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbjAJNWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjAJNW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:22:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62A1BE98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f34so18346535lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1jCryZd0MLquey5H0nTF2IFCusGwBvh3/onGnyEr0M=;
        b=kdcVyit4GtBoFq9PSCOoHCt7y8Tf7a/lDpaBGo2/hR5y0yeUeVKL0O2X69nY7c+Mri
         o9x6dXMz3MCF+lvEVsGAiJ4MXv8JOSfOdNmpGNvm0jSpXUZkdbJ0evhNgG6ObQ8i9sAu
         ZjOzfWZxP1tJM8tfDDJ4Zsi7FK8R8uK6ByQxnyLPJm/qenlxnc7avIP+VXK4ZHuN3oXM
         Ar5ka5oYLk1g8TA+JigkKYMbCQw0ohTIMZSdgpJNasENdfwTgLDuiotzGJgH+bNlsjQQ
         +/SjozOLbQPzp6k96RHCbModKg0ZN/hfmMYI8j0dS6rxT4UCY1x7Jy/JwaYfQmPSzUCp
         Wahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1jCryZd0MLquey5H0nTF2IFCusGwBvh3/onGnyEr0M=;
        b=vA4hP/ypG7OdOlifZrTRrHUFQYwDRgjsF27rzxcNAZ/9cDKC2yrDQvnrlRZEAgw+38
         v05vVqmwJ3fCb2G3slfrFvxCxS/XdkDjzhBeUghjLgCeyLqANu27d9y22ZMOEYDUVKwB
         5I0ohj+r7S6wCRTxOdqdIkzl1xgvEwVusW391fW8jGkpIww78VJxK5i6c0RcuRHVPL3h
         UnJv2e5flr4zVfnt4Qi4Qwyr8wwGz3AWIWPtxLlpDHLApDB34dlOZ6EdA1p2X8d66ldL
         Kyla1k+PnzRuANHQ9hc9+YBORp2Pe+qiU7Bdf2udYkusbd4Gm36REKWg+WJI5m52CltX
         nC7g==
X-Gm-Message-State: AFqh2kqcy2XIrVENQDRSZc6/uUiCJ3J37zwxapBOTgtcSXouw253chCF
        butoQrGT8gB5x0NDgDZtaNgazA==
X-Google-Smtp-Source: AMrXdXtH2OgiIGpqQ67QPhspmtX8/aoipBQ4txDs07SxJ1m9wWK9Y8gAC45JALVxWt6rkGM7RAVnag==
X-Received: by 2002:a05:6512:3c9e:b0:4b6:a6e4:ab7a with SMTP id h30-20020a0565123c9e00b004b6a6e4ab7amr22899322lfv.8.1673356938455;
        Tue, 10 Jan 2023 05:22:18 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:17 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
Date:   Tue, 10 Jan 2023 14:21:59 +0100
Message-Id: <20230110132202.956619-8-konrad.dybcio@linaro.org>
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

In preparation for handling non-scaling clocks that we still have to
enable, rename num_clocks to more descriptive num_bus_clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 80b5008c8b43..150ae89e0a1a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -399,7 +399,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_clks; i++) {
+	for (i = 0; i < qp->num_bus_clks; i++) {
 		/*
 		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
 		 * for other clocks.  If a platform doesn't set interconnect
@@ -484,7 +484,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
-	qp->num_clks = cd_num;
+	qp->num_bus_clks = cd_num;
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -514,11 +514,11 @@ int qnoc_probe(struct platform_device *pdev)
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
 
@@ -540,7 +540,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
 
@@ -573,7 +573,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
 	return ret;
@@ -585,7 +585,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
 	return 0;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 206a7f8dab0c..d55d2bd44b7d 100644
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
 	int qos_offset;
-- 
2.39.0

