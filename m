Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B0B5B5429
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiILGTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiILGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3DB2AC46
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn9so9325582ljb.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7otNZydIIUOO98pahjg4CEuB5+Fq5/uSk8VTmLsIpzU=;
        b=y1PkTbkfQaEwzE8pqTvXXEqqyqgNCrhlTm+WskqwrVRcHgZIYMYePo2scrKwo8Ecva
         LvDAC8NGymufgPa4qEORDD/Wrq5CrWBWa9E+oyAnQPx7MmmwGinLriWtg6V8WCOQQ3fl
         I2sKhg+kVac8Y5/tnJBTChOa8UrscNYu1O3nVa2hM6+iJ/Pt9EhIEtWL+T2MtBJaBaTX
         AQQA9ud55nUBZurgUa3xNwm/CLLgLej9tnvGgeKGG0MxkPPzXZD7RvD4vLXhVK6QSKlJ
         JbrvbYONCzrPcZD4dQroI+Jyg/ZyUW247d06MWkK+JpW5GecpmHirw37alQZmRSfS4YI
         fhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7otNZydIIUOO98pahjg4CEuB5+Fq5/uSk8VTmLsIpzU=;
        b=Duc296giqeSxhXhvIAbq8YAKbbLGcVwBogmdwQUb3wXRyUt97k6TL7ibUMYBRQ41iH
         7jlssL2exYbV3geWzlPS4EsxmptTLtJKSDiQ/NVVYQzO638pu0CwErwnIQw5d6c5fJkV
         926Ev7FTfA2E+3kjiUY8BzjjwgS35Bg9NkDImRsKpCfiUYLFVERP4AGSbmGIl+lGborn
         HA+lXdgzy2PStHqx9CaPbM5mjPxc5U/RI0Roxmn4L84/RjZIhnNP8nUN7j494GrzOzOr
         CZeuVyeYbz4Hl/2hB9k08VCU3CjeMwpfbwWf1MZapq/DWtolbWlRtaNwhF/1dA5UNNIA
         TmAQ==
X-Gm-Message-State: ACgBeo2gWjGVbG1PiKFt3g2SYOK2QQ7hV6pU1YHeiTCHtJR06IH2ZRBU
        utKmJTeXHewt+zYDDSjpDDoxBw==
X-Google-Smtp-Source: AA6agR5L+ws1m3zLWS/oH5Zrss/Tfueo4yhHwoEwx2izoi+tIo4sz1GHBrQ+L4BNJhVVth2dfNz0ow==
X-Received: by 2002:a2e:3817:0:b0:26a:d369:ca71 with SMTP id f23-20020a2e3817000000b0026ad369ca71mr6775219lja.191.1662963504669;
        Sun, 11 Sep 2022 23:18:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 24/40] dt-bindings: pinctrl: qcom,sc7280-pinctrl: do not require function on non-GPIOs
Date:   Mon, 12 Sep 2022 08:17:30 +0200
Message-Id: <20220912061746.6311-25-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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
index 76de3b1eb8c7..b12e738cabfa 100644
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

