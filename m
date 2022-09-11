Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C85B4DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIKLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiIKLMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:12:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F133420
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bt10so10405075lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=huMBt2cOX5WYiW0m7Bpoars+zfOhAPbHFngq8gou9wo=;
        b=gjjFGcTzNIJEpTozDwXlCSQu9pxjor0DOliAlVN4b3xO3s+BMl9gcVSKWAmyPezafe
         stShxSixpggf+L5Ut3/uAnnWPvHw2CVeUTtPWQC2lEhfZAZEj9+AZA0Oj0M7W2SxAaRN
         gwffL4xCb6oQI/13wC5i5HtgY3xpVlo5iWdlMxpOt9ajb2Np/fzwUBemzBo76Xjpm+3e
         FHMzR1Gwu/tywUBKZqePd3b/Ak+TBkAEXrsh3A4N72e7HdMEPX3zFjV2djtdKDrHScuP
         nKKBGJn/bWpLcj/A7qXa5ehbHCQOYvUtiaMyYhzISPh281JdnJ7TLUvJNXfkBDsiIuRH
         hAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=huMBt2cOX5WYiW0m7Bpoars+zfOhAPbHFngq8gou9wo=;
        b=ap0ldE9JKJwLu9a7eRd0ItDSY/+mwD9tOrT8EOqL358y+6STGKfq/3AluTsbSbwc9x
         xx6QlZYKTj4B765qmk7nJ/+sk7eK3ZUDEWWIBXRerYLqU4CPwbE3X2fBA6+wWi15UdF8
         sxp5Wkrd2WRHMcEy3h5HQ/Fe701otgyZLmvSKH1ZuwCKrFSI0UBXZTiuW0GvO0kaxUds
         i/Wgfmn/TlHtpAuQIPaPZ9ZRy8W6BIsNZu7dxogMJx//irhy8mUR5rgDG40uvMtkOguU
         OLgvbZ8jKDYwQ4Mgu3bFjgfu1wAjdEWuxDV1sCSXjwZf3xotAYT1Fj7EW/JKOj8+Mf8b
         BY1g==
X-Gm-Message-State: ACgBeo2b3p/l3qJQNKuNarQzW5atPRJ1KRfUsY812M0ozYH/dQ0g4SqX
        OLTkFVpDVjBOXTjIsaibnIUuOA==
X-Google-Smtp-Source: AA6agR6di+WIA1ch9u/rQZkDKXpzRSwuSZEtWBV8LhyTjERbH1hCrJWCet09H3Un6djVDYxi792y5w==
X-Received: by 2002:a05:6512:3403:b0:48c:9727:50b0 with SMTP id i3-20020a056512340300b0048c972750b0mr6898768lfr.309.1662894740977;
        Sun, 11 Sep 2022 04:12:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:20 -0700 (PDT)
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
Subject: [PATCH 13/40] dt-bindings: pinctrl: qcom,sm8250-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:33 +0200
Message-Id: <20220911111200.199182-14-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml          | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 15bb1018cf21..12bdc2e67c4d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -110,7 +110,15 @@ patternProperties:
 
       required:
         - pins
-        - function
+
+      allOf:
+        - if:
+            properties:
+              pins:
+                pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
+          then:
+            required:
+              - function
 
       additionalProperties: false
 
-- 
2.34.1

