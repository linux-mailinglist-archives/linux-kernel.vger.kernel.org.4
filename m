Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A0606EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJUEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJUEOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:10 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7AE1CD324;
        Thu, 20 Oct 2022 21:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiXF/amexY8A8vUQ4whL8tihK+RzLtqdirwHxJwtqj1KVSzzgB2Q1HiUts8pu5GtUse9Rq3OjLyHTPOw4PmjeOTqjZcobEMGROaZgAWZqspi7ctFQxmDQMbHJoDAaBe+P/DpQMzEmfUvMkpWbkpL7NOpEZBEn6Gju6JoNCOUPdROP0By6JfnCtgzha995qb3Tc8SiO/3OBrraj2bZuOgEeGZCsDOWPgkwh2IzTPo5PsFpSZ8XKGa1nWPo9P6+gKoFKT5luWMoi0BkhYfMG9OHw9vnYvpw48OPpCrnWnUDUrhYMGx+MPBrGE1OXZLM0ncQC1FXfxQfnweKLjJhyMj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=NhoVWnfwQ22BB4q+s/RHTkYH+bYdTOckLLSzeY/JejP8BDF1AGz46Krixz11CwTW+RkJR45xBvmig2BRn1dKj7IfasLa7pRgxsF8FIC5rcdwvqNCesIIyVyB+LOL6AHaWtw92Rhwrp0niz8qC+pf6zz614KsRxhRmkOYs+QXwWNeB3peb3rkNW1OsvqS9GXbEUn8OI13amR64IusnMjt4CMPP4qtFAOnP7SzOoONuP3EzmBW9JFp0d0xBABkCk3uzo5VBpl6+d/EnaLFaBjFQUyoYPF8mmUBAARRmgb4YvkMChZkiGA474dOKfi/KGdoLTHb3/9UuP0i1OZmtkwrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=BT+n8eUAHalYRCWNKniNh+fosaF47c3PnuhanSv7MUncOC7vztzfhp1e3hJY1CxUCX8K2DApzJ/r0C9LW6iupZA8QctJitxw9COXOTS5hK6cdlgdKcmp+ewAqYEqTn2XoTQlOWZlr17eYb+R+sChj1++9DvFdp2IGUgf2PMCMn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V8 1/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Fri, 21 Oct 2022 12:15:20 +0800
Message-Id: <20221021041526.3696483-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 74540085-b25e-4f61-ef2d-08dab31ab1e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrgAaAgtT4l6kG3sBK7Ylwjbm3szHP8PSpo20KlgHMDfSGUJM4p/e5PRBOrvRdfRGeaPFH7RuO6Ra5fQmNbfQYPclabUUhp4oNO+nQcvhCvVaXpgwrtYiYt0vTZg1mekQkZhChRTBgZFX51Ur3Bhn6dcAbpFyE96XNZALk4875QFa1ZNi9ok/M4YtUaEwMful/IBCr0ruahF9sE/5iYNFSSSEIV2r+L55XM6XJN+ByEvE9KZD3Y4sxedyFwbQEHswFApI4J++6KzaTJ9s+JYZcyt6tWK8cRVOKBg1KSUTRwFLXhdIhB9+MROaDeNjUomnLGbnfUuwJafrK3I0I2GOq49FFA4AX4TZLM7vzUi6juY8zOAu3+1WVi12DZHu28EedzLsV70t4oxYMig4HAQpHujiHZP9SXDm9w73ksC7U3l7yR6yZeErrj3a/nrvwLo7Yhvetonmeq05IAeepmbLfK39n6B4N+md6UhrmQRLbUyavLboIBOoHST5D23gSPteqbBb2E7pkbCWNE35qEtigcW7Nb4aMdn78X7nEun3NeNQWh5VP3IddyDSW2VK8d9s921cdh77ihtmVoyZ2fK0+BRjIs9CENAF3AUqYj52yQcmdBX9Cs7CDAIegjOVBjubGmWIZm2iCXnW7w1OV7kKTJLj2zvVlikvYH/4XPaHNxbBIsHgBask1qh/JKdx0UOMPWCQcoZNa11ivL8Uu6KisDVXBocn5SJtuKPpfcgi5mNHX4Y+j9YA4LgZKZXB/1f4bLw3p6eotTXmr5VEi2VlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(54906003)(66476007)(66556008)(8676002)(66946007)(86362001)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnpupBtq3Ln4ypwUlM82GnqurbR+kSAT010WsOb2T/PVuOjQBsJcJDF9YMlw?=
 =?us-ascii?Q?WJKcXh3Bv0nMvoouu44hsRB0Q7Pax+k+CzC18MJTCt1CCJ4dVou7m+m6lWgM?=
 =?us-ascii?Q?I6n4t2+S2p1bXXXB6PZeK2SIO2WUXya3cdHX1OkDNVgQX3LjadSe8/z57Y1+?=
 =?us-ascii?Q?IQByedDRaU2bRhPh9UnoMtIq9HIdgu++jqOmpqGfwyylFmYCk07k7BPyQWVB?=
 =?us-ascii?Q?LWQsnOc0mkj9dsGo9OYOOstC+aJ29dbkN8WKUdakUgaS5Qk+qgfLyobKcWg8?=
 =?us-ascii?Q?mpkEryVprb8ubZ/O1abK79HeiDXzcLcdcYmJeC+KDUbxn9LruWbx1ds/2R7g?=
 =?us-ascii?Q?tQNwyZORiknCg/l7KTf49Pi1dSylLLwh1ckHnVmaLyPvRxc+wN3P3Ir/T0b3?=
 =?us-ascii?Q?WRxUnalog/ZcBXQIqesX34/UTUqX0tVziyQHd9sfMsxsSk82jj/mYjbF9Mkr?=
 =?us-ascii?Q?EagDoHYD5XoR15P3Waxq3jr9IDhsYQtM1SbPJuXZ3Id6hyvqGGNj/a46O7Mt?=
 =?us-ascii?Q?5eRkzZW1Yu2txP+KviDoz2xUUN8Xc34SvFHAFmtUvy4mJaudtZvAyO3RbZDo?=
 =?us-ascii?Q?oyob7JeQalN/60Xdf4s6lGSDrPhumiyA6/jNd9DhRQfhBwCdgDz0i2gJAmCW?=
 =?us-ascii?Q?fYikUPbCZCYPnnFJkueHe9qFJWw/kww5LcHBTxmVEhcA6vdPsgt+ppMXFrES?=
 =?us-ascii?Q?fSo8ejr4VFlZkjNCk6kCaOTrR6KzMYXegcAcR+g45aODpQgOWf98JgTDaBF7?=
 =?us-ascii?Q?lsSgQa4kKuXTOQCz7ofEh+fs0hIFM8NSbSMin/h6/rh6lJvSw7tzCZBFOdlM?=
 =?us-ascii?Q?kOr7SkK3DFJFxRpOi1Wmt3+/1/w1BbegTts2rJmDNNYXNMej/l/pRZEp4Cnu?=
 =?us-ascii?Q?d+yp+wl1+vdwVU/YZXOGQPByQF6eOsHwuTV/NKQv6fZoVLWC7Y5Ms9r12Lm9?=
 =?us-ascii?Q?IDoVtko/G7ObBw0MLNndfpVV9vrQJ8dvyYadsxSngypNEkQR792pH9/eaDbZ?=
 =?us-ascii?Q?pCtRyd8v7arvZdM06A7WX/OJa4WMjZ/n5sZLP1rT7QNVX8Ia8v0TofOV4t+O?=
 =?us-ascii?Q?a/gOjTSgK7ao8Qmov7jogBeL8igoGo1bJpG7dVUlrKQcqr6EfwblI2wDO2wk?=
 =?us-ascii?Q?s/DRv6DkOUTjztw1EeTooqrOGPL5Z90UJQgD5oaob6RNWYVCU7kA6wBQmoDW?=
 =?us-ascii?Q?kL+1jsC69gd2fGKXfgdJ613iRDYm46H/UJ8ZdzZ09AuvBIx6zOqz8jJtYwSN?=
 =?us-ascii?Q?ywK6A/I0NIndVWGSLh5UljLdSW8OokWqQBrgWZjDAzo2d51Zr36dhz7z0GAv?=
 =?us-ascii?Q?8SteSAPzTo/mvawY9mc3piBJ65x3Jxi5VFX0JyALzf0rPX8vRJK1jMHSZ+Yy?=
 =?us-ascii?Q?INqVqCPoJTflgOSKTQcm3S4AIaPLOGIQ13MNn1LKhN38kvMFsUUq9uFDK4qW?=
 =?us-ascii?Q?HBYi/wHk4LZTRvnJcWuuZyDmGY3f99KHnO6FMOr6O2209D7U3E1I9sHz11Iw?=
 =?us-ascii?Q?uXpHX0JvXdX2xuUjdINhI23arj2fUVT2K9tvNORbUh5Pyxp1jwd78o4obSQS?=
 =?us-ascii?Q?GA0qsQbJvAcvUXYcGNV8UwTatSwW6Sqvy+a6csGO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74540085-b25e-4f61-ef2d-08dab31ab1e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:06.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3riru+I9u7w+8BH/pkoAP2ir9QQn76EZiIlUb3IaV9WR1kCXsg/b834XLmZ1/BrPQCHQeGWY/NY//uNNdfI3pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QXP compatible

Add a new property fsl,resource-id for SoC which supports SCFW.
This property is used to check whether remote process is under control
of Linux or not.

Add fsl,entry-address to specify the entry address which used by SCFW
to kick M4.

To i.MX8QM/QXP, when M4 is in the same hardware partition with Cortex-A
cores, need power up M4 through SCFW, then M4 could start. So introduce
power-domains property

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 3a1f59ad79e2..70322e57b6ff 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mn-cm7
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
+      - fsl,imx8qxp-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
@@ -54,12 +55,26 @@ properties:
     minItems: 1
     maxItems: 32
 
+  power-domains:
+    maxItems: 8
+
   fsl,auto-boot:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
       Indicate whether need to load the default firmware and start the remote
       processor automatically.
 
+  fsl,entry-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specify CPU entry address for SCU enabled processor.
+
+  fsl,resource-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property is to specify the resource id of the remote processor in SoC
+      which supports SCFW
+
 required:
   - compatible
 
-- 
2.37.1

