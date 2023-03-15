Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7136BA946
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCOHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjCOHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD0222E2;
        Wed, 15 Mar 2023 00:29:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v21so8986843ple.9;
        Wed, 15 Mar 2023 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPFgK3X39dXISj3hHbLpDm92COtr7gUeJ96GRH4aaGI=;
        b=dqmoNOyoISBXej1LzyLk9c0SV7voNOz6xI5VYdwXghfpDb+7NY7367qwlzCD8T5DnK
         pRJAjbGHPsnoPCyUWw5ud/p+X6MT3PNO74Bo+dkX14sywhikAGVeh7KT6TQkY+HfwRaA
         ODnoQs087B5BDuXRk/0xVHv5zXmZrGlo2yWaacweoc+Ns7jHJ24VshckqbBr1xYrRUcp
         pqo9/JGuej454709jck82NMtsalxfQ9f1oVVsL6RbAhxY+sWiEpImfLokFqHRB6gx9sH
         5cmcFOuZh0Fo4ET9jI7tuIa84REuwnw4IglHhdyKfMVaJIz5pvIuzaJg1Xr31PKovObC
         ZcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPFgK3X39dXISj3hHbLpDm92COtr7gUeJ96GRH4aaGI=;
        b=LUxy89qZE/FXNwYSFwrZnoNfY4pJc4BY3rf5IXoAAdVLjq73itNkOEbCUoLawu4Rkf
         MwhR5A/AGRWTiShXDrVaRgu1M/fngcfQ2g5zJAYSGRxuT+AQW4Q0GH1FughsQyqDXhG8
         1McUwYplmYnJL1pKMV/vPS1D5nqBLOmcdT/udLW6BzxjNPuvV0XlpROGKPTWskv6X6SS
         bcH4ibaJ94cXGBH91qmmtgCfvmG+mMI4pEwFPTPDflN5htu8/QoDErrWA2sqMyZDIS7G
         jIoAaqIHJOLsywiETL+sbwsBv2jkkW8B4cXXFblR+NRClrb5sVE5oR4B2WEBGYz+4lSW
         f9QA==
X-Gm-Message-State: AO0yUKVO9cUyjfVdBVvzg319LJR1ew2M+GTOU/XyWN4L8gP1mklCcRM7
        7MISga8Yfbqfgq0pLIvK/3X+kiK/xearaQ==
X-Google-Smtp-Source: AK7set/NEiW1gw0LNrWPpFDF68I/JNL/D6y70q7WPUviYQItpE0Io/gzbliw1Zt0QigRdAbwjY7tQg==
X-Received: by 2002:a17:903:2310:b0:19a:b588:6fe2 with SMTP id d16-20020a170903231000b0019ab5886fe2mr1453175plh.13.1678865368810;
        Wed, 15 Mar 2023 00:29:28 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:28 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock controller bindings
Date:   Wed, 15 Mar 2023 07:28:55 +0000
Message-Id: <20230315072902.9298-9-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315072902.9298-1-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 clock driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
new file mode 100644
index 000000000000..5c2dea071b38
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Clock Controller Module Binding
+
+maintainers:
+  - Chi-Fang Li <cfli0@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description: |
+  The MA35D1 clock controller generates clocks for the whole chip,
+  including system clocks and all peripheral clocks.
+
+  See also:
+    include/dt-bindings/clock/ma35d1-clk.h
+
+properties:
+  compatible:
+    items:
+      - const: nuvoton,ma35d1-clk
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: clk_hxt
+
+  assigned-clocks:
+    maxItems: 5
+
+  assigned-clock-rates:
+    maxItems: 5
+
+  nuvoton,pll-mode:
+    description:
+      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
+      EPLL, and VPLL in sequential. The operation mode value 0 is for
+      integer mode, 1 is for fractional mode, and 2 is for spread
+      spectrum mode.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 5
+    items:
+      minimum: 0
+      maximum: 2
+
+  nuvoton,sys:
+    description:
+      Phandle to the system management controller.
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - nuvoton,sys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    clk: clock-controller@40460200 {
+        compatible = "nuvoton,ma35d1-clk", "syscon";
+        reg = <0x40460200 0x100>;
+        #clock-cells = <1>;
+        clocks = <&clk_hxt>;
+        clock-names = "clk_hxt";
+        nuvoton,sys = <&sys>;
+    };
+...
-- 
2.34.1

