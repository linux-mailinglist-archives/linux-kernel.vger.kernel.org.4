Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816972CE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjFLS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbjFLSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:25:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C161E6B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so5471843e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594300; x=1689186300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nc1+n/UQ2y64CZL44OODa51PjPBdbRWsiaTLI2r2o0=;
        b=Kwril7gkjpeQmojfltoNDZDiXw13Zs+Vvqa4LrWMRMfKWSiK6s8tPWP1x76TvroBHu
         ytDxHlb1s9dRSeGviSNmgglcdcGysAneLyNQYeBhPi9nNynMGcMYzQUo/3mlorT0oI8h
         PZFyEq0JT9HgwwMf3ctPHFaE7j9KqJOWDJiot5gZf9HN3bmPMvb+xID+H9tYpiakp3hv
         sI6DsZuNE+gABtvjODs4wd4QerHlZOVUmsQwft+tlgIbrehm7y5dUZfcw1MElw0fYB7x
         xwKVZB/Vv0IVXy/7c622Yw5ZPyodLiA90WDIqqoOkaCcTMnHgWgAkqOhoG/yvf7C3+VR
         T8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594300; x=1689186300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nc1+n/UQ2y64CZL44OODa51PjPBdbRWsiaTLI2r2o0=;
        b=drjG3w2BTSOE+7409cefkT7+eoZurv05BOzzO36VCOKhTRffAlYOVHkfaoXgi+fraR
         Io5UxuKgJZ1lz4fs9jLWzF2JQkDOz5HLs762bG1FcvrbhPpyvdj24dwln75SdJPU4g00
         tFdIoZVVWIuEjE/A+Qbp93StA9fJgSBhCG62N8CQI0nUMTVm3Kvcsxs8ffltb5LmO2CF
         nhZkYyHWv+NgJP1QloNTKf8mL7XWIghLkw6ZgcZjVQgrZ94ufpX+kdXFREH3oCalpCnG
         5Nvb4CdqQ0ABG1SnT2Ww20AMPqFvkueCLa4QoPN/iXuW4k8thdT7zx4i7Uu3SvNuvWSQ
         L5BQ==
X-Gm-Message-State: AC+VfDzmG3z460Ay9G+QnkpeTGNlMc2OkbYd66LJF5kPLCt5NiBBsDqZ
        JhkT546125rOe+4FGv34m42w96KL0GLe7j3AHsY=
X-Google-Smtp-Source: ACHHUZ6xRUEXfvbB7ezbFacPU+QVuRsFuQKXdHaFoLB/y4VQb498OYc0o1UCGn0BvN5Zj5SSwicv9w==
X-Received: by 2002:a19:7915:0:b0:4f6:13f1:38a4 with SMTP id u21-20020a197915000000b004f613f138a4mr4174718lfc.41.1686594299917;
        Mon, 12 Jun 2023 11:24:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:33 +0200
Subject: [PATCH v3 16/23] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-16-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=1438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=U/V7/Y31OoJlewUp8cNNSi57yg1wtDegefv7cGiM7Cw=;
 b=nsKAwCSQtKK2LwzqCfgZoSGQsHxkpuRh+dW+5NcBXXbc6qg/N88MW7VSJDyd30DHLxfA9dCih
 iuDlO54o6SZC556r7rOX6undfSxnzdB8l2Zh8G9KWnA+DEps5Ey5GMj
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

