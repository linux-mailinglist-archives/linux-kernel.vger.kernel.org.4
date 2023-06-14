Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B9730706
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbjFNSGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbjFNSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F626B8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so8632690e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765898; x=1689357898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3iwd6rHqsg8HTsIHqkjHpgKU8rjtKazN66jALoshMs=;
        b=fOaETqmNSknr4iw3nOx579ELaw/iyBGPoamIHwC7mQuQYj+c7Ln+7h5TYT8Qj3vlvQ
         gdOBlkGdpLMJQKdSGBSGs7lRXQe01SxAgMk7QXxipBY5TBlgne3kyqZ4jsKcwsnPR+VF
         gOeTJSYOSEzx5rwhBe8T5SD2f1S0JFx6Vo6qMMNIy5ctyzm3y3AeCnH70cUexUcP7p6y
         dXSbP4yTEt9hCIstLnV9boARGrbQ7XCkV8ZMy3mIVYZmC7vpibH+BydsR4XiWJRdZ4sZ
         KCCujrkgm1jZwVaACJE6//4Otiiuhl3/u01qqx6KveQVmBUJQwJrPTFaoLteMvZknUFU
         WSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765898; x=1689357898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3iwd6rHqsg8HTsIHqkjHpgKU8rjtKazN66jALoshMs=;
        b=RMh607ZYm+scWXRnDjJrnjK0kaEarnWsDkrctgaau7NXaSf4/wAewZxeznza1B1SjZ
         Azu8FjDMKOS1n9wV9lWw0gMJO+PWZ9peOibChJosSnpN3q+44DlNcI90jO61uSzsTb9C
         KjGzkRkSjQLLa5O1JIU6K0yE/JTfM0EU+F7BxI4xg2T+hDHzx17uGU/J8KATzxXE0ytv
         xbhg6rDErLSFfYY5l42Gn/ZCjtCA9cPf5Qtj4dCpkFe/d73PtjW7hlzTROIVVC7VJm3g
         Jc2/YFFJETSK3jX0kjVzjGyyerHLKThGIKyg2U+lpUnZ5jt2ErszRI5+joKeabv4B4vm
         tLfQ==
X-Gm-Message-State: AC+VfDwwhDgH40LrCOWcmLnGg2p0aYeaP09bDMiEiyGl3rzwm3HxX+pR
        zHWSDvsCudpXj1I0e5OeB+DJx+xDdqqCLh2h55U=
X-Google-Smtp-Source: ACHHUZ4uSgnQ3VWqMFR8CLCkS311qnUzYC6MQ2efLCvipThNIl7spvvPZEYd40Pkh915fByY1ADWoA==
X-Received: by 2002:a19:6554:0:b0:4f1:3be7:e1d with SMTP id c20-20020a196554000000b004f13be70e1dmr7638434lfj.62.1686765898105;
        Wed, 14 Jun 2023 11:04:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:35 +0200
Subject: [PATCH v6 16/22] interconnect: qcom: qcm2290: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-16-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765873; l=2388;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y5vzxfTOafvaW8mPCP2rmWXwcfrcZgL9XrNa/4uLTOM=;
 b=c8St70MdxSL4ETnKqVrqwwneypoqlc2/65u/cJgwHt+IG4LQkzORMvmLaBkRk0jZwCVG+XT0/
 BRBb8UbqS8gAFSRIHCdklVuzS+x9oZX9EUDo/38umtszqxEEmd2xlk9
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 36a53add866d..8fc4acc4220b 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1195,6 +1195,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = qcm2290_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
@@ -1250,6 +1251,7 @@ static const struct qcom_icc_desc qcm2290_cnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = qcm2290_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_cnoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &qcm2290_cnoc_regmap_config,
 };
 
@@ -1291,6 +1293,7 @@ static const struct qcom_icc_desc qcm2290_snoc = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_snoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	/* Vendor DT node fab-sys_noc property 'qcom,base-offset' */
 	.qos_offset = 0x15000,
@@ -1305,6 +1308,7 @@ static const struct qcom_icc_desc qcm2290_qup_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_qup_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_qup_virt_nodes),
+	.bus_clk_desc = &qup_clk,
 };
 
 static struct qcom_icc_node * const qcm2290_mmnrt_virt_nodes[] = {
@@ -1318,6 +1322,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmnrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmnrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };
@@ -1332,6 +1337,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.type = QCOM_ICC_QNOC,
 	.nodes = qcm2290_mmrt_virt_nodes,
 	.num_nodes = ARRAY_SIZE(qcm2290_mmrt_virt_nodes),
+	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
 };

-- 
2.41.0

