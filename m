Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FEA73DC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFZKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:46:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2220.outbound.protection.outlook.com [52.100.164.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E51E60;
        Mon, 26 Jun 2023 03:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRLzQYRIeH8R1i0K0AKmxecqHHAMxlDPFIe82meHA+RRF7X71RlwbyWcUguDLEErS1HKJWJvmXDY6UFa73l228bzC7GwZVgHKnJXnCbeo5HgfdY3XdgO6EnzrQc/F1ROqjuSBHKZlM7hcQBzkRtkoxb9vY4VaX99E5b4X24S7XaqkQEW1t7XSnwY9C7VvG2rxdYaDZS5BhJCuuAm66NXiyYityPPU04aLTZdb3dswaQabB9dYnRVsC8ZzZukKD/OSddrEdDpA6dEgTXNGsCEhDT8oEYfYJAJyAOKzuYH6dD+CfmgCJ/A8h9R/e7FLuJfgSh6+koV18wQ6Rv98uybbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ej0lptjdV2CRtZEzkXS+Gb9EZSadzOdB/EyIUWQ6U=;
 b=Ko/tMeW8MSflKnYpbvUul0npTKktCW57KjDzXWWTZijyL8wFVpSedhLDJ/9y4OnM4BYpTvPK+MLz/6Sm+ve9j7maXacQ4k8dalDhJ4EZPE0mIOJdAQcTaHedjZHMqwmY22eFXPYCKhvfQes8SmU/3nmq932Gy1NmG0T21q/UzkFDPsG3ORUeySMn3oxch6ZpKD4NUe2QzR5isai3d5Alpo2VjX+AuhSi4QF/xo2bYOByQf6dNKJ4ZhpnzcuQkboQ3Y8blsw4ERYfLVxGzCYzQxg74t7ioLlo9vSryv/e8uMYMniNamz5bi5W9H3mB+/d08c8ppn9WGEAakJEfiRdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ej0lptjdV2CRtZEzkXS+Gb9EZSadzOdB/EyIUWQ6U=;
 b=WS9ZFLefmgWJlpzsYZ6uXRIEwhqBKYN0zUo9HgZw2mgZuMrqzms1uYpZ5cbVIJJaa6Og2nMxDdUIKjQE0J/j2V0Zly646Jh9rANpOLe5j7S16MM6Bc+n3CmNgV1A9JHsznp0gF8MbC7Nu4fyZh5tzKrgKHVKPAcGuwCCXKz8Shc=
Received: from TY2PR02CA0006.apcprd02.prod.outlook.com (2603:1096:404:56::18)
 by SEZPR03MB7615.apcprd03.prod.outlook.com (2603:1096:101:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:46:25 +0000
Received: from TYZAPC01FT044.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:56:cafe::89) by TY2PR02CA0006.outlook.office365.com
 (2603:1096:404:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 TYZAPC01FT044.mail.protection.outlook.com (10.118.152.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6544.15 via Frontend Transport; Mon, 26 Jun 2023 10:46:24 +0000
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jun 2023 18:46:23 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Mon, 26 Jun
 2023 18:46:23 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.2 via Frontend Transport;
 Mon, 26 Jun 2023 18:46:23 +0800
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
Date:   Mon, 26 Jun 2023 18:46:19 +0800
Message-ID: <20230626104619.1112588-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT044:EE_|SEZPR03MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: fca53768-e698-43d0-63aa-08db7632968f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZfb1C8ikX8gkj3l8Nvbr+cx1GV2eI1+LEBH/EOHVR8o4Zg3C3P6ALCdrecI2Wf9HxFog6sTSShuqAdwFhTnGocrUXU86MB3tFzpx9pI7MN5HrhTTxTpHdSQeBZUSjUCXo0Z6ioiOukIVtVYRNL0sBN3rgTj8SrjDxpz0mF9kxJkHJ2/p1ep0BY3e/FTa7dz1WL3njq4ZU3qQNfirxJ2rxH/9nZFQVXapiJ5vAhh+MQVzcgTNDMiOtGzgzpPc9hnc1o0awBAQ3NhZr8+NqV9hljZ4sWQ3QsadEhqWzqyJKrxRrGrkNGirdDi2lLcg3KSv6YkxICpfXZDopbD2oox6Xcgeg+9IaR/bp4hHKNfhxr4gZ4olFE6K4V3t1v5iCHWXGpY2AIQVtuLRu01iZBwpu8k6cwDT6MnpEtUqwXZy4ubIAGAbiS92d/bPQ7DWhMy/LA4QeFSb8TaMORlYLPdSc7O3lBYvnc4DN+R6UHp3NfxHNHEsimqZHHzPnYhuGUe3+QbCzN99yQNTFqJKLfQJR+Q/nNRwiz6YgAqlVVsSr//Ek6eh+hpOLCNLScyr2eRfXs8o3zQssqt46nBS2RPpJihNBCWw6TxBzEIDvD4JXpKcB6a+dMGgTIEvlQ3kDdBGK50nzbWxkY+SncDiWsPby9sUn+xi+/KiviiAcmT0U17JsJeBCPqrg/IUSVEq1/zZDogRoBIIQ6cEsgasMiddfYuCY/eSG/s7eX5aj9mnmrQN562E8UULq0G8e2x/z0dCuOTpZZREu1CFzeYXBGji6zMmJhIGE32g1pxgC22ZFkOdK9tbcT4vsqJAf5mmCvErjOHRHHeyQE55nYa8B4a8Q==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(5400799015)(40470700004)(46966006)(36840700001)(2906002)(186003)(26005)(1076003)(426003)(107886003)(47076005)(2616005)(81166007)(336012)(34020700004)(356005)(40480700001)(36860700001)(5660300002)(41300700001)(40460700003)(83380400001)(70586007)(70206006)(8936002)(7416002)(8676002)(36756003)(82740400003)(6666004)(54906003)(86362001)(478600001)(4326008)(966005)(6916009)(316002)(82310400005)(12100799033);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:46:24.8697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca53768-e698-43d0-63aa-08db7632968f
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT044.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NAU8821 audio CODEC bindings to DT schema.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nau8821.txt     |  55 --------
 .../bindings/sound/nuvoton,nau8821.yaml       | 120 ++++++++++++++++++
 2 files changed, 120 insertions(+), 55 deletions(-)
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
index 000000000000..728223d20876
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -0,0 +1,120 @@
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
+      - 0 # open(default)
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
+            #sound-dai-cells = <0>;
+            compatible = "nuvoton,nau8821";
+            reg = <0x1b>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+            nuvoton,jkdet-enable;
+            nuvoton,jkdet-pull-enable;
+            nuvoton,jkdet-pull-up;
+            nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
+            nuvoton,micbias-voltage = <6>;
+            nuvoton,vref-impedance = <2>;
+            nuvoton,jack-insert-debounce = <7>;
+            nuvoton,jack-eject-debounce = <0>;
+            nuvoton,dmic-clk-threshold = <3072000>;
+        };
+    };
-- 
2.25.1

