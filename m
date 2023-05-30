Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A9C715B63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjE3KUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjE3KUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C95F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4f757d575so3098298e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442006; x=1688034006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvXpNIbHmqtd4lG8jcv7ZzbkoIqN9kOw2a/0JaApzvg=;
        b=nm8S0ICs/LpwJ5/vDr0fd5IwjPwej8X5egeLTLnaOEyL+sObY7zIlZUwD0wCwzw5Ra
         YMLO7XxpAo6jltNKhmLabdHmu+OOPDT0T8R4rB00vqaSSp0uO1sWQUfJbZUJeIoSkJGc
         c3qVoYHkIxs+oQMJ7crPlm3Mdp723q8c4aXdBTaggGPRZHyjYrAxVGYhTVuCzaTsYbcH
         chhgfNV626FRO8m8PFCEAHbrHIV6yFhCFGwsbX6uqdeICuonE6RsGUWNS0I2IDqCDfRy
         e+HrJA+TxU1iaLyJ6/ojVjBVrNmdltUSckZqayHVhOnEThXlKDweEPhUQ/7rHlzKnJc6
         ZXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442006; x=1688034006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvXpNIbHmqtd4lG8jcv7ZzbkoIqN9kOw2a/0JaApzvg=;
        b=jZ8Jw4igROVMM11Iz76YN3cH29p4UUAuJreBV98uLJQEgK94P98q6AihAtXq/wARHu
         F2ipAzR6yw5/CyyiQtb/B3A6AfqDfpjmcjLGlrzpFo1ffNBubVF6IRHo/YPXWMyvbaam
         /mhgENxUbaSn9DLSAD/sUlAD/5fVUncnGIE0xXBFfIdk24eUaDwTxmKSMChWawpFNUIX
         /vQEomhj5eQISjmz0dr6ZqAhNSQPcO/7qzrVrV/C126dOsFzXLdqLC0w/R2DLL74aBC5
         X1mdhiIEqqXrCfx1V02jeODYTie8Xh+Vb9NRYbjuI0+EVd27hAY0x2dB9CNA82aIrhGT
         sb0Q==
X-Gm-Message-State: AC+VfDxF1tFSCvqwKkss911WzrVm57EGdehLx4XWa+8KxIwR4+XVaSG6
        OeAYQn0KPwbNZuQkMdAPKRjKww==
X-Google-Smtp-Source: ACHHUZ5+zKi+lgYEbZ1esDpzoBfTLPxmkNqynE9WjjmRdGWq94hAmEPOF3K7nDXeSyVqyzjcalxqFg==
X-Received: by 2002:a05:6512:968:b0:4e8:487a:7c2e with SMTP id v8-20020a056512096800b004e8487a7c2emr501857lft.14.1685442006314;
        Tue, 30 May 2023 03:20:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:01 +0200
Subject: [PATCH 02/20] clk: qcom: smd-rpm: Move some RPM resources to the
 common header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-2-1bf8e6663c4e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=2376;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ApK/VPfTmld07UKzNhGBat7UaI7zSF3PDIl2T4HqloY=;
 b=rSjHIbUA7ZHfYPhT2WvjHFRqSyeNfPKb8oZvSP/GEIX6r6PpXXzQLHMrQUZnUjUmiAQcskOnF
 GkrinvwTeNDD7nra0QIM6+AOf0Nu7SwerMpzW2LOHwnb0E4QHAWiNBa
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

In preparation for handling the bus clocks in the icc driver, carve out
some defines and a struct definition to the common rpm header.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c   | 13 -------------
 include/linux/soc/qcom/smd-rpm.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index e4de74b68797..937cb1515968 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -18,13 +18,6 @@
 
 #include <dt-bindings/clock/qcom,rpmcc.h>
 
-#define QCOM_RPM_KEY_SOFTWARE_ENABLE			0x6e657773
-#define QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY	0x62636370
-#define QCOM_RPM_SMD_KEY_RATE				0x007a484b
-#define QCOM_RPM_SMD_KEY_ENABLE				0x62616e45
-#define QCOM_RPM_SMD_KEY_STATE				0x54415453
-#define QCOM_RPM_SCALING_ENABLE_ID			0x2
-
 #define __DEFINE_CLK_SMD_RPM_PREFIX(_prefix, _name, _active,		      \
 				    type, r_id, key)			      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_active;	      \
@@ -171,12 +164,6 @@ struct clk_smd_rpm {
 	unsigned long rate;
 };
 
-struct clk_smd_rpm_req {
-	__le32 key;
-	__le32 nbytes;
-	__le32 value;
-};
-
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 99499e4b080e..8190878645f9 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -2,6 +2,8 @@
 #ifndef __QCOM_SMD_RPM_H__
 #define __QCOM_SMD_RPM_H__
 
+#include <linux/types.h>
+
 struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE	0
@@ -45,6 +47,19 @@ struct qcom_smd_rpm;
 #define QCOM_SMD_RPM_PKA_CLK	0x616b70
 #define QCOM_SMD_RPM_MCFG_CLK	0x6766636d
 
+#define QCOM_RPM_KEY_SOFTWARE_ENABLE			0x6e657773
+#define QCOM_RPM_KEY_PIN_CTRL_CLK_BUFFER_ENABLE_KEY	0x62636370
+#define QCOM_RPM_SMD_KEY_RATE				0x007a484b
+#define QCOM_RPM_SMD_KEY_ENABLE				0x62616e45
+#define QCOM_RPM_SMD_KEY_STATE				0x54415453
+#define QCOM_RPM_SCALING_ENABLE_ID			0x2
+
+struct clk_smd_rpm_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
 int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 		       int state,
 		       u32 resource_type, u32 resource_id,

-- 
2.40.1

