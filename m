Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BE66D9C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjAQJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbjAQJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:23:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3A24137;
        Tue, 17 Jan 2023 01:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOnw+XVRtWitjd+QJ5Hevy+CUpvfGh2O7/ExjI3Hyv4UV8Vbgqx1Wha6Tbge/18ZzjmCERVS0c0GV/nOBZqpNAoUG+76ZjujGX6ZdHz5Tdk3HTtQOnSt32Cmyu/LsFNPPIgB0EClxwy6W6+wG08FVRbOD4SDC4jq3xeNDKOE6jqvz5qWtVJgvAgeNl2QHE0hdt0B8aONY3VcisN0lZtYuqEB2dj720SbsecHE93Rh89NnpKw8cvVfHzmSLZZTWCIOqVpq29XP4A4/P2qjRyq3LRH1Z95KmvdYIHT0yIciY5hFCp0j4MHkEfpDISdzZupRDpv++xHjowvJAYTjoDeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ4H+g2+FR3r9dFt+Tiyg+onDMrCrThJ7dOrXpzVnxY=;
 b=Ii3XPqFci4GMEy7XD4+E/ZE2NVUahdJv6D+9jIzvdljALv+f6tsbH6Jr8Jox0wo3YwmDunY3jRmQALr1MytsjjdBkc97C57szOXxEIjAIiez4tIssOQltKp8LImr3JXXg5Ar7GUghCNSAGPt0AUf+uV7S7Av+xloKEtzA8JzHEau4SAI3FezbEbMcUOpQkYQMOvfIOmQcHIc+xYc37m69pL2/xwrvLVzp6zSFeJq4g8LvUf7fgaBTjIaijpgH/JDVzw2b6IFfKx5MZWnfVoe5HWEVWBzPEU0ncU7jReU5CuHQ9qJ757ze4fTP+1rfi56+21hgi9szdw4asVmG2YyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ4H+g2+FR3r9dFt+Tiyg+onDMrCrThJ7dOrXpzVnxY=;
 b=GoKl/bzEMCuWjcFcSTosYdzh5srsK0Pk66znA2aGCGwws6cAuij6Ejsov7oQnSKJrKlf7zi3w3DFhg5RD8WhT5sjE9wtiP0f7wEugwIK4Bk4oh4lxJNisOTeptm7UHavd3K83rj6+dHgAq4fgyXvnWFzy/TH2QnijTccAZ1jJbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 09:20:21 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 09:20:21 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal/drivers/imx_sc_thermal: fix the loop condition
Date:   Tue, 17 Jan 2023 11:19:55 +0200
Message-Id: <20230117091956.61729-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:803:14::35) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 339a36c7-4292-432f-b9a2-08daf86c0e4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UtWgI8AgtXpU7g6EcepeBk+inELMGV96JcccQvmIY0b82VHPRUOd2Dso/0+BSUNSz14wE+cmU8zCn04KcSstBIB/QT1m8bqjCm077XnQjOmVtzA79f2GSEy5FbHyNKVvJBVYxpXH8u7BenPMUozuF7Lu/D4gP2Xkp/jtjTKQ/jMBBhn8NRrPWuQPCsQbgfIwnOKjHTXb6EN7dmaHA+z+ZyWUvmsca9ngkkzpaFtr+CmdcG+d6ZzD4a5sMwHUOv7nFdF45Hx8bK5GZqp0eVev5v4C8e5A8bus3b1pOnW61WCdKG5+qQR0LRfu/nr3KmYrDkHW3/3guk3cZScoRkw7oHGeoFGXnXnya9K5uO78dlY5bHayrcnXYFdsRyP1ABCjT+rzj5NibalWA8SrcYN/sjdt8MKwgKAF3iPiQG+DLBwy0KlSYqPwijaCSVkz16b0RX0G3ks9OoG+tIwrGtkaR9VBvxYP0hjeiXjA6tbuGTZ5yvf9rjzGPQhtoruRuCEbFnCB61RrR1vmxSjmOloVXgEPE147/gTpDIKg/3umNANyGK3c1+lBc58dbXsgdhC7TbYwchSV9nr0qIuPRN74DTwXSh6Bs27OLpaIzh3D0/ZKwN9UA2zIvbXF42rD1eT4+zKQ2WbN/26ioKvLFmUMRGNuL7C3KSpT6VpDuJ6ACTgZVav5ym4Y2Y/IFl2UsJ/S3Rmwy8apSVGgX1bULnBAVscIXmUjASylhn0vE+W5sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(83380400001)(110136005)(6486002)(6512007)(52116002)(478600001)(921005)(186003)(38350700002)(38100700002)(2616005)(1076003)(86362001)(41300700001)(2906002)(26005)(6506007)(6666004)(8936002)(66556008)(8676002)(66946007)(66476007)(7416002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OPjw4plVjo/ULNpgXSwZUQZSAl3enmj1EYziu4xB4mIi/e0jyd7FeOg1HJrt?=
 =?us-ascii?Q?fyD+icTyxP1PAVHBVwyWc977/+FG9ufiuOqbJw1eJCqEeyKaR/Vg65gOD03r?=
 =?us-ascii?Q?7kjV3DpBEny7DEOFoiTyFkWVBlEca1yLEY65m2hnCsFYTWzefFZnqyk/g7uo?=
 =?us-ascii?Q?cRmNORJ6jV6P7YP1f5WDl5uCWc8kGvsEYCTX24mLLCMrx5vX1V168tO3p9As?=
 =?us-ascii?Q?b8g8NVijD3xfu/6vtcUSx3ryA1IVeRkkRqCCW6yxDRo9G3P9kRLOcRsr9rkE?=
 =?us-ascii?Q?Dvs04bxDTBbz/sFSyy6H5aGjRQmSutZfJe0sSH24WQrRqJdXfOQRTMyHuAHn?=
 =?us-ascii?Q?K60EADuZy1HCReWCzdafIaBSLJ1HtJNlFVc2r7dtuGELixgnvZgeyNoJTJVY?=
 =?us-ascii?Q?qkhY7v38KT5kvEBD/29LS/JzxSTpPGz17HnUhgly/VHGjTj89DUk5ClNeQEc?=
 =?us-ascii?Q?E96huXkBzQZb1oWO5SKP4PXWe6OBD0gq9OB87OIvi/t3/MKLGBO7Urwzc/dD?=
 =?us-ascii?Q?jIt5JmqGkOqdPV0f8J92EjfPTZGX5EgfZo59KbtFu/3OTPfDuhfaMOZ1HTUA?=
 =?us-ascii?Q?gPqDSuA7YbyQmHrr73Ljz2mhRp9YqZF4BvtKC8BrCuj3W6Jzn7/br+3uIJF2?=
 =?us-ascii?Q?BMNgADrEQqgfEecLvLVy5h44I6kUSxw6NImucP7wXQlFwCl/zaREh1kJk8l4?=
 =?us-ascii?Q?w5g/fCVGgCUSCFm3RZ5e30ekcsWsp23Yx6hrks2wlENQAh3GDGarnA1iTtWi?=
 =?us-ascii?Q?FUk8viwOjoPUM/wtJWHqHUq5oNimaxWWxfC42DgDNogjl7jwIEZpPLGVMDVr?=
 =?us-ascii?Q?mlgJ5NlPstF5ai2VMmPWLXxBDHJ4v1KFCrfD8V+B4u3Txp0g7mlgxKXldkKg?=
 =?us-ascii?Q?g+BaYqncZPJV8rMISYaJuih2vddE/k27xgst1PjbZOXgYUraxNk8FwNKmei/?=
 =?us-ascii?Q?lDa6Izh9zcyJC1c+phZb47cf6wCP3REiwB8CuvbuPxlmjxIkudQpG5LggaRW?=
 =?us-ascii?Q?PGYkcTBuyJVmsiA1ifjmToGCLdxo8cqpPr7XielDvq6s6V1j7QudjIkte9u3?=
 =?us-ascii?Q?YpGGOJiPm/uILpMKuoLttcD3fgSQQFc0IIlxMLYspOPm2wFCjrRaGsJy16L/?=
 =?us-ascii?Q?eMvZmmoSV+KJVIeLL+UAS81PzDeHQEf/iWlUzkxbCUXxrRQrvmn/xv6va5+K?=
 =?us-ascii?Q?PNfibXdJL1OJzDo/9d39yvIpeQ3zSSPPkrJ+omWC3sa2z3JHrk05zM8V9o9K?=
 =?us-ascii?Q?4tc3ygEe7yJoaDGYKTz9rQgLdKczWp8/4Ts/0R2WVKJw9SWiG+YyGEYPE5Oy?=
 =?us-ascii?Q?IEbWCTOn3LAilJeka62MXQf1bfxcOQ64hfgWNb6tKSZsgVxfJ94TFMjtl4gs?=
 =?us-ascii?Q?/P6X9LgJ+4kEhYwy0vMbbWq2dP6ckB1rL1eH1aQEhOwiztvXufWDvKhzbs7N?=
 =?us-ascii?Q?DuJxx6DHJkefWKM2SAyFS/NCx99wcgghPj8Dn+OXmOThVad4akK2ptJZ5g0r?=
 =?us-ascii?Q?cRA2pnjD8jFLBEGrT1x2JnUi7oQNOOk+vYiTSi8eh3wo7PDhoWH2GWYFZjQn?=
 =?us-ascii?Q?mUUH/kpE22XlUGobYONB2MtsFQRrX08vdeHmkSIvjr7ZXDPqsubFiBf+Tmz8?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339a36c7-4292-432f-b9a2-08daf86c0e4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 09:20:21.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqXCPGPk8hhTsn0SWCxfzsRhhNqU+m88jN8gsj9uY5w4hz0gHvCzJHMM2uKrmhenpiSLy54m2kftwB6zECIcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

The minimal resource ID is 0: IMX_SC_R_AP_0=0, so fix
the loop condition. Aside of this - constify the array.

Fixes: 31fd4b9db13b ("thermal/drivers/imx_sc: Rely on the platform data to get the resource id")
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Dong Aisheng <Aisheng.dong@nxp.com>
---
 drivers/thermal/imx_sc_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 4df925e3a80b..dfadb03580ae 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -88,7 +88,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	if (!resource_id)
 		return -EINVAL;
 
-	for (i = 0; resource_id[i] > 0; i++) {
+	for (i = 0; resource_id[i] >= 0; i++) {
 
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor)
@@ -127,7 +127,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
+static const int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
 
 static const struct of_device_id imx_sc_thermal_table[] = {
 	{ .compatible = "fsl,imx-sc-thermal", .data =  imx_sc_sensors },
-- 
2.38.1

