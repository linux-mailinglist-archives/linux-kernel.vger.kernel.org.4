Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1072CE15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjFLS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjFLSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:24:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682E113
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5580732e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594290; x=1689186290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoVwErVMHDjHjayDKUron2vfQdiFrlJxkN0o/O5bBtA=;
        b=qXRITVAtc1dn+CSZ4LgYXqwiWtNcR9mM4H2dFeg2jwOiGmILmjhh9sOyoG9fN5rCmp
         WLYDkWb5McIecYyfKkI69ZqYiLz5SGzxRpDPGg4lk/5GFXMklr7T2H1jtr8HLvPkTJyt
         xZAALrjt+tnR+90+QknVaEAGd+A3NQo7TxDQyDzrEGLCT+5l/oqfs5pU3gCpZcBweaXS
         fsTalvBFG3SQs+djzENhPESI5/lCFktIy0OSAE05yT6V3LxjInpFAMS7uj6tB9VmZ+BU
         pMxJ+wiD4EJ+qcLUq/xIvhfe+ne+1KP+1WgB4R8+EqNSehSgLOcf5ptXcB842i4PThoV
         6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594290; x=1689186290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoVwErVMHDjHjayDKUron2vfQdiFrlJxkN0o/O5bBtA=;
        b=cwYK0+uK2PeY38mkRIfEwBLAmbgqX2sPBlu9BiTvKwzBvkQJZv/0Vkfj9yZ4kK16Qa
         kWWeHoayVhWgL8LET6wy9rL+EnwKIIux/2OgA90lSBmABM2Vrc5jtvDZEE8Gzbi1dNb2
         ZQVmmXnUg/5aQoyvIM6RXKUulqRDQfmzaExv6re9viGg6wghTClEhpug+uIjt7dVMydc
         Af5OrRpSWkUpRDtgK6HmjJUueBlckA1r/IzH3bG2WKAVWlUg0rmcJM3CmKw3dMdCAbzY
         J+9zb8VVof/rvUIYUacDMjPvCT7V1HJGoW51uQZRalh/lr0JRvuM0eQiEy7AjHlE3ir+
         KU4Q==
X-Gm-Message-State: AC+VfDwHg+byqzlFj91rFExgQmHkC3K+8/w84vvK7xEYmd1lOhyQyHp2
        Cmib84W3bWmeXMhw647rgCJbT/kOhNgPlRsLDeM=
X-Google-Smtp-Source: ACHHUZ4C95zt4fw031PkmDVq6rh9WnxR9inBA5lq5ZXv7YG33eB8EI6ZIEAIT7A7vCkSZMhjG2FSMw==
X-Received: by 2002:ac2:4da7:0:b0:4f6:54c2:35bd with SMTP id h7-20020ac24da7000000b004f654c235bdmr4391451lfe.11.1686594290517;
        Mon, 12 Jun 2023 11:24:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:26 +0200
Subject: [PATCH v3 09/23] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-9-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=3554;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CbTTRxJto8qrm6plde8cKMqpaBb1rdIRss/XEaPuhyo=;
 b=V8ybrcxkJtmQI9Y0OyQAx8gGXhOVsVAWAmYQeFQkAko3KQzznKBDzT0BSCz3JdRdcGbYuLwET
 JS0y1CmqbY2C6HAx8dSeEQJLyW8lRPvW8sLXe5nSdgeM03lyxl5a3/L
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/smd-rpm.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index b0183262ba66..433276f1e671 100644
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

-- 
2.41.0

