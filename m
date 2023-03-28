Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9156CB3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjC1CTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjC1CTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:19:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33B2715;
        Mon, 27 Mar 2023 19:19:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so13741901pjp.1;
        Mon, 27 Mar 2023 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlMZWXI0BqpjxcDo3vioPoQp6EHN6TdIk4431Kd79Vo=;
        b=R4kIHWP6FtqQWttzMUdipv3eix4i3tQADsRWvc70fZ6dB4A2Ao65MHMv9n09qApbMD
         lg2wl1vyjLvNPVpwBU23w0UrmsemjM/zTPu3AAecbT3kfdrlA3f12znCAL+hRa22YChq
         Z/UiZQmDaUAnXDa0KHUFoTguVDozNSXfj2v9+CBRLBtzwWad/6StCTgibderqoDGZNwA
         CV2sGjlMI4RMyN7cwYjG+HonFmwfJEAhK6AF6KOTlVnX98MOoWE5kearIBMs9wI1cHhI
         V1Nwlkw7idM/FIy0AXCLQLXrK3K/uXOWu+OfxJgLlen0GmKfL669L38ffstw7nwI7uly
         vKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlMZWXI0BqpjxcDo3vioPoQp6EHN6TdIk4431Kd79Vo=;
        b=twgtrOBh/n2RnLs6uDyoxE+KKm8u1tph00Gkpo34qzMqvik6yq1avyFX484K52hco/
         iEiSLjDkEeekG9yTVVgy/pHrmJPyROtSBg8mvhDNxNKqV+U1qFMAS26l2fvN6OJeG0jd
         ny4AUAufadwxXGvHbnxRmZRKLiE8r8j904yF8k2ndsKxxhcGhQJYrd3ZpmJNxHn9Zt77
         M/1k+s0tSyf8FFxHHKlwEQUx88O0hD56ZZ2XohZ2YsmQ5bXfLwH/saGMiDQmrXQD4uzo
         RcCcKHtgU0NFrO0Adx5lQSgd/fgcTAj2g6CX/p5hqmIls98d+w8MmI4dKKpf6MSWh27G
         9lbg==
X-Gm-Message-State: AAQBX9dyQTMaaKtLnUPE7awsXjGGgE9GgmgJnaWE3lYNgHMwZ3HgJjgV
        ya82zGAz83x0o3QRFzN+y6Y=
X-Google-Smtp-Source: AKy350bOjFMN4qrmBxHTmxvriKn7u42SHrZx7W4llTbNEQjJGn2j7xU2CiDmHsDqiHuxkvGAXAGRRw==
X-Received: by 2002:a17:90b:3c49:b0:23d:19c6:84b7 with SMTP id pm9-20020a17090b3c4900b0023d19c684b7mr14798947pjb.16.1679969971250;
        Mon, 27 Mar 2023 19:19:31 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:31 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for ma35d1 IP reset control
Date:   Tue, 28 Mar 2023 02:19:04 +0000
Message-Id: <20230328021912.177301-5-ychuang570808@gmail.com>
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

Add the dt-bindings header for Nuvoton ma35d1, that gets shared
between the reset controller and reset references in the dts.
Add documentation to describe nuvoton ma35d1 reset driver.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  44 +++++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
new file mode 100644
index 000000000000..342717257e5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -0,0 +1,44 @@
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
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  # system reset controller node:
+  - |
+
+    system-management@40460000 {
+        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
+        reg = <0x40460000 0x200>;
+
+        reset-controller {
+            compatible = "nuvoton,ma35d1-reset";
+            #reset-cells = <1>;
+        };
+    };
+...
+
diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
new file mode 100644
index 000000000000..f3088bc0afec
--- /dev/null
+++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Nuvoton Technologies.
+ * Author: Chi-Fen Li <cfli0@nuvoton.com>
+ *
+ * Device Tree binding constants for MA35D1 reset controller.
+ */
+
+#ifndef __DT_BINDINGS_RESET_MA35D1_H
+#define __DT_BINDINGS_RESET_MA35D1_H
+
+#define MA35D1_RESET_CHIP	0
+#define MA35D1_RESET_CA35CR0	1
+#define MA35D1_RESET_CA35CR1	2
+#define MA35D1_RESET_CM4	3
+#define MA35D1_RESET_PDMA0	4
+#define MA35D1_RESET_PDMA1	5
+#define MA35D1_RESET_PDMA2	6
+#define MA35D1_RESET_PDMA3	7
+#define MA35D1_RESET_DISP	9
+#define MA35D1_RESET_VCAP0	10
+#define MA35D1_RESET_VCAP1	11
+#define MA35D1_RESET_GFX	12
+#define MA35D1_RESET_VDEC	13
+#define MA35D1_RESET_WHC0	14
+#define MA35D1_RESET_WHC1	15
+#define MA35D1_RESET_GMAC0	16
+#define MA35D1_RESET_GMAC1	17
+#define MA35D1_RESET_HWSEM	18
+#define MA35D1_RESET_EBI	19
+#define MA35D1_RESET_HSUSBH0	20
+#define MA35D1_RESET_HSUSBH1	21
+#define MA35D1_RESET_HSUSBD	22
+#define MA35D1_RESET_USBHL	23
+#define MA35D1_RESET_SDH0	24
+#define MA35D1_RESET_SDH1	25
+#define MA35D1_RESET_NAND	26
+#define MA35D1_RESET_GPIO	27
+#define MA35D1_RESET_MCTLP	28
+#define MA35D1_RESET_MCTLC	29
+#define MA35D1_RESET_DDRPUB	30
+#define MA35D1_RESET_TMR0	34
+#define MA35D1_RESET_TMR1	35
+#define MA35D1_RESET_TMR2	36
+#define MA35D1_RESET_TMR3	37
+#define MA35D1_RESET_I2C0	40
+#define MA35D1_RESET_I2C1	41
+#define MA35D1_RESET_I2C2	42
+#define MA35D1_RESET_I2C3	43
+#define MA35D1_RESET_QSPI0	44
+#define MA35D1_RESET_SPI0	45
+#define MA35D1_RESET_SPI1	46
+#define MA35D1_RESET_SPI2	47
+#define MA35D1_RESET_UART0	48
+#define MA35D1_RESET_UART1	49
+#define MA35D1_RESET_UART2	50
+#define MA35D1_RESET_UAER3	51
+#define MA35D1_RESET_UART4	52
+#define MA35D1_RESET_UART5	53
+#define MA35D1_RESET_UART6	54
+#define MA35D1_RESET_UART7	55
+#define MA35D1_RESET_CANFD0	56
+#define MA35D1_RESET_CANFD1	57
+#define MA35D1_RESET_EADC0	60
+#define MA35D1_RESET_I2S0	61
+#define MA35D1_RESET_SC0	64
+#define MA35D1_RESET_SC1	65
+#define MA35D1_RESET_QSPI1	68
+#define MA35D1_RESET_SPI3	70
+#define MA35D1_RESET_EPWM0	80
+#define MA35D1_RESET_EPWM1	81
+#define MA35D1_RESET_QEI0	86
+#define MA35D1_RESET_QEI1	87
+#define MA35D1_RESET_ECAP0	90
+#define MA35D1_RESET_ECAP1	91
+#define MA35D1_RESET_CANFD2	92
+#define MA35D1_RESET_ADC0	95
+#define MA35D1_RESET_TMR4	96
+#define MA35D1_RESET_TMR5	97
+#define MA35D1_RESET_TMR6	98
+#define MA35D1_RESET_TMR7	99
+#define MA35D1_RESET_TMR8	100
+#define MA35D1_RESET_TMR9	101
+#define MA35D1_RESET_TMR10	102
+#define MA35D1_RESET_TMR11	103
+#define MA35D1_RESET_UART8	104
+#define MA35D1_RESET_UART9	105
+#define MA35D1_RESET_UART10	106
+#define MA35D1_RESET_UART11	107
+#define MA35D1_RESET_UART12	108
+#define MA35D1_RESET_UART13	109
+#define MA35D1_RESET_UART14	110
+#define MA35D1_RESET_UART15	111
+#define MA35D1_RESET_UART16	112
+#define MA35D1_RESET_I2S1	113
+#define MA35D1_RESET_I2C4	114
+#define MA35D1_RESET_I2C5	115
+#define MA35D1_RESET_EPWM2	116
+#define MA35D1_RESET_ECAP2	117
+#define MA35D1_RESET_QEI2	118
+#define MA35D1_RESET_CANFD3	119
+#define MA35D1_RESET_KPI	120
+#define MA35D1_RESET_GIC	124
+#define MA35D1_RESET_SSMCC	126
+#define MA35D1_RESET_SSPCC	127
+#define MA35D1_RESET_COUNT	128
+
+#endif
-- 
2.34.1

