Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503707357D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFSNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFSNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0FE59
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so4314286e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179895; x=1689771895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyLlsxl16OWqS291jN4brexaOHkZM0ynHfqUIIXviBM=;
        b=gSqZcCyrF0W0oCYu5QyPWNYWPFfPdT42Il4ZiMSPPWQoXgenRoJnT/hdZFFlkjKznU
         KoBm+chQJyxX/8+NET62ofyUr9RTx6T9K6f0iZyN2QXepUX+l2jrpR88fO9ffWWQMgT4
         kTYLv788nXUTkOhF/QSfLsMGnuZpUFdaGAu8tx0n5GMEGL1xH5oiQ56eX5xiRJu6eaZf
         xMH5U5cU0QgiQkVHq0hF6NGa631U5+eA2yQl0zDAJeZEEQQzwUp/iiAFJu9WFJrC35J8
         9XcIFe1NR7Kcy6m5w0FOPKRT+0YvR60j2aVWalJ4QBWPoO2gov7tBRZCy7uCa2X+Fahu
         FL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179895; x=1689771895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyLlsxl16OWqS291jN4brexaOHkZM0ynHfqUIIXviBM=;
        b=I3aABQwRO5k6/1ioUkEoZm537Xlc77j5uKRyX+nj2ZQB86bMTzr7iX3S5DYc25n70A
         U7Gqo7mVQHg2M5u+6xjQfgngjLB6XgV3gf4qHPr/nVCiLkWoeGTK7QNMVmIiFI+k7GbL
         nPCmL5CretI3VS0heo+pAbxzZpoN/gkK3CXC+2t37mR/GJUWRiYYVjIsWJRTVnuNMblq
         OTXS6FGaghNg1cYNCBkuEo6p+GMGNn12bhjl3zlXatgr+DnuTn6MKIrnRuQuJemdVzQC
         KwWanNIV0rCH153FYHaECrOxK8hlUH8dGBFFldoVVGycgPFMiCXQ3pxBSX9K9gCvr8D7
         rrZQ==
X-Gm-Message-State: AC+VfDx8jJSJaiZzgKLcoUwSjtR1aT93hQD7D2qFfTN0cYBXUBKycTqN
        Ioe7s+LY80lh8g8idZkP4FPZEA==
X-Google-Smtp-Source: ACHHUZ75ifEjFXrFiZ5wa9y71r1VcDmPGT1oP6w1VJQNL2epEk5ULcL/ZW9ft6fuS8EYnLenrbHCnQ==
X-Received: by 2002:a19:e34a:0:b0:4f4:c973:c97d with SMTP id c10-20020a19e34a000000b004f4c973c97dmr4468328lfk.25.1687179895156;
        Mon, 19 Jun 2023 06:04:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:40 +0200
Subject: [PATCH v7 15/22] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-15-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=1438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1dxDULtatbAkSLWWf67/ek605+kPD/vruTIZt6NGovc=;
 b=iHL1KLuXW2z5vhKEtHclV/7a1+eknfyUmqgCVycmAtSNQ66hiUIt+fGXfwsgThZc0MlKZz3kG
 cy+Ehap3RUfD1OGxO074eFwo80Q4OyYSMBDxouvU1TdNSK4HseGwxwk
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 70b67fbe453f..b567a2b4199c 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1230,6 +1230,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8916_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1258,6 +1259,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1327,6 +1329,7 @@ static const struct qcom_icc_desc msm8916_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8916_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.41.0

