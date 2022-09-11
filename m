Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9615B4DE5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIKLNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiIKLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4333E34
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k10so10370083lfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BZ9D0FRQE2grk03g+mdXjEXzyihdHpyqrjbkROOcsv4=;
        b=Uq+Waa+MOIP9pYf+FiYpnLRgnmgR/SfA/kJzGTRDaGZVDZUjhCBA94ITxnluyrTt4U
         JjIZGF2eBuwfGJeS3BeYTXDcio+S75AmvGwQjxEiTrfvflvygITINWCBp7lNp3a5Llla
         TbfgQvMRX63u6qitw8QQZWT5fr/73f9YCKD5kTUgKdHK4AULMLrG8B6XKwWo3ii7m+yx
         QhOV7EDmjfAPBbXwB58zr8YEWUzTvHSOf5MsA1X6m1Ij90yuNCF4BaPkC7LmIuUxiplm
         dakJKP1fbaM/U1G7k90vJfm4GviIMO1HxvacqSKc1gn0mJycv3PvMXVAWBEjPZr87+zw
         CP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BZ9D0FRQE2grk03g+mdXjEXzyihdHpyqrjbkROOcsv4=;
        b=AOeGZpoH3EfBbppzIDO6amfWS58xjQFbdjC/0e6DJP7PLQ1ynnm5u+21M7SW0uvhEe
         373y9Au9XhVAXpMy8kwEEuWNSn3P/G9OSPoxVXEorTfKifjaBT140LdhMcUUDmoNK4Lb
         v9A06SWuJ0F3vgj46y3iF58v0IN1grJ6vJq/GsuegVMB7jEIr8U1Fqkdcss3k2N5qgRR
         HG/W1s3BGydX+NFDhrOjgmaE/p0hKWwa0inj3a5CceqTdIypqGcXswkt/bFxMabsjJOI
         TJfsCEm1usqFpIrZTPqrOumbWbRq85v36NjeDNF7Jm0StcWckHB8FAR4HATaRwaEPFHu
         bKIw==
X-Gm-Message-State: ACgBeo0gZ0Q6UimzrYE9oZ57XnbvC+sfkX6Y929O/yAuhisDvcHZ4WxK
        u0mxTfRGg2rWHYBoFA9oKYakaw==
X-Google-Smtp-Source: AA6agR75xSzW2FO1RR+w4Xef54cJTvNyPsu/Jhldn59qzhVCOmobsJSeB//MjmmWzRRGlhCxkA1O3Q==
X-Received: by 2002:a05:6512:31c4:b0:49a:a463:51ab with SMTP id j4-20020a05651231c400b0049aa46351abmr394253lfe.12.1662894747400;
        Sun, 11 Sep 2022 04:12:27 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:26 -0700 (PDT)
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
Subject: [PATCH 18/40] dt-bindings: pinctrl: qcom,sm8350-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:38 +0200
Message-Id: <20220911111200.199182-19-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml        | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
index f3106d25adcf..6ae5571f60da 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
@@ -54,7 +54,6 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -108,7 +107,16 @@ $defs:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-3])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

