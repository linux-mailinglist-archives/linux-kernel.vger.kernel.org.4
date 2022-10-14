Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91DA5FE75D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJNDKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJNDJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:09:59 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F39E17652E;
        Thu, 13 Oct 2022 20:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT3YM/ax1P6IOJu+DXJcs0nNA7OE968raUg5qWhwZIbqGy0LcTUtj1JlHJt59HHsrMdkfpFaoBl+wLmXE7JKUYJuVtKdVwsNoTtt8gwBf0E36CiFKEzj2BpnyZkFBIfI3ft/AvO8JoHXpUOP9TOFtEwptzJvy3VCqPspDaKtAaWS0eA4atMW60OwT6AqeMC2Zw/AJ6unOs0Fy3l+U6nVV16m0aHswdHSJELbHiVQ4ze8Ik52oYYQUf9ZPZRy+lA6fRmZ+f6+uX6uuENm2jpnNNBlyTIjPME+9YBFJqrfuUAJu391A2lpuw3uYaz5yA7AnU0BvyiPUROQrBYE8VpL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=hy9RusiQBl/Vj+NuOCyfynm8igJ1LUNsCfqhql7FHti7BobikgC28dnKvS2YDxPzKTNo8Ifu+3u5K5SpF23xt/QMIHhos6jUoD4zWv3EbFW4hMYWLMj4RpJuuOJb9QnfOHfJ5yt7RATp7DDR+3eBNivD5E0SGrJBofikT4sQmhmGRsVLs6VKFGV3NPHIiOMLAUzv5CmyTOXPyr/dCyEah2wYAX20zvBMqL36FnTp9cTHq4tLdnTHjPh0nL8zdjqNB3g9pf3FcgIaMlkyugHvsGA1ctvncLEH/JL3/7p/kO9NbGHHZYa/XZGOdpn7H8sAxBT06ZWCKUQMXhPIKhEHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=EtCGvftib2VO5t1niZ7XzHWFqiw3CVKvJ6AvP4ciplUtHIxOS6s+2YvCGMgljheMgYL68ZUnZSZNcnofz5/HoULTxLvEeZptJFIiqpmY2s7fxsOtVKThgUzrSmsiCPkSgvwAlZNYTagLwdYkqlxFcJN0o4fmh7EQcHrfp/UeY9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 1/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Fri, 14 Oct 2022 11:10:31 +0800
Message-Id: <20221014031037.1070424-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a02e14f-f6cf-4d36-d640-08daad91789c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzzwRkajCQDoggUYSEzSYSp9an5e5XiM4WAA2v22ZIZJ/WUWLE2vrxIYlL2hca3VyI0iuH0Em+PzuSwSJCLbUVtsa3sqrsTWCOOrisPdibRh3amSvSHh0fFWQnFcRzfq2ekrhMTlN78fdgg7VA8TFCfvCr03LcAuZ4yEEttXjaLRCs1aAVhRaox+4C88D3kZV5iD8LhcCd6WZ0znWEFzgDXYq5kAwqsCGbH2HafiCtG248VjPS6HnA1e1Hyfno1b08bwqOkUTfVDNAFSqpERjop8K/hat2FPDuvIpCnSAo3RmnsqNGRO1gQ6tZYa6OlHf366In3spyRM73kY0tj3pljjKt/HsyY2U1vFsCJFGXqmW6QPRh2LRxS4ZJa6CrE8+2majeSdfsXgRnDtm6Z64Jef13gvr3gzeub1vHpFD4tR7kkvNWsbdDXVWurZq7Pe9++0RLmGKGodEX94GQklITHiSNxHrHH11RN6yLg+P14X7FkEJA479YKHa6ey6qZCzJwQPsrcaEqKHioomXaT9PV94xN+vEmBwNyGBuI9iwcOBE9vMa2xQwu0HXpfa6OxnKtPExyNcNyIT82CyYSGrb0qoMrJoDEuu3PU9S9stgLEGCeOdm/OBqCxsofCMkRMDP9NTa2c3/eVpL/Jw/ZPNCc24WatV6XJIn4VlZHI8hDHUZ334mhfXcSrbeuxD7+xiU0XjL2lN1DpA57UKyb9pHsK4CUoc2YOkmbFscBka9WFSnY2vYsQMS2lj9H44ureUuXziTIlpEcCsSEDaDYjKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(54906003)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uc+8Zdy35yK6XIhtSe6HsAkZBmmFFZPdSwdx8CMaOlHJPbwNCNUQXwy4qCle?=
 =?us-ascii?Q?6xozV5k8mY9lG83mdrONA7+jHi0LOB/JaCsEkA7SX18yUeL4Dzao3q3NSH3A?=
 =?us-ascii?Q?N9/7z92Xe/EH8r0qBoblcpRg3bQCjHHOTlDqt8nc56XawdNgzNmDyd7X0gXp?=
 =?us-ascii?Q?OD/FAUWNMdfI1KJmgxgTyNkCKJbKO4v80IjaTPpW+Dm9Jwg8P82VaBEtsMWK?=
 =?us-ascii?Q?pdtNFMIrDMoY6ZLYC1cl/KOv525vuSwQFLbOKHuvF2vXtRY4x2hdiO4lzHuf?=
 =?us-ascii?Q?4tJAlfJzjIGWgW+lXNBbop6rd8Qg6LIi1e6sJVCkHtW6kbvKcM3bLR9KGgen?=
 =?us-ascii?Q?4iwsGKYe71zgWHelBFyNf7EH5Amfu2eLsBDD9VK/Bpj0ImWiqV9ir3EUsGbk?=
 =?us-ascii?Q?2+ayZQq9C//3ZtdYNkDnVlCsHpB6/lhOwvEgCIg7+4AHNg8ajonArGBhac9Q?=
 =?us-ascii?Q?UIhNlwAGYKEUUnY26tu3sQmEhW9LWih0CAmvoL9Na/QD///6ejh9MJGz9Puk?=
 =?us-ascii?Q?FDa1ddNgiQ6mTI2nHfaK8XrHhC4gUWut0+NIZ+jEfyfhg7eSZedDrMWTTt04?=
 =?us-ascii?Q?34XLvvSkMmMtIx5uZC3OOjxoTce4gzbteixFR5bUDwnueOEjBXq5MZ/ovVzM?=
 =?us-ascii?Q?rUuBPYJV+Odzob9OP+vTzuxcqaD5VbvphMGpesyyzOSSiyeB1dlkLIq62/hn?=
 =?us-ascii?Q?AbZsjKZlwuiwcilNyOCi3XY6grwaCZJ1HqmtFlZs6BclXkofBOQUh19DAePd?=
 =?us-ascii?Q?4ckV338Zjr3WiA1caVULzQTd9gULF+00EQGi9aose78Pj4Z+RwgUUWOmvWrW?=
 =?us-ascii?Q?fQIjL22ZygleDuTK8ZKh/ZerL5G9z3dPYZt+UXYqlEdeeHVmowTJhTqsnSQQ?=
 =?us-ascii?Q?nidCRrcXJi9b1wzeyAuSRCjuDtXJYMDN5R9lxdDaXJY8MeTHcmUS5303kIgP?=
 =?us-ascii?Q?opAO0k2sKhKY77rGxJBPWBd7EBEWqwSeCsxebx/X7+pee8melg1ZprqMDarE?=
 =?us-ascii?Q?deSTxcayn4kotwU1kwSxEJg4QrB+R+/gPdkntbFi0KN7KU8+6rA+zNXAZRdu?=
 =?us-ascii?Q?L9g3xD4jozyBcFAfluKTF46Uw/xAnMVIHaE9vNyxYRbEo9frHDKKPWZk9XKG?=
 =?us-ascii?Q?Gi8MWhZXzRCprPc34t5HzICjrV5LhefLKyP0OdieUJEQ+f5QWgURqs8wH5md?=
 =?us-ascii?Q?39JTJ8MU0miXFgQM7i71p7ijYmwi89UCpG7Y4/5cxV+5JVwZ0j/8cFhe4ei0?=
 =?us-ascii?Q?dJbD6l8kcbU31Q/pgmm++zn0DNj5J/S+F+p7jFgPC9cwSgzn2YXJ6vDtsJKA?=
 =?us-ascii?Q?fiYIce/BcuXczlFvo9h2Qe/Us8/T0iyQTEZaAIwnHEUW25xRxoQGJB/9rZJU?=
 =?us-ascii?Q?ivOTRarsRFfDP0XTOq9CYxH98qOTArcURe/IZvlJuoFN4zQeN0u+CjyI40lf?=
 =?us-ascii?Q?x2R2aViC13NX+NOGoVxMhsxZWa1+TSmPik8TjN9CsEVIZyfY1C35bj4UKDrl?=
 =?us-ascii?Q?zAukpV587bpYgeL55C5CkZQ2E0w7ZJ7Kh2xM4S3ez31qXMXvE1MnusRioJQX?=
 =?us-ascii?Q?aPzo8mCUhKa8DcLQLAXdSEpzdbMauukpVzXnnO56?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02e14f-f6cf-4d36-d640-08daad91789c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:13.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaZ6ILUWcSi0nB7xWONFAB0WPO9CRfdl4Jbnjod1OTjfGzoJVrFWgASO2grKR8eZTOUCwbLDQdmrbF1dEqs73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
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

