Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F7D6D7A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjDEKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbjDEKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:48:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7711558F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:48:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s20so16520296ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680691718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjlBvbh3eaYQdMUrEcW9s95jBLrDwV6kOykUeIJwqFU=;
        b=O0Un5q8xa8eZEAV0HNXsomUkDQh2PLo3gU+WS5eAM7Q6JfyVLgD4ZwWF4bxpLJH7T3
         HemIheY1djbO+KnIKfvnhbGRLxAD6J2DG8cYF+xD5duGwweh9v1FlQBEQkWppa2SLpP8
         JYoV/W/oIcWwCeE/segxii9FnXawpxNUDSV1W9Qe2ZzaFcY2Uk93H1D90JrKqPwgLzoF
         Zu67hVbXLfaOzMdZEj3y02Yv7dSBJ/H1lqfX5hAUMY6BLIE2nDQsGudh3fgxFDLlNjWE
         atvPtXNIuzDrLIhAmaycrx38GTWG5RJkehBIcrI7ESjT2f3pJRjDLfnO9rkaLG61PUdO
         NQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjlBvbh3eaYQdMUrEcW9s95jBLrDwV6kOykUeIJwqFU=;
        b=0HoTe55HaTooDA5dRZhrFzKBqJ4pELCsTHMpl1SjK6bRMD4fKB/qG+tCbb9ILs1Kg0
         qh4IW/cUdIjWhEkHkC2jqSxm04Han0jd8JtH4OC/HXG5bCobAVHD8ftRovw8ToG3fYth
         VB1tXPTh4KeEEdpOhZpcIj/5203I9Jlmrc0ODbKoYeOVJyfml7OZCw55NkGu9ndDhhfm
         rP/sJOI2IPE4JjtSFVR3995BUVXoCLU9dbpFOn0BdnD17wmdIC2w2QgSQhaIH8OYUnfq
         kIro824rw6sWCVC+x2oOWJr+BL2xIwmIQXpS526tmqlqPEmRn8VX0X2PKxClFSO47WRe
         GSWg==
X-Gm-Message-State: AAQBX9cTVJAX6kW/ScO0hQivOMo9af21XiJHYNbvNchscnoydrUF4FrG
        IuIjTDkmK8Fby6x6OaS1KfJhgw==
X-Google-Smtp-Source: AKy350bdVUEFNr57PjDT6SWEHZQXvm3/rcWvHgODiBYoZ8YyxqMc3d59JioLMc0ssYPawDgwC2T53g==
X-Received: by 2002:a2e:7814:0:b0:29d:ce75:5d06 with SMTP id t20-20020a2e7814000000b0029dce755d06mr1802690ljc.32.1680691717969;
        Wed, 05 Apr 2023 03:48:37 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9b04000000b00295a3a64816sm2777299lji.2.2023.04.05.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:48:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 05 Apr 2023 12:48:34 +0200
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680691715; l=2113;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=R+nl9I6wuHXVSNu7ub0x4qWS9SfiNOhOzZJ7YrNBpgo=;
 b=nkKf8A9vZ3gv5c16oKZQlCBsfqwPAK9cloJD47Af9w4oLjF/q/kjJyT9Hl4zHElrEPnSKgSNhvrx
 izmgdvb9B9gxIw16BlNtjyjYEqwTaT7Nulq0JppAGtU2sjuLOcj/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
use 'reg' to point to the MPM's slice of Message RAM without cutting into
an already-defined RPM MSG RAM node used for GLINK and SMEM.

Document passing the register space as a slice of SRAM through the
qcom,rpm-msg-ram property. This also makes 'reg' deprecated.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
index 509d20c091af..61fc5b1b74dc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -29,6 +29,12 @@ properties:
     maxItems: 1
     description:
       Specifies the base address and size of vMPM registers in RPM MSG RAM.
+    deprecated: true
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the APSS MPM slice of the RPM Message RAM
 
   interrupts:
     maxItems: 1
@@ -64,23 +70,22 @@ properties:
 
 required:
   - compatible
-  - reg
   - interrupts
   - mboxes
   - interrupt-controller
   - '#interrupt-cells'
   - qcom,mpm-pin-count
   - qcom,mpm-pin-map
+  - qcom,rpm-msg-ram
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    mpm: interrupt-controller@45f01b8 {
+    mpm: interrupt-controller {
         compatible = "qcom,mpm";
         interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-        reg = <0x45f01b8 0x1000>;
         mboxes = <&apcs_glb 1>;
         interrupt-controller;
         #interrupt-cells = <2>;
@@ -93,4 +98,5 @@ examples:
                            <86 183>,
                            <90 260>,
                            <91 260>;
+        qcom,rpm-msg-ram = <&apss_mpm>;
     };

-- 
2.40.0

