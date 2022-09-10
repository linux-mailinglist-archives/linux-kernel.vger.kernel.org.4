Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF55B458C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIJJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIJJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:15:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62C2CE00
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn9so4757797ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Tn2FE4uhx3qd+o+7Fk9TdVeJts1VUhiNI+L2cf12iKs=;
        b=NZwn9py8H3WOeWfR1QBFDAoAnj6TSmEodR/wnsLqWNfQl6QjD+CQP8wFRAEVLHYwm4
         yITT3sZuGaDuEa9eppdf6KN6oLY97GRyR5jYOZ6bw/2m60mILwjlXXEE6xknfGhjPc8n
         EpsBERDfQslDsnsJ3jOEfU3IyIGsniScMIC7w4pXxJlGxgUUGollwRCHWBbAhBCMkZTB
         WnW/1SDZgPLgFZ6BjkCMMjKeDopXYqbT38Ua6E3nsXadpC2kyKOp8S8h8/LBclbwpgkR
         Uoyxu+Oy9TcRkFunH7abFZEC6uqku2BwAAQoti3QzhhkZw1G5/UU1EMaXhQQ9JTEyFxE
         efzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Tn2FE4uhx3qd+o+7Fk9TdVeJts1VUhiNI+L2cf12iKs=;
        b=7UzorMqw0xaunnb0J2BVGws4OI4eYNRGRa+AdJnjHZ62LbxxItWySHrbbfy2fQ5+wx
         tEr5f4Zwvu9tmafR2deVQKaSc6ZDP3OoCIasQZCzOzpN9qPyVTpDrIXZfh5V8KXnt03e
         sKkq1g8Vdd1hRGyVvXRydKAxsLT50I6EOk6da3gn3VtFVVJxuOTzHN50JfllQn+METxY
         ADmXaVdUysNGCRN2t+rJdfxspqT+8Obxfc60qhefoSEXSbhupkwu9vlnP46tWNjoyb9W
         SRqZIteEE4Ci+tV/zW/ZpC7SjHXp6cDF4wG5VjyBIc276vVXAzf/T6r4K4TT4fKXR4/7
         0XNw==
X-Gm-Message-State: ACgBeo3gTYTrj6U2pAHRHFn6arYC/O32V8af/pfiDAjOqG1f5KkoCHIH
        Ra+Rn8CrM7ykX2n5IG5DLK9Wgw==
X-Google-Smtp-Source: AA6agR54ITWThcZ1aMJWyfiJTPcW3V/2oO2lUB+mlbei49YQMsWuFF/0qzWnKIbZAOmtqzOxNhdP7g==
X-Received: by 2002:a05:651c:2106:b0:26b:ea0d:63e9 with SMTP id a6-20020a05651c210600b0026bea0d63e9mr1284134ljq.414.1662801291706;
        Sat, 10 Sep 2022 02:14:51 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 12/15] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: cleanup example
Date:   Sat, 10 Sep 2022 11:14:25 +0200
Message-Id: <20220910091428.50418-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
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

Cleanup the example DTS by adding APR and service compatibles, adding
typical properties, using proper device node names for services and
fixing indentation to 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

---

Changes since v1:
1. Add few more properties.
2. Adjust indentation (better).
---
 .../sound/qcom,q6dsp-lpass-ports.yaml         | 48 +++++++++++--------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
index 5e666d9fb388..e53fc0960a14 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.yaml
@@ -153,24 +153,29 @@ examples:
     #include <dt-bindings/soc/qcom,apr.h>
     #include <dt-bindings/sound/qcom,q6afe.h>
     apr {
+        compatible = "qcom,apr-v2";
         #address-cells = <1>;
         #size-cells = <0>;
-        apr-service@4 {
+        qcom,domain = <APR_DOMAIN_ADSP>;
+
+        service@4 {
+            compatible = "qcom,q6afe";
             reg = <APR_SVC_AFE>;
+            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
 
             dais {
-              compatible = "qcom,q6afe-dais";
-              #address-cells = <1>;
-              #size-cells = <0>;
-              #sound-dai-cells = <1>;
-
-              dai@22 {
-                reg = <QUATERNARY_MI2S_RX>;
-                qcom,sd-lines = <0 1 2 3>;
-              };
+                compatible = "qcom,q6afe-dais";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+
+                dai@22 {
+                    reg = <QUATERNARY_MI2S_RX>;
+                    qcom,sd-lines = <0 1 2 3>;
+                };
             };
         };
-      };
+    };
   - |
     #include <dt-bindings/soc/qcom,gpr.h>
     gpr {
@@ -178,20 +183,21 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+
         service@1 {
             compatible = "qcom,q6apm";
             reg = <GPR_APM_MODULE_IID>;
 
             dais {
-              compatible = "qcom,q6apm-lpass-dais";
-              #address-cells = <1>;
-              #size-cells = <0>;
-              #sound-dai-cells = <1>;
-
-              dai@22 {
-                reg = <QUATERNARY_MI2S_RX>;
-                qcom,sd-lines = <0 1 2 3>;
-              };
+                compatible = "qcom,q6apm-lpass-dais";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #sound-dai-cells = <1>;
+
+                dai@22 {
+                    reg = <QUATERNARY_MI2S_RX>;
+                    qcom,sd-lines = <0 1 2 3>;
+                };
             };
         };
-      };
+    };
-- 
2.34.1

