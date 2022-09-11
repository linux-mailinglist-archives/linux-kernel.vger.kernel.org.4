Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71545B4E19
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiIKLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIKLNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C93D58A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q21so10451118lfo.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XCpzuH6l9uwERwbmApSAocGpO1WUQ+kJaH+BaZZ4Pgk=;
        b=XfWPipm8NHuHGFvOkzCgPBObPaQVO60zqd+ssj/FBsKKyHzkIDUsRCDAeiJ9gY71e4
         89VeL0jtf76X+KYLAp81TQb8bZYYM3cXdHE98pISUzxac0+907bctyFIc04qvtAkCvEk
         CKVu6AB0eqEcaIQnnQ3AwJWJE2mJLLB3lJgxt2BVUIMbJwsVCpDTDRkUAJORNS+09pmr
         Y3cOd1FwbKeBAldntvZY8urBxPxZqV44rNlGZjH6tgPDOyHOPSCDKy0aOLAizBejtOME
         kA4KKNUoBuMOm+TPYvpj8+9FL+Dq45dBlb2OFWWUol1+ZVX7+LufOK9sOlYCrjmmbRl6
         f8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XCpzuH6l9uwERwbmApSAocGpO1WUQ+kJaH+BaZZ4Pgk=;
        b=ZjGutgFI8COEKjwTXtKUendYXeCMQYcqPZ5u19ZfeYv9s7AiFotDuGYNYQ2RhqDxPl
         BHhJSWME86+mzLEj564Wfj6+JWAcYaNUgi7whW3w/O3zEHDLgm2fbWxiAYs4ZVxkMAjA
         pJqtgTpgKB/g9pB9OA6Ywyj/3ddALGK73OHOgs8e5floUSJwqXbuZMuRp4fTLG5qcxOx
         JZ8bQTpHE7gi+i4bsOYB0/VbIO12+A0NCHp9OvhqQG3yLnd619pDmacew9WgWFDX2Is/
         lQIL3IU5FRBsLKLIoR67640Eo893K6HkH5mfpmfP5HBsK5JF6gKortwRoa6B1XplVeNb
         qqWg==
X-Gm-Message-State: ACgBeo0XOqCOIQWAdP7a8GPu4pgjdDbGirqkQcDg5Lu78AGpRWCcEkgx
        sLkXNYWsg76qTUhclteOzTYybg==
X-Google-Smtp-Source: AA6agR7kqkbFDwS3KArvaunAcNLIXhS1j02OhPXcOWC979/CGLTm+hr9z1H2bOvTyArfhByimnr6mw==
X-Received: by 2002:a05:6512:3fa9:b0:492:d799:1038 with SMTP id x41-20020a0565123fa900b00492d7991038mr7303081lfa.574.1662894765340;
        Sun, 11 Sep 2022 04:12:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:44 -0700 (PDT)
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
Subject: [PATCH 32/40] dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:52 +0200
Message-Id: <20220911111200.199182-33-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml      | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index 5147afc28721..8610f2701388 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -53,7 +53,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -113,7 +112,16 @@ patternProperties:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-1][0-9]|22[0-7])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

