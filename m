Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF0372E538
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbjFMOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbjFMOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:04:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9B19A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b344476595so354731fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686665018; x=1689257018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nc1+n/UQ2y64CZL44OODa51PjPBdbRWsiaTLI2r2o0=;
        b=SkLsg4jLtJh4muzvpK/1L1+mHr3dY1P6bVFg4FnP7PUMqQpj9R7ZDsNrDKS8fC1w3J
         vu5QzylNAQ3z8cgaaa6rELvgzY4oIl9nZV5ZHec8d9uYLSvA785YUolx/rRhKFYy7b1J
         iup6VTekHXjbU5adVpZ+EPJxngAu3D2LWHvMIBiw1jMpD4QBKvJ5cMAkxhijHXX21x8D
         rg5+JhKjh8JqUOe5zmVm2WESmyuMBkOJRJ/dx3VMsdcvCbv8LNNhakJAvM4mxRCvDo8p
         +zq5YdfN2t8F1lPnVHbiWa9eTkgkf0/ml/7uKrjGVMeBffpf32WkZ2kfd5gdFq8Ag7a6
         ZS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686665018; x=1689257018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nc1+n/UQ2y64CZL44OODa51PjPBdbRWsiaTLI2r2o0=;
        b=CA6rqM5x2j//HIV0Ujt6tk5DlQSmZ/e+YRi5gsmjVOmYBWdtXYAHmIvmNNb52aXLTa
         vaiddrnPxSrJFLOlFitmrBIW97CaOAx9ZKyFeZfvXhfdmA8SVHm0FmAXHrWdk7t5UyxP
         UOIH8woaODdWxsyF/qxJy9pNTDrAhJ3LMAK2OgwmKyCa1ychM34uLIgRjm4Gqk7aP1uI
         qrLmZVYxyXDO0tkWp0lMkYBi7vUBux5edVQzgqf1NL16qvE+0Plozunch795dU+/68b5
         VmKffV1koweZPJLbZiWQd1Q5x5+oYtvwAEzivsjMV7b+ADDMlugeNFf/zOvLoiBD2kSb
         GbLw==
X-Gm-Message-State: AC+VfDyd4anK/HdVBCc39iQXyZosThM149Pq4k9IXKqomYWWoChOqddX
        ZspAVtSDaEZpeKecbvKREkX2+A==
X-Google-Smtp-Source: ACHHUZ635pJyiFxxxLT0B27GFEGsN2CroaFOriZSk+cKoL5Iby3c/CuNmjokyy5yKYRRf3RXXo8amw==
X-Received: by 2002:a2e:8005:0:b0:2a7:b986:3481 with SMTP id j5-20020a2e8005000000b002a7b9863481mr4545031ljg.41.1686665018200;
        Tue, 13 Jun 2023 07:03:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 16:03:15 +0200
Subject: [PATCH v4 15/22] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v4-15-5ba82b6fbba2@linaro.org>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=1438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=U/V7/Y31OoJlewUp8cNNSi57yg1wtDegefv7cGiM7Cw=;
 b=VkfwRBcb6pnN2BVscdR6bPccYFGp2Al2Vv/rNKh0iMXxi/6/aTTmI9E0Nvm/C/MR4Q0oEgqVj
 KyqAGVUTXR8Cjk5rVlWVxj9EyFUo1sH9tmyhftbg8yXhqlQ42s6Ybt7
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
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 196b05879896..be2a190a8b52 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1231,6 +1231,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8916_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1259,6 +1260,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1328,6 +1330,7 @@ static const struct qcom_icc_desc msm8916_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8916_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.41.0

