Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655B719737
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjFAJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjFAJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:39:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E8E7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:39:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so687140e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685612353; x=1688204353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc5Z7FdibsmGdwgiV/8KbQWxOT9Tiw8Cs0GSujQgOBc=;
        b=V6vNXKj3f3bcLUGmfjMz1T8gwhhuAfK6vlnFGaabrtwXigrsETkfdE+uPDOEY/GHU7
         uNN32i4fXCGshKm7FNAfx8hlkyLo2L2nMBUKLeEi2n9nV5uN3UO3LmHOZobhqadBar0x
         6QfZ515Z09n5cbOp2tl8z2NPPAxOTRhzxGGyQH978ElFZSVKxCaE6EADUXziPXN4Wo31
         Ddw3UqawQPgq5zBwUApGZPZvCegs9Dg8+UOzxm0zMnia2Jd6vDnbXKGAiNdxCnnnog12
         ENE3baNWaovtzbPLj4rMQPBCfwBSLbSOvXuL+EtyitzbjdDe30h29kd1FXxaSUXHIEBI
         MgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612353; x=1688204353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc5Z7FdibsmGdwgiV/8KbQWxOT9Tiw8Cs0GSujQgOBc=;
        b=LXHRZaJI3ipgeajaTEQQ+nV+wpF3hOF9UhxbNhV5plHvr2wcES9bU3l5xyuYwb7zHb
         4FkGEaGlc39cKpYkQ/oio7o5xPmwTnYTY13KfvrqTDARtJM/+w4+qSMcMC8M6qdyLdi6
         SZlwDZGnosJDdLoXsdJN5YDXTt7FwZsPA3lYXJKQdryGiU5LTReYXv99ZlXkTJkmdmCo
         9fdtEXTVaZsNA7Z5zYuQGBhoKZpHY1w8Ravxq9eUlqMS8l/QemmoAAgPzjsewzyhIDy4
         89z42gjWce9uYNozhhRQtxKhjjSyZiw8pGoREO9+pZtThjegN4BEspm+O7KNpZD6JGlr
         YwIw==
X-Gm-Message-State: AC+VfDwwJ3xsniuqQ/C5WjQRwoxyH5WMJ6JmrVEa0Lnmrk9LVo2XRNtY
        I3sNs6w4CXqerSzfwXYifo6GDuJuNQBdAQZBX2E=
X-Google-Smtp-Source: ACHHUZ7IFtTrJRawCjuqtPt6AMA2+XViWBjkBWsRc8UqEwdcLoyo8qk51EgzMkfXz9GQPXlSx0QP3Q==
X-Received: by 2002:ac2:4214:0:b0:4ec:8524:65a4 with SMTP id y20-20020ac24214000000b004ec852465a4mr801852lfh.55.1685612353425;
        Thu, 01 Jun 2023 02:39:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512048300b004f3b258feefsm1031119lfq.179.2023.06.01.02.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:39:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 01 Jun 2023 11:39:08 +0200
Subject: [PATCH 2/2] clk: qcom: gcc-sm6115: Add missing PLL config
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-alpha_ctl-v1-2-b6a932dfcf68@linaro.org>
References: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
In-Reply-To: <20230601-topic-alpha_ctl-v1-0-b6a932dfcf68@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Iskren Chernev <me@iskren.info>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685612350; l=1703;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SPvCmzGhftB/XAFnbpI3W945MryOao+OxYb3yPb5WLA=;
 b=uGXQdD8bVwAhRq4ZoZThpA9708kDy5PvmDdfw0OR+wSrx/VVrfjEvTo0oMvQnX2USKv7X49/s
 sqLe0MHvgTTCKwf2DsNlypPUHln9cUvl2/My+YBt5zNO26e3gpZc/UV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver was ported upstream, PLL ctl register values were omitted.
Add them to ensure the PLLs are fully configured like we expect them to.

Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver for SM6115")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 5f09aefa7fb9..033e308ff865 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -119,6 +119,8 @@ static const struct alpha_pll_config gpll10_config = {
 	.vco_mask = GENMASK(21, 20),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x4001055b,
+	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_mask = 0x1,
 };
 
 static struct clk_alpha_pll gpll10 = {
@@ -170,6 +172,8 @@ static const struct alpha_pll_config gpll11_config = {
 	.vco_val = 0x2 << 20,
 	.vco_mask = GENMASK(21, 20),
 	.config_ctl_val = 0x4001055b,
+	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_mask = 0x1,
 };
 
 static struct clk_alpha_pll gpll11 = {
@@ -362,6 +366,8 @@ static const struct alpha_pll_config gpll8_config = {
 	.post_div_val = 0x1 << 8,
 	.post_div_mask = GENMASK(11, 8),
 	.config_ctl_val = 0x4001055b,
+	.test_ctl_hi1_val = 0x1,
+	.test_ctl_hi_mask = 0x1,
 };
 
 static struct clk_alpha_pll gpll8 = {
@@ -413,6 +419,8 @@ static const struct alpha_pll_config gpll9_config = {
 	.post_div_mask = GENMASK(9, 8),
 	.main_output_mask = BIT(0),
 	.config_ctl_val = 0x00004289,
+	.test_ctl_mask = GENMASK(31, 0),
+	.test_ctl_val = 0x08000000,
 };
 
 static struct clk_alpha_pll gpll9 = {

-- 
2.40.1

