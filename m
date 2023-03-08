Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58A6B1461
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCHVlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCHVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:41:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BC125E3D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:41:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y14so18057123ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unt+dPLwzkgBjPSkzsrVRAW1HisvFWN9XweBb7CWlcc=;
        b=iYUBgB6I/XNDs7MZcPLs9Pg6hHIj6L63f2DFpjEofHbJ1uJ8y480C1ua+vBa0tUJPF
         d6VEAVJqTe8OdyOcbPYBAbatOr25CHX8/lfaQnyaD5BNwnBLBT4YXwK5HZZunwO1R1FX
         ktdCIGwLdEwMjZ5LhdBXYe2z+u5YR4uCe0MXmABP0DyN3x5jAD/FnFK0ED6SRv1BgHff
         Op2REMJcU9grd0GcyGWSkoYNuc4sAzyqzi+/pA+g1kbg4zHVtAHZ+S8bmAAOGsVFC7HD
         rgQKPXbemTWfEmpuTkVqfc6Kpm3A3vkBRbXemG1La81uzYeKiYdZG7pG8QwmtRC8oxvP
         gIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unt+dPLwzkgBjPSkzsrVRAW1HisvFWN9XweBb7CWlcc=;
        b=eu0lNJK2H3o3BaHX0YxR6rBd7w73cRIpGPjKukVbrqjIcZ3udmT0UxpaJYhq7OzhDa
         BEf4o1G+gYJldx+lJcyrvNIHpq7tfQhZMHuJ0LmJeLOel3PVI1vEJukbdcPoTLJOZ8wd
         jVufE5/lgeVT91hQ/dBozB9Fv1WsHth/BkL1wzuTwDQhkRUH/GMzoHDT+7aC50Xc0Xnw
         OySOPJvcNG+RZyTqMF+UQdJ+EaJD9jXp1YMPxElykgQg2VXetkVYVt5o7wO9vRO+isqr
         b+Z1/WdXZ1gv23hD3YXbi4y2/Gge7DfOfNBS51cfeFz0X0i4kCjFOg5SkmH7hw/dB+b0
         y7Ww==
X-Gm-Message-State: AO0yUKW7Z3Rr1XJLSH466Zf9efO0ISZSjpAmKKflT19DDHucLM7d4Tsd
        DG8oq2FVmCKC8XUHQMaPUFYwiagGOfiMO8bT0Z8=
X-Google-Smtp-Source: AK7set/SyoVD86AitSzXcVLVxn5MQd+pC1FxWR6jvTCiFvt79bFw612YamJyx8eYCg47FXPJrGR91g==
X-Received: by 2002:a05:651c:543:b0:295:a3f6:43b5 with SMTP id q3-20020a05651c054300b00295a3f643b5mr9959326ljp.39.1678311634349;
        Wed, 08 Mar 2023 13:40:34 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a6-20020a2e8606000000b00295a2a608e9sm2688844lji.111.2023.03.08.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:40:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:40:13 +0100
Subject: [PATCH v7 7/9] interconnect: qcom: icc-rpm: Enforce 2 or 0 bus
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v7-7-815606092fff@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311609; l=3956;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nj1ikMGVO7EgZAVkHUb/GU8vQaA6emWCF0oysxBXbt0=;
 b=eSJQ+LMTzaVG8udxqxqS8GpeeEcSj1itclMCXe3BxIfDOdo90YFfck3aG2FUrisriVEHbEL4b2zN
 4UP//YJpBzpK8qK+nk0mSg4QkqtxpaWBph2rf2dtVgXnbUE4RD3t
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
index ca932ed720fb..31d069433343 100644
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

