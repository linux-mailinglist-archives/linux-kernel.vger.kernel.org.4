Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D9710C20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEYMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbjEYM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:29:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93C18C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094871953bso1438552f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685017789; x=1687609789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJsCP5eAukhRRhN8wNftC7pCTKUCCN0FeNvEngr8YsI=;
        b=ORhM7dDRxsRP2rCm+NpguoZtR6c+ZIqhx8hiJ0JtEwbJpLnmofOvtVln3aE0ReFJnN
         1MwjTOkft1jHmTOVrAVFoHa+vjjhSWw08n4iwjn5S6TzXih1A+5TJojWqYZyChSPrpmR
         A0KnLjmROPGfyorXmwcfNBqYc98ePCCwfv2mthk7DlT076wOF0G/9UXTG/Fb7aQtvr+j
         5toTcRSA0VOpVsAOLXR3MYHD1/pHK+vL5SGAYAlmpo3dtNdg7qoRcd7JIcHZYZfsrQ3s
         C7T/FW5lAd3FeglO2aKPrISkC5ZPR3kS3uWu6mWH5do1BflZruoi8Vht2M9YczgcSIcr
         ie8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017789; x=1687609789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJsCP5eAukhRRhN8wNftC7pCTKUCCN0FeNvEngr8YsI=;
        b=JkmAYI4cAWrmYF/WhDBF5fgz7Qv+xocktjKzMkENuvbUYSgQoL2tty6rYd1CqWLfZY
         ow0viCG3cxOg5rxj1tEKi8+JbCERQoYFtpp45hfTNCFfO6S99Ot34qoACce2PnW40pyW
         s/LTaj9DJpbvrnly6zgBCcWomToDzuj2l7TjB403y9SBAcd4Jb5E18wF8j4umKCx0A//
         qxRSQ7gYKjHDgmjwiTYjHRn/VRzgG0Ftl5pxOvQU1Nrnhz6GyyG+1vrmdxuWJkJgpFv2
         ZovbT996Py8zk2O5KMmPkoKA14rmaGJyZK/d1j0MSyNufv2LF82KLg76Tahc2h3y+wPc
         qzzw==
X-Gm-Message-State: AC+VfDyVUOTYGKuQD9F18CebQ0lRuHCrUgvgSNqkKhtLtg6Qt1J7r+2e
        ML+mpxzq0gangQ03X/NrMVRLsCYuQK/x7mTOZCo=
X-Google-Smtp-Source: ACHHUZ4vMqeUCwGb2uVCp+SVxuBY9+XTrYC5axsN8N1ITSaFrjffj/2AHApiEb9E1m5041bOjWZQBw==
X-Received: by 2002:adf:f84c:0:b0:309:45b0:e7f7 with SMTP id d12-20020adff84c000000b0030945b0e7f7mr2373279wrq.52.1685017789535;
        Thu, 25 May 2023 05:29:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003062b2c5255sm1700227wrm.40.2023.05.25.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:29:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/6] clk: qcom: Add lpass audio clock controller driver for SC8280XP
Date:   Thu, 25 May 2023 13:29:28 +0100
Message-Id: <20230525122930.17141-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the lpass audio clock controller found on SC8280XP based
devices. This would allow lpass peripheral loader drivers to control the
clocks and bring the subsystems out of reset.

Currently this patch only supports resets as the Q6DSP is in control of
LPASS IP which manages most of the clocks via Q6PRM service on GPR rpmsg
channel.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/lpasscc-sc8280xp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/lpasscc-sc8280xp.c b/drivers/clk/qcom/lpasscc-sc8280xp.c
index 547f15d41a9d..60cc3c98d03d 100644
--- a/drivers/clk/qcom/lpasscc-sc8280xp.c
+++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
@@ -14,6 +14,26 @@
 #include "common.h"
 #include "reset.h"
 
+static const struct qcom_reset_map lpass_audiocc_sc8280xp_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
+	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
+	[LPASS_AUDIO_SWR_WSA2_CGCR] =  { 0xd8, 1 },
+};
+
+static struct regmap_config lpass_audiocc_sc8280xp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "lpass-audio-csr",
+	.max_register = 0x1000,
+};
+
+static const struct qcom_cc_desc lpass_audiocc_reset_sc8280xp_desc = {
+	.config = &lpass_audiocc_sc8280xp_regmap_config,
+	.resets = lpass_audiocc_sc8280xp_resets,
+	.num_resets = ARRAY_SIZE(lpass_audiocc_sc8280xp_resets),
+};
+
 static const struct qcom_reset_map lpasscc_sc8280xp_resets[] = {
 	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
 };
@@ -34,6 +54,9 @@ static const struct qcom_cc_desc lpasscc_reset_sc8280xp_desc = {
 
 static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
 	{
+		.compatible = "qcom,sc8280xp-lpassaudiocc",
+		.data = &lpass_audiocc_reset_sc8280xp_desc,
+	}, {
 		.compatible = "qcom,sc8280xp-lpasscc",
 		.data = &lpasscc_reset_sc8280xp_desc,
 	},
-- 
2.21.0

