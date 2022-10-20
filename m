Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F5D605C06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJTKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJTKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:16:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8417FD5A;
        Thu, 20 Oct 2022 03:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5G+EGIG7iUzLNnbamN52SP6UrjhfxaOw54o769z9SZpoFJNVTSC/niHgKgYmT4sV5jAuMuiWu9u2cygYy/wM9Vjc11NenDOLSOzhwts7bmGVNVTb9iiPfX6e491PwETqHW7D/AaRPj+px97mYqw+lGx7XG5BEAU37gO3vr/m/3wBuw1arCLmMiqy599nYqWyv6k9P/BFviXqudfFFNnLPwuON8jRdFN9eYn0s918HGssovuJNdOV3n3TVPqbREZSMigkj+AEbP5DhpsGh69KQSLPMEo5ImYtMoQWklYni7QcRRJSy6pTxWiLMg3qldq7FfTkp/qmypzwyOq8315xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmczja8pOSjVUgbmOLGtKhwRJ+caLVFqy17jysgvAbw=;
 b=c3F7+xlSPWVco+3lT7ZtJnM0u3DqibMpipbKxVQqQLnsnnKvhTPCuEueP0HxwDmi3dfhAVSheOYThPK1HM46EUmvUDtoNHIu1bOI2/vnz2KPkpxKQkOlbXiW16Dba50s1AJP/ilA3dYIHNbD6oRSkOScaSOMUUV/FdBdnZeMXvuiQ52jxBPCgoe/Fa5EZdl56WCicZLK00d4V+7DH1ujLPH93OJ/cuHNVIwRTz4VQj9SFhVrjgPfVIULz+9rNrVNRe9ghDTbuGbkb4Kg8ISoYiAYH95QlUAggNHhcvab1IDTb6kCpvNDVT/TLOa0Yw6PvHdRGjq9rpx3GOwFdIevwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmczja8pOSjVUgbmOLGtKhwRJ+caLVFqy17jysgvAbw=;
 b=EWjBpGIOCYBltNvF7ldSNoJRor9YZ6snSNduu7192FQSG6/or7UBZmKcCXq0TJTBuKXkxCMQ1rsz8dlnzkLju6+5poQzY/5cRsQDafrEr1o/wZD4tEqQKzsu7rloGJB3POqhiDF32hqpCDLX3CByhSROPgCRDrPMeokqt/tRNuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 10:16:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:16:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/7] arm64: dts: imx93: add gpio alises
Date:   Thu, 20 Oct 2022 18:17:00 +0800
Message-Id: <20221020101702.1867188-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: c650c202-1079-4ab1-fc0a-08dab2841623
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyZaDG4I4dhfxUZ7cKXkpFKSEuAWUDnDJSue5wuZ0+qjwbcKne3WWZKIFRG+eoRf5bc5xs1br9zPoETBk376PJISGUQdiwiiGi43aDJHQqTYS5Nvz2sJSVMyJpe/ZAJpTDLzAI3brHYZg4K7ZPUEAWh1mWB3zfB9KhfNCMgtYNdb73hyd0tyYzDES2uzwoSmgmBNZtlc7DnFKvf1gZz7ybpA8YtDus++hVEwAuqnnboLg04lwojeUIIkI43sNGH1iAbJucxPU0bw4O98+TXNOBVLnDcwv72xOlG8YFuWDWUPavpu49qRjaxZUykJI0cZmlS/ZF8YMHTMSF/ABO9OYrkmc+b0jbTIB6hZJa2lMiIdEp9MsQ2m6VHHb9VH/3SH/pe3Z5fhAuC0I/M3/9naC2eZqmVmoPxFoLqp3sTcVCAMQtNBaIoAGtkwHbKyk9wBVwmihXWs3vxkTEpTYFEEgIsQFI96vAg9PxcsaKdG0htlmq9J59ge65BBf5Uq6G464reX0j7tdGkb7MGXDMVZRwiAnW/+OLQb4VPN2Iexqg4z6Kt4MRAod0N2S+U7FgicX+pWqQci2gW3P5FfW6b2HC1ZE7oNo0tcj7AMYIdME19IoP23EqCTSgSdBSMHxLT87cMD89o+bMQKDHfMLEbuMsWgefIIElnd/A4b/+KzExYtei1raS2YvlQB6IfEiiOyanZoL+84hpdO/sYd9kgiqcMvLQIVzcdjq5t8MeKi5cfpNq+cpxLAMchuD4LVo0cE6HlU4opIXOH1Qo+C8d0xLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(2616005)(186003)(26005)(86362001)(38350700002)(54906003)(38100700002)(5660300002)(1076003)(4744005)(4326008)(66556008)(8936002)(41300700001)(316002)(52116002)(6506007)(6512007)(478600001)(6486002)(66946007)(66476007)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P08T9F8FmA1tUBg+VdIdqrtan6VD61Lz8iOHsIEP+Yx927Uecj93RnFvEY5I?=
 =?us-ascii?Q?JsgkP6Rt1zq/C3+xRt3ALfTb0EYdPWz3sPLPkqyOlE9L5wWfZELZj4FFYzb8?=
 =?us-ascii?Q?in6FNS9f9BgZ5ICDD+VZ9V3OcaITxr8FuOgfhXQqSp5eLGs5nx2R9BsraxnB?=
 =?us-ascii?Q?BIVO/owOk8+M9hocVwQk8DT7ZIqszdm9p21pqxgGUdAyp7d8j25LU3PUm1QS?=
 =?us-ascii?Q?LhL+Vr0w2nvgiQtSG930hgSHjB+MDhrOajgP7WSNHEEtUIELcxEb7+Iy3jCU?=
 =?us-ascii?Q?zqQz8Vqw4xCOm9H27Xb81GESJLZ6K86rmBUq4zuA1ww+3stFx0Ex4u/nAQtq?=
 =?us-ascii?Q?nHbyH7kTdzXKdbpRpqqVJ9HHUTbL+lDR+VFNW4JgcWGUOx/0FkTXq3RGvrQS?=
 =?us-ascii?Q?9jE5xvEOcKbcvp0lj7G2+dlRk7sd5f7ckNBkd1/3/SwIMJ9IM10vmq18Xy3E?=
 =?us-ascii?Q?VcKPXKPieCiMw8BN57xB5WtLN9tv3SDYMVrraU1kj+idWyG7uGAjylNtrPE4?=
 =?us-ascii?Q?TLzhXRq+0EHoongbMtntl4aYPLvcyuQyQEItdwB82kiFrcBZtLLG5yTJlrlw?=
 =?us-ascii?Q?HjTyStGCpIBHKX1dSA5BOzlfpTk5eYreVvL8EA5ooxVnyRzcWw3TSTCLNmvB?=
 =?us-ascii?Q?Gts+c3gIK89OAmyHpIr7C6ptjEP/RyiSNPMx4unqCvg7gTx+HnzKhVqsZUoZ?=
 =?us-ascii?Q?NAniN8HAdw8QYMz+TdCsOn7VBmvr4vMMXWm5PGxpoUPBRiJJj5PLvVRi7w0h?=
 =?us-ascii?Q?DRS7VFyY+NVGYadni2+pFSo6QZDxbcN0IplRWgeJxs2xH9Mr4hdLGyUBQY76?=
 =?us-ascii?Q?/Dtj6FeV/tca0D3NaLOc7mVQ+6L70dZi0lUF886uYXy8HIqsQcTHrJfOzISb?=
 =?us-ascii?Q?9RRM1b94SSzQQoSdS/xnqDcl3UwynKAVHNBMP+y0N1caPlHGJvWBRw7YDa3Y?=
 =?us-ascii?Q?kw6z6KU2wmj4CJ8KqdwJjzxEM5DgFoZCLHnJxs7VPjigNbpMyfwHaZcRApyy?=
 =?us-ascii?Q?hvTm+urps/W2UH11/NvetpMKEI1889KV1TFbwVqwcJyiZQog5pPwgc7h9nxG?=
 =?us-ascii?Q?pAsQCv+tD5F4ky8HCymkEMeeF86Z/YoEgXnT/sTLrPkp5YpZqPxPxjwvFyhN?=
 =?us-ascii?Q?rnVK+qiWiPI1N1YnyARiEWr4AL+kw5GbqPozGCC3eAgam5vdjc6iGogEp7eW?=
 =?us-ascii?Q?7JSF33b5TCypVX8K61dYL60XTs4xfcJ3iGSCHVUU5Bdw0R+x4UObe7LBe7QG?=
 =?us-ascii?Q?3XmrbBQNV4mEhpVeoDTtX4L/o3h/5JdhTxmY6YgGDGZwz5dn7Va4addUfgvi?=
 =?us-ascii?Q?dORWkxhDauNvKF6sE/ya0ueRW7TwuywhdYuhF7N3JetMNpZDSmtIMCh2NAYd?=
 =?us-ascii?Q?EithIT57weWtU6CD4UL59GRArBO45/hV3Sf7ASui8yf0V6+fKmO+Xqo91Lio?=
 =?us-ascii?Q?2CcqzN3atTqxiIl4fayKHx0GWQaGSsuRO0/ryqPigHDcdIyVpPszlYQj7TyZ?=
 =?us-ascii?Q?7mF88E44wI76gIfv+V+Dai2M30rrFsT35zWJW+sJRwI7JC9gIvuYM6qGqsU9?=
 =?us-ascii?Q?yFQuVUyWPwkW8Z2wEtRcXpvaZBjeshQTS8zQn0r5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c650c202-1079-4ab1-fc0a-08dab2841623
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:16:00.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUoQyYLdfYulSKLdrKUQh1vrv0RrK5we/vvVTZEEImNZznfDYYtuEK4qYU/V2RwSCKZnVOtLXFyLuthtRAd7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

gpio driver need these gpio alises to config the gpio base.

Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index c886ad0f6499..092a6bdd0fea 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -17,6 +17,10 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
 		i2c0 = &lpi2c1;
 		i2c1 = &lpi2c2;
 		i2c2 = &lpi2c3;
-- 
2.37.1

