Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47FB6FC278
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjEIJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEIJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:14:56 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B6DC58
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUZ7iLOzRZ3B+CMB6sr5qnKXH/bncFuDvK08Cm7bVkx+zvUVzPITepILxYsFMiNkwROMOpf5G5PYvxhj0H36+RiS5cWqTUtonjgaMGK86ET2ksmMobdfSFoIhMxNV/lZwpP4MyfjrFIiR/VBlEZkwGwc8yH5hUPe+agQY+5FWdQ8XHGsEfj0fImMkk5R+D8Q/RACq1eW4LobGtKrxvdSAr6uxeTt5tSkiJGP1Yaaq7ogwDQ/CVupss/X2dWNtH+LSNabWy3b1EZy7AsFB+Sr/pooQCy5Lpc1TgU50ujucZJaw7U4hhz9cEivoO31M1se5VC/X79V3jD3OplR8Zzqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHDshFukuC7O4/7O125TMRmHzQQCzYCM9FrzjCUp5BY=;
 b=M9Yvr4/qJWMs6RiCQ2HuJtqOSrujxzDQjEIHbBa+8lZrxKmOXCNk1mvp4Yoj16HSNI321q+OAcTptKxH+AAeeJaONhPt4AoYOCCDBli30zZZUXlH1ZZC6jdnzC/quYlpZd7DfbzDD7BY+muRs+RG6AnZbMSflzi8bj66bWEeHT8nOYPwlJ16DSBhlwa3ceEkDLApuORYJisH5ye/TTrRzWEp5Fsji+XA9TT1oNWIHmy1JhDOCOKsc9bwuHQSU+OTTTAydddmr/7pGqrT6QqYiXPqxNzDp/B9lMiQguPUWsAInZ20Idv5f/9+Zy3YXQ+E9Viaq1YcCaXuL7LIT4e09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHDshFukuC7O4/7O125TMRmHzQQCzYCM9FrzjCUp5BY=;
 b=bC8wvC/7ATcsJsWeH/pPSWnk1xAcN3WwEX8/jbCdUmG1IBm4xfr6Ei+aLHtOLA2pbWf6mjRakH/EwCNm+BBpGLP/zLkn9VtyCOcDIrbAK1kqJFsb4uKgtU7v+/Hoy5FnSXgWNi0kU7M693wJrC033CZqyPfnWRwFn6OB7Zrbv7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7831.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 09:14:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 09:14:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] soc: imx: support i.MX93 soc device
Date:   Tue,  9 May 2023 17:19:42 +0800
Message-Id: <20230509091942.2923330-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: af5c6db7-d18f-4d24-8e58-08db506dd284
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH+w7U7+nitZLyqj5mkfbQ2GKGTV8m2L8ubXt4B4dbebyqGgqtDKKK5ZQNc5WfHn00Jsp37ctD6Bivm9otG89adLvITimzkGylz68UnGN4hXtmMfp43OT1I45xfqh9AGS6sb/xDdETFlzHcj0hhvAfl8W2rJOfykExCuq63sr2G3UpsPgKdniz1oU3fKgmfSjKTwcRwdY1kN8CGQEYx6cjuOP3MTKWbIE+EmKIs1F9EAtQAsb2+6IbdFa7SstgHbZioS3GFOgV37LlSVMmrhUOM79zjY5xWPxPpB0saTyj51nzi/l3/nQm3Eiyxf5Mtu28dPUBuH2SpA+Zrvq2ELO4SU2Pt8bYTg+fthMhLfqapOfH3yD5CjEfsCWFdjs4L+1zLdnCiBWjuJ1Eo+p47OD2R67fJJHwui+znFYfHXqdEYubzUjfRsxo9cGwI4I8K+LdZ/Yp8d9hnFLjtldYMwKTnrtyWz02+0ELJT/wB/VdsWpUYUCkKk4o3tKNegGSdHKFK6RPZabyhFHBPyssZzpCkEwCGoLLP/0Uw0BXBY2nPu84RTmzJgrMSutg+JW5ktWNfrvBz/wRELHfuBUi7nyJ/SmYxHb1Sv8uaAKb2T4lk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(966005)(52116002)(4326008)(66556008)(478600001)(6486002)(66946007)(66476007)(316002)(86362001)(83380400001)(1076003)(26005)(6506007)(2616005)(6512007)(5660300002)(8676002)(2906002)(41300700001)(8936002)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFLnzf0pMJFQdPNtkqO4bPIRw9BH4veOg5StET5XstB121BBrci6RAu9Iess?=
 =?us-ascii?Q?yZ1v4ML18GFDLOQJmjdhsrJzg+D4/GvW0p8j/rdAwmkJx03rRmN06CmuGY+A?=
 =?us-ascii?Q?uEpcobbTczQ+AMzumVKXF4clvQD+s4XeMtpRmItqWOYgquYrcPz4pTzNqa1+?=
 =?us-ascii?Q?Gb57NyHEbqj1soUXS7zN2JWLOUVQ7WZeEXn51isJ9mTFJ+h3r7gDcEbMneBr?=
 =?us-ascii?Q?qmEmd3eK5yNVZV/9nOxN0M0vsZP8F0PPbM/Lj9jgyaCCjUfjylh3JCysOnT4?=
 =?us-ascii?Q?VsX+KTC8I/rHNJxDiSizIUNZDGrB9pMuKTSmfrdH4WzdTYTLB57gYLwkAki4?=
 =?us-ascii?Q?q5YOhj464vqu0xr1XA10GoYTRd8gJPDUhkf2g8r1sKLKnKkGMFyXJFDuDpdn?=
 =?us-ascii?Q?I/+R0Esy/2xEv1d64FUUZyr9KkDN9mn+qRhVEGrrF3SAQHZCzcOFip3IFgzc?=
 =?us-ascii?Q?4O0I5APQ/H1PocUtrJIiZFqtcSU2SJWhLpYBiwL8Q4po/lbRgP+p+Y+Y9w6h?=
 =?us-ascii?Q?aFLqRfv5A3b6j4yxKffq40lCXpGGMYJU/ZyOI9Rw9g/wyqJLNldB/YPqhvpn?=
 =?us-ascii?Q?PRAu7LnrDCHiPmNfdB3oj1kGcOK5jOzB1e1WbJZ4UNARj0Uv0+/jdOLSaWyk?=
 =?us-ascii?Q?/fAG+inB3JMCWvGcff2fenWkrE3zQgORfeLqDe2mG76ks4Ek26hYAPZ1fFYY?=
 =?us-ascii?Q?XFn747NxEu0ZDSpFNIAL/BM+BapTOgm2m6NcLMapCfMWRL9vkbhkIFJQ9l8m?=
 =?us-ascii?Q?eHjcwcs2q/zQUK8h+uyDe8nfitp2oAj81V3qsQGcW3qfs9rZqNqvl8lUVw0e?=
 =?us-ascii?Q?/gk//dp7A/XUemZxxoq1DsP3XKzwVGZuusEGsvufGu9YFMDPHAlQDlW1QfeR?=
 =?us-ascii?Q?uvVWeVcpReNQKn0nNgBITSuI88UPYOnB3WEPh7jCL00Td3SjcTDj4ItZfHed?=
 =?us-ascii?Q?6y7wVYhVg8dor4zh6sIwf5MW2lFwdi9g+TdYXQWrMutqHOESUD3yLAcpvIjt?=
 =?us-ascii?Q?nW9mpAoeRYDYziFIgvjIMIX6fD/m0jZIqpfGmUOwTiMh5xuZmhrLNtPPQlLg?=
 =?us-ascii?Q?ehEog9DLu8hKpxsczBRA5MdYUkq0xhVYP1lhXAB40odLdjMttO88PX5/hCk3?=
 =?us-ascii?Q?+4Kyzzd/ED7ukWay3uekR/eViz2x2mpJPyzTZrfGjVZykgs+yI61dIt06g3N?=
 =?us-ascii?Q?mFDBfiZtrRCengTMVk7tbrkXVIt/gSs4Kn2oTzZtgnGG/QbofiH5Mr72cuCd?=
 =?us-ascii?Q?rwX4gwKgRhkfYjm7AHY37x03auxzX1M16RJifmnmsVL/ZloiyXV6qfViSl8k?=
 =?us-ascii?Q?fvOm1Brj9wp1H+kEvPa+2RWqTrQ2R2w1QvxeZED8FmtomWIXykIU4xh9W9bY?=
 =?us-ascii?Q?h6nUdnReYJ+iLT3P2wxkLclUDrGjsSSWvk8jlA/5ffxm9cK7qcJzAtA3KEBw?=
 =?us-ascii?Q?TNOjkURrGsOr13ohZXhFgb+rpDQaPwKvDxFLl7/sLjrrO2FWRb2Q20bWlZ3I?=
 =?us-ascii?Q?IM82PywZLVVIwgwkDf17Imhkmqv1VdCF9s9wvPTMHROks9H5KIKbKnGTIWYQ?=
 =?us-ascii?Q?Fq2J3MZTa4eD8iMnQodhU6PKTIFhnmwtTRO3tjKQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5c6db7-d18f-4d24-8e58-08db506dd284
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 09:14:42.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /l3O2Y5cMieu8nMxANpP3P3ChRFsarEFm5FiiBXrZUiKvNDVO7q9NgCmhoBHBlv8n6k7guDfSMSR99VWv60KdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7831
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8M, add i.MX93 soc device support

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 The ocotp yaml has got R-b from DT maintainer:
 https://lore.kernel.org/all/01be24b3-aaf2-e27b-d00e-f8649a497463@linaro.org/

 Remove uid_length from V1 which is unused.

 drivers/soc/imx/Makefile    |  2 +-
 drivers/soc/imx/soc-imx8m.c | 64 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..83aff181ae51 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += soc-imx8m.o imx93-src.o imx93-pd.o
 obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 1dcd243df567..0e69b8b48183 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -25,8 +25,11 @@
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
 
+#define IMX93_OCOTP_UID_OFFSET		0x80c0
+
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
+#define ANADIG_DIGPROG_IMX93	0x800
 
 struct imx8_soc_data {
 	char *name;
@@ -34,6 +37,7 @@ struct imx8_soc_data {
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -141,6 +145,53 @@ static u32 __init imx8mm_soc_revision(void)
 	return rev;
 }
 
+static void __init imx93_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	soc_uid = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x8);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0xC);
+
+	soc_uid_h = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x0);
+	soc_uid_h <<= 32;
+	soc_uid_h |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x4);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
+static u32 __init imx93_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *anatop_base;
+	u32 rev;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	if (!np)
+		return 0;
+
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+
+	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
+
+	iounmap(anatop_base);
+	of_node_put(np);
+
+	imx93_soc_uid();
+
+	return rev;
+}
+
 static const struct imx8_soc_data imx8mq_soc_data = {
 	.name = "i.MX8MQ",
 	.soc_revision = imx8mq_soc_revision,
@@ -161,11 +212,17 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };
 
+static const struct imx8_soc_data imx93_soc_data = {
+	.name = "i.MX93",
+	.soc_revision = imx93_soc_revision,
+};
+
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
 	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
+	{ .compatible = "fsl,imx93", .data = &imx93_soc_data, },
 	{ }
 };
 
@@ -212,7 +269,12 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (soc_uid_h) {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	} else {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	}
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

