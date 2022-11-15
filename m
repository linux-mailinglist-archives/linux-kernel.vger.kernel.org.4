Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACA6297FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiKOMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiKOMCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:02:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915061D0F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id be13so24089930lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0wP3pJrxOd4FjAX8XSZyGxgmfCQJkYV5Ck9FfoWKRI=;
        b=JPZ0fHXec/ZF/rA3HkGmGyehGPHZM9rbEoGqsffUFGeQMmXp3Ney2ECVlRBTTvF/y8
         +pNosN+QkbcBiSkN0rrBSyQm1+/aZ/Br74oxuIc7jpzoJmYpYifSyt/yRKa6+Scl9S3i
         l7+N7WnlJjjGqEHO10JkXKCo/o6X92wzYX2FRxZLf2O7+DlaOHsLUHWA+XoD+Jqtd69k
         lmmhz9hfz0Wee5smnR1Hgk8N78hQymSXnzbFfPWPBpOiQDlBbbOmHW2icdjsB1TKw11B
         9eBeKB8IweOHAVAbbV9NJm2Vr3/BUddEON8gInLRZY8EeFhhlIb87NLlPU4v7HnQivBF
         mw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0wP3pJrxOd4FjAX8XSZyGxgmfCQJkYV5Ck9FfoWKRI=;
        b=te7m0QZdO5Q4kasNIeiM5r/icxjwUp9LhFSwu657zX7Hp1aF6dXvmRLfkU1igIcK6Z
         JM5DHFiC/t2Jo5budX2aMOUeCE1iDIT8HqcbDJbzuCTrNsnfnsdjx90XBZPlZBEFINtk
         kuxPQUmy/foD9B19wR8qzfaGtxWO0fzUIX/l60KOP6Np6Oi0z8nHwJ2STHWKdOQahMCZ
         tOYMj5mp6sB81KjvTDkiKLD/7f4gXmR/vIfyCyHKP23RxBWOvbQAETz/qknGEbh+hg6e
         1QYdAMmcs5uTXGUuTIFjVnyatq2fJLkhXeThTvx0I9rKiOVUuARF+gYfLjU1JHW0uwlV
         1D8g==
X-Gm-Message-State: ANoB5pm4DeMK2Li02wUw9HAu8FPZvz7Ry1THXLbx7cu8xu0Fl7319i5z
        5xYsIwE7IONBU7hfTAK7tHz+B9eDKWAMDosv
X-Google-Smtp-Source: AA0mqf5UI7DsIxp+KqIgTlBJuKyeNzWpW0asfBEJr2NReqjc3Tg+JWNZjnnWBNyOhqneIvVMq6Raig==
X-Received: by 2002:ac2:58d5:0:b0:4a6:4e24:b2dc with SMTP id u21-20020ac258d5000000b004a64e24b2dcmr6403652lfo.456.1668513767694;
        Tue, 15 Nov 2022 04:02:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm2176233lfb.121.2022.11.15.04.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:02:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        quic_srivasam@quicinc.com, quic_plai@quicinc.com
Subject: [PATCH v2 03/11] ASoC: dt-bindings: qcom,apr: Correct and extend example
Date:   Tue, 15 Nov 2022 13:02:27 +0100
Message-Id: <20221115120235.167812-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
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

Correct the APR/GPR example:
1. Use consistent 4-space indentation,
2. Add required properties to services nodes, so the binding check
   passes once schema for these services is improved,
3. Add few other properties as APR/GPR is part of a GLINK edge:
   qcom,glink-channels and qcom,intents.
4. Drop unnecessary services, to make the example compact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch.

Cc: quic_srivasam@quicinc.com
Cc: quic_plai@quicinc.com
---
 .../bindings/soc/qcom/qcom,apr.yaml           | 61 ++++++++++++-------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
index 1fab1d9a2dad..4209c6314996 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
@@ -142,31 +142,35 @@ examples:
     apr {
         compatible = "qcom,apr-v2";
         qcom,domain = <APR_DOMAIN_ADSP>;
+        qcom,glink-channels = "apr_audio_svc";
+        qcom,intents = <512 20>;
         #address-cells = <1>;
         #size-cells = <0>;
 
         q6core: service@3 {
-          compatible = "qcom,q6core";
-          reg = <APR_SVC_ADSP_CORE>;
-          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+            compatible = "qcom,q6core";
+            reg = <APR_SVC_ADSP_CORE>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
         };
 
-        q6afe: service@4 {
-          compatible = "qcom,q6afe";
-          reg = <APR_SVC_AFE>;
-          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-        };
-
-        q6asm: service@7 {
-          compatible = "qcom,q6asm";
-          reg = <APR_SVC_ASM>;
-          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-        };
-
-        q6adm: service@8 {
-          compatible = "qcom,q6adm";
-          reg = <APR_SVC_ADM>;
-          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+        service@4 {
+            compatible = "qcom,q6afe";
+            reg = <APR_SVC_AFE>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            clock-controller {
+                compatible = "qcom,q6afe-clocks";
+                #clock-cells = <2>;
+            };
+
+            dais {
+                compatible = "qcom,q6afe-dais";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+                /* ... */
+            };
+            /* ... */
         };
     };
 
@@ -175,12 +179,25 @@ examples:
     gpr {
         compatible = "qcom,gpr";
         qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+        qcom,glink-channels = "adsp_apps";
+        qcom,intents = <512 20>;
         #address-cells = <1>;
         #size-cells = <0>;
 
         service@1 {
-          compatible = "qcom,q6apm";
-          reg = <GPR_APM_MODULE_IID>;
-          qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+            compatible = "qcom,q6apm";
+            reg = <GPR_APM_MODULE_IID>;
+            #sound-dai-cells = <0>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+            dais {
+                compatible = "qcom,q6apm-dais";
+                iommus = <&apps_smmu 0x1801 0x0>;
+            };
+
+            bedais {
+                compatible = "qcom,q6apm-lpass-dais";
+                #sound-dai-cells = <1>;
+            };
         };
     };
-- 
2.34.1

