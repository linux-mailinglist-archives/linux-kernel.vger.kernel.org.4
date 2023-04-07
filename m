Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E476DB505
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDGUPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDGUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D2BDDF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y15so55687335lfa.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aCo6YWSWC7QDyDOgnSdKQprMmsQavo7dczvCShoPH0=;
        b=B1QnkTPGvvIyEvodHBYuu9LL3xe40OdQRgBTwdVVM1iEc5BoNzebvBFN3e2/oxXg5q
         cA0iMRDsD1CxGngS9MN+hNqQKl8MaTf1mdrHW6psnJAouLqolZkiAyu4k2KoSho3IQJP
         hX9Dp8H59wOyJnYL8bqqwax6hNPdzX5c0BlI0tBMq++2uSH+0BxK4URNrX1syN6BCEau
         DOYnHfK8OIaI0GoOQ+lQafgi55K+Vt1JuNpZqqtyV4WDFbYrrLKFY9bZ1b3I6eJ8b7cI
         BlebXXH8a9E/5it8zIbvnGBfb/WugaP2oEjhA06OEzrSZnIsSK/dup66VuNl5O6C67Ea
         CmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aCo6YWSWC7QDyDOgnSdKQprMmsQavo7dczvCShoPH0=;
        b=y3+gemRYiPZxmQ1ztJICLxPmLP84SiB+6fqDax1NWwKqNgQVyj7Zf3TIJdoFu7YUaE
         9Z8pIJfwzbeJmxbbj7f5GOqIBtc/NEy9cPMdpvoD6A92zaL95xJb8jLKKIPS0CqaFfTo
         yWk3kW/9N91kb5ZhfgqSgYpBEx6nc+BGzZONpIuoRwKqxqorg0vesh6/qBCdu3s8YaiM
         mKpsYWN6NNiYMAWFcayJQltCcqGZcFBUmg1p+oWYxChCFDVFaCOGac3wFI4gtVYI4kPE
         vdcxHwpPtJq3YKiABWOC+Spglh+svhyaevf1T1ehLr0DO1sqZVw/5ckltOms/n9BG0a1
         nInQ==
X-Gm-Message-State: AAQBX9cqFYQoJL10aVA8DIMyc+zPapV2aCSE6JevdzxFjAc/e4x5pMkA
        vNQdTOHejA2BR65wKWlObzWQHA==
X-Google-Smtp-Source: AKy350ZWAFUetM5TUyfwMXrFXqhTKAHsnvo3YH5ggDIek8UB9G5BzAnNUb9WIv9JDbv9Mbo+rQTHAw==
X-Received: by 2002:a19:ac4c:0:b0:4db:3e1a:fc7 with SMTP id r12-20020a19ac4c000000b004db3e1a0fc7mr182lfc.31.1680898488054;
        Fri, 07 Apr 2023 13:14:48 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:44 +0200
Subject: [PATCH v8 2/8] interconnect: qcom: rpm: Rename icc provider
 num_clocks to num_bus_clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-2-ee696a2c15a9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=3064;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AL/5pHSAvV2vBdT049aGNYdnVcOJiOzItHlBogTY10o=;
 b=wcySxfPAttSxwn9WOps36nlx4KY+U5yuRwJOUN5PySwu0zk63hRzqg6cSXdop7Vb7O8irN7gk2oV
 ahgwNVKXA7+ESyhtSG/tyco/laQlr4+2aO6/nyR9yUJKzx5lancD
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

In preparation for handling non-scaling clocks that we still have to
enable, rename num_clocks to more descriptive num_bus_clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 12 ++++++------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ee3d09a6850e..8dce3dcff8da 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -379,7 +379,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_clks; i++) {
+	for (i = 0; i < qp->num_bus_clks; i++) {
 		/*
 		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
 		 * for other clocks.  If a platform doesn't set interconnect
@@ -464,7 +464,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
-	qp->num_clks = cd_num;
+	qp->num_bus_clks = cd_num;
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -494,11 +494,11 @@ int qnoc_probe(struct platform_device *pdev)
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
 
@@ -551,7 +551,7 @@ int qnoc_probe(struct platform_device *pdev)
 	icc_provider_deregister(provider);
 err_remove_nodes:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 
 	return ret;
 }
@@ -563,7 +563,7 @@ int qnoc_remove(struct platform_device *pdev)
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 
 	return 0;
 }
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 689300a2fd4e..2436777820a4 100644
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
2.40.0

