Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9D7357CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFSNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjFSNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:04:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06AE7F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f87592eccfso607891e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179885; x=1689771885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J74hRLqdt4phs0w4W6UJv8aBJOI01g/JO9GJ5bngPB0=;
        b=n3tiVERn6y1q2wmgjBdZ/9yYp7yPK7ND0Keb5cGMLL63wdwWtTicToWZfFy3+Th5J4
         fL1NN1cCM8M4NgxhzsPyNLQ1l1LmIMDBBxggaQcE2V4a5bbFwkB8fBgqz7w3ucAK8IDd
         1+pZqIKXNcVsCv6LaXpn3302UwunIRMrxyCmU7Ocg0XhA/4gA1bc79BGY3UW07XGEYL5
         bOMVv8UfOjcZO/crYd+QoJEm3B6UW7h652ytD9soe1tfKtppqh0cY+U0st58WxEmbeuQ
         qRlCTW7WRUuZNx8xq8yBkxlfNW02sB6IQVanSnJs+wf00Vdcmy1CD4hKn+9AXJkGe9bL
         yzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179885; x=1689771885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J74hRLqdt4phs0w4W6UJv8aBJOI01g/JO9GJ5bngPB0=;
        b=PMORba/7Q8N2zYah0jD4DDiDSH4dc2IKyhho5fJY+qQmZb8XcMGuxR5MLLiEFFqaKM
         BDKrRMRfOhM/NGy3XtL7TwCVhXXx6jL551rCs0cD6S9tfbcrzrdFniP+aknrWRnmOygI
         kAWq7bqfullqN5qlnEu33G7iQKvoJ+xCbzsm21+XHhvDr8Fd5Owh1Gy2PHcxNivh+jN7
         TaU8oyYGZpZ1uHAlkNxZ0ggtHjMzkU5zd2YHKK+ODYlbP3PGgkUew7BBbV4SnWPNdKiT
         H734HGBJGLF2TDNrfos4OEI/y3gRPuML1N+58+o2It67lcoAhRYDJldBldT6XRJwhZOW
         G9jA==
X-Gm-Message-State: AC+VfDzj8HQ41BjoYTvyhe87q/T9Vie3R8rfwONXUQiV48L2tQW7YH7m
        QoMPgb+1VlFXioyNp1uOI9y0vQ==
X-Google-Smtp-Source: ACHHUZ77OSp+ZeMK1V7b9Wj7skJyD4Q4DgGwrgTCQXBZrCO/YmTW+8Mx4n5ue69/W3WxZdDTjuI7Zw==
X-Received: by 2002:ac2:4992:0:b0:4f6:392:6917 with SMTP id f18-20020ac24992000000b004f603926917mr6271207lfl.34.1687179885674;
        Mon, 19 Jun 2023 06:04:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:34 +0200
Subject: [PATCH v7 09/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-9-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=3261;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q5JnbdD4AZQp53PuMKdCoeW41i5whKLsOXgMlTL64nI=;
 b=fKzCm0bBoEQy8KB9X6mIjcrEKJZVJ0NGb8AB5bErke+89wn4+hjVgFv6PmEp7uUnzKCuE5jLd
 g/c5GLyeUmwCznmoqQazCLxN5ZT9NJ0SiGfXu0vSKRj5WcIP+Rywog7
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

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
 drivers/interconnect/qcom/smd-rpm.c | 21 +++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 4755e422d2d1..5c43a8023ffa 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -25,6 +25,18 @@ enum qcom_icc_type {
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
@@ -50,6 +62,7 @@ struct qcom_icc_provider {
 	unsigned int qos_offset;
 	u64 bus_clk_rate[NUM_BUS_CLKS];
 	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	const struct rpm_clk_resource *bus_clk_desc;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
 	bool is_on;
@@ -107,6 +120,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
+	const struct rpm_clk_resource *bus_clk_desc;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool keep_alive;
@@ -128,5 +142,6 @@ int qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
 int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int ctx, u32 rate);
 
 #endif
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index b0183262ba66..24bc994e1a12 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -16,6 +16,7 @@
 #include "icc-rpm.h"
 
 #define RPM_KEY_BW		0x00007762
+#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
 
 static struct qcom_smd_rpm *icc_smd_rpm;
 
@@ -44,6 +45,26 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
 
+int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int ctx, u32 rate)
+{
+	struct clk_smd_rpm_req req = {
+		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+	};
+
+	/* Branch clocks are only on/off */
+	if (clk->branch)
+		rate = !!rate;
+
+	req.value = cpu_to_le32(rate);
+	return qcom_rpm_smd_write(icc_smd_rpm,
+				  ctx,
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

