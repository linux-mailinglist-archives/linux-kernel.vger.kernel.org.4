Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED44620684
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiKHCRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiKHCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660892AE3D;
        Mon,  7 Nov 2022 18:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1MsbUbuRbm6QJ6R9SqH24C55QNo+5vXT6RdDBF9hCxgG6HESxvh1XrTqS9jppcQ5n0qYEWaGZshqdOdP0pU25mUgaFKieYuDIyCYPxI4kmbxiDu1paatCcJUSQsEP3g6DgUgt0PWPpdH8AuRyxObs7uAMbEkkSuLaQf3CoaYMBALkSCzguq46o2DT4+XkccbkrPVt9s87YEBi/bd4W1yU1MkT6wwc0XEn/BwyMd/BwEETzz3wFNx9l14ml85aTKnjLulODBgKtihhC87V0JSkqShN0AQ0hOBA7QoVoGqm5u4xlf+ixxegUeb2m9fyC2o9Fz72D+q/JuodLMCdYPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=RPvUyQzqumvYgkknuRTgSkjQHUsRp0xVH8T3QGjqeQrVj6H9w6bIYU6p4tSiTkZ5T4vbmmXxjv/uxEBzEJlRAIs7c/J44zNdBIIJEbBJ5vRb136PzJQqUk45SRCoLARyT8nY2mVd5KfW3cDbyO1qul4EHq5g5Kl0CvebnBgGsuIKTFRsNF59Dy84LJUf3dhOn/v1RTmuEnmKHfI3JZ0j9bzU2RckDQaf7shzc8nYvQaI+CmXpftu4TzMOb2lJPvYAe7wvGbIQA2KYyPXcsJHaN09tswWefLBzy7GM0ucmkgl3j4YhMxoPYoOfosmqfEUM91RYaCp6s4OXt9H++mNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=Y2VKavl4NKo/jpZy+DQPC3HGgtnFq1BpJjnUD+Ms8jZNwrcD54VzfBU4VptOiBDZytEree6LE9heBscHgBToO5OZIdDqchKG5IYmzDFHe6skz28E+hYHbvqwYtewG9yiwUI7Kpj3PFJbEpb3qqHf3gY74JVbWF4IEosXnF0BdOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V3 02/14] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Tue,  8 Nov 2022 10:18:08 +0800
Message-Id: <20221108021820.1854971-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 63296fd0-deb5-4b64-5be0-08dac12f56ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rWvB9bMZesPqxB6LlgPoQagEDf/Bkr5v6dTfsl7/JL7idqeKJbD3kpkXNY0WQAA2vVudIYXiikEol7jOYpM9WxanB5sCmoyptKpnP9nvlvPSW478FCbtFt26FD3jtiihvA54gDW7LQnrg6n/BE0gVBhnAkakQJoZbjXyBnsHjDJ9gBO74Xhx91Z5VJXPikh+BKQuHY9r3oDmYFw6ZHBSUp7Sh8OyLMNUWoyZdsOX15bt+8q4WsMZbXy+EOjhpd3AdZQ/vTW5NIm7MQPLdBCSO3r17Gddf9oOCX7qNMvck5qLzHCUHoaZS9pjExFg4zmiB+OgLBIxcnGMLyWJHWW0j3HKp5XsmIUL/xcHbWmJ7OlTlRDUTbVSV6JNIKkvT98DGqngrcTvlcb257vjBMzwhgt9cjBfC/a0V3UxucaFya1k5PvynHST+tVUGrqwMERQu+U1H1kw+qngQiInbQ461ED3kCM8klf8qlPIpUMI8/QUTiz3GR33omeaKSvnS3GdRgwWEqdiJUOJG/RQHGRZw5kLsJkcrNEKPGi4nVH0ED3wzzGV6qECh21V49YJG/DDNU/7P492zvr9cOjVJsk4uEPXw605QIQWe0i3J03wuwgL8wlQjbC8X3MDnGICubENGfmvwFg+NbUt4qQDPBNXD1RsusgvyLH6rcQIUjXW6Rf9P1uwfIaWNQKsoGhWfXqRDf+E0uh24bt2LWB8tYcpkwP9dUOBrj4MMMsIk+hCXXVwjAmw/32qYQ83QANfFV39SKDOb4shWNpNbByC/e0GifZnoISgH/NnE5Kl/XVDcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(7416002)(54906003)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVcleNMqEyg74Nic/7vvH3BLTLzAaLxDq3m/OOtboDLassXQJGuV+BPWvAlI?=
 =?us-ascii?Q?V/B8kGp+GxCtdKq5dxW3GP9CuPenjbYGj8hvJHs/DyZW6Q/vV3x5kv3rdISp?=
 =?us-ascii?Q?3VY7iaobyL2PnsoVkws+4GehqAKZCKaSWchQIU4JVXPNil60U5oqpHBxBrSI?=
 =?us-ascii?Q?WBGqewEk7MMjDqBhMyWbH4A+QK2oz4064BOGS+PmDsVT0hIhNRqw0+YfS5qo?=
 =?us-ascii?Q?QGVVghO7yitdIBcGTIdNdfc1hCzEIJL7LQRDE3fU7UVV8GFjoQguZcSdvn5P?=
 =?us-ascii?Q?LOTnMT2A2Vyyh3i9ROYQUEvaQNgm5O1Y3UKZzQSRV22H0zwAh+JRKbKqrkG/?=
 =?us-ascii?Q?DWXOEJw78KqD42DPqcXaMGRXmZDoA+yt/Q1hQGuDF2ViB876qK/jZjAwbfFh?=
 =?us-ascii?Q?1vvTiRFXY/+So8+yoyr7XgdtuGTjH4iCV3G938It58TDdPqBVTIuBWYeWIFk?=
 =?us-ascii?Q?MBqTj+Us/lktyVoBPQFfsBEu4c3cexQksse0TJiGF2AuFcxumkDr6EtGtk77?=
 =?us-ascii?Q?C2A/2r9AsKfPhgKgUlHRR+CJgRUzZZPP51mvk9cAR9wjsaX1HNm9M4EkaXL1?=
 =?us-ascii?Q?i9bMgOipglRFhHvcOK2FnMsu9fruKaiBA66sijN20InQeeFb+QYSOV8t3e+f?=
 =?us-ascii?Q?Sj61RdwoWbe137DP/GEbIFERIrXM28VA2jlChn6Shwo+ZtZZNMYAhl37g03e?=
 =?us-ascii?Q?FlHAlnjyk8IUHk7ZYJtP87BDvm+9Zp+KedykbQYyh5hn1bYcgIT0KH1rDZV5?=
 =?us-ascii?Q?8kBPT9YrwOGqsNVG+eO0xXbK01/FRFYMHm+w8r5Sf3bUyVHTJUH9ltW1A9fT?=
 =?us-ascii?Q?vtmgexZjj266xAB2hDZAhc1lxBOjd+paPImDwNfUR/s4x/K/uHaORWIRUiCo?=
 =?us-ascii?Q?lkl3Zhyca7LdDCGXldgpMIqilwI/Y3amB2st4ZMeAq3VNlkR8GM/ad6pKm7I?=
 =?us-ascii?Q?46mXMyTcrelVpa1A9+4g5K+2ABCYDPBV5fJBNCGK3i1tHHrExrKGR8OdNT+X?=
 =?us-ascii?Q?F9qGz3ibOcS4OHu4uXjubETALuA8hahX3dg0aQBu6H5YCwT5+Mm3PmGb4sFa?=
 =?us-ascii?Q?LIhialXUrNxp0xv5/hy4kdD4TohLNOQS8NnCdLrK6fwRGok9xg9jg8jGnVzf?=
 =?us-ascii?Q?I025+Or5NBLFkwWZst/GkatPtzxbEfRB+oRCP8P2K8Ll5GjXvZxGle9j/r52?=
 =?us-ascii?Q?NGvcQqIYMyRIGXOiued/Au4za+lHnIliWHaMHnnnFsCg9/p9i1lhFhK+2ssM?=
 =?us-ascii?Q?qjbi8LQs5PNJ7QVHcM/r5w3apRLP5S09J9HM62p7lizlh34XOQ2r/RxiZS2o?=
 =?us-ascii?Q?aZzvWERo8Qu/gmgQjYcwPOhoS7JgNjGffrY9bVaVYlmk40YoJdAOyL6aNtTP?=
 =?us-ascii?Q?GZPE9PKqLLKKa7e4TPwmOmg2SWt2q6d0N2kiOvGbrICbBXiIO7YjfCd7QHVv?=
 =?us-ascii?Q?oODaVxLd55m1KvkQKIdCkvx/pYtFzLW+KOD4irvfqDRxZfeQb5D5byncYwEk?=
 =?us-ascii?Q?wGfrdNDf1KcIn+fze1OMIicotGa5QXiJ+jSpNVLPC0i34QXs5RR+z2/VgOyR?=
 =?us-ascii?Q?N0HbSb6qWsFfG2/iNw/VPPi9GcyMZvLW9Qxw8wy6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63296fd0-deb5-4b64-5be0-08dac12f56ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:09.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea3sp6jqx7kch295gp7whuvOEO6V8/dLGKHJQh3C8U2f8QxV0peEe6+rkOr+JP/+PEs4PPJ0Kkl0UOpzPsZwiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to RM bit layout, BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
  PE HYS PUE ODE FSEL X  DSE  X

Although function is not broken, we should not set reserved bit.

Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9f1469db554d..b4c1ef2559f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -544,14 +544,14 @@ MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c2
 
 	pinctrl_pcie0: pcie0grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x61 /* open drain, pull up */
-			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x41
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
 		>;
 	};
 
 	pinctrl_pcie0_reg: pcie0reggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x41
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
 		>;
 	};
 
-- 
2.37.1

