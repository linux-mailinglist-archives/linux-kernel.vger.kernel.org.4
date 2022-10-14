Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19E5FF60D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJNWLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJNWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:10:44 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6BFAE5E;
        Fri, 14 Oct 2022 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665785443; x=1697321443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IVXCDTmtJ9MZtZj0X1aSf97KGfN6jclv/rAdOONBIvU=;
  b=Z0fc7BTQ3zIW2UJBSd7w/exSDtj3D1fYUxRYBszsYISNk8DIIOxsAvC1
   pvkup9eHw4b5xhwVj8o5O5EzGtVpth40z5tn2nFYuiNegOyYYCYexCgS5
   LtG34Zkr07R3t1Nzma/sIZkV0fW2uY/VuaVxen1vZ14Hfo84I6POCpt2v
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Oct 2022 15:10:38 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 15:10:37 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 14 Oct 2022 15:10:23 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v2 3/6] clk: qcom: branch: Add BRANCH_HALT_INVERT flag support for branch clocks
Date:   Fri, 14 Oct 2022 15:10:08 -0700
Message-ID: <20221014221011.7360-4-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014221011.7360-1-quic_molvera@quicinc.com>
References: <20221014221011.7360-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Shaik <quic_imrashai@quicinc.com>

Add the BRANCH_HALT_INVERT flag to handle the inverted status bit check
for branch clocks. Invert branch halt would indicate the clock ON when
CLK_OFF bit is '1' and OFF when CLK_OFF bit is '0'.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 drivers/clk/qcom/clk-branch.c | 5 +++++
 drivers/clk/qcom/clk-branch.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index f869fc6aaed6..b5dc1f4ef277 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -56,6 +57,10 @@ static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
 
 	if (enabling) {
 		val &= mask;
+
+		if (br->halt_check == BRANCH_HALT_INVERT)
+			return (val & BRANCH_CLK_OFF) == BRANCH_CLK_OFF;
+
 		return (val & BRANCH_CLK_OFF) == 0 ||
 			val == BRANCH_NOC_FSM_STATUS_ON;
 	} else {
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 17a58119165e..4ac1debeb91e 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved. */
 
 #ifndef __QCOM_CLK_BRANCH_H__
 #define __QCOM_CLK_BRANCH_H__
@@ -33,6 +34,7 @@ struct clk_branch {
 #define BRANCH_HALT_ENABLE_VOTED	(BRANCH_HALT_ENABLE | BRANCH_VOTED)
 #define BRANCH_HALT_DELAY		2 /* No bit to check; just delay */
 #define BRANCH_HALT_SKIP		3 /* Don't check halt bit */
+#define BRANCH_HALT_INVERT		4 /* Invert logic for halt bit */
 
 	struct clk_regmap clkr;
 };
-- 
2.38.0

