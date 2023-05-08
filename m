Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C466F9E04
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEHDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjEHDAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:00:20 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB96150D0;
        Sun,  7 May 2023 20:00:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64384274895so2775063b3a.2;
        Sun, 07 May 2023 20:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683514805; x=1686106805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=aCR8GUSsXByUpHiRa3dL9AIHKvB54VBNxXwWDm/A6XsS/ZKlaumG+Uh6o1AfvQlAIq
         j0Umd6yLRM1R2/WdLlw2yQXNEeV5DMLcrugp9liXKm92BISeRoUjw/mpg3io+H97mtO9
         klHyVdFZmX+HZDIOLI9G4DSKqaZbNIOCGhhTxO/T7soTsplvBi+4OBZiHcLzBINagRbn
         asV4cLa+OxstT4mtbZe2PvG8v9rRc43x2BNI3CqUjDeWlUheZQiaJFULAT2xDFcnSs9f
         iEb6BTGm6xAaEIO/vBTSxuS5PTVCmNFo6UxV+5X8ZDJPDOHrOICwh0DKTgG2yRVFGZK5
         RMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683514805; x=1686106805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lQgRTbL4lTQDPfHV5KDSXk3n/APm71Tse6u2f9wX4A=;
        b=FAYLIU3l+F+7HaQrof3onEHKlLpuk1VJGdbP/Uq4+HQcW2QwmkTSRPDSRTAeCTXsxa
         Fd+BlNRLPQu2m5EwJLtynPwojqnIys+QuE9kg+MwK2Q3ufdn4QSmtsSWKWwzrEjaLPAE
         QBUZ7FycamYj/zujK2yIAi+fA+rVNlKqOOSN4qF1zNKQHatXX2DCzBEgFnDwKA7/q8cL
         EqapwxerPkiBehOxsMsyafpsU81i+Dz4J9c8W4XJH8XJyJgqg5LTgmJvw8jIlMDAobKD
         OdiYUqfQqwLZ/I8Hp2ddek5RTd+hJtjeU0uAEhGosDH9cdyn598K6KnbTJv0ulHgZzCS
         JRmw==
X-Gm-Message-State: AC+VfDwqrEZ6DBU2QchVIrmE+0ZWcjCBiojXpD2/fUdyJndibCedWzw3
        4gJ8vxIADlotCc+Oo//seU4=
X-Google-Smtp-Source: ACHHUZ4Jmy3UND8GoBdkjqs7iJzPX0WYBOtoFndOhmbPr55BU4gUNTAWWdUHFBTgzKCbKyn8/EWOxA==
X-Received: by 2002:a05:6a21:9015:b0:e7:56ad:5a40 with SMTP id tq21-20020a056a21901500b000e756ad5a40mr8852418pzb.36.1683514804726;
        Sun, 07 May 2023 20:00:04 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b0064559b58eb8sm1525422pfn.154.2023.05.07.20.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 20:00:04 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 06/10] dt-bindings: serial: Document ma35d1 uart controller
Date:   Mon,  8 May 2023 02:59:32 +0000
Message-Id: <20230508025936.36776-7-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508025936.36776-1-ychuang570808@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
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

