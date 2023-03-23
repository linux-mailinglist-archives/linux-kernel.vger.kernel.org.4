Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBA6C5D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCWDvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCWDul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:50:41 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7272DE64;
        Wed, 22 Mar 2023 20:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6dayV3yyop+NxLROBEyESNUxRWR99JaOlTdBXPDx1HpP5FaHk8K63L1oBWuWUfI8gG4b7Gs0+fTLUtFf0JHeSHOCeGBbFE+ekxn/z7VOa3I0zPVp1OKjiv2LAeHTwHoAeo6juAk9tXGoIVaz9FX8QiTwHwRrlGK4NSwLy/5celjZ+Ui0WO9PLpS16R3hAgbbE54qJ9ug8LFQKgD1q8BlZhrFLkXVL0V5wgxMH+HDC/9CMcaAcBJrK5m0/g49ntypRtL6E4PXSbc1J3WDNr1ki4/0GHYPYWUUgY2HIDjh3iPMfTJt9Jdb+babbsc8bZpIxzElU19NNy+A6x1RUYkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbcvCKxF5Uk+y2pg4gTo+zulkAdI1Z3tMkYEkm4ulCo=;
 b=YTWD82xBdn6d91kMKMVDMCnziFzlpjDEojR3fo10/l3D3qgmoegzZnrYbhIsD/WO9CwVtEheA8Ay5jIuGwW0TE8ksYdRH2id/y6ki9r3IodvokggU2LLM4TBa+IdQfmLj6ExQdRsJF+ce0aBz8fPPkQGiFdCQmHmzMCmn4iLamKxCVcb/Ktlof9lpq6kFssVeTAp+mlaoUEllbQsa3oMP7YgsAXisPYRi9AinQMXJnWmnSEDiB1onG34Kw6ZcfxeLI6YDY1xj1qir3QN1H0lQ2TViXXWkoO/fL2FiBXvF1fqGici/njFDGCCxPCw0KKn2+TPc9dnO1VW2ZoYEs9ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbcvCKxF5Uk+y2pg4gTo+zulkAdI1Z3tMkYEkm4ulCo=;
 b=aQ+NrkySHKjO4uQYRYrZTaqqoLSa+rMTspTzB9xu2froFiRLGMu5v2QtQB4MHRJHaxkZw5Zzpa5P1Fg3u63IvNn7ZuMD6hfBsIcLrQDH6eJX34LvHvZjwtscRPITexYV9eSF/wdfSebZZQtrtz98PYT2otlvj4qZE5dTtIP6uxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8099.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:50:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 03:50:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH linux-next V3 1/2] dt-bindings: usb: snps,dwc3: correct i.MX8MQ support
Date:   Thu, 23 Mar 2023 11:55:30 +0800
Message-Id: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 61faba9d-a410-4fb6-8004-08db2b51be88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hgFQgg5S1318ZA4v1H1Gb4fgvZEIAFADRJYsuAAMsYa6b/op2YxrgBRzShnC4eYic//LP2Hm71Utt0xLhOHrD86JGofPdUZXggn3nyv6eJ7pC1KjfG+UqCI2t+s8c2CvOaMgdEdBiZhr0br998F52p9eO+iz2PXf5o1Y6PZV3tpjtz3Klf4C4MDSfEwdxahzp/6cqj9R2PzfU4THBIGWOiQZZN9naIAGfQN3gJQ2rxWvxmuidSg+vD3k99sMrTwhkiICASWFiTQGkTS0ZHG80tdcpd3J3j67KecsNoxDSQDykEcuEjuVWxHR5291+DhLcjtxz6NhPCaMbFTwBXIgj1oN7g3TQ6dIggB94GMd3S7mDxbhqdnUd2TC+4A2I7whTMvb36iz0BHlhhriW4qVtNSZCkZI1bt+s+D/cGsYjzRcYjxVG2vzN2gYsWCdu+axu2o6nWibQlBsiKwuZ8i9xfnO9Qlk+cqIao+mA9H98NEd7t0vEgzSmC6mGSIoUdLtyC86jxy5mMF5HuM3jwdFhzLTuv++S/rCXPyz5Qxje2YXJ8NGkhpISi7M+4WaYYuxpisbYrFY8ADR2NA0tKhuUzh4k8xN9nLx7EsvNriyGWtzwhmtp3EvCXC+954v3Vcr9VUm2B4CLZA4YFKsOVeVOMiCHpdlJdLjQNhPKH+FFLDYn8G8U6RyQHZ/b6uK1VUSqr5Xt/Tfjeufh4YV/R2RE3jYefrKtfAx96wincW/AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(186003)(6666004)(26005)(2616005)(6512007)(6506007)(52116002)(38100700002)(83380400001)(1076003)(966005)(6486002)(86362001)(38350700002)(2906002)(478600001)(7416002)(316002)(5660300002)(4326008)(8936002)(8676002)(66946007)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xO9/yFP0hvAr0Lbv4J06Cyq8X16AXhxmt/i6obCRwdGgak43XSs1BiX1i8u5?=
 =?us-ascii?Q?R/JkSGyG42lmoh+a89dAocQOMRdBkww01nU8bdAyj3RLlz094yHpv8i3tCIM?=
 =?us-ascii?Q?DGk8snot8VeKtvIk6vjeP1+0ByWsr13KRc01Kzv/WqIj9pkC8cc92Ag5Pryi?=
 =?us-ascii?Q?6DzP1JsRzXRFQi2ivbgU54ruPLw+/apYYQCUg4UE3L8l1EroopHyGca9fndl?=
 =?us-ascii?Q?bslvbSbAXLC1lrEv7M+BnaxRiCQT5+HTgaJkXcUJad1vjbyVGP2yFP8yStFj?=
 =?us-ascii?Q?xWau3JuKJxVXRNmwdkAk6QpWqtbSW0LJuiJMoV4qBeuIEZhL0+oAQOH69/5g?=
 =?us-ascii?Q?Cnn5NfaARpN2i5xe2eyPhAFbatR90nb1f9ODmg3n9ALnDYt5wRkr15is2HJT?=
 =?us-ascii?Q?QTRJjc1gwf/LvSCOzOw8/lMA4WENJiD/qctA2VZKh8wUmxHL0TvfzLg8rZTs?=
 =?us-ascii?Q?70PqxcpC1WxfnrKniA641LQTM+cR4dHOVIbmcVorPXHwNuvOvJQ+El1lTVlI?=
 =?us-ascii?Q?mFpRRUsCTMYJTxEM/QIS0WYBQYQFNmYHAddBluk9PmGEeWHoFkhEYwCJj/Co?=
 =?us-ascii?Q?E4a75yIS4yx5NIHBBjmA16oYqie0AjywFa+hqBV2gXsrvrgyXoMjzf5zYN1P?=
 =?us-ascii?Q?xoKKFKwCXHr2pP+O/s+QZ6c6OqigRtg/xxI71d3mOc6WnG3mGG03CWFjjWep?=
 =?us-ascii?Q?r5JGfvPAXyzmPeXCGq0eI/LHnHxpE/yjOcvwW+afR7T6nVmaUztkOT9Xq+n3?=
 =?us-ascii?Q?GrGvbo0McqiiO3TB+GMCl8l6It8lZdnUfGerQndCLlT5BYcmCOwFfxjxp2D0?=
 =?us-ascii?Q?OcsJQ3TZHIuPqyEp7qOf0M88S+2KdNMxiRd4h0I4m/HSvcf/xLxt9f2fnulX?=
 =?us-ascii?Q?FNMm2cA5ZMYi6RnIOWHPNcV9v/qpqZ39gfsMbMX9VEeXGfBfhlFzF4oD+XdI?=
 =?us-ascii?Q?rXoadF/2y05d3+z1S0sqsvdORrnDNlz0wIr75uAKC6mXR8849faMZE0GU9HP?=
 =?us-ascii?Q?+ecePj5AiIYFXC8EgghZVEzrZD3pgsw5rp3OukWFA3RFBPLHZowU2aBkHfiL?=
 =?us-ascii?Q?e3pGO8pQKam59HRFbznG3nZkj+UNhN/ESSYHAzQ1JiaoVYwb3gn8MjgRayRt?=
 =?us-ascii?Q?ukkn0TlprDagfE+j3IBOVzHqLU7nxKKMWa/AP8d2UA9VHUswGsQNoZ2wldhj?=
 =?us-ascii?Q?7WIfp6gv+ZzFbuSyyLse8zmNbQBS33REnEQRC0MUDcSTBYg1H7/sbaGKvZKy?=
 =?us-ascii?Q?bXgE3zisPoztHtz2U2ttTdHRVfLT0n4blCakE6g0upBtvX+RL3uZ20gk22G1?=
 =?us-ascii?Q?0QZGBSi/YsdQCHJNDTJU5sUpmZNQ6o+y+B7ps7nFWa5sJU7kuVzpHxIrbPr4?=
 =?us-ascii?Q?QfCnIA7BNBJYs5XbtVDnO40cR5fcQvx1zZTe25I7Zxdlv3nFgM0mgRnpVgVf?=
 =?us-ascii?Q?oZ8zulsAUiN8OXNg4Hm4fT/p3AFGCA7QEg+S2RdaaMtD4xsQTJmqq7xLPCot?=
 =?us-ascii?Q?L3cOwZz4czW4WZjEbkdSy6xD5XObxBq8V0m67MnzeftVmjmJmcriPOMSn2Ar?=
 =?us-ascii?Q?ewFa9OCcZVOFpUHOXEZIBMSOVKwgFrPvA4Vk5B4E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61faba9d-a410-4fb6-8004-08db2b51be88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:50:29.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQBCopM0VOa83yqDkvwnbRfjoqRGG4FkYfYNk+e65uiaMGLtYcxa4ZXT0jaeI3lvT+jDAk1SjsXB6ZqlO5jN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8099
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The previous i.MX8MQ support breaks rockchip,dwc3 support,
so use select to restrict i.MX8MQ support and avoid break others.

Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Drop duplicated ones. with patch 2/2 there is no error anymore
V2:
 Add a new yaml

 .../bindings/usb/fsl,imx8mq-dwc3.yaml         | 48 +++++++++++++++++++
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 12 ++---
 2 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
new file mode 100644
index 000000000000..d2ccfb35b392
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/fsl,imx8mq-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP iMX8MQ Soc USB Controller
+
+maintainers:
+  - Li Jun <jun.li@nxp.com>
+  - Peng Fan <peng.fan@nxp.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8mq-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8mq-dwc3
+      - const: snps,dwc3
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb_dwc3_1: usb@38200000 {
+        compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+        reg = <0x38200000 0x10000>;
+        clocks = <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>,
+                 <&clk IMX8MQ_CLK_USB_CORE_REF>,
+                 <&clk IMX8MQ_CLK_32K>;
+        clock-names = "bus_early", "ref", "suspend";
+        interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+        phys = <&usb3_phy1>, <&usb3_phy1>;
+        phy-names = "usb2-phy", "usb3-phy";
+    };
diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 16c7d06c9172..c167fd577cae 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -30,13 +30,11 @@ allOf:
 
 properties:
   compatible:
-    oneOf:
-      - items:
-          - const: fsl,imx8mq-dwc3
-          - const: snps,dwc3
-      - const: snps,dwc3
-      - const: synopsys,dwc3
-        deprecated: true
+    contains:
+      oneOf:
+        - const: snps,dwc3
+        - const: synopsys,dwc3
+          deprecated: true
 
   reg:
     maxItems: 1
-- 
2.37.1

