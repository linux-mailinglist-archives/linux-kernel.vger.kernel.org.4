Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC5656CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiL0Qby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiL0Qbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:31:44 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3432FCA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:31:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bt23so3609202lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72cmjE0V7BUxC28t/DNBJowrN2/6PZnCNzCr8N7zUBI=;
        b=NbHvojsrG4KTDx9OBuOv4eb0KqhmLcbXkFP/iqhlN3OVTGkCaq0cWQ4jMpkhcK63Zp
         PmZkTs8M36h3rKdR7cK8P69gAiI0hXs4lj9IA4LsAJHoyeD65U35aJ1Ffv9H7CHlZOVh
         Gld9v2SH9QS+6kO7lwGFcDpO9nNfulZWMwZAJt90TNOY8BVHTIrjkN+igQKO/cFLtvwp
         +n2PaWEUVwv4hBmiw9ncVsD4bJnJLy94IJsjLhz3S9EHpUAUHQiDe+z+hoUhvMUH3D+o
         1ZB7JqL7yARj2SwLMSuthMBQwTsqGmH2YdyYUgQKEAEny+LPMlmku6gPPU3nn8jJHqft
         /HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72cmjE0V7BUxC28t/DNBJowrN2/6PZnCNzCr8N7zUBI=;
        b=Og9h1rgiB+YGZKiEuzmc4Kdv84yttRcmmM0n6bNpFogI+2VTfbFHNPQDvFOnRVgQRM
         5jhAh5reUc896WEeBMJ8cVRN4/zH6k0RujVVpMXhUxTjyIISfUlvAnFe6LtkiDS655mW
         ykSIDNiAVAh4IVTjSaCFWsI8j/yEddPogC25NTRsfejsYVMyEGi21woBOZpee9aK088s
         DFM+X5B9bvG1n4iOTdeq3ENM6C0aeAS/7N8nJGeyhx2zoFvxcgAJA/YoTu8KLmdObqPJ
         fCG2rvRNZP9uFXhyWohhd6C/JY4iwHjsh28DT4tfE934XWf2g0iVM5jlN+40cH6Mk8UD
         OZHQ==
X-Gm-Message-State: AFqh2kpNctGC2JDNJfO0QpOUYCetOqQ3ohBx/4/fhB4hjKjKL39U0AP3
        gekNZxU9fTkQXngO8Uq0sDSUVg==
X-Google-Smtp-Source: AMrXdXurCVsOysDqPyuiNeCz8zEeNtL+8/Od7Vrp0R3PwtkTV5Cby6lOIAcerYnQcAMYUDfSKqgvPw==
X-Received: by 2002:a05:6512:2316:b0:4b0:6023:6f6f with SMTP id o22-20020a056512231600b004b060236f6fmr7739080lfu.57.1672158700907;
        Tue, 27 Dec 2022 08:31:40 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512348900b004a46a9cebe2sm2318019lfr.289.2022.12.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 08:31:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: dt-bindings: qcom,lpass-cpu: Correct and constrain clocks, interrupts, reg
Date:   Tue, 27 Dec 2022 17:31:35 +0100
Message-Id: <20221227163135.102559-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
References: <20221227163135.102559-1-krzysztof.kozlowski@linaro.org>
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

The binding allowed multiple variations and number of
reg/interrupts/clocks properties for SC7180 and SC7280.  Maybe this was
done for different use-cases of LPASS CPU audio node, but DTS is
supposed to be a complete picture of the hardware.  The upstreamed
SC7180 and SC7280 DTSes contain the widest set of these
reg/interrupts/clocks, sometimes being even sum of these different
variations.

Correct and narrow the reg, interrupts and clocks to match existing DTS:

  sc7280-herobrine-evoker-lte.dtb: audio@3987000: clock-names: 'oneOf' conditional failed, one must be fixed:
    ['aon_cc_audio_hm_h', 'audio_cc_ext_mclk0', 'core_cc_sysnoc_mport_core', 'core_cc_ext_if0_ibit', 'core_cc_ext_if1_ibit',
     'audio_cc_codec_mem', 'audio_cc_codec_mem0', 'audio_cc_codec_mem1', 'audio_cc_codec_mem2', 'aon_cc_va_mem0'] is too long
    'core_cc_sysnoc_mport_core' was expected
    'audio_cc_codec_mem' was expected
    'audio_cc_codec_mem0' was expected
    'audio_cc_codec_mem1' was expected
    'audio_cc_codec_mem2' was expected
    'aon_cc_va_mem0' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,lpass-cpu.yaml        | 131 +++++++++---------
 1 file changed, 62 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
index 16248629f659..6cc8f86c7531 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
@@ -35,7 +35,7 @@ properties:
 
   clocks:
     minItems: 3
-    maxItems: 7
+    maxItems: 10
 
   clock-names:
     minItems: 1
@@ -124,6 +124,8 @@ allOf:
 
     then:
       properties:
+        clocks:
+          maxItems: 3
         clock-names:
           items:
             - const: ahbix-clk
@@ -138,6 +140,9 @@ allOf:
 
     then:
       properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
         clock-names:
           items:
             - const: ahbix-clk
@@ -156,33 +161,31 @@ allOf:
 
     then:
       properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
         clock-names:
-          oneOf:
-            - items:   #for I2S
-                - const: pcnoc-sway-clk
-                - const: audio-core
-                - const: mclk0
-                - const: pcnoc-mport-clk
-                - const: mi2s-bit-clk0
-                - const: mi2s-bit-clk1
-            - items:   #for HDMI
-                - const: pcnoc-sway-clk
-                - const: audio-core
-                - const: pcnoc-mport-clk
+          items:
+            - const: pcnoc-sway-clk
+            - const: audio-core
+            - const: mclk0
+            - const: pcnoc-mport-clk
+            - const: mi2s-bit-clk0
+            - const: mi2s-bit-clk1
+        reg:
+          minItems: 2
+          maxItems: 2
         reg-names:
-          anyOf:
-            - items:   #for I2S
-                - const: lpass-lpaif
-            - items:   #for I2S and HDMI
-                - const: lpass-hdmiif
-                - const: lpass-lpaif
+          items:
+            - const: lpass-hdmiif
+            - const: lpass-lpaif
+        interrupts:
+          minItems: 2
+          maxItems: 2
         interrupt-names:
-          anyOf:
-            - items:   #for I2S
-                - const: lpass-irq-lpaif
-            - items:   #for I2S and HDMI
-                - const: lpass-irq-lpaif
-                - const: lpass-irq-hdmi
+          items:
+            - const: lpass-irq-lpaif
+            - const: lpass-irq-hdmi
       required:
         - iommus
         - power-domains
@@ -195,54 +198,44 @@ allOf:
 
     then:
       properties:
+        clocks:
+          minItems: 10
+          maxItems: 10
         clock-names:
-          oneOf:
-            - items:   #for I2S
-                - const: aon_cc_audio_hm_h
-                - const: audio_cc_ext_mclk0
-                - const: core_cc_sysnoc_mport_core
-                - const: core_cc_ext_if0_ibit
-                - const: core_cc_ext_if1_ibit
-            - items:   #for Soundwire
-                - const: aon_cc_audio_hm_h
-                - const: audio_cc_codec_mem
-                - const: audio_cc_codec_mem0
-                - const: audio_cc_codec_mem1
-                - const: audio_cc_codec_mem2
-                - const: aon_cc_va_mem0
-            - items:   #for HDMI
-                - const: core_cc_sysnoc_mport_core
-
+          items:
+            - const: aon_cc_audio_hm_h
+            - const: audio_cc_ext_mclk0
+            - const: core_cc_sysnoc_mport_core
+            - const: core_cc_ext_if0_ibit
+            - const: core_cc_ext_if1_ibit
+            - const: audio_cc_codec_mem
+            - const: audio_cc_codec_mem0
+            - const: audio_cc_codec_mem1
+            - const: audio_cc_codec_mem2
+            - const: aon_cc_va_mem0
+        reg:
+          minItems: 6
+          maxItems: 6
         reg-names:
-          anyOf:
-            - items:   #for I2S
-                - const: lpass-lpaif
-            - items:   #for I2S and HDMI
-                - const: lpass-hdmiif
-                - const: lpass-lpaif
-            - items:   #for I2S, soundwire and HDMI
-                - const: lpass-hdmiif
-                - const: lpass-lpaif
-                - const: lpass-rxtx-cdc-dma-lpm
-                - const: lpass-rxtx-lpaif
-                - const: lpass-va-lpaif
-                - const: lpass-va-cdc-dma-lpm
+          items:
+            - const: lpass-hdmiif
+            - const: lpass-lpaif
+            - const: lpass-rxtx-cdc-dma-lpm
+            - const: lpass-rxtx-lpaif
+            - const: lpass-va-lpaif
+            - const: lpass-va-cdc-dma-lpm
+        interrupts:
+          minItems: 4
+          maxItems: 4
         interrupt-names:
-          anyOf:
-            - items:   #for I2S
-                - const: lpass-irq-lpaif
-            - items:   #for I2S and HDMI
-                - const: lpass-irq-lpaif
-                - const: lpass-irq-hdmi
-            - items:   #for I2S, soundwire and HDMI
-                - const: lpass-irq-lpaif
-                - const: lpass-irq-hdmi
-                - const: lpass-irq-vaif
-                - const: lpass-irq-rxtxif
+          items:
+            - const: lpass-irq-lpaif
+            - const: lpass-irq-hdmi
+            - const: lpass-irq-vaif
+            - const: lpass-irq-rxtxif
         power-domain-names:
-          allOf:
-            - items:
-                - const: lcx
+          items:
+            - const: lcx
 
       required:
         - iommus
-- 
2.34.1

