Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835769C426
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBTCdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBTCds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:33:48 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2A9021;
        Sun, 19 Feb 2023 18:33:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTx1G4gJqrB9aiv4S/eOcqdoVLwwYXUIIpSw7wq6gc+rLDZDGRa8zKkJmMhRCDx/YAoDKS6n60AY3tr35MFOgwWYFVZtQsY4JY/+OaB4ygXQB7pTohUNOHFrglqg0CX8sNRX8T1U316QCCYMGh3E9A/GuAYbEXi5UKfTrO8nZ/aes1xQV0jaTPDpmsDSs9+3548py0JJQ9rOcDYJyXOeSHDmZoO30DhIpMTBYl5NoIXkj+a9ofaKQCzwHq1lBxlZCnQr4Z/CuYu91y8tal+5gL47QTvZaegryqr+cwrTe/xQiHoOGSn+IaqZlcbfLjDvlP+C7ocaAYA3RgrTQjKjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZAXeRR5vRCQDwxUAZwXoG1HUP+fybt4rlf5SDgolSU=;
 b=gx+aTWcRwbj5c4UjgmxEqGr0srQ2kjjPzvmAPTWgvT+C0LTIAYonXHW4ETRS0QAe5ihPsOjcmr77w45hdoroozGEY9SXXSCaxVTGnjQZ25SnCnQwp5JOJYMIQk/EibQ/wBG1cRapxO9kMRyVUzoXJwKvxnNiTjXtwrsR5y77iwHzfO43/F1h/4Otd3Fpd7LJifEKtrmfIH17JcqEdvOqDGRdnbPghz9vaWW6Y8lJq54OM23mLBGZGzS+FwLGnvTgX6eGtupe6q2rlRQL5RbuWWtNWNZTaedvaRc//uaDfoRfchW9bWhJb9S8rLg7cCV1zV4PbXh7/qz3CIre3IGJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZAXeRR5vRCQDwxUAZwXoG1HUP+fybt4rlf5SDgolSU=;
 b=pbHYS6TaGp+J2WZUkkXVXX6/A/eZhPy0rRV6qOAye8iCDVJSQCmQoPz62xcesMoZU+y0hvKXQ+lKad1BgbQHrgBKJHyjxzEuh4skMf6Ueh9LAN25JMPHcNUmjMdRmOOvjlrac4TeKC/qbyeSEPKJgzPtwepOaRjiXRDK7aOicE62mBWMMmlgJM8s9PcP3rH9ev9hacgTIr2gMdi4hS6hRrIdv8yC6QNPomHJPVqTZj84CzYIh+uV2atXCFkcgpCuvHFR1cMKvJBYiS3zO7uctle2AOa4Vg/GCFczudy64/8D4nwAuq797/EYCE9LT/KMoy7hpqgUPQrME0r0k0PMIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AM8PR04MB7762.eurprd04.prod.outlook.com
 (2603:10a6:20b:241::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 02:33:42 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3%6]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:33:41 +0000
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
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Date:   Mon, 20 Feb 2023 10:33:18 +0800
Message-Id: <20230220023320.3499-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230220023320.3499-1-clin@suse.com>
References: <20230220023320.3499-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 55268ca1-518c-4bb8-8776-08db12eae16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PueZnL2RIpLzLLqzlX7rZfLcrdXY7vV6G6R7FU6NAD0niSZNrthKKWSEuHkj7Hoq7MkweUfSNMi2YFWygBbwXqJBeRevhPFogFv7bQXXH+EDRe4huDIGaqbmZGp7gtuq0SmILT5xyCqjLfuOFZuXy+SJKxxihV2kDQQkY029xWJjs5KE8+7c7c4eJ8G2CiRVbX2nCWUpvFDzH73WbgINK0/gOBrySF99E9i154OU6uYChupDp+qDX9jRTywy6G+OhgDkygSqhGv4Nj0NR0ugZ4t7MSVJiWUhfHHet20OG+CFIhkWgmDVuBd0nRXjq3idqY5dRvbKU7ik5L4bmWUmkLjztFTiBYH2nnJjb5MW0wRkcAk/PTcmraEdNoYbv1Jf3a+fKCV4cbY/oNnJ+xUjUtjYYaRQQJyXMH7unvTXCwgn2wfFSDb9/c72o0x8HsyVKgxsgF52HBCHCsT7FsnrN/BeLFo8FhkMvFWUHN0goiO9Cb2dwrnJ51bTvUaqs4DXFSVNxBrv/jsCiqN0LPQx3Tz11FK26kWTuVxsr4So/993rDPgAivPBob6rSAP7v00nj551GGOyLk3JXNaJO9XEH9d2g2htgicOqdtKCn3L+nXGDIfLlfUo80if2tKTUN+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(6029001)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(6486002)(186003)(26005)(966005)(6512007)(66556008)(4326008)(8676002)(66476007)(5660300002)(6666004)(7416002)(8936002)(2616005)(66946007)(6506007)(1076003)(36756003)(316002)(478600001)(110136005)(41300700001)(54906003)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9MSQu3lbACQkWYCW2kcKj0hpRwYKZq5w/e8o7Sj/YMl04Vx75EqupwnGaY+C?=
 =?us-ascii?Q?/KHJ/Lzcfmf3lsHpOHkzg/3Ozz7AQKUtQc6o+zXptgi9JEOR+oqqLxRRqPlp?=
 =?us-ascii?Q?gFBFfqeY+7CJFHfjv4LeAJNKlUyo+PtFmA7rDKBWmprghY+/r3ZPyXDxUsV4?=
 =?us-ascii?Q?4eX3wSIMaDLEjaRhE4Au/0Tqtu4ZDPNdQvvQYBR1IBqgCky0YbZXbsR6Hh48?=
 =?us-ascii?Q?g8R3WZsiTbCUT0lxBfUR1ZHoNJaq+EVfuPa+f7hawtmA8isxLlw74527znYx?=
 =?us-ascii?Q?iXhBXoPEDCvCrzOObBHzn5WsW7YmYv5aGpICoig/QVES69723TgxP480iA5l?=
 =?us-ascii?Q?JZb+sXPnVURHtxyUNjwQ/4TDTGy50/gtnebQKJXxxw6CCpqhaDvsR6e5dUzb?=
 =?us-ascii?Q?dEeuKUWigdvcC91IdkG7TJk047VLCDqR43QcFUsZKL1CSYznxZWFpUwWOcuK?=
 =?us-ascii?Q?XFdM+jRrL2tzsYwIQjMfzkzArPaYmCh6zTNl9U9AnkzsgPpZsSvXordDwlte?=
 =?us-ascii?Q?h2cYXYk7tPmL18BpJcJBfqUXS1UlBfOHwtKm++Whu6iiy/7+JjVc7I0HX3RJ?=
 =?us-ascii?Q?HvAm4Ov3XH4/G/rJkhqFkZWn2yq7MNknBblJPV5w5hUVHKxQleeh6bvcYPTN?=
 =?us-ascii?Q?vwXNZKjWK22/VyQ0I/uPKWJyEjpa92tXkx/BtclWRPsqo42QvcXp2r8uu+cr?=
 =?us-ascii?Q?WnPQUG8BsF/ZzAVS9dsOklkXSnGOrXfeZMI3DjgFvt7PM/NtYd8KqaKEXSMy?=
 =?us-ascii?Q?1Tz3x2smiNFdFQJ9qn89sIVxg+heShVqAESKfeDUfS9t20jNsgLHye5Zk5sP?=
 =?us-ascii?Q?Tp/WE7CQgx1nx9w2Prvvtg6bjHyq2SUFtMR7+dJorjWL+X9tHPABrlqDupOi?=
 =?us-ascii?Q?70S4TpKFEsAia3D+4dqfzo42a5ceAXbH9bK6H3WeSELfbQfKzTcWWcWK29Xw?=
 =?us-ascii?Q?2G7zVFZT442SN/cEa2zBbddmtVv8m82JB6yG9KJEPW88Ud47Zck7FImbFQYF?=
 =?us-ascii?Q?E8vegxr4yiJnBHvPp8GLu//c+nB2MXtmD3wP8s89PX7p7Cs6OcS9NLFzWaQ+?=
 =?us-ascii?Q?vxdhwAMsPintr45trZlWfoOhNvucMngszn44sDMIYZslDrw8UA6bM0uE+H0m?=
 =?us-ascii?Q?x/QoBxBszn8OJO8lTGkswUy9/8yokFOk2HOhBhkqW6gsozfphIMhCDk6hlys?=
 =?us-ascii?Q?lAEtRS/KLDYAVyOP1XMKv10TEAv76A3FQEA+vbTGz2/2skD52RsnMLZIi3sM?=
 =?us-ascii?Q?fiK8ncybGJyyt3UIbTVllmPc1/fjH3HAFxTBHR50Oqo2UCgdp7tr3c9FfPeU?=
 =?us-ascii?Q?rvSQRsuYR8wpn+dtvWzJFp0JhRdjz7l35ym7VG+/EFv8BuyvGyBbPx/aAvwI?=
 =?us-ascii?Q?A/cA/+mo7ke1wMRha24r8/A/SSt+SEo912v8V8LuVCdrbsABmFtAyKSenj0y?=
 =?us-ascii?Q?sBDQTcGrPX/OszROjqaO8MbaePiPsBXcnscXI0i9H92lycxpI+3jxgdVdczM?=
 =?us-ascii?Q?AbihnOP2ZCUU68V8jRYwYW/AklGsdO40YBI0OxBuYhxgy76hWc96qcyrhEwW?=
 =?us-ascii?Q?e43TlE+n9+CHHpr8QR4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55268ca1-518c-4bb8-8776-08db12eae16c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 02:33:41.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgvi9Lh2/am2bWtFXInXRGv3C3r2qg2UrzAxDG6ZEpjuBgjfxGz94Eh/DX7qf0TH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

(No change in v5)

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

