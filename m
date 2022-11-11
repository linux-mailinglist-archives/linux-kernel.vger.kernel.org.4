Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E926251AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiKKD2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKKD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:45 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36A65E47
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AatSscwVSVp1ZhRRi3HMEKhAuRcA7HuNDWoVUOthkRFulI64SfZKLKEJlQpD9JGXMy6uVKHP8qzJv0edEdAM7Ybd6PRf1juPhle5/GZAQIdzuY9DmVtc49M/Mw0hYiRUgxC2nIsSmGNqdhEgYdbEe/kUeTz5dhWtGBAwCW54xpGk+ci5VB7kmh1fsexh8+I+WnGYFzjHj5icvy6K8DzKJNb5K8gUnsoVYgAx6i9DsKtiB3O7T5rLZnojHXLKQ2JTc4GAoKoHPwqo5VIZYRoMx5/6iAMjglGpfV20wuW2QkVQe9Xbz/9te2YOWNbyDh/f3npKt8h1w2Ov/QbgNl6J6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=c3VFrNhWsaXWIrWsY21r7kgtLFxa+62panB2opurSXG+S+WW2rLFOL15HZk1XE2S91lHgdi+cIyB1u/9fUesxgAqEfTQASl/pebJemLW+VFLg6lZPBRRlsGeE9uz0IxHNJ/9fjT3oKo2vKFE2EaZtv5vhqhwqefzJOGK4z5gDIKHH+DM+wtb7AHN3TpVtRIzEbGoW6uEhHms5pMlC4qnxOqGmRC2B59mTDZwjJkzurXPznB3CVi2Hu7nvS1GWlIH7cOklswDL/wbvi9ScqFS745FJxi2/HxUoMp6RUr9tbuRIpbCVd3Xm7WZSFFCb44MQS38xPAJMRzGFmN40rhSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD3y/1/E0ibJpbjGPCjYtWgvN8kRPlJ5U7hqTre8rJI=;
 b=O8ZZrYsLw+I0uL97QEmCKVfBoggz78lRZlwPyMeY/VFZCUoM0u4YOv091OwM2lUez7bvjx6uVNnYapqAd9vgz4Z1XCIal7PSIspdDAlbFLIcB0QifnmpJDHTYH9oK7GU+1KsTRNXM5lb6pAfRWRIFzaz9r94iuEZ/xagLRZFOHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9321.eurprd04.prod.outlook.com (2603:10a6:10:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 03:26:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:26:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 02/14] arm64: dts: imx8mp-evk: correct pcie pad settings
Date:   Fri, 11 Nov 2022 11:27:59 +0800
Message-Id: <20221111032811.2456916-3-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bf4a95-1478-4f3e-fa6e-08dac39492be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6Ju/uDAQDBcHBHQTcc4biCLqSbZMe20OT5XpYhOT8v1oi4my/WHghtZt4zxD5P2JPsp6ySeLrgSDT7VzoG+3EVNkLzILi3JgXGJ7XAUvDPkqYrBbKl3n8EAvGUvwe//qHP428h2IVudBUurKdu/ikOz2iJjmsoyR3ZcAdZ38GOeIs2e9526V3Sfs58EXu6LjgQ9QllA/5Ko9V1BWIZ/53OSeq6ynRHRyY1dsmVJSSoaRPp4cHwJBy7u7DRA6nJ1SdRYKa1wj1ZuKytyl3pFM/ekMReE7+2NlBbalj17gFZAmj6pJKVuVtuzTyHlYENlw7ixWnq6XsgmbuHz1eRfV1MhrVgIRXT4zpAUhJbw+VqgyZGom2VIdvNgsq1oe6aQjHOgCK0HAZArxCxGWBywZddQZKZSEjaQrlSVQ0f+WFseXBhc9blKMsCrY3JpNF4SdKoWh3bQnf9uTe9fZz56WJfxHCqhrMmAMgHGL25rFHEJ0bJTjRBEptEH5BD8j42ZW9zUDQW+CqgzPVnU190QRtW1+SQTF8FDmN7WH6/lBh+DKqQ0ZYr2SoYXycTRMnxr+8iYCyFUfEsc6nvgv5KDL11Yp1cMPEN9AgbSsYPyguRqzftTpQx4hHxbj37yyzmBNsaw+euuK1rN7YCCVYlHz0At3tikJxKi1kMLvvzSIZqI3naExBa5c7mRHkufblkqRqyR6tic+vVSSgaGKAGTOy6xosoYHtmgmRFKGRmNm4S97Vvy0iSzHdTXsQVoockZ3QP5j4dcX1pTx4cVW1ibnOboLBXxuf83wYOHg1xItf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(83380400001)(86362001)(2906002)(38100700002)(478600001)(6486002)(26005)(66946007)(5660300002)(2616005)(66556008)(41300700001)(54906003)(316002)(66476007)(4326008)(52116002)(8676002)(186003)(6506007)(6512007)(1076003)(8936002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ToxnZYWLNkpOQ9VYd02I8TzV4SihItkdfYLJAljGhK3TflNseHKcukSLzOU?=
 =?us-ascii?Q?3NbHKAtAxkM4VJOepjeU2opMlahzqgoCcyW3WQGbKuE2EwsNnxV9vsyEVsSX?=
 =?us-ascii?Q?4IwTG3MvcheQyT39xIL3ZdM1bqBYEXG+LaD19opETSX3rZfTIcL3S2IEd1wt?=
 =?us-ascii?Q?DfwW+GMZPdudL2ZBdNYC33zdVj9ahcilb8uebIAK+dHsPZGZEyPzRgmPL5Pb?=
 =?us-ascii?Q?fcMlWPF6m9h+gI03NBgzDNIy8tehxUk+ixTv+H/RJy6Lz8aJyf5IENrZXgPj?=
 =?us-ascii?Q?r/IKjDS3EjIBQo1wNBUgaj4356A7UFmvmG9w2cYIFlY+DcA01EXd/QDxv/lI?=
 =?us-ascii?Q?XkFnnhzly5klNy6dVTwxlj2yROtYd1KsRrvJv2yaO+qBg/68H/5t6cwRRVYs?=
 =?us-ascii?Q?/ZkCnLjvWnJjfBWBD80vaBWpgcx8w3UZIfb9NLzGwwjFCJcroHo96jNue5G9?=
 =?us-ascii?Q?oddB+05IaeA/EiUFIsuaO/atvb7bX1psVVmN7BdAGymIwzwv5ImZnBuy0JPf?=
 =?us-ascii?Q?fBf2xD95ySgaESPczJELaSbTogx6F7qRIzFQUkK31PL9cGPY1kP7a2ZQhKSS?=
 =?us-ascii?Q?jddqAqB4m7dSF7HvjJqBgLJJlmbO1xMNeLjgx+SI9kB4SoiarqO2C7azeqES?=
 =?us-ascii?Q?usKaRv/0USBMzwldodhe7Zx8RPL1sLN3TxfxVxpdWk4yXYsLxBOO0NAANgFo?=
 =?us-ascii?Q?Ih486WVIE4elMT8yRYmfuYi0Nf+v6Hpyu3VK9waVANHKtnpFYlw+Pam+kpuU?=
 =?us-ascii?Q?TKYXafogrmIjy4MnI/6SPmpDplUUH1WyBLo+r5i+x/kxUxlTt44tTfYSvBQF?=
 =?us-ascii?Q?vuxFRQSajMPLz3n8ll+v5W5nPyLV3IrHXe75/cwWsX+inQQ7IRY0agCap9rH?=
 =?us-ascii?Q?bk6Gk6eVbGZPaNHJ2YaiYJdvRM9te4gNnI4g8rFH7+XOydJTxb0PWT7LpwHU?=
 =?us-ascii?Q?wPf+f/ysPX6pUOvuPWbyg38zcgQo8bs2ZVuKWT9GggXuK5C+9GVbPykP62kp?=
 =?us-ascii?Q?bxDPEIsEChQJOG6+3r6huN3bf9tnZstwzrbDIcKj8tgTBCXTueK23J65QtCW?=
 =?us-ascii?Q?4qiD74l4b/SSvXSiVKvQWili+gE84NDCwp5wVFYNZlQXIARttTk0Z36042bo?=
 =?us-ascii?Q?7K2gft9NApNY6Ms+WVZ6UIKGzn3pDZQxEn2JVCaCRwIbSCUKMYWZT1k+IF7b?=
 =?us-ascii?Q?97NZomNzjcAQW7cfZuamPc9CDFLoJKQxiuheqlgFI1In6iKhtr1eWh298K0E?=
 =?us-ascii?Q?REMqqEePRT2zYvUZMMbInfSTPdlQtahmXwp1FbYSo2Pob65afBhp20nnZbFT?=
 =?us-ascii?Q?YwEyGu/IdzoVcJ288OI1kXq4MQkRQGp3U252k0snS3UjLFRFt8FqoKDlFclT?=
 =?us-ascii?Q?dF8vqdFgM3HRMuJwDiDS6IIfvninQ2aQ1fTHASh0KA6y8326LxSZrYwvLuyr?=
 =?us-ascii?Q?DB4yfSAsls1ls75i1EAxAczDYTufCwlWe7HpsSDprN3/TQWYDA21tGLCyiva?=
 =?us-ascii?Q?ZKN4Bxi8gFi1f2/NxYLkGQyt3Bwk9KZbdYSbiOoM3LDrWcWm505JPTZqt0L/?=
 =?us-ascii?Q?8XU/CFXTUJiWqaBefB6b78BysPdoT50GHlThz0Wt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf4a95-1478-4f3e-fa6e-08dac39492be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:26:51.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0DNA3ggvSqmvswBzCwonAYRE/hHZeoXRWj4NyaOYsTQgTzih9FHSB+Qk4jRV/BqWhGcQsuVkfR9XSNsVoF/Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9321
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

