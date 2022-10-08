Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211495F86B4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJHSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJHSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:40:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4084622B0B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:40:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so11569099wro.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgD3kP0sSWca4YlP6hR+kz5HlaxlTP+KMXKfvr3kHec=;
        b=b6GVfGW5JnhTrvqehLVkLkkzJWiN982+Yjnjisk8UQVjWn1Yff400hD6AH1yMsy78x
         Aid2a8rStuTW4NK3w5iiOkdJoFTmmU66egoGFJYVv34Nn2heRyyUUVeCT43Yt7c7Rm1O
         CTV4Sv0LtVKPse42CNQ0BsmK+ESeJXLbQ/ggAR4A9HR4gDZK1mYnshBY71MEeDqppskh
         5mXlEMcjL9d4iH2ltfh/Bvd5Ah7RQfpMtY2tBcxW9tScVhBAFtnioeUYmJgbGE6TRg9Q
         WGfKJlD+6GoqTyqHEcAs1BgR7eGW7f6D97/YbGcBOJHSJrsmaeExkoW9C/SDL+27i1vX
         UGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgD3kP0sSWca4YlP6hR+kz5HlaxlTP+KMXKfvr3kHec=;
        b=rGiyICIBW9BOzmH5cyp4v8oUw9iOroonSNgFWWqEIOQ4Ogx/K2mi2sfCOrUMT9ErFj
         x9gO4FYTgyO8LAlYqisYDnWsaDleoEb7wkBZk6NAgcQcA1a52a6jmQWOZaJdH40dPLhN
         P8ujE1V5MfEYhHowclA9ELnKADjmv14Ems6o3l9h1t5dRcY1eSyfNR3adcmnHUZaqvcR
         0qD2QsJ07ubmtHzg3A7B/YRcBf65xYv1QhsWYHGCv1ZObuT4oyt9jVKmK1k2hVl67V1F
         1N8u+wNgRBNVkugMoFdN1rVFXeQdJbzu2v5t5bm5lVvA/F0YghqyCcUqGC37PActPE4L
         yliQ==
X-Gm-Message-State: ACrzQf2S2xHodjDcunbJ1MNv4ijGnTMiZ39kgq0rsUSQu6j6xkxra/Vv
        ak492bwZi1B/Wwl5dB8h7BNoIw==
X-Google-Smtp-Source: AMsMyM6JzbCD/vOcJXmuExnmgBlsqiJfszhrDlcEyT5u9xQNubX6MXHbri4HR+9+gp6gxO6Rxr3Peg==
X-Received: by 2002:a5d:6484:0:b0:22e:3456:37fa with SMTP id o4-20020a5d6484000000b0022e345637famr6403075wri.203.1665254402785;
        Sat, 08 Oct 2022 11:40:02 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b003b4ff30e566sm28325194wms.3.2022.10.08.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 11:40:02 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
Date:   Sat,  8 Oct 2022 19:37:52 +0100
Message-Id: <20221008183753.249514-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008183753.249514-1-caleb.connolly@linaro.org>
References: <20221008183753.249514-1-caleb.connolly@linaro.org>
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

Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
driver.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../power/supply/qcom,pmi8998-charger.yaml    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
new file mode 100644
index 000000000000..277c47e048b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-charger
+      - qcom,pm660-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+
+  interrupt-names:
+    items:
+      - const: usb-plugin
+      - const: bat-ov
+      - const: wdog-bark
+      - const: usbin-icl-change
+
+  io-channels:
+    items:
+      - description: USB in current in uA
+      - description: USB in voltage in uV
+
+  io-channel-names:
+    items:
+      - const: usbin_i
+      - const: usbin_v
+
+  monitored-battery:
+    description: phandle to the simple-battery node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <4>;
+
+      charger@1000 {
+        compatible = "qcom,pmi8998-charger";
+        reg = <0x1000>;
+
+        interrupts = <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+                     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>,
+                     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "usb-plugin", "bat-ov", "wdog-bark", "usbin-icl-change";
+
+        io-channels = <&pmi8998_rradc 3>,
+                      <&pmi8998_rradc 4>;
+        io-channel-names = "usbin_i",
+                           "usbin_v";
+
+        monitored-battery = <&battery>;
+      };
+    };
-- 
2.38.0

