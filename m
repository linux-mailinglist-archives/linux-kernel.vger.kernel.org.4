Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66C715FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjE3Mcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjE3McO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:32:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835DE61
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso5037695e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449856; x=1688041856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyYkzqdDCC9q3w7GHxMV/UafzmkX5Zjo7MaFjCP76O0=;
        b=ODHH2/xiyrQVGlpxEkAyEQnT7M9/CCiIvDY7IH8HlfObOxLHSzOrz7rMm9tBJa+aHK
         osZbEmrwGlnpFnyonLf4jMuRA/D/CZ5M/asyNGSHtKLFqyBrrMuhcBrs8G6Jz7gx6KvA
         AoFJ7TBnr7IPH35Xu9xNOlvsXH6vEmAF+1A0PGZBi73HS7CbhQ+9VQGqE9V1J7b3rv5j
         dVwBI1U3261i2jOJGnh53jPbGUEn/wO+5tQWdxIxUu2a8d52+uFAiPNjIwe42HZINnaa
         lPmTdqiUFRAAja98C90flRDXM8CnKnlGMGVW69bIRWdazZKW33UFwywHaWYj4idoPYMJ
         Kgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449856; x=1688041856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyYkzqdDCC9q3w7GHxMV/UafzmkX5Zjo7MaFjCP76O0=;
        b=by+Ud1srzTCljRHYAqCg2MpAHR5kv+s7iqZMqxRQYQTLZUlPgAniNXmRsU1ob8u0o+
         QGbBRn2pRMNkA/ElXGpCNl0u7uTFc5rOvn61PIaHMjHHedny9JwPppByD76ayyOHBdaV
         cFx+WL3HbpNdq3E533zYFFT5AqTZBSye5JXFSa7Q2dugxbRQGvW+vZ1kamijqERttfEv
         JfDgalSapoBigznGZz8NYTJUga7Q2hwg9en8QuKfvolXwBlh4GU+tL4VHovmfJEmvRen
         gaFeOvbkXiu+cOzDs/Ybw4I9NHITZXTE94vjOP3Thzp/p9MvfVe+NcnLzC2IDLhQ1G4S
         rS4w==
X-Gm-Message-State: AC+VfDwdNgB1oDNBDt6PI9GJEo+BanF/aFvuUphS/PCdoazL+utmnBg6
        bvc8kOl6alUx7kKgQkmkfjL+1A==
X-Google-Smtp-Source: ACHHUZ6EpWTY1acHGhOrV2DgzEt0DXB9F9/5GHnBsOlHHyCCThuALiUOGAonQJi6WtF33x0jIFXlfQ==
X-Received: by 2002:a2e:8792:0:b0:2ad:87b3:7d62 with SMTP id n18-20020a2e8792000000b002ad87b37d62mr623302lji.46.1685449856399;
        Tue, 30 May 2023 05:30:56 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 14:30:46 +0200
Subject: [PATCH v4 12/17] media: venus: firmware: Sanitize per-VPU-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-venus-v4-12-feebb2f6e9b8@linaro.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=1814;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6YgBcnk5wJmY0h2UMmOrskDVPO7haGfbf8N3hZu0IXY=;
 b=nl3wP2X7tsd1Tm4R4+AGHUVOu2PspKZpQYRq5zaAqrZB1Dyr/OGl0Ou1UGxDWP/yzbWOGvsZK
 VpC3CTm6zapDgzGxt1BQzPtHT6RhUj1pET2XntH+Dqv6b2r17VWyJQs
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

Replace the general IS_V6 checks with more specific VPU version checks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 572b649c56f3..ef07eea38d93 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -29,7 +29,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	u32 fw_size = core->fw.mapped_mem_size;
 	void __iomem *wrapper_base;
 
-	if (IS_V6(core))
+	if (IS_IRIS2_1(core))
 		wrapper_base = core->wrapper_tz_base;
 	else
 		wrapper_base = core->wrapper_base;
@@ -41,7 +41,7 @@ static void venus_reset_cpu(struct venus_core *core)
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
 	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
 
-	if (IS_V6(core)) {
+	if (IS_IRIS2_1(core)) {
 		/* Bring XTSS out of reset */
 		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
 	} else {
@@ -67,7 +67,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	if (resume) {
 		venus_reset_cpu(core);
 	} else {
-		if (IS_V6(core))
+		if (IS_IRIS2_1(core))
 			writel(WRAPPER_XTSS_SW_RESET_BIT,
 			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		else
@@ -179,7 +179,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
 	void __iomem *wrapper_base = core->wrapper_base;
 	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
 
-	if (IS_V6(core)) {
+	if (IS_IRIS2_1(core)) {
 		/* Assert the reset to XTSS */
 		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
 		reg |= WRAPPER_XTSS_SW_RESET_BIT;

-- 
2.40.1

