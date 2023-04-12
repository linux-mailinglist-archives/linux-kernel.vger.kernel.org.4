Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0A06DEB50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDLFjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDLFjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:39:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874F49FC;
        Tue, 11 Apr 2023 22:38:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n14so35369989plc.8;
        Tue, 11 Apr 2023 22:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277932; x=1683869932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=kkyF7lQhGXqCzBFIwWI46UYDNy451LBl7qMW7Lt7k+d0KNdajPbHtJJbf4r5ag4SI+
         mKkrkijN3gqxXT48bTjxkNdM5tR5iAvKgWltspzt/NlpIAyBtKdWxoUK7A34C0EflAYY
         6vfceOF0v1xeu8lP1loItRqO4QpzMobbD4Or3lfuC1MrVvVsfgKKi1jXdsgFCmrc+MjA
         3/+JCuRg5XUAcuRT8FRBqSDxGXFcAP6+AmpftJI1uwMhtD8QlQVSW4FXqV6svIFuhg2R
         PaN2QgmS9pBmxOlpdlwondgXl3A7NqgjekZIm9rA1xx5kAIqdPVtGs0pY3+s7lzY3BQz
         tQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277932; x=1683869932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=S2jIvxZRG+Gvl5Pwm1kvImcpSXrzbDZ85NKv/knbWIVlrL70AOAFdW18HXo4oGsXEp
         AgHK3mnFmJ7HUzGnh27hPUeT60OQ/5vI5z2R025wJjV2zdO8QpxTzcdsSPuOCKmlHBuP
         oxVsn+r5aIJl5f3XRy3dxDW+koex0N+35LZ1d/tzgYE6/JABkdCDu0fSNuom36h19urU
         h5SqEgYlXlh6CJ2DuI5stssGotR72ReRk6SpS/dqcVEaZ6CrCCXxzaIRPtsdPppEyO23
         pf7PMonWEhRq8ybWjYnMePf2Knv33ep82wfXYCyZlOz5DrPP2+gT2ta+X4tLwt17u2wf
         29uw==
X-Gm-Message-State: AAQBX9frTd6QWk/SGDeIQFMwuNcJMmbImvz+S5Si06REzFZsFWBiY83I
        0lvZrAlXlWt28ZN17fmbneg=
X-Google-Smtp-Source: AKy350Z2hUBwLR0lfamQP4/++4nzlFpXK9zF5h439FKColeYC/khI+/oFQKFsr3HYkIirsdpxLk0EQ==
X-Received: by 2002:a17:902:ec8c:b0:1a6:6bd4:cd8c with SMTP id x12-20020a170902ec8c00b001a66bd4cd8cmr1554701plg.25.1681277932407;
        Tue, 11 Apr 2023 22:38:52 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:52 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 07/12] dt-bindings: serial: Document ma35d1 uart controller
Date:   Wed, 12 Apr 2023 05:38:19 +0000
Message-Id: <20230412053824.106-8-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412053824.106-1-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
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

