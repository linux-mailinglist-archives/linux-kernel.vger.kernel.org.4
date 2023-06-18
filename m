Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FAD7345FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFRLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFRLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:45:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552210DB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98862e7e3e6so94382166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088695; x=1689680695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dPojD9npiwMmQiJv3PZb1An4/WWE0TQK40AIn/qp+M=;
        b=l5lafToVQYIRevrMTRL+nQkXc110zXRrLErkmbHXlKy5VvngHg6+dUmy7xgJ7WdDrH
         rMndE7K6XF7eeEJkMOFhTK/NhNmmDWtkHORQdhK6jXmE329mvDm/3rBMAh0yTnglzYJF
         KoTR6U23wZ5R8ovNBbOtIJn7oJUMXjf/10VCf+bIiXQybgLsTQIgmiijACJl3x793nh+
         r9YQNNyP7AcGw7FbOQ4kKdhvU/LCGJG92I2YpSEnqx/eBqnN3W6xGvUrsroWbbUD1yk+
         n/hvBRt3FfeMOpNYqHEB8ZSCN27SPooR+Py4srNEYzrvUP47kNSYDBxEdqyT2WaEU2xn
         FT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088695; x=1689680695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dPojD9npiwMmQiJv3PZb1An4/WWE0TQK40AIn/qp+M=;
        b=MntOC4vfx9RfcvnHc0mKV098sVCGZpjTYXyRIIwURl7g+2bG9wXGb1NOLc0jwqOseR
         1KngAICPeALRD1e6oILYKZwKr4owdB4HcM0Y2Rb3T4i6EqBV2CzxVYgT4KblrZoAX+D6
         +tMOgqnpGwE6rPdElROwdf6aBHIA4iagZ7jZFTFNdNZb9dzYHKJZBbm+LgwZo+zvX2mj
         0XGiXfL66Fx1hA7zFm+J9D/9k0CU1c7uaHdNg+1E6t3ZVeOpPsV/rPofP9u4wk5XA/TA
         3h4szp8MA5NG9WGy3e5DKoM3ul+s38lTuqlIRw/bKa4hgW3H4jY0bAAeUckhklchCpn0
         dH8A==
X-Gm-Message-State: AC+VfDz+l80Ve6tXgrZvbnSjiZfL5er27q+G3wrkI8uM6B5cmDQuMQqM
        5BvlqLdWiussdLCP86JypgoLkg==
X-Google-Smtp-Source: ACHHUZ6QitBWwkX6i02gqbVLAFVkgxp4wvxomq7VFX9OX9IPsrfNRB+6OtExkYlb5V8Cc/kUZ/DS6g==
X-Received: by 2002:a17:907:7f2a:b0:97e:ab29:952c with SMTP id qf42-20020a1709077f2a00b0097eab29952cmr7313016ejc.2.1687088695257;
        Sun, 18 Jun 2023 04:44:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] arm64: dts: qcom: sm6350: correct ramoops pmsg-size
Date:   Sun, 18 Jun 2023 13:44:40 +0200
Message-Id: <20230618114442.140185-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
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

There is no 'msg-size' property in ramoops, so assume intention was for
'pmsg-size':

  sm6350-sony-xperia-lena-pdx213.dtb: ramoops@ffc00000: Unevaluated properties are not allowed ('msg-size' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 30e77010aed5..698171bda9fa 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -673,7 +673,7 @@ ramoops: ramoops@ffc00000 {
 			reg = <0 0xffc00000 0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
+			pmsg-size = <0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
-- 
2.34.1

