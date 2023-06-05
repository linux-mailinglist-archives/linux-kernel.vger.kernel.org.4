Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5043721CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjFEEJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjFEEI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:08:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBFE40;
        Sun,  4 Jun 2023 21:08:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b04949e5baso37958865ad.0;
        Sun, 04 Jun 2023 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685938097; x=1688530097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=dePX/Fs6SmVQCdiOmkjLuhimVD6fEzVIh30IzYMPDTNhFZltF/qwW07BJaDWAPdqM0
         B0yNrWY8TYKqUGoX0y2knTRPi3ophb5kyhxD575VrT8MJl1BhnVasITzUz/hsCUkuJVs
         w/wszy099EjstL7tm3lsaTx8Cgd3AAMaHhr0EUXHuvxadCdTty0t/tOnj+EU1upN4BPd
         cBGxr4uvGqmydhWMxar43LczeQ5PpFYXjlAnWOvX0nrjTLYqOnkWFiEFutl265WR6nb7
         CCcAFICJIWtF0ky8JZpaWvqOBBEwZ5OE/OOvQnDKvtu5LoCXqT+fKkUGwEE4n7jmq59W
         oeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685938097; x=1688530097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=XYGjsv+GH+WAxwNLFH+T8UT3q6ULfa+yaIOizpVqyUTBw8IQL6WnbaA33CXCBB9mq0
         QaMpicAxNq2Vb3GIW2LhgBWkaCUCHbxJHWyQfEoeT8zK+1tAvq5M0fKsa7mNKpLt7bMP
         FQ6GK03bYfqkKxhv5h0u5eoi+QKYC/FM5HSUd7xgYUNnj6YrgFb3+7dwLDCpJ/Wadg8n
         WIPw5+93HrNTL7Fih4tsAnYLskYkBxbvy+E5cqVB9S9oRXsf/IZaMNytk/RfoVFqvSO5
         0IJ5QZdUz6leDaXrqVlVdgpwnZt8s4hAuMwp1cfRL+XqfSnA5Zhiz3hE+PfJUJ7VZJwm
         eMIw==
X-Gm-Message-State: AC+VfDzOh4B195FgiL+ksJTNJT+lPAkGYk9l8jaKbs/uKlnlOzmN3vTo
        adTL3NUQCVJp1v/ihInJg00=
X-Google-Smtp-Source: ACHHUZ6a9mPQ09ZJ0HL4XfYWr8oWVVJy0eIuUMW9lwnXPhZ1Bz+z6Er369wEga+rjf70ZrreLSRujg==
X-Received: by 2002:a17:903:32c6:b0:1ad:cba5:5505 with SMTP id i6-20020a17090332c600b001adcba55505mr7308298plr.14.1685938097524;
        Sun, 04 Jun 2023 21:08:17 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm206164plh.170.2023.06.04.21.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:08:17 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v13 06/10] dt-bindings: serial: Document ma35d1 uart controller
Date:   Mon,  5 Jun 2023 04:07:45 +0000
Message-Id: <20230605040749.67964-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605040749.67964-1-ychuang570808@gmail.com>
References: <20230605040749.67964-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation that describes the nuvoton ma35d1 UART driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../serial/nuvoton,ma35d1-serial.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml

diff --git a/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
new file mode 100644
index 000000000000..a76af0f6009b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nuvoton,ma35d1-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Universal Asynchronous Receiver/Transmitter (UART)
+
+maintainers:
+  - Min-Jen Chen <mjchen@nuvoton.com>
+  - Jacky Huang <ychuang3@nuvoton.com>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    serial@40700000 {
+        compatible = "nuvoton,ma35d1-uart";
+        reg = <0x40700000 0x100>;
+        interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk UART0_GATE>;
+    };
+...
-- 
2.34.1

