Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78573B82F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFWMv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjFWMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:51:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C782693
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3129c55e1d1so696083f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524654; x=1690116654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYdp75VAJ765a2DkcylWB3P153YCeO8g/iykuAM8Pgs=;
        b=bikJxea1Yk1J3T5KYNMQApfPvaGH74ADu2BxV0CNf+XOYt5OtyJVvIJC9wYFXXLXo2
         S1PDVkLW3XYIOWlUFwhYjZjqQEPlftarS2tz3ynAVSIC8yX/AzOMP+7HyJMCY0QLPzxG
         9qnl94f2gUApQvgtdvTj03jcoYsTbm8vHZ7Mj9suRpwnwbQt2UY+EBSxcRZeUzaD0Nls
         cRug7w2qVPJvgc9vTnKCIlBHCQJDakd64iFIncRAkTky3dR/nppwHSlEs8QzXKGCNsAr
         Wm0bzjsH4mQPFLl3eiQQwJKvH0BFJVKqR33metaCfxSbDUaKSCQozuQTxUa2lZ9bfdJh
         MFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524654; x=1690116654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYdp75VAJ765a2DkcylWB3P153YCeO8g/iykuAM8Pgs=;
        b=JHO/58FFmjBcioJMPM3dyu089QF/Bt7tRZmjCJ5bREuVuto0cZIqO8ZvTb/qDRpFOd
         XoWML9ewMCujgN5/bVAv4R6na6wdaeNlxzqeqywx5eypiMj0638KCn/AtZHDVcKPsRon
         p86faUj4JN0jTuBKqb+9MwwCCkc11XeMjBASOjetz537PtTkbqzfvRwM+pv6TtAdE7Ny
         IsziM8Ykmr5UIWduKAB7OBs17IAVqQ5iPh4VXQisW5y9Bez8b4WCbUz9oIh3GgwrfQIN
         RKjTORhTm3p01fmXbTXSyFjKXAWo9Qr9BPgG3zcNSpTNNoyuk8LMxXXMHv6cRrIskVME
         DaQQ==
X-Gm-Message-State: AC+VfDwU2oYiS3nwFAWftvAPagh9f1P6URRSeaem58dIFPffTgzccJGi
        ed3r0A/p3/VW1lyfPOtsaoBGYKufSHl49k/mYew3Eg==
X-Google-Smtp-Source: ACHHUZ7qAc5EKkLfCusMiH7xwYSijIrrBDzdRNP/YHHAqobl4iyafrfQtwOZA7O8+0tQc5Txvm/tYQ==
X-Received: by 2002:adf:e585:0:b0:30a:f36e:72a3 with SMTP id l5-20020adfe585000000b0030af36e72a3mr20991627wrm.0.1687524654342;
        Fri, 23 Jun 2023 05:50:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm9455350wrs.108.2023.06.23.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:50:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 23 Jun 2023 14:50:45 +0200
Subject: [PATCH v2 4/4] interconnect: qcom: sa8775p: add enable_mask for
 bcm nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-4-709474b151cc@linaro.org>
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
In-Reply-To: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=871;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=T0OCke3zU0kw5rM6EOGl8ujcJr6B7UbkFHa+/zvY2yY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZUlAw0ZOrFFJdxA2MlOVSR2x2/u+WWMqwGAroEz
 KBdhuSGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWVJQAKCRB33NvayMhJ0Yg4EA
 DO41iwRa2L9Mh4dQM+rNxAt/O4LwF8KTM5Z7SYrycTMC+hO8I2zyPwGaGH/WOJhBt9KMyYSXxccu+H
 w4UkP2BfStArd5qsC18sHYDQxIary7rt2/N8RxfJjAeTe2saSVrI/5Kd3DOqVhG/N1wz4kGzyPGzhT
 H7/lS+ajV6jt3JH0uO4DbwCVMzDkR/qa2eTj5plcYAMgbTwXIVJUGaads3eet9Fqa5b5gUo6N1giRJ
 HkhpkGMh6KAbsL37HB63jSWFoeEAkYpZpyLbKUuopNqRsw68MMFvgteXxbkx3difOL0RAJAecJw2Uo
 nehy+yVZTDytzFQkX7rP5ctSHN1RNcbr/5wdD9RgyiTo+vRQ+2X4R0i/wOv6NOdPxbclWsWcAQ9sZh
 fv0FYAhCMJAP/k3T9Sj2GMnmXmrRVpSQG3t8PQcnt44meGjyUyoGKJBEj0kWvPokq2NefjhrmWYkMj
 +yzDbdbBzUtabcUT7ZoBOTUMpRyr8czV/MMWES3908S08qeEws+hAPAv8T/0EURKE3zyWVbYHDwLMu
 CrBi8CQ+t7oJoH4yIRpg+YGvw+Ie242k5MdeEMuyrScGj44pLuWFxhEbkBwBCTISf7fjtKKeutwqgI
 yJ6mNSeOZebcjV06t6Zs5wAN6YvEBvUvr+Gd+C1GsaZgGmsJDM3F3pzZH1Cg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the proper enable_mask the ACV node requiring such value
to be used instead of a bandwidth when voting.

The masks was copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r32-rel/drivers/interconnect/qcom/lemans.c

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/interconnect/qcom/sa8775p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index da21cc31a580..f56538669de0 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -1873,6 +1873,7 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };

-- 
2.34.1

