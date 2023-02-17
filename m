Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70869A94E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBQKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjBQKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527AD635B1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x4so911163lfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MZKW1luAupXiDdvhAWR5OgDUlxdbyScvUfNLPjc4eQ=;
        b=Kmd5DPUwzulEC48gA6ic9WdlkQ/hNGjg4WdrrToQ29CqDM4JGKxmh49g9WlEAbrhDj
         Wz94fjSyHw5Qhh+6Y7nG4gV5wUCg6qjls8ZBzHJwBvsNMs5tsLeWN3oAl8juIGoC649a
         0t1ncEVnlsoOYPP3J3F8gJAbA0kwYixnTWxX/U1tv16W7HKqHZsamgOsCcRRqGkzYwRb
         tiz17l6G05COkM+GKA3kTut+glzFqh2jwGx4z8jHpOYmG1Ng8QyzyPLiTr9mXWK+CcVL
         bJQag8Wbp9gwppXpUMEzWAdG3rVgfFxyJr8cHMNTbgibfsrAlRiZLdprjCHfe78HyWZ5
         XQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MZKW1luAupXiDdvhAWR5OgDUlxdbyScvUfNLPjc4eQ=;
        b=o3DqOxfOBKuH2hjVLeMzgbELRjPySBCu/gCclyylAP4PTtuzDLiOjMfKRZuAiEL3ps
         n2FflRw39I8iWIuflK9OjVlg/xnakK9z9jqjZ9nI35/XXxf+eBT0MsBWCjDAkb0FR98D
         EHd00TkYeSJAvy3NDPTKTeA2xMDNo2+kNS4/StHYEZ0Rdxs/12H6HKY+qsKqNP+pS0bo
         zX2yEcU9Y92nLSmAQ3RXPJRbxgCysd3n87gBa6/KF7WPbyb+b3efgS1yigUphbN9dBVx
         /hDtEha/3RhqNuH6zuwayFu3VpYbxUCAVdoifs58zCSBZcTeCNOP3BwENE0rUh0Y12RH
         iH4w==
X-Gm-Message-State: AO0yUKVuhsEEq1C4iBxIDFhS9f7I7fjp5gufAF1C/v7nJKd2Jbs8KRNv
        ZdmijpUXLz0XqaUkT68SyWjEQA==
X-Google-Smtp-Source: AK7set8kMF6hq8uzp/ZoeOSDX6mSYEz6U4PUe8eC1poZ5jXbjITjJsgsSG1fcRpGoyNQf9hMEw37ww==
X-Received: by 2002:ac2:5490:0:b0:4d8:7502:990b with SMTP id t16-20020ac25490000000b004d87502990bmr2392639lfk.64.1676630799341;
        Fri, 17 Feb 2023 02:46:39 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:26 +0100
Subject: [PATCH v5 05/10] interconnect: qcom: rpm: Rename icc provider
 num_clocks to num_bus_clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-5-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=3438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aiMG32ahJtopvSpAYtuicAveB020UtGpy7a97D0jQ6M=;
 b=bWToGfiDHGkY4wV++Fm8DJyFVJXVAqKTWMe4CRzPQiX0tbrooaFBNY90Md8IuQT1y38MLHRAasdo
 Teug8/NwDZ62faBCvlpyzJf6IxVIB4gsXbqNztewiYUvXpF9HxE8
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

In preparation for handling non-scaling clocks that we still have to
enable, rename num_clocks to more descriptive num_bus_clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7a54fe4ccadd..f78c13e6c5ce 100644
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

