Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BAD6C4B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCVMvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCVMvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:51:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E1811EBB;
        Wed, 22 Mar 2023 05:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4RkyQgMBeh2kj+hHrxCcty1iRz6lCAfW30Q2WQjQIoJLdfPkDFwyy8kFYpdz93uoACbsdQyrUfKMAu6QhzE5JgbXfiEzdPc4uDpQSBKcfNcYztq/kB+FNg1l5LRfDB8X7R7DFBYssg4oKDSvskBfWnRS/0MUPvu3l8lakgByc1ks5O9RH4VnQt80vSnCZ43vkLVteiQhuc2Om1NXGbEHCKsbLdUB0hJFExa2fcx8kG54HPedrYsgJsnYbHeLXVWX+XqvpE4pjXA0fsaT0RKEtXP4ZpE+fxBWW1gBbQs4YagiImKy8VpZniddGgm0ws6YPS8/2t5J7KOP8VSTyeNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE+SF97Nr9xmxw2bxHnZ1+fzvQeNqUA1CQdOXXeesDM=;
 b=fijcRX4vdIXzNhBSuM3++HWMOzKIHHXHH1vcU4nzmS7YIpVFrHnKAoh2m+YKNbhGs+KV1F5V2RtJztsjBOUEISUnSaCjo33YrJjit3IvHQjhCz7abk2/mcv6aqIenbq8Io1j+fs7cqcZtTGjUfqCap41DHp8yPc+apoOTz4pAtyHWdQKfd5L9KqAMEqLZDKVOGLB7gM+U3kPxv6W5hYNoUsXfxz8cpcCLwym5TbUFW22szPcDw0yLLY0SbZHivVrjrx/hXr56/Yp+MANkz1qVi5SlZt2DN4IF1IX4VXH8pEK1XgDbL9IAzgu+APmY6UVXwsb2SRoHmdkX0AkJrll7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yE+SF97Nr9xmxw2bxHnZ1+fzvQeNqUA1CQdOXXeesDM=;
 b=BPri4+22Y+GvuumeejvXU+p3ScyaVm6WAbMdMWzQRag21Q61zZbUKWWcRl3xz2LR98EyXkaLkSeNrrfDxry26DrRGaVwhEoifwdFVu4qzyWKsgSDIQAf3L1s9UXZ0T1FT7z8ZqFlkorSrcgu0SRKuo4FIvXT/kxW43qoi4dSYB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9756.eurprd04.prod.outlook.com (2603:10a6:20b:677::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 12:51:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 12:51:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH linux-next V2] dt-bindings: usb: snps,dwc3: correct i.MX8MQ support
Date:   Wed, 22 Mar 2023 20:56:18 +0800
Message-Id: <20230322125618.3402577-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: aab6a2a0-bb18-46c8-668b-08db2ad41e28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83afpwXshU6CCoVx2X37b+78ny5EfJVkxwrvipwYftxFqVH7zM/r+2YAfIuUzu+lii66h14NvlfprNQYwNQGtgOczT2/B0bcd5dmNV43ZDi7cd8bVbiooQq6PIWj9rclf9gk7shhRaSWV74GV2zUij1/lN1uri1WdGtvAVhYcThOfPKqCTc2M6bgsHlSXMnCQq6ktdc5rqGasZQu+twJRxsiNyYw99DQtDzYHCSMEnl2LTiptF24bYmGwVanLWPHAh5LA4R+yqBYt3LIkcdVYOMEz/J/ISJggXcVLQ2hwPM7rZlfD5ZUzUeUrbZKVxjN1NXHgsak2ufGzEhGxIN/V6VGlj9vnq6dMccBOVmDiYLfZa0K6q6J6DyCEVma1E/xroQPmbTeCLbigZneLr5W6eiei4vdWVVJ2bw6UnvqTGU8J8eGLy4vzGYKRY7G61ubAw7aAx30hdbulugMqlFdks5+ZIoRqA3IS/yyX2wiWMiGV/6f4LjfYFdf2Mre9D+pV5dPUMOaHzO83pNo2HAcmWmJENnnG70/1gR315RBlkc5jBPwnhSsqwxMM+DBSUmwPcdqZiwgp6rjThsD9TmC2hhgdFS4fDsbsF/eFjWS/YL1sdB3ITlGebTDYoSu33H3mfENvSdKJ7CSOXh4mN9s/COVmZxp3hoAXWR1TXFwcZ298RMNB0vj3smOpia3NvMaUwZsg/KYYE/+WLqmdZq0cEx6h6B97MqHCvxEGdtXUK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(2616005)(83380400001)(478600001)(6486002)(26005)(6512007)(52116002)(6506007)(186003)(5660300002)(1076003)(7416002)(316002)(966005)(38100700002)(86362001)(8936002)(66946007)(66556008)(8676002)(2906002)(4326008)(41300700001)(38350700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uySpZ5VGdvmGF4dueO8sHkT8BrJsqn2F+HWFN+DJwG/x57v6X6OqNySgJwVE?=
 =?us-ascii?Q?rBn0nOm6oxo1k4kAUaO40hpdRSfkl/bHoUVc+R+tLcpYKbhIRWNoZrDrSdTn?=
 =?us-ascii?Q?jzHolKB7eOMwIO1ZqW9/RQA/GZ6mLFDILn9mWS5E0UY2F/XkA4c7x7NGrkjs?=
 =?us-ascii?Q?dmcyvOMGuNj1Nn0LU5yu5WbeQYwxwLpp/RbaKQz1WU8oEgWHkqLPuhYSE57+?=
 =?us-ascii?Q?xmOViT3j48wMVButPmg4rb6gWlMO4YBgFFp9jLQJxtyXGFjLG79b+DCiCsCz?=
 =?us-ascii?Q?59YFpK3ErRYJBMpYJGA+/Y4Xn0/ufna/B2hmerYO83BAmdETMxP5ILsqTOly?=
 =?us-ascii?Q?HNoAP+cyDbWczIH9QzGloE/cPq0ytbMEjQTNzN9KUmZVrE+9PwNdunBPqqDk?=
 =?us-ascii?Q?e9s6KbfjnJN8xlbxG4hgCPC4rebLAktHb/Uybi+JqdBoe21RG3GAv6AZW5ik?=
 =?us-ascii?Q?yKTbt0fryCPx+bzBiBQxUl91FnGxybx3qRK9VIoFq/kd/lCL/P87RxgDXGX2?=
 =?us-ascii?Q?nzmaY4DQBQCQup175+zruKF0Dq0ym97ULRFGv9lsfoHhU1pXS8RzXzxrO/1V?=
 =?us-ascii?Q?/daC4frG16TtTLJhMH5oHsnpGnK4DxZwMOvVIuigck7ooYWyXqptzppSnNxa?=
 =?us-ascii?Q?mdA8RVFyRx0BO2OEhq7Y397N8djoz1QhQxTe3blQzhCOT/0L2aAlno+5n9cC?=
 =?us-ascii?Q?ZVBhph50emlGOiQzOmYDtMTKXHjxD9xAsCS7LERt6x9Er5HhUuTXcKMCcuVt?=
 =?us-ascii?Q?WbLHRP8ofSHGWjOey5ZVBkv/CSf6WtqTtNOuuuofZC6IhD0QxFCmzFg1uxX6?=
 =?us-ascii?Q?Xbk2p9mTbd5p0i5PJMv9LAjUHy8EmN8A+AMo2I46ZztGc42enASUgZhKNurp?=
 =?us-ascii?Q?sU9/66GZXK4oiJC3zJxpI2ku1qGhZ8zBsahYS7f8nsuU37kRWkLLksdzO0Vk?=
 =?us-ascii?Q?jfXElGQ5ERa9b2cEn7hZjNaCL8DQoBDGvNWoaRmC15tGO4/ixm7UxDz6Hx5g?=
 =?us-ascii?Q?b0hel74Pz60BSJzdtNSmSjO1hruDnmFVA7KDO5T9kkNvYAPcFpOd82ZWvhSs?=
 =?us-ascii?Q?KPxuKTRzG44h12wSRienFKKWQH//iS0RiOCOUiPQ/sbBJwAOwf/D30Jq3mVM?=
 =?us-ascii?Q?O0+JetyYU3dh46LnjYXZ21+YvlMLjB0aBWTHQ7xSsjggOJBTHJZvcziN1Xi8?=
 =?us-ascii?Q?9UMHofGF3S2XPTGvjEEn1PSa28qNSeA/w7+5aZNxpmrAwWeRY8y3HbVHPrNP?=
 =?us-ascii?Q?vseYYKJhuEzTolG+NlCx3KuuA4Cs0oaVs+G7T0B41TnqeRag49+ucOyGk4sQ?=
 =?us-ascii?Q?nhRLyGeClozOsAJDdsvwEK25tJRkEUZAMXBXWilCALgMN585rkaLGE66t339?=
 =?us-ascii?Q?/62aYONEzazoBNyDgUzhHxxC5qESpOd187dttWN0r1z07S0DCsmMtqGdffFt?=
 =?us-ascii?Q?01ix/d1ttmqJ7RacI/QBY6LJloKUrbmLeWFbX3BOucNVXxhOAQ4lHLcEph3Z?=
 =?us-ascii?Q?+8N+qwFpQwZmSju4QU7wIlcqnfngB7yN+eOHGJ+sprTPKrtTsArtslbv//1S?=
 =?us-ascii?Q?nNZ9At3W/5z9UZBiGyxILcpR4IL/pYWLP7SRkX++?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab6a2a0-bb18-46c8-668b-08db2ad41e28
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 12:51:13.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFEsE4OEf5T0fCnXVzVj10/WTjIPo5RYXByxI6EBZL3i44hkkfBW7daw4ExJBp9ZRfWX/yfKACkXJcvhD6QhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9756
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

V2:
 Add a new yaml file for i.MX8MQ DWC3. I am not sure whether this is right,
 still meet dtbs error:
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb: usb@38100000:
 Unevaluated properties are not allowed ('phys', 'phy-names', 'maximum-speed'
 were unexpected)
 But there is already ref to snps,dwc3.yaml and dwc3 yaml ref to usb-x.yaml

 .../bindings/usb/fsl,imx8mq-dwc3.yaml         | 74 +++++++++++++++++++
 .../devicetree/bindings/usb/snps,dwc3.yaml    | 12 ++-
 2 files changed, 79 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
new file mode 100644
index 000000000000..055ffb122db7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
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
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Controller root clock
+      - description: Controller core reference clock
+      - description: clock that used for wakeup
+
+  clock-names:
+    items:
+      - const: bus_early
+      - const: ref
+      - const: suspend
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
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

