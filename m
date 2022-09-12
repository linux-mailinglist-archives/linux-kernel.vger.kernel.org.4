Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0875B53E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiILGSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiILGSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:02 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0AD2655D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v6so9372662ljj.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vyYamw1Du4HV9eH+g+rE4fAB7iezBD0VnqsswMEZh9Q=;
        b=OMp8EudE35YyzNGuCOAeWC5WjdioYM252RuRUFtRRdYynw6J1BBqWiYPEsWt0+FPUj
         M49nt1W2kDIRmNE30QLul3sMweSnC1Pryl8QRXnMDx9CRYVEbdO25JbtbhMt6n75bpPv
         TKpKrO/2m5eBEn3fYF+TyMEBXCSLYpkfCrYFGWld0R7oXpWV4qbShAC5FNrpKZYlmOcQ
         u+MzhKiSMFMXj4xGLmhO4xXND1soJIx01JMcBXMOrgk+PQ1ANQUN8tVb9p87/Tel+WME
         XEjDA5DSuc2WH0NIcOFpMGOjXmO+5H0CiMCgcDxQrWAO1tvg2/n0zuwPfk1xytg2M2Zk
         MEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vyYamw1Du4HV9eH+g+rE4fAB7iezBD0VnqsswMEZh9Q=;
        b=COnzcFcAa5A6zhlebQRcGO1e7KMw4HRxyZuevCk2tTvqYa0PfpAY+CCgLyMgQj59J3
         4uccvocCbGXEXs10Znr1ztgNGVaXJ3qszrwRyOdvHPTXYLGvovykP2yNMQgzdmEwi/Ib
         Epq75upqW74yiaRlUXutcCsZ+JQxBZ/4NW0t4OJ2l3WWhNkkRs4VC56Dpj2+fwZz8fGR
         fzxrN/scTzNs5cLZVkTjUI/t6bhfTPIfVxih9FdbmkVNzbcBRKDWh7c2IGpOeVTskwDD
         x4eyN0uYMsE2I9Trqlb4t3SuDL3y173Wp0iUXMkwaW/Ca6hUHhqwUDc9XqMFvq20a2/R
         FVSg==
X-Gm-Message-State: ACgBeo3hljVYJRNpDvHIcrE3PbGtvoCXqZQSmRSgRz3yt1REav6RAo9P
        /yr9YlbsBNHoABtEhNWQFYqNNUsd8o831A==
X-Google-Smtp-Source: AA6agR6zRnH0MEqYlMZz4QKOqoGTt9It9V5BpYycR4WeATh2oNCyf5EySkBoW8N2AOkwOV8LKEpDcQ==
X-Received: by 2002:a05:651c:2205:b0:25f:dda5:1e65 with SMTP id y5-20020a05651c220500b0025fdda51e65mr7827812ljq.240.1662963477269;
        Sun, 11 Sep 2022 23:17:57 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:17:56 -0700 (PDT)
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
Subject: [PATCH v2 02/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: require function on GPIOs
Date:   Mon, 12 Sep 2022 08:17:08 +0200
Message-Id: <20220912061746.6311-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

Require function on GPIOs (so not on SD card pins).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml         | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index 8a2b4767c7b6..28b29bf714b4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -69,7 +69,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -121,6 +120,16 @@ patternProperties:
     required:
       - pins
 
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-2])$"
+        then:
+          required:
+            - function
+
     additionalProperties: false
 
 allOf:
-- 
2.34.1

