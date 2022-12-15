Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D237664D8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLOJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLOJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:39:49 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F61BEA5;
        Thu, 15 Dec 2022 01:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZSyI+uvb40BZjbvP5nmRG/iE+zIfMRoSO3/VlwcPlIhPENAsAJDOy1TY16t4z4qcIw+POIcpAiJrTWIAgsCvvkDwTCbvYwa4TsKK9IzI7MfW3YuD4nOzlpxPNBC/y8h2RK5zOnj7mDD2A7UO/drHs+gIToJ3D5iHIlkggZnnYAKvqJ7edwWK+jz1lO5OLqu59TTNJzcwcZyUvStx5UijIx18OrN0+RjUF49RBIiFDfQVIDe+V7gmSmSDLE6nYEMjRfjV3en4bdEFyQTp34jKZRJN5P/vHoir0hTbr+DcmxNvYW1SN0A00C4g7nKKmP5SFWGRNx7fMgVoAWsxjVCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR3BwNHkDePVasXy+qKJfGiR48frz0xOSr3P7Bwodas=;
 b=i0jkxr1w/NDCj/iwp7bu1H5jJCuStIwBrN/V86ZBMksXCNh82j54P5lZyvbYw44onFZCcaQnyAswjJPFnEFbH4WbwUZAU87PGrA1PljrHIG6IuhOh6pAgHg4wcxmxYKmvoi8y2utkWWXXVo58IztFTfVwPzHonCj5mWVYGyTcGc2AgSp36M6RjTeYpScq62YownwDtFNCclQLMFnrSLmxCgRt4QgIo4cSuQzUmbiHNHSGKP92sZrBbXvQNMHXTU5L49nxzt7UvptqwhtS2j3rjkWE2N8mL6vQIBss+Q1gcPz1HK3ZK4jwqKOkTr7gSxpSKgcGdInsbA0/IpGISANOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR3BwNHkDePVasXy+qKJfGiR48frz0xOSr3P7Bwodas=;
 b=SKP7xlgExTVjMupwbTtSpnMIs4ZdP5qSabShbgyr8G31WOlyYSaYsjkN/Xv62jX8Z1jzUVKbZt6LOlx2fBgGf15XQuhmdv1QirGigcUkXvkm7H+GXxoZ0U70P+hbjMNcGf1KmEkYWWTX9dhEXgxK0rKSGpgfi+6XBRV6y9C1Q0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13)
 by AS8PR04MB8866.eurprd04.prod.outlook.com (2603:10a6:20b:42d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 09:39:45 +0000
Received: from DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24]) by DB9PR04MB8106.eurprd04.prod.outlook.com
 ([fe80::e9c1:3e78:4fc8:9b24%9]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 09:39:45 +0000
From:   wei.fang@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Frank.Li@nxp.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] arm64: dts: imx8dxl: Disable hibernation mode of AR8031 for EQOS
Date:   Thu, 15 Dec 2022 17:36:27 +0800
Message-Id: <20221215093627.956417-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DB9PR04MB8106.eurprd04.prod.outlook.com
 (2603:10a6:10:24b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8106:EE_|AS8PR04MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f119db9-765e-483f-db80-08dade804cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbvaFaSHfBlme3pq2FrHfgOJd2nzeKrOxy6qcnJO1t6RRruuo8KI+sv7elbzS0Z4+DmexQ+SyKM8V7yR79NFAw5+QDSWxhnYPQ9A+YDQX+y81ZG6Xf34nZ2r1UEAqHMeoXm9ivoPY7V0+knhxZsWfz2uR0Tgg1ibIiiNXlYt7/b85fUAI2PyPdNFVGjS0eUATcMHMFuUPuHTI4Zdg31c4uc400NoB/1uPNWUVgjufXGJYgoECzuDRaDEc9GRJomzwMBX33Vd1MnuDRwEo5p1IXmjUeyNOHDOf2wCowudw0u0h6f8ywVktMklBkBwM05E52k31MfYjp0Q2T94ZpezZwXk0eTKI6a0M3Xg7oAdllOcr6GEodBJfiq0e1kNusQiSs/vfCRQkwmTC/+hScMSNcxPENPFHpiETEs3/bMI+QTbmjbnfW0JtORY7aJ3uChtyu0YWYdH2uOjSWMwsnbCsrBqKv5VkkGHhStwXAD1y1NnNtNoZp60CFXMPrwufgZH+UsfbH7FzOv4bgLTw9QO5O+mJfIh4yez95Tx0rY5gjvI4M+lAD/aHT+raQMjvIlZ8pBcH+XRFlujEJoQSh0C8IuIYRDnvb2CI/tsb+VQBppPBIioGeW6IFbqQ9QUMzNpbRq4Ta+3pp86OFccY3v/zSqVyqNplJnqcnDnR8/dXcAFPKaxwHW6+4u6NXaeFSLNUaxWETrUCAg55HFS6n3CQ2fe/v4gUWrjTPARRE/qgM5Ht/vPPVlIjappgemm9Y+7HLKLIxpaWirBg7MmoK94aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8106.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(5660300002)(4326008)(66946007)(66476007)(66556008)(8676002)(8936002)(41300700001)(478600001)(966005)(6486002)(36756003)(52116002)(316002)(6666004)(2906002)(26005)(6506007)(186003)(2616005)(1076003)(86362001)(83380400001)(9686003)(38350700002)(38100700002)(921005)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BfhQljKoof6tL2QJSVrFTMP4ZWhekY0CnaSAbbJjpnslIxE79h04PMD6Gsaf?=
 =?us-ascii?Q?APYT+00XVoanyVIM6la9jKkUlQfTnt3O1Pu58+Vw06Sox9U/nm1KZgWlROAe?=
 =?us-ascii?Q?VgdxrxB9thFhZ+KKBmNemyzdCqk4OjgmHIm+1PBiE1KnCrva6M05o5H539WC?=
 =?us-ascii?Q?Kc1gog2ucDVjWTzQgtIFvSA2hswDK4m+FBhvauir1lx62Wv3F5Xz24v4uTj3?=
 =?us-ascii?Q?p1I3GjV4Uv5+kRazb97eHDnyB8uPS5fy3wJ3Nnljbk3faTz6hzlQ2ITs2q6n?=
 =?us-ascii?Q?eM/CFvOqGrbEMd6U4ZXCA/naF9M/3PKf75gXCN3SPdErM/duOVE9FBYyvuwq?=
 =?us-ascii?Q?UJ8vFnbqZpcAJWZsosu797/djqii/W2GlEqd+1a6p63yDt/pQVhhTmtCeUiR?=
 =?us-ascii?Q?W3STG2Yge6j3Q1FEaDSAlebydJ30WLVmpk1wG0Qt1b48Hf9buf/bTfA8g8Va?=
 =?us-ascii?Q?KHWXlcCpYntYLKmoFgfIQnDuP/e3OKyg5SBywKFfH4hE3TYPlJdV3WoMlvvP?=
 =?us-ascii?Q?FkZvaP5zv+0EbprhETLrk8QwBKdSf/DiKgSgZSiPl8AdlXijg019lWDjhSkI?=
 =?us-ascii?Q?JD5+avhOAfZWki8bZCImAkj5P8scyYbW7UVNwnWVuhRn+IRzPJy+wkuChXSN?=
 =?us-ascii?Q?xRywhn6mQ6fq2E5gsw964GLMXBL7w/NpecMhh95vzHDmNaPoUBc0si0cObJ9?=
 =?us-ascii?Q?2LTxz9Oba60ik+rAfTLoWZ19ZWEFFRXPllKwtJaegqmMVvDKS30NRaTb5pHP?=
 =?us-ascii?Q?vJdB7w23JWUIqCck1ozwgizf3aolh2/evo/hytiwUzypa5ZRNflakV18Qxy0?=
 =?us-ascii?Q?sVvTp6EqNJTZnd+FiiwxYD9a2SYEtEJGE/qihd5iYHkIQthNZlY0AAsLRQ2Z?=
 =?us-ascii?Q?NswvQVDPG0dvxEkiu/w7JN3pMGD02zD5KWwYgtQTqL/6WzKMb0cBZNYK03tL?=
 =?us-ascii?Q?qMnyo6WvOqD2omjdgwrq/G+yEqxuyq1vMRjHwKwYr+Y/vpYoigcibVmlQCoQ?=
 =?us-ascii?Q?uks0BGRk8rIZH53v4aqVOs/oNpGtdxMx1TxIyPDDtZB7L1Ov8VQQNepN1GYI?=
 =?us-ascii?Q?LXwqtfzeAf2yWFcuFfxeI7FMiGDOzmDC//yQTb+Ebb3S4yLVWyQ2e/5fkOc2?=
 =?us-ascii?Q?wNDQoQZZSC9jne0MAJlDPhft7Ox1CfSZxbrx/Iag4WvdQ/52B4ZvdcVCMghS?=
 =?us-ascii?Q?3HW2IniOBMmKBaW0vfiuttMicJqzJUEbpAQDYzmNMFYQ67gvuCHOTqlA2Ya1?=
 =?us-ascii?Q?8C9MTjfy4oi4+qAAL83Wt4qBzQ8ihcDtru2e+F4SKY1kuZyGGSY5BYfQL31R?=
 =?us-ascii?Q?OvpJRsZB8nWakMEmGZrsZ9w5pD/WnvaDIa05mScO/2ph2dyFJ9TkK6SoXVqN?=
 =?us-ascii?Q?YCm5a87BpzAaAE5HKbuP2xCDpxhgwdpVz8V2HVtqOpiPIu5odoRnAQKWUrEf?=
 =?us-ascii?Q?P1OgzYpgJvKcQ668Asw4RrxVl1zJb+yw2GB4ptuoIHWkkGRKqkJLNKpBmqoC?=
 =?us-ascii?Q?TJTfosLiOes7zt7fTGTJcneTO303qJfNI/ohBTCLiZ3sVVx+s/1tkgJ4yfrL?=
 =?us-ascii?Q?argFUEnCJp+8X7f6QIL+UqR85dDqgrzJIReM14uv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f119db9-765e-483f-db80-08dade804cf6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8106.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 09:39:45.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCjY4ZVjWjRzeVlDcXsreEeWLhVnZkpYRQY+Wp/efFvUdluH9jMaejmRzP073Vt+OY0PKxNLGoJt0rPg4GyMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

The hibernation mode of AR8031 PHY defaults to be enabled after hardware
reset. When the cable is unplugged, the PHY will enter hibernation mode
after about 10 senconds and the PHY clocks will be stopped to save
power. However, due to the design of EQOS, the mac needs the RX_CLK of
PHY for software reset to complete. Otherwise the software reset of EQOS
will be failed and do not work correctly. The only way is to disable
hibernation mode of AR8031 PHY for EQOS, the "qca,disable-hibernation-mode"
property is used for this purpose and has already been submitted to the
upstream, for more details please refer to the below link:
https://lore.kernel.org/netdev/20220818030054.1010660-2-wei.fang@nxp.com/

This issue is easy to reproduce, just unplug the cable and "ifconfig eth0
down", after about 10 senconds, then "ifconfig eth0 up", you will see
failure log on the serial port. The log is shown as following:
root@imx8dxlevk:~#
[34.941970] imx-dwmac 5b050000.ethernet eth0: Link is Down
root@imx8dxlevk:~# ifconfig eth0 down
[35.437814] imx-dwmac 5b050000.ethernet eth0: FPE workqueue stop
[35.507913] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[35.518613] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
root@imx8dxlevk:~# ifconfig eth0 up
[71.143044] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[71.215855] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[72.230417] imx-dwmac 5b050000.ethernet: Failed to reset the dma
[72.236512] imx-dwmac 5b050000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
[72.245258] imx-dwmac 5b050000.ethernet eth0: __stmmac_open: Hw setup failed
SIOCSIFFLAGS: Connection timed out

After applying this patch, the software reset of EQOS will be
successful. And the log is shown as below.
root@imx8dxlevk:~# ifconfig eth0 up
[96.114344] imx-dwmac 5b050000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[96.171466] imx-dwmac 5b050000.ethernet eth0: PHY [stmmac-1:00] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[96.188883] imx-dwmac 5b050000.ethernet eth0: No Safety Features support found
[96.196221] imx-dwmac 5b050000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[96.204846] imx-dwmac 5b050000.ethernet eth0: registered PTP clock
[96.225558] imx-dwmac 5b050000.ethernet eth0: FPE workqueue start
[96.236858] imx-dwmac 5b050000.ethernet eth0: configuring for phy/rgmii-id link mode
[96.249358] 8021q: adding VLAN 0 to HW filter on device eth0

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 280a9c9d8bd9..1bcf228a22b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -135,6 +135,7 @@ ethphy0: ethernet-phy@0 {
 			reg = <0>;
 			eee-broken-1000t;
 			qca,disable-smarteee;
+			qca,disable-hibernation-mode;
 			vddio-supply = <&vddio0>;
 
 			vddio0: vddio-regulator {
-- 
2.25.1

