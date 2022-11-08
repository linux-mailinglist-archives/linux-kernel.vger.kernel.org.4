Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F756206A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiKHCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiKHCSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:18:12 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A42DAB7;
        Mon,  7 Nov 2022 18:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlB07N6NxMJSmohLgpZjW/XZuubAvGNhfmEq5maZBsvmCK2rFJ+xwXEj4KN5ZDw6p5CKrVony5w7Fd3p8ruaZ+QuYr8Cm6LrSPUP/g/3vdcGcXsETrk7lcVVI2pxeNMcmSyA8J28XC7Fh/cBW0xzVGLR7fqowbbqpRJd/53JYOgoh2wPIjGvsDcigQ2nlYnKsIfDmgD95ZjtWrCOKEbTwAMM3SiznXTwH6RFnMaF9r0vWdZsEZnUwaAvmiWqQlWDg7u+8+XigymopIuc7TtkPVJtoWq9TGWT61e888zwxsrAvH0uHLYPpQUGg/TFfmkYm9STXwFmADcjJDXki1PzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz3zK8DP17lcFGmZHLPXTi1DTD0usmKlYijve+Fp8dI=;
 b=Mcp0fII4YuxvVI75Chx9Oj4XGJ2F0JGIQH0/vQPdM8nVe1lc898QDO6stO7VjJEqYRSY8FokcVpBk6tY86MPlVycGepDAVuV1m996rlpkDCV+FCdDlJKe4041syIXxfgHKhf+mSP23Yjl38K8ZFPbE8imrm4t7ce+riP+MGpOXW4mC8jvAq2xZzUM/T96VkEEfoEBjVqNGdgdIfC3V64KdCexX8Yxn4/ZWDJzlCVu2gc4LB6buk6KYHv20BlErY/FkcGZ/OENGFNJe2QbSjItw7hqAO6lPl7qTB0vFoR2vDGPZ9pptiANEJItMWgTs0M/gD+oMLhL25KEdKfS8ui7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz3zK8DP17lcFGmZHLPXTi1DTD0usmKlYijve+Fp8dI=;
 b=c5pe259CAbaC2TGOrx/dExdwFaLPi+2qEh6W50RkJaHM6spJpYAcvp98vAK/t4IgWHMswrCwlfm/lSLqxWdnwdqdD06BIB1uBzWPXyDpusUxE9pdnm7mZw4QB8u/VRwKCUXZ2oqlSrfoQ7YnufAH47HkNBsWCE9GeHTUaQOacYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:18:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:18:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 13/14] arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator
Date:   Tue,  8 Nov 2022 10:18:19 +0800
Message-Id: <20221108021820.1854971-14-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58466492-da30-4a89-c8d5-08dac12f7a3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IJ+YKPBDKe61EKVdr7mE5NxkgJ1xb/kdgdCc0pvMSiGNYuyHHQfeoj0u0/DNf5kmR6Xa7FObz6kFV2wrJTehr7vcV0uo9GO1T711XG6UfX6MyyzgG8cjsUwzHcFnII21EL5WQ+KDWRYgQ5XVISxdDERCeaXMOWz1gbIyEEVYmCEuvMol6bGhCVxCderPgkBrJI4BeNJ+/b8KPTnkJYAHJv+juKaqMweUneNwQOJPNIDP17asPq13lDs1J17eiiH3n8mUHPDLkR6OS97bt4qPQPMw8Uv1J7QOFCKb+TH63Izwk9T+qK0miG0ztGY5FxMd5FvY/tZI41hU09GaC/Sz+eVpaJDPM9RgtItp/fwD8f+kfRHTqK74NSLe6EhnRG61xsw6PAuNfsMd0Ro2hXQ2dOhSeCJfTmOVmnmRFDk1H/UCnATAMAy7luaMDxcbtPS1O61vGYluNV5oaihV06E4QGBz5GQbgVCenKUuzTC3EvWS1nUT8eujezMOiY5KGfsOXEiPvkXc6Qd3wTN4kiRJm/5N4olHp+VRPiwZsSIjbJXGo7tQvBui5vvwlT7ZEM2V/mXQtgB3+EHMq11AFq1iul8jZSu1csfaNpHo7nzjfqq7D6CZF/kmH4eZ1SB1GXIUOLpHYS0D5ELFbjZki0Ztrsk0d9mSRa4gQnkOKHMa6XJFosOd/r11HRs6ii8q/zJGnc0Vk8RXU3gPssUqMFdF6ZwTkI76xeLkbEUa8nn6KLP7zMvHy6F8CPukyxROYDL8CTdx4CpMkGpFtGalX8EczSrWOHhMcmw8tdxDJemn54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(54906003)(8936002)(1076003)(5660300002)(6486002)(2906002)(86362001)(6512007)(83380400001)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfjiCcHgQvdbfEqCcg0pISyIML5WWcim1IVah5DiOPpK3wEPb390s7Cbvl+l?=
 =?us-ascii?Q?f9qlU5pMFvV8sDv3/zoaShkBQi/4JrsruVyc5eELCqt1KIL5Eb2tPrF2iIPt?=
 =?us-ascii?Q?F2+g9V7+6Qt96JrOw3Hv5miAmIg1plX988PXN140ETUR9apoVvpQ3b2GEyt/?=
 =?us-ascii?Q?cBLRVdyKR0YBDBRZJxWclJ1695NWXS+Ii/gzzmkhTM/GyS9ZR/EgGPDP3aCb?=
 =?us-ascii?Q?h4BlYCo+6CEEiHV4MIVBx5pKPB8XAO5gYfqiYwgj03kRlTLY74Xu9SPAY1NQ?=
 =?us-ascii?Q?+E66gDkodovUMUAlwhmQip7i6hrO/iGtMt/6QWSeIrotTu7kO8W/rotRdQk3?=
 =?us-ascii?Q?yvoFBH1z1iPVKDOs8sX8KSYgiXs0kIiLUZqlFa+U0g4JklGUqWL40ouHUA9/?=
 =?us-ascii?Q?/RA1SRYeidl4fpjmWCDXCDHVDU+Tr2/58h46WwknAp8IfrtBOBo4sHJoU4n7?=
 =?us-ascii?Q?3HWyjJfVlRKpMItKxs+QyRLuPlo2g5NZCZBGOCvGN8kyhQ5A4ZbN2o/ShlPm?=
 =?us-ascii?Q?Gc667yjajefxpb+tX4BBMGjoX01+wLiOYbUMBfF2FvQTPdko+SBa5LD46x/k?=
 =?us-ascii?Q?LQfxuUGM1EnYoru1aJYrmENNqw7hyjAfAfWuRgdq9ymNEEXXcYe25xOzA5Zi?=
 =?us-ascii?Q?0b7lcl+kEnxrfp8nLDHg1vwhz5sDf2q1TXtzHnEu6l1yf5/T0zQSa5fX45Rd?=
 =?us-ascii?Q?uRcbL6whGgNrQ/Ynvzb9hEWVXiRh/vfaoprqhjFgjodsssJKX3s5mXpWwvnC?=
 =?us-ascii?Q?u/nc7lfR5bZNdnbQILdwjRshDBIA00fhfRxLMJKZFCgTnBjFxA3xp5//E9fq?=
 =?us-ascii?Q?tGEsVHkBpDaXI6tQrILYBOicW/J9lz5FyC1oeDTsd6XA/eEiGnOoDkt9QBrE?=
 =?us-ascii?Q?LXGkwxjcBeK+r88ZKuWqxL7RQfNcNixxt4esIqKrS6TsZsT9bycl3c80lTCt?=
 =?us-ascii?Q?ANaMIA10JjS5qQ3BHakL3hE6YHwizlPstYxdxl3mlrTlaCEsF2b7kAIR1//E?=
 =?us-ascii?Q?fZoQCc935u954ffFfi0vmMcG26l7uKBrFSuNtGUDPiA2bKO80Td+FE7B0lQZ?=
 =?us-ascii?Q?xMqKDxDmk04XgGFOG05soHimbHWdXm3qzq8Q3W6Qbh31Y7JlaXwP+UugLteq?=
 =?us-ascii?Q?b8MizPKrVC7i9sxTNJhnvcB9fbwvzCddhhKkNRGzMP5GCCJJ7nRI+jNGATwo?=
 =?us-ascii?Q?vaPCxnUVkpqJfoaLH+nPK/Uuj9PsayNkVqOF6SRX+pXBi/zgnuSf4EZJSm9r?=
 =?us-ascii?Q?SaoN3gRoPaYO53actd0bqk6l9uOJcKqCRZUNNjtw7BqI5s9gDBo3IaY8hplg?=
 =?us-ascii?Q?AwvnSLKxuucWgSK0kqZ18HYoJyPOh+uQ5DQFCzRBJmWFZHRW1Uc0P7OYLQjF?=
 =?us-ascii?Q?lDfOyoaobTFMfl7f7nR2WdhqNyREZ79u+zl3HgQbQB3MMbvRe4ysnQGT5G4L?=
 =?us-ascii?Q?FabotRcazYiWxwV+hdBA9xB4VdLBZVQCkoMnQHPT1meAWypi1w28sX3QoeOo?=
 =?us-ascii?Q?x6Lbf9y12wYCRt4oX+TyzYBX+DN1qgGI1dezppJUslsAdQ7HQ+kJ2Lw9sglg?=
 =?us-ascii?Q?5g63MQ5zAPa0zXSSBLE78YVBTZ4JP1icB6nlnRQJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58466492-da30-4a89-c8d5-08dac12f7a3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:18:08.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8d8BoDth8rS1YXyO8fkjNrgnwyRtH4s2Rnr2kb/FTzFWN5iJoCa1Tkzrs8qjP/Bvo8xjO0/7DyjcyzWjIhvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
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
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index ce450965e837..fdbcd2483efc 100644
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
index 82387b9cb800..07d9fb2aacf8 100644
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

