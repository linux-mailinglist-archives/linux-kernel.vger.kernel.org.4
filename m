Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8B605BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJTKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiJTKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:00:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3836C58DF5;
        Thu, 20 Oct 2022 02:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYAQmmBiZovz8kxl9H0E246MkZPrzXxRhpNEh5Z8vD1zU0zloHlJnUDHBtxy2TJZqiwvr3gOjGbSSMdtqTftUONQNww8ghRDjWchBf+82uRAd7C+RjGpYSQs0poy6p6iXeKYVT7FarTMRJnvaYf6yM37K4g1NBbK/A6EI2QXkkxlptozu1zLraYtoN0aLXAmersP2/y8bdbwO6bkOA8Bb0oWXIe8fp/4RIiUtTSy+wHjTn7r1q0Z2uRgWIOi6mR46hpGIyp1QW7aHMgdyI8dejCw6xAnN+mekV34evyNBiMTEWv+FpJqjBrzECq4bA0NJ/3c6UQ9+j9NwjEo4eiUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0KHNDTrlzsRv2IeFktyEWpVo2DPB9ick5yP6XVdN2M=;
 b=BQybJR5gWt632V7ZiW2KvDxVOx21stkFhco5lVYx98P01kiqI/SDLbIzM7NanmSkfimFkKuW5Ii1+omZS+uZ/kEco8V/4wn1lxTZRRtGvTo/ZTbM4Ip9sYVZrAaJYvOrSboFcR2K4F4nmE48iL6ImPUISRNvVvdnrc1gFL8hV5g7h4PCJr35YyUEgc41uojTDQeEx1UPKXgxeYCfPwGOdqBlObProUKO02PvV/v2ix/kjoe4UNA4MX60Azz6jeu5otfYIl7E3+TqwoYwHhvHbFGSOTrskPD9bEUvW7wg2mjLz/TTEQeBNERDpgI7M2jzQvzU/h54QmS4zkzVtxCV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0KHNDTrlzsRv2IeFktyEWpVo2DPB9ick5yP6XVdN2M=;
 b=BySFd5TB0uU8Jx5eb77DpwblGoX6DUIrgQEirHrf7GjPMii7S2c0YsAMFvRo7mI+Y86BpqcQ9Gqh9qVejde/6q2AHA+3IK+Pa6J5Q1pFy0zeE9nszPZqNuFoazp5f37jpcPeu4EC3FB7zBvJ6TeBeKuzKFy9j179RhULCBciEfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:59:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:59:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 14/15] arm64: dts: imx8m[m,p]-evk: change to use off-on-delay-us in regulator
Date:   Thu, 20 Oct 2022 17:59:33 +0800
Message-Id: <20221020095934.1659449-15-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: bd45f20e-4887-45da-16da-08dab281ba3e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP/XvzkhSgF8u8EVXRmLGr49ic745LskkepwOjAn7XXzAAZ7m/Qpx5NZVRNd6gyqZyw47VfCo9O60WGmunlCqLqcd5RH80/0uhlpqTNwADDF/0agm5bAvAC2VXg9tu/8RgKw8NsjNa2IZiD+EuK9ItYFBnxX5R88EWTRp4Dn0YAkzzeTvNbwqq2y35jSyCfNJVct16yD0++6LyCHIs5oSPJqBHHDVZsQIo515zALZKaTeNDEsG8EabrFNpiFGTJl29uy61eFt7ftMBSvzR5w0MyynHsm7p3qk7ppEOXGNOCyGvbiPXm5aQU9dP0jFL8B4yhD31NKc93MNaZNo54oQx7TaQxX/960OGX+VByWjEiBXPAZAEszQa5MWDRvktdhXb723vz8YteMXaLgOAdpzXe2UarkmB9Vi670rAN/uyT/8QpwD7brXiaosKB/ETnVD4kXNs0gOp+JeFjjKtbjOTSlqNAqvdg4px1uSryd5V4s9aJ456dKUWym/H2X4TFXVGHQaKZyrTcdPOUBbT32nxQ4mBHdMdXktqw5CsWjVCLu1JhptAKRcSpAvu4g3zM3UMxgSLhibX9uikCJr3Xp3aMD7fyyvhW9iK7FngPoCasHWxnv9Pa2UlUb9ZLSqC2b259AzKLM8iVMSAL2ts5DgqFBqjJnmGNVDZf3uxHIrAi/mM7LjerQffk8v9xssyfdE9AkJxdHprEBG1kKKCSieWP5XyGm7J0BPHRYfctzn5GLkJ1GwgoPnlkxNSELdkJejwGqeFr0audQbtunc2mrGr3sfD0cG0N2yBBzz3PyNqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(54906003)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVi7o2mzjW6Kh5qAMkww9H/Oph5CgEvt0FsybBElgpJDZT8LKnKxS+yPNPJD?=
 =?us-ascii?Q?363FBVRdp6+EkFWoqIDnQWApRUEdIFX+8CRJiRf1mkTvZgzHTK041FD9j9Jg?=
 =?us-ascii?Q?GbHPZRyOI6/7T6U9ew5xlTVqlqNgXvTkbe9GShSYgZSJhXnVV1iLjcQTNkCW?=
 =?us-ascii?Q?nE7gGX0np/PBCFwnJ3z49ugKhU9RAvV9zropBacIENzJo9FRmCzOAolWlaCw?=
 =?us-ascii?Q?IMH4SbAioaM8Ep7KbPAL8LraCc/qFYlX+qZrDJ0SEY3K/yZ8uDCYT2R4W9KD?=
 =?us-ascii?Q?id9chf82/rXPxy3j3wYOygZdrFeAQZJ7jGsEFGRcvXESTIWqzcynaW2ztw78?=
 =?us-ascii?Q?eQQQGP7YXpy3ZkSgZPpSiP8VWu2sHbVoqPSR5MFvj5tcDrm/6dvobgd6VbgU?=
 =?us-ascii?Q?jZP085TSs042N3PC01bzKUmRzGU3C1oV5iUEZNeRWtH/quVZN694kDVMAf2U?=
 =?us-ascii?Q?2+WjMZJjbOQ65xbvFEgF8XARspYEximue59lCM3ev3dql81FFocpcovy17Gb?=
 =?us-ascii?Q?zn2gT4HzQiy2cXYPpxrHE3guDf7LiaLMEthRkMTrB+xBTZmydNqDleKehGbe?=
 =?us-ascii?Q?OlN/LR4sv2Tl8Hnqa7l6jE+NDFUN2qdoz6Ga6V+vn5x+WfNdUUcJfUAHqLe0?=
 =?us-ascii?Q?tDZJ1aX5hK9+sDvgDKXCcigEuGxSaFlGDgyXHLg9MKAHtPye3c8MbD55Q4AO?=
 =?us-ascii?Q?tqJYDwpDsRMVSk4BMTIP3OK6RsqylGsWJ7ix14QelQ3EWcQ+FNTRWuzOzc9m?=
 =?us-ascii?Q?YtViLN7l61FnBf3IwSVDnyVR4fBCJbs1JNVhBov03qDiEZQmr69Dv6N4/Dcw?=
 =?us-ascii?Q?mfcrMx7/wWi43UibLkZIlc0Eg3xOJ4SXOV6CtnY3MoVJ0yiuFzpUChNE5hbq?=
 =?us-ascii?Q?4qbcpgDj+kq73HwfUXYmapVonBmW/kHhGVz/u0xcEPEXGAYpEIjAt/Dvw2b0?=
 =?us-ascii?Q?pxwMGykVKtA8Chn5EKFLYQyLsUQjSlMUva0ikp5DKlSjFOuauJpOxYIO8rKS?=
 =?us-ascii?Q?8H1+hoID55b/QjHkCgFVbiiZsstUyFjN/Q9BpV6DbC+XyeCU1JJ4ZKrJcMtX?=
 =?us-ascii?Q?LyPZj1xWmtQTc81h6WaAMnvjmyRdYoCnV/f5pOt3VZCMyHO4/kxUzixDAEFd?=
 =?us-ascii?Q?+M8UurzESDUIeTApXcuH+hQ5Tj2DPESi+py1C2lPYsnRmI1VngutEssRYjgg?=
 =?us-ascii?Q?5dVoM+KRf/f3xAmExqFTeYc02JVfsPlTVkDbX8GJCCDYIgmZNAZZ89BCih8Q?=
 =?us-ascii?Q?x56X8dWv+GXi/zCImHdCAu52cvellsnJvoK044EAYOGJRCHenNVkH93x2W7Z?=
 =?us-ascii?Q?qQe0AD8pgpedeBi1Jj8l+EN1WTGu021enrjZ4wfE7MhiFA+/Vw6tmlrOc49I?=
 =?us-ascii?Q?29dxPEkoSBTWA06qcy6lXBatRKSMwVMgVOu8ly8Fi4GOkgVLNHWNImsBAgfR?=
 =?us-ascii?Q?cN6wkkLqzAqnLwo+u9zkhNfEtfKt9kmB4PStzz4JiSXDAMIIllGHb2y0ut/v?=
 =?us-ascii?Q?i9fNwTRN4EB1xo/Hzxk0lYynJmWeCmD1QOVF1Yh06Mh1GuGuHyyFACFmd2mM?=
 =?us-ascii?Q?d23Rr/o8V5hlcVJ6RoQv1fihaqmfXBXnmBH/YcOA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd45f20e-4887-45da-16da-08dab281ba3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:59:07.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO0jHlSEGBqStQfVG7h3aSIe31YDsSGRBbOhwI4orVve87n026eIL4Z62uanPI2qGnAqgKerjHpaP8cIIaEm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After commit f7907e57aea2 ("regulator: fixed: add off-on-delay"), user
can use "off-on-delay-us" to define the regulator off-delay time.

For SD card, according to the spec requirement, for sd card power reset
operation, it need sd card supply voltage to be lower than 0.5v and keep
over 1ms, otherwise, next time power back the sd card supply voltage to
3.3v, sd card can't support SD3.0 mode again.

This patch add the off-on-delay-us to each board, make sure the sd power
reset behavior is align with the specification. Without this patch, when
do quick system suspend/resume test, some sd card can't work at SD3.0 mode
after system resume back.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index c93387fcd498..898735965ac9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -22,7 +22,7 @@ reg_sd1_vmmc: sd1_regulator {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
-		off-on-delay = <20000>;
+		off-on-delay-us = <20000>;
 		startup-delay-us = <100>;
 		enable-active-high;
 	};
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

