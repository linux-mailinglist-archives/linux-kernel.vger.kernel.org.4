Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4946F66BFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjAPNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjAPNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:22:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6BB1A4B3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a11so2576365lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OozpeIfKZUe2RNntDDmLbGsXIgqGkWGMpzQghUMFV4A=;
        b=SfWliU+hovruEsUKhOCTMCOp8YVB776IQ3eNYGZ3boVrFKk8zqjsmO/gSs3M/n+V+X
         6AtbmgwZVH3sp+0KeATrkiwR7kLvc7PJfeVK3n3ftDdGH7YHdVrJ8cRP+Dh6yKdjIKa+
         dq3ngFCB/m9RWiQLjXDyWPkJKo5KAVtq8DJyODedUiuAhhnVvyGYhWXGA8/qu5sEZ/+Q
         ClqMB+52pxICmeQ7zRmRA1PFAwyJJrraM+cK1F+rCu58HMwwQ/cNAWwwuzLbB5WgCVYT
         JWBlRWtAwluObgsqYSibXLnRx3yS+nEpDkudom6Pt88psqFhMWpDXBxZ9DFx71SdOGsO
         E2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OozpeIfKZUe2RNntDDmLbGsXIgqGkWGMpzQghUMFV4A=;
        b=1fGf9D1ooDdUzYQ1UXS7M+MfoZ3ZWwppwhq6KIUs1GoPTX9ayDRHGuesExzd3R1EtQ
         TEOQ03aaPPKSSMiOa08c4F/NGLLiADseoBlKXpkxZq8G4eh1pmK6w3xtIKDkAvJl1ksl
         iW7gq3AwypVQmSNMnMUWXKE0fNhWp2MAoxY1S7bqfMQS168n0weIrZbsBiVewP25tE5W
         Y+40Hj5VsGdZDPhcvhP7OL7krSQhtj3DCDELeDOdJeKPcSQRZ0Crv1hRKQ9VXnRQg6ft
         OewzR1XJTNOq/eMFjNbXO22HKeXkzBerWxn3dtUiiMQZAfXhaetSGzqC0Xw4Kfa9hwds
         ROPg==
X-Gm-Message-State: AFqh2kokiatLDn8MvT4OOODyFPC30i0cf/OpyI5MhYPM2BCoryjBwppc
        ELxLJoMgDCNx2ydNEzNnxMI9Fw==
X-Google-Smtp-Source: AMrXdXtru/iuqO5bV0jvFb2fF+kIxQTmJxtE3KjzwlmUcFqA7pIhH4a13/i0GHvIfUwgrKzdzgGkxA==
X-Received: by 2002:a05:6512:2085:b0:4d4:ea0f:a784 with SMTP id t5-20020a056512208500b004d4ea0fa784mr1943314lfr.19.1673875327310;
        Mon, 16 Jan 2023 05:22:07 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b004cc58b91177sm5016653lfg.239.2023.01.16.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:22:06 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
Date:   Mon, 16 Jan 2023 14:21:49 +0100
Message-Id: <20230116132152.405535-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116132152.405535-1-konrad.dybcio@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index 31f6f09da4ae..5888241c0477 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -392,7 +392,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_clks; i++) {
+	for (i = 0; i < qp->num_bus_clks; i++) {
 		/*
 		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
 		 * for other clocks.  If a platform doesn't set interconnect
@@ -477,7 +477,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
-	qp->num_clks = cd_num;
+	qp->num_bus_clks = cd_num;
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -507,11 +507,11 @@ int qnoc_probe(struct platform_device *pdev)
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
 
@@ -533,7 +533,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
 
@@ -566,7 +566,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
 	return ret;
@@ -578,7 +578,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
 	return 0;
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
2.39.0

