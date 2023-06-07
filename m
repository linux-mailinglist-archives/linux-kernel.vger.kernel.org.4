Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E907256E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbjFGIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbjFGIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:05:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3710DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:05:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5865007f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125112; x=1688717112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gE1qhAhlgSaB66o5SMOQH1/DZyGEHuOAUxg0SjDKmKE=;
        b=HAjIbiURhSM2F1wihpcaKnBZ1ATOwtT48EJKnfpROc4BAteX3tegdMuSB+ovEivfSb
         tRIUXb6bw6TlloRdHldXceIi0Km97MEB8GI8tAxnWAwFovQv+bM1w5V9JTFt2hkxIBl0
         jr0renaM9mkS9gBEGuGduyBrUFoVtjkyhcNvll9ZdmCXkZfbuEBTOEoz1tmdi2Iri6U3
         Ej1UcVq+bA+dAZzMMk1b9XlAmoQiNGmapaks0RMEg/g9gFn7yRW01FLNpGHgGD+9YaOW
         ICgsgziCyeVw6vJWWoBfoZ1+kJKgRnKOizI3JzGnpb6zck+Van6Vvr3bCTgDrjzlFv+P
         qiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125112; x=1688717112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE1qhAhlgSaB66o5SMOQH1/DZyGEHuOAUxg0SjDKmKE=;
        b=GJUu3uaMU68XOgDFKpOpMa7iPnf2M7W+rKYgnQKQbCIZY9AKqMwBTLPAcRxwkmRGNg
         Sy+TeccnSxXYGxw1emFgVFm6dOTgyJQN24NoaKTqwIxng3lScGjZWZWXOB4iBC6L/ZTw
         JEyQWeiKONH/sDpuHdssrTvG4+RlRE2f1vdXKHyCTbF2zUiQd+7yasAhwNQ9/ZPGixTP
         +ErAKVOuj6bM2INjha6LDICN6bGBGAAZk+mqTPLcX15roEyg+5EHgJlimMpPvYO2OJf9
         x3U24zaKRdjrEMbupr+FfjTBc78lGn9FyzzlKmd1BR7pGUM5DpCmuZL0JDarPz/gG1NY
         78tw==
X-Gm-Message-State: AC+VfDzG+6Bct61HUiseVlrd2Gu20kfzzayv4119pNI+5UPhBY34czES
        5hWCGHJP9WVS+I1T+2m6DDSDrQ==
X-Google-Smtp-Source: ACHHUZ46A9CM8Ldjm2dzNVyfQDTcYDYZzOV5FSPMMSJbHo+CtXsC8s1ALkAgGKT+fE0d7T/eLtsmcg==
X-Received: by 2002:a5d:4d46:0:b0:30e:5283:ec85 with SMTP id a6-20020a5d4d46000000b0030e5283ec85mr2792581wru.33.1686125111884;
        Wed, 07 Jun 2023 01:05:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm14706269wrm.17.2023.06.07.01.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:05:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 10:05:04 +0200
Subject: [PATCH v2 5/8] qcom: pmic_glink: enable altmode for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v2-5-3bbdf37575c3@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=z0GFmf8RXrtifMxHJ2/MNRFqa/pTMGwvA09+Qr9ms/o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgDov64o9cYJqLKmocRK9oMU8YzpISf9fvbDGZqpc
 lHI71KeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIA6LwAKCRB33NvayMhJ0VIeEA
 ChyuhCk5Z4gXDrAm6P7ShqvfFh3tuKAez0xzlhDOimixdQNd1XoL9HCUt3SEyQqZtIEy+n7KNl4R63
 SsKZZkttbC0GLWb38OYLNRPVzj4awqh4lAO1h2Mjplz+HsKyxSPR3pN5mt6cIwuhzsvjEW1ATWfH1W
 dfQPsnKyK7S8C/Pqkr1Bpu7SVyXVKvJgZ75Z0m7Nap+1Tov7OMnHLeqWRiEePZoi994KqEgEZeuHKB
 qCkuLnsqWtkOOoKxMocx9T1hKqbkXWb02hJRTzUN3Y84D0gCASMoIlQWbzKOzf17kEV6t+FIwpY7N6
 /RgXrEJV3amblF8lNKoTiiEQuq8ST7ScLwwkYZiYzuB/qQiDXo1XyawqxFWnRwwCV4cV4iKQZBT8tN
 0ESc9V1XQLZz7MHCggse+Puv9jDPjvqws011FRW5vrdmQiLW9V/gySFlASQQVH6Q8Z/dulr/Xz292U
 7fDWJleXrul/IMBESM62ZB0rGwdgbk7UNCvugPAnDXi1ClQplDb1Zu4aGicTkqAvpDwYyQijraR2WN
 /ZjsxAhg+wC/qqrDk2DM5/QCkN+jiOaXFDGaGOK6eaGCHI6J6+CTeevG3VnCCOegl4yU/+jahhcsfq
 a9EQdo19XGTDyHilKQ4XU3qAmKV4w74qyq7BXsYb1Fazxo0Jm0dUkTKpf/ng==
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

Altmode is also supported for SM8550, allow it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c87056769ebd..8af06bdc6f5a 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
 							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
-/* Do not handle altmode for now on those platforms */
-static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-							   BIT(PMIC_GLINK_CLIENT_UCSI);
-
 static const struct of_device_id pmic_glink_of_match[] = {
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,pmic-glink" },
 	{}
 };

-- 
2.34.1

