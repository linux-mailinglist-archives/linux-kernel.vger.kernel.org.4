Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED725BAD56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIPMWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiIPMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C77AB14DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so201008wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zxb2eOYdbFuIwriIiJENiShYuzhFLs8VI8hEdSxtZI4=;
        b=dJENqT5SmssLbc9m96wJVytWaLVPEqOYq8HoGtclBFP40G6/qaEymUD4L4ptdBGP3R
         x5r+jgSQRb+RJY2o1UEDn50v+zZx56VEuBQZQNJgJ0+y9qpzdldYokd3v3Sax2l/ykVD
         +eK+1vI5ZlrT0w5RLJEGRDRD7pey/Zksj1M+P+a1wZcI3hEtyyQULMNOOnjI2e5bGH8f
         0xRAMrw75bbKd6PBzJmX/t++WiIGeLqCPI7wmrOQV+FagUybQwGCEBFHm6IDVX//ZfKs
         IZbId06UnCwcrOPfHeJM9IqiZwyeBGw8lbnhqa8wjiB6OqSU/vwoj8mG1Po+B93l3yhk
         2w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zxb2eOYdbFuIwriIiJENiShYuzhFLs8VI8hEdSxtZI4=;
        b=RxNcrMhRpWlbUcvXvCakHoBlVGhDV7LEf/XIjlTU8QcSrnUC/UrVhO4AroP5g9uher
         SiWlfUCFWQjx8euRsKrYc9PpQr0qyeqH/uy8jQ3Z23eCcAJWujnD3f8xo2Q1htlp7TYx
         pZHJOjgZMIG9dMcDDZq7qCNc1ymXv1aWDv1pv3JzI/qL9hbWZsLkDhlL/YkH6sxkOghz
         DgXNjiyWyFY8nfNwF9UQNRXNv0lTW/wom2AYyUY6QcnD0mj1KPOziBbOyj5sB+3MaIpj
         8qWj0SWdVZTdYbxwmHz2bUcKW9/03Mz1x4245V4c/GhaHrthh5eWszw5U3OEDXZxP42W
         CO+Q==
X-Gm-Message-State: ACrzQf3pg/9uHR9O4kI1kod9p+Z/S5b/TrE0WHXA1jlcEbRhWU0XTpzf
        kCVYlNGgTdfVz6dtSMNT1dg4Kw==
X-Google-Smtp-Source: AMsMyM7pYbr/gLRJ/QjEXxATOLucnIKEqgDSegZtMFndzFkBYgYW5+4/Ig+CjDtRITYqrN34XVIH3w==
X-Received: by 2002:a5d:5452:0:b0:228:d6f0:dbeb with SMTP id w18-20020a5d5452000000b00228d6f0dbebmr2741501wrv.84.1663330879251;
        Fri, 16 Sep 2022 05:21:19 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/13] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Date:   Fri, 16 Sep 2022 13:20:58 +0100
Message-Id: <20220916122100.170016-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
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

From: Horatiu Vultur <horatiu.vultur@microchip.com>

Document Lan9662 OTP controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/microchip,lan9662-otpc.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
new file mode 100644
index 000000000000..f97c6beb4766
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip,lan9662-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9662 OTP Controller (OTPC)
+
+maintainers:
+  - Horatiu Vultur <horatiu.vultur@microchip.com>
+
+description: |
+  OTP controller drives a NVMEM memory where system specific data
+  (e.g. hardware configuration settings, chip identifiers) or
+  user specific data could be stored.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,lan9668-otpc
+          - const: microchip,lan9662-otpc
+      - enum:
+          - microchip,lan9662-otpc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otpc: otp@e0021000 {
+        compatible = "microchip,lan9662-otpc";
+        reg = <0xe0021000 0x300>;
+    };
+
+...
-- 
2.25.1

