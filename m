Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30B5E9AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiIZHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiIZHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:44:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13335AE6E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so9521406lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5TDwWZedP0ry9rwbVBeCh6jUuzx1Ug7/63kkGKiK+II=;
        b=A1/gSvpo5HPTey19JBc7p2sPnHeeDuX284GQl7iYi7DMCRpGIzjtyVJLb89stiDs3U
         kIGGxyWjLXb//IAXYEMr+1b0o69C25qBchV0mWjxd1vcKWZAqkIzs93K+d9ynkK9dQI+
         CQZVp5UXhQe98qtJX15FPTR4YJx78OyIU827BbQXtX39u7GZ4zY6xxMlvWGAkXj2brkZ
         iBWYaxPPoLwe3x8XOj5yQQipsCkG9aaiNf4cHVOeexng45ZOLDGtltrvDeGUT4jQ+T/e
         BfIESYcSJcnBIUM+zAZGvG7pJ6LYrN1stFb9tfZ1UFjvm4dhyskhF0nhfAaY1f5hveif
         mQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5TDwWZedP0ry9rwbVBeCh6jUuzx1Ug7/63kkGKiK+II=;
        b=GaL9Ewk7GnUuDIBUtXHwKqMkPzr1lNDTQRvBluA1xQyIImK+pO4v13WU3WHJufyJKy
         LxH1fgskHsiCg/tgyyBJ/hZp4eceHdhxfAfhIN75eLVTP9h5yuXioCPs2u7LNwx7KQ28
         SMpXAUKx3npI1VDU2xw9icfGJ0qMUk4rdcomaZ+v2WIZdEK7ZkHO02vS+ulCOo6T4x1T
         kJgCzmrR+R1EPCoTvPWnnLCxVe24KvDbGLgf2j/yA07fpJgyXSxcrL0iMssv33a4j2zJ
         Js44B+T5beVWeyFkxROYlhwTOiYWdZoEToi8UvR7f5SSocYQ6mBzDLWDheuMwJds9d6p
         v9bQ==
X-Gm-Message-State: ACrzQf06XvzzaYGPcNsEhuuvAdebKwhv9WzC0jRUv+gOXTjeWPjU3+8H
        gDV1SdC95UBJjovFHik6ML2rfQ==
X-Google-Smtp-Source: AMsMyM5z3MwZGzTlCuw5SA70Rq2CmJXDsCR7hnTZP/qB9YtqhasaiPaBcbF6iqxCpcpNG1/1lz3EWw==
X-Received: by 2002:a05:6512:2586:b0:4a0:54f2:772e with SMTP id bf6-20020a056512258600b004a054f2772emr5867602lfb.663.1664178278335;
        Mon, 26 Sep 2022 00:44:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:44:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 07/33] dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
Date:   Mon, 26 Sep 2022 09:43:49 +0200
Message-Id: <20220926074415.53100-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain pins, like SDcard related, do not have functions and such should
not be required.  Add a check for this in common Qualcomm TLMM pin
controller schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index c88c8dcb69d9..e1354f0c64f8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -65,10 +65,6 @@ additionalProperties: true
 
 $defs:
   qcom-tlmm-state:
-    allOf:
-      - $ref: pincfg-node.yaml#
-      - $ref: pinmux-node.yaml#
-
     properties:
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -82,5 +78,21 @@ $defs:
       output-high: true
       output-low: true
 
+    allOf:
+      - $ref: pincfg-node.yaml#
+      - $ref: pinmux-node.yaml#
+
+      - if:
+          properties:
+            pins:
+              items:
+                pattern: "^gpio"
+        then:
+          required:
+            - function
+        else:
+          properties:
+            function: false
+
     additionalProperties: true
 ...
-- 
2.34.1

