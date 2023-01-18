Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CAE671979
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjARKp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjARKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:57 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A93B3E1;
        Wed, 18 Jan 2023 01:47:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WENCn5p6YgeoYzfZGVD+PTrnj9I+U101BFIULdnQ+Qj4PYTieFwJmpkDOYcfISmTWajCvHsPBLYKm2pKCj5vIhMtFzQClUcIne7oFgHoebI8zThWs1geLlmyr5Oz8EDnzL5rvwRoVhgQ4Zyxl+ksUEJ4d7+TL08sfgM7s6LJ2WttFe2XkXVdXhph+xdQtJclVva3PpIwoEyXrxtt0adrZrnpakBZq43VYQe1hiMozubREiZh8za/I1i7GBmUmJFmzH/gkI6f4Zen23150SdMgJoKTTgoMKtA6VUsu8iGTAFUIRil5HlnWBeh7G3UIs1evVbv6vUCHfh3cwICaYpjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5roKvkMNfKaYSOVdBOuvOCZyIaT3Ygi0OOjezKJy+E=;
 b=VW2tJrN28YYBxLVDUfRS0GNoMAkUwS5q5LQIR801f8oxcev8dG1+Dyn6xPx4P3n/DBc4BgtqcrchIpfslz4jfsca2WxHOhl7hv4nNcyrEpJ7+E7C/B3sJmc1VTA1ry0ISPrhoHfRykOVU4e6nXQIGCEBA8Uh4kK0ukcBLVr2SUj6unmckcadPR8sh6rGxgSvYnV7RbOXhqjSPHM1vY73fVcon/1zao3yfndkTWUt/tkEi5+Y6Qz64lhirTGGSYd72nwIQs6rJjogRD6MK66g3Brhu5IjU9GDY4/R3HYnuuaYPbdL2A7D8TtnbbayBrBtyqcUUfNWbGxorpkmiyvC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5roKvkMNfKaYSOVdBOuvOCZyIaT3Ygi0OOjezKJy+E=;
 b=JSzfhe0btiwehpvtqHZk/togKPj4/1sBM04EdUQQSm5uAo8U6jOq55bcC8A2M8f0vTbGK6e1L/VHOClfmkZk/ISMFxD6tV9X9DhfOWf3Tc4uz4RhpRWoSYZ8VsZUkYuXWcF/a7exCXGvveAhyC4mG0QwJuATgYNKkqeyvtIK+NJCzAaRQ7eSP7UbxQsKLMfpQZYLRnw8uuOjXdbMrEYoZcY4QCEUdBgONk+cWxqy6dIrUujnPfTt3kuhWfW2+vJimTsMXdYQX/U/WdUYJ9rIB8P5Cu3T0yKFL3QpsqL5tSH5pZ71ZcLYQ2rZiMX9YlldrSset83iFAZxKfMMgj3qTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 09:47:43 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1%5]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 09:47:43 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 1/3] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Date:   Wed, 18 Jan 2023 17:47:26 +0800
Message-Id: <20230118094728.3814-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230118094728.3814-1-clin@suse.com>
References: <20230118094728.3814-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 341680b2-4b0f-4737-0577-08daf9390b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPMMS1unNDkaZWPv1NxxEQyHvBFnSyvALhsAbpsHcN7FW4Ou7YeyTVq7I6tOJq1a3rl1cSEs0VdSsUeAcP/rTfTFs0Dxi/K7t/x2p+kG+lNQEJehg1LlQUNKiBtByRGQZ4JaAfWNf+i9hyw2DnN1wji7wcmoWJ263z/TlLvg++sOKGPhGJ9DO4BrtKPhcUkNBgISO1Dyb+qg5zxQmLPx4E7oyfDjw1F91CrOwqTKuCuvy5aLPojKmCJDUWIV7lEd1BVk95TTZTj8Ur8vUan6C8isSKbmEJJOSd9cy9m/Gg9xrI4IlM/A9xmMAptnlWnJjvFqkaGsIusXWwONO797vVLjQ71nrz7MydoQ93oc0Tbi14g61j2dpLPaN6fT0X602krTTdI7PM2ViR7hPvYB9VArufi2ewjOJnRkKJVlRYvi2mldwU74ICdbOBZrVctZnxkwkh7VAXglZL0FMpMY1x3oF4gYlzVq1pIkskD+yyLgN43vZA3mtnY5bbLycncyMeJAJtNEz4MsWkJN+E8mhEvnABNDZojaGcApN3GcqrAiqg9tiO1RAspxWTqDs16jHBfAWbMlnA92LLDKl0EyO8+fN+9VGEUD0TF/aTPYywYd/sl9EYW4W6IsJyEqzN8xl67SP+GwJqw0ow1kiINGnF4YrGsUpTsyuJsBI4+UdjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(6506007)(36756003)(478600001)(107886003)(6666004)(38100700002)(6486002)(8676002)(110136005)(66476007)(966005)(8936002)(66556008)(86362001)(316002)(4326008)(7416002)(41300700001)(5660300002)(54906003)(66946007)(2616005)(1076003)(2906002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YekL3LOJV/0fMFHQl9hqpPex+nsuSs18cU1wY8/twgvthfuvwQrYmBydXEH?=
 =?us-ascii?Q?uyYqMV6W0U+ppqTUyeflhyDJjiu4V2gQcC7n+Xmqtdfmw4D9lezEY4yfIfE2?=
 =?us-ascii?Q?V4uJNU7u4UY9uA3yh/LEU2Toj0qNUUhwhRHm0CSjIkDC8IGnTFisjK1izuk7?=
 =?us-ascii?Q?KpTryd5ozp3uqoham/c+Jvdn6wRZ5IA53SxURI806fKlVxe/P6YEk2rg0tRT?=
 =?us-ascii?Q?axG7yiTtpGWepjUuVtb1Bw9WiHuACXmYDoJIZFl3sWX+vC/vq7EYbFDCOkng?=
 =?us-ascii?Q?Yp4sncEx4HdDGYGmpYewHB4Wb1AulQcMNVb1VTNsfxHXHUB311V24XpCgGBK?=
 =?us-ascii?Q?pwLHjIT90EiLb5auCEEwjqcMUGqePyLRfmQzFM2An9mRxp4sVLSs38moaSE1?=
 =?us-ascii?Q?Ia911Rp5t/AE0Wp4BgFKt6VadPtvilTxsNwAdQU/n33q4wjovfZsGKao/wBD?=
 =?us-ascii?Q?aDsMdnt5xU9Y9azyecPSi5NPOfEZu/olRywL5OCrw0oRkz5lieVk4akdRUGn?=
 =?us-ascii?Q?w//twKyTYqnmT5tefr5v6zz2h03K9g1KrkILdyNQxx3e4qaS0Ex0xG4PtYhz?=
 =?us-ascii?Q?WSvED/tFftkPk2paEVA9UOMnNCWlB4I7jUtVsHa9TdmY/kfLuCKvMJkSBY2k?=
 =?us-ascii?Q?PRVWergd7LI7DTuhL1eP1yaDvcnnWrS8Wb22xXIoyyHl25RhwQB0P4MHJjaF?=
 =?us-ascii?Q?cg5yo0EKa/bFNiih19gYJZLRqZCVVfDkMVEQ0SuKjSQxJeck55BG0o4Pl2Ci?=
 =?us-ascii?Q?7EcLLK0Kvd3lKsVGs6GaPKPHWfJH/Nhdas8wJGP5Qc+GZZLqTh+F67OFL6Mk?=
 =?us-ascii?Q?yYk0rYxJRoV4R7IyskVIPeyRsCZQ80rT7MnZ8vSQvCSMKxQGn4TeKYyTtFjw?=
 =?us-ascii?Q?EHgidIyG1WgM2MnkgapdY+f5EUq2nmn0U+3Lh7sFPuMTdAJrWioFYbKtb3lc?=
 =?us-ascii?Q?WNhgoTq7AKStKk/VZJ2zKPd+MDcBG1A066HAuUTrLlx5v7hR7Wodem97LclO?=
 =?us-ascii?Q?2uTdofgmn4XrOXtno5rkDTvgLOEGCbvpm3rGi2480oDx9pNedhD0R8hhphIW?=
 =?us-ascii?Q?5ESrLrhXiaxb63FYWEGW8Eh4Du/RUoQrGO1MMoSqifaWPqzRd+Cv0Uj8Tbw6?=
 =?us-ascii?Q?ZRjbhVujoe7NsxpFIOUTcqKINw4UAs12rBKtDEdXYAVvPOYAa1bycqMdws20?=
 =?us-ascii?Q?mmYUQ5tE7Hw9BeJ1QSpBSwsykwSKrj+qJLl4v+PnxGbXLQ/kp7IPt6cBQSOG?=
 =?us-ascii?Q?FkQvB2eKlFLWnTeQbsSdYyFrX8Ec5ze0H19oPtBTZglFS5SpmVoKDYR95+Fs?=
 =?us-ascii?Q?SMWfkeTVND1QRRvSBY9ugTMO4laOnI5IiQq3f+Dv/Nw2N71bIhSknBX5UjkY?=
 =?us-ascii?Q?NYvWzqKWZ/wp3RMZxCql+HZDW2/FUY6V0jRfxi9fX7qughjENEtwqo8ilSOo?=
 =?us-ascii?Q?OLORvGzz1yyH2sghvhfV06xlD9FOsPXQJNMN0sVOLhbXTJJ2MNvUHXYONYlT?=
 =?us-ascii?Q?LS3OakBko9oeJ3zqeS1Rf1JmJETZrJhoV1hK6dOzSXfqXcEe7NW4DQYvD5D/?=
 =?us-ascii?Q?w3H1Q1Ey9t0mIAlKpmE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341680b2-4b0f-4737-0577-08daf9390b80
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:47:43.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aE9XGAEZ78DlfaEo9EhX7dUJlpGaF/GZi6WNzsSCLzwlSayhoBpSv/d1uuC2IkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
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
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
Signed-off-by: Chester Lin <clin@suse.com>
---

Changes in v4:
- Change the representation of available slew-rate DT values from register
  values to real frequencies.

 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
new file mode 100644
index 000000000000..d49aafd8c5f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2 pin controller
+
+maintainers:
+  - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
+  - Chester Lin <clin@suse.com>
+
+description: |
+  S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
+  whose memory map is split into two regions:
+    SIUL2_0 @ 0x4009c000
+    SIUL2_1 @ 0x44010000
+
+  Every SIUL2 region has multiple register types, and here only MSCR and
+  IMCR registers need to be revealed for kernel to configure pinmux.
+
+  Please note that some register indexes are reserved in S32G2, such as
+  MSCR102-MSCR111, MSCR123-MSCR143, IMCR84-IMCR118 and IMCR398-IMCR429.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g2-siul2-pinctrl
+
+  reg:
+    description: |
+      A list of MSCR/IMCR register regions to be reserved.
+      - MSCR (Multiplexed Signal Configuration Register)
+        An MSCR register can configure the associated pin as either a GPIO pin
+        or a function output pin depends on the selected signal source.
+      - IMCR (Input Multiplexed Signal Configuration Register)
+        An IMCR register can configure the associated pin as function input
+        pin depends on the selected signal source.
+    items:
+      - description: MSCR registers group 0 in SIUL2_0
+      - description: MSCR registers group 1 in SIUL2_1
+      - description: MSCR registers group 2 in SIUL2_1
+      - description: IMCR registers group 0 in SIUL2_0
+      - description: IMCR registers group 1 in SIUL2_1
+      - description: IMCR registers group 2 in SIUL2_1
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
+        description: |
+          Pinctrl node's client devices specify pin muxes using subnodes,
+          which in turn use the standard properties below.
+
+        properties:
+          bias-disable: true
+          bias-high-impedance: true
+          bias-pull-up: true
+          bias-pull-down: true
+          drive-open-drain: true
+          input-enable: true
+          output-enable: true
+
+          pinmux:
+            description: |
+              An integer array for representing pinmux configurations of
+              a device. Each integer consists of a PIN_ID and a 4-bit
+              selected signal source(SSS) as IOMUX setting, which is
+              calculated as: pinmux = (PIN_ID << 4 | SSS)
+
+          slew-rate:
+            description: Supported slew rate based on Fmax values (MHz)
+            enum: [83, 133, 150, 166, 208]
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl@4009c240 {
+        compatible = "nxp,s32g2-siul2-pinctrl";
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
+                pinmux = <0x2b0>;
+                input-enable;
+                slew-rate = <208>;
+            };
+
+            llce-can0-grp1 {
+                pinmux = <0x2c2>;
+                output-enable;
+                slew-rate = <208>;
+            };
+        };
+    };
+...
-- 
2.37.3

