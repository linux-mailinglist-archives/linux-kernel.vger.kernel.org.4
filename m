Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B46DB50A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDGUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDGUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22FBDDF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q16so55678257lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s0KyzdHFTaVpYD3IHUwfb488kPSo+jQrOYqwaSsIUo=;
        b=go4r5JVihkQQblcQ4G5vxq1Z0CTXFplgVnHfahcsO8nR/B1ptHYm91GmmGlMpDQ7L1
         rmlKWBodPxKXH+W9vuYaCVgWpH0QFFTYSCFlr+KqCTr7nW0nHpTxNNIvAz6XS6dbFzIj
         OrLrVfvoZqQMEh8TWSYuBDsVA8fr9+gT5tgfMKg2wJMha0hGRgnNUFpE5lGsm1litlw6
         3M65vjMLT+bu3AUKPIF8p9WF9THinPrhVewKIB9rZOdbomsf2wup4ps34/jvqUOq04BN
         z7Btvbts00hkZshq1yfN9JS3zmDv3QiOxtuVfmTpNUpfFJMuIJxtV4X50E2+IzM2giuC
         62Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s0KyzdHFTaVpYD3IHUwfb488kPSo+jQrOYqwaSsIUo=;
        b=5N5YVowQu97MpAMLfpqc3hid9kIQcEtMz6ZruKR03vrQC+ta6RmU/fjob8UavTMvSO
         jJFg9wN36QDfefqRvfihjarx4IvKyhtrr1L1uTY9/Nt0jLfuJ2mVhMbJ6XuZxEKypMEA
         CMNStVobIHOFCr/pGYaJq2aTfWrWvkvTK/dMzCapr3H7Evvi1eVDRWnh7+hiaBPgoyeO
         pLuQd3YSHO/HuKwsDL5R9THk9l4k4MvJA3JFtEvJjZcXa0Il4PtxYPzzmT8SKbsHqXfD
         NgLuaVpPefcVRX8gc6ETyvh+efDnImxsrhn3bH9zOZDQ/rPtM+Nn1Cox73k2z9ItexAQ
         RG9A==
X-Gm-Message-State: AAQBX9eXYUKVOqpRfOIPvnmW+z3UKGLI8KMaW77ZgbEBjT/Nx0U9gMqS
        bR7skeCa7BTZHpCa2aNdYt8pGH9MG9OAhirtouk=
X-Google-Smtp-Source: AKy350bGyQKWhCW5Eao8Dm5teRNJIhdmfgCuZntokOV5aWEJ22B+mRGDLm+lSCXuKd33DdvgKmBAPg==
X-Received: by 2002:ac2:5206:0:b0:4ea:e5b9:23b7 with SMTP id a6-20020ac25206000000b004eae5b923b7mr977487lfl.2.1680898493438;
        Fri, 07 Apr 2023 13:14:53 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:48 +0200
Subject: [PATCH v8 6/8] interconnect: qcom: icc-rpm: Enforce 2 or 0 bus
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-6-ee696a2c15a9@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=3952;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EgGK1x1RiyMgrD2kZYQgSem5RplbiqiH4kze2S62h0k=;
 b=xty6z7PfiH/CbAPnqHCmo4YWPMSsd33Dcs7tw9vP/lU5oKLxwXOGUvNTb4Lm4uHteS3vgpSnKfaL
 cLdTZumjANz0+KqISWa2bYzQ9nhVoOEwlMn8TiHfXXRP6eW2QxlQ
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
index 419b2122bebd..2298eb019534 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -449,17 +449,9 @@ int qnoc_probe(struct platform_device *pdev)
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
index b9b63860042f..ee705edf19dd 100644
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
@@ -100,9 +100,9 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
-	size_t num_bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
+	bool no_clk_scaling;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 9aedfc8de4bf..dc9959a87df2 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -1819,6 +1819,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
 	.intf_clocks = a0noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
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
2.40.0

