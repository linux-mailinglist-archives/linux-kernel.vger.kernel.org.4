Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049EA5ECB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiI0RiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiI0Rht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:37:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D01D88C2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j16so16821029lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vNG4GFYOyMZYbc+jKx0tALJsbLNDTZON3pUsUF82eUM=;
        b=wxf0tbLQ6jIwn/jH0ZxPwoIGk8LSN1w/QHYQjJpUfjUX6fx5eWSn9rtCl/Z2O26ayB
         Xh5dENnTec8cxquS0p/u5B9/sQ3/ol+zFt25cWNHY9Gakafzb9iQsxFPAIRoGvgWxm+c
         yY1jxSwarX0xpUKWUlDuhc4pK5wdJPo5zRc6UHNWG8nvnGr/qJnu4AfrV6g//j7v0i1J
         WFVilfE8Nstw4MplqDTiP5uPD5rj1If2nGgJSKMGSU04Xd5GTqCxhMQ/h56jBykur71j
         ju6qQ3Jr42Jesen+0ZzcFNLkpTLC8uTnx9DE7yLqTWGm6wS8txwY/dIc/x0Ds/IlnvK+
         32FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vNG4GFYOyMZYbc+jKx0tALJsbLNDTZON3pUsUF82eUM=;
        b=Q4X/XcWM+GU9swFUZpKH+v/Ke38oOVumhgP7TdsFseWr3/4CESimGG7v1SdFVo65+W
         Xmd5lC+E0ublQx7Pxrm1YEsjU8CxhWl9fwAjmx4m6PdJxuoKaAgfRdMDdOrXTrZotdmf
         zJ/5EZeMr0GkRgIQg7Z7mFkDfxQZpOa+yZo4F5uMYxPRoiHvj149IvkkiDVTfiGy6tD8
         d6fQREY4BC0lMMZzxS/CwcWyDh5EzAJ+Kg2kF0oCLwQJB6EpvCIZSr+PFWwo854sRwyV
         DaDCOYEIyOAwldyyQns52W+4OV04aQxcoWj1CNCq7rJXtZdbBmvw42ydBG4CuTJPC3Q5
         ojVQ==
X-Gm-Message-State: ACrzQf0Zf9vB/FwvSap9STOBn/kP26+GSXT9JlHOmmKoo5mjbRSrsk23
        dVk4oPbrX8l/1ZhA4tc61QOmNg==
X-Google-Smtp-Source: AMsMyM7cSK0KTT3e52vosNnCkgmd3vFc1g8GePRWvtQ3WBE+YJxlZ1ES3MFXaGKHNwUQlFS93y2hNA==
X-Received: by 2002:ac2:4c30:0:b0:49f:53dc:324d with SMTP id u16-20020ac24c30000000b0049f53dc324dmr11961235lfq.395.1664300265372;
        Tue, 27 Sep 2022 10:37:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:42 -0700 (PDT)
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
Subject: [PATCH v3 07/34] dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
Date:   Tue, 27 Sep 2022 19:36:35 +0200
Message-Id: <20220927173702.5200-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

