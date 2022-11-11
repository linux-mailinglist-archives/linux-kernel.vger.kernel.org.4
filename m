Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3393462598B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiKKLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288807E983
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so7886852lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+DBxwlSpUyj8lGt+IYb/lufNjAzDcecLdKZpM26350=;
        b=xVCLNlN9wYe+LKsEBRt77PDlL/q8IAYF63JYB5lSSfMFs84t+7wF58gGCa/h9z81Xa
         2U0T8RbljMgHOwvugy2GY7dPPrjnhD9j7mUacdYMcZeS7/3II5eQ/ygKB3bNAtqhLyE+
         +T0VxAZoWW8T1QN6NSsd66Cz0fA8ORrYx3Hlx1x04L070iJb1LhD/bTPrpdkzUgnAJi9
         lv6dvkp20qsj+JrFUekCd1oH1DCybnMVvd+GL+fzgMSPvYPKQ4A41IyqhPJJUgQnXf71
         5yBDqGUTGX2ANXztXXctpT6I4yNpTr6cXL6W6IlQebPwqLWj4ZJg5dimgtf3vCbc4Pu1
         TOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+DBxwlSpUyj8lGt+IYb/lufNjAzDcecLdKZpM26350=;
        b=y0xrhK7vipmwDPzKSj7PdCRpuNW71RTx33lmvWgdjgsyeI5mrgdRUDCvCv2vp9RyxN
         ui68jx2XSgjTveBVwoZtO8NfdO0lIcJArC3+8k3X+6j5Yif80dA6ns7QBCSgAmspz8Dh
         PhrcFAdBAhBfCL3HR8YFppjMzZ/ZkWGfYCUbsJnBDCjNlmo1NB/xDesisoe1kq5HeZcG
         cJBfLPm6MeNP8mVRTxHwRTYW3OHdBQRFOGJGKLbqf+DwEz+55r9kelTslfF3YQVMlERV
         dteFodbTe+Nk/GDl8Z5/p7IxCmPXo97hfZhOKiy0/SwgWQbfdQEhI80nEz1chtLNtGlB
         O/oA==
X-Gm-Message-State: ANoB5pmFY5ULZPE/mg4dNYOlgbCQB+L5r98WoFJ/2L/cPPs6Hgk6668c
        M5qADEFHf/HObhSMo/IwBfL44w==
X-Google-Smtp-Source: AA0mqf7ZN5G00D3X6MrSb4PtP9e42Wf0Nocjk8XCHEej02zqN2gKndXuNJE3QsxPmkI8wRnr0T37pw==
X-Received: by 2002:a05:6512:3e1a:b0:4b0:25f9:14e6 with SMTP id i26-20020a0565123e1a00b004b025f914e6mr577507lfv.604.1668166580125;
        Fri, 11 Nov 2022 03:36:20 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:19 -0800 (PST)
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
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/10] ASoC: dt-bindings: qcom,q6apm: Add SM8450 bedais node
Date:   Fri, 11 Nov 2022 12:35:47 +0100
Message-Id: <20221111113547.100442-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
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

On SM8450 and SC8280XP, the Q6APM is a bit different:
1. It is used as a platform DAI link, so it needs #sound-dai-cells.
2. It has two DAI children, so add new "bedais" node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,q6apm.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
index 7acb832aa557..cd434e8268ce 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -18,14 +18,24 @@ properties:
     enum:
       - qcom,q6apm
 
+  bedais:
+    type: object
+    $ref: /schemas/sound/qcom,q6apm-lpass-dais.yaml#
+    unevaluatedProperties: false
+    description: Qualcomm DSP audio ports
+
   dais:
     type: object
     $ref: /schemas/sound/qcom,q6apm-dai.yaml#
     unevaluatedProperties: false
     description: Qualcomm DSP audio ports
 
+  '#sound-dai-cells':
+    const: 0
+
 required:
   - compatible
+  - bedais
   - dais
 
 unevaluatedProperties: false
@@ -41,11 +51,17 @@ examples:
         service@1 {
             reg = <GPR_APM_MODULE_IID>;
             compatible = "qcom,q6apm";
+            #sound-dai-cells = <0>;
             qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 
             dais {
                 compatible = "qcom,q6apm-dais";
                 iommus = <&apps_smmu 0x1801 0x0>;
             };
+
+            bedais {
+                compatible = "qcom,q6apm-lpass-dais";
+                #sound-dai-cells = <1>;
+            };
         };
     };
-- 
2.34.1

