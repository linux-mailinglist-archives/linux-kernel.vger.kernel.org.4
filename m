Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138A633847
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiKVJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiKVJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:23:53 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC83FB9C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:23:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so22656582lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0c8F3pQnElMN2xHZ1SlYuM5B9Kk5rY/ZkP6nm5e5lc=;
        b=G51+QcNUVp8RdBw9DUif1oIad+gpYHbOn3VC/yZxItAe/z11obzxzv7FiExZRijbbv
         +2pNbImieqLa2Q0zTYf6R93bsQih8yWPqAGTMRtkx9h8oDAySoW09w6SabpGnjzFQbUb
         5BGW9VpfT57c99xjjuRxTeMP9Nt0bg8q4Esk0lMml1CDsKYD4z2wrZ8AJLYKxazAiJAq
         DsqxDh8FWo3yh7tBkMIwEWvCmsvpvbEydbPDWgt0tiSw+Zd0hVlpp6aljXbXH6DPSApK
         S/vqslIKIJmqr6NBymTRaDrN6fo6n8cYi8KACxcgIDConsENDlhMZI3kjYl8By4Tbjz5
         x69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0c8F3pQnElMN2xHZ1SlYuM5B9Kk5rY/ZkP6nm5e5lc=;
        b=5TYkZuF5qzRDsOT3ULFueu+QICNCatwnaUGvrUszVi0QndE/4F0C87Y5VOe4DfVoll
         7FIv0jpZnpghj5EMth71urV78mjUpeE8fZJmQpU85icuFjATyWdyCf9qoABBfztQgHdS
         DqA9pe7CYhf7w++CA2aC/GL0K0UcwVcEhaBd2cZT5PwopuPW08sp0T9uEWABUgpu9Ftu
         wOxrbQsfGMcBvsHbo8t+Vl7nOBYs4xbtqjWZfhYWUVMc2XpsAsBssV1QcLP1bI5U/BND
         vGY8QXnafTz0v+PMzfbnslRydLzPsbcKd5qF/eBFv6LqN4LvwKrbaWbt82Mm5+HnAInj
         Ay1g==
X-Gm-Message-State: ANoB5plm0KHbi7D10eh7AWJVMqQxyiqkpEbDFGkLnQuc3YoYp+ePIkdh
        MLYKbfI/tywiiwpLJAC75In3eQ==
X-Google-Smtp-Source: AA0mqf5AdJrX8WFVMBoVFTGinA3SdZzsjZQoovSzg0Up+RVmfUzWNY4fnyc8t+WkuDD21nhoSaBqNg==
X-Received: by 2002:ac2:5e7a:0:b0:4a2:6238:e7f9 with SMTP id a26-20020ac25e7a000000b004a26238e7f9mr7285472lfr.294.1669109030754;
        Tue, 22 Nov 2022 01:23:50 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id br31-20020a056512401f00b004b1a5086485sm2405609lfb.2.2022.11.22.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:23:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 2/2] dt-bindings: firmware: qcom,scm: narrow clocks and interconnects
Date:   Tue, 22 Nov 2022 10:23:45 +0100
Message-Id: <20221122092345.44369-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
References: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCM has clock inputs and interconnects only on some of the SoCs, so
disallow them inb other cases, which makes the binding stricter.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Melody Olvera <quic_molvera@quicinc.com>
---
 .../bindings/firmware/qcom,scm.yaml           | 44 ++++++++++++++++---
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index fc986f2f5d30..8e6e9ebb343d 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -82,6 +82,32 @@ properties:
     description: TCSR hardware block
 
 allOf:
+  # Clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,scm-apq8064
+              - qcom,scm-apq8084
+              - qcom,scm-mdm9607
+              - qcom,scm-msm8226
+              - qcom,scm-msm8660
+              - qcom,scm-msm8916
+              - qcom,scm-msm8953
+              - qcom,scm-msm8960
+              - qcom,scm-msm8974
+              - qcom,scm-msm8976
+              - qcom,scm-sm6375
+    then:
+      required:
+        - clocks
+        - clock-names
+    else:
+      properties:
+        clock-names: false
+        clocks: false
+
   - if:
       properties:
         compatible:
@@ -100,10 +126,6 @@ allOf:
         clocks:
           maxItems: 1
 
-      required:
-        - clocks
-        - clock-names
-
   - if:
       properties:
         compatible:
@@ -128,9 +150,17 @@ allOf:
           minItems: 3
           maxItems: 3
 
-      required:
-        - clocks
-        - clock-names
+  # Interconnects
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,scm-sm8450
+    then:
+      properties:
+        interconnects: false
 
 required:
   - compatible
-- 
2.34.1

