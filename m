Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD915FB956
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJKR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJKR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:26:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F7691B6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id de14so9380745qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWvSUtO1t5Yo44+0PDNHOUmm01FetjF9ArFB5CjIeY=;
        b=UG6ZF/60DpMDFHKiXUqnYVvGBt5jjFVc/VsSEb0aoveOLm395lm0/2rHfi6OtSE9KN
         TIj/i+QuDt/ml1NbhIYaze9bgaRsGPCGCrjVFLfSnOHe2dd76uY9V+ZmygwNvqe6B6QR
         1SfgkkZwMr4SK//lQw9aDXInrZtd8soWu7JIbEXF/Bf/lgmtkpLe2y2VUUvytyfIupJu
         JLMUGkjdhnd8cBJAt8gtl7whS8+XsYRdakhY033dRmCWbuuZyYNCylS18qqUdyCnH0h2
         l78znyM6uKM7xuZwHFjPa5q0yXh5lj25CtB/cBmj4Xh2mM/5Wb3gjCI+x6CZDVb3cNxW
         truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJWvSUtO1t5Yo44+0PDNHOUmm01FetjF9ArFB5CjIeY=;
        b=OPwyI2dN+f4++ZNY4GzNLKbpnt7dRp8Iwpd7UDzQzgd3Y836myqG4lwSVcn9bkVdpI
         /v28Rx8dlexbP7sfc+Db1lDbmpDdRrEXa3HU5KOGekFb322naFBdPoNELGwXsYI9AIrp
         eusTatlrmNUTSu9wc1qvDD89C0O9ZC+xONYAty1YSBy0RYSM04inPGju+ELGCW3eSFg5
         Po2Hz5ED0ZzmqVyR1MchXZ/kixfjcc+i8/FMWtSxNGS7peNr6mHjfPq7K9MdwVmu4IJS
         uPvZy1VA91OMZ1HrW3kH5vCez/4Oay6DZ4TIaQ8oLnK3pMJ9nbME0baJ1oqiepl9bolE
         cUOg==
X-Gm-Message-State: ACrzQf1ZN8mHW4SoqLeoY1nbiwwlVkT+BSgDzbBz+dR69JjVT5vtCKH6
        NFG9TPF+3Ft7cp0sBsFwU3KK9Q==
X-Google-Smtp-Source: AMsMyM6IkoDPiH1CkCrH+QG9B7FE05z/2J8gS8zz8ggm8E8+kOdn1TIEL13d2sdOzgE7ejg4NgUgyA==
X-Received: by 2002:a05:6214:252e:b0:4b1:9859:b74a with SMTP id gg14-20020a056214252e00b004b19859b74amr20047433qvb.87.1665509183795;
        Tue, 11 Oct 2022 10:26:23 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 12/34] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TLMM
Date:   Tue, 11 Oct 2022 13:23:36 -0400
Message-Id: <20221011172358.69043-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 8320e5ff17b9..4482625b6b1f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -119,16 +120,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-6])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

