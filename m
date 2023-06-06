Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7037F72460F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFFOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjFFOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:32:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684B10FC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:32:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so51972845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686061923; x=1688653923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/RmLqBdqHlKB/fV0OvGO4bPEeaDKdfC66+DK/AUlm8=;
        b=uHI1NVueW/Wm5qhNtR28P71UiCHaIVk5+netraou9AR2FJeD26iWlBgE4zGA8Xqmw4
         hpHBkk5+atMXnJ8XlmzqjfL3Bs7bavUoW6m+5aw2Zfv6ez4xK4TaH9ycFTCy7v9yJ3oC
         vmQRfJiUvm61KGMnytw6YVX6v7j53a6SSzGIR2hQIDdLk0G2Jj+8DH0k6twXRL+8P6/d
         aElkzHTfT6uFXgTIaXK+JY8bZo2tPe1RZbH1fMNhk8oAjg4n5jDyGl5rr1x8KDvhOt+J
         DEFcVl2Mx6oH/vHsaObAbVaoAu6pf3iD83eIdWyvypyp7KRJo69BUBEYPXF0gMULzqwi
         fqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061923; x=1688653923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/RmLqBdqHlKB/fV0OvGO4bPEeaDKdfC66+DK/AUlm8=;
        b=b7qLFZ5g+Vxcu5CA0zRBc+5O1u/QkBuUw0BTDkzaWCwggN1/8YdiZWm/f9c0qwU4d4
         4sS5TfWBrYhvOMTPRNbObg7jutgltLwG5kxoVnm8dWAA4E9KJ/TiT0ABaTRZGbJiIsKG
         qz5jN2ZLBejJgHrtRBenbY8zcq0JRGaMwzrNKEx8qMnIkaVHmNfcTpCgF9RIZyNSWcLZ
         dYxkG00VYQaB20h1jPZIKJgyiJBp3ke1s0VUkSyAkAzRIc9JLId9dU3okzvfCuBm/uw+
         qES0s36eBd21+qgIItr4WHvn4A81XSykRCRYD7OfRUZGIsGR/BMHcGWHCskK2qqCkKDD
         4QyQ==
X-Gm-Message-State: AC+VfDxwpRtQ+zxdq92wG54rDSsgNo+ymhNO0vDN7i5zTO56Pz4EUuG9
        OWnlTJb1/umwqpj/jLSHKFvZPA==
X-Google-Smtp-Source: ACHHUZ7hwY1Z3l5Yvc2X3Oz1LL3KoEWaAMM42b+UPLtpglXJY6hMFGUqOxJyIlVzjXL5CDVP8bRRBA==
X-Received: by 2002:a7b:ca48:0:b0:3f4:28db:f5ff with SMTP id m8-20020a7bca48000000b003f428dbf5ffmr2197281wml.35.1686061923019;
        Tue, 06 Jun 2023 07:32:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003f61177faffsm3883600wmb.0.2023.06.06.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:32:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 06 Jun 2023 16:31:56 +0200
Subject: [PATCH RFC 1/4] dt-bindings: input: document Goodix Berlin
 Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v1-1-4a0741b8aefd@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+IS00VmbfdsOx5expv8gh1ojPzZ6FMwcyZcX5s15570=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkf0Nf9Wmua32M+ZPjt3hEHjRmfw4gESMlRxDWbXXq
 6dxqA4SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZH9DXwAKCRB33NvayMhJ0d7FEA
 CzhWwc/mrRmSEptYgxIYR/jJoYyo5IDsYy4WdkOTeRnazmkjzRtdWaOSrQamQylY+GyALqzK3FBoUt
 T6vab4eQ3e8TVkae5GaUQM/pGaBP5KNtDky63yV1x1IgoLlPlXddGZQfD7YpfYF28VewjjSVfW+dJ/
 it27CACjJO5Js5a7y6Niuw8FJ0zDpQ7BjYdRhtNY2hF7L5xyaE9/hBpEDhax+157e4KsxBqDPvFN2t
 eFsUB3rYI/iJ4P9lFmyGaDo7NTax8KKIYdwtJReNoka5c/DVufAnH5a03tMHfTsDNbU1C92XssH8lQ
 cUUgBPTopKIAG6ZzCe23vK9C9+ianwMMQ5Ts2OdpdLFOaE/wp1XPTQ59aUEe8eJE8fLFZ0B0ala2ko
 CfrkP5EGW41Js+BB+i+DxcoSvKzkLopv6WfKm/TIQmQu3FUuxIcra4zAaoEsVXRYQgENHUAtelFAhK
 aYmV39gmeCUBar9Sj5E4SGxW+JGxHyEorKNKwYIFhejdd+6TPPRxHuJ8XmiVoYyVygLKFEXjcUd7p1
 kWBf6orPo0/38QXXex+Ccmr1quUr8OwVdkAtnDCVy07gC8VzPTCR5Hb1y1Rsow0LNXl6njSSsTDRpY
 jrXbTeN8gNFk+xOlowEoiIrcFrbJYziD5y1r6g4vbNd43HWLjXt7mLzGY6VA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Goodix GT9916 wich is part of the "Berlin" serie
of Touchscreen controllers IC from Goodix.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/input/touchscreen/goodix-berlin.yaml  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
new file mode 100644
index 000000000000..4c24a541e919
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix-berlin.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix-berlin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix Belin series touchscreen controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9916
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: GPIO power supply regulator on VDDIO pin
+
+  spi-max-frequency: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      gt9916@5d {
+        compatible = "goodix,gt9916";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      num-cs = <1>;
+      cs-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+      gt9916@0 {
+        compatible = "goodix,gt9916";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...

-- 
2.34.1

