Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAE7073D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjEQVPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEQVO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB8A5F8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af16426065so1121981fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358084; x=1686950084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tD8sADHcRsSq9QkDCRoE5JuqMpJE24bgCDvH91fnaag=;
        b=fWK4a3TxhnR4+vQWwKc78ULZk+l86K9r2wgGO6X4lcc9RvVrbaXbO5dXP3zbbpB2yk
         zrP5bqY/OoAwP6hAl59TRupUlWJ5wuP3TjNCzNT6HOTig4g1u9ZvaA3DPmGzFb8Lp6pD
         Pkfgc1GXRcuCxuI0+F2/R+vYZlgEoPZ13y5MCQF29S6KEyS/7pMjUKzKrFl57tDJ6X/1
         zuxWu3dAxbRhKVQ84UXTV+kDGau6C0PTgoXI7oBr4I9d9d5GSIWf5hMUE3T82ERohHS3
         +qhxvIWW/5iCPliEYUSZbQ9Pmw8FZLGZnyVA30knI/Sbub8b/89E/ivqE2s2R8fWkfdw
         qkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358084; x=1686950084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD8sADHcRsSq9QkDCRoE5JuqMpJE24bgCDvH91fnaag=;
        b=dgg653KuJKbdqXvNmVXUWa+p0CQNWKgH0TmnC+iWSBIslYrlqGOSnYKQ0n7jodqr+5
         D8Wi52vbELUX+mhlLZ7ST+iP9nb2YnQUoaaKbBh9qY8k3ItiEeaWTTsrbVBBocs2ujOa
         uTw6THyGt3UbtrVwJRBDegDKWAfTm+G5nReAXtWD2rBVUsjaxUXVBLYkL8/v77IilAi7
         3M1Wxd9Ob+BArhJgB9MqLCK2n5OPJzl3P6/BCbf5Xa/nzm8Aq1JUZ3KI7oxbcdZZjMoR
         k7m7xCvIpN/iEm4eczFo7XuT0W5ECRaJoWz0sCinS/yydw3SaOXixb9JUZVRI3/2Sqyz
         qAAQ==
X-Gm-Message-State: AC+VfDzjiOMBqEeAaAvTVxlRQpDzTnuiG7g5FUnIu+U8DR0Tw5WvIkB6
        3tGqoKhiYq3M0UI7cns7sh/39Q==
X-Google-Smtp-Source: ACHHUZ6Naxvu6Tu1jSreFZzq+4Iz+YoCyM5FeYh/8C4RBaOpE3flhosbS+/uIFvU2nHNrRodddS1Lg==
X-Received: by 2002:a2e:81ce:0:b0:2ac:829f:487e with SMTP id s14-20020a2e81ce000000b002ac829f487emr10903563ljg.21.1684358084503;
        Wed, 17 May 2023 14:14:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 23:14:25 +0200
Subject: [PATCH v3 12/17] media: venus: firmware: Correct IS_V6() checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v3-12-6092ae43b58f@linaro.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
In-Reply-To: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=2239;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hZ+hgztR9wHWbz6QthMQ1eS50eS1f+OVy6D5ufbrrY8=;
 b=+RHQ9L/G1CxdtabVF8ID0djAkMzXA+4Uw4nLISy3nZw7hJ1zjcr/tvzoO2cg/oqgCnbcq0bV+
 PG8dhBwIRkMDRCcw28F2yE07u7O0KnqbnLcY8Y8RuzxkGr4o22PgAja
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

Most of these checks should have checked for TZ presence (or well,
absence), as we shouldn't really be doing things that the black box
does for us on non-CrOS platforms.

The IS_V6() check in venus_shutdown_no_tz() should have checked
whether the core version is IRIS2_1 (so, SC7280). Correct that.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 572b649c56f3..ceb917f2e0d4 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -29,7 +29,11 @@ static void venus_reset_cpu(struct venus_core *core)
 	u32 fw_size = core->fw.mapped_mem_size;
 	void __iomem *wrapper_base;
 
-	if (IS_V6(core))
+	/*
+	 * When there's no Qualcomm TZ (like on Chromebooks), the OS is
+	 * responsible for bringing up the hardware instead.
+	 */
+	if (!core->use_tz)
 		wrapper_base = core->wrapper_tz_base;
 	else
 		wrapper_base = core->wrapper_base;
@@ -41,7 +45,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
-	if (IS_V6(core)) {
+	if (!core->use_tz) {
 		/* Bring XTSS out of reset */
 		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
@@ -67,7 +71,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume) {
 		venus_reset_cpu(core);
 	} else {
-		if (IS_V6(core))
+		if (!core->use_tz)
 			writel(WRAPPER_XTSS_SW_RESET_BIT,
 			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		else
@@ -179,7 +183,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	void __iomem *wrapper_base = core->wrapper_base;
 	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
 
-	if (IS_V6(core)) {
+	if (IS_IRIS2_1(core)) {
 		/* Assert the reset to XTSS */
 		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;

-- 
2.40.1

