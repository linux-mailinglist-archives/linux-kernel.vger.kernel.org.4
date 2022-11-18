Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0762EF30
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiKRIZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbiKRIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:24:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097268C55
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:24:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k8so8173658wrh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiBxSrL28JGP0DNg6s8GgXKGYTQyCsmgm2nfUqqKcn0=;
        b=r9D596iI5oH2Q20YxqLfmXNZWeSrDF+EeAgL8EC45v2B0xm5tb1c2LpX8OKlnVp7aE
         ULNvkfHu5Ocbi5YL4H/Mln5dGws81C/eAckKlZ25Ss6IVeyxE+RRkeOnwVc0avbpJCGv
         Dw7JyLiM6LIuSXOZ/ujnutUiBm7WauQxeYNdHxhR5+vK+sdAkhdwV+BKs6G4ZeigTZ3A
         6sXxKgbzsA67/5GpBsKNv+Y7VemYH2/fWz4Ewlb6NbPsxfw9plx6xK2HNGNKvbb2+RMg
         8pSGY+ko2IPUeBN3pyXYFXjnkU5Xl0j79pOg1S9fxeS5AZFCeSypmbbhZJLdhRgOFyYv
         1dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiBxSrL28JGP0DNg6s8GgXKGYTQyCsmgm2nfUqqKcn0=;
        b=Kvbxc8VcEpmZlwdQtC4YcVs3/36C811jz+E7SGx+o3bG3cgVsNP0bIhwv3jEBM81mR
         +e1GKD1s+QhXJPMAOh7Tfd1fIg4C5FMR3qN4kpEowcl44XzDtaqLLgN3VmoedmGSv0/y
         uGpvBa0UE84ParOH+iDqkth0OVW+W0LnyhIunzWc6CyZHdHvn+zg10mwCCAnwgpnNb64
         dAbFaPQqnLW2q22NBhgRumVR9lho2EE/4v8ngn8KrgOl62gKNH9sAuAcUEf/P9we7y12
         /fvcFJ72vEcWUgKykZMqtrHszjQlAxICKQ9fT+XyC+sgmn+vfrp6uzEMn/QGxjQBk9Ma
         QcSA==
X-Gm-Message-State: ANoB5plVA5V66yqxyyvbTp+AIouRnL9tr3HOJISI7IaCZdDnC7ODW9NH
        2hFD/aCh7f9Q6IOKrrjH7V8iPA==
X-Google-Smtp-Source: AA0mqf44oDusQvGEljhwkHzIV7/Bt4Y6ek1XYFTCEPTD1VQ6CwTtSS02BM2BGvCWXRmFCaB15PQY5w==
X-Received: by 2002:a5d:5960:0:b0:241:bd31:fecc with SMTP id e32-20020a5d5960000000b00241bd31feccmr2088932wri.635.1668759884009;
        Fri, 18 Nov 2022 00:24:44 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003cffd3c3d6csm4070084wmq.12.2022.11.18.00.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:24:43 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 09:24:40 +0100
Subject: [PATCH v2 3/3] pinctrl: qcom: spmi-gpio: add support for pm8550 & pmr735d
 gpio control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v2-3-b839bf2d558a@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v2-0-b839bf2d558a@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the pm8550, pm8550b, pm8550ve, pm8550vs, pmk8550 & pmr735d
gpio controllers providing GPIO control over SPMI.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 8c31a8f6b7e4..d65c9f2ece73 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1219,6 +1219,10 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8350b-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8350c-gpio", .data = (void *) 9 },
 	{ .compatible = "qcom,pm8450-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pm8550-gpio", .data = (void *) 12 },
+	{ .compatible = "qcom,pm8550b-gpio", .data = (void *) 12 },
+	{ .compatible = "qcom,pm8550ve-gpio", .data = (void *) 8 },
+	{ .compatible = "qcom,pm8550vs-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pm8916-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8941-gpio", .data = (void *) 36 },
 	/* pm8950 has 8 GPIOs with holes on 3 */
@@ -1230,11 +1234,13 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },
 	{ .compatible = "qcom,pmk8350-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pmk8550-gpio", .data = (void *) 6 },
 	{ .compatible = "qcom,pmm8155au-gpio", .data = (void *) 10 },
 	/* pmp8074 has 12 GPIOs with holes on 1 and 12 */
 	{ .compatible = "qcom,pmp8074-gpio", .data = (void *) 12 },
 	{ .compatible = "qcom,pmr735a-gpio", .data = (void *) 4 },
 	{ .compatible = "qcom,pmr735b-gpio", .data = (void *) 4 },
+	{ .compatible = "qcom,pmr735d-gpio", .data = (void *) 2 },
 	/* pms405 has 12 GPIOs with holes on 1, 9, and 10 */
 	{ .compatible = "qcom,pms405-gpio", .data = (void *) 12 },
 	/* pmx55 has 11 GPIOs with holes on 3, 7, 10, 11 */

-- 
b4 0.10.1
