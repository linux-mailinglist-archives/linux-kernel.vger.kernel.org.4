Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CE6B140E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCHVgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCHVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:35:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5AED1AC6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:45 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r27so23092501lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov5RMn4u4UzKJ3B2Go2X9BkWY6GJei++Q812Yrin8NQ=;
        b=AxhmL4HahGAmk4iXonM1WZnW6wfLggY8ACu1c7y/UUUX50xPNa6ZMfCFXIdx9ySf9B
         Kp4CHTl5eVmBoqaiegAqMDHPGeA2jm281La5XN8hGZVQvfGFZPsXi/2R8Wx4Xqg8pSTL
         7x2cD7elmtx62OdCkJA1uYcgy3YzpiMjMbAoD7eT5EpYnM5eBkIHm0gzGtFmbICOGZwc
         /pAJESYHr5wN7jd9vh8sNHflicgIO3Nt+KatIewTqS178ZSiBiquaBGAIsgUtUlZlLFf
         q4blRWTFq9zvFxeNLz39okmM+Fa7hlQK3WL5qijMd7pjfdcoe6xh2RrcbbRP+7fMpq2S
         SUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ov5RMn4u4UzKJ3B2Go2X9BkWY6GJei++Q812Yrin8NQ=;
        b=01ZjTlXM+f3Q0w3eBbjIBPQCj+0VjU0lwEsKdEv4lcVppX4dCFDDvLmRfKO5GrBGOD
         3Z842IE6C2f4mcpCeHiBqjyMi5rw1C/ppfvDwIoqI4dQ2AZ9Oyro6/fLfm4/wdw1TQRd
         ygjz1gJ4UwBOqdz+GryrImqdRjotEswrggNktY260C+EsdYXmiRP+zFUYOmgdz1yrKQf
         6Eb4IsM+u3sbVVUNa17MIZgRjx6uUE3X6egYqznXEnbcILVfVJydVacoR5BK++GS+mR9
         Z4GkQM5m21drLbCC/T3t+Ur83OsCRi21cyuc/3NsSHrJ36gJ4qzzc04rDyOLLXGa40dX
         oLmA==
X-Gm-Message-State: AO0yUKVUbTpkUEvpFzHKlkoWoZHN6EAmNNDjAKmlnOInBGGRICzZ5cCg
        j5wnOSA6dkU4KFudedR+WtDl1A==
X-Google-Smtp-Source: AK7set9dma1j6Hpgq09B0UyfOJ4VTgSFw6jduwHFeZviyO9dnKsNOae9xfK14OlgNweaqopTCKXu7g==
X-Received: by 2002:a05:6512:38c6:b0:4db:387f:a3af with SMTP id p6-20020a05651238c600b004db387fa3afmr4619602lft.4.1678311343950;
        Wed, 08 Mar 2023 13:35:43 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:21 +0100
Subject: [PATCH RFT v2 05/14] clk: qcom: smd-rpm: Make
 DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-5-ae80a325fe94@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=1812;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=svZJYxWNeuanDoOsLpbm2ZL4k08Cxtikg953kjcomQI=;
 b=sWofPdTB+S2gmrrLLUFIgZQAJ2Dpw8GiAIqWBFrlUA0dFPLwJP/f1iFMOzWa5eP3iGN9mRFIVl6i
 PnKA34jlACMIaRLdI7hJ6pz6gH95zN0ugXHXujjpvItq48fx3w8B
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

In preparation for supporting keepalive clocks which can never be shut off
(as the platform would fall apart otherwise), make the
DEFINE_CLK_SMD_RPM_BRANCH_A macro accept clock flags for the active-only
clock.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 72b1f010509b..fec6ae4a8989 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -129,10 +129,10 @@
 		_name##_clk, _name##_a_clk,				      \
 		type, r_id, r, QCOM_RPM_SMD_KEY_ENABLE, 0)
 
-#define DEFINE_CLK_SMD_RPM_BRANCH_A(_name, type, r_id, r)		      \
+#define DEFINE_CLK_SMD_RPM_BRANCH_A(_name, type, r_id, r, ao_flags)	      \
 		__DEFINE_CLK_SMD_RPM_BRANCH_PREFIX(branch_,		      \
 		_name, _name##_a, type,					      \
-		r_id, r, QCOM_RPM_SMD_KEY_ENABLE, 0)
+		r_id, r, QCOM_RPM_SMD_KEY_ENABLE, ao_flags)
 
 #define DEFINE_CLK_SMD_RPM_QDSS(_name, type, r_id)			      \
 		__DEFINE_CLK_SMD_RPM(_name##_clk, _name##_a_clk,	      \
@@ -450,10 +450,10 @@ static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.is_prepared	= clk_smd_rpm_is_enabled,
 };
 
-DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000);
+DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000, 0);
 DEFINE_CLK_SMD_RPM_BRANCH(qdss, QCOM_SMD_RPM_MISC_CLK, 1, 19200000);
 DEFINE_CLK_SMD_RPM_QDSS(qdss, QCOM_SMD_RPM_MISC_CLK, 1);
-DEFINE_CLK_SMD_RPM_BRANCH_A(bimc_freq_log, QCOM_SMD_RPM_MISC_CLK, 4, 1);
+DEFINE_CLK_SMD_RPM_BRANCH_A(bimc_freq_log, QCOM_SMD_RPM_MISC_CLK, 4, 1, 0);
 
 DEFINE_CLK_SMD_RPM_BRANCH(mss_cfg_ahb, QCOM_SMD_RPM_MCFG_CLK, 0, 19200000);
 

-- 
2.39.2

