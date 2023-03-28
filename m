Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823526CB3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjC1CUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjC1CUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:20:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE030E7;
        Mon, 27 Mar 2023 19:19:41 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kq3so10248613plb.13;
        Mon, 27 Mar 2023 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx93At5pvdseQUWEuzHR4lKtVzLOoH38UjA3vGGOuXY=;
        b=RERLN9XPDJ4CkeXmJjO758Lf3jkYm4FC9uTPpJz2j/5ZvCmU9mdLeyL3YVn0BdVvtB
         CTcDE2BTfjSAm2bUsLEWVV9XkhZq8/xT3GlzQlpd/wrsmggAwRmXrKX3LrjFm9hURnBl
         2rSMge0tEgqv6ToTXiT8G74Mjr3k5n2ejQJIa3+LaUmDXkb6FmW6IkO0xZnvrxnHCtVb
         eM6B15snhzYxhnrUoh2GRhQhcaMQ0tHQWI8jDopF69AFZemcwFRA0UJYntDZ8qk3I88h
         YzWuwySYmYgTFJY/lvI53vj/JGXPui1V1YrOvZXrxRoiuJRhFPVfpErzzvT+1W1yxbsb
         OG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx93At5pvdseQUWEuzHR4lKtVzLOoH38UjA3vGGOuXY=;
        b=opNiwTXwcYiM8I/R83yO1FwWO5MmnGe6Cb/LwoBKRqCaykD9FclA59EDuqN/PG9iT2
         TEGM+8CHkkYYQ7fZ7HERRmJ7mg9ZC7t/p6RhGVmze2Hypv8f2fh5/Q1HfB2D9z5EbWvi
         W2SiC/JHp9ohkUmRaUytfWlIXHcQpqy9iMOMF8fbPAvKTrwINLJCsoEKo8LSrrC2FCX+
         GC1Ehgc9wYXDvmwGDvwUPit0xrknzE4s3wb+QRgyDJ3X+UzsLBCa9Oq5Jg34Yyk5feHq
         fVy3RoXDWWYgRAeot+FlTKGkxQnxNd1aQjJ33K6yhpfcDPaZuW3ERg4PbQp4TnbSc+Yt
         fceQ==
X-Gm-Message-State: AAQBX9cl6RLJQ4FvAhQQP+g2MqfjDkdF9CVnTyyJY39D0O0nE4bq3Z/L
        XnRFFLzVXJsOot5WuNfbGa4=
X-Google-Smtp-Source: AKy350Z7JqAP8MxDaCpM4QXfN8rcCDOwmOIay21gL5ttsyR+u9y5UXgReq4OcAsHJAhp9ip6QJy23A==
X-Received: by 2002:a17:90b:1d8e:b0:23f:37b6:48f4 with SMTP id pf14-20020a17090b1d8e00b0023f37b648f4mr14969229pjb.43.1679969980041;
        Mon, 27 Mar 2023 19:19:40 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:39 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart controller
Date:   Tue, 28 Mar 2023 02:19:07 +0000
Message-Id: <20230328021912.177301-8-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add documentation to describe nuvoton ma35d1 uart driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
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

