Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB976F7FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjEEJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjEEJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:12:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51378191FB;
        Fri,  5 May 2023 02:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBYZhOJbD09uLzvpXpFdkjKJAkd9OoKLZNJTwuCde/xGNsSanyGRLrH4p+IwlrTqZMOyDRSwJkAxBKi7YycW+xTuE83dUyKjGPLo1HhIWAwgGlXu7ssGDheSOAG/AyeR139rzp/Yy4bhNxd7e/GjwPbIIeh4zeY5A1NwT2splBl+qdQcqiE8/WhMEiWG6qP5G82hDtYv/P/gmA34PfWcnI0yIFQi/cL9z/z7lL63dQYGg4+tP9WKpCsIqOayDBusBLUR0Qe04xcaEBpZWmfIf8wq2JQWIPy4/dU1gGO1RBfv4OJB5nGo45gSbneKyLNRw4irce7whqZzs2g9CSNODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc9JWIKftSJW1SZOcCLvMxvbKL+9gvaW+2HxIyaevBA=;
 b=CUT1jO755emieTDDhWwyn/TbFGIdI+R87ouVFJN8HBs4Y8YN/WYoOCkjwT84xz5lI+tnHD4Z3TcmVCmn3GgSIHhuHBHRKJXFeb6DmHAcwWksSwAWcet3ex9rtnfqAk+lVyUdTq7TQ7GBNz7pX8Rw7rCKalafAFG8RsOx8KJ/so/3J206r4hOWg3349XQyIg/V7f2tizjtBl9K63rqYdIfKBEg5hZfKAoLacV1vini4d9INVEzgdpKKn61xTkeL+0jb6p6+IA4LS56j5iC4iifiyjmVoDURy7yGYRHzvfmnZFuBbEhkfwBIPNqkldahO4HE6/EYYKy6jBdsEZPEOZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc9JWIKftSJW1SZOcCLvMxvbKL+9gvaW+2HxIyaevBA=;
 b=errJwzKDy8dI5xK0yV98XAS8YModm66z8mbBPd6PpSn86WofbHUD0L+GA+hZZ2Gg6FV6+ay7NRKMg6LDTEYpK7Na/ehSlFSObNRpIh9Mb4VsM//5BlI857tJhaCA+4M0CO3S/cB5ZFZYuvc/JsvXdskZtgLRjCtv7nGUMGX6tRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9473.eurprd04.prod.outlook.com (2603:10a6:10:369::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Fri, 5 May
 2023 09:12:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 09:12:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX OCOTP/ELE
Date:   Fri,  5 May 2023 17:17:32 +0800
Message-Id: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 390157fd-e56a-48ab-4fa9-08db4d48de58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyX8b300UmBlQ7zKTTfCs3mgmaqH8HqmMSv8t+TNMwRZnoPonZYWzxgL1jlBqX9Dh9ksuDE3Vls3EwSZeuMRDe175uNvAw94Aol9nIpBQAZzGMu0/Glk2l1dPC767B+Wxzizq9mka2AsoDIeWN21/SGblkz1rFfSBrVJHhOtblGnFIkKRt6gR2zmI2z8KFyW3eP68Zant5tnQqXYFhO8C9DvkTzGaehrC0TohDax/x0dhg3mFd4WUb/RaEysfuYLtgg22O/JFP78XFLZ/iR9pQ82u2SKdAkhKeXa9xbmImqrwwg3xXWzwcMYQ3XYlyjjbw7KJ24NAXAJUKlL0V0RFXDEpkTVww/B9CYjgZyZaQSycMwxc2BP+6/MQSFrq7Auqxu4wJ3Qs0ShDRdnvudojNkIWEc5ApMH+QpoO+cBd6AivxU5b5KnC5MHX4+zfXo5Y2aCIClx5AxS+T/VSXfun3IKb7E8jaPg0SUQg/IkBzmzfBdUp2qJx377qvNHf5ZJG+pu7pBzjgNkhOPHxu2wdLpfzfidNwfK117ZyzNlnmtHWLkFYMkzfl75Y2tiUzAhQVl8aSniPLfXNqZEAfv/tbjsn7MBJU7096jo4sdwiImO+XKoatC8oD5iQPDqgvXWRqNTdxu1ifLbLDjntViCBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(66946007)(2616005)(478600001)(83380400001)(6486002)(6666004)(52116002)(966005)(66476007)(316002)(4326008)(66556008)(26005)(186003)(6506007)(6512007)(1076003)(8936002)(8676002)(7416002)(5660300002)(38350700002)(38100700002)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bDj4Cci9HgdEesolPK5aFHMKaOlzjp3SZSBuEyRX8mHZTdtIBv6g+TBP3M+?=
 =?us-ascii?Q?IRgq2DbttY34r2zvmLKIjAh+0gpuL4x4IwxQEJt/MMFzCWjIBbouL/v9pYLu?=
 =?us-ascii?Q?KqqUKDAcLhvAF9OxxaLJS3qAkcuYeJ3qbpXnYG2f+OU3IhPL39fDa3g+udD0?=
 =?us-ascii?Q?a0Iz/0iRaUDjNZMYbo9bnP0pf5Rx2PFSTaE1Emp34NdB0Jsfherh3Fy4Jee1?=
 =?us-ascii?Q?f50fs/PVBIJUrf/ysHfGO+X9A3VffqHAObYyB1ZEnJGgYWDVgz6/BUWi6EHr?=
 =?us-ascii?Q?dwaBhEDce5+MjdC7G3jnyVTR3eXrBX/Cr/Oq2Ce94MS1xvYjyJHq0kVsYw/X?=
 =?us-ascii?Q?88ckLCPXh9vIGWJUSpjQm1zAONJo9cCSwiHkKvnRiNRAeasgi4H8hgRGdWZK?=
 =?us-ascii?Q?P2RJ480IeTM93K16MrOAOPs1Cp7IOdn6L8bLE5mLYfqWLssCCrSET7syF+28?=
 =?us-ascii?Q?A/Wv5av2BmpozZxt5m3T+7ZHS0IICt3GwhX+rxpX5Z0AKjxIfkfzYG1tGfXH?=
 =?us-ascii?Q?od+YWAOh7ovnRRwZVOnT8HY9Ph3XslmhiPEG0JDck9NAjIfGUx2gMecZZCPJ?=
 =?us-ascii?Q?csLfEH6p6GgSr3OsUhZf+H3TKnvE1LUyPN0NYQGJD784WPC7n+CrCrtHqrIA?=
 =?us-ascii?Q?YPUMiAHA4cx2TWrvqYNZ3IXdz1Q8/OUKQVgLcSolsi0v6d6+bbfCHmufr4LP?=
 =?us-ascii?Q?kCIqC5cMdhBl2r8sGJWFyL8AToLE5aBc5txN5g/vJe8YbJCOxnQBK3dFVCco?=
 =?us-ascii?Q?0FCBBUU3eOJNfbjuHfWtF15/N9QfFN3Q9ZAHitIz1jhc3+4WoFx8UEk8qhsO?=
 =?us-ascii?Q?lSr966MiPGpoqZZkTiZbleuWrcPvoNyfA7kL160vzGUgw78EOYixnUi7ftNx?=
 =?us-ascii?Q?IGGHEsu7RvUkC9EGcUFzeDD5hvHNV7ovNxkntGkee5WEFbTa/d1EmZLTajHD?=
 =?us-ascii?Q?dg8fMihOp1hs7sYCLM+LN105ZfmW0Zi87VF8lqowYSgIa7E4G/qql+r4RklI?=
 =?us-ascii?Q?za5dI3zT4zQbdxZM160Ob0HV0pj/CObed856kP0Q8xAqoGhGwBMpj6NpDuJ5?=
 =?us-ascii?Q?PYPIn2BaxKe6FZPKzbNZoa+f1f5UoeK/njYsbEsrfuknVk7cuxX53fhK6L2m?=
 =?us-ascii?Q?SoS8yVsQUgQssizoYQ00cnkeme1I5H01OgHoDC9UOC4i5klmXxYVeKGHYwoS?=
 =?us-ascii?Q?qG7q4XTu3KnuiAo3RviGKLMBbdrOfv4Ce9qx1AgiQ2Ym5ZSrJ97hdNn2+J73?=
 =?us-ascii?Q?yHc3m2P2hk+WSnklp7alFddxtiV8KnOy3kHtBEPcJZY9EgKEO+HYcNVdqrN1?=
 =?us-ascii?Q?7MjW5Kuxa2O3leGOppkM5HpsIgKLmBq8RYtZ7ScR5ive10EfzPNnFDDyRbba?=
 =?us-ascii?Q?j5Pq93G39yrF1di6I1VBPWPbI7XmfSnsGwzTFASUP1+Et7sKs09Uyhqb0KDc?=
 =?us-ascii?Q?TcRcAae4DBw5iCjA/WAV22rNq8jo5xGtZ/ilLQbDDCr2Iny8oFc8vDlmV1xJ?=
 =?us-ascii?Q?D9xrT0/EuqZ49EHNNHF/CKxEeZAb4wPTUEAfnzX8r1LCWp5co+HuQnOtZNmq?=
 =?us-ascii?Q?cpcH41M6jSxGev6XQbV5/lilRpdJSDTn7Fq6FAhS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390157fd-e56a-48ab-4fa9-08db4d48de58
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 09:12:37.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEzBHdvaKNPaNENgbIg1lYAaPg0yQERW8+RwFElDV5ScTb9U34lEp2Ljz5cJio84ESUa4CMFMajmkUxTD2sg6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are two parts of i.MX93 OCOTP, with 1st part Fuse shadow block(fsb),
2nd part managed by ELE firmware. This binding doc supports both.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/nvmem/imx-ocotp-ele.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
new file mode 100644
index 000000000000..024594a2bcb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/imx-ocotp-ele.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX9 On-Chip OTP Controller (OCOTP)
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx93-ocotp-fsb
+          - const: syscon
+      - items:
+          - const: fsl,imx93-ocotp-ele
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+
+    ocotp: efuse@21bc000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "fsl,imx6sx-ocotp", "syscon";
+        reg = <0x021bc000 0x4000>;
+        clocks = <&clks IMX6SX_CLK_OCOTP>;
+
+        cpu_speed_grade: speed-grade@10 {
+            reg = <0x10 4>;
+        };
+
+        tempmon_calib: calib@38 {
+            reg = <0x38 4>;
+        };
+
+        tempmon_temp_grade: temp-grade@20 {
+            reg = <0x20 4>;
+        };
+    };
+
+...
-- 
2.37.1

