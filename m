Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D95626B71
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 21:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiKLUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 15:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiKLUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 15:07:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED315A21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 12:07:24 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c7so3028884iof.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aloX78xpt1ZUhhk2B4r0yIdFbVyMyxb0348xtj6qFfc=;
        b=TT3fdj5lcRdlBtkMD5vkH+ZZoUO3bL/WA3FBAh0BI7eO+orVVn1dNt7qAlAegJ0Lss
         UemR8GUQyxIv6pQufwfd6UaPhavZRdvi5PuzA+bLQD8c0BQ6fXIN0qqeIdt6J4ZGj+X2
         wisjKxowPvttRKTgiyUy0zTgxcSrpgXShkJdmGUIzojI84JPdhWW8f3LMw5ZZiy+rbgD
         5+x7Yzr9FaF8OTiZplpQB9FKZaWoHRgzKN+sPJvtgSwoPK36TE0xHYB3qBjORbGKZj3n
         j4F4BTi/qO0yIJamHJMEEJDHFLAcxb97dlxm6RtK2OaRVmMV0GFoqx4kgNT0q3PGxS2p
         xGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aloX78xpt1ZUhhk2B4r0yIdFbVyMyxb0348xtj6qFfc=;
        b=UCS5aLrquV8gBpRJUv5yxhdE6jBwv6tSb/xOjF3FQA9j0KUIn+3L110ijBAFtIjzx7
         t/RjafJrEkO+ybe1EbITeC01ubMyLYNYQ+RceAhhTgAbOngIFH4O5KPBtDAM7Vh3v89s
         HI7w4zEicuw5SoY+bt2Ow1Yg9Sx1F208nmodwEdeIzEia/6ozq4DFrMQlmcMVeVLPebp
         RmZ9sYOfzPCVbxPtPgKoqM5tizlu/MhTlHHoaGNF3KQfNhhj0rIlTQKk5NSGvQKj5EMj
         G5QZ/JsflHLT2FntDJEmBtYBoEZo3cPWNdo/bPVLUNHgFKQKfYiWK/nIsVlWQ4JAKME8
         NnTw==
X-Gm-Message-State: ANoB5pn0sOVEWzmv4DPNr8AzVNmja+V+raW4FJbSqLiyAFOnzTYgAzDi
        +gbRPEWLTHUgX7IA8u1zECNo2A==
X-Google-Smtp-Source: AA0mqf6APkEFWbXx0Gjx1yZuFZlNO85CoDgOGY5sIPjDA9FD9GgcyhdrRotiIbkSLtIq/1ZHGINVDw==
X-Received: by 2002:a6b:6318:0:b0:6ca:6cbb:cb83 with SMTP id p24-20020a6b6318000000b006ca6cbbcb83mr3221089iog.44.1668283643477;
        Sat, 12 Nov 2022 12:07:23 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id j28-20020a02cb1c000000b00363dee286edsm2036870jap.60.2022.11.12.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 12:07:22 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        elder@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dt-bindings: net: qcom,ipa: deprecate modem-init
Date:   Sat, 12 Nov 2022 14:07:13 -0600
Message-Id: <20221112200717.1533622-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221112200717.1533622-1-elder@linaro.org>
References: <20221112200717.1533622-1-elder@linaro.org>
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

GSI firmware for IPA must be loaded during initialization, either by
the AP or by the modem.  The loader is currently specified based on
whether the Boolean modem-init property is present.

Instead, use a new property with an enumerated value to indicate
explicitly how GSI firmware gets loaded.  With this in place, a
third approach can be added in an upcoming patch.

The new qcom,gsi-loader property has two defined values:
  - self:   The AP loads GSI firmware
  - modem:  The modem loads GSI firmware
The modem-init property must still be supported, but is now marked
deprecated.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/net/qcom,ipa.yaml     | 59 +++++++++++++++----
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index e752b76192df0..0dfd6c721e045 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -124,12 +124,22 @@ properties:
       - const: ipa-clock-enabled-valid
       - const: ipa-clock-enabled
 
+  qcom,gsi-loader:
+    enum:
+      - self
+      - modem
+    description:
+      This indicates how GSI firmware should be loaded.  If the AP loads
+      and validates GSI firmware, this property has value "self".  If the
+      modem does this, this property has value "modem".
+
   modem-init:
+    deprecated: true
     type: boolean
     description:
-      If present, it indicates that the modem is responsible for
-      performing early IPA initialization, including loading and
-      validating firwmare used by the GSI.
+      This is the older (deprecated) way of indicating how GSI firmware
+      should be loaded.  If present, the modem loads GSI firmware; if
+      absent, the AP loads GSI firmware.
 
   memory-region:
     maxItems: 1
@@ -155,15 +165,36 @@ required:
   - interconnects
   - qcom,smem-states
 
-# If modem-init is not present, the AP loads GSI firmware, and
-# memory-region must be specified
-if:
-  not:
-    required:
-      - modem-init
-then:
-  required:
-    - memory-region
+allOf:
+  # If qcom,gsi-loader is present, modem-init must not be present
+  - if:
+      required:
+        - qcom,gsi-loader
+    then:
+      properties:
+        modem-init: false
+
+      # If qcom,gsi-loader is "self", the AP loads GSI firmware, and
+      # memory-region must be specified
+      if:
+        properties:
+          qcom,gsi-loader:
+            contains:
+              const: self
+      then:
+        required:
+          - memory-region
+    else:
+      # If qcom,gsi-loader is not present, we use deprecated behavior.
+      # If modem-init is not present, the AP loads GSI firmware, and
+      # memory-region must be specified.
+      if:
+        not:
+          required:
+            - modem-init
+      then:
+        required:
+          - memory-region
 
 additionalProperties: false
 
@@ -196,7 +227,9 @@ examples:
         ipa@1e40000 {
                 compatible = "qcom,sdm845-ipa";
 
-                modem-init;
+                qcom,gsi-loader = "self";
+                memory-region = <&ipa_fw_mem>;
+                firmware-name = "qcom/sc7180-trogdor/modem-nolte/mba.mbn";
 
                 iommus = <&apps_smmu 0x720 0x3>;
                 reg = <0x1e40000 0x7000>,
-- 
2.34.1

