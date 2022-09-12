Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA35B5455
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiILGUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiILGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:19:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C129821
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so13202708lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hce0/X2M7TfP4RUEOJj4lD2o6WMQMhsp3Z9J0vMVmr8=;
        b=ZXKYRnQbMrzbBBMEj5ewTSQLkcTtsF4QhqUnK4rUxBkiQD50Ieq0wUWyfhwd9KToOJ
         mFeHU7I317N5fNIMGMNiSqiUNKfYg2wkERv0+lWfcLQp0IVkb6dK+wIi3vmaKUoQR7lB
         3TfYUbwk+0i6Mn9AC8xYOZ1bypcR8mKVJFlZ3eMo6XuPvkVTbkAEApY5+hyI9s+8ZwbO
         ygtufrghs+QhH9cJTXUbWEFDgSFcXeaYzkRVarXF3GODspqDRs4unjTVMcR5WpWdA81J
         Ky5BsIyxt/O7HbYyiMLoiXw3aQfF+dAwwv7Di5DdEW7G4gD3Er3e7qaNfmhgjb8iq++U
         /9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hce0/X2M7TfP4RUEOJj4lD2o6WMQMhsp3Z9J0vMVmr8=;
        b=orvwroK1Ug9qQfj58pGreHFZQW9W0ZNjz+CFz4WFLvncP1Ur6HeHZsfL6HwYkhB0sO
         9sr0i0CnybkKANgWhKoACcsKuSmJ/el+iKUsnwXKpipfRNOh1fl2gxeB1TJueM648RUH
         BBqIkzHdEkibuzZZaVaeFk4xUKwxj3Jt3fRvTuWLJgtggLJcqX5jlmZkg2KrtV4QMeDn
         n3Z6wS7qoI/RejqxkitEQzOVxZW+jSQII7E/UucP4uUBZrlg9Wmoo4LthhhmgabefjQN
         n5jk5B1lwKV/GSWHv5CKQgfIewAvWPudY4j8hATSB5B9Rq/+RJ+jDyjHxziThwZSBuih
         RYuQ==
X-Gm-Message-State: ACgBeo0DtjbD0mT8vsmjF+mixC6IHYkn+YhIphKgEMTS8bpSvwb4ekMt
        Y0gpVBI+R42UMMD/Z0ZHWNk2CA==
X-Google-Smtp-Source: AA6agR7wxJGiPeuK4elaQ/Zq9PldsHu63xZJaoVKvIJwb5wrJqe/x6l3D/S89Et+8uD4aRFo5guISw==
X-Received: by 2002:a05:6512:3409:b0:499:f8f1:8322 with SMTP id i9-20020a056512340900b00499f8f18322mr2448812lfr.459.1662963523773;
        Sun, 11 Sep 2022 23:18:43 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 36/40] arm64: dts: qcom: sm8350-sagami: correct TS pin property
Date:   Mon, 12 Sep 2022 08:17:42 +0200
Message-Id: <20220912061746.6311-37-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin configuration is selected with "pins", not "pin" property.

Fixes: 1209e9246632 ("arm64: dts: qcom: sm8350-sagami: Enable and populate I2C/SPI nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index cb9bbd234b7b..b702ab1605bb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -223,7 +223,7 @@ &tlmm {
 	gpio-reserved-ranges = <44 4>;
 
 	ts_int_default: ts-int-default {
-		pin = "gpio23";
+		pins = "gpio23";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-- 
2.34.1

