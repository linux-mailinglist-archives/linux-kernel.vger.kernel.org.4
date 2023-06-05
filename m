Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CED721CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFEEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjFEEIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:08:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB909103;
        Sun,  4 Jun 2023 21:08:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so1495052b3a.2;
        Sun, 04 Jun 2023 21:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685938090; x=1688530090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpWKXTQ7KaKDbEQLhyhWPukZi3exhwFNB7mtgPLK4aY=;
        b=SAESxSAegLGII2+A1u5bdqSPBbMht/4poCK07TNRnZYmM7Mamx1wtsazXVSX78WUOi
         iWuhRCmQuGYYAZU3YrOjC8hZ88YaY0aQT3QexANAVo1MmMGiR6Nf2doyvmc3b6s5d9AX
         AVmg9W3GQK3kwYfLwxW4eaXVPL/YcZ9as5MR6tVGUfIa4cGbdMPm1dMhdx/dxoWxVBPb
         A6tO+kvR1Xl1R01Gal0sViM5FWOsGlg13xe0Q33X6jpSVPvFcX80mJj5aLqbzCgSW5u5
         IW3NEew3Hwca2fQsOd7p/vT3Yf0WK6VRNmCNjPO5izbH+pGN1zSbTw3tFfp4+HANUQfk
         q83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685938090; x=1688530090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpWKXTQ7KaKDbEQLhyhWPukZi3exhwFNB7mtgPLK4aY=;
        b=NaAA7I96YIRZ6mIcdzfubgjs0wQJcTTOBgSvonEymyigH3ml7GQoi6dgGUC8+ePK4G
         ipjkMJU9fnsoJQiHl+auqC/Z6yZyLkpH1PrPHAjN1EmL1P9ecly7au5clogIMnVRv3+f
         RnfjBQyw1FoyFhJhtEXCpeYoCdtgNSFdEDoN0Wk4sgd93Vxr2qULdukFnnm0Ab4PoaNJ
         PwfJtd5IRKt9bve027YLckfw7/cOx/2+A5ZovbG77Jf+YhUteFoEMnAJ9LEGddmzsAj4
         6+PAdJW5SeQ6xfJklcM3wdZ1K+uKa+YzrIu2w0ZDL4sD28h9N/qsJHvj+4/db9EiIXyL
         qJuQ==
X-Gm-Message-State: AC+VfDwJdfjC6s71tXYuyyFrfrxsT9tNk5Yn9AeKxExtV2OKNx2Hg/wW
        jXuFtI22KBz+vbBxpOwwmdM=
X-Google-Smtp-Source: ACHHUZ5gyEgn6VrJPUlfpTDlV29X1Jl7v9xm8K4yT2CwShXPjJruMHysQRoi7RbCt8J9v7JHZwSZOg==
X-Received: by 2002:a05:6a21:3397:b0:115:8be3:3d76 with SMTP id yy23-20020a056a21339700b001158be33d76mr1607159pzb.6.1685938090162;
        Sun, 04 Jun 2023 21:08:10 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm206164plh.170.2023.06.04.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:08:09 -0700 (PDT)
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
Subject: [PATCH v13 04/10] dt-bindings: reset: nuvoton: Document ma35d1 reset control
Date:   Mon,  5 Jun 2023 04:07:43 +0000
Message-Id: <20230605040749.67964-5-ychuang570808@gmail.com>
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

Add the dt-bindings header for Nuvoton ma35d1, that gets shared
between the reset controller and reset references in the dts.
Add documentation to describe nuvoton ma35d1 reset driver.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  45 ++++++++
 .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
 create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
new file mode 100644
index 000000000000..34c5c1c08ec1
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -0,0 +1,45 @@
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
+        compatible = "nuvoton,ma35d1-reset";
+        reg = <0x40460000 0x200>;
+        #reset-cells = <1>;
+    };
+...
+
diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
new file mode 100644
index 000000000000..2e99ee0d68c5
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
+#define MA35D1_RESET_UART3	45
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

