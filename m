Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555F972A47D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjFIUUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjFIUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1B3A8C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f65779894eso1832862e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341965; x=1688933965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfrxuCryRwNruY8M45Wu3RJX+ovLhKu0IcVWJCqPsxA=;
        b=KP3A7+9FBIecqU615cEw0NVUU7OZT2ysrAuA3GWbLrqAPv2q2um9rzZ9rE7wrLB0C3
         LmuTLt3juXN8Ppiz8vxzUtdKH3bZ7cM6gnVEF3H/ikoRPwi0pX7qUOW3Vh4Yu0CX278F
         MCLAz17EOt2i+00pCEo0JaZeRc/qp5dE3HLJyWMjoqVuSrxGN3pv5CDX0ydcde1DhuOI
         O7nbNMkI4aWEcNAngz62MgmaqsMbOiBKDBlw1sOlNAElaihzwJeqrGVqYkGk9j7b38gC
         ysjsoTznvLK5uIDcIw+xk6X0rqRco6GxK+b9ToBjqF1sKtdOCTIZhr48QRT4Gmmfd5E3
         CmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341965; x=1688933965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfrxuCryRwNruY8M45Wu3RJX+ovLhKu0IcVWJCqPsxA=;
        b=dxpuUXDcz+Wn4RIGYr+ysin3CTxGSSy+Agwg76Gi6MOWntTyi0CXsKKph1I1rkfnwb
         O2jw9rq0SxlPNlESxYrrv9tc9CYfpqb37Dbwhr+JGtphVTD6lzKXPS3R+8OwjnP102ao
         liIf2KsSU7WARAnCoztzkIyIMhOhwXxase+PFTpJhOYA6Mvo6mqTvI9ECRwG01quJvPN
         UwwaXvozjfzhTmwdYMo9mr9l0uBMCASX2RXObhYSTELQwXPWvNEfzHWge8gy2hHA8B1D
         3pA3d+bSxfCqNSKck6JPovMQ+3qRtetXBZENZ17tQacXCq83jhzMPWY8pJoiWmNXmQLW
         hptw==
X-Gm-Message-State: AC+VfDwg0hTkRyuUEGLdSwhvKKqIQAeY9hKvjgCeR/6CQ+64+3hMEuE8
        gCQSv2V4jEQyi9c4jJYgzh1Mpg==
X-Google-Smtp-Source: ACHHUZ57mtvh0Fc3MOodhaPBpI9c+k4zhwvL0O8bCEslmW59IgvvJBqXfyROP6dh646bawhPQGXjBA==
X-Received: by 2002:a05:6512:1189:b0:4f6:29b1:c872 with SMTP id g9-20020a056512118900b004f629b1c872mr993739lfr.34.1686341965479;
        Fri, 09 Jun 2023 13:19:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:13 +0200
Subject: [PATCH v2 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-8-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=3840;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Be0qL+ODrjCDl44ro/wrhtm3D8xnErJxyrWWn+SRhEI=;
 b=7lsJVMnla/ctq1ICQUEQZnHZ5G+do1MXvq8+atVp+X9Wj7lkLh6SSBUpc/FVjWwAeOPlKXWkW
 oe4s086HNvSAU9FRarNzMqepczduiogllgwdRJB3hoKtaWyTL6kVf7u
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

Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
clock resources within the interconnect framework. This lets us greatly
simplify all of the code handling, as setting the rate comes down to:

u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
write_to_rpm(clock.description, rate_khz);

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 9b4ea4e39b9f..aec192321411 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -22,6 +22,18 @@ enum qcom_icc_type {
 	QCOM_ICC_QNOC,
 };
 
+/**
+ * struct rpm_clk_resource - RPM bus clock resource
+ * @resource_type: RPM resource type of the clock resource
+ * @clock_id: index of the clock resource of a specific resource type
+ * @branch: whether the resource represents a branch clock
+*/
+struct rpm_clk_resource {
+	u32 resource_type;
+	u32 clock_id;
+	bool branch;
+};
+
 #define NUM_BUS_CLKS	2
 
 /**
@@ -47,6 +59,7 @@ struct qcom_icc_provider {
 	int qos_offset;
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool is_on;
@@ -104,6 +117,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
+	const struct rpm_clk_resource *bus_clk_desc;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool keep_alive;
@@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
 int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate);
 
 #endif
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index b0183262ba66..6c51e346b326 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -16,6 +16,7 @@
 #include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
+#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
 
 static struct qcom_smd_rpm *icc_smd_rpm;
 
@@ -44,6 +45,38 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
 
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate)
+{
+	struct clk_smd_rpm_req req = {
+		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+	};
+	int ret;
+
+	/* Branch clocks are only on/off */
+	if (clk->branch) {
+		active_rate = !!active_rate;
+		sleep_rate = !!sleep_rate;
+	}
+
+	req.value = cpu_to_le32(active_rate);
+	ret = qcom_rpm_smd_write(icc_smd_rpm,
+				 QCOM_SMD_RPM_ACTIVE_STATE,
+				 clk->resource_type,
+				 clk->clock_id,
+				 &req, sizeof(req));
+	if (ret)
+		return ret;
+
+	req.value = cpu_to_le32(sleep_rate);
+	return qcom_rpm_smd_write(icc_smd_rpm,
+				  QCOM_SMD_RPM_SLEEP_STATE,
+				  clk->resource_type,
+				  clk->clock_id,
+				  &req, sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
+
 static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
 {
 	icc_smd_rpm = NULL;
@@ -60,6 +93,10 @@ static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* We need the clock driver to kick things off first to avoid ugly races */
+	if (!qcom_smd_rpm_scaling_available())
+		return -EPROBE_DEFER;
+
 	return 0;
 }
 

-- 
2.41.0

