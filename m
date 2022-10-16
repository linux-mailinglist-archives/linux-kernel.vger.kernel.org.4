Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A96001AA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJPRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJPRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:01:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A8399DD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z30so5415789qkz.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0qog3y6/pjQRMdLgI2wTjHB+zwmYy9wpugBMuJA3qs=;
        b=S2l1QZkwPPLd78+/YAMB53iEVSUZLee5wjy+1OGrOq/SMcUiBdeBstBh4hQ8ONivsc
         XipJSvPgmtrVjg/+gE1NDXf3Jp61FPF6DH6Nb4834W9pcBodQ3eY7mhOgwcsXw9SaOVC
         p3T3JOLivtNP6fWrkNSaP0bVlUnK9wONOOlTmQBc87eMKvM7riI1jatuyEofmKD9WtTW
         h2liQgz8iCyhfwy0ccVujw2TdLVEuU3VfuKtxM3e3QN8tkQv1tWBaW1Hcn5ozgJB6++n
         2ATbn7ZkdzooFyA7wN4TxdvWa0tXbfqIrQAjixS0I9hyuoV1mpmIJwibpVupQzJsxmOj
         jiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0qog3y6/pjQRMdLgI2wTjHB+zwmYy9wpugBMuJA3qs=;
        b=kU3wPyuByzd3U9vKbqqOqriXh9NiOAsnncqWd6lalmIvVn3FuZJSEAoxNr4Gt62YJv
         KlKcSDTCxRWkY7yq1xTFLEDSW3G0KsiXkW1MrAC9jnAxr6EJU4avCY0IIexh9FjK0jLF
         vkSVeBTmbF04FVCQGFi3EWkPaPCVMrV/NvlkZH0BauYqeo/GTqg+i8L8uEYHUyijceRi
         wTg2oUHxvGYI8Es3xunQ+CQEK2v/rgyNi8Y4WOrs+27UHAovKo968+KikqVeFkhvd6eq
         JNuiA28KTpUeq5OnUMzyuuP6KJNbt1Aug47U8Cfpr04HSB6qB+3dX3BEZvgg7NZ0ddSc
         gBuQ==
X-Gm-Message-State: ACrzQf0D0cxXYrtx8wustHqi6tAtIhgPhzUaxabksh9UELkF4CnXnrFH
        s3hASFbHmoRi7Sq56wlSxe1z+A==
X-Google-Smtp-Source: AMsMyM6MtCjQycs7nk7Y2Cj3Eozd1PZzqeVTiF3BMcX4ERUMeptvdy1JEhSONNP01z6Zu+TtfqBFcg==
X-Received: by 2002:a05:620a:4107:b0:6ee:ce95:1d15 with SMTP id j7-20020a05620a410700b006eece951d15mr5102309qko.266.1665939698601;
        Sun, 16 Oct 2022 10:01:38 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:36 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 07/34] dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
Date:   Sun, 16 Oct 2022 13:00:08 -0400
Message-Id: <20221016170035.35014-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
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

