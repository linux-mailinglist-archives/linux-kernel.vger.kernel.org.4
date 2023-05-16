Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2627046FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjEPHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjEPHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:52:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF3530C2;
        Tue, 16 May 2023 00:52:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ab2a37812so3520609b3a.1;
        Tue, 16 May 2023 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684223555; x=1686815555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLc5jEICyGFPtj5UVRr/46bNpOgUxZnI7Pfi7aWcdhA=;
        b=BG0lknZxh12uTEWSrfplFkwrbZMMaNrKWTBV+4hgRcfYfjNchIklfZY1/GLY1j9mdM
         zgeed9soweL+idvbUi26iHNHISg7vZ6jlqP2v4YE9Z2ag7sVHVwlr8qI/n2sY8Cvs8kM
         g/9cOFCH4eYyB+oTdHVzt0BYKHbi/R3qhWxHxP+34/gxRonlDu2DPjzcuK8soHVlNrxI
         KlD1mcHA/BETGzykEcgQycGABUEZjAkzAJMcI4lhcGkVloSITXVWRc1a/00oJcyFDoiT
         r5/vWDvhckjKQhHKgVBfCLWQNrD7TKLRjmM0JfTrG3XpkKwGRjH6V8e8AXVj+tFGbIpx
         KzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223555; x=1686815555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLc5jEICyGFPtj5UVRr/46bNpOgUxZnI7Pfi7aWcdhA=;
        b=Bx8weYpbnYycLrRw0QFhbxKYcHAWvOLF1cQlCwJDCQNxTuI7t38P7/oILXqjGXIFsJ
         YQfayWAZaveTy6nU//xFSxqZmFpr9B1kRLwYRzq8uyOMVRwOFd89v8N7Y1zzehAnehcs
         SfBn715t9fIoiAbMXfOc27caKGf5hRHKGFbJWRZD8gk6E5oZlnT9tzNsPzJ9Wqt2kRuW
         J/1X2ZrXarIbbTQwJIkgFNifVXcrj4TAC1CYVlgN0QgAk0JpYVAWHOrm61IN3U3jsifR
         LqB7sGxzwVEg2lsS+gWsrAN9Gw57bS7SeepjdTXwXkY9BuqAsoYkNsGvCia649HBvntY
         2OuA==
X-Gm-Message-State: AC+VfDwa/fs1DrI9gCVWsTUckUBBwKAc69I+c8S5MS8ImLKYRRFRYTQG
        shM5WFk1Z5W4NmVPjdcIAHQ=
X-Google-Smtp-Source: ACHHUZ47BWGggQh63uYIA/VCFNpKmj2XcfQfsfxgL5GhgmyuD3IPXDx7tMsqqDxkfiSZLuE0UlKg8g==
X-Received: by 2002:a17:902:c405:b0:1ad:d95d:ca9c with SMTP id k5-20020a170902c40500b001add95dca9cmr22981535plk.15.1684223555022;
        Tue, 16 May 2023 00:52:35 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001ab061e352bsm4793043plh.195.2023.05.16.00.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:52:34 -0700 (PDT)
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
Subject: [PATCH v11 03/10] dt-bindings: clock: nuvoton: add binding for ma35d1 clock controller
Date:   Tue, 16 May 2023 07:52:10 +0000
Message-Id: <20230516075217.205401-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075217.205401-1-ychuang570808@gmail.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add the dt-bindings header for Nuvoton ma35d1, that gets shared
between the clock controller and clock references in the dts.
Add documentation to describe nuvoton ma35d1 clock driver.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  63 +++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 253 ++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
new file mode 100644
index 000000000000..8f0c43683729
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Clock Controller Module
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
+  nuvoton,pll-mode:
+    description:
+      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
+      EPLL, and VPLL in sequential.
+    maxItems: 5
+    items:
+      enum:
+        - integer
+        - fractional
+        - spread-spectrum
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+
+    clock-controller@40460200 {
+        compatible = "nuvoton,ma35d1-clk";
+        reg = <0x40460200 0x100>;
+        #clock-cells = <1>;
+        clocks = <&clk_hxt>;
+    };
+...
diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
new file mode 100644
index 000000000000..ba2d70f776a6
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Nuvoton Technologies.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H
+#define __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H
+
+/* external and internal oscillator clocks */
+#define HXT		0
+#define HXT_GATE	1
+#define LXT		2
+#define LXT_GATE	3
+#define HIRC		4
+#define HIRC_GATE	5
+#define LIRC		6
+#define LIRC_GATE	7
+/* PLLs */
+#define CAPLL		8
+#define SYSPLL		9
+#define DDRPLL		10
+#define APLL		11
+#define EPLL		12
+#define VPLL		13
+/* EPLL divider */
+#define EPLL_DIV2	14
+#define EPLL_DIV4	15
+#define EPLL_DIV8	16
+/* CPU clock, system clock, AXI, HCLK and PCLK */
+#define CA35CLK_MUX	17
+#define AXICLK_DIV2	18
+#define AXICLK_DIV4	19
+#define AXICLK_MUX	20
+#define SYSCLK0_MUX	21
+#define SYSCLK1_MUX	22
+#define SYSCLK1_DIV2	23
+#define HCLK0		24
+#define HCLK1		25
+#define HCLK2		26
+#define PCLK0		27
+#define PCLK1		28
+#define PCLK2		29
+#define HCLK3		30
+#define PCLK3		31
+#define PCLK4		32
+/* AXI and AHB peripheral clocks */
+#define USBPHY0		33
+#define USBPHY1		34
+#define DDR0_GATE	35
+#define DDR6_GATE	36
+#define CAN0_MUX	37
+#define CAN0_DIV	38
+#define CAN0_GATE	39
+#define CAN1_MUX	40
+#define CAN1_DIV	41
+#define CAN1_GATE	42
+#define CAN2_MUX	43
+#define CAN2_DIV	44
+#define CAN2_GATE	45
+#define CAN3_MUX	46
+#define CAN3_DIV	47
+#define CAN3_GATE	48
+#define SDH0_MUX	49
+#define SDH0_GATE	50
+#define SDH1_MUX	51
+#define SDH1_GATE	52
+#define NAND_GATE	53
+#define USBD_GATE	54
+#define USBH_GATE	55
+#define HUSBH0_GATE	56
+#define HUSBH1_GATE	57
+#define GFX_MUX		58
+#define GFX_GATE	59
+#define VC8K_GATE	60
+#define DCU_MUX		61
+#define DCU_GATE	62
+#define DCUP_DIV	63
+#define EMAC0_GATE	64
+#define EMAC1_GATE	65
+#define CCAP0_MUX	66
+#define CCAP0_DIV	67
+#define CCAP0_GATE	68
+#define CCAP1_MUX	69
+#define CCAP1_DIV	70
+#define CCAP1_GATE	71
+#define PDMA0_GATE	72
+#define PDMA1_GATE	73
+#define PDMA2_GATE	74
+#define PDMA3_GATE	75
+#define WH0_GATE	76
+#define WH1_GATE	77
+#define HWS_GATE	78
+#define EBI_GATE	79
+#define SRAM0_GATE	80
+#define SRAM1_GATE	81
+#define ROM_GATE	82
+#define TRA_GATE	83
+#define DBG_MUX		84
+#define DBG_GATE	85
+#define CKO_MUX		86
+#define CKO_DIV		87
+#define CKO_GATE	88
+#define GTMR_GATE	89
+#define GPA_GATE	90
+#define GPB_GATE	91
+#define GPC_GATE	92
+#define GPD_GATE	93
+#define GPE_GATE	94
+#define GPF_GATE	95
+#define GPG_GATE	96
+#define GPH_GATE	97
+#define GPI_GATE	98
+#define GPJ_GATE	99
+#define GPK_GATE	100
+#define GPL_GATE	101
+#define GPM_GATE	102
+#define GPN_GATE	103
+/* APB peripheral clocks */
+#define TMR0_MUX	104
+#define TMR0_GATE	105
+#define TMR1_MUX	106
+#define TMR1_GATE	107
+#define TMR2_MUX	108
+#define TMR2_GATE	109
+#define TMR3_MUX	110
+#define TMR3_GATE	111
+#define TMR4_MUX	112
+#define TMR4_GATE	113
+#define TMR5_MUX	114
+#define TMR5_GATE	115
+#define TMR6_MUX	116
+#define TMR6_GATE	117
+#define TMR7_MUX	118
+#define TMR7_GATE	119
+#define TMR8_MUX	120
+#define TMR8_GATE	121
+#define TMR9_MUX	122
+#define TMR9_GATE	123
+#define TMR10_MUX	124
+#define TMR10_GATE	125
+#define TMR11_MUX	126
+#define TMR11_GATE	127
+#define UART0_MUX	128
+#define UART0_DIV	129
+#define UART0_GATE	130
+#define UART1_MUX	131
+#define UART1_DIV	132
+#define UART1_GATE	133
+#define UART2_MUX	134
+#define UART2_DIV	135
+#define UART2_GATE	136
+#define UART3_MUX	137
+#define UART3_DIV	138
+#define UART3_GATE	139
+#define UART4_MUX	140
+#define UART4_DIV	141
+#define UART4_GATE	142
+#define UART5_MUX	143
+#define UART5_DIV	144
+#define UART5_GATE	145
+#define UART6_MUX	146
+#define UART6_DIV	147
+#define UART6_GATE	148
+#define UART7_MUX	149
+#define UART7_DIV	150
+#define UART7_GATE	151
+#define UART8_MUX	152
+#define UART8_DIV	153
+#define UART8_GATE	154
+#define UART9_MUX	155
+#define UART9_DIV	156
+#define UART9_GATE	157
+#define UART10_MUX	158
+#define UART10_DIV	159
+#define UART10_GATE	160
+#define UART11_MUX	161
+#define UART11_DIV	162
+#define UART11_GATE	163
+#define UART12_MUX	164
+#define UART12_DIV	165
+#define UART12_GATE	166
+#define UART13_MUX	167
+#define UART13_DIV	168
+#define UART13_GATE	169
+#define UART14_MUX	170
+#define UART14_DIV	171
+#define UART14_GATE	172
+#define UART15_MUX	173
+#define UART15_DIV	174
+#define UART15_GATE	175
+#define UART16_MUX	176
+#define UART16_DIV	177
+#define UART16_GATE	178
+#define RTC_GATE	179
+#define DDR_GATE	180
+#define KPI_MUX		181
+#define KPI_DIV		182
+#define KPI_GATE	183
+#define I2C0_GATE	184
+#define I2C1_GATE	185
+#define I2C2_GATE	186
+#define I2C3_GATE	187
+#define I2C4_GATE	188
+#define I2C5_GATE	189
+#define QSPI0_MUX	190
+#define QSPI0_GATE	191
+#define QSPI1_MUX	192
+#define QSPI1_GATE	193
+#define SMC0_MUX	194
+#define SMC0_DIV	195
+#define SMC0_GATE	196
+#define SMC1_MUX	197
+#define SMC1_DIV	198
+#define SMC1_GATE	199
+#define WDT0_MUX	200
+#define WDT0_GATE	201
+#define WDT1_MUX	202
+#define WDT1_GATE	203
+#define WDT2_MUX	204
+#define WDT2_GATE	205
+#define WWDT0_MUX	206
+#define WWDT1_MUX	207
+#define WWDT2_MUX	208
+#define EPWM0_GATE	209
+#define EPWM1_GATE	210
+#define EPWM2_GATE	211
+#define I2S0_MUX	212
+#define I2S0_GATE	213
+#define I2S1_MUX	214
+#define I2S1_GATE	215
+#define SSMCC_GATE	216
+#define SSPCC_GATE	217
+#define SPI0_MUX	218
+#define SPI0_GATE	219
+#define SPI1_MUX	220
+#define SPI1_GATE	221
+#define SPI2_MUX	222
+#define SPI2_GATE	223
+#define SPI3_MUX	224
+#define SPI3_GATE	225
+#define ECAP0_GATE	226
+#define ECAP1_GATE	227
+#define ECAP2_GATE	228
+#define QEI0_GATE	229
+#define QEI1_GATE	230
+#define QEI2_GATE	231
+#define ADC_DIV		232
+#define ADC_GATE	233
+#define EADC_DIV	234
+#define EADC_GATE	235
+#define	CLK_MAX_IDX	236
+
+#endif /* __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H */
-- 
2.34.1

