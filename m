Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5A6251B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiKKD3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKKD2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C885D68E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcpAzts63VZDYP9i+MD2ur+dLZBY+8kh4T9g19Bmfvr+NTDYefZ/+SfK4xPfeFcNyUDiyzHuQHXbiRC4er3U05kFyhCB18gQWejeA1342bOFVDYUn59rmuIXt5yGuhYmH8LT2Hsn7rYmjyl2etBmHLhXWCropBVtuakLCXEJtbaihganosTtH+mZ/8icRRKQDZMWdALMhG95W9wmOzmEjxTRQSiys+QTGeKSYT29XqOyc5iN5G7xD2mUawMRmqkRCZQ5f9Tidnz2CgIwlDIpr/dmhs0//LjIYTyRHisP9zq32sQ5Gs6C7ZszPqsvnEbi185sNO5pG0RYuKX4y7RSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=mj44slqSmV8SyEBAirxWgI6EpMpRCHyax2nbi3p1ZkmCOY5AqY9HM30UGwZnZhBSPFfWa8L5j25q8kUrE+I6zRykz+vGkwn9Tm1TWKP3kBz6cMD3WqDymFb13JG2Xp/xCuKqo3GEbFucWM7l+d0ptJdzRXWGYJBXNqlvx9YizqwcWGjwmTUhzx3oM9UN6DsVMd1mPPa/ZiifotuE6Hpd3UTFszLN2Kvi9Izl2s33rmm7NyKh8new+djY/ftG4uBlrJbOD5gP3kRX4stN0D2Zk+wE7b+C0jpZDu1HkuxEDCRoKF7ADvmfcXYAowmX81Ya+YCPUDIjXFkTbcqVd6l4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=k24XCxZCd9jFRQ/hwUJypJxS8Jnz2IiT5M4HrE2LtAL1d7NZ1Ddmi13RiWNVWjJHfexuVI9tpo8MYL08iiPtokV3ldKduvbqh0xYhEFx+HrtzEZgwI0c2KI4bXp3xRJNBapsbmDeUbRv2FoC88e33hsSVkHl5FzzR577ZST/yTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 07/14] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Fri, 11 Nov 2022 11:28:04 +0800
Message-Id: <20221111032811.2456916-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a581f1-5c93-4761-01d7-08dac3949c9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GlLctv1wUPMAMVZrtXdfYoHzRBu5uCy9HJHCSSBt1kLHm3JXFEM3rWADTFHlZd2+X88g22StmpX1MWEJsHKCFA+fjWxNeBLGh2fWv5m4Y3LLKA5mKXkmFgBsJCXDiWAaMr/dMPMMqmS9vgGf1IKGLOmrBVocgF/Q4UV7TSlCrBmHmJsBK83qrmtNDSzyU/pUM+b5894YTWqjfCTBL9UIooOO+7Q1lI3Vg03xyU7nM8DiCK3OF8R+oMOIhkpcUpoXX4gJ6p0cY03qFtFerN/cpxMV8aaTt5qAtZMWNr/VtnFaZPbzltaOumpMz3VTDsDH58EszXDBLDuwHPZaGuHRWfl1CiUt/C08I9H3lcPd8/Tiogt5fAHZdqzbnRypy0AeglAXEAOauK6MF8kMMm3xKlaQlG8225tgcwX/o/wpeS1SFbh+NLCLJCSm9eOc5MIuBDhsyJc8UhFG9aj+3PMtfiwlzVe58qwd2w2J5O0BwBokLC475WO5Yc8BLZ7H71zQZ2jIV+8nbPtbA4LmULuOgXBBc76woise6+LkbXsWVU6UBjFIUsm5MYQT9k1luLC55Ts70ccAkUEearCbL2bTPmq0MD0tEZCFt0yJiL9vp5CAmp0F0VPvZ8Hg1bBA9vER7gJFtuY13Qz4mOXWaC66SbbycQMPozvIUxGOoHACLbNnteMGJE0dyxzu2utp8mAtxxraFeA8xfZwsg2moOhZfLnPjVnfRPMKwNlW2JRpXGHJRaLg17gr7ov0Faxuw1Xt10vqfh6pSC6Js23vKEJ/tNbrqoEUaVG+Ei3FSGV2EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmUk5EcXenLuwcCZDTJuBkvfTWNNjfxBx8UWXVk858MdL6PnT6KeZuajLGxv?=
 =?us-ascii?Q?bYKte+jzgL/ejdrFW5M2kJb9Y8LaqYBuLTwfaRz6qLj/8BD+faLixn/wpYyv?=
 =?us-ascii?Q?runmCL2YYXKqZWKcbQMQMNaxO9sQCx/+3YSe94jp5a3mdQA2c5rCV8A5oYsj?=
 =?us-ascii?Q?7k9g5br81C4fy7s7gvWBezm2IeQPVgAvcPOSJ2ZQ9wCEyYLIu8QjvYpTeaZ/?=
 =?us-ascii?Q?dH7UkD6Gl8n39HQ7MdFQL+/kg4t4MSewiHwu39s2dQyoifMxvgi/eKW2jff2?=
 =?us-ascii?Q?loUkE6NFsI2srIScn41SEXsHrwTzCF4za7bG96OHibh+IfYL9NWEsoTU9xO2?=
 =?us-ascii?Q?RljYAB992kKFytlSpLuVnxtpjxZe/c4MB+3vB/vUkWUMYi2Y+LVzcbpnAS/z?=
 =?us-ascii?Q?So6gTsUQFebpD9IfFE40iHdr4XfDGIb0hFwqFo+sHGBAo0j5AZsGsW5rDBeB?=
 =?us-ascii?Q?GaH4XcqTmNbZ9ukoyXPWCx/+Ij26FRqdw43/lB10q1ePqIDVj+WFxk/XNV6w?=
 =?us-ascii?Q?lg6loz+foXxSXeJIyyLbd8F0XUce0kDT6ctpg5p20ZUSLyTAZ6/SJ0iLxlmw?=
 =?us-ascii?Q?sFX8ycgIyAT8KUnVSRVVtQ3NrzIFmuLM8qJ6x4CPyPCSE8z04/q7kzLysLlX?=
 =?us-ascii?Q?WJxOLD94wSJAo56yHUMO9tndIOlAqxG+JbCmGjCIAK/DgXRIA5/C6PinPQh9?=
 =?us-ascii?Q?FUuV9RApkjbmC5107/kNXphuI03JVSIyskCaWl8uun+3GpyfYXuAmqdIdQAr?=
 =?us-ascii?Q?PMSfuZ+7dwNsy0d6VxcYzYPsIQV4t8VZi+0fb8SfuEDzEr98WybVVPqaMGPz?=
 =?us-ascii?Q?l0zjdxQu/MzpnhonGMEXqXLjYicsE7zcyvNUfr+zQk0yiLWPUi4yhrAzEjhr?=
 =?us-ascii?Q?ULjz9wxwtbtSIUdp/Dj/ALkhzMJXKNRLqUDB+lwcie37R5iXyPfesgDKdTvL?=
 =?us-ascii?Q?vmKhFQG+k/Lf/UETU8SLXMOQL6gBK5J2SMUOwFMFaRI+BPxtn3MZLj6X0t4M?=
 =?us-ascii?Q?jimHko6xuE+E8t4G3cvP5NAQ4Zh7kEpddec3L9ZK5s14GBzcRbGXmee9LEch?=
 =?us-ascii?Q?4BtPjFo94gUScclwrNNoX/kLiZULKibRSoSZwz+ZBhju5smpGkjr6Zqp9a7D?=
 =?us-ascii?Q?3tHOx6zZl90xi7g2hNWCWl9h3j94/PpIeTVfIJ4AytAXypKWFODrwefZEwZP?=
 =?us-ascii?Q?sSA7RsP26zPwfX3M1nJGoYNM9vHXN7ryDNsmhRWMzQZ8D3Uwi7XFwv9+K4Qq?=
 =?us-ascii?Q?6R5kr/hCs3If82FEfaUWEKHnwaEdNPJSYFda30ttJ5G+pGWHKn/qwlR5UrAB?=
 =?us-ascii?Q?58go+Z2fOhhVokinFhMHDAfcaZGNe18huEdBTHkCdE5pcqldcANZz/FGJY2f?=
 =?us-ascii?Q?kpqxh6Y1FeX+JtdDROKL3CaalTWTnXxSua7M01CY1iosroHrWjlG9xhdOcKM?=
 =?us-ascii?Q?65SXBsqVLLDLthgq+Wn8251REQ8AoMA6dzhNysRSgOL+fQ3UwPKeMUiDsXMy?=
 =?us-ascii?Q?88URkspJlKiMMGfVAMpfg9YaIUuq96TuHiFgnQW32OF2JeyDgDjzjo0+xIt8?=
 =?us-ascii?Q?J4xKo5IclvSC0fZ6TTmVyvbjKxsLYBo98h0uzBCz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a581f1-5c93-4761-01d7-08dac3949c9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:07.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciEaQVmyQxGuNgIizIkR0aZyzMTQHTz4HYFXzCSGNll2HdLoK9MbVgYQQl0f9zTrNk+mdGAE+3a3x875XMxg8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
BUCK2 is for A53, which is handled by DVFS, so no need dvs property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4eb467df5ba7..a5a7d74ec1d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -47,6 +47,8 @@ buck1: BUCK1{
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <750000>;
 			};
 
 			buck2: BUCK2 {
@@ -56,8 +58,6 @@ buck2: BUCK2 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
 			};
 
 			buck4: BUCK4{
-- 
2.37.1

