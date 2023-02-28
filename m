Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735B6A5A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjB1NpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjB1Noo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE662F792
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id s20so13205184lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd9x+d7515sKxUNxCoW/Rv03ypHAqgqe3FjxGAthHkQ=;
        b=xmyiSwoB6ksw76lPWURTXa1OtcQ8deSc8qxFSCEF9jwdGGulPCdimgisoZGjo4kmP3
         1SH1w1Vm1qGWSGwbmQ8iCQep48NwTpNQw0DWA2rAL9EcBvoM81hlXyM08rD1LHwLGMen
         F3Tdiu/GrNShQU/fICjKpEfZSv7+LK1ScriUGYAeujsJ++IcikkW7PYYmnKMgx8N3NPh
         KOPKXDF/3VMHUkgMYIH/L1uVWbeU3bH1RHBOFS8dgNTj/0PZVnioFCs5oGJ/yKxJAXm3
         iOVX3uT+yosNI/s37hTjkvywAoubm5WiFOECBA7XYbjibGos+DmAeaNh+kYc5y5q1aKP
         P7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd9x+d7515sKxUNxCoW/Rv03ypHAqgqe3FjxGAthHkQ=;
        b=wWxuhbG5SccoqKNikAWO8czcH+M8BHx9pnux1vkb02ysTBtWdIxvI707yOvBjTOII1
         7gHbyZVrcejlVxzH+teiwlr/deYtcbcTLRjzufyG6mUNVbJHbDLRPcjrewbd+gUpUUFl
         mQ0CbV6MgBjwInfUOTQmkqDiTXwStXCqgEpC17zhXH4eV9FYeGsKNKJuw9fMdNPdacCH
         rhnufpeRXQRQ1YSiCt4gdBcMXlS3wrWGOh5076VKpJWI+R+xoP5RuzQxYAj4LllrvhAA
         KK32SiTPJQ0O6xupk1w7S6QtCQNJw0YVswWTrj1KgabZk4pM53conlXBl9KKdofgN67a
         ACrw==
X-Gm-Message-State: AO0yUKWoUnUiwxxClnqrqLOnBO1MA2PU8gxTGvVfKz31F1yUc8Lo5uoz
        X6CGd1odTfBqCiYGue17O7bJjMZqb5sNnA7Y
X-Google-Smtp-Source: AK7set/jiIvRGelGf9ZhVzkFhcmmf0fs+TUEGSTAhJQkhN2w2udFHyHQ4k0pct4UBKWpo9oFgYrO+w==
X-Received: by 2002:ac2:5451:0:b0:4de:3f1e:cdc4 with SMTP id d17-20020ac25451000000b004de3f1ecdc4mr585207lfn.13.1677591870562;
        Tue, 28 Feb 2023 05:44:30 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:30 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:04 +0100
Subject: [PATCH v6 7/9] interconnect: qcom: icc-rpm: Enforce 2 or 0 bus
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-7-3c37a349656f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=3956;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j9XF4WxaLfGj9Ej6rkDHnjJlz9ADRRyGeXxkSRrXYCQ=;
 b=M35JcJbA4z7xVPt78oyUt8q1B96IPmZiN7M3R/pvpsHCHr4+uzvAmsdDhA2yk+jvIkg71yk3//ph
 jUAuZfHqABAngnnLpshAN45cGAeUqMNWoq/wICZzASvAitTUv4fD
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

For SMD RPM bus scaling to work, we need a pair of sleep-wake clocks.
The variable number of them we previously supported was only a hack
to keep the clocks required for QoS register access, but now that
these are separated, we can leave bus_clks to the actual bus clocks.

In cases where there is no actual bus scaling (such as A0NoC on MSM8996
and GNoC on SDM660 where the HLOS is only supposed to program the QoS
registers and the bus is either static or controlled remotely), allow
for no clock scaling with a boolean property.

Remove all the code related to allowing an arbitrary number of bus_clks,
replace the number by BUS_CLK_MAX (= 2) and guard the bus clock paths
to ensure they are not taken on non-scaling buses.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++-----------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 drivers/interconnect/qcom/msm8996.c |  1 +
 drivers/interconnect/qcom/sdm660.c  |  1 +
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 446f6df9bc98..48eb4394b84e 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -485,17 +485,9 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];
 
-	if (desc->num_bus_clocks) {
-		cds = desc->bus_clocks;
-		cd_num = desc->num_bus_clocks;
-	} else {
-		cds = bus_clocks;
-		cd_num = ARRAY_SIZE(bus_clocks);
-	}
-
-	for (i = 0; i < cd_num; i++)
-		qp->bus_clks[i].id = cds[i];
-	qp->num_bus_clks = cd_num;
+	qp->num_bus_clks = desc->no_clk_scaling ? 0 : NUM_BUS_CLKS;
+	for (i = 0; i < qp->num_bus_clks; i++)
+		qp->bus_clks[i].id = bus_clocks[i];
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index a4ef45b4a9e0..3cddff44b4ef 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -25,7 +25,7 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
+ * @num_bus_clks: the total number of bus_clks clk_bulk_data entries (0 or 2)
  * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
@@ -100,10 +100,10 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
-	size_t num_bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool has_bus_pd;
+	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 1a5e0ad36cc4..347fe59ec293 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1820,6 +1820,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.intf_clocks = a0noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
 	.has_bus_pd = true,
+	.no_clk_scaling = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 0e8a96f4ce90..7ffaf70d62d3 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1616,6 +1616,7 @@ static const struct qcom_icc_desc sdm660_gnoc = {
 	.nodes = sdm660_gnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_gnoc_nodes),
 	.regmap_cfg = &sdm660_gnoc_regmap_config,
+	.no_clk_scaling = true,
 };
 
 static struct qcom_icc_node * const sdm660_mnoc_nodes[] = {

-- 
2.39.2

