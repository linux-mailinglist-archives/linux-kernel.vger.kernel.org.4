Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D162D786
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiKQJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKQJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:19 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D86BDC5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnaZ0sBZlJycNq6hyLx/YxqLvP9wiZxKEpUpOjE51nSkmT/ZQPtvbnAazJOfZ5Dpcn9V+jB+8ZoyRLwJAt44TBeXL+c5u4hnosvtO0yg/HnmRorPrKUzGJGN5eQr2Om7N3lDj8iYqP9UrrcMtdY/Lr5a+EXaYXPTWJg3Vws5RBxdDPTT1M5Tn82kPLcWyj3fHhAkG8jH7Q2RrRzWhcq37oQ4RL7XKwumqTjqI5WqWUtKO9tfpx7RValKmxhKJu3uIUe6KweSIx3cUmXzTfZFRLgqTlOP4VBlqNbDkKn5xbkY6Q5DEKIJ/L1+Y2VugUxdH6GuTwMC7zZog6N3kfpImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXwuanDyxhnNRhTSbaVzggrrQ25dhPHZstO2HNLY5dM=;
 b=Hq0xvEf5nx/hPnATTP1U12lqq8PMOFzgFY08b4EeZTuHd27CsYQYByWQcndINU5Xe9+seofxeUzx3F26pSxIeSiDBkZkWOuZy/idYEdHrR0MlFdCIBbT1T+H54gyjQQRKXmR8Mi80o4vOnTO1XJjViXxo/mlOjqhtX2P93FnFpGjV1yiNTenCjuojXR0Hrs9Y5mgdrnZEACaVohX2jGBSh/EmdYc3sQGa3UnMb9d+UeSkPAQvv6cx/Cey32hhb/WCUq8gaVLxtc5b2g6nxB2EP9uRTv3aQwxc6NB8XtyhM+AsFB9TwTrH+2ig02t2KvxNMWnQxa8jxA0peCukqMC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXwuanDyxhnNRhTSbaVzggrrQ25dhPHZstO2HNLY5dM=;
 b=K3x6Xgz02BKTzJGbLYgnafAp33UfrdaS9Q1psLCTq/2tc7W6ERzrvztRXaBrk9ubFB+VJi66EqzQOVgk78ly9rL+saVKsNGEhpnmifta/5f86dKMnnMYl/96bvB1h5DYMvWpmMGnnuEx726u9EsrA28ela/IpUnFPhxycBxlCxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 09:53:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 11/12] arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator
Date:   Thu, 17 Nov 2022 17:54:02 +0800
Message-Id: <20221117095403.1876071-12-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: a09e58d5-8c30-4496-dadc-08dac8818b22
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIHiz94C4pKKx6B/1ROb+r4+gIbMBEx1UPUQyQvh6q8lZ+QRHT0ycr2DLajx44GwjGRAxqJySuDucfpNf0Zch7DrtPnCMashd4lCVbUhXA6KlP0FbTY7vBiGXEVTLaJFL82FcQzPQo1DwNlhssMTdk203NRUhpTj3TiKRjfEeGTtFMt/sSAt12AP5WHJ13Visqn5+XJIJByaps50i/OHaKGNWpx6ZQTWqAYIPYYxZS2w5EQGbjW836yMNKPje/6Q+Guoy0VN3Q873fzxu4ZoYL4mWaqbC4blSxz3rlwcGsgnjylKa4H7scwrTtNLr/49P0LdfouSLsOFYs1dw1R2qPucBWQ9tbA6NQUbUBGM1SjtxsmvEDifrYXmQ7+hPz82ora1Z7qNbB16jRJCgFQKUYv/WYbi2Ls2a85yKMvJDEJuTQ4VHr5VPvmNWbeQPwoL3ortbkYIoSJNkC00Of0/sn+J1AHLswlmuW1GCRBKGudJmxG8zzm2nMr7OF4EfRWSKJC/kDZSK0zd6jOaYUP7GYOYZ9tvoolYOw0H+HRzzNmbl47LfoYKizF3Xl6xh9vUOzuI1IjcCtws0Z/nSn7qXXO5UvCecpQHoO31sZ+jYXRHCYTwLBSK4oCc6PJy8it7W7HyFClMk5NPwm2qtK7qbSd0zNQpJSKiYHk9qsmfGfp/soe6J+25WkW+V6Th2CnCzw0/swA5qE6duNHx9MN8QpF41hvQUi5xA7Pp9yI1DBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFBwgTGheLmwrSF4nYjvsrOSI1Ku68XU2wz6h1Wks5M1PL0y1l9z22glMHGv?=
 =?us-ascii?Q?LZj43PYwDBd9BKpbgy9trM/fhNHyg4Sf+hy7Nim7ao0yEZAwPg14bt4vEd0C?=
 =?us-ascii?Q?9gigOjbS7IXLUUT58DE+tdk/9DoECTUAe7oRnXXf153TxSs5pVRSmXfZOIKK?=
 =?us-ascii?Q?XeMO9ecHsJwicMveRutL7ACtvxjth2e9W/PvC4O8MR4SUb1VuC6pk4hAzzIV?=
 =?us-ascii?Q?Br6Agy+pOuq+Ct3enkdznddSrCnW2DwRCwKA6/b5gzHvB0+h+EgMyK+RB/dS?=
 =?us-ascii?Q?s+4zDDw8+sWAOuSkMfdM+7WXlzdPNOBLwfd54RFcFj6mfw0K+GSZwzaM1qxA?=
 =?us-ascii?Q?zjLd1Nj8T77IhwhRReYwwIbztFnlR4lutWfSbc84jkdLip7ko/IO5DVREQ57?=
 =?us-ascii?Q?RNKgDY8r83KfRMI1ziYGJPnMDd8f07IoNO0KApciLzx/DTT41jpOBx8gsZeE?=
 =?us-ascii?Q?z5+P+YzC5LuvEpWaDtmHwgrfDk8IBK4BstUNVFuGdwlZyRE/Jd1K/NVj7pvk?=
 =?us-ascii?Q?c+YijCE2FYPf7zB99YDvGDosed7+TpfOtniJFvO3DwduIgcapsS8Qnb6COCh?=
 =?us-ascii?Q?9XB/5DqFAGWVQQUTo7inzxAlzZxHzTUf9245Qp+gHkF/91EW7YHjhckpTYI6?=
 =?us-ascii?Q?Kjf0QeVAkMDt83P4HmwJz0v534HvzAlAmQ/Yc/bV2GVAQwFEVLI6td8mGphN?=
 =?us-ascii?Q?DmGzOoMIhuhXAt+RkldUFOY6q+/DUKTif0qwB+b/N2EnGgMeB772XbcefLVP?=
 =?us-ascii?Q?DxBJoQhgfHGoc+o05eb06wmzlIVX+sHCUSq6QWqB1n/ID4nIJDGVZeraDjtE?=
 =?us-ascii?Q?n+WzUGXZ3xry9XClW7eAowW25SWHuNgBDoXcpVE+ttv+CK9j9kKG9qVEzEd0?=
 =?us-ascii?Q?TK6V5GsQAODXs59vTv8TJ2AsaChfqpqC7HLaKNzlJqmtqU+TJAPvcPSj1PMX?=
 =?us-ascii?Q?DfYIfU1THwIdS2x2M+D3++Pjg7y8ladyTNzYbQBllA/rcuxiHHCjrBxIMEZS?=
 =?us-ascii?Q?lUsM9FEoYDwzQMdOEDWQS7Xdth0TrfryvLriRYPmNfR4zfVP0JmU8cSaVRlX?=
 =?us-ascii?Q?1ffhnRkJTaWmTqIgw9BUtAxhM7Y66o5cme7J/d6Qsx+R+T9ge1HmDxfEBWMQ?=
 =?us-ascii?Q?zk8n39OlxceOSp1pZDmr0mKVXajtVI2YpV/iOgMhUDAMzCeuiIVBnFcHAuma?=
 =?us-ascii?Q?FcjztKZcHRotDEqQxawzn01TqhBwcOjQszrTDrEXDMkDdFoYpur/QKpGwDeK?=
 =?us-ascii?Q?HhHs1qPlsj1trFjZloJKpOFGa7eZAqzzRXb+l+NUUPHNEcErcSrlBLdG6Beo?=
 =?us-ascii?Q?LNEP072ppdQHlvqAl8s5XLxod1qzK17qpjheG8CGM9+PfO2HdA6BMbvKj6Al?=
 =?us-ascii?Q?O0HQqKd7x8GzXClnzfNrM1v3oRsi4LKi8BaaSoG9OMdq4oxN5/z+Pq5yiCpd?=
 =?us-ascii?Q?/ZPfHw/cKZJIfNuOLew6bY2vcDUhqQyJd7NcMI/rNrahjfhtvh7jNjLL7CyQ?=
 =?us-ascii?Q?n7znqhnFLMqxcCQ4w6gbJC3DGK2/3C8ziiyNmVxTAHe2xvd0t76uDWwK/cmJ?=
 =?us-ascii?Q?n7V2q4cKWZf5t+fhMPy6HYyTfdnAJL/MEz60ceDT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09e58d5-8c30-4496-dadc-08dac8818b22
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:13.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/B7FtcePLDbaaWK6A7n1QaiwtVQItlbw2umJ5q69QC4ST4av+HWw52EcN9xEcStWj738/tkgu6ETTXLpGni0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Some SD Card controller and power circuitry has increased capacitance,
so the usual toggling of regulator to power the card off and on
is insufficient.

According to SD spec, for sd card power reset operation, the sd card
supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
next time power back the sd card supply voltage to 3.3v, sd card can't
support SD3.0 mode again.

This patch add the off-on-delay-us, make sure the sd power reset behavior
is align with the specification. Without this patch, when do quick system
suspend/resume test, some sd card can't work at SD3.0 mode after system
resume back.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 6800d923aa7e..3f2b0ad51e18 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -56,6 +56,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 2102e9b57697..78937910f403 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -46,6 +46,7 @@ reg_usdhc2_vmmc: regulator-vsd-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

