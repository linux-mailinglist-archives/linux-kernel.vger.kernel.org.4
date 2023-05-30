Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18948715B85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjE3KVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjE3KUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE58136
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f5021faa16so2119912e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442017; x=1688034017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAsONE171UzwSRGl6PgVe3dqdksBfyj5NkhGAc1S/Ww=;
        b=frjwm5PPxdjPiGGgAzrG8Q5lwh3+BhsiXLovKQDMq0uZpKXitrwro7by+xn/CDYrBw
         zszsFehxJaLGO25zKXK1SODyHv4w6oPWAC4nfjFFJpPgj3voUnR856kD73seoNdYGaGX
         e6VosZ5Cix+PmbkbixURnBrTBrhDTHIpGVWbLgKha4+TnfqewmdeWXWs+HyPdIvPTY0c
         1WlLrMw1csWqKcGqhJep7Npx88HleuO9XtdxZ1kGoZA9bNfOG6bLPdEAoTzDpfPB02Vk
         aFQpmPsr0+V1QlqdMaucVr6dfAvQw8Owafu3OvN4WUBqmmW9mZOR8rHnZ83BkHup8wPv
         +lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442017; x=1688034017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAsONE171UzwSRGl6PgVe3dqdksBfyj5NkhGAc1S/Ww=;
        b=SsdVBiETpqDtw8dTm+asd/Vao8bkTXSL+5F4vJ5QgSYJJhyrIFDnZaJmB4/rLrKW0c
         MMLMZRmE5fpsEq1iVYDTSQQ+1G1UDLqoXCMuouAWdAfhsJnVvuThFsThVps6HAew4Row
         zA+8wiLZgf8DTGUvKYDztJ0wId5tSFW1A0jkLrIPnUfvsNg0HvRfxCu0vDgYoYBF+bUN
         K40XkIbVmYtfBAJRbFAn00adoWu+OsLXLk0+i8A0FktF1yAcofwMndTRJl7OYcl39wSP
         358+3Pu/oPHNcz9prLLTYUAMiA/s2O6qDiM/122ONbXQ01XY98ZJ7bdxSENSbbCQQ/NL
         2dRw==
X-Gm-Message-State: AC+VfDx/4nwCa+vPwDPh9oC9GWTkN/BUcP2ldFZn5J+7yHG9viaW+Ixq
        w40EqO23QmH+xSkGARoW9fY+ZQ==
X-Google-Smtp-Source: ACHHUZ70f6Zg6og9613w5YSBYgODePBFDat5R6XPuwd4PZVcxJrzXZ8j54RPgNPYJihmJHvWIR5lxA==
X-Received: by 2002:ac2:53a4:0:b0:4eb:c85:bdc2 with SMTP id j4-20020ac253a4000000b004eb0c85bdc2mr512659lfh.2.1685442016950;
        Tue, 30 May 2023 03:20:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:09 +0200
Subject: [PATCH 10/20] interconnect: qcom: Define RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-10-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=3698;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fXrsqgc0ESuIHhXQ72pw1fVDYdStaeM5EbSnljGFx/s=;
 b=dQGfnVFW1/E2mzOi1RzGRMIIivQGDxwKRv7adDq14OX8J/0R+OpkYstNp69Wb/gXFkT7LhSNN
 4OBlzi7j5CnDZESYR4owbIci7A29ThOIOdN0qLUXa7Zr46MIZpvoptI
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

Add the definitions for RPM bus clocks that will be used by many
different platforms.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/Makefile         |  2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c | 66 ++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.h        | 13 ++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ab988926433c..80d9d2da95d1 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -29,7 +29,7 @@ qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
 qnoc-sm8450-objs			:= sm8450.o
 qnoc-sm8550-objs			:= sm8550.o
-icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
+icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
new file mode 100644
index 000000000000..a195bf32aff4
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Linaro Ltd
+ */
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include "icc-rpm.h"
+
+const struct rpm_clk_resource aggre1_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource aggre2_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+};
+
+const struct rpm_clk_resource bimc_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource bus_0_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource bus_1_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource bus_2_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 2,
+};
+
+const struct rpm_clk_resource mmaxi_0_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource mmaxi_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource qup_clk = {
+	.resource_type = QCOM_SMD_RPM_QUP_CLK,
+	.clock_id = 0,
+};
+
+/* Branch clocks */
+const struct rpm_clk_resource aggre1_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+	.branch = true,
+};
+
+const struct rpm_clk_resource aggre2_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+	.branch = true,
+};
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 09abdd0c891e..e3df066fd94e 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -136,6 +136,19 @@ enum qos_mode {
 	NOC_QOS_MODE_BYPASS,
 };
 
+extern const struct rpm_clk_resource aggre1_clk;
+extern const struct rpm_clk_resource aggre2_clk;
+extern const struct rpm_clk_resource bimc_clk;
+extern const struct rpm_clk_resource bus_0_clk;
+extern const struct rpm_clk_resource bus_1_clk;
+extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mmaxi_0_clk;
+extern const struct rpm_clk_resource mmaxi_1_clk;
+extern const struct rpm_clk_resource qup_clk;
+
+extern const struct rpm_clk_resource aggre1_branch_clk;
+extern const struct rpm_clk_resource aggre2_branch_clk;
+
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 

-- 
2.40.1

