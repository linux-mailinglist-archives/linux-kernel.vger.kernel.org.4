Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA16E8BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjDTHv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbjDTHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A254EF1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so4330893ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977065; x=1684569065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT98ZUIOHQDisLLzR6txJBqg38B3hjy7KWFju1C2swM=;
        b=QS7RnNkxeEH+4rY7j7xPTO9yVEcj1PTTf0APLQHLSIaq9l+AyrIAkSTQBRnhXzymIx
         AztwSZWf1Zvkj4Oi7ITLVTX3j+r+AHaOoBiYKgHFHSvYt3cYkCW3RwUYiIbJUWzg2Avv
         nqn7jqZiM1eVR/tquNM5RHgZIAUQ55SeWN5ZxHK8Nld4FLFK/OEhugoaw6xWjiyVgmZQ
         gw0kc1oG9IkMhqCEpy3Z8S10lHKW0Pt1v28hDjxB37W+hOIc+U+UV9wpnlmPTr1QQUdv
         S/NDUrm/7rQZpIWwOYpNvAzUTqA5TF/NKXtr9nTorcC/J+MAFh5rbGZ0W1I14sN1PChL
         LAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977065; x=1684569065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT98ZUIOHQDisLLzR6txJBqg38B3hjy7KWFju1C2swM=;
        b=Lh4JL4/etVWVWKrCKYTSl04v/JLyepMzlfXtNn6EembiqC0cGHZs222a1GlJDnpsPa
         SzZix9jAfA8+aA3E2CvgS7Ng2GqqVbE8xYgsK+balvUMfiXZ+Z3ZPS42/MIWRBXQqCOf
         CvbAvPDZPTguBePTEv1Ar95WtvvKz0EFD1QSieQAcktcnHGLhkdVsMO0cmWhKYhLQLUB
         /wUfhFoa06kpzbL8NNe3xdNIr9mtNkKOTeL1EEYB0FoXlKDV5rMBqlPS63Eqb6rGjjOT
         YmjAkff31ZcU9aw3yLnjmRd0gOPNb70uKHXryYUrvinoYwVbbM4c0cChzfcjpOr50Tn+
         WVJA==
X-Gm-Message-State: AAQBX9cQnRcCv7hOiNjlZmhfxuspHuUuH7uyB5cXP1Oc+dPkry5TR7b3
        MTsPSAgCKot4+vPzxkYhM+RtOg==
X-Google-Smtp-Source: AKy350acUXyEmc+p2LiJuruYd8lPA+IdeiFYDUS+YtYv7txdejaOPxf4pTAKMsCU4lJnMHAm+r3HsQ==
X-Received: by 2002:a17:906:b20c:b0:94f:3804:5cd6 with SMTP id p12-20020a170906b20c00b0094f38045cd6mr586981ejz.66.1681977065614;
        Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/10] ARM: dts: qcom: msm8960-cdp: move regulator out of simple-bus
Date:   Thu, 20 Apr 2023 09:50:52 +0200
Message-Id: <20230420075053.41976-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
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

Regulators is not a bus, so drop incomplete simple-bus usage to fix dtbs
W=1 warning:

  Warning (simple_bus_reg): /regulators/gpio-regulator: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 8fa2befa629a..6c1bc3818883 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -15,16 +15,12 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		ext_l2: gpio-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "ext_l2";
-			gpio = <&msmgpio 91 0>;
-			startup-delay-us = <10000>;
-			enable-active-high;
-		};
+	ext_l2: gpio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ext_l2";
+		gpio = <&msmgpio 91 0>;
+		startup-delay-us = <10000>;
+		enable-active-high;
 	};
 };
 
-- 
2.34.1

