Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086669670D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjBNOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjBNOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:38:07 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588E244A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w3so10688687edc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZQ+Q5LCAHKHQSgy3yl+J2ss+UfKNp2XcWG5M2noUQM=;
        b=v1ohS2cMmusUnrYLqFzah4WLvGW1n71og7wpUyBJLys2wk2hZ37taW+GANhe+QR4za
         0DOvf593h4DgFfNJ5fm1jIIB2fv2GuheHbyghXCjW8TL7/uYRyTuIw5ed8ojxLQFC2ds
         Wk81OqgArmoTcFLX1m/MFZFds4Rwtgm6ULpmSvJUgMWev8DWEwm7ivnjU67SRAYf3Y79
         rYXfJSYr3PBWFxv0+8fWEMpgXlxIMMbJ5Ta8ghlhxCoTwFqOnkomCbdIA8luwgMt7YVi
         r87gSLqRIZ6497Ws8SoZHf5BB2ezK2b02FfwIyCJSe+PQZ9ypqVSVEUygfkJbxZJgfwO
         f1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZQ+Q5LCAHKHQSgy3yl+J2ss+UfKNp2XcWG5M2noUQM=;
        b=iuYuhIXWKgfs5c4n0BsGTbMc5iHD25Za2UlZjPK88c/YrRCq8/H7hp0R2q68BEHTTs
         x8e2D0ktMqbOXlPsLLCgL6FTxpba3xSycQaqPz8vOJTvaX09gDJGk1SWrfJyFW5rNbaF
         mN5WXEDM7V/4N6DLXIMSirSlRxLzcJq/3FVF/nbpen9GeUczXAFV3+ENrMTHCSiKT+eo
         C1GegG+YPS8qwo/dBdXII1pilOmmaYGrvrCVLI5zc7nTfskXVBFbCjTsS2uHvGNACKO8
         wE3qCNx4z4506pM7RRTlZCow1XQEMeXse3g37L2QrU/bmkP8wS2bKySriqthTvT99Gkh
         65BQ==
X-Gm-Message-State: AO0yUKUiAq71WW7/EgmmJvqYgcWxxq8oTKEAKvxz7QWQ3V6yIsQE0IBm
        6tptn8svmydKuNOgdCVK8Es4fg==
X-Google-Smtp-Source: AK7set9kDbCN3DytGLWPJni3E26eW299uOBWkxKbu8Z5m9InIIYQyiR0e0YmdoCHVdP31zxBqrCNdQ==
X-Received: by 2002:a50:9ee7:0:b0:4aa:a390:bf4a with SMTP id a94-20020a509ee7000000b004aaa390bf4amr2987011edf.20.1676385485402;
        Tue, 14 Feb 2023 06:38:05 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:05 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/12] interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
Date:   Tue, 14 Feb 2023 15:37:13 +0100
Message-Id: <20230214143720.2416762-6-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 37a299f4de6a..76e8f660b932 100644
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
 
@@ -521,7 +521,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
 
@@ -554,7 +554,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
 	return ret;
@@ -566,7 +566,7 @@ int qnoc_remove(struct platform_device *pdev)
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
2.39.1

