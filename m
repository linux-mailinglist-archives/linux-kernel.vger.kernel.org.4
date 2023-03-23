Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390486C6648
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjCWLOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCWLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:14:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B79EEC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPRjL8fMLO59uGy2sXz7nGN66xOj0sERhu1oRDPeni2nqXLH8sQqNibSzxYfkojPIQeu4On7Vjw6ktR4fhSK2nXp7+oJGzvy8JrTZcxvFyGrVOLPymyKe52zfdazulUiN0/bo3dE3XSHzf+oKUf6sA248rk8XCt7d98ukf7QWYDn0B8rM+ikyi2QfJCL/npYSQ4OZmQw3KJALbDxpL+JfoWWOyguDnYOSFwePu2Z1t/f2PAqKN7yTmCvFPaJK8p6+7GqygsLUmp/KYnWFLlrxmDaREbx4FbphMI7T8VvK2AyZesdDcfd/7LugQSedBMhc68lNHmkH2ZKk2oMDHwfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eixZdGf6tZL/LLeaEYZ1+jS6jWibgMc0cL7KUjXx7Uo=;
 b=TkXljAtrJZ9kgv6g/98mqulSyA0BPFbMmd7ef/DUZ7gD9K5Xl3KkfjEWQ/joJfcLhOngaDHaIHiOxDPVjHg1l5Htg8YtTf7UjrURypnI9nhHqYIcEkCFtSasRJEnvtoYiqdQqJq+gmJ7TOdgj4ATqui6T8DBs6b/upP4sqqXJ8ZaDyhZWS9Hd1JzZ5jg0tzS85/x9Zr7bOriGNE4yT+/liHcXwxJfKhvNMrjd1WeY7ZudDwnrXfE/DIGeoWszUuQFaKLlKmY9BwADi9pDlWb1gnvh39q6n2kXRC4P5tUdJTW6q/gk4doNlp6035CdTcKxODLLi2NKHj8rcSrV3SUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eixZdGf6tZL/LLeaEYZ1+jS6jWibgMc0cL7KUjXx7Uo=;
 b=Sr7sMyX9VPCR0Ga+gHOVupsm+4uieo03c64f8P7f+0ajaByh+BOWUpxJAgRGFCGJVLZdmB+6wxSED/zRYHv4NrkqOHxSZUpuQ5UBuIvbiM6XUL5xCbF19lZyNzGIEv8hB9HxX6d3tsNVBLWVXA8d7/IfUOtclwT3K5ARxkf/W3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 11:14:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:14:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
Date:   Thu, 23 Mar 2023 19:19:24 +0800
Message-Id: <20230323111924.102541-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e162dc-4e1a-4cb4-abf4-08db2b8fc0e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp+Vx+vc2t8wjjwHI3cpyyzoTa5R8P/TZhTt6SMp92PHAINm8fZzyNLIieEWdC0Gelm1AdETnl8ByBARDUnh17un6xhfuJvZ1UuD8CZ8LW6yzn4a1ZU8v2sHhCxD36mfY9KpMp+EhQqnsT1vRDoHcBQEeAG1pqvR0WJV3FIIgF364fI6ND8xiud07mNmsEek2TMlFOu267vfeXQ2cz1FTDWCvoa08FMQRRoNmPA1Lkwe6c/R/VbOMTA2NfladPhCs/PTNV82Lw1Fu/qWB5jmEBpJU/btkS6CgEwdm7p8Duaewb5w3ZRLN2kKIB9L0tYtKQZ8OhiNCPjIg2Hd1JegzVvCFMH7EDu4R8uqKcoxwpXQ30GhvvyocSOxU3QO6UQmGdXdzeuefIkj8DiowUTAHdsed6PFbCfcNrty5r/VnhqAuZs1IfjOFqpxHRdOT0h69FrgOrfV3TElpdA6WQFGTf3zpTX5iv20COmAVZw455mKp0uRkcVONWvwxqP13IGRJ42gEG4GCmiQv8GKCigEXU6M4Ok+tWr+9pjE+c7YnSr37kQzAoR36QvQ9HPh02FrEKtVFvnRikKaAMkbC146ay1iYvzNggJRvv3RbpUrcpVO1WDPH1/v2xfCX75YoTYrqt5RiCIeogFyyiYiGHNu8Nb4/N86eKy4fI8Ycgv0IZGtw4AolXxTEiM+a7kwRiFmVetjfafVtu7/rT9qU2FfPz2wh3yVLqCjccXGDT+dbKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(4326008)(66946007)(66556008)(8676002)(66476007)(15650500001)(5660300002)(41300700001)(4744005)(6512007)(6506007)(1076003)(8936002)(316002)(26005)(2616005)(186003)(83380400001)(478600001)(6486002)(52116002)(86362001)(38100700002)(2906002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzOIeovhRwqUGZFAr+oQ6kQ64T62BzrvryuwyJDfgniDiVfPdBngpMwkQEZa?=
 =?us-ascii?Q?yDZ3TmvPXEYW37m9FKryGNRc0eVGOEiRyYIr6UH2Mc6Hgqa6fyCW/JRKAuIc?=
 =?us-ascii?Q?l0jH+0CVLeMRkXl7yRHOtWCjW6d0KCOOdQ9JClDmhtKnyDs3DK/EJTaXFDd0?=
 =?us-ascii?Q?95Ar0DyIZfuFhSQns3wJjmlPRpKycdhTs285k6lSKpih4hr/VcFp5v3Zg6OO?=
 =?us-ascii?Q?pdIroGBHcNnjQLmZHVZSMZp/XGJUUMUoaltGe5hkGQ5sCrQtCx0zbdxzLXpa?=
 =?us-ascii?Q?k9jDLkbYJRcy4R+Own1t9Yb6jDJIz0hHJSZS+s6yi4ytOIld75kC/B0ruLwC?=
 =?us-ascii?Q?25heMkDqnrSciyZuG892wf6GfY8Q1qWW8Bfcn/+VOkEs15yRWj3CGt30qCA1?=
 =?us-ascii?Q?+7ZWT24aOWLaJs4gl5KSPnENL5ReuaLW6CaZ2mltVp6In7y+X2ishxnaGtYG?=
 =?us-ascii?Q?C1S53iT2ewXh/gTPvjL2E/Iiw1CUuoeAvDp1t12y4COk8zm/bR4NzQaCBDTL?=
 =?us-ascii?Q?tEOj6MV0Px5kIxkn+MfU0K6pRBT7ytVwhpUjOYFA4b5lDAZU8d/SbJOlJrws?=
 =?us-ascii?Q?CxKUtsBhSuhDm0YgdjtMoEEIX/05N7yxTWzaoqpTMZWLUHlJOH2YAXFAh0Uv?=
 =?us-ascii?Q?tHO+PeRKuts2vVwUImjaYQi0rILJbMpd6jrKPbcDhZ+Tq+ddoHYmJvdkMFhm?=
 =?us-ascii?Q?YxvCUSbVxH0Rf/mYeLEfC28mcaHP9tfAsAhReWG9u1U7pvDyuu9RLP07+aUV?=
 =?us-ascii?Q?4uKioDXe4PFYPbdgSIqf00DfkN/broytmDSDMJ+c8PhACANnOMV9K442t+Xr?=
 =?us-ascii?Q?LpCs+H1rGajjwnlhPiQ4yApJRh4Y/ezb9tKuJIfgE7V826FxePN2L9ilfY3h?=
 =?us-ascii?Q?kRYounWBafYDSF2nix8jFJKIYBZbtyUDPTEE56/bJd7MunNuaj9pNgb11YUk?=
 =?us-ascii?Q?0WJCLm5sGK1+hmK3a7mto8mkDNy/maF7srQRYVUegXGPa6T/0qgUwNTOJfIn?=
 =?us-ascii?Q?GPDO8SbwFbSo9bcDUY4QvSwRxVQdFkxyZKZ2bt7G1hauZ463OwX20WPj1YaM?=
 =?us-ascii?Q?5Avs+zTrioqHSAfAbn7kiO0carA2hVOVm+8QgrJ1u4rjww+pk8ZbQy1tAaIL?=
 =?us-ascii?Q?R+YfaOU7IHLaScgl7wvM576G4/AgQLhdBYybZK0qet9oJNc3yE8BD26CyD1z?=
 =?us-ascii?Q?BrinJon9+g2iDa/lkUDxj0SN2PK+feYxRDrSWv1OFJKU5DheZIc+9qhwZLo/?=
 =?us-ascii?Q?4PbV7AA0nysK4zmmqNHWdPYdDv9F8IWBABoxOBhFVMYwEY1pvcdZ47egV9rh?=
 =?us-ascii?Q?Zu4t2pXyBeDSWAb3b6LjoXs0ztmcpaLWCnz6hkquTWD/x2yg5H3V/+sqpJSn?=
 =?us-ascii?Q?ekHUwGxuI1a9sVH43qa54bC/K1ebKLMLlgJTn1DRwS0dnQCeo9IZfgURcluO?=
 =?us-ascii?Q?IsGf6gC91qF/fYMdudgpOoHIY4U2iaNpFY0SoLyeXx/vyi9jJy3Edsk8+RoW?=
 =?us-ascii?Q?QPNRVDE1PT3XcRtJOAxsmpPy/OE7rFgR1JInsX9fjZcdJ2+xTjN/T/Q4azbV?=
 =?us-ascii?Q?JqUwzkCksZzBAREIHrvhVMdpFQRxb2lAGEnnvy/1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e162dc-4e1a-4cb4-abf4-08db2b8fc0e2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:14:22.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2nANfGDyYP4QtLTpyoVz0qxGq2cQ7gzuhV9CHwYhwANzWgrUCoD1Oc83/75WrsEipgibv9zbP7Cr1wjhMHlsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9433
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dtschema requires 'grp' in the end, so update the name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 8fef980c4ab2..876eb5da5e2d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -389,7 +389,7 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
-	pinctrl_i2c2_gpio: i2c2grp-gpio {
+	pinctrl_i2c2_gpio: i2c2gpriogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x1c3
 			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x1c3
@@ -403,7 +403,7 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
-	pinctrl_i2c3_gpio: i2c3grp-gpio {
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x1c3
 			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
-- 
2.37.1

