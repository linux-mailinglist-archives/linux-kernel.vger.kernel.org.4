Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37F730704
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbjFNSGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbjFNSFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:05:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B732689
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso992930e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765893; x=1689357893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhmMqJgELFXlAh9h3uttQVzjp1sKHmXWUeh3OQH1oaw=;
        b=Pi+e/0JbEBc6rc9x2oF6ycpVpx+yrCqjvYDiE105zydnRh1JAq00FZBCItzHPjlSLB
         sl22fSXnSGFb3XoARQeRkxBR9ykrDtwGkMSa5f6yq7c3KIvBWRSZxwD8UTIgEVgZbOeZ
         CrWuWsxhaMemy+KSBMOlBTaqyN2MBIMUsIYPkSbjz8ggq0+xGXXH8CmgRWshxKdWGvm7
         ewaF/kKiAgBr/6Gg3RGHXrag2PQN2v2RxdFQUWHuwdAw1NWsr51Vg1FM3c0cRpgZBzjw
         EpM9lcMpv63/9e0eRShZZJHW0mOv7GgJEVvBcKYun7+A6V9SUsV0lT91tMN8uQjZL1Oo
         pFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765893; x=1689357893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhmMqJgELFXlAh9h3uttQVzjp1sKHmXWUeh3OQH1oaw=;
        b=WUu02zoy9bJGFZHmMEo83sEAbj4H2IS0cgFP/2Z5y2PEgUgb5HdLpFqpZbVdeVMDk4
         Q3lZZq5/V7sKPHN4udk2tyBVLre1pCnGjqrQGAhyX2dBaoaGpJ54QotKfww9LMUnznbr
         rcLG/2/HQvjRRcwlq2t9eCexL0/VVnOWFgENw/1rA6HeraUmI33nJ7dvG8a/A7GHEzbB
         M3CcrfkVs/g9G/VeTBRFFahAQBSvqtsGX14QwUOmrzOC2pnr+GlwlUxkHPMzUcbzg8bv
         YrG0kJIRyfuKbYs/IbLXZeAPTrmRGPF7/cDP6yWxGux/zGu0hODiLo8dfdcGyi9hDgnd
         gbBA==
X-Gm-Message-State: AC+VfDy+bD05a6F4W/5SVAH9kk6DFt9QSHEu1MCzZXEluC9NKFS4TtdU
        e8zhQKSM40VkChdmUTFiw6szfg==
X-Google-Smtp-Source: ACHHUZ46Xypjs0BrwGKM4RnH0dBLszdfzW4nO2vBplYiPIlV4EJO7exKV49gq1+V/PzqYAL/O9eAjw==
X-Received: by 2002:ac2:5b11:0:b0:4f1:30cc:3dae with SMTP id v17-20020ac25b11000000b004f130cc3daemr11180460lfn.10.1686765893783;
        Wed, 14 Jun 2023 11:04:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:32 +0200
Subject: [PATCH v6 13/22] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-13-263283111e66@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=1291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lGCEkIFx3Ro52nqp/0xgEzhtJm6XAu+5tICY6AP6scg=;
 b=GnkaJ6PJfJFJ+U9D7aBXdtV2MToXO8a11ZO+RlxPzks9VSY2QScKNUzv9n8sie0GHv6FifFlM
 Q3tdS7702caDM+8AU0pN6g5oC4c23C1hZAdvu+mfUf2m7WTu7LjeTqI
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

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 1faec0af74e7..82fe905b74a9 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -983,6 +983,7 @@ static struct qcom_icc_node * const qcs404_bimc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_bimc = {
+	.bus_clk_desc = &bimc_clk,
 	.nodes = qcs404_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_bimc_nodes),
 };
@@ -1037,6 +1038,7 @@ static struct qcom_icc_node * const qcs404_pcnoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_pcnoc = {
+	.bus_clk_desc = &bus_0_clk,
 	.nodes = qcs404_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_pcnoc_nodes),
 };
@@ -1065,6 +1067,7 @@ static struct qcom_icc_node * const qcs404_snoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc qcs404_snoc = {
+	.bus_clk_desc = &bus_1_clk,
 	.nodes = qcs404_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(qcs404_snoc_nodes),
 };

-- 
2.41.0

