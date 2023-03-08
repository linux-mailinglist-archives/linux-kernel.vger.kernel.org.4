Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED06B1414
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCHVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCHVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:35:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD38B856A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s20so23096163lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwZMH96UXfkc0AccFCgdHWqtpm71+Gjc4i/Nm8NSEJg=;
        b=hXBEuXzGMdj72xSPbg/KZ0ZJ0aETajx9yHPyiwgOFt0X1hTP8zQd5MS0i2U5vFEwfH
         pPPAGpWf1GoL2gATieKsJ/f6RnWuWoSB05oiMl2XdIjnLSw6NFqKdb/tFR83zRtjPZry
         ayu0Y7ftEnndA1gN+kBzO+r9ThFsGWL2XiC7ylY3GhYup3b1CPA3SQTZujAX2+mwZzoJ
         vHhxLYUqJ+5kfO2DLCFPXLATsD+E1ZWoIETRgQ4w29wc4j8U9VkgshFBgs6nXYKiE/+1
         z++PKMsRMGHzzrYxFm0ZsYGBw1wElZt3rdh7FG7mb+zk7LYiOhFskqmSkbKpdzShS5gO
         Hs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwZMH96UXfkc0AccFCgdHWqtpm71+Gjc4i/Nm8NSEJg=;
        b=zHH98M3U4Zf6ABdu5IexJeJVRF9ynp88nk7cmwSdygLvYwgEyBQqNSIyt0UOZGwnd5
         dBCC6GknBl0hge/seCvn8r7kzqIdB+Bc0odOe0lyy7Ux3JDH8s0XaazKdXD2fCsK4VfY
         Ty5zWdEsX96ado4cWqNUghWoTDO4v1a1oFS/VkX1IlpZowmMa3Yg9IWBqpUAN/OgEz3t
         /GjcOpLI30dd1T4y+MM8mA3RE9guRuSeyXF1wjhc5/tpyFpsnGGMqjGU6UgAHldDvBB/
         RXXloMLNpTIXyC/NhDBXYs1qZFIj9nlL0gJmlB2/ruko8VW8dHUk0jKvyGx9lcCWkNMG
         UqLQ==
X-Gm-Message-State: AO0yUKXONstKuBNeU9RmVX09LrUMOocSBPdriY5A1c+VrGyvJS5bR5O9
        R4/sdxEd6jlw3BcMSBPI94Gu1g==
X-Google-Smtp-Source: AK7set8FAqtCPNeuGOFm27ULXeGksmc+9BuHiRhwbhDwx2j5p8KAmARp3lWBZD4m8ceHjrAfxOSShg==
X-Received: by 2002:a19:f00f:0:b0:4c0:91d0:e7ab with SMTP id p15-20020a19f00f000000b004c091d0e7abmr4595915lfc.28.1678311345559;
        Wed, 08 Mar 2023 13:35:45 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 22:35:22 +0100
Subject: [PATCH RFT v2 06/14] clk: qcom: smd-rpm: Make BI_TCXO_AO critical
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-rpmcc_sleep-v2-6-ae80a325fe94@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=1209;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TISC+Oc8V9fBm+Q+IBeIefGIjS6ebEWVyUTx7mIEAsw=;
 b=R+M8Tbyxgn5h+HC/KiEpepKUFCu2bNNp8TswNI/3zNht3TSAvrONTg5dU73dvGjmFn/8guhHpguL
 RBE7PiI7AhPCKKU6oJK30w2Zvsq0AjO1z03dGN3IB4jXAx9VGi8i
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

We should never let go of the active-only XO vote, as otherwise the
RPM may decide that there are no online users and it can be shut down,
resulting in a total, uncontrolled system collapse.

Guarantee this through adding the CLK_IS_CRITICAL flag.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index fec6ae4a8989..9dc779360ada 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -450,7 +450,8 @@ static const struct clk_ops clk_smd_rpm_branch_ops = {
 	.is_prepared	= clk_smd_rpm_is_enabled,
 };
 
-DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000, 0);
+/* Disabling BI_TCXO_AO could gate the root clock source of the entire system. */
+DEFINE_CLK_SMD_RPM_BRANCH_A(bi_tcxo, QCOM_SMD_RPM_MISC_CLK, 0, 19200000, CLK_IS_CRITICAL);
 DEFINE_CLK_SMD_RPM_BRANCH(qdss, QCOM_SMD_RPM_MISC_CLK, 1, 19200000);
 DEFINE_CLK_SMD_RPM_QDSS(qdss, QCOM_SMD_RPM_MISC_CLK, 1);
 DEFINE_CLK_SMD_RPM_BRANCH_A(bimc_freq_log, QCOM_SMD_RPM_MISC_CLK, 4, 1, 0);

-- 
2.39.2

