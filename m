Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B9605B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJTJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJTJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F91CD680;
        Thu, 20 Oct 2022 02:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDqXcZSDS4XOjK4M6JtRJnASoeiqjMMY9YJ6QFvP337RsVoHd83+IyOpWkaxLFma7EVkSIk20eXbhvEikCyiUWWj76sXMMqbXCFrTcmPbZ/faa2NWaKhnm40tbBh8tSxTHBPWx94ImX9e6A1OFh2qap53T0LY9wjt/VDJXKwFDNtSaom9gz8WQ0vIrvGE/of4LctW9T0f6u/99AXrxW4PuvgMbVOeig0VCjOpm/ieOgiPzQLpn83vMvZ60ftOmhTFKZfSVVmVl8gy8S22/Z8/4Idnv09URD/q8WUAXdVjQvEC3DS+kebIkbC1uPxInaIy0pUML+e0HeffufR6Vrzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaKk9v9NHxiGNHXzfunETX2khyjIAOtRmRfe5+2fd8c=;
 b=XH+nDtv0lRoHY7lD5mheLBUdoJiQGdRj1TLfVYBky0MNE64OCjrWCuW1HvE/2mmdu9RHh637WmIY8cdmloFK/biCWvkul7eesya8rrHWq3qve5GmAg5JKz31g+H6K2iUeSVITp3BAZNddXUumhddUUG6BDbRMRcNK3baZx+gBd9RMVPtC9eW8OtwY+VJwnMG/k6W7WxuE/ujVogOYGq/i8Zbe3MwcgHo5vgQjWfqifGLa5/vaK7wtU2A9lfs9zudHsfK5sZC+Hx+5PAuOklkzuQBLfNzo3GsWQNcbt/8/EYRxJXXl/0Zp1gO5TOTNO5Sqg1gwExe2HQhb2gNoSnPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaKk9v9NHxiGNHXzfunETX2khyjIAOtRmRfe5+2fd8c=;
 b=bhq96rEwRAu12YDiKw81TO7IzXWUT36euoxab2GrHzi0fOOK/B2e1ai85LnB0L7I56yACoR5/pTWMgMbSyfdr2HAgnySN3EMsUUTBVsc476JsIshfYOtDWLTb2g4am13ojfeULH6YtSkwx7f21bwRnPKU359YkOOUHmD4RRxfEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9320.eurprd04.prod.outlook.com (2603:10a6:102:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 01/15] arm64: dts: imx8mp: add mlmix power domain
Date:   Thu, 20 Oct 2022 17:59:20 +0800
Message-Id: <20221020095934.1659449-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e01236-3e5e-46c5-ba91-08dab2819d51
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maKdvDbVULsgM2pDQQie3/RmbxEY425OlCnjFq3ikqJEYjpQN87K/9r0FnqjhuIKOMGGm0b3niP2bKu8bLLqW5Bqo8yEHTa3m5221XcBD/oM/OBEX4+IxRcNqGLtzNvbPqTsdxMzdcUsfGQUcv5Dr8nGgNjxrpCFwTE4YphV3yCzBENRV0eUdLFujNBBUM7cSIMrqrUZaPI9mYj8niwDpbId9uKXGJWtaG4N00/4CNxmYTaRLYV8B2CgYn9H5G1ds4UCWqIjDOpA1QWXudcwF3bA8F2eIqucOk7/FWHRbpOnuRJeWnfQt8uhpdjwRK9o6wZBww6E6A+5YciD9gKvzSftrmVTiC6ASrgQX6L+j99WzuoaBbQnEuslvhLimPoHSfE1YThDHI56RMlGHjaB/u6bDp3hj7soyyVg6Ueore2ywPhzCSahZvOKFoYXsMr3YvGQwErHXf3YTd/2is15/MtpHWIgS3we8MSqU8JGvHqCH3B16IsVB8G1iuUMRmaqGgJU1IDI43WCzZm3eTIy+CiQZmR/B3T1JtFxmqdMCnrgcsLcRa20wYMgpgqXi/jiOjB7hEFAQxd0nL1+gITOb53ZUS6pq9XHzMsdjzgbSuiECwDn6TmIh5ECh8pQlzdjh9Q2djhqbwVRuSJsz6dNsSmWdhTdTyisVWrsF8ybhvDepaojdVvAUVPl6QMw9eQRb3/+WFwhpptQXncBXjgljPiPZ5IE6gXlwJ5Zu6/4w7/RjOpAW90vhRPSD8SJdBOTAWSytHJ1RHDaonS3BAmpRVb5IFFALqOPaBCDOSBydwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(186003)(52116002)(38100700002)(1076003)(478600001)(38350700002)(4744005)(2616005)(6486002)(66946007)(66556008)(6666004)(8676002)(83380400001)(6512007)(86362001)(5660300002)(8936002)(66476007)(4326008)(41300700001)(26005)(2906002)(6506007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ddNdBktBrHmoEGewMZ1goT7r2le5XFTi/m27H3iCKz6IyaJY9NQXtX9qr0gX?=
 =?us-ascii?Q?SFVsW3L7d7ZUsmwVqRVSCUG3/RaetyE8rlGm20gjH+3pU1C/n1+OWIoSIz+7?=
 =?us-ascii?Q?9V4f9cBHy3BL983KYDeGd7Zsm8Us5pOPf8WSoWEMQj57z+zpKhiDQA0/wJFO?=
 =?us-ascii?Q?V8ZhBkQiuUe9/7iR0YT3G1m7kwjKmnldmjhMAitz8Yes1agD5EmRtvCveB+H?=
 =?us-ascii?Q?M9k0z/bqsj92uk9CkB0NVw56u1SkCOONbYgF2QwZE8JNTUTuy50fCDfol3/1?=
 =?us-ascii?Q?noqSYiItDeqTGrbBlHuAbudkSKtxxG2asIa5emu93rjIOJRWqZpxIAlV1UOr?=
 =?us-ascii?Q?AJWAg32QjK0EG5rdVFS29+10y3o8RTrF/WCCAzr2dFQkzIwEQUsb/FQi9+Ts?=
 =?us-ascii?Q?dqnNiMwicscCtMf8nxHzZHInHIrGe4hUIstbgG2pU0kSFyHoM4tvfRYbubxh?=
 =?us-ascii?Q?BNm+D84Pd3OOqqRj74TwyNLbAO5KOLCBKdPGfMSWXP/CbdOsPIZtrKn/knoc?=
 =?us-ascii?Q?efFSaC4u+zAh7uwObkv94AiHGuoKZOjmdyKfXVofV25RieTTazGlN8gq3BWJ?=
 =?us-ascii?Q?c74+8ieyjrtJG/Yao3Gd+CRkFWDHQO/fGZpFIdNuhjRzxsUp1EyIsLeqtLgS?=
 =?us-ascii?Q?D/Z2QTT9iNRy7fR20eOsi7cEhURoUsqvh33XFZWkpL+MQ3LU9529XSzudncf?=
 =?us-ascii?Q?/wQipYhidf1yWouQhfKSZ1yXni2ni65dDsXCgV6TIrPBh3PDQz7S64r2PX+W?=
 =?us-ascii?Q?zczTbAgMCLlGXR6bljI3zKfKvN+IComLaGV/wyt4FmVhqGOmJd4SyXHtZ3j/?=
 =?us-ascii?Q?HCQ3NvVjSuq5v+FRB7Zw6iFH2DciMUdPXTgo+ibJR5LuM5go3GP21pA6rCkJ?=
 =?us-ascii?Q?Ia5oppWz7A8GPDN1b6Ah6bKFhKGv+0y2kj5g+F3Dub/gg7PuEiQsY7VGjUnY?=
 =?us-ascii?Q?DeYwo5vDhFGHPfNpxp3k0h2nQ5IBGK1ZoRVI6NqRqxtT7I5hl30Y7EEl4Jmx?=
 =?us-ascii?Q?I4bIjvWNLYLFJNPEQXJ3K1OYqDZHsMfaMGg5Dtt8TVG4HwBk2Vgo8w4KBPGk?=
 =?us-ascii?Q?HbJiicTDiXZ5NQZg0jyKQAKXZbEgzukFk27XFEdKiSW56DkaP23VhEv9nu/B?=
 =?us-ascii?Q?+o/pSLE1lhgxw0q4Re/CxqfH2PMIeaei6EdsoCetT+O4G57Yz5nXGCZBuq7x?=
 =?us-ascii?Q?Ip0g2cF2muz2hP53cTv7yHyuE/oD6zYS+TVTcioJ18vNJAYJHaphpx4DgBxA?=
 =?us-ascii?Q?53ClueqUoUuJZ+b9zLxncBYSIS+I+Gjz/ybiXBUo/zgW/SN0XEjD6jyfvrTr?=
 =?us-ascii?Q?RzjerQPZYWRX3hR0exFh8TWm76LMkkqqESzoF9IKPdqKS2YGyPdq7stIky3F?=
 =?us-ascii?Q?l5vHxuzAdDyopJTGcq5IGdL9uMhPsiPMnzVgW00PihxCZVx9yGqombNg4/Nh?=
 =?us-ascii?Q?VDUkBr7pRSHYsR5ZxqZn0bN667PlRiDCnUAmksnjkAZSH6Q7/UDnhYkhGKct?=
 =?us-ascii?Q?c/1nflegeVNRDTpiBMPTY0ff82LN+9RYRgLevS0n+9g6+f7EOhNUtjkbed3q?=
 =?us-ascii?Q?/cDymtFVX25w0SizcKbqjHpBg53wN/PctGNDCifP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e01236-3e5e-46c5-ba91-08dab2819d51
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:19.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt7l+q3IRjgtFYnimTwMdECxay99T3NuwBZvnaDrndKCBll0P3evWmJBRJDi3+24FA1hHwsUaj2M5CLREtYeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9320
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add mlmix power domain

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb916a0948a8..732a87179edd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -631,6 +631,14 @@ pgc_vpu_vc8000e: power-domain@22 {
 						reg = <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
 						clocks = <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
 					};
+
+					pgc_mlmix: power-domain@24 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MP_POWER_DOMAIN_MLMIX>;
+						clocks = <&clk IMX8MP_CLK_ML_AXI>,
+							 <&clk IMX8MP_CLK_ML_AHB>,
+							 <&clk IMX8MP_CLK_NPU_ROOT>;
+					};
 				};
 			};
 		};
-- 
2.37.1

