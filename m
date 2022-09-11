Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D85B4DD3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIKLMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiIKLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:12:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696132BB1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn9so7399078ljb.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QW6MO1hMHGswxNmgzSJJEoxkkpvgP7Us3KREmZxCiHY=;
        b=eyeXN9Le/aPSWoxIrfrsLAdbjSJy4EuQYeJyu7Lcit4T9HVME/yo7Y3GoZzc8vCsvR
         VCCvqP7BYX45NmvzokK5tX951hLpcQZQ4hTnJG2He5Cx/ZK3kCNbrfGZ7lgudu3C0tJI
         crYHnII73yh24E4yx2tkGhza7jxrYR/0r8qQnIwbsnY1fqH5GrDUyNsdvFqd1joqmJs9
         W1KRIzbabLt+hhw/m3TTlXcqhox5rR3tPg51F3hxvrjq/wZLdJnuBty/81dxFqug4C3B
         f+1R9C56WwR3TI+nkr/HvS4NY50+ZmW7jcm+0V/FDXhUVaP0ZHZcOHdLmDI3lIayiVl2
         0d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QW6MO1hMHGswxNmgzSJJEoxkkpvgP7Us3KREmZxCiHY=;
        b=p3gjn2rGYVAggrS1j1X6gwJ/hXKq4hrIKr9K0348UUQyzR0y8bv+1wpy8Wh1vkhznS
         sapLmXf/7mps3XAauT7AwpLfrU65wi4Bi5N/J9UWUM5CF2Y5mb349Jmz8Ky2sUrYdob8
         8Dhdfl0tCo2LTzPtUi4DU9i1P3D3fp070iDQNmEN+WW+i8pL2stqnUMTOe7P+BQAojhQ
         sf692duvDW0ml6olcAjnB2P/bQuT55Jt/7uGkqc6sRfoTMvio36LoHFXk5Hs3pjZOYBA
         zTMBfQmkLoP44MjMfZiXW9ZXFBQTelPgTMSIE+gaJ4HGc587eJ/M0FAqiVWeuwRG+kt1
         sWLQ==
X-Gm-Message-State: ACgBeo0vU1Q/S7nakQdFRaPTnGNjM5Jy18lMZDFCMXSHOYjhXwFw9/64
        t+00I3yDehlGtIIs80roqnJE+w==
X-Google-Smtp-Source: AA6agR7BV8HBCwYB1jzJXqz85cIhYPcJQ7yITXg8fPLl6vijl1milInz0nx5/IJi/IVn9w/OmT6Wdw==
X-Received: by 2002:a2e:7314:0:b0:26a:ca18:60eb with SMTP id o20-20020a2e7314000000b0026aca1860ebmr5969946ljc.69.1662894734365;
        Sun, 11 Sep 2022 04:12:14 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/40] dt-bindings: pinctrl: qcom,sm6350-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:28 +0200
Message-Id: <20220911111200.199182-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required:

  sdc1-clk-pins: 'function' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Another question is whether 'function' should be disallowed for such
pins?
---
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml        | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 85a4ff5a5625..0c4bf6e90ba0 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -54,7 +54,6 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -111,7 +110,16 @@ $defs:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-7])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

