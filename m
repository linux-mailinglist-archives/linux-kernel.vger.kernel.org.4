Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541DF5EEDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiI2GP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiI2GPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:15:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760C128A38;
        Wed, 28 Sep 2022 23:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUpa2nyukiKleDJo8bQ8HTNpoxtywxvCB8ezW89eJAanQ8Q0WqnYfPaRu9T0/9rv/M99CVoVzMYyi0aCg9kgRAXfKqm3ii2lP8T/y4cctGRV+xSdp7wdqRHV2VT3RUCNsS61ZltLBfH5vWjr5jcCLmX0YyBnHVB4rq2aD6RCAV6sKK00aoX0116B0p/C+gs2iFkWxCuvpV4jljpu0IAkUpwstxSMVEgpCIU6QHzA6RXIiJDWe/66NrnDcD1emYQSJbWIQW3QrADSraTLtqmXPYD7qfqAa+hlTOPnG1PzyP5tYXNHfIJOfFPs7VA2ba39phAQIo4APw+deMAUQOuseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=NGvtZqG8LNAO5+dC2Z8xz4GK+QTrEC5LmwDHcYftNbiUxzSIuMSHiqB2CHgdkuEQLNiHYOpI7QD3+J+0xAriwC0+AUnJbLjZBax0wooKQyVbwFfmI6nExda5QhZtbUv6gX0RbT/d2BYLCOjTuzs27g3NNGUoQ4G9qjVTTDhE3RClD5If67KsEb4cjurUT2p3N8nKCHHAINuSKSPEgaE0pkic01khaCtrdokBQEydpKp+cYjm/I6/jduTKM25K1oVtTO0xHgtiBAB0Yf7eXDcsZnlWEEKtLA8SrV48vULlTHERsPBUXJ76jNn4+Ac9nbwi5bGYwfUpcTLF9Evk7WSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05Sxwp2qiuQnWOyN46jehy6hs5jPcBhHTOijKpW514o=;
 b=icH6CYdRix+3TjrN4scjI2FWj4E6wIEjMtg5TqpTbw9edY74j9Hu5RVTYjwCsCEpEaLqNaWcLanUnSDkv7veOC9vN2Gw3rEGfScbTFMbsAf8VSwhzR+xMytCTJhlw+m6IyLoGHAsiaAMvsQ9/sZfKPoXdaIagI/7+qErVukDjtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 06:15:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 1/7] dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
Date:   Thu, 29 Sep 2022 14:16:58 +0800
Message-Id: <20220929061704.1571746-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbaf077-77a3-4bbc-335d-08daa1e208bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfNBNHYwNl5/WkpDASe7hON0eb8TnY2+Y2QfvNnRhUb0rAO4qD4zuaDI8AVCj3QvtV/JuNn96ukL+UA82m6T4U/cdcb9E/Y+fe9xle5dLsGSKLTxP1uxHGMgdl5Vi0Hfl2GTyOvNA64xW8vouOhgIX0z9Hf6+d4AbgrEXcjiXa0ZB5q7ePW7yM+TTT/jSNsRxsd0vKHEoBWdQBJ4MnB0YbF94k4/PpyEjUPhWTBgVuNbp879TIDqlJWN4wloxrZTtI6iN0+au3xl7kS46Yk4CnpCeS7jJPh0iOsHuxv/qQrLIfSMSHHb5pSfUQrCjfezbKCkf22rkHexcO19AMZQ4No5tOyPnjelIDuZrfTztxy7mZbTPT69qz//Wdjj2DXW0QEcXfe4S4Nk09MBQV1s/RUBisO26VS48H5ptpZozymAHf6uml/+XPDtfDILcdmeXA9PfZCg0r7fE/82XzVnGv9VR7BWR4ZkfW/YKPvwc0INcP5ltv6Bi6DGYeFauwyOdAubE3a77PaKXt6gDy8HPSsv7ue59G/zSJwB3mog6spygBg0glI4/3Ghx262SOmEUXVC5QMSretRQGR2l8CfGV5UEo3iRf646yPMgihWbquiL2Py0G15ef0U+lwtkGratmxEExnHJWoTHAxUdlihNL5jvq+ZqS35s3dv83sJh7n/MCwzqdFMALedU2k0C+1QFuRAPnCostHKhw9cjrCDm1umP56wByIEwnWjeK/lqAJQpu9sVIcwCY0ZIDNK9cMAoJKs8bObOlw7Qq3jtahRvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4326008)(316002)(86362001)(38350700002)(38100700002)(8676002)(66556008)(66476007)(66946007)(54906003)(1076003)(478600001)(6486002)(41300700001)(2906002)(5660300002)(7416002)(6666004)(8936002)(186003)(2616005)(52116002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ylTUGOIjILr+ya1F6TZXUvPoyTycRSf2e8bmW57yfKTH2DC2YQCP7q7+LALC?=
 =?us-ascii?Q?BGImuCmCjACLRFA2msRozh/0yjUXFconAaAu7DqtRe8QtQ2Lzu68fiqj81Qg?=
 =?us-ascii?Q?a7UXOtgy+fT2DK5I4D4GM01AISq3Bz24NuwrVd8C/ROsCfz+3jl0CsUb5eGB?=
 =?us-ascii?Q?/lu8t4gq4S8zWZTEHMZWm5ZCkDjlxEYXb5Rz9Zppqvy/Ew0XT5EWqyZEGu/I?=
 =?us-ascii?Q?UpGG7RAacMMSR/lzBb8Rr8Z3dzgoG5Uc/UPbPemhxz2uGcltgV8SFJ++DLwf?=
 =?us-ascii?Q?Jax9mreiwF7VL1Dc02qjCOE3rm7R7Ncem7aCpH5zjFNiUV0CKGlyl/AMSPRr?=
 =?us-ascii?Q?zZSrdZ7BebzUOpgTiZ5bnAzYUgu7L6V1bhVbUzHlZNR+AnKG42Y4PBxk2lLG?=
 =?us-ascii?Q?7eWsNvxXL7DfMB9E1/f7z8Zq0PUpJLUu69zhiEqps+C7TAJLnTa74Qj26+Gf?=
 =?us-ascii?Q?XsvdQOdfibFfDPve2Dgjavr0//OaMr5yQ8ErlZ1twcU0y285JRk18mwu3+bi?=
 =?us-ascii?Q?I7pMM+ltub4ote4e4rbneedOiCnVYzLoyLcfc/JUzxsfX2Ill4Wmjgea2IBJ?=
 =?us-ascii?Q?KSwbp1Mf9aaW2uIIpjHMDFZ/6vRxuYbGbuxuihD1qS8p5Qm8LxUyXxG4Ba3w?=
 =?us-ascii?Q?jMKMhLHGHtnu1Z5VnOpU3Fozpg/+7YlsYi46v8wFq1U2TNHzxxwW/2o8xZdq?=
 =?us-ascii?Q?EdIjmob3GUCg2nOymBkOJwANNjsiIpy4Xjin5i4/EMyrjNqAUorEmuEkzFh5?=
 =?us-ascii?Q?3d14Kvyv4bnCxADO22dkaN2xuvKmGyORQ5nOFYdVV4HG2PBsRqcOPndiL62s?=
 =?us-ascii?Q?RljQrEdJb2v3LNzmUwSCQVJk+zrb66rodOG55Af0rKvg67W7ikrgIetS1Sea?=
 =?us-ascii?Q?7e0hnS1IomigyTc2J0ARnP9WtoDrmWw8qJxXtpE83QhPg2ljzkAemfekuwO4?=
 =?us-ascii?Q?JKMd58KXEB4GbBTqA56ZvEaveN2tvO3zhl/TnE6RtLhtVS+CPp/RbzRFfjzF?=
 =?us-ascii?Q?rBVRsilxZcl0N54meAJfKsQ+oxHVd1e7/+OSy+zF7Hnb8K+C3pyu5mVIC3jc?=
 =?us-ascii?Q?JY7Xe/2bmaUXaz5GdhzT/aCPXFbhQVRcRsBhN8AytvNvkihQ+cS1+XW6N0Iz?=
 =?us-ascii?Q?+TR0377/Zg+RZPxu5CDimkX5gjTvfxcCQrdMEfXdABVxF/djVKBDawHTHbAB?=
 =?us-ascii?Q?0Hn8f3VQRzfuwjZ0QvlJANmbDA/39l9nHmXgGADCuIAnOZqyOXY7n+ySDzI7?=
 =?us-ascii?Q?5VBYZrynod5xHtkE2p+sbloampMYmrOAPaPbWnrdIXVBO1j3S6YgCDrx9d2u?=
 =?us-ascii?Q?r7d0PGz6wxs2lTAYc9xhE5WvCe6/Sugh8U3W1qFPBYanC1b45eAMN/Ba3bT1?=
 =?us-ascii?Q?J8B6ZVpXc7GEPMBgjbrrWZ4wKfP+6P6A8ZtD8gM0ozcjF3kRWjotTO9xBcLA?=
 =?us-ascii?Q?0l2jOrV1psGKZ+MRsGkBDP9wEeyOpQME6I9FjGS14VJJoNQ9Is+6X+AbBOKi?=
 =?us-ascii?Q?VMrJOdQzUVljZqXmIYpBK+fK4vDZzG6MV5ZeezOC/Tt/w0N5hS/qKh4nul0k?=
 =?us-ascii?Q?SKfBIrUu8oeoRwj2fPM85SK0qZdLL5fyLz2fOTMQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbaf077-77a3-4bbc-335d-08daa1e208bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:40.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsOcvxYLghc6KdMxaGgGS+tUf2uB/qxONUjVngLRnlC3TUbMI8IFJ6tDg42ujc2sbcm3IA+vPXoF75a6j7TmrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
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

