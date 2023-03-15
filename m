Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F09C6BA952
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCOHcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjCOHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:30:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A06BC20;
        Wed, 15 Mar 2023 00:29:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y2so17849616pjg.3;
        Wed, 15 Mar 2023 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fldN9Z/nRJbM0Lzjn6Ao+M0+u5Fjd53Dn/A88mT7n0=;
        b=cCfPw0XNXBoP3Cx5ZNn2fiS+ZvnSFCz2f5VT3HrzQI1b/wr/oa+iyA02fJcfmFS4AM
         F5hsc6Um2b/gTBgB9CVGzxh4ccLuTThJZ6TofGjsoikw2mwpNrt4A+QGIKAf4TD70tlb
         6uoS44Vqx6m2becMWof1Ni5wiI0rXE0DBJhtedOgJ1kFZdB5Y5EE09QI2f5nIDRoyrkm
         BI5fwQjdQQO/FLg6fD6Bo0fX4DLBm2rRIs+nXDg8kCUtL5Pc5x0rKEiMCJITB8rs+0Wx
         zn2nB/b0HpgxuwghxnbISGzuVbt5Z2pupJIoCaOUDWT9+9MuCLPRogExRlmTkJSrEaR5
         corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fldN9Z/nRJbM0Lzjn6Ao+M0+u5Fjd53Dn/A88mT7n0=;
        b=4mz6wFuDmaDVduSpp2ok+3FWnRcct3nfirWiBbnnFz1DgYg+b7UrdUp91op3HRwN8w
         rGkIJd8qvL5mZcng8Uc95EhrQv4B0jLTUQuBO7q/14lXRMIw6FxBJhHgKL/oTSRGIlIP
         BBVlQq37pQJ5uuYQiNGHfOUgwBVVMb8Ca1ckieRH2aqErjV8yp6CQmz8UsjgKL8za9mi
         79jwPiEH9CqDK+gA1rETh4JffDuJ3Vc/qQYH/GwL2HstekgjpAIPsy0vcQRDLOlNmyav
         Xl2xZhGkkpZN2/pvLDbO1V0P9/YomKWJ11cIJweamjSO2rgs7lxlrxhuCiUuj5rrCH5w
         I4Cg==
X-Gm-Message-State: AO0yUKXubKik4Cy/jpPCZKm3Fbh0ZdO0buZunEaKY3cZlTD1e7UM7zk5
        W8tgM/THhEs1CTWS0uB/LSM=
X-Google-Smtp-Source: AK7set9uvYjM0hc4f8jO2M4ynPeHSm/k4K54zkp8yEjgF3TI2QteervwyP5DRnu48YUgo0Q6w3pWkA==
X-Received: by 2002:a17:902:db07:b0:19b:c37:25e7 with SMTP id m7-20020a170902db0700b0019b0c3725e7mr1557259plx.66.1678865373824;
        Wed, 15 Mar 2023 00:29:33 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm2740003plb.94.2023.03.15.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:29:33 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 10/15] dt-bindings: serial: Document ma35d1 uart controller bindings
Date:   Wed, 15 Mar 2023 07:28:57 +0000
Message-Id: <20230315072902.9298-11-ychuang570808@gmail.com>
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

Add documentation to describe nuvoton ma35d1 uart driver bindings.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../serial/nuvoton,ma35d1-serial.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml

diff --git a/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
new file mode 100644
index 000000000000..9daa2efd4734
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
@@ -0,0 +1,52 @@
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
+  - $ref: "serial.yaml"
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
+    aliases {
+        serial0 = &uart0;
+    };
+
+    uart0:serial@40700000 {
+        compatible = "nuvoton,ma35d1-uart";
+        reg = <0x40700000 0x100>;
+        interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk UART0_GATE>;
+    };
+...
-- 
2.34.1

