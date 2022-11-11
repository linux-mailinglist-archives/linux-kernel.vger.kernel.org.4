Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B8625989
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKKLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiKKLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:36:40 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71377C8C4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u11so4225622ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEBoGr3X7IB7lANWmyJ0vo8TD49udt1SAuFDZMae92Y=;
        b=WFz3Cp9sXDJehJxF/+D7tFxIq7jlzy31R2WdUCszgtRsVgRyRjUzckqjFh4mIRrlW6
         tcs8Me2SpXcBkc4YiiIM+sMTOGQEyXWMmFgvcr1ncAIFNDr8QBwQ94LrnpQrF+KED1Tc
         NSlMWNiVFTJ/nZz66HKF1bcXMtcvwAZXkJYqaBRqTt2K6gaNiLEiJgadwb1ne6Suv0cQ
         8U+WdV6TuX+fbdycyVV1vwfEpfiuynzPeGc6JKpATl8RY2nb8BSYAsJYc/jB0UA1lM8Y
         c+kUWFWpwcuslThBCVXMAG8okz3wWrX0TnCaeuCXonhyZ5/90i7Ufh2NVxhZuh9locJf
         spKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEBoGr3X7IB7lANWmyJ0vo8TD49udt1SAuFDZMae92Y=;
        b=4FGiLzygw6gK96UcbxVUjqZX+P5vfQm58gS9iEBOUrwzy0QTo50J89P5Uid0QP+dgn
         kjuj1j6r8wyj52ZapyF3LDMYBbTGiSyqVZLAgMejSUljVJN0FuuVMhVEsdsW79gEmHtm
         1MW0q3CgS/ILCpr4d3vYQylWu3IduFWPXPcZopp8+u4poyo2/3LZC1FdvXXYSI1KGjx1
         UZWowmDvHfA9xjm/f/2supF4epY17OLHCtxbt3UvWvMZeYNCW8TRNHw8MOtNL1i7zTOT
         WS1nzb8fyk1Jh7JyFWpVLn2OMe1jmtvXmjf00kD2BL4wqcHXLmk68u3deFzGiRwAveRS
         8Vvw==
X-Gm-Message-State: ANoB5plpXIKl9hhtT6HWB4LlxBMoyFFEpxk6lJ64BFDuCLnmfu5jAWCC
        xBT4HZJnKsALYeWY79srspXTKQ==
X-Google-Smtp-Source: AA0mqf79IMhFGWeei5VfHf+fjaEoxMdTeoHoRdkihJODjwuK6Lm+qK9xpde8XmV2xJ5rMF4kDArDTA==
X-Received: by 2002:a2e:b056:0:b0:278:a7de:54e6 with SMTP id d22-20020a2eb056000000b00278a7de54e6mr530694ljl.367.1668166577831;
        Fri, 11 Nov 2022 03:36:17 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b004acb2adfa1fsm274970lfb.307.2022.11.11.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:36:17 -0800 (PST)
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
Subject: [PATCH 08/10] ASoC: dt-bindings: qcom,q6core: Split to separate schema
Date:   Fri, 11 Nov 2022 12:35:45 +0100
Message-Id: <20221111113547.100442-9-krzysztof.kozlowski@linaro.org>
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

The APR/GPR bindings with services got complicated so move out the
Q6Core service to its own binding.  Previously the compatible was
documented in qcom,apr.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/sound/qcom,q6core.yaml           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.yaml b/Documentation/devicetree/bindings/sound/qcom,q6core.yaml
new file mode 100644
index 000000000000..e240712de9ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,q6core.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Audio Core (Q6Core)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+allOf:
+  - $ref: /schemas/soc/qcom/qcom,apr-services.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,q6core
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/qcom,apr.h>
+
+    apr {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        service@3 {
+            compatible = "qcom,q6core";
+            reg = <APR_SVC_ADSP_CORE>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+        };
+    };
-- 
2.34.1

