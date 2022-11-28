Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4A63A0E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiK1FtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiK1Fs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:48:56 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2068.outbound.protection.outlook.com [40.107.249.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797813E1C;
        Sun, 27 Nov 2022 21:48:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra0DNn47z44Dda5HaApPtOnPTKwtDSxk7LWpAPPBMJ/MeLa7kIPA/Tsgm+y4MCO9nrjlzV3gPB73BSFTiKKKUPbMG3tFzEx9KkXt1t7K4UEAD3+u/j32STW9WoqxaH5Sxh0ZaP43eP8p+/h6gQzfCRDyMohsOAkXQE6WrHudpl8hmgJzc75pQTucn5fvHSFr4wz2oqRUVX5VQi9lT2+vfdFiPMqpERMrpMF3CeLqrIhInhTtKbbKMZwX7jI96ESIvHi6c0Jnr/W1FJWAhWOnYm9SUruJvcOMYqEvQul7+9IxVClplUizpbX0yOAkHOvCFwKLENftzyOs6YyK/oR6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKootHdzoY9t+MnBDuNh8njB/oNRECpNI7qyTn6GUSg=;
 b=nvBFGqXrJ4rdiEoDyvUn57ET4otJDF0AUieDi8E5oqWYioSPz5JC+1yRCk4zTo+dNkP6lLMFOp/+agyyzhngefQhhCdJ7+4LhhXBmOrYJeOZqHw+0A6qq4PlFOioWDvStzW0GNHBpWEm1F9b4g8IEEJX5PmZIvN7noHkJlfou9iEbS2UEDNBQxhwo7/pDxwP7r83jdtEHGlqqYJb4NkGwsZZrdlrUowvsuL/y+kDyOBNETJggo3zjsGe5SHpBMeE3NgqP8fR/jClJ+bxQw14P5NRW33GQwszPpaSLwviM8h1WwGmB3OltfWVpfr3/xCxu5zy++IVkuvRGgwE7M0mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKootHdzoY9t+MnBDuNh8njB/oNRECpNI7qyTn6GUSg=;
 b=zMj6Yig0U7tP7b9nkCB9U56K2gKZuonL4X73UEJFzjI2bu8xoUQIbFZeTlmyStCF8MXDP9TPgedz/1/bguzRdUz4kaLV8aqnRELlg8CehHH9lgmQplKTecQMamaUspsoxc8d66A1ER35g6sSG+60Jhpm4D2olcfDI6qUQkff1GWP60zNNTjaoMkUBFM/HSpq0/yoWATw+EOXSB98//dI6XtPb5MLipWNypUv4h7+zVfKLQkJ0UtL1lUYmQiR1Uy6mICZOb8ifAnGEsDfpOWuGaIHP213qgYaF+tMw7Wpq14LbcHrX/5LfcfW+3Qgn2P19227Ny7x5JX/b1gL2ehedA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7829.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 05:48:49 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 05:48:49 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Date:   Mon, 28 Nov 2022 13:48:19 +0800
Message-Id: <20221128054820.1771-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221128054820.1771-1-clin@suse.com>
References: <20221128054820.1771-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 84060feb-66f5-49fa-355f-08dad10438db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvaHHMo6kJbFpw52VMLEKBzAJ3r4ugyVaXeLFE5njCKDCgdXOY5IRPCuKLQ4y3KA8Cl7yw03W+AhZ/rb1FqnkVCVxIpdV8sJ6tWb1FjnBk6gcwOPc7aiJOPsRe3Bo6+1DPYsI+2+8KOKFAIogW0m94Rg70cnHJQhdBiKS22s6Uoy9X/kSCvbCT3VjUiHsy0gb7IZtWonredlOTZbgU/EVLxramJueUVUTahQpoJcoZfNfntOZOwI1lJ2w8itxN9WXVQ98+FNTInKMycD12MrJUX0fAZ1dMdlMjwuPdEb4y6vG5V9wq60xwVz5yjkBFFZzdmV5jDmijArhszqZDDbFWBJ0upIH4Gn1GAXbextOdUxKYlutPkyFyu0Tudm1VhXGJJDveQx/vy7PC5xpZ7ZcKBEWpyt4nhk6MMD/tBee8gbr2sUONnwYkgvydo+mnxqyce2LRFD3NX20Yjw+SjlA3sL4ByqFWloMiVfLK0QBVeYQWHeUAeh5QfxALVVlfBo2yN6MdgSi1BH1FlwStBB97PASQiTJHsrWj/jmrfkZTZjgdiCz5PX/escbL3NFMs7ukaJzYaGArydlo8lFd+l/TXu3Gpi8NIE5ngm3gf53Iat297rN7Kr0lCVvgcJLOyLNijS8JNyDUxj+LfkYOGMeF7Gfj92JnT2UpegfSq8ZAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(86362001)(36756003)(186003)(316002)(1076003)(54906003)(41300700001)(66556008)(66476007)(66946007)(8676002)(110136005)(107886003)(2616005)(5660300002)(6666004)(6512007)(6506007)(4326008)(478600001)(966005)(6486002)(7416002)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dc1SozxD8dNeu/sQUa78O8BQ/zBpXmVdsyqG8ASsMji/M2RqtWQLTr9q8srD?=
 =?us-ascii?Q?UiSycd5kipwRVITQiXOAQ23oJr+8nWbMRC0LBQG8z34KtFG36Z0XfvlSmlkQ?=
 =?us-ascii?Q?BxjV9DHujACQOE6PKER6Oyzk8PPaGU1tAo3TozkGgsSshvu0+BFpmvaRt0oZ?=
 =?us-ascii?Q?A8cmZmnCFQgH7noG+CNOhd0AnG0Bb8VBc2LrI3X9sXPs32bflNBlwmISvPha?=
 =?us-ascii?Q?e8+jvJr2cCbkwHJpX2J/DMe1cxiuk40qIuW4oYQA37M8OO4bpG8QR83Ye3gp?=
 =?us-ascii?Q?ODEzxaOvZ5Cng7unrprSV/AE8UmELqK55cS07UXKRtDrOV5250GiuGQUxb/X?=
 =?us-ascii?Q?VabttIJiXzQD8+kH1MBjS+UC49avMh7MFg1UySsbIdvvyElOSinuTKoOFZV/?=
 =?us-ascii?Q?EIO34/yDcFy8fxVMqCdBjlWxDelUaWVBJNkpq34wLjqEUXSxkNp7xClZbnF9?=
 =?us-ascii?Q?u6FYS9BBGHi7amqfwQ7px2vsObD8wHC/51/CBcRlaPNB8q+S0QAYdn4eqe+U?=
 =?us-ascii?Q?cRKngn1EYlxE8h2ZWm6zrSo7EW8HGM/V709NU3ZsHeROBfcgsV0W3lA/DK2g?=
 =?us-ascii?Q?kTqSkuvbsJcxk41ikefdv/hbv0nwvcdA98fw5gzr/hDIu4JbBJaIQUgmEG+9?=
 =?us-ascii?Q?PNi0Pjo/In2FoEBRZonXn/qThgS74coDyV5ngdf/UuQ9xx3vFGRTpkIOjKK3?=
 =?us-ascii?Q?3uV1VSauYP89aKk1pt45ZDkFL6ONIouMxI8MHanfOS3Gy5MlKB2ojA4GhS1t?=
 =?us-ascii?Q?FV73Qjzr2iSy8p3zjQI1j2jVPiTXns838KBayJHvpHrbBqqSnIafziwtgagC?=
 =?us-ascii?Q?T4PnZQmcv2zOr20XrqZjeplIGGjliKEVqGevo4liUkJLecpaFQNvYcNaIVQY?=
 =?us-ascii?Q?+ePxjRsfu7rfEnZTZsbJHFhosHz+8xwedsrfYrCIKzzE2+9whTSpyxKWZpYV?=
 =?us-ascii?Q?H5mE45d0AqfW6zGo54Bxf/MnAwvdCiws8VNgPUpFJ4b2G1Zp9dSSVafaL9IW?=
 =?us-ascii?Q?nrptIT0MAMfrXfEu6+T0bHorJvbPtfwDZoZad0bTppNNtZ2rJskwFDOUzSsx?=
 =?us-ascii?Q?tMJmgUGE7pkueRH6uM+XcoaD/f6vFlrNEX2aQRSwSlLuPO+Fjg7VUzHtRud0?=
 =?us-ascii?Q?LamMrKi7z4TIOgrsnjU5MO0m491T5WAcNA7HQXBVGZgTBlKUugaV8/VePZsa?=
 =?us-ascii?Q?eyhyTP8xQNGicwxtvNO1pcIGGgEsjI2m5nIwkwWtrhmK2+tAIRS9WlSF2Zvw?=
 =?us-ascii?Q?aA0ZcZMfh9LuGsZWD16EEUfbRNS6rzahdT/g88X/vFK64qlJ9J8QE6VTgCMX?=
 =?us-ascii?Q?MUFiGZhOPtEGHEY1VI76gWm1ABrm/PQLWg9dxO4UPGoalf5t+hMdt+0cXqgO?=
 =?us-ascii?Q?rK0errwkEZ+eVSALBAlwa/z5qGFcxwnVJ6RJF+SuKWOr8zygK8qWA4I3Frad?=
 =?us-ascii?Q?FKmwV1an5VCb4Ex29lt31HbZEFGo6D6BNLBQpTqeZJTQy9qIeVPxa+0kioWQ?=
 =?us-ascii?Q?a4UiE5JsHhfton6t1+sk5MPgVaW3kWlZ4jY9PWtkpHSrEEz2mRWpJfPidHwR?=
 =?us-ascii?Q?vWKQo+rxGdwpO6LFlpGPsneQTg9iRQFO7eeP93BhTNDJ1CVLEwxt/mcZieDP?=
 =?us-ascii?Q?VshX4A4GsABiIDEB6k+abebaUDWjt5VSqmo+Ezmh1Olm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84060feb-66f5-49fa-355f-08dad10438db
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:48:49.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i/ckeyvXOtBJ5cEUdhsead4h0xqmT8iNJWOvXigOUphV7O4vCpQdGm7Sf3bv7w6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema for the pinctrl driver of NXP S32 SoC family.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Andrei Stefanescu <andrei.stefanescu@nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---

Changes in v2:
- Remove the "nxp,pins" property since it has been moved into the driver.
- Add descriptions for reg entries.
- Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
- Fix schema issues and revise the example.
- Fix the copyright format suggested by NXP.

 .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
new file mode 100644
index 000000000000..2fc25a9362af
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,s32cc-siul2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32 Common Chassis SIUL2 iomux controller
+
+maintainers:
+  - Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
+  - Chester Lin <clin@suse.com>
+
+description: |
+  Core driver for the pin controller found on S32 Common Chassis SoC.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g2-siul2-pinctrl
+
+  reg:
+    description:
+      A list of MSCR/IMCR register regions to be reserved.
+      - MSCR (Multiplexed Signal Configuration Register)
+        An MSCR register can configure the associated pin as either a GPIO pin
+        or a function output pin depends on the selected signal source.
+      - IMCR (Input Multiplexed Signal Configuration Register)
+        An IMCR register can configure the associated pin as function input
+        pin depends on the selected signal source.
+    minItems: 5
+    items:
+      - description: MSCR registers group 0 managed by the SIUL2 controller 0
+      - description: MSCR registers group 1 managed by the SIUL2 controller 1
+      - description: MSCR registers group 2 managed by the SIUL2 controller 1
+      - description: IMCR registers group 0 managed by the SIUL2 controller 0
+      - description: IMCR registers group 1 managed by the SIUL2 controller 1
+      - description: IMCR registers group 2 managed by the SIUL2 controller 1
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  '-pins$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '-grp[0-9]$':
+        type: object
+        allOf:
+          - $ref: pinmux-node.yaml#
+          - $ref: pincfg-node.yaml#
+        unevaluatedProperties: false
+        description:
+          Pinctrl node's client devices specify pin muxes using subnodes,
+          which in turn use the standard properties.
+
+additionalProperties: false
+
+examples:
+  - |
+
+    /* Pins functions (SSS field) */
+    #define FUNC0  0
+    #define FUNC1  1
+    #define FUNC2  2
+    #define FUNC3  3
+    #define FUNC4  4
+    #define FUNC5  5
+    #define FUNC6  6
+    #define FUNC7  7
+
+    #define S32CC_PINMUX(PIN, FUNC) (((PIN) << 4) | (FUNC))
+
+    #define S32CC_SLEW_208MHZ  0
+    #define S32CC_SLEW_166MHZ  4
+    #define S32CC_SLEW_150MHZ  5
+    #define S32CC_SLEW_133MHZ  6
+    #define S32CC_SLEW_83MHZ   7
+
+    pinctrl@4009c240 {
+        compatible = "nxp,s32g2-siul2-pinctrl";
+
+        /*
+         * There are two SIUL2 controllers in S32G2:
+         *
+         *   siul2_0 @ 0x4009c000
+         *   siul2_1 @ 0x44010000
+         *
+         * Every SIUL2 controller has multiple register types, and here
+         * only MSCR and IMCR registers need to be revealed for kernel
+         * to configure pinmux. Please note that some indexes are reserved,
+         * such as MSCR102-MSCR111 in the following reg property.
+         */
+
+              /* MSCR0-MSCR101 registers on siul2_0 */
+        reg = <0x4009c240 0x198>,
+              /* MSCR112-MSCR122 registers on siul2_1 */
+              <0x44010400 0x2c>,
+              /* MSCR144-MSCR190 registers on siul2_1 */
+              <0x44010480 0xbc>,
+              /* IMCR0-IMCR83 registers on siul2_0 */
+              <0x4009ca40 0x150>,
+              /* IMCR119-IMCR397 registers on siul2_1 */
+              <0x44010c1c 0x45c>,
+              /* IMCR430-IMCR495 registers on siul2_1 */
+              <0x440110f8 0x108>;
+
+        llce-can0-pins {
+            llce-can0-grp0 {
+                pinmux = <S32CC_PINMUX(43, FUNC0)>;
+                input-enable;
+                slew-rate = <S32CC_SLEW_208MHZ>;
+            };
+
+            llce-can0-grp1 {
+                pinmux = <S32CC_PINMUX(44, FUNC2)>;
+                output-enable;
+                slew-rate = <S32CC_SLEW_208MHZ>;
+            };
+        };
+    };
+...
-- 
2.37.3

