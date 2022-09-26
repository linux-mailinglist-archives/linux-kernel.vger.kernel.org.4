Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116585E9B32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiIZHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiIZHr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35546386A4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t16so2427293ljh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tiszVZ3U+sZrmN+IVbNNI+6tb1bLHF50MwuU9g23DF8=;
        b=xyIVUuKOVU2ZpHNkNgyounLujMhGA91TAod9uhTeZ4mvlZzIgujT9n0QkR58NOE/UY
         klDlYRC5qPsT+uqeSjXOhjyftoh1GSURXzwTJCuAUcmy5ormLr5/88p+h5Z9fTpo+Tfi
         4UBUzmU9a8EbUxejQZGcUu5SoG2LjseJMjUEauBWBUIX15Zdd3AJ9/FJ57q/DQSA8T9o
         0wsLqcICA5Dh7Ke4d5RnQk7py8p7NjcieTbgkQgDRpuXyn+FRVtVAZWCbxEr3Qq2hNPF
         uh4wPUwoegvdniSCGH89q371BzaN9Mk0WHGQeZyWG4y6EcnJXrpNlqstSU0fv5DFM7E/
         ihjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tiszVZ3U+sZrmN+IVbNNI+6tb1bLHF50MwuU9g23DF8=;
        b=KRiOxML94WMN84ONjF90A7uqty9dxLMWAPiI9nLwRUhGcmF8WZWEij0FFczJMY30x7
         qIQrxyGYn00ppcthXpXYD91hztremaFYzBAV/XTzUtITHQoR/Vt9xC/rouiHXmQur0qx
         Mzkraf2mqqkWU6PldobhdgqM+B9afY156JJTHNDQW5wHwoNdSu+ZlMl/wNkwfCRnwBBW
         wVMTU93fKJC/dGtP1Wqpr3rkfafv49zc4+SvxQ0SUkqsUx28iWrAHH3V2he4TfjwMI05
         8YOSIYFGXj3Po0Xp4ss0nF/Q0rSRU2VKOPf91uWyIezeJyFrthwEZOxJmmq3k8pmxBnq
         oHeA==
X-Gm-Message-State: ACrzQf39zMXSuL26dh5ktRQZQGr2gEbbQ5NjUuRITdFQ8IOUgzMEZJ97
        T5a3UME/4KQAPGCOWulTKqZrQQ==
X-Google-Smtp-Source: AMsMyM5R6qhIiL0bGczSL52FiNyrrh35Rq6RB8M0PjiOc/WRWqbtNRt/J9omJ+XS8QB3cqM+4lm2GQ==
X-Received: by 2002:a2e:3206:0:b0:26c:814e:a7d5 with SMTP id y6-20020a2e3206000000b0026c814ea7d5mr3976802ljy.522.1664178319273;
        Mon, 26 Sep 2022 00:45:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:18 -0700 (PDT)
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
Subject: [PATCH v2 28/33] dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
Date:   Mon, 26 Sep 2022 09:44:10 +0200
Message-Id: <20220926074415.53100-29-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring other
regular schemas and additional checks, like function required only for
GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index fff57abf4fbc..52b7a557f452 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -60,7 +60,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -122,12 +122,11 @@ $defs:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
-- 
2.34.1

