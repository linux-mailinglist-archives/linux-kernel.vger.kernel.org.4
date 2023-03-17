Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EA6BE93B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCQMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCQMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:32:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F456C6A4;
        Fri, 17 Mar 2023 05:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myrxtGwVEiSCWb9Wnkwrpoq/3dDIIm9zSpJryqOLFKBYx3CkTzl6UO4fJ4oWR8kf1WQbiZ9PT3SM/uwlORMey/ouWQhC1ncUlYRfOHx6InVQST01n/zuhZQEaScwhQvlOepBLLriI2TMD4jT1caGTnoJtBSy6SL36qD5/YGqgAK2+KWexJbqUpdRWXnyglMrPh/5pJiKwt8WW3jXiSuCBqnRO+2/P2ZjxVeReoqr9WNeTgAOisi/dl/5ZPScFD3PEAEuZ4ivrrcLgZlFngyRhPjmkitAx8LQkJWxusfcItVkwmC11HB2EO7oOKox1GSg/bYNaQwPBCyPkZDyYpP/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMz3p6Irib64hv7d0D58VrlbW655Wbrb3tHBPsYkyfw=;
 b=BOr77rHNUloR0ubW195ZkSmQ2CbHfwBETVNY0oDCWudZWrw0YcFzLS3i84MLaD3DHPtegaYYLB20h07UsP7fgrak/i2BZg7GZzkgnQ8moSWc6ZrgdVY6yDFLyS1vz3gdaLDyspeMDdXlZuIVmQsDd6NzxesGGfl/mLYmkENgxNJpBilF2phnuXxi7Q9JfdfycgaKJvHrLu4iX+edJz9iDKjGBCYiS6vjUXGjpiFnKvuuxLJ9w4lRFiAlgip6V7wDfbjERqas1W+zG4y5MyM9natAZcdvKBHpqb2qN7tVuUxFzmqiU17uLwwvT0PQeF7t7ZMHYImaqzKn4zG5eLMR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMz3p6Irib64hv7d0D58VrlbW655Wbrb3tHBPsYkyfw=;
 b=S4vFj3ojbVD6Df5Iz1jE8pbPpomWHOPSw/2qBSeUPoT8zieSROGm+pTKCmkpbNdK2z8TODUbHBgGS+DPfshi5lXtS3lWNl1crHkDkiON+o6W6ICXwutiEpXdcPawanWw1p1qsT1oGQl2LdsodfI8vCwOa+kUz9xjYMEqsMphU8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:08 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/6] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Fri, 17 Mar 2023 20:37:03 +0800
Message-Id: <20230317123708.337286-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 253eac24-8af6-43d6-7ba5-08db26e39fae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NW82lU+6AALTF1Wmmm6/YYpx1AzSRyZrAwtVQMBu0FjhpPKbeOSfe/AmT7OWYwWmifySdD3z9M84zKatY3gktr5cmo9Q6BeGqBcaI2c40IcPmClGrRonrcMw1IE/NdD8KZo8sD8kXXr+VsgLF89gJH9z6z3jCfoO7oqrU/HVYNAB2z+O674SV6l5/N9PuxlJv7qYTdbImehpO10FbrVm7ktA8cTVKii6kMYJlklHQKAIwo/z3nS0MLtdTxRJcORsugo32avxuqQGh9W6FZdvWycmSMSHKTJ/CWIpA78Y5mLAoV31/drSKv19lRKB3NQ+wht6vAZ895ChSTNLLvliZyTYQfq9ATo1g2rHeryMR5zkP+ZWQfR/tZpIAncam2EoyapiLc65yWyT1dcL58szRJs6trp4mYCi/ekSlpWPjryfP11ZQkgyCBydrym9GOubcOG+kg88zxFDyFOlwo/T1S/I/6c9cS1kjhPABqTo2d+UquYcvbG2xoBUrRWywdmBg1/u5SZ/ZkH1mkTVfcJYprIezPtTx+zR7Ae2rbqEN+wBedE0TZYXjh6tPOOo0b2VKGAcUugY3PQtaJcZT4cWM5z6d+Sgjug3SOmuTC17wpxaPYbb9vwmwBQ3kwetHY9ovRY20X6SQLkwURe+U/9K2j2ERx5qotxy6XxH3hW9pr4jWBzLoAgdnZO2PJwKyeIfbeCs+mgE/EdAs+y029cp7PDVaCbDPjMAyy5tnsMhBvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6666004)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DzHhM0MM+IDrT3miaZr3XVrwETVkOJapDSCJZ0hpGIiy5GkiAWLIdhiCoNM?=
 =?us-ascii?Q?RIuihXZhMFI2yzZ8QHQ3Mvojl22E5HH/FM3JfEDfaDZ+vaA9bLHGNeCArYtg?=
 =?us-ascii?Q?hQdorBCoBboIbnUQ1GuYFjeZ+DTIIShy87j0mdZCUXPHYVIh38ZZOzceBp3o?=
 =?us-ascii?Q?DCMJZGU9omWZUNWqOwt8c2OZtL3BYZuuPD9/Ca6himzQL9goYbQ+XP+py6sa?=
 =?us-ascii?Q?8A0E2HaV3W6UhGI/qznPFKGqHVi3WmdmEgEtmhGfeO5WPpNhCYZYn8Ww5wfy?=
 =?us-ascii?Q?Dmm9UitqfR39ehHSGobjenWjg+ySVmY4xaHE9dnHsmu9MafqFZqEq8yRrnZ1?=
 =?us-ascii?Q?/prYXd/Y4/MFNOPWHqjiSa2VhPd33BEr4a4ARwNIRwX9uHmZzVbsDa5/4RkB?=
 =?us-ascii?Q?dao+Ct3RXQ1lR0FqBTfdkLEhKV3ETGJwYVp9oTUZFbCGSGRLRZnbhKZxBlkS?=
 =?us-ascii?Q?WiIoselwfS+7KnCPbpvNgBjDNgUhaNtgciE+Eh8uFhhpEzySk+feeER+5FgJ?=
 =?us-ascii?Q?r0uczeay9aoPJktnC7bgpT8GlgCgLHtA4Ijfnzb9AxW16LIuxhCU6L2FeNRG?=
 =?us-ascii?Q?89wOu3vKe8kxhpAtwsc+Oaw+v5fsLeRIV3crv2H99YTl2UGL3XBnDwg5/IO3?=
 =?us-ascii?Q?p0559C3VHydmsV0/+9/B/yORswH/jIeQvrf7xIanBqvUFexJgy5OXRhN99Mk?=
 =?us-ascii?Q?SlxIZsfoHfUPy4e9QbBBq+4hMD78JP1sdXJY+jmzdc8t2mrIN1ViXZ3bwpJ4?=
 =?us-ascii?Q?inSmU2dPBc4JE4N+IL+3PYsM+MUe1OmC+TG7vXDY+ipNljPNIujjDHpcfRnv?=
 =?us-ascii?Q?P8E/4AmONM69yFOTWAxPYuB+0S3EJRgFih4h+CQCvZlFWIHeFnIMgvabT/HB?=
 =?us-ascii?Q?DE2A7z+4O2SwwcCoqks2kA0QT0Jc4Rw8aGQajTFs/0uYtC0JxSv7JxpaZa+u?=
 =?us-ascii?Q?dxW3cY5tEXxIDh8f3CTpErAcp3k1d8XlzZ2h9wBdMRJ5zXFNyChj2iBzQTq0?=
 =?us-ascii?Q?INm6zMOzkBpOS2nCMcScPfsl4Cr3ujOfr+PZg3SrbP5tKGex4jHnzijoaO8k?=
 =?us-ascii?Q?JiNAMlpQbXR0yQLTELx0a876MMLZZLqhmFw7fnJrU0wI73IUUCmlepCjy7kW?=
 =?us-ascii?Q?aG64C/1HZOQPsIu9xpoZn7ooeV5PQjIi0RALEGgE1naUtrpJkOO/+2v03Mfe?=
 =?us-ascii?Q?I902IN48qAingt5nTn2Fkt2+8VW72HVzG1IR3qU8lIvmUialcnYlQAdyi4uc?=
 =?us-ascii?Q?8Lb6eBapLpWP7c4LYec4pM9Snn9aZCyZqnqUpiUrgpOq5mP709xdSB1T1S2x?=
 =?us-ascii?Q?akR/UURRFw+9iryopcvwftWGHH9tXB/7hCglg4iD5HAzuoc4zGYeWp07t4hs?=
 =?us-ascii?Q?DV7MMA0lOxaMf1tPukNVpvnNv/ZYEaSiOLKiwGiqCWbIbK/0514yJhsPkk67?=
 =?us-ascii?Q?HI2qIUhyZGEFbRvOpgnz3hlU904RhByb3qYzkGUxqdi5w6xhJnl0Fg3XAaxB?=
 =?us-ascii?Q?1UHa47Mey1RCSz1QQFFz4KcOFBrCNP239Jpc/VeKIdE6es+U9mQ8vFOt+e4f?=
 =?us-ascii?Q?06rqG0zNCzw7PSzBzhT1C2MEuBUhgb39WQz5DPHO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253eac24-8af6-43d6-7ba5-08db26e39fae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:08.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtUlvZrmppZVMtrwAZRL1qIgsokYkm+VAJt1xTsd6lNJMwnXZCVnOyM3yJGbKBFawg3m7gmFsR4R0Vmd0cqOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert usbmisc-imx to DT schema format, add missing compatibles

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 68 +++++++++++++++++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   | 19 ------
 2 files changed, 68 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
new file mode 100644
index 000000000000..8736d9471af8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,usbmisc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX wrapper module for Chipidea USB2 controller
+
+maintainers:
+  - Xu Yang <xu.yang_2@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,imx25-usbmisc
+          - fsl,imx27-usbmisc
+          - fsl,imx35-usbmisc
+          - fsl,imx51-usbmisc
+          - fsl,imx53-usbmisc
+          - fsl,imx6q-usbmisc
+          - fsl,vf610-usbmisc
+      - items:
+          - enum:
+              - fsl,imx6ul-usbmisc
+              - fsl,imx6sl-usbmisc
+              - fsl,imx6sx-usbmisc
+              - fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - enum:
+              - fsl,imx7ulp-usbmisc
+              - fsl,imx8mm-usbmisc
+              - fsl,imx8mn-usbmisc
+          - const: fsl,imx7d-usbmisc
+          - const: fsl,imx6q-usbmisc
+      - items:
+          - const: fsl,imx6sll-usbmisc
+          - const: fsl,imx6ul-usbmisc
+          - const: fsl,imx6q-usbmisc
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  '#index-cells':
+    const: 1
+    description: Cells used to describe usb controller index.
+    deprecated: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    usbmisc@2184800 {
+        #index-cells = <1>;
+        compatible = "fsl,imx6q-usbmisc";
+        reg = <0x02184800 0x200>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
deleted file mode 100644
index 29b8f65ff849..000000000000
--- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Freescale i.MX non-core registers
-
-Required properties:
-- #index-cells: Cells used to describe usb controller index. Should be <1>
-- compatible: Should be one of below:
-	"fsl,imx6q-usbmisc" for imx6q
-	"fsl,vf610-usbmisc" for Vybrid vf610
-	"fsl,imx6sx-usbmisc" for imx6sx
-	"fsl,imx7d-usbmisc" for imx7d
-	"fsl,imx7ulp-usbmisc" for imx7ulp
-	"fsl,imx8mm-usbmisc" for imx8mm
-- reg: Should contain registers location and length
-
-Examples:
-usbmisc@2184800 {
-	#index-cells = <1>;
-	compatible = "fsl,imx6q-usbmisc";
-	reg = <0x02184800 0x200>;
-};
-- 
2.37.1

