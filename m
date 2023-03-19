Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E76C0101
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCSLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCSLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:50:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD21CBC9;
        Sun, 19 Mar 2023 04:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccgmWObwZ4m2bFm+XzMfZSfWq4emIyOL2lkXzBE2kvpVDFOD8ugWn5R06GVRleic7dezW2l8VxLLHm0xKRu/DJZRSfSWXKEXYh+Bo58hao/R+Ubsi5Wa89GWh636HTenhpQCU6xSMLvFIRUYgnbDkwFHRenMRY1W9x/4mWdS3PVKlb6OwDhXA76icTts4r3SZSpWyyVBD+WGqddK7qrS4vkAm4M+6pW6vW7MY58tXfiu69sS/2Sf9g6/kVVna9Ocp+ZACTiKo3/hmp8WnikuwBSSOo6KyNAGEh5PZqOjRP3GZdgX2RgcPHm0zv8FbBHynrdPR+Z/YeMmb6ljER6fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMz3p6Irib64hv7d0D58VrlbW655Wbrb3tHBPsYkyfw=;
 b=gYzYK65cxh+lYXl+f8IdI5YAhWR09+RAnx2lmhO1x4F43J2Vf3Ae5uz5C/k33JrgKztDFZh2mGogLcatHANZp/9nAQ3kCaB99orRf9NP/yH4AFEP0HNQ3su3ZlH77O0YOos/a9b5hd/+Iwu/ZT0qUlxOIwCNkWaXCC0BfNPfC+up7Qp6XvvajbmtgpF8wtMbwsQe6KqvBs43FXTA003/KuOuFeh8t7jkQwIj/fG40Bgw3OIvsICpYiG9v13OruLjS6wIivj/7GyLC9L7Gn6DA8VB7ZJ/TgRRhVvhvfGZl+NHh0mz/Gd74qmxBu9Ba1ECIexyW8HhqnbWJZSykPfj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMz3p6Irib64hv7d0D58VrlbW655Wbrb3tHBPsYkyfw=;
 b=VbPx5tdLG7dtRaD6VnmOIUPfMpM0b5yo9Y33BWIoDMZwst/rQ9kuOdWccgx0wJ4E9UTvEco7dB+DbFV4CNdJW1Lp9GnjLuGYUaiCOpCJdrCD8bM2zCMFRvmkyhqHQDZU8riAc1wzaiQcpyMEjIlZkZ8j9XLYOcE2GnoB/DWPZic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:49:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:49:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/9] dt-bindings: usb: usbmisc-imx: convert to DT schema
Date:   Sun, 19 Mar 2023 19:54:48 +0800
Message-Id: <20230319115456.716969-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: 691c503d-9609-4506-57c7-08db28700e90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THSFdIq90fct8fFGA4q8LfRIvb0E2fRBKsVjEVV4+SGmEWF1xEa9maPJVQlLFcNHhhLiNFIj4tS8TbnrgWCsBiQXLA2ERWZm5SlcRSCYANWA1pHgGxYyMtD+sL6KV7kDqVXhrchtbSE9i9Mp19DNFPfhu94pln7pxdZRo7LwoAoI195yxRI/DA98rzG1KRew5TEYyTV1+3LpehKsZ6JUV7U+QOBFpEbax/XNawhVMcO/YxBDkJGExRIj7ibOh0CH/BbWIxOWDfM0/vYh8Q9SJ7kAqEx8i6Q6SkcPyOYu7oBQBBTr3KNTdoMClyC+XYbL5/osjjD9CDbvL2naL7KpvKtd1Bs1lvqF1GMx+CLKbxIAvFHIROpsyAiED2gZdHG4qaNcI4j6ymWDSob6SB9zkjkmyXp63MKFIjgPVTf00H2DuSIB+eGi8WOvM9jeYa87xGxo6nhMyTZz//v3MiBjL6sDA2nqzw+y6d93PfmJ5RlNJ4aQmFzO76p1j2WfcREryn6AgDJUSFRIRtohpMqXJmnyrhr+SvJEGdOUh0ASXSpN+FlMdNQzxxs4q4I8N6CNvxt34t6OHByW3m0+o12+ICLBgT+qNa1boeu05CsxUqJHo9z18G/U7/Bqm0QQbOSs/cT3lRgoz448xeAOhkHr5EHpu+8B4oNtjoMFQyL4cD1R6YAgE5x5nAbFouRjW0fxQ8VfVN3tPkHNf3s6RpCV0VUeJxTK/uGTmlLemopB3Yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(6666004)(38100700002)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(966005)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTirUpdnUVlBytx7PVgxWbdHRFE5ChHUWbw1qbJJWG2t/M+M6snr6leqdf4I?=
 =?us-ascii?Q?FGd0G+/aP96NakQ3EbF0hwKhzmNHK0oacicMNitlGCch3UF0zwcRxCc4niKE?=
 =?us-ascii?Q?2k8iSiF16g+JnLMbgQixRzM5vf1NuCntFPZr9aWScfpJUt/qeuGSGWPBGtWf?=
 =?us-ascii?Q?bKV0Tur4n+TVB1JXCtE1UayZkrTmQgVEZfB5qix0fQEQiSB7lSNXHA+bAdy+?=
 =?us-ascii?Q?aKrQ5VHaHCIHyf4DqH8H6eUnsrwBWFT7cuT/oMrsVL2d2PTT59YDKd/4R1J6?=
 =?us-ascii?Q?P5444JJxLDa3o7fcKkZb003O62nps36Rxb0Ff8dDg0FYKfmRLrsjC3Us7Wv0?=
 =?us-ascii?Q?v47KwFzSvOHYz2kMTiHxl/+huwnHKvfc1XH8ZQ29RxSMr8isEUJW72cuCQHS?=
 =?us-ascii?Q?vNRJKhwbSt29nWHVb4bBp3is8OEWkXrcdIQtHMVsj8LNM0QYYRh6bf6w+NTL?=
 =?us-ascii?Q?Wx0N2cbs/I7FNr/WcL4Kg1hyjj0lXxkdCLiqG4CBjPrEBhcU4UKu0l7/vlAM?=
 =?us-ascii?Q?/IP8fIrVIp0mhexxHjf1oi6lS3JXLMFdfuPcgNIy03qvV3nAUYtxUClIqV/J?=
 =?us-ascii?Q?88inPQ8mEXMO8xkT9aqZTQ2zY42AGTykGt9ncwEMU+xgq4SH0cO7msQGTUxw?=
 =?us-ascii?Q?4edYJzyaCFaudmE6WZ66YTQweCE4yzCmhD0pauZoi0SVyX5oSUFfprYzf72A?=
 =?us-ascii?Q?m3ct2kKSbc1tNmUxi5dj9bFGncmqU5wyY+q1FPMe79WTOt8R+73sEhJQvOoL?=
 =?us-ascii?Q?Dj4h2Z4aONmG1IkgoAtviiw7T5A/v/sKrk1ZBzNbFmFYt8EpPEUWidKoDh27?=
 =?us-ascii?Q?vgOiSkisBqc0aeFbx64PGxX16qG601VdsSQlSZXR8tsbMSkICDDkrQYGWgMt?=
 =?us-ascii?Q?l6xFtqXaQTufzz3y7USyDNVBNGzNhhwP61MSK3hKv06Dt49/KHk9ioF6ATLE?=
 =?us-ascii?Q?F95tqlXiJ1U8TSCrkfvkVk+DhrX/bltW2HgFGqGqSH0B5GqeXdWUAOcKvOyC?=
 =?us-ascii?Q?lo3j0XmzbxcdkatJaPrQW5626lIFTaW3lRNw9J2f5AzLzyiN+RaLTFoC6dW3?=
 =?us-ascii?Q?sDg3DmzM3ESlxsdxqmsWf0CO/1HLUQxClqWTHL2Sc9UIkjWrdJ95Fi76ZSA2?=
 =?us-ascii?Q?Dm61Vxr5fKsXUH9uYOtgwuhqMU2MTyVxRuWh1sxUdcGKYvqc0IDcCq8+vD9g?=
 =?us-ascii?Q?wMKosFHX6v9q+Upg0S64OluUuM5bftutHDY25iqsU6kh1YN3/FFjG0t7n9cG?=
 =?us-ascii?Q?wO9TYPb2Y+bYzJxQyy/na1lGqJzoLl7mZ46gGizAB8DsiLfmKoW1uFjnYjPt?=
 =?us-ascii?Q?aCi/UWpSCcosZM12I+37G5hwnSLkDDit+e6Jzsl1FOBSoqcqGBK0Y7HZdHu7?=
 =?us-ascii?Q?6r6V4wf6gssz+X+3zitDMTaRd2+gAvTHy6QePivT0kGBgL5ulaYKMepJUxhc?=
 =?us-ascii?Q?NGntkylgEe0/1f/h1ujydqFlhW0AnUfcdKEz84N8F7aCdEGu+mTYWjkRtmfO?=
 =?us-ascii?Q?6yphbQP01rK3fe8fI4gcmDZp8YZK3e3znm3gDf3Yj625r6S8u7M68s7vbrM2?=
 =?us-ascii?Q?geASpjKcLbzt4QHwHwZtbrQY8eGpjdNBO1F0Abpm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691c503d-9609-4506-57c7-08db28700e90
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:49:55.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5O1xsgNwlNyHnfjeW91bDIBKUgv/ftBxP/ADy/uwxueZFdGZDzrSMqjkmI7HoT5sIz32VuUHPGF9fsi/stdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

