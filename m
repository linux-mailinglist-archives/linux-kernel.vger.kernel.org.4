Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01EF6F890F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjEESxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjEESxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:53:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DA130D6;
        Fri,  5 May 2023 11:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMqtFkSsmcpwCrEY6603/61gIOnyRltfVwGpyk7v1pH4264JzRyQdfuoKTzEclk7g+H3SgD0ViMCygOZ5cBgvRzHpQzsdE/m2k7NxIOsdDiYwL2EhaME+Fuab0434OXjakc0UvR2YO6SSVBbE2opWIELopOWrdYq/RGWSpoSRK1x3lNp4EoTmRczs4zXvGaKvex1S1OpaIsexr1YpytPyGNqtMe37fleFWegr1kuG86mIaRu1x56LxXAgeLV/boaZdGAmAf3+eC2F6+TIW7tDxiOq0H6kJ+hJusIlQBPfNWRDcQj/LcQ0DE+SGAFOllkY17MHztXqKJYPZCnqesK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H17YH8D3prWN9qaM4RX078K1Xg1rukN5XHrFEfhFGSE=;
 b=UUrjOUpNlXPvbraOjM4rsBPQ/J8iK7dFdt6cfYxYmD8VTjfmZNplLk12gMSTzPLp+rWIAHvR+VqtYjU8nI/vEcOKsp34rw2qsAxZIXOo6osduJGbSX7MXoSnLwg+x7s8+n3IzTVROPBtRyeKkvQWY9KymwMMtiqvjiGgYpugLHfKAu8zU31YKWck+FRPFuwtDCwQ5O0LfUPSajpyw4Xy48+Uf0Q5gsiHs6apCeHwL8sZ8RsgWtrDZB/Hc1D/686Gyml76gu8IiqOoTgaBmqD0xLe3GFuXQRfgi/xlZQA/4RgDHGyuCCN1/KNWsA1u+VkW4kMIplOfb2u41YFMVDt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H17YH8D3prWN9qaM4RX078K1Xg1rukN5XHrFEfhFGSE=;
 b=cc4KYMf91RZ0Ef5aj5mf0Ou6Wm4MIvG8vXFBG6uLaLrcUqDltCEORi7u2Kt5BeMRWH3N5utrAiCgLeWk69CtN09g/yMHrnjjL9aAoq2YVflZIVO63oGtP36j9M61/Lw+mrKbe4W3yXhTG+3h0st7gLC8jRsyFwLDVKa2wDuffTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9894.eurprd04.prod.outlook.com (2603:10a6:20b:655::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 18:53:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 18:53:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
Subject: [PATCH 1/2] phy: cadence: salvo: Add usb2-disconnect-threshold-microvolt property
Date:   Fri,  5 May 2023 14:52:46 -0400
Message-Id: <20230505185247.1854677-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9894:EE_
X-MS-Office365-Filtering-Correlation-Id: 690dc766-0ab7-4382-bb37-08db4d99fcfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1UD/guvWabD6XYKaf/JETJMjJqln6oTh479QzJSGywPhv1Z8vRVL8GYGLjgu02KwISdgaR34qWesLNaaUFcwnGvTtO5R5yUvqLpaKatGQLPaYPeWBW7oFcYtAMxthrPhKGVp+x2ylD0jkzhWcdZLx0MdM2GVdajZnhRAige4fWolrStsRUQECmKDxT94gBrHL9tdEwId6rU305LZIJAsDHARETD+NHIpDWsHluO45xO+08CplYMesZ3iSRb6BFImI78kAEVpqJKiQi2lSQHuEmNrE1swVfpqOSsv2hk6cZ500c4LeL4FLqiF1EfFkKJOtWmIflEuYIoLX9NsiseqPGwGtnII6+qLCtGGcU30UF61brPsyFAZbKSmP3wVyMnx4jujplwi/rndEZY+MTKINDpR/i8lOkSZZvPkr1JKo5hYcBCXPpSmPuzaCRz4HHQsxUIyQjn1d2zGDtbbQzL2yDnVzVJ/Y6qKBdR1eVtOkcu42wGYB9qBir3aGi3yn9kLUassz2hGvxcDTwZzyhFo8msr717Mwp/kYPfumV7fjHY7RmN88v+4ktCl2mXaqcyaqJx8Ng9HX7aHEFdISZrsbBHKAcGskCsF2wayGGFji4sbcRDfHOvfIEEJ5fVNye5QXSJ4lY8jpt0t5EZeFi35A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(7416002)(5660300002)(8936002)(2906002)(83380400001)(8676002)(2616005)(36756003)(186003)(921005)(86362001)(38100700002)(38350700002)(1076003)(6506007)(26005)(6512007)(52116002)(316002)(41300700001)(478600001)(66476007)(66946007)(6636002)(66556008)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVREFqihoF/9Y/+5VFmSmGO7mSY6LeXB6CNKuMU80Hh8omEU1G0H6zyn7PBN?=
 =?us-ascii?Q?pqdKbF+yYG6Qwjk//oRMhVBpVyl8VV/1Vc3T6BPgCHlqUu9haw2YWxbRmfgi?=
 =?us-ascii?Q?c7IDKgaFVOq4pGjnNSWWaJFE5WwHKzEVAahIFcd+2c3re5UuVGNZTe8AdeqS?=
 =?us-ascii?Q?+7HTZtiEis7IatUDbWKOlGGns3N9xJTb7Wc+goQJGeK2Kbf4CmmcWlOkgMcd?=
 =?us-ascii?Q?/+2b2MyJjuNZAcSOKouPP40qO+JPcrIj4zAVWrPFEriJocDQEGVB30mHZcfE?=
 =?us-ascii?Q?7PRQ8zZZDTXgq6CoKykQXthTPg6q38pFLrAA1T6GCNcDoygiEcYQbdwJanYE?=
 =?us-ascii?Q?fkHJOEMV4MCLnIUQuqrOv+WDr30BPWLsmT10UEWH59StaacTGJHMRj1DsMNJ?=
 =?us-ascii?Q?G2Btm2QeN+wfxwpL/1Sz31loytvgh6QNxPLL1yTIPNxh/t40YRTegWdAhTgx?=
 =?us-ascii?Q?ACk1B9m+6204uf1tE8LzGtTEUpZocC3AqPi8+PW+Etxo8BOUREW/IvpkpK6S?=
 =?us-ascii?Q?yHIwyKDuhn/OUZ7cWkgggmAOoqqV9OT6H9/i2a8mnWP+svaVOGDalvyVVoI8?=
 =?us-ascii?Q?iy3Tt363+qhtkhmlDJR/n/SaH0uqcyenukCa71t2yk9CiQTfcgwe5K7e0OJY?=
 =?us-ascii?Q?E+1ZX7W5DkWCMSXOxXGHOQq8sMEc3XI2okBIA7aMZ+gLBBFisMzEU/IIMzy9?=
 =?us-ascii?Q?SrqQw0OmnhcQbH38PT279Og2mBk8Ec0eXAqW7XGfxjJGulef8wCvfjhPFt9w?=
 =?us-ascii?Q?yCw2Unso0AaSIENBLLt11BAbpGe/3I1nihxQKOegRf5qnwkoTKOrNyaXsiDb?=
 =?us-ascii?Q?S/sepSwll4rqLq/ue783k3m+gPjd5yYRe0QkbK7tIIxM8QCNcMHwsOtQvs8D?=
 =?us-ascii?Q?daMxa5Fx+5mwt5DHuqu6sGvcZxNWdEbrpAGChMI9oP+I4IaTanUX8inr5nbF?=
 =?us-ascii?Q?eoZ7pb8/YMPAoi7nlzKtvk8LH2jX0lSiYXf0fl5lTbWNPBi0tT6jUUDE1sWM?=
 =?us-ascii?Q?3mr9/hnkWTaXct/HNXv5QMNcbWynXkC4LL3e2XSoEQuYkN5ZezxwQSD+EIBz?=
 =?us-ascii?Q?kVIEEm0JEuc52PLtQL4NgLCs6Xn34ttj4rkbAofrjbK2qd/ZWZmIUb6zw04a?=
 =?us-ascii?Q?a0iM0ccwBJdNhXh1VtO8u5/vBeEPyNoc2I/TRw1ISuM7pi/h36PD+t+0GX8J?=
 =?us-ascii?Q?U6iaCifD2Ju5+CugqJJUSZF+0EAi9LArA+FJJ91zdpoQmXDb9ZodMRuzo3qI?=
 =?us-ascii?Q?x27YDjtefTmmnUOaSWed+RZQbCEMLX6JqBettOBWZYx88PC1/dDEBY4isnKm?=
 =?us-ascii?Q?751HgMOTRDQ6nycgBhgxyYnwPWotSOBv0HxLOfFSg1gaKfMENGkihXgLxAry?=
 =?us-ascii?Q?3+ixIFORPi/jglXRWp3UgU5DhPDoE4eTj8mhXqMVsPCNo4lJ8S19QtGKAFQO?=
 =?us-ascii?Q?CZ4VKFLS6bNyv2iNohSfzqQzGjw0DDzecPLP5DRpN4CNecy4tWG1Bk1/yH6c?=
 =?us-ascii?Q?TulVb9cQNcT5vY1XRZICSXqyb/olMNkca4UHQ6cTI0n8NjRGUOSo3crAA+UK?=
 =?us-ascii?Q?En99o/PKIcloV6A31sJJjkLX9bVp+QU5GgN613Ms?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690dc766-0ab7-4382-bb37-08db4d99fcfd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:53:17.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OuiS4Ruj3fMLem8kS9G8+kEcI8VCMFEltiwb/hBHxXtxA/mqmn0ahX0Ecjdh+J7R1/ZRWxDSFnm4j+KqDFkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8x-mek.dtsi |  1 +
 drivers/phy/cadence/phy-cadence-salvo.c      | 30 +++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi b/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
index 2f8fe59fc131..6a396844c02d 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-mek.dtsi
@@ -1051,6 +1051,7 @@ &usbotg1 {
 
 &usb3_phy {
 	status = "okay";
+	usb2-disconnect-threshold-microvolt = <645>;
 };
 
 &usbotg3 {
diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 23be27a747a9..06e705dbbc3c 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -5,7 +5,7 @@
  *
  * Copyright (c) 2019-2020 NXP
  */
-
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -91,9 +91,19 @@
 
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
+#define UTMI_AFE_RX_REG0			0x0d
 #define UTMI_AFE_RX_REG5			0x12
 #define UTMI_AFE_BC_REG4			0x29
 
+/* Align UTMI_AFE_RX_REG0 bit[7:6] define */
+enum usb2_disconn_threshold {
+	USB2_DISCONN_THRESHOLD_575 = 0x0,
+	USB2_DISCONN_THRESHOLD_610 = 0x1,
+	USB2_DISCONN_THRESHOLD_645 = 0x3,
+};
+
+#define RX_USB2_DISCONN_MASK			GENMASK(7, 6)
+
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
 /*
@@ -125,6 +135,7 @@ struct cdns_salvo_phy {
 	struct clk *clk;
 	void __iomem *base;
 	struct cdns_salvo_data *data;
+	enum usb2_disconn_threshold usb2_disconn;
 };
 
 static const struct of_device_id cdns_salvo_phy_of_match[];
@@ -261,6 +272,12 @@ static int cdns_salvo_phy_init(struct phy *phy)
 
 	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5,
 			 0x5);
+
+	value = cdns_salvo_read(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0);
+	value &= ~RX_USB2_DISCONN_MASK;
+	value = FIELD_PREP(RX_USB2_DISCONN_MASK, salvo_phy->usb2_disconn);
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG0, value);
+
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
@@ -315,6 +332,7 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cdns_salvo_phy *salvo_phy;
 	struct cdns_salvo_data *data;
+	u32 val;
 
 	data = (struct cdns_salvo_data *)of_device_get_match_data(dev);
 	salvo_phy = devm_kzalloc(dev, sizeof(*salvo_phy), GFP_KERNEL);
@@ -326,6 +344,16 @@ static int cdns_salvo_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(salvo_phy->clk))
 		return PTR_ERR(salvo_phy->clk);
 
+	if (of_property_read_u32(dev->of_node, "usb2-disconnect-threshold-microvolt", &val))
+		val = 575;
+
+	if (val < 610)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_575;
+	else if (val < 645)
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_610;
+	else
+		salvo_phy->usb2_disconn = USB2_DISCONN_THRESHOLD_645;
+
 	salvo_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(salvo_phy->base))
 		return PTR_ERR(salvo_phy->base);
-- 
2.34.1

