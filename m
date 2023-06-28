Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D7740C43
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjF1JDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:03:44 -0400
Received: from mail-psaapc01hn2219.outbound.protection.outlook.com ([52.100.0.219]:47840
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233988AbjF1IuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:50:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6eEqmfotfe2CieZRHgiSvVqgXib3ru99iBV1rb70Y8FFgplEdcJBej5DbVnQtAiNaQZnITo9jd47+0wWTYiccY4ootP+R0zCgPat8+ZqVytXtZkTMOZ3jqXescm/S7Qh7gr4qrWE28CmmSxcYWp3S+ZBXasNqJF6JdxScTCwFoVkIrLRVioj+vgRj2axc8oh7KzNu1jHCTIRGm4JIBTr9Bdc5n5vo2GYVN73qmnCaCKW1PpaAgtecJiW6PSiUv4Nbz6bSEFQM2kobUWkdTigRHJ/43tag1wXop4zH73MK1NUZT7vRDXUhUA9dEOxl4EqMCo7/wc1XYbFaVU8O/Xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQRA5ZBRU41EkIlvTOxbPvp8iacxTwMBx+xczB9TrTM=;
 b=Y8Ph0JKssQCCw9QQlViZWA8zAr0rkyw0xo0hikpcbce8P8CZugp2Xgr1gosesgWlvZJmh2r/ssgAdw3hAA+Kgg9M+BGVnVm+lvSLxscwWHuqouPrkoBeFNxqCvj9D4JL6csb6R/4dt7ksafgvLXGBmnWaY9cHZk58KxGnIWCl/QPqaNJNpXj/gaz0TV8W/4Kq1qCbb6vLAvWoFDKI5ePaCvUeGnZU9Z6Xsd/ZTqq+DAAdSBynjP2gt2cga9pLjQdtztCA+dk0DWVmwBOTvoiMMwStfpMhBlt5UhGwTQOf7yB869arTMAsLo7Cbdfp+SRu8UVd+0ayAd5wawaCWTMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQRA5ZBRU41EkIlvTOxbPvp8iacxTwMBx+xczB9TrTM=;
 b=bG496CSLiv+HermhJdpZXKX3BhujOgvul+yLw6ysjDpWJg5Pe45qI9mPhTPuTYQ4eQxBOy5BcTS4pKoDn2QdnvNgH4pt3hc9HfaBxrIPn8159oLiVftbdL7QMmDQsMHYy/w4mHk/spCcO34U6vpDoqoqvWRaxJMCJGKobsDb7xM=
Received: from PS1PR03CA0017.apcprd03.prod.outlook.com (2603:1096:803:3d::29)
 by KL1PR0302MB5410.apcprd03.prod.outlook.com (2603:1096:820:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 08:50:17 +0000
Received: from PSAAPC01FT040.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:3d:cafe::66) by PS1PR03CA0017.outlook.office365.com
 (2603:1096:803:3d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.18 via Frontend
 Transport; Wed, 28 Jun 2023 08:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 PSAAPC01FT040.mail.protection.outlook.com (10.13.38.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6544.16 via Frontend Transport; Wed, 28 Jun 2023 08:50:16 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 28
 Jun 2023 16:50:14 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 28 Jun
 2023 16:50:14 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.2 via Frontend Transport;
 Wed, 28 Jun 2023 16:50:13 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <YHCHuang@nuvoton.com>,
        <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>, <WTLI@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Date:   Wed, 28 Jun 2023 16:50:09 +0800
Message-ID: <20230628085009.1130318-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT040:EE_|KL1PR0302MB5410:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3c9c46-076b-4bcf-0177-08db77b4b209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQPrZ5A5Kqyh0ld690WYv7TbIrcC9hoDeiE/NiyHLf2vNtG2uvYk1ZRpAbx13yKqQTug3TFamYGwtQ7d7uO/nfOwXTkv4O62BWkzmQSTP0lgKTyk2ph6avhep3E9OmZM0tALkQZ1tqx9xaXHCTcRWWlAVmxhNXrS9oRp0yKgLvRflCtTSh8NlVEdBw4Mdq689m8RWWQsUunVLlmFOud9O8gPSmseEYxIlt+SUiwIpZi3I1CEf5wUrNg8EJdieUyLXM169xM2C/Tc/YIvcbC65Pt7g5wdLu98oUhCbSw0DHh8SM8xHidCAGorUHNeBfx1o8YuyqwGsZEMpkaHT1hTWc/lwFQIsnv3B48cmSbgfKrlN2e90F3PHgyPEQ3e1nG4pKHHU7Qg5wf7sBqdnX7Kf31oM+zXTtuEsuethLzVZ5xhqIV6iHvkiEh1y5J1pg6rkJ68b4lBOVVSsnJIrQG8ycCpx3YSQWplpkqRthnWfzc8wGtqEwURo2G5daDk7yj6cIkcHmI6faYz8ZfKdTFrwgENuYCtvz5k1LpUAv5ejEPwsAjnciTK4UN4tqtG/xFHn2jZGouaqfLhufiqv7kqmrzJC90W10HCN+P//Rp7tdup33sTRLlTybhcovZxLX9WIuU+LB/AgwYgjVuBT+2/d1p++YNgiBgdETHimF7VtybsZp0yXkuU+eS5FEaOoEd9DjLeTk4bOgJ4bu/gRm0wImtURicteK5uFQaxRxVoWb0SXrmt5kXSNs8EzzdOTJY5PiMoSrRFIxxxZml8sZo6OL7Kteua3HhQ7lFKK9xsAMWDTZAhvLOWBUF03NniIPXWbM/GBUja9E9RsQL652tLCw==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(5400799015)(451199021)(46966006)(40470700004)(36840700001)(54906003)(966005)(6666004)(478600001)(83380400001)(2616005)(47076005)(36860700001)(336012)(40480700001)(82740400003)(86362001)(40460700003)(34020700004)(426003)(82310400005)(1076003)(26005)(107886003)(186003)(81166007)(2906002)(4326008)(36756003)(6916009)(8936002)(41300700001)(70206006)(70586007)(316002)(356005)(7416002)(8676002)(5660300002)(12100799033);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 08:50:16.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3c9c46-076b-4bcf-0177-08db77b4b209
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT040.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5410
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NAU8821 audio CODEC bindings to DT schema.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nau8821.txt     |  55 --------
 .../bindings/sound/nuvoton,nau8821.yaml       | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nau8821.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml

diff --git a/Documentation/devicetree/bindings/sound/nau8821.txt b/Documentation/devicetree/bindings/sound/nau8821.txt
deleted file mode 100644
index 7c84e7c7327a..000000000000
--- a/Documentation/devicetree/bindings/sound/nau8821.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Nuvoton NAU88L21 audio codec
-
-This device supports I2C only.
-
-Required properties:
-  - compatible : Must be "nuvoton,nau8821"
-
-  - reg : the I2C address of the device. This is either 0x1B (CSB=0) or 0x54 (CSB=1).
-
-Optional properties:
-  - nuvoton,jkdet-enable: Enable jack detection via JKDET pin.
-  - nuvoton,jkdet-pull-enable: Enable JKDET pin pull. If set - pin pull enabled,
-      otherwise pin in high impedance state.
-  - nuvoton,jkdet-pull-up: Pull-up JKDET pin. If set then JKDET pin is pull up, otherwise pull down.
-  - nuvoton,jkdet-polarity: JKDET pin polarity. 0 - active high, 1 - active low.
-
-  - nuvoton,vref-impedance: VREF Impedance selection
-      0 - Open
-      1 - 25 kOhm
-      2 - 125 kOhm
-      3 - 2.5 kOhm
-
-  - nuvoton,micbias-voltage: Micbias voltage level.
-      0 - VDDA
-      1 - VDDA
-      2 - VDDA * 1.1
-      3 - VDDA * 1.2
-      4 - VDDA * 1.3
-      5 - VDDA * 1.4
-      6 - VDDA * 1.53
-      7 - VDDA * 1.53
-
-  - nuvoton,jack-insert-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
-  - nuvoton,jack-eject-debounce: number from 0 to 7 that sets debounce time to 2^(n+2) ms
-
-  - nuvoton,dmic-clk-threshold: the ADC threshold of DMIC clock.
-  - nuvoton,key_enable: Headset button detection switch.
-
-Example:
-
-  headset: nau8821@1b {
-      compatible = "nuvoton,nau8821";
-      reg = <0x1b>;
-      interrupt-parent = <&gpio>;
-      interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
-      nuvoton,jkdet-enable;
-      nuvoton,jkdet-pull-enable;
-      nuvoton,jkdet-pull-up;
-      nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
-      nuvoton,vref-impedance = <2>;
-      nuvoton,micbias-voltage = <6>;
-      nuvoton,jack-insert-debounce = <7>;
-      nuvoton,jack-eject-debounce = <7>;
-      nuvoton,dmic-clk-threshold = 3072000;
-  };
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
new file mode 100644
index 000000000000..fc2f4ce4db88
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8821.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NAU88L21 audio codec
+
+maintainers:
+  - Seven Lee <wtli@nuvoton.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,nau8821
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nuvoton,jkdet-enable:
+    description: Enable jack detection via JKDET pin.
+    type: boolean
+
+  nuvoton,jkdet-pull-enable:
+    description: Enable JKDET pin pull. If set - pin pull enabled,
+      otherwise pin in high impedance state.
+    type: boolean
+
+  nuvoton,jkdet-pull-up:
+    description: Pull-up JKDET pin. If set then JKDET pin is pull up,
+      otherwise pull down.
+    type: boolean
+
+  nuvoton,key-enable:
+    description: handles key press detection.
+    type: boolean
+
+  nuvoton,jkdet-polarity:
+    description: JKDET pin polarity.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # active high
+      - 1 # active low
+    default: 1
+
+  nuvoton,micbias-voltage:
+    description: MICBIAS output level select.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # VDDA
+      - 1 # VDDA * 1
+      - 2 # VDDA * 1.1
+      - 3 # VDDA * 1.2
+      - 4 # VDDA * 1.3
+      - 5 # VDDA * 1.4
+      - 6 # VDDA * 1.53
+      - 7 # VDDA * 1.53
+    default: 6
+
+  nuvoton,vref-impedance:
+    description: VMID Tie-off impedance select.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # open
+      - 1 # 25KOhms
+      - 2 # 125KOhms
+      - 3 # 2.5KOhms
+    default: 2
+
+  nuvoton,jack-insert-debounce:
+    description: number from 0 to 7 that sets debounce time to 2^(n+2)ms.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 7
+
+  nuvoton,jack-eject-debounce:
+    description: number from 0 to 7 that sets debounce time to 2^(n+2)ms.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 0
+
+  nuvoton,dmic-clk-threshold:
+    description: DMIC clock speed expected value. Unit is Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3072000
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1b {
+            compatible = "nuvoton,nau8821";
+            reg = <0x1b>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+            nuvoton,jkdet-enable;
+            nuvoton,jkdet-pull-enable;
+            nuvoton,jkdet-pull-up;
+            nuvoton,key-enable;
+            nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
+            nuvoton,micbias-voltage = <6>;
+            nuvoton,vref-impedance = <2>;
+            nuvoton,jack-insert-debounce = <7>;
+            nuvoton,jack-eject-debounce = <0>;
+            nuvoton,dmic-clk-threshold = <3072000>;
+            #sound-dai-cells = <0>;
+        };
+    };
-- 
2.25.1

