Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56F17357DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFSNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjFSNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:05:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16651738
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f76b6db73fso5439683e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179892; x=1689771892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhmMqJgELFXlAh9h3uttQVzjp1sKHmXWUeh3OQH1oaw=;
        b=Jc0K5UwZ+laxYKK03jBheQmpDvzqfDEws4KGpfjz4n15U0NyziU10HTCZQjLoEfauZ
         flF+teE3HpYtTtEigTy1EgqXnfrI6YDlDGLMjcm5vASK6XpXmptaHDNrtMTfOLk1Gp6r
         7BM7/sCtYX7CB5ahh4TK/KUlcugIZtiC2ZtbQlOlluH+QUIX/7OVtg4s2qqGdTb+MN2F
         pGZiFkL/mF0sebwmPxolcUONW0zbR8bXonwcJZbdPy3okPNfocGbXx2vSIh+fcHwSfhr
         ROfmuRaW0BBgl7MF6QzK4xN/j2HWiBAtuwiERcwfAB6eVkjEBQ/MbtP2gRUzPTn158lH
         nkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179892; x=1689771892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhmMqJgELFXlAh9h3uttQVzjp1sKHmXWUeh3OQH1oaw=;
        b=OPZaVj9OE3YlImqeTlAAI7WxPyjqtxpdlorC8M9xBfrZmPmYzAjjDKmPcF6INtFtZA
         i0vebLE+Ld3/5OV5ZDkut3yRRUGXB7qGMzXh9fBlNeFb3Ls9ci0BrH/20n7Ujh2Yov3/
         tV9nNNjDARGB3wwK9ydiNj2KGgc5i1+qHfSFQnV22mNQrP113l+XNETPxSg3u/zFl2TG
         ZvchihsKvBKHAl+eAfBpxP9YFFhRkZ80y/c9APLnQzPACesBREfpjTK5Po4mbdFzYoq/
         D5a340G4X5DvjyBG6d5x29LWmDdoX7d7ggehnR0PHhUDvcYobLzb68Ik0OVkzYkj5/YA
         fH1A==
X-Gm-Message-State: AC+VfDx6+jm5RDHXym7f20SXOcd/ZA6Q9CsGwqxDQ5VAAPyNKraS/Ntw
        93NYOSYvnLZt7sJoqw1amWzIcg==
X-Google-Smtp-Source: ACHHUZ7FZjpRKxq5d65JTILojVXT9Xed3eqJfgeE81NVF+fPyI4WckxgKrGODb1WRo6oBc/BN/Zysw==
X-Received: by 2002:a19:5e01:0:b0:4f3:b18a:6494 with SMTP id s1-20020a195e01000000b004f3b18a6494mr3003131lfb.22.1687179891982;
        Mon, 19 Jun 2023 06:04:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:38 +0200
Subject: [PATCH v7 13/22] interconnect: qcom: qcs404: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-13-09c78c175546@linaro.org>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=1291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lGCEkIFx3Ro52nqp/0xgEzhtJm6XAu+5tICY6AP6scg=;
 b=gsd3ZKxdUUC8liSw5PeQt2eYT4eSPAWZA1xwNUTdCWDlP2SQz8z6Zyq49zm0lik+zzQqoh5v+
 WG71xRXXAGrAO+6TYRDrowR/lWikzPdmt9JWm46XF6li9X6t7GftYyf
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

