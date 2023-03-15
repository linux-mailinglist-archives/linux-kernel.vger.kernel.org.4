Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E86BA94B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjCOHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCOHaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F86189;
        Wed, 15 Mar 2023 00:29:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so959428pjg.4;
        Wed, 15 Mar 2023 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE/RI5yAOmxYBkNdq6c6SaQJoz6IKg1o0eGLwh6Y5Vk=;
        b=KR3aumpweHk0yvAaO6rW2bGN3V9OFwxsn6B1VNC/0BKjPFik3L0UomGuopEKhDEUjj
         hPA4WCwG6TZF2d5Z1BaVQiWBdCHfumy0UiP6emCEjfRbnOb0tlD142w18syChlDnLWCD
         Nzl1v+bW+N4F8aR0R/5Yd+fTpzp8yiQbD0yE0G30Fv2js6kiiVLRLSFOQkGgmCWXvMnF
         e0mBrgk2+Zynmy8osmHYpmhr6EppSJ4BZ56Ap505SDMjZV61dnsq2r3XTldTjqVjB/EE
         qhhtdwp7csWy2Tkd0V/YzbwFFzogR1Xa3wOdItVDIlwiogHGphV1n6UMWe5lBd8HBrX/
         Ii+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE/RI5yAOmxYBkNdq6c6SaQJoz6IKg1o0eGLwh6Y5Vk=;
        b=ibVSBpce0KYB0Z/nEjnmgrAEzBMnUW8vZu3fCdquTA26Wc/i6tRWTiQdnFr1Luw+T6
         wXmCbjwq2sBnBwkhuMSe7UKJ3w+hHSTN7q+ZUqtVvd7k1avw2K57BGrB8XZwv+g99Bm0
         +NLRoINmJI3AmA6BZjEQf8d+ZJF71GwADSZGVymqS9wK3RM4tcnPLlGiNCxdO2pYZVC7
         UpyGWPyEdyy0ULH1wix5VL6p/wUHX2lnpA3fKI5J6tcYDDze4DxwZw4dTEr79HL3u6uH
         Va9tssPLK2HbOD/4MhmJoFUQeyfx19/MT/lKesLaqGihuxScZSqRRGTTn4IxVorHJmEH
         Ou6g==
X-Gm-Message-State: AO0yUKXGPn5MEqksPf/YCqzsLXdTAffFlZUq2WNI4A4aYSyKtGflcsk3
        VIB27bdTuhnIhLEVVzU5w0U=
X-Google-Smtp-Source: AK7set8W0U2XX7TDLAyXOn6kzIRDZWJHkurE6WdftDOlmtmeqlTt5pP9O1KblsUaYDqQqny9rVZkUQ==
X-Received: by 2002:a17:902:dac8:b0:1a0:763f:2445 with SMTP id q8-20020a170902dac800b001a0763f2445mr2031945plx.11.1678865371300;
        Wed, 15 Mar 2023 00:29:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:31 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset controller bindings
Date:   Wed, 15 Mar 2023 07:28:56 +0000
Message-Id: <20230315072902.9298-10-ychuang570808@gmail.com>
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

Add documentation to describe nuvoton ma35d1 reset driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
new file mode 100644
index 000000000000..f66c566c6dce
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Reset Controller
+
+maintainers:
+  - Chi-Fang Li <cfli0@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+description:
+  The system reset controller can be used to reset various peripheral
+  controllers in MA35D1 SoC.
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-reset
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the register map node.
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - regmap
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  # system reset controller node:
+  - |
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    sys: system-management@40460000 {
+        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
+        reg = <0x40460000 0x200>;
+
+        reset: reset-controller {
+            compatible = "nuvoton,ma35d1-reset";
+            regmap = <&sys>;
+            #reset-cells = <1>;
+        };
+    };
+...
-- 
2.34.1

