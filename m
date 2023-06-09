Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55272A487
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFIUUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFIUTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA993C12
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f644dffd71so2823609e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341968; x=1688933968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+fKLnlHalDuAg33z9Jtbv/mJQQ+EEa4+LdoMppCsko=;
        b=FZox072qCZ8+Vgc5KjdNja5smMo2cEH6xpKztsqEF5trGJxhoiMToftA5/7BPibrKO
         JTaQi6LTL1AsuMGw/O9hnee01Jx8XaWqqo4FtEpW8eLgshpJYZEXRdrkWAMfkAThxvYx
         H8X4OqimxE3JoUrHoX+ShTWoZ2u3sAXinLHAwt/dhI/5yxI4Oosk2wGtVBenJJumPyLb
         GODpo09XSsf7lkq8lZgdgmze2DPvAXslkNYJI6hgBdY+IQ429ooZwwtv4lkjRxX369J4
         FaEYidvm8RYaCZu4qT2t1qCjzMgvwJ6Vr9vdYjFSVLK8dNSZW0d2Jve+BMTTIVtwIao4
         6TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341968; x=1688933968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+fKLnlHalDuAg33z9Jtbv/mJQQ+EEa4+LdoMppCsko=;
        b=PYN8Hgh8XdDuAngqd0z1JOUFJ2NF6wGAlXH4lTvT73Wv2wtsQTNaMZXWPHtXdJ2JGX
         zrgHt0H4ReVO69AZ3GBu5kj1TZASZy/seAAT6aFc3gEpnW9j8Gt3UMhPVpna9bdNWpGT
         rjRz50e68Jl91PHIpDRGzmiDNMyUKJMGHtS2dzcl06nEfxzPxupeLgUzn1pVVBg8XjDK
         kcGb+YzaKANTZ8ByGl61yPmHwso2witDsaZovs7Lyg6sQ2+XUX25u5aSfvStKin4lMly
         mewqEHqqsP+YRa1aGRfjVTH7ZER4uQDG3BwNi8u9JwH7ACeL66KLUn92kvwP/zXfx0bO
         yimw==
X-Gm-Message-State: AC+VfDwrr08IbTJIzOHVXI0Ldp2cVs03JxiCsW9m3QSU4X7jk6Mo60Hd
        EyfM4yyals/U6I4pDEODwVO8XA==
X-Google-Smtp-Source: ACHHUZ7Jg71QhNkh0TVgjGSlBoPjUiegm74pkiBf41tE2jcyGDtYqSkXKZOBSwvQTP+MTWyLDs987g==
X-Received: by 2002:ac2:4d9b:0:b0:4f3:a61d:19d2 with SMTP id g27-20020ac24d9b000000b004f3a61d19d2mr1591779lfe.36.1686341967962;
        Fri, 09 Jun 2023 13:19:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:15 +0200
Subject: [PATCH v2 10/22] interconnect: qcom: Define RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-10-e5934b07d813@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=3759;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x0HK0TeLMEP7kpXmLD7jervQe77EX+FiCHoc2go6cXk=;
 b=eIMSoSow1QKNvTDcfCtM27veub/s1S90w0vRNDyG2OsSNUnMncdygzEMKGfOL3FbhA/e6gUYg
 9YgZZCGB7ovC7Hr9kLoo05AjRhFRPuCCDlJApxei75dxRUOvjDKYQjX
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
index 057a1a8b3cb9..99e34f684c85 100644
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
2.41.0

