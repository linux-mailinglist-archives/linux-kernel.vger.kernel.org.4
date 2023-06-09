Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2883B72A481
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjFIUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjFIUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580394216
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so2750318e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341974; x=1688933974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL7LimSkUpmanSTy0wtlUZtM4pffD5CjvvFdcF8Ze7o=;
        b=iipCaKbJH2wOrgHLIVyPR8llaR08XQVE2crxmS9sQstw0eCj1njBdvrN1dYEyY1iTB
         Fd+1UjvXBcMqZu8/zCujhue/IGZ05ax403Z+fj0NrpZ10BZL9O9y3auAOUfdhbwgM3Tn
         WA86EO6a8KwOE5nNV6FJBfq/VBQsMKyggC6xxzCBkdvCUoQSwEHj7Fw7WKip3sqn/zJ9
         LmgkFX8t9RH8a9aE9CFKBu3ShIWfotW0NvnSYgg6IlzsntJsnr+/VF+ZzFR2eBocG9+T
         6ghtJu8zMlxhGv9/eZ1ZPQeYuWNXQvB8SHWBpN+WR15XNAD9q+AH4Nq1Cr2/cx45y9rt
         UbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341974; x=1688933974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL7LimSkUpmanSTy0wtlUZtM4pffD5CjvvFdcF8Ze7o=;
        b=UtjqeqDWeCQ0jM/3ColcIO0omqBoooru+Y15VeAZrZKepfPyT1It+rfvN0lyIFsROn
         iS6b4hvkxlRUZ36rjNfh2qzTPVTtFol1XcwkxSLQAftVMSgltIXVL7xS6mX2I/5AtGC4
         iG8fFDjUP5tq+Oj8qKMN+PGDV2dsiLQvDES15askSe9dYbrmDPcB6xw7sykhIOP3CXIy
         40Ji1J9L7+eWTXYXHEptpwmzk57HCzs/5mOZd1gY8vsMPXWDK6ZWiTt7kh/1wQt+38lI
         /uTjlCC4KZsWjRKqTFaQWOYxSvK1YBrUXK4tYR6lLsrn6SdxA7ckY3ep97a0qytCquLg
         RuwA==
X-Gm-Message-State: AC+VfDzHLPHCDWMZskoyMT2RCQRP0LVKWb+1M79TwIXRQg61xQcrBtHo
        egqha3zhzimuzunMziaTD9aNpg==
X-Google-Smtp-Source: ACHHUZ5NrY8HHg7Qc0dNMwxz5LCD9h5M63yhb9lPsfyXahSOzWiIVCEx/CetVavtaygEmKP6vTt26A==
X-Received: by 2002:a19:e019:0:b0:4f3:ac64:84d9 with SMTP id x25-20020a19e019000000b004f3ac6484d9mr1754478lfg.20.1686341974540;
        Fri, 09 Jun 2023 13:19:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 09 Jun 2023 22:19:20 +0200
Subject: [PATCH v2 15/22] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v2-15-e5934b07d813@linaro.org>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=1386;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xhlOJEBugQss2pTP3O6oyCRi/KrlETAc0nKSQL7JH4I=;
 b=qbtAUIVOZARp02bUCslV8/25C9+BkepF6LM/2e0NztL8bWhPr26/hT7Ovl7Hh9j5aA7VVbfN6
 sYuvR1AOLo5BuxK25YFdrQlkj5YFcoG8+Ae1ne1niJuH76PzakeXYWp
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

