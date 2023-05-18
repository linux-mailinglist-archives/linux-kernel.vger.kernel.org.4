Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE52707FED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjERLlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjERLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:40:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEA211D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307a8386946so1279835f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409997; x=1687001997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+NnmS4Y3N2+zWv4AXvVWEIhI6GRLW/Tqx1d8cSKZH0=;
        b=WgmcYd3c2c6AmlCrESXGoTOnB4d/DjLyAxklZQY3IlX6lsIPNn9B8cYkfuSa/SKIj4
         zLrhmGGzX/x++nUUWvv8gFHW1cLmJikKbJffcn/hSMa5GOJ5YXOW78CjVVWl+OKOHFSe
         Ko2sUmtsolRJIiLptuFsMxn/87vmOMYtIVo9VudQMJTAllWLLsHV9/8MDqhMxaFTzWKV
         dYVQvogf0/W7aDP38KKsH3dZH66xxx1hcO+FEuWQB6faRP0YnydpqGmcS/RJoY6Cb4sZ
         bJXLs8IcZBbliLdNkTxfDmGrd1A0HOihgl/GskeUcmecsE1hDzsBfgHrs4eQSqMQ30Tm
         Royg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409997; x=1687001997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+NnmS4Y3N2+zWv4AXvVWEIhI6GRLW/Tqx1d8cSKZH0=;
        b=gYCkvWjKe2SLfD6LLZIACaVC3Kq/zsb2P6atOZwil7210uANs0YmKpAKIgxJbs0jrZ
         CAER6BISYThgqfE9RcnOtnptxX7wK5RxvyiBdl+gCmui8Ta9nT4uKAfiTjq8eWT/oMaA
         ucthkvRoVxK9BLw5Hb4tf2rpee9D6AXxg/wkR+D9zNuj2M1wF0TbFkVqG2EgwEoibrdc
         Yee7/qomVCTfrEZi21k+djDQca6HOJK+pLyDKg7i5E8ZNpXqi2NqhNXdu2dowH5tTfRH
         ALX2fm1Yud2UgD8DyKxvabNvUxDE4sExiCVH3aHeRZCnLE9PcBhS97bh0gamdw2ZmY/+
         R+vg==
X-Gm-Message-State: AC+VfDzNBPpwghU18oGQXrVBYMiwNhjELfSRa5V8EZZ9YqUH25trdvbI
        1V5xXjN3IDN5ArQsdVIloNQo3Q==
X-Google-Smtp-Source: ACHHUZ4xc23L4sP/TfxuHDTrwImaj5xkH98OAx2YSlJWBzyYAHAXNTvdKHWzQ+9tUgRkhCphmGYYHw==
X-Received: by 2002:a5d:6d50:0:b0:309:475c:c90e with SMTP id k16-20020a5d6d50000000b00309475cc90emr1637260wri.37.1684409996910;
        Thu, 18 May 2023 04:39:56 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b003047d5b8817sm1897135wrv.80.2023.05.18.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:39:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] clk: qcom: Add lpass audio clock controller driver for SC8280XP
Date:   Thu, 18 May 2023 12:37:59 +0100
Message-Id: <20230518113800.339158-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 118320f8ee40..e221ae2d40ae 100644
--- a/drivers/clk/qcom/lpasscc-sc8280xp.c
+++ b/drivers/clk/qcom/lpasscc-sc8280xp.c
@@ -13,6 +13,26 @@
 #include "common.h"
 #include "reset.h"
 
+static const struct qcom_reset_map lpass_audio_csr_sc8280xp_resets[] = {
+	[LPASS_AUDIO_SWR_RX_CGCR] =  { 0xa0, 1 },
+	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
+	[LPASS_AUDIO_SWR_WSA2_CGCR] =  { 0xd8, 1 },
+};
+
+static struct regmap_config lpass_audio_csr_sc8280xp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.name = "lpass-audio-csr",
+	.max_register = 0x1000,
+};
+
+static const struct qcom_cc_desc lpass_audio_csr_reset_sc8280xp_desc = {
+	.config = &lpass_audio_csr_sc8280xp_regmap_config,
+	.resets = lpass_audio_csr_sc8280xp_resets,
+	.num_resets = ARRAY_SIZE(lpass_audio_csr_sc8280xp_resets),
+};
+
 static const struct qcom_reset_map lpass_tcsr_sc8280xp_resets[] = {
 	[LPASS_AUDIO_SWR_TX_CGCR] = { 0xc010, 1 },
 };
@@ -33,6 +53,9 @@ static const struct qcom_cc_desc lpass_tcsr_reset_sc8280xp_desc = {
 
 static const struct of_device_id lpasscc_sc8280xp_match_table[] = {
 	{
+		.compatible = "qcom,sc8280xp-lpassaudiocc",
+		.data = &lpass_audio_csr_reset_sc8280xp_desc,
+	}, {
 		.compatible = "qcom,sc8280xp-lpasscc",
 		.data = &lpass_tcsr_reset_sc8280xp_desc,
 	},
-- 
2.25.1

