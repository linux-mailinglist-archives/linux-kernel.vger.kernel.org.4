Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A2690079
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBIGh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBIGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:51 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFA42BE3;
        Wed,  8 Feb 2023 22:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw4sIgbluTq/LuTtBgrPGp/hVx3r98+V25GlndDr0VOfUwzzNt9un6z0do9bunGkVdwuzoB//utAe7g5GjLCDt1RILibgHgGuLiW3J+2qD34s0JztD5+uORbrnqd3dCa6SBOAttBd4q27qMCnX/pCt6PuHlYB3m9Croie5JTbddZNmmGBAFX3V+KNUxy227l3QeXMgKErdSLWmWVRGjEQqnXAqiAobKqM6ZrPGAkR+ZGH/aWFkGoSdBgmelD6iMWUCAOxwW4zmyjt4xWiPcpjiI4T9JiCW3lgmeHnUfN5ZpWgG65/AcVTlNrHeMtFsDdUhmMBsDVJEJcxG8mOz1m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r63xdWghm3dhcPlNst2k8Ze7iDZxE/v+2VmG/ks9xYk=;
 b=i25U7Sfw9InV6Cig7YmuRsNvndV2bUOveJAXeAWvall7tss4F1o/nhc5rRgUgPjtXVrWG/6rZlN0KfBnFuVV50rd5MtNLBDko1TLGJyh7kc2bNMTP5UFIuKAsqH9MtGrXJ2gRJv4j/OcNQujHUJkQv8ZRLVeKte1c3D28w3u6DzxHL774w3SbtfExBUcLGjdEx+E9uxzWjUIPGdVPPMaXRWQWUv3KQOLo9Xhy2fr22sD1Zrt7Phm0U5cxn/o55dpaKdIwbLWiZCnU03/TILAywpiCOFGze0hYf1Og79y4UryWG6YTk8KK+TUS13dHXVPCCbaE8mNcwpsW/AAaqgfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r63xdWghm3dhcPlNst2k8Ze7iDZxE/v+2VmG/ks9xYk=;
 b=eDVxj5q5TIcArZNmkUi75/nYKsOpW7sMZtR9hLxnFMTknpYI0SDkxO5gAEMExTDkrYsXr0eJDqF3iBKhxLd/DuJmjoo4bhhQ9GYXaFGKblq5ZTGkwce7oZSET2UbxUYj0X+/bDIYKdTAqizCz+YGeag7JqIHxOpx3l45lrWPNxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
Date:   Thu,  9 Feb 2023 14:38:15 +0800
Message-Id: <20230209063816.2782206-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 45037bc0-ccda-4143-b038-08db0a681a94
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8b6CvbmK825UN2VcwanvkFG3aw68NZQyBEkTMxK1v4x3WkrN58r06lMndJoSt84DQiuQsRfb3cWluJttjZOjMu2m40ZualebA0CPedrgv1Cg0o8CRJ+84mG3tBxKCztgSExyL0+zhMGKBC1/4BmrZIa4qRQ58uImqqpKyyyRO05938NnsYsfRwcK5yw06RejFgWrk5NJ4AVkhYdE+ZkHfuLkORMU1+JIYXQgUcMiugWXSMWrTbDB7Kr6+C2VmGzuNHNkigIuxLPMpkUflfUsf5ajOlkFFE88jr4LDdeIs8DTAWjFBkmotR7tAugwLS5AWzv9KfvQC5sRtgZZlSHJuAHtQueAri/5rVR/uSYe+0T3lwaccDQqsM0zPaY5U6+Q0SkN97dNmwAr/7bQYnzCDp6Ds8NcwFcwJKA109shXryalcl+9vQCGfe3AESoM5oszWvbxSoowYqd/8lZtppSxT7//ygOogosNN8LJCVv/gHT5MYjpkLGJN8Xm1Ldf0bK/8Ul6ZCocuO7C6GveSSvJTIITMjuj+508SKK1nCEAaP/09yYTnji+yv2weR7hHjy+NQ31UOKoFMTzSd9Qr4c256YaBucK/mBteuXd/VWlzu1KXVwvcS2zlLw/BClHAJi36QkpmWvpui2UcdhlslmNTfubb+mGCKxv+Jldk7e2FRliD8RVhJJQNv6nHx3ndu4PAME/ISC0vbIwkijPodhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(6666004)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wlb+LYtkXFZ/fXa/S5mGfDBruF9UI2Zc3yRzBmoVMvKDlivnpKQ1J6zlCJ5?=
 =?us-ascii?Q?Wnwv8aSpUngG6c8ZItQs1au7pb1wEI0LU5gfTp9Cw2fSNmgi/OZxSqqRGe3v?=
 =?us-ascii?Q?KxOydsiJBlVcGX5lnutX0uE712BWuCYAewsmNgyueBgtjProG5OqbDMD3mnE?=
 =?us-ascii?Q?VRxBOMFhAVbIaR4VBiNMYt0zUf/QVXQe/sMaim4fX3ly9jc9zLO1+87qTAER?=
 =?us-ascii?Q?fFyC1Chq+OPEdQly4ypC0ZXnqNs8QOz7bWm2c5VSVM3iL5+MTtyNYj6qhHt1?=
 =?us-ascii?Q?4NSrNmCKAxusRfBCMe7QjvVIRpdOqa8jkSha/WxkVkc8usjpvSsY8bEd9bFa?=
 =?us-ascii?Q?si+hMwKzBELQAuSTchlg7ubNHoe4Up4eE8ZuyKKuPs1+lqS9De0ywLQaMiAi?=
 =?us-ascii?Q?lRwYVWUj5bzUDyZHT4k/ShdWfrop0GghQq1IDXd81/AxUUUISxa8HFmUg/jG?=
 =?us-ascii?Q?RAfInIptCnjzgf5kRje1O5tkB6qg6inB9KndC1KmAX44pcOJ5RWkeCRhvLle?=
 =?us-ascii?Q?I7caSj7YDoX23wHkBospNkCZmmbKZV1ehQbXSQxTAEgOI2J6SqyoqnvRkTfa?=
 =?us-ascii?Q?DWcDpnkWCNOK9CBZoPF65Pbue5lw37j4QQjFs7GYjRrga9QTamc2Laxv/uHb?=
 =?us-ascii?Q?B2CZxeZGhWpKBwDkmWAFccx61bjS5K72MbDgvS1icZRgdhlHD3rcavNGfykq?=
 =?us-ascii?Q?AGLCeccFKqLp519f4809M9l1qQDHuZRic3KEw3rI0iGI+N6MflBhvYyjsGYz?=
 =?us-ascii?Q?l+aqHXpBvYvxPWCh14ou2nFPoP7pPBj+pIL+KrKlULkIi9oo+SWO7duMlA72?=
 =?us-ascii?Q?BykJH3ih5SS7ipFYtj8W25Fggbjd1HT+tRua8XZgxId6YZzyNf5dDt9bFOkm?=
 =?us-ascii?Q?YBfTooJU0ndvSfrio9xpH4NOEJaqiWNt4Vqq5N9Sq0ErFOyLOWIw1qCDqWwN?=
 =?us-ascii?Q?/4ZbMGCPZfeakJQKEX/Hem2qoOcPYzy5wwsCjBCAG3ox2h8zieT9btCvRvtC?=
 =?us-ascii?Q?BI3r+tOLtMzYkb4uwjn/4QeIfawlVEQItD/CXLONFCL80sAo6aAuP1EC+UWy?=
 =?us-ascii?Q?watJlpfpl+ok+IGYDjqGF/cvHpYGXuHcHrXDvKN2EkJX3EMllulUWNBdLlyp?=
 =?us-ascii?Q?Dn4rLj3D1QJc7ddMcokalwj0Kt2aTGNTSsdxe6fZlLvoyC8T59ryzlN1dHbe?=
 =?us-ascii?Q?3GkTV1yaLAKGdZgh23t0OXSKK9APu7sC0krJ4QJF1aLtAmsc8659Tqvlo6x9?=
 =?us-ascii?Q?Z5mqSNovLZGKBJSK+JlTpNiiXOcraWjILUWMjSp2SlsF1YY8SLB3eGHgYxnY?=
 =?us-ascii?Q?+9K9URQ8SPXpKurHKb5F167Lx0SYGAQZnvJsLCJvvaiz5rqIHHmCUQiiQq7+?=
 =?us-ascii?Q?tCX76HRW7GwImV5/g+zZ0hNpcuXOPgmbh007Rk+twr1cRlyhZmPNiNC+4JB8?=
 =?us-ascii?Q?if+Ufl9DSAUEOVV5VzOy1Bw+aYwwcKHDMc02xE2ifcjv2Pj1CFOKbRBnJe/d?=
 =?us-ascii?Q?RYKA/VDBK3D6pxhQxTovrYUbdQyZVoLs7RbkW6IuRDvi6GN1/B+8M3S/Og4k?=
 =?us-ascii?Q?5J0JqNheOQHQAchF+3AWYHHCz3v28+3rUCqgbhNr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45037bc0-ccda-4143-b038-08db0a681a94
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:24.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qi3/AohGPPW+v4zAjywETBAUSrSPrQSg19b0pva6u8ZnjKm4XQecyqsx3GWcgzBzk4ec4MRrE4W7/O7HKIcgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8M Cortex-M core not has ROM. It has a requirement is
the stack, pc value should be set in address 0 and 4 from the view of
itself. From Cortex-A core view, the region is at TCML start address.

The stack and pc value are the first two words stored in section
".interrupts" of the firmware, and the section is the first section in
the firmware.

When the firmware is built to run in TCML, there is no issue, because
when copying elf segments, the first two words are copied to TCML also.

However when the firmware is built ro run in DDR, the first two words
are not copied to TCML start address.

This patch is to find the ".interrupts" section, read out the first
two words and write to TCML start address at offset 0 and 4.

If there is no ".interrupts" section, it just return bootaddr.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 295e0e0e869a..2265eddef4e9 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -7,6 +7,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -23,6 +24,7 @@
 #include <linux/workqueue.h>
 
 #include "imx_rproc.h"
+#include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
 #define IMX7D_SRC_SCR			0x0C
@@ -634,6 +636,38 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 	return (struct resource_table __force *)priv->rsc_table;
 }
 
+static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const u8 *elf_data = (void *)fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u64 bootaddr = rproc_elf_get_boot_addr(rproc, fw);
+	const void *shdr;
+	void __iomem *va;
+	u64 offset;
+
+	if (priv->dcfg->devtype == IMX_RPROC_IMX8M) {
+		/*
+		 * i.MX8M Cortex-M requires [stack, pc] be put in address
+		 * [0, 4], so the da address is 0, size is 8 bytes.
+		 */
+		va = (__force void __iomem *)rproc_da_to_va(rproc, 0, 8, NULL);
+		shdr = rproc_elf_find_shdr(rproc, fw, ".interrupts");
+		if (!shdr || !va)
+			return bootaddr;
+		offset = elf_shdr_get_sh_offset(class, shdr);
+
+		/*
+		 * Write stack, pc to TCML start address. The TCML region
+		 * is marked with ATT_IOMEM, so use writel.
+		 */
+		writel(*(u32 *)(elf_data + offset), va);
+		writel(*(u32 *)(elf_data + offset + 4), va + 4);
+	}
+
+	return bootaddr;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
@@ -647,7 +681,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
-	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.get_boot_addr	= imx_rproc_get_boot_addr,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
-- 
2.37.1

