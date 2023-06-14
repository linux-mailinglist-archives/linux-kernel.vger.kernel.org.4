Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE43B730702
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjFNSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjFNSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F12116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f655293a38so8762100e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765891; x=1689357891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMhyB/RpDb2yjDqD1QrZgIdZflFbKzp97wvcFuesnD0=;
        b=upPlIKm+tolcMQ5+qZfqpv6jWmH3EHe8ralpHU4jSNkDBY2zjYM7ZFWFFAJMLXW+/6
         jbVEGjkGykFNWJCC4er3hUu3eVJ81Q3nv1XAJbwhfaA5Pc7zMKpQcev2F0baxkRSun6P
         17PNsX7CE5Kk0EtZLm2WiN1hwvShL4m0qFUYNfJbRTU5NJcbtSuZFCmSwmGX7DztNjhf
         AugnmUvfDNumbM/elMa4rZvLKhPmO7VA271tIwd4T7MogPd8s51+SGA+1aOQj7CmLZ0B
         Zf1ntsb8IY/YtlR498JgbWD+JnOJew2Ul7kfu3beRN0GxjRYchOdaT0ZlNsXC4WyYk0b
         0C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765891; x=1689357891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMhyB/RpDb2yjDqD1QrZgIdZflFbKzp97wvcFuesnD0=;
        b=KSh/2VDf94wBvmAZ5dbaZZN/t8zK2FW+KMK4mNDgLohxFBIOHUG6EyU95ushvtK3oC
         Ce+ObFw/02nhcBelj1ZS8b6/j1ikc3DiH4TkITxtdCfz7KsLFGWxuVrbtTIZufO73QaL
         eohPBq79ttG5iqaQaKF6c9U8IC8vnXIIMv4LVBq3gCIgDgo0Ze047OWYktVvpFL0Js0q
         SDDMIVGz5lo4AqiqexwRpDW6OMWArITNHLbTek3xaawYMh47ucD/aMp1KaoWemGxxXRZ
         2AjGq22ALSI8rsx7KHe7WEDMrKm6h3Na1cklpsKGPlUYe2u6lJaWBYnHJYUUVTRVm9lb
         q0gg==
X-Gm-Message-State: AC+VfDwxDcSEgbbFx4eGMUrGCP/6SwbX6k3v+U5jB8m1BqpOPQHOtS9V
        1a2fD+0hgTFktZxgaf1pGDw3mA==
X-Google-Smtp-Source: ACHHUZ6P8hhQia7Ebub4IAKRsVrm1V8cXT6ihFhFZ+xHA6ZgOl6VHQLFno7QP/4iX39XW9xvRkUJKA==
X-Received: by 2002:ac2:46ec:0:b0:4f3:a820:dd98 with SMTP id q12-20020ac246ec000000b004f3a820dd98mr8963435lfo.7.1686765890842;
        Wed, 14 Jun 2023 11:04:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:30 +0200
Subject: [PATCH v6 11/22] interconnect: qcom: sdm660: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-11-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=1986;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xMlMRTkT4oZ3O3DhlrRW9yoPIGqYk7SOo/vjpjmWPac=;
 b=H5234cvJ6NDXbJ3laLRNvGm0U7WrBzqr6vGHOzp9t+WHv7ao+g6ma5IyvYB0Dk0vC/iE/Pbx6
 BjbVHAEfGJmAWBaFORV2nK1oqGr+DBtBi8W2YzmiSq2rQLK1aHyJaRy
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index e7bd86808f13..ad5d52af7eab 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1510,6 +1510,7 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
+	.bus_clk_desc = &aggre2_clk,
 	.intf_clocks = a2noc_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
@@ -1538,6 +1539,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = sdm660_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
 };
 
@@ -1592,6 +1594,7 @@ static const struct qcom_icc_desc sdm660_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &sdm660_cnoc_regmap_config,
 };
 
@@ -1654,6 +1657,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
@@ -1691,6 +1695,7 @@ static const struct qcom_icc_desc sdm660_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &sdm660_snoc_regmap_config,
 };
 

-- 
2.41.0

