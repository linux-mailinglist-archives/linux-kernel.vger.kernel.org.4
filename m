Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900D85B4DFD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiIKLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIKLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099EB32BBA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w8so10344166lft.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VjyXZG5WEWMmFKlfVnHeZRcue/3s1E0AVQ/ZTDMMIro=;
        b=VcZLlKfWfGvOgDWeCjGT5u4JPbqgGrFS9XabUJP6NCC2hK9TYQzhJM0iMhw7ykDDB7
         Rqp/YybXIE30dGIuRCzm/DeBMLPVYjLb7zXGzBD1aWu0teTjFokjOPfDWZCUTnD/697D
         ZvCqfSXponcmK9K+WvPPozBB8+LwtHPz7/CMEkAqxWphycl1OdqS/U3oqmB8Tbp4Deoa
         Nfmpos3izoN7WqM9mVqz3YkdfCohwJhC3qs2wM1kq7zimL89SchA+oLgCKcG62zxR6lm
         mkthYnnrhkrIZgtOQgRD4k9auoTxts/BKnTbJ+WLtVZKoDCFyUMNV54De9CVf3c5Kf0T
         Xjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VjyXZG5WEWMmFKlfVnHeZRcue/3s1E0AVQ/ZTDMMIro=;
        b=vQKz69sgJNPOmrnf1SESyG/nu9B7X1bPoa9yBSy/iuw21jeuuFXnysqtHL1hoGCI2U
         gcps3aAIi/QVPwNCQs2ix57B+mBhWXquPNiEiKgoxQTLuKNjN3athxFe5Cm390EBGTDu
         nF1es2cZFViBUuw8k8MZUk+l5LUxbETJs+YeG/4/hAUVGCjGhLd+z6ORD6o7QHdlnjFk
         I/JSDivfAsKq5BvjM1C0VxZGSAKXwyqKt+tfH+scCoyZeoshYNnF7dTL67WE8Sy2k+6r
         55ygGNxRmZAGDsSAe57gqt7pJAmF17r++T7aeEBAEsD+pKp3l+o63sTr63MQZ+uFnDAa
         43Iw==
X-Gm-Message-State: ACgBeo36JSGmTOkxUc+0n8uB3dcmviouG0uj4wuGjNEtj1xgdwnoRa6J
        4TrhKD6ig+zbRCuX8obybzmdKw==
X-Google-Smtp-Source: AA6agR6aZKdkJKzOG8y3SYo6qdQpTLkkBQ5gAzMlZEfZihhcjRLLfdtUvnYhbH+18I84CCtUBtNAag==
X-Received: by 2002:a05:6512:3fa8:b0:492:d80a:e54a with SMTP id x40-20020a0565123fa800b00492d80ae54amr6920958lfa.173.1662894756232;
        Sun, 11 Sep 2022 04:12:36 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:35 -0700 (PDT)
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
Subject: [PATCH 24/40] dt-bindings: pinctrl: qcom,sc7280-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:44 +0200
Message-Id: <20220911111200.199182-25-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml        | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index f948a7f30f6a..9bd5fbdde9a2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -51,7 +51,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
 
     properties:
       pins:
@@ -118,7 +117,16 @@ patternProperties:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: /schemas/pinctrl/pincfg-node.yaml
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

