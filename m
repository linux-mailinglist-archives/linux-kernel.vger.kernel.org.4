Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25820601D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJQXKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJQXKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:10:07 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC59410FC9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:09:55 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id v81so6095696vkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hGWVea2Q1JaZ/Dedm9+8nbJvnK1pk/GRHSmb3bzcTM=;
        b=mcfKh/yIqItJk6tysWdSSQOgSlOTDh4LyM1OfQ89A2KVRT0gzD+rTHaZNA173U0j05
         hb16KVxwOLgijoySDcgNl6u9NA8B0qcmg/zLPtdLX2NsOb9IVVZULlIAOcJ1SCB8jzvV
         540PSQANJrnae/3QkZt+X1lYwqw79JwlEupMxhKfNR4VUwh/pnQn4VnZfn++9rpaM+w9
         A3Taa8PnSaiP6qgur+tb3/G1b9CRfzpc5zRpbWJ4PuGwohYt43H+ZpQnj4z/Uo8PYOcJ
         QJGaY2FHZFEe5ALxHE5kRyoZqzjhqehKMmEKvr8Cqzp/oaDdRoE0fykPaBlfZbonE8HS
         W/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hGWVea2Q1JaZ/Dedm9+8nbJvnK1pk/GRHSmb3bzcTM=;
        b=umkGRmWaD6GCQcxsjCs/di8LzFlFpsB8qXy9ejaSer/IzlpHlluu9a/Em4Vfdmi8lm
         UQrbJvREjSOpZyij2p/NA8lhYrLlKYJUY3vnxR/JT1JaxjgZjDMbzRyTBCcdzC6VlR4B
         G8Btf35eCOasOdGaHDfCB7h+iElblb7ufLQwRYd9en68u8rQftN9QhQY/PCzv6igCCz5
         aoy5tdao080ff176PMEzKyZ8WJaBdZ3OVECRAAUTPMKaV3Ongf7RTcC0gMOL4XmGpU3L
         gsdN/dyx/Dn9/8aIdb+YnFPCFFl953h672jc/YfRvp0tr+5Uceby0s8/Khoik+nVwvCI
         bwtQ==
X-Gm-Message-State: ACrzQf1aAKdD+/wY/PBz7jw6J92oPnlzPgqvELW6S7gRVRQH7Z1V5B9u
        lBA37RJFjU7gOJSS6CpMoLNPlfqgwytu1g==
X-Google-Smtp-Source: AMsMyM5vnx5IFck087+EHdBTgJtKPgWd/BgGwOt5gSbpZOke7UrcJuW/OhcKI6Nx2E/OcUhHk4j7MA==
X-Received: by 2002:a0c:f349:0:b0:4b1:a0f5:4a2f with SMTP id e9-20020a0cf349000000b004b1a0f54a2fmr145329qvm.112.1666047696298;
        Mon, 17 Oct 2022 16:01:36 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:35 -0700 (PDT)
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
Subject: [PATCH v3 32/33] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
Date:   Mon, 17 Oct 2022 19:00:11 -0400
Message-Id: <20221017230012.47878-33-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml      | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
index c81fd74cde1a..01a0a4a40ba5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -4,15 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
+title: Qualcomm SM8450 SoC LPASS LPI TLMM
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8450 SoC.
 
 properties:
   compatible:
@@ -35,7 +34,7 @@ properties:
 
   gpio-controller: true
 
-  '#gpio-cells':
+  "#gpio-cells":
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
     const: 2
@@ -122,7 +121,7 @@ required:
   - clocks
   - clock-names
   - gpio-controller
-  - '#gpio-cells'
+  - "#gpio-cells"
   - gpio-ranges
 
 additionalProperties: false
-- 
2.34.1

