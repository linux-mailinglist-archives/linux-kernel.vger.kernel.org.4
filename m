Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8756E29E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjDNSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDNSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:13:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C8B448;
        Fri, 14 Apr 2023 11:13:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hg12so4633051pjb.2;
        Fri, 14 Apr 2023 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496001; x=1684088001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCtsWRyIxiDsBBm3zcX7OgE+LyO5qPbft4vgrlazqlE=;
        b=DqXnM7D2dHKfhH3ZxXQgOWXtmrdxUHcWq9frNl49eVyBFJWzkXf4Wq1twBLD5ZCmAT
         WBTlqDHpio0KxTPjH9ZB+UOprrVWLqL1IkmTsjmV841GWcwtHhnhy/NME44gZbv13OqU
         lrcOx2d03hAue5NlzzVM7PzMzdBlfX1lYfwe2PunKK6dvgshkotvbkwU3sshl9LLSARg
         1cO17W6z17GlNwPrftv4yHHXkh/1jdTGijk9MgFsPAfalXjdTKHJIDv1t57wHvPrRigy
         kymw60yoOrZAtCL0UtgbjgqraMk6toNdIJW8s6Ib8T6RtXSNGtI9bQ8wsU/23bV2pwtx
         MYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496001; x=1684088001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCtsWRyIxiDsBBm3zcX7OgE+LyO5qPbft4vgrlazqlE=;
        b=fk/El4qeTVuwmWtNLrm5uAZFBgizGvq0LyNq7ziOPU5Ku+D0aBHJ0QxrXRpNih0mvf
         WJMWUG3a6zY14/Z/zDKtyNq9p8FDJqsCi7xck0vdVq4SY2Q+UEmwj9BkC1HXRfZJ/z0P
         JhkkLxfTibI5/xL9T/cNEYgUGw2jooUZztP9vL+Txcr+11cNrEGxW+MOhW6CNP7hrZHY
         jk8yPmV3eJZTXaEQbWTS8arm6mb4fQ/D+uhh9ioS6lLg61lrJ915MvUpZsoW9rH+J0eA
         rUtz6L/PGWNdOQ58PREvnWU4TgQ5j63gwSeuuzCuqSznMEssVxseZllh0JaIFOB8SUR/
         DRvA==
X-Gm-Message-State: AAQBX9dCE7moJh6QtbJELzKU9aUrOZJ57rwEJaaK3VtxQvL5x215eVey
        MT7WpejvTmyWq+ek+gbTkQwmOQB9UB4euH90Hsc=
X-Google-Smtp-Source: AKy350bsVbu0uEvKglf+5AzhX2bgHP6ylEXg8p0XyPL3HtQJVbf3Krkl5U1YG4agN4uZUijdQjeyVA==
X-Received: by 2002:a17:902:e5c2:b0:1a6:82f5:c90e with SMTP id u2-20020a170902e5c200b001a682f5c90emr3729378plf.67.1681496000824;
        Fri, 14 Apr 2023 11:13:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902820b00b0019a593e45f1sm3309371pln.261.2023.04.14.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:13:20 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
Date:   Sat, 15 Apr 2023 02:12:59 +0800
Message-Id: <20230414181302.986271-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414181302.986271-1-mmyangfl@gmail.com>
References: <20230414181302.986271-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings documentation for reg-clock-controller, collection of
basic clocks common to many platforms.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
 1 file changed, 245 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-controller.yaml

diff --git a/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
new file mode 100644
index 000000000000..a6a7e0b05821
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
@@ -0,0 +1,245 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple straight-forward register-based clocks
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  Basic clocks common to many platforms.
+
+  If your clocks don't fit into these catagories, simply create your clock
+  controller. This driver normally work well with other controllers as long as
+  they operate on different registers.
+
+  See linux/clk-provider.h for details about properties for each type of clock.
+
+properties:
+  compatible:
+    enum:
+      - reg-clock-controller
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  ".*gate-clock@.*":
+    type: object
+
+    description: |
+      Clock which can gate its output.
+
+    properties:
+      compatible:
+        const: gate-clock
+
+      reg:
+        maxItems: 1
+
+      '#clock-cells':
+        const: 0
+
+      clocks:
+        maxItems: 1
+        description:
+          Parent clock.
+
+      clock-output-name:
+        maxItems: 1
+
+      bit-index:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Bit index which controls the output.
+
+    required:
+      - compatible
+      - reg
+      - '#clock-cells'
+      - bit-index
+
+    additionalProperties: false
+
+  ".*divider-clock@.*":
+    type: object
+
+    description: |
+      Clock with an adjustable divider affecting its output frequency.
+
+    properties:
+      compatible:
+        const: divider-clock
+
+      reg:
+        maxItems: 1
+
+      '#clock-cells':
+        const: 0
+
+      clocks:
+        description:
+          Parent clocks.
+
+      clock-output-name:
+        maxItems: 1
+
+      shift:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Shift to the divider bit field.
+
+      width:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Width of the divider bit field.
+
+      dividers:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          Array of value/divider pairs.
+
+    required:
+      - compatible
+      - reg
+      - '#clock-cells'
+      - shift
+      - width
+
+    additionalProperties: false
+
+  ".*mux-clock@.*":
+    type: object
+
+    description: |
+      Clock with multiple selectable parents.
+
+    properties:
+      compatible:
+        const: mux-clock
+
+      reg:
+        maxItems: 1
+
+      '#clock-cells':
+        const: 0
+
+      clocks:
+        minItems: 1
+        description:
+          Parent clock.
+
+      clock-output-name:
+        maxItems: 1
+
+      shift:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Shift to multiplexer bit field.
+
+      mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Mask of mutliplexer bit field.
+
+      table:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          Array of register values corresponding to the parent index.
+
+    required:
+      - compatible
+      - reg
+      - '#clock-cells'
+      - shift
+      - mask
+
+    additionalProperties: false
+
+  ".*fractional-divider-clock@.*":
+    type: object
+
+    description: |
+      Clock with adjustable fractional divider affecting its output frequency.
+
+    properties:
+      compatible:
+        const: fractional_divider-clock
+
+      reg:
+        maxItems: 1
+
+      '#clock-cells':
+        const: 0
+
+      clocks:
+        maxItems: 1
+        description:
+          Parent clock.
+
+      clock-output-name:
+        maxItems: 1
+
+      numerator-shift:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Shift to the numerator bit field.
+
+      numerator-width:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Width of the numerator bit field.
+
+      denominator-shift:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Shift to the denominator bit field.
+
+      denominator-width:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Width of the denominator bit field.
+
+    required:
+      - compatible
+      - reg
+      - '#clock-cells'
+      - numerator-shift
+      - numerator-width
+      - denominator-shift
+      - denominator-width
+
+    additionalProperties: false
+
+additionalProperties: true
+
+examples:
+  - |
+    clks: reg-clk-ctrl@ffff0000 {
+      compatible = "reg-clock-controller";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0xffff0000 0x1000>;
+
+      my_clk: gate-clock@cc-3 {
+        compatible = "gate-clock";
+        #clock-cells = <0>;
+        reg = <0xcc 4>;
+        bit-index = <3>;
+        clock-output-name = "my-clk";
+      };
+    };
-- 
2.39.2

