Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5469654B76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiLWDBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWDBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:01:09 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D1DF28;
        Thu, 22 Dec 2022 19:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBLOyp5wAXP0KuZfbSWq+h2FVDJIQXxJzTrTok+jcnOJ0ByYKR14ia2WiUSglvsHchfn9duqPuPZo7LhiQ4UvdomNYacTkSdoqWkThNuNmtKmWFR6mIjPutysqPfi0iptZZqxu9YSWdpPNpyC0E/HW+TXlDpuipSTt5Hhyo7qxTDGljG6Tp2UpzuPttntptVPJO8NtWkned0q+64hl9pHyPnTHZUmiKp9BQnxCJd6PHo6O+8o7sY419I4R7NFc0SVoaE8mgM9zBEVoETxnr2DCrYmUs2f+SdnYSe+MPjZGqSjSshnrPDfs1OwnwhzhmBrPRF/PP+eJ1DQ9I3HuBuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDjtAQaRGVS2uUdzHs4Z4h3CpB625bovRS0sQM/ynjM=;
 b=V1BoZoYxPNrmuyTzvkCTIokNH6jVOlRZn4OIgx8JQRv4i4yWxOr6dj7XewamUNGiCY2PNWWy/3HXl5i/B4WJ+xeyCzbAakR2Pg8j8m8CUxIHf9FdGJEcGcSx6/nBt5H0+/4m06klyNc96tTWBnRb1RsMI+KR255TTOqnHjxcWz9AuwnK1ckigHyyt9FTdGLdGGGh+59TwvlV3AhZXgIGNHKJ8tV3vGEgEObqiYvDLtcHO0A9Ifhmp5FOkG7KufsZRqiETNblrvnTKU19ySyvrtCAyI+WZdi4LK6nzu25w4WkvkHk16lcpCx3YDCG3ld8kI4mTpUwtneFjVB9X18bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDjtAQaRGVS2uUdzHs4Z4h3CpB625bovRS0sQM/ynjM=;
 b=iWS1AaXgrlwpxgMCxEC0i75exPjwhJndPI4ZQljP+EgC1HdEvwWAWPZVpem7O6mmhhp4GSTWrlIVRfP+Pr+IQDa6IxYiI1WubJKCwMjp6XKVGtb0OqgbL9tD7wGBGXvq0xg939xWSAVUwvoKKOJZ2CK4vnlHcJYoVHnNkRcqFaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 03:01:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:01:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mm-evk: update leds node
Date:   Fri, 23 Dec 2022 11:02:27 +0800
Message-Id: <20221223030227.16784-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a46296-0447-40a3-7468-08dae491ee1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbJ7U4GLBZO8YYhLer28RXb5U7/HkHekOm5fQjD0vmWdMD+0jUDILVdWKF0ZQpS5CEaypZu6Enqo3cyU8PgwQs8M00cutj9/mBNiHuxga4U68WaCoK9Bnma06lQ3e8MfscuipVsWzoexQUgOEO1iYIRGEHMskQ+z+qTalkRvAoToSzgpP+2qlf7+DXyExpZS/UMlQM5RbqjPtx0QfXDmO5Fc/jX9WaQZgWAND/8H8eF63MHlXaFN3xZ9ES4aloCLiMPd5cC2FP2Lwp+nptx3/ZMGPNLv5Fk5aPpW695ANTa273ZXPOXxU/oKywmOpi6Y5PF2hTamxI9VBSimgd2PGj5p9hnZ1RrvbCvkhNoaARmoO5v3ORDc2p6AnjSXFFops94KyO3Sz6f2TIZUAmVytZyHFv1wV5cz0kzwoNiI7CnJ72Ai0VUKJf1jBw4K7fbFFINgORdXlA9N/p/33Ufp8dBmzRIaadplZJdGofcFXuIjyYgZqWhEx4XYKluIoLNspS6yFtd+bAs9YCZ49VeAaFTkFE5qfj62EIfoDbzR1x4G6akUKP5k4xkK2id8/Lz64gcereYxrISKWNiSCbzI5l2pf0FP7mutaVkGvmeBfdq7U/ONdYv7noAV9sAjeLbg3kw4utWTESN1zzAEiUxs7pHNC4Yx8o9lJDb+uMjJozDwRHHYSfPmFANs8JTi1zmmC5x+2ZBWgvTtjHVaMkmGFd9dtz/0gF/hjRYstngYobI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(15650500001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7ye5Ys0ugdBhPW8bKhOUP2PzgAT/i38lxosNZIlQJRV1z+M26ZY9ehUHGFl?=
 =?us-ascii?Q?Zuo4lmDtz8uGPbqm81RRWWXO/vWOcD6/0ZTt47R++B54rHkSPxMI1ntMwj9L?=
 =?us-ascii?Q?W/TC2SWjuCkuQS2WDQZuT497vsoWg3WdYmqth4UxW+rVyYjxaX31USBmZ/kj?=
 =?us-ascii?Q?6gE+A9HeE5XvTEsnDzIxjVnlA5ABfnTj64BwqzzzEeHAKl/s/F+KfyGdfGmn?=
 =?us-ascii?Q?Xokp4O6322pr7T4mGQn1j1mgm9YJU9geNoHxce+/JgIk/85Bex7qgKxuyKK9?=
 =?us-ascii?Q?3HCBoQwPqo5xxkbB/n3kMLWS1D7Qfw7gClMrMfvPHJfCuugTkYjtG6v8KWLZ?=
 =?us-ascii?Q?jfKBth2dIeblrrfsxmIJrrZktEVcH5323qLqeuE3rqSW3wPnePW3zRuri2xT?=
 =?us-ascii?Q?pzmzwd9VU4QAQC232MFaj3ZUPmXlVD0A4MClHyroL7KaJKy190v66om429yp?=
 =?us-ascii?Q?nfGeKeWcxCSCDkbIoqpCh+6/sLO8140wXPFtZ/kl9zWtcG/JIC/s+QEGKRJD?=
 =?us-ascii?Q?fRamVx/5ZHff4j4TtEKnzTE/xwHzr/edXxcfJp0RTOR1rQ7AKqW++XY868nG?=
 =?us-ascii?Q?biy2blddlitYFe241BOTZ9cZ/twBymEVIe6kV/azDuFdUnr3e4aelTKR72Wg?=
 =?us-ascii?Q?svK4LN0G36pzBzHpwUripEouGiIks4hQePEmbDMRodhooSowj8vL3bgmjIwK?=
 =?us-ascii?Q?+4Bvy3HNCyEjKKtr1DKNeUeL6GP1i4ogzEQZGrJch0kC4bZr3yDlipM/P652?=
 =?us-ascii?Q?Ide71DqKrGflZNuaKJsZAqlbRkJZoB7VxfYqRWaxobD/hNW5q4gj1TWUhQRQ?=
 =?us-ascii?Q?JsB0IXqTo1CUz8RAuj5rmIcDhpyhhiU8U1v9XHrF6WRIhe4tZox5cBS4fg82?=
 =?us-ascii?Q?jqgNkCKNVcaIOycw8TQrCES6W8lCs9ZCfm5m5VkQvS+jJAucEjk3kPdUomIl?=
 =?us-ascii?Q?S8jSdDTEMdyu79GfWJlqu+jiMCM0SyapyFo90yZh0cX2Nswk1uMzq+lJbC+V?=
 =?us-ascii?Q?vEhd3yaig9QxMIOWLdEBec2PtY7JIyykmp1qCBMoF7qeNdPAG2TOlg3a3qUC?=
 =?us-ascii?Q?Ku857l5b0xfG6Ng5zCSyTXYPc2lSkEI9MJCOCwci6jYr2IAvw99q9aEk9ZOj?=
 =?us-ascii?Q?5qwNEeqOo/4YU6MOE5EKvaD5EID7IzE4oBIDdM+7/k2Gofrqmo0bR9bg3l+b?=
 =?us-ascii?Q?DA+RtplCR4y5+7bzmudeDH3Am1/cEtsEFSuobr4opt6SMYnCiYdxba8/FLA4?=
 =?us-ascii?Q?muJMvG1kPM4ZMzDduxG9tK9lldvig3TKMMq/gzTH3W6AfiVoVmD4zbbLYLL/?=
 =?us-ascii?Q?5EYSa8oTvm/aM4d2CHVLDUyDmv69XgisQRVJHjmZ80ZgeKvDQMU4liuIf9IT?=
 =?us-ascii?Q?7x96Xd4yNfKRbOJCn8se+QcLgae4gN+gFfibSjUuAemmDn93SeGc233CeFCg?=
 =?us-ascii?Q?nYWvqctUOrwMB6MxzN0DPgoXD+9qOgvODiBSykZIyniWQG1NY45pTk+YLdSL?=
 =?us-ascii?Q?VPrKdR6fA5fgu5UOXbqCO5LjdaTZDYTMpM6iQscwfnlYirYGjttrSTFZFSHE?=
 =?us-ascii?Q?J1NEforhgqARZeP1rNouY/v2V5+eCtgYls4itw9v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a46296-0447-40a3-7468-08dae491ee1d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:01:04.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUP3UTXNIsFVMRuKjTA5t+il+gNlkVv5rjAMrobIk93IBQrFrxGAiptQhr2lVljB84u3OC0Xux5DqHF7RlZVUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Drop deprecated label property, update node name as leds-gpio.yaml

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e0b604ac0da4..0f87991dcb57 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -24,8 +24,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_led>;
 
-		status {
-			label = "status";
+		led-0 {
 			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
-- 
2.37.1

