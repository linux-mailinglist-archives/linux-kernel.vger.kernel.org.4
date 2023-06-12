Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE372CE17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjFLS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjFLSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:25:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD722E77
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso1115921e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594297; x=1689186297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=KrxKoZAteRQDDN5hHVT10/mvSJUs3GSrKyx9wHMwt4dGs7Ui1g0JYCvH/AvlxeJdM7
         8V/eSMvAZh2aSep1ShcofRbjU+7mGzRhNRZ3YUxMYlsGe7EBiukq5F7P/ed1NS1nFTtY
         mP4l/9Kbc2YK66VTjWhbqirbsoe+Z0uMWjaunbEfD7nFlEVnFJorXOKZ4BZHhD/o/33G
         OBx4VXQY0ide1PAXexByFEv8RNdkVs9QSIe3MoHEHWZxhK5RVl7ForR/IdwlCHA2bZNH
         GVlHfTZWzK1I7UAO7G47vuNkn/4RLJ44iN4JoSxWtfVcV/9ypc7yR+nRkB89UNFcZwwR
         e5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594297; x=1689186297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxwAlvsxTG2NJKirdi7L920nJWliszLcfh8qb5HaEiU=;
        b=HFQdzu2ObeSVYWOF/pMsHjN/RT7wke40ygANyzBIDuGCJOTaA6fl4YZcxSPQjk8qPA
         dnN56qKqLHvlriUY5fvVndDyt4vFzze0Jiu6aWMwA+jDIfrGCU9gxIskmwuRuLciR6qD
         2+G+zQHmVQ8yeoJsrt2NiHJDvWz9mJ7bGROAG+NZ/H/Kjyexya4aKQJgjLxvgmjQ1Okz
         EdpBhfN7LtrIBgxvDrk/bJK6yG2vib+muF4NzGrcFXGX9uSmOgFgLfXVDrRMbbcLm3/r
         eaKbfjg1q42hVCxBuJTFiZ2zXvaHSvPU6eyFTi7Bc/exCRcuywhZl2RlJHrv59brUXeW
         hUOQ==
X-Gm-Message-State: AC+VfDzQbLUd1kN//4K8+pYuEZM04keL7CQk/GR/e4rZCmaYmjdse+Mv
        dSCgbA0pPs4NYoICXzjv6HTmrtHobpqNNq9Ohu0=
X-Google-Smtp-Source: ACHHUZ6Fre2H7uk+cngqm56F9E8xnzgp77wCVevAsYlSJzkkkoEn2t6P4PgjJc+hqE9J/1xdYC3k1A==
X-Received: by 2002:a19:f205:0:b0:4dd:ce0b:7692 with SMTP id q5-20020a19f205000000b004ddce0b7692mr4500967lfh.46.1686594297148;
        Mon, 12 Jun 2023 11:24:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:31 +0200
Subject: [PATCH v3 14/23] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-14-5fb7d39b874f@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=1291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NibH4RmX92w9jFbYbYmeVzyLtbX9fV3dfXE9S9JnGAI=;
 b=vYHOmrHPf2khIR+4l0Ku4Kx0v4SMVzTQA+pWwvGePhMzB914Y/Y915j+Ii7EJoq664w3zSQNm
 MlSw8cNNRLXDgr3saJcF5EuuvFEWnr3IsKGW+wWyoc8Q1xlYuOly/6h
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/qcs404.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 938283ddd0e3..9deb4d81104e 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -984,6 +984,7 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_bimc = {
+	.bus_clk_desc = &bimc_clk,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1038,6 +1039,7 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_pcnoc = {
+	.bus_clk_desc = &bus_0_clk,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1066,6 +1068,7 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_snoc = {
+	.bus_clk_desc = &bus_1_clk,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };

-- 
2.41.0

