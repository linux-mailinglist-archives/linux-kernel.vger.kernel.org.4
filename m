Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBF5BD46D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiISSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiISSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD3B4599C;
        Mon, 19 Sep 2022 11:06:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so328994wrp.11;
        Mon, 19 Sep 2022 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6o/84kfK4xdwTkYBv2fG3jImlB7S6+cVbXt6vDjpfIE=;
        b=ht7pYL30ye8ua9awvg3LxLGDnMjoWRRlRLaG9QDB35JVIB+1KFOI6iyZAvQ33J/Rvp
         30V66POKe5nspYmO3dI64HnWRcOS9pm30RBhMKSxCLuePnvUfOJq8fR+YKil+mLtyogx
         WrON9vmzBm9GPEIrhA52KDqtW1aMow/SinwKEiitQKnUdY987xoRN9lmPpALhKk73Jfm
         5dHyd3V/NmAClp0I17NFX8X6nPMSpr3+wmurqUvo3/k2tQMQKgaXCLnFLFZzqBE9Q2hv
         XFsIXdXRzntU914D7ek5CrWkO6uBxzLJIPQE6n5bW3RN6pgD+X/nTCXuIbYeRx+HU3RM
         4/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6o/84kfK4xdwTkYBv2fG3jImlB7S6+cVbXt6vDjpfIE=;
        b=5z0gFQHigqzJ4Xs+LhxCSDBWZnTno2iWRJYHXN0tgk+P6EdCXp0IPeDp8FfUzWaQh8
         OryloKOtOz0huXW60R/S7luz7XdDu1C2ej9Mk8KkxVN4XCqqC5XPa56cdxUnoQzPc9LN
         o3o5m7NTJIMnwfrD0+FC67wV9lvhutP/5UnMEX9llCksqOx0hE2IPoB1dkuxga8Iquc9
         7DJ2TuKgGXlELBWk5dtmdESdfLzKKlS0dm81brBOdzkP5wwS+W7t3xj8jARHTmnB0vNW
         tZXJDKCF7aQzSG5Fo1uOeveFQeHQlBU6+pdQBwOyn2yu1vA7uNi1Ie5268F+TOrFX3P4
         XJuQ==
X-Gm-Message-State: ACrzQf0//KxM/+IIEX3IltNBQVaqdEiKAzXMZaC0yaXe5X+5VzWRXFYu
        wFGekebR6coKTERh5GjhxiU=
X-Google-Smtp-Source: AMsMyM5bvWOJCqx4mOVN0KyIB0uluk5u/oMUo0Cbtapb6sfO+XCML06C1K8dg8xNAhtDw1AlgnVTHA==
X-Received: by 2002:a5d:6245:0:b0:225:41ae:a930 with SMTP id m5-20020a5d6245000000b0022541aea930mr11723087wrv.342.1663610799015;
        Mon, 19 Sep 2022 11:06:39 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id n6-20020a1c7206000000b003b4764442f0sm14192711wmc.11.2022.09.19.11.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:38 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] dt-bindings: usb: qcom,dwc3: Fix SM6115 clocks, irqs
Date:   Mon, 19 Sep 2022 21:06:14 +0300
Message-Id: <20220919180618.1840194-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6115 has 6 clocks and 2 interrupts.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index cd2f7cb6745a..4ca07c79819d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -294,6 +294,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm8150-dwc3
               - qcom,sm8250-dwc3
@@ -348,7 +349,6 @@ allOf:
               - qcom,sdx55-dwc3
               - qcom,sdx65-dwc3
               - qcom,sm4250-dwc3
-              - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm6350-dwc3
               - qcom,sm8150-dwc3
@@ -380,6 +380,7 @@ allOf:
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
+              - qcom,sm6115-dwc3
     then:
       properties:
         interrupts:
-- 
2.37.3

