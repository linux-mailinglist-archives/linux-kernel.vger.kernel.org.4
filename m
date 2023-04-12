Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C576DEB44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDLFiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDLFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:38:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB655AF;
        Tue, 11 Apr 2023 22:38:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8so8791396pjy.4;
        Tue, 11 Apr 2023 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277922; x=1683869922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pcD9/IFJch2qBlmmRGYiROXPMNW810KBgD8vZ5RxFk=;
        b=ULzUw/lxDylaoqu2Ny2TQpix0htPy4VdYMKnsQgmOySazYaFqQtCDBAcg81gG6eQzO
         ThW1qDEih0GTdjTPA4oS1/b66REL0l8wi04yCxNAdeMeMF+An1P2CmSmwtEyhSuXwbmV
         3ADimyVRNnS8XGlwVFx7LfqUmm5QGsEI8yKD+NW7SlnMEmWqwQUQtU2dq8JcEuQ0PEcS
         zwxbbxP7rDGU47B/Jy0W+ZuXSRUVFR5W1pJhjc8I8YUlxV2U9EYoRSpSgcJiAF1e3WH6
         H7qK0R9bu2rfur2QWyJsp0VWyLwGUGjkQdH+9wm+OFPEutm3VPuycA7/2MY5A4Scntj7
         3aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277922; x=1683869922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pcD9/IFJch2qBlmmRGYiROXPMNW810KBgD8vZ5RxFk=;
        b=LyJGNLSXB31onn5xiqN7NHjsnE9SFTm2MrF37/2mMSd+50lFZRtMDWEqewTgNHLgqk
         v9VBH8KLZmxuxD/liob8ki9oXJYZuLhu/o7dlRZhWT19++c9YRne38wuIpwr8lDU61l2
         V12uUpTE9u3kwEM8onk1XUVuy9m8c+SSOiJpPDbHu4Ih6kCJJWqa1E6bo6bfGKTsNSIV
         rzjM3+i4xtS7919YconFxGPjqvrzoO9J3swMiWT0HPT8azE10Dul/fV80rz3iemp9/O+
         h5TAPazTSRYoYWgWj8Ci1u2wBv92ZTHrZzWaUqk5Q8NKEiAujTbBTXhwanhgP8B7oqfG
         8nJg==
X-Gm-Message-State: AAQBX9cim0W8OV19MjAR9r0ZFQ05+o3AvLrSbInVimJvIk/chw7aSoxV
        sitghOheGbnFtZdXoYceuf0=
X-Google-Smtp-Source: AKy350aHC2TX190DnZrSsEhWxa+9pHpknayo/OjI5oINYjQp/js/SSVZsepTsTffHNlBCDRJEZds+w==
X-Received: by 2002:a17:902:f545:b0:1a6:3d40:d74b with SMTP id h5-20020a170902f54500b001a63d40d74bmr1468468plf.16.1681277921866;
        Tue, 11 Apr 2023 22:38:41 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:41 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1 reset control
Date:   Wed, 12 Apr 2023 05:38:16 +0000
Message-Id: <20230412053824.106-5-ychuang570808@gmail.com>
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

Add the dt-bindings header for Nuvoton ma35d1, that gets shared
between the reset controller and reset references in the dts.
Add documentation to describe nuvoton ma35d1 reset driver.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  46 ++++++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
new file mode 100644
index 000000000000..3ce7dcecd87a
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -0,0 +1,46 @@
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
+    items:
+      - const: nuvoton,ma35d1-reset
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  # system reset controller node:
+  - |
+
+    system-management@40460000 {
+        compatible = "nuvoton,ma35d1-reset", "syscon";
+        reg = <0x40460000 0x200>;
+        #reset-cells = <1>;
+    };
+...
+
diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
new file mode 100644
index 000000000000..44c01e66d06c
--- /dev/null
+++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
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
+#define MA35D1_RESET_DISP	8
+#define MA35D1_RESET_VCAP0	9
+#define MA35D1_RESET_VCAP1	10
+#define MA35D1_RESET_GFX	11
+#define MA35D1_RESET_VDEC	12
+#define MA35D1_RESET_WHC0	13
+#define MA35D1_RESET_WHC1	14
+#define MA35D1_RESET_GMAC0	15
+#define MA35D1_RESET_GMAC1	16
+#define MA35D1_RESET_HWSEM	17
+#define MA35D1_RESET_EBI	18
+#define MA35D1_RESET_HSUSBH0	19
+#define MA35D1_RESET_HSUSBH1	20
+#define MA35D1_RESET_HSUSBD	21
+#define MA35D1_RESET_USBHL	22
+#define MA35D1_RESET_SDH0	23
+#define MA35D1_RESET_SDH1	24
+#define MA35D1_RESET_NAND	25
+#define MA35D1_RESET_GPIO	26
+#define MA35D1_RESET_MCTLP	27
+#define MA35D1_RESET_MCTLC	28
+#define MA35D1_RESET_DDRPUB	29
+#define MA35D1_RESET_TMR0	30
+#define MA35D1_RESET_TMR1	31
+#define MA35D1_RESET_TMR2	32
+#define MA35D1_RESET_TMR3	33
+#define MA35D1_RESET_I2C0	34
+#define MA35D1_RESET_I2C1	35
+#define MA35D1_RESET_I2C2	36
+#define MA35D1_RESET_I2C3	37
+#define MA35D1_RESET_QSPI0	38
+#define MA35D1_RESET_SPI0	39
+#define MA35D1_RESET_SPI1	40
+#define MA35D1_RESET_SPI2	41
+#define MA35D1_RESET_UART0	42
+#define MA35D1_RESET_UART1	43
+#define MA35D1_RESET_UART2	44
+#define MA35D1_RESET_UAER3	45
+#define MA35D1_RESET_UART4	46
+#define MA35D1_RESET_UART5	47
+#define MA35D1_RESET_UART6	48
+#define MA35D1_RESET_UART7	49
+#define MA35D1_RESET_CANFD0	50
+#define MA35D1_RESET_CANFD1	51
+#define MA35D1_RESET_EADC0	52
+#define MA35D1_RESET_I2S0	53
+#define MA35D1_RESET_SC0	54
+#define MA35D1_RESET_SC1	55
+#define MA35D1_RESET_QSPI1	56
+#define MA35D1_RESET_SPI3	57
+#define MA35D1_RESET_EPWM0	58
+#define MA35D1_RESET_EPWM1	59
+#define MA35D1_RESET_QEI0	60
+#define MA35D1_RESET_QEI1	61
+#define MA35D1_RESET_ECAP0	62
+#define MA35D1_RESET_ECAP1	63
+#define MA35D1_RESET_CANFD2	64
+#define MA35D1_RESET_ADC0	65
+#define MA35D1_RESET_TMR4	66
+#define MA35D1_RESET_TMR5	67
+#define MA35D1_RESET_TMR6	68
+#define MA35D1_RESET_TMR7	69
+#define MA35D1_RESET_TMR8	70
+#define MA35D1_RESET_TMR9	71
+#define MA35D1_RESET_TMR10	72
+#define MA35D1_RESET_TMR11	73
+#define MA35D1_RESET_UART8	74
+#define MA35D1_RESET_UART9	75
+#define MA35D1_RESET_UART10	76
+#define MA35D1_RESET_UART11	77
+#define MA35D1_RESET_UART12	78
+#define MA35D1_RESET_UART13	79
+#define MA35D1_RESET_UART14	80
+#define MA35D1_RESET_UART15	81
+#define MA35D1_RESET_UART16	82
+#define MA35D1_RESET_I2S1	83
+#define MA35D1_RESET_I2C4	84
+#define MA35D1_RESET_I2C5	85
+#define MA35D1_RESET_EPWM2	86
+#define MA35D1_RESET_ECAP2	87
+#define MA35D1_RESET_QEI2	88
+#define MA35D1_RESET_CANFD3	89
+#define MA35D1_RESET_KPI	90
+#define MA35D1_RESET_GIC	91
+#define MA35D1_RESET_SSMCC	92
+#define MA35D1_RESET_SSPCC	93
+#define MA35D1_RESET_COUNT	94
+
+#endif
-- 
2.34.1

