Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31AF6A650C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCABxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCABw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:52:57 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF422F7B0;
        Tue, 28 Feb 2023 17:52:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0znM0rHKBnXfNQuo62yrvBHBgQJIA9Nz4+rr1CVWVI8YRXmn9adWMy6TIo8rTdZXc1Ur5GO78miDK2nw4eILNInCq9DduD0UGzh6+NK5HO2q4jL8SM9TJxAZMY4FKdNm09ui3SE6X6dKK9wgyiUbwGyYnshFPg4Fd6RNx/krheobsbxYPt8qmFMgANRDOzFKJh3O8VtdT9pkhrNlW0M6DkWDEOovJXnW0aAQUBI5R7k/Xg4luEpHiaGLoUe048BqRxxn9ExYkzYyp1Bj5amfNposijmo1wLL27V/9BZOqnYtRvmvneBdfAyzDT2FBPe6EUq+44ktJWfO3Dd0UOoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uLq7GYxk3Qe0dv5yu9+hoQr5GyJIbIGUhhpNFNWGDc=;
 b=GjlRHLFkug3nO+74vTgqndaZpmGnV7PF+KpQvfUYw3zyAolXMnCuJN8XB5StQPArQJPVoAaByYU/kSZw4EvD80sVBs34WKVGkpm+BmEkcZSseev5yn0tJ2+X2JD+fZcZLWOkRg5QMBtTbhVnE9JaZBvDbVmfycZ9UDPljq2HmoXGzshJhtiOnS2Vbfz4SixFYDQooCyZuv0r4TUn7SH1DrOO/4Q7gZxJ5oWeWADdYPbRW4BcektuVt1vpujn+ZNuAwsVFJ53AWUw+lHqRScniTKE4l/3qVj8yh9Q5sE2t/k6UDR/2gs0uAP42vAL+IZ8JgmHarFq1JBs3A6nJThOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uLq7GYxk3Qe0dv5yu9+hoQr5GyJIbIGUhhpNFNWGDc=;
 b=CTttcY12Ak/DfcgX53bhdnCCRr6d2w3kyZyyUx6ymHT/mwMSw3rNnTRJzAYpea+JCmGJPy1XhwnfB6ccuV6+r9LwCl6GHH4JdccW/nRc9oEOcc3edjJ/s5NcMcjoXh7iNwA6rojQ//9ZvSk/0aK/A6bBFpZeAoMGXa8FU+hPZXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/9] dt-bindings: crypto: fsl-sec4: support sec5.4/0 and i.MX6UL
Date:   Wed,  1 Mar 2023 09:56:56 +0800
Message-Id: <20230301015702.3388458-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e6c94-94a7-4ecb-8d0d-08db19f79301
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/cfdHBuAleVd3zWn1XJ8Y8TfA0oo7XpnVchJO/COBZAXgqOA0KYfECr980W71iZ7ny6XDYrFUnhMkBKiENmhCXlI6LGvOAxXpFiikgJb0Naxx8evbqROPpRs4sceKC9NoiO2oEYYWTxYCirvyXFFv0wWZcqStnGwUA9qDlxCIHkVahg9Bir+4v+n/R8sMJ3UXfRI3ssLa6ODow0F49hZg/JtX9hyWg9gno/9mDGn7XEnlSmLkNIolaxxZmrOmt2Vn/yuV+6ekV4JpX/53kFN5zJAFI9dByIUwwRfeLutyO4GGwVz/cT+i9NGdTc2eh5GgAba3Ymb34U1Xzl8I2X7ZeHoTbm1/YLaONZVKGZjR2g4iBN89tHej3QPdfERB1NVeNdGklFE2lw/dMYm6fh4duN3EU6XCiiEiYXyztq7w6uVNUOyTVp81Hy4VHVTfQNXmMMyK87vddOaUsebYvFPj0Bq4a6mqqdQYezFey6IrEka0Cq1LwhSbHJjn0Hy5KiiJOp1MD/veDXCSghJtBTAPREDVMmgiNR5+bDYSeOEWq4ruPKYkSe7Q9uA0gAMLGgo+g/6Hn1gOQev3dy7vmt8P7ykrUIN8KxhfeLhKVRqxpeJcCCHtnnCj+7OE/lkOxGi1NOQZ58WT0H0bBuzEXuOmSLMbPM+NyI659gPvW7JCG8zG1rf4obl9d/4ceLCEECjMkOzKvX8bD3DbUnjJ1CfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CzC9b9WOYLwYw+ygOOEJRjrWCdiVm2Em8GsyDM/0eFG6xIWtpTmeM9zpwAYc?=
 =?us-ascii?Q?/FC84/AWRWazcnrf8uksMyb1G8+5nxH5eO7MyjtuQt+TXaNNWaIDVhAYKvwo?=
 =?us-ascii?Q?Hlq6yo7JtVYvj7+KFJZdyO8m4fRZM1XzwVSfnyl3trYe3FsJtg/fTkC10Qam?=
 =?us-ascii?Q?Q+DZTcd6blulALclwr0YpPI9400fiGcweyZ5ngM5iD96E+RSr/bi1fNXKZSS?=
 =?us-ascii?Q?cCfjRq4/pghpbTyHdCKL4hQKAKLraMEolgSNl7XdAETJH3fzKKBtsHz3eNSV?=
 =?us-ascii?Q?ulp39KCEKBZ14+AOPWZlFeLd3XHZIlozkuKxVrIrn6Y+TwQ3ffUcWewPjAy1?=
 =?us-ascii?Q?CWK7ZaHlcPHWc6pJjRgvXA9JKvh9hzTtktqESV1I+/hvHublu8j+sYaghpox?=
 =?us-ascii?Q?ensnRZHNHAJ3akTJKO1Xqe4HII3FP9THS5/1ZP6c+zIoZy6Hupd9TzL2BDFo?=
 =?us-ascii?Q?2qXPX4TesmbIwYlGHeKJwfnOuocxhkGYxtKuDLADuMPLrDSTJhzOU5ceN3qM?=
 =?us-ascii?Q?aAdBb2QZrbjMoxGthF/P4u7os29+1MGBepg4ODr9JlK1ZrgJJIomJtZY+P6x?=
 =?us-ascii?Q?v0yBDHNT9+pL6pysG1yVvTm94dgttSFrSS35PpIDwzkaPLtE/Cvh89aZBGIW?=
 =?us-ascii?Q?2Y+o/CZu2fcpYUoPDt1V3JD/7rUnifwx517r7ND3w2oMn/3io/7ySUCFEqzb?=
 =?us-ascii?Q?Mga+sNY77YYgUWEyMcXX3uJxWSOo4alQa8twFu2JGpTC3w3d4EpqMS3UI4j6?=
 =?us-ascii?Q?x/czD/LpQCgUv5aCzf3/AEvsSUgHwBkXvmOhVKDPmknhInR36WH2snpuUH18?=
 =?us-ascii?Q?TsFYlXNJR6JgK4fLzeoFwlUudv0+lBvyI4w1q/V04/XaZUojhxFNXMXxMBGo?=
 =?us-ascii?Q?1x28zD13yRcO69gw5O6Zlb2RnR63urlF3Bvs9Rp8eXhHRP+QMktZxzcTyTBT?=
 =?us-ascii?Q?6Ca45yk6ZPi/DGL5RbKQfjA9JjJgVK2EJkna6hpJvLaF2LNHgmyjH9jiVBGj?=
 =?us-ascii?Q?8uM6Y17vwkupHH3LVuip6EnHmgY6MD0YF5MsZ4TK4sdcl5tTUdGJ0NSuOSno?=
 =?us-ascii?Q?Ls0RWacKfWa7RCIx63Y9pKSXVa+hAIMx16mfND++aFhF624obRSFsPLF7s6X?=
 =?us-ascii?Q?Dut/0U7ge1FdePVK9bzN3XnmBvcYi/2W1FoFbguMpMvb+1S10GmOx4ghKov9?=
 =?us-ascii?Q?OHvVwJqicbHB/meQ238bcjVg6nXgqanlHoIWHd+wB+mJJBKqbBeo+VU3JGfO?=
 =?us-ascii?Q?ezQ5/Y+cpx+BT6+zM6X666/s2qTpaQFsQdHS+y5Brb+FlsO0WZMK5VFml7Da?=
 =?us-ascii?Q?U2Xp7pIfpGXiy9VTc2n5pMC9IqU4Ht8/KQsu1kgwkyWdge03BF2LsjjM9ZQl?=
 =?us-ascii?Q?45ZMr7le+p6TtEoUb24A4xQhkIeT4Yl9JUgYDiWGoFbBg/MNwgfuYpXhgh7H?=
 =?us-ascii?Q?omaDPeW3UvfvbGnv7ZRw08FnVo9otUN6IH6Guj5wrNXyukp2WtF/LaxjRaYE?=
 =?us-ascii?Q?xz7FiGia4BHf7vbE39sSeT1abwRnuIX/tQkq/iBhitm5HFqgdAaocTB59Y4f?=
 =?us-ascii?Q?VaomTt0TmFo269gUYVEiLslTI8EIkz63RZF0JfYQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e6c94-94a7-4ecb-8d0d-08db19f79301
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:11.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qccg6sOpNxRd/jx5bKy/wwku0JMtkV5ZoRFZNoK7ZjGy/6pkCz2S5xFN7XrZunO7gnQkNsNyopHqFE9QmuuZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX6UL, SEC 5.0 and SEC 5.4 support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.yaml  | 58 ++++++++++++++++---
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
index 678c8389ef49..1b801ae5ab51 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
@@ -45,8 +45,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,sec-v4.0
+    oneOf:
+      - enum:
+          - fsl,sec-v4.0
+      - items:
+          - enum:
+              - fsl,imx6ul-caam
+              - fsl,sec-v5.0
+          - const: fsl,sec-v4.0
+      - items:
+          - const: fsl,sec-v5.4
+          - const: fsl,sec-v5.0
+          - const: fsl,sec-v4.0
 
   "#address-cells":
     const: 1
@@ -77,6 +87,8 @@ properties:
 
   clock-names:
     oneOf:
+      - items:
+          - const: ipg
       - items:
           - const: mem
           - const: aclk
@@ -85,11 +97,17 @@ properties:
       - items:
           - const: aclk
           - const: ipg
+      - items:
+          - const: ipg
+          - const: aclk
       - items:
           - const: ipg
           - const: aclk
           - const: mem
 
+  dma-coherent:
+    type: boolean
+
   fsl,sec-era:
     description:
       Optional. A standard property. Define the 'ERA' of the SEC device.
@@ -108,8 +126,16 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - fsl,sec-v4.0-job-ring
+        oneOf:
+          - enum:
+              - fsl,sec-v4.0-job-ring
+          - items:
+              - const: fsl,sec-v5.0-job-ring
+              - const: fsl,sec-v4.0-job-ring
+          - items:
+              - const: fsl,sec-v5.4-job-ring
+              - const: fsl,sec-v5.0-job-ring
+              - const: fsl,sec-v4.0-job-ring
 
       reg:
         maxItems: 1
@@ -148,8 +174,16 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - fsl,sec-v4.0-rtic
+        oneOf:
+          - enum:
+              - fsl,sec-v4.0-rtic
+          - items:
+              - const: fsl,sec-v5.0-rtic
+              - const: fsl,sec-v4.0-rtic
+          - items:
+              - const: fsl,sec-v5.4-rtic
+              - const: fsl,sec-v5.0-rtic
+              - const: fsl,sec-v4.0-rtic
 
       "#address-cells":
         const: 1
@@ -187,8 +221,16 @@ patternProperties:
 
         properties:
           compatible:
-            enum:
-              - fsl,sec-v4.0-rtic-memory
+            oneOf:
+              - enum:
+                  - fsl,sec-v4.0-rtic-memory
+              - items:
+                  - const: fsl,sec-v5.0-rtic-memory
+                  - const: fsl,sec-v4.0-rtic-memory
+              - items:
+                  - const: fsl,sec-v5.4-rtic-memory
+                  - const: fsl,sec-v5.0-rtic-memory
+                  - const: fsl,sec-v4.0-rtic-memory
 
           reg:
             minItems: 1
-- 
2.37.1

