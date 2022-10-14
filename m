Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B85FE761
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJNDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJNDKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:05 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFE0EF59F;
        Thu, 13 Oct 2022 20:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7kcrmq+yrqo47BJDRIsn0dcauhRB4kYELdQzjEtoNKbgTe8sSobYgUvrPsLloWHo6QfCTMeTYn899iqtaCDvUw01cWIIhR/lBa+E/2QYYxUURTRnWhUQz/gIWGLpztaiLp1eX2rwrZOk0tWGPT+GC1Ca6XA4xxHbSTrjLl/9eU2xlSRogg3IW/7b/qrH7UecdrUaVk3yUajvoxPmYOSLKoQoLsdGIAUxxuwF3eTxpwPGVlQUxBjg6Xzu6wMESWYXAzHBqMWldfvGz+8b9tn2hbOqbKkAWWLUgcHTcaKWB5887xcJNd/9NMAiBaMoiYhgIzPQhoYt17LABB+jLEYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJfWI1YzYlvXMQs7TPShXS8gSDh/xbrUCZxc6bIVzUA=;
 b=Z7QxJ8/xLwAVFDItdPCCHvwr/hdje+8UOJysNd3cxm4lZV/nqbQTBLbyD5Q3s/aWP/FBmNzC/eTeDjnUWVZXF9FueKbRM/iq0w4T4cC8B0sCHjuisfAIZ0FVl4qZv/TcjBm6qa8YyY7NU0Q0HnJZWCWFTnj621KAuWPLKTx3BpXTLLxjLZTGAlqmp9aDGEABMVMl7Vyl8b927vom/gwc32/4pKO7PI9lrCSSckNPwXOvx4xxlTW0z/9zFuOHemalAvKrcXfssuGSqjURLDYchYB0NNMLWVNTTZzbVji8vbZ3mY+6xqV/xZ+L5KOC5XjliF/NLG2w9zTrVb+SwwT7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJfWI1YzYlvXMQs7TPShXS8gSDh/xbrUCZxc6bIVzUA=;
 b=ID4TAiogwItMTE7fxm5pGU3uoxvSgnVxbHiiwFpO+lIlDAYMlWFH2mtyIfp43CqCVsla7DuqjymXxiPr5ZKJod1hsVfka/XcZ7H2zPL/bEXbVua9RpZ6rsRldmn8Ae0bI1KijC2+RSLNMGUGveblhcU68shj5tM1b5n9D5Pdod8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 3/7] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Fri, 14 Oct 2022 11:10:33 +0800
Message-Id: <20221014031037.1070424-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a41c221-27c0-4a1a-7cd8-08daad917de2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqdJ0yUBdekMr7RRtHQbMJun2oSv9hDI9z6a8u5dnLuWz4GtD5oOHsOdTsyYtmUsyRSyLeEw9BPhgBy7/HRpuBMX3KUdrEJZ6Yh8VgqT9iyFqQPvX0p3RQ76qnMLYpFzui3PfQrafI8KLBoL3/01KlxbhJvq2MCKJyHBbGCjHfsGLlccBgRU8M8cVc5nGjtyrVB7r44y852NZCoDrk417/gvhDtIYkJNKr7/2r96tf2p8DzFsMGN15RHz3IcWJmZMRs2U6VXp2kx/h8X5fyFluZUlauUaDCaRuswR6Rei8VIcqFQyzkVBAc1iOKAD5IvBR2G+8DRf31FYOHL8/nN0m51b0Oyxj0NlH5IlCmCSshm/c0CWGcpwkDRVpWtmMZ0HhbIaD6acUK7iHutBSvp5Knaaq8NjZVA89F+oBE10v90fqZRBcPGm9RWnWM/ApHFGHNy3KhXZwNjTP8QyH+r94mQp/VlDUMXSEMlwIcS7l0Sc+wa3h236x+pz+eU+qf0MUXHmzbeaMJ47Tnmqxou60w6fx0sNyF8y1JRX4ZhmPHyijqCJoW++DnH4GF3W9DHOwkxDza155W0wBnS3pJDysNRU9ZKLynmQxxGY0gPNt6Xb0x8AArxM7lo/1oeNMf7HtupRUtdG6FPgVMjLknk3JCK2U5Cvq6AGzMVSUQ3nB9d7jPk5nWTLe3Mwazh1JRD7CrynPfBwW5nrtBJLAFP0tm+oT9e6ERNVPF+rAVAX38MesgTqxWRR5xSatLOHWV2Jq3ajnKmv3yBof6SElHMvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RW76T9jC4WP1+jhG4Yz1+IgWTLWkJcsNeVFlw9QAlkYz1lSaTawo4NfxZPrD?=
 =?us-ascii?Q?GfsAJIRL+EPIBRTJxBPV/aFD/U5PtyikqTi5aeQGptEPIanH61hEnT7jSl5F?=
 =?us-ascii?Q?kOAtiGcaY71nJbbb0TkUSulHIYLLAwQiouYXWwDbAFSKGfuCn0ewDivpvpkI?=
 =?us-ascii?Q?yGOr22nhlsGdwVmGBdC5OPAPJKWrXAGJRvOwvTM2h49MHOyXEiyKM0MzvkwP?=
 =?us-ascii?Q?OdVYgMZ1OqnmOKpYPG4mJRi2g4nvKZU8vH1nlABVrptjTlNS6e881qmlC61j?=
 =?us-ascii?Q?fUIRA9uFUtSK4snwJDpJy17qAxiUR9EWZciSoVrqlnoYm0nz0ioILWc3jqL6?=
 =?us-ascii?Q?dKQxzAjz7ZH4wR6SYPC5/E7NAO4CtgcXPzbYv0xOslfwfffBT4jUp6IBSLL6?=
 =?us-ascii?Q?IrD0qmFaFpLwB1QKmTrRAneDew/Pvj9ggcCgaKlU/BJYqf1a/H3H8N82Xj1L?=
 =?us-ascii?Q?nXExMRXp1aicqaq08OuLjhUSVgp1RPkYpflphl9UZvlBKJ85NTl4mEQEH7tD?=
 =?us-ascii?Q?1lV0Vurr8PdjCvxQYdJjKnZSAgR7IR5u+KCJMxfliVE2jA36bqPS/NlCDFkN?=
 =?us-ascii?Q?x1fmQo2WeMl3opwvJNq4WwV8pCmolHPmFxSc4nm2v8yhAgu1Zhjsjxnm1nFn?=
 =?us-ascii?Q?BZ7Hu1V3gD2ZSfRs0rA7Dcete1PAZF1DnEfBn9y6N5ZMiw4As9ow++JUU7+Q?=
 =?us-ascii?Q?/lUaS6XOPWS6DE7mOaWCZe34gqRLjAnLmcBV3WpI0PjTSoIao1SYmktsINhO?=
 =?us-ascii?Q?7wlYs2dbMgbbQYOP5eVj5Tcj323eNfQUkWUcvgMnHk0ge0hw4VrOLcnXhkig?=
 =?us-ascii?Q?V0vhlkrNErxTjKKMua8+a0Z7KGxvn+ufMuDcpMdffGy8J1BIt5NDsr4+ugb8?=
 =?us-ascii?Q?a0Dt9LToDVzmue9U/K6VTubhB5nwABheTyIT+KcqwcvzqLOPo+iWMQU+ebE2?=
 =?us-ascii?Q?61eGQ/rUmgbLFDo6JAe1c4yXd4UrhfgPXOnA1YSexZcJxWBgriZjejqehZBN?=
 =?us-ascii?Q?Hv48H7qiLhKeiRh9CMmaVL1WjrWym+MJRfwnoQXZmB8Bw0UrOApHNev7C3Tw?=
 =?us-ascii?Q?tvDScjED1gcf1cp31ccZcbMyhpi4YmCij1h/yEdGlDfzD3+42phoOFkSR/oQ?=
 =?us-ascii?Q?tFwllTZRMsmXu8zXSWPodtszDCrp/TyDldXgG7/fPd3xsxGwVhj5k5jKy5Hq?=
 =?us-ascii?Q?k6Ck3pr9KKmD5MsTTtVtLG9bhKgHpSDBmHq9dGH9g5nO+0sNRujQhgZ7DE7T?=
 =?us-ascii?Q?RT5dI2j8yz1uHfVyRVg5tgMecHiduTWVOPqVqw5Cdx4Yv2E3sRIfFyfhuH9B?=
 =?us-ascii?Q?3CNxIPzE74LNVdQISR533l7TD/UQ4+qpZO+O/c78HRP80H38uQeLPKi65JrM?=
 =?us-ascii?Q?x3E2fk8ucdtGY7eIX3RYo0ISZ4DezeMIKcNRu7tOiPXzXxXonpRaa4cyAgaq?=
 =?us-ascii?Q?+IetaB3Lx59mf7ie2wpf1DY+SdYrDBztbgh1ufcbmeBNHH62zl+YvNYf3mRR?=
 =?us-ascii?Q?QYcJniZ4TlqhjHw0/+5qWXn13ZxAjaUlZe9+0Ps9TYEyAjJMWtyvvRKiUhKC?=
 =?us-ascii?Q?VlumgS+qzabkQaNsqlwp3fLTGPiCYCAKAOriYV4u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a41c221-27c0-4a1a-7cd8-08daad917de2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:22.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ORMhz8U29spCnKIsSbywtQgq/Bk7DLrHJbcMnO9HdGHttDxN33AK2VLz3dpeRHi8j8IcXQieeJpWxAbkgPEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
could only do IPC with M4, it could not start, stop, update image.

We disable recovery reboot when M4 is managed by SCFW, because
remoteproc core still not support M4 auto-recovery without loading
image.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 108 ++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7cc4fd207e2d..5bbba6955683 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -6,6 +6,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
@@ -59,6 +60,8 @@
 #define IMX_SIP_RPROC_STARTED		0x01
 #define IMX_SIP_RPROC_STOP		0x02
 
+#define IMX_SC_IRQ_GROUP_REBOOTED	5
+
 /**
  * struct imx_rproc_mem - slim internal memory structure
  * @cpu_addr: MPU virtual address of the memory region
@@ -89,6 +92,10 @@ struct imx_rproc {
 	struct work_struct		rproc_work;
 	struct workqueue_struct		*workqueue;
 	void __iomem			*rsc_table;
+	struct imx_sc_ipc		*ipc_handle;
+	struct notifier_block		rproc_nb;
+	u32				rproc_pt;	/* partition id */
+	u32				rsrc_id;	/* resource id */
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -117,6 +124,18 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
 	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
+	{ 0x08000000, 0x08000000, 0x10000000, 0 },
+	/* TCML/U */
+	{ 0x1FFE0000, 0x34FE0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+	/* OCRAM(Low 96KB) */
+	{ 0x21000000, 0x00100000, 0x00018000, 0 },
+	/* OCRAM */
+	{ 0x21100000, 0x00100000, 0x00040000, 0 },
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8mn[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	/* ITCM   */
@@ -255,6 +274,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
+	.att		= imx_rproc_att_imx8qxp,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
+	.method		= IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.att		= imx_rproc_att_imx8ulp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8ulp),
@@ -680,6 +705,37 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 	mbox_free_channel(priv->rx_ch);
 }
 
+static void imx_rproc_put_scu(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+
+	if (dcfg->method != IMX_RPROC_SCU_API)
+		return;
+
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return;
+
+	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
+	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
+}
+
+static int imx_rproc_partition_notify(struct notifier_block *nb,
+				      unsigned long event, void *group)
+{
+	struct imx_rproc *priv = container_of(nb, struct imx_rproc, rproc_nb);
+
+	/* Ignore other irqs */
+	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
+		return 0;
+
+	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
+
+	pr_info("Partition%d reset!\n", priv->rproc_pt);
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -689,6 +745,7 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 	struct arm_smccc_res res;
 	int ret;
 	u32 val;
+	u8 pt;
 
 	switch (dcfg->method) {
 	case IMX_RPROC_NONE:
@@ -699,6 +756,51 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		if (res.a0)
 			priv->rproc->state = RPROC_DETACHED;
 		return 0;
+	case IMX_RPROC_SCU_API:
+		ret = imx_scu_get_handle(&priv->ipc_handle);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32(dev->of_node, "fsl,resource-id", &priv->rsrc_id);
+		if (ret) {
+			dev_err(dev, "No fsl,resource-id property\n");
+			return ret;
+		}
+
+		/*
+		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
+		 * and Linux could only do IPC with Mcore and nothing else.
+		 */
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+			return 0;
+
+		priv->rproc->state = RPROC_DETACHED;
+		priv->rproc->recovery_disabled = true;
+
+		/* Get partition id and enable irq in SCFW */
+		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
+		if (ret) {
+			dev_err(dev, "not able to get resource owner\n");
+			return ret;
+		}
+
+		priv->rproc_pt = pt;
+		priv->rproc_nb.notifier_call = imx_rproc_partition_notify;
+
+		ret = imx_scu_irq_register_notifier(&priv->rproc_nb);
+		if (ret) {
+			dev_err(dev, "register scu notifier failed, %d\n", ret);
+			return ret;
+		}
+
+		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
+					       true);
+		if (ret) {
+			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
+			dev_err(dev, "Enable irq failed, %d\n", ret);
+			return ret;
+		}
+
+		return 0;
 	default:
 		break;
 	}
@@ -803,7 +905,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 	ret = imx_rproc_clk_enable(priv);
 	if (ret)
-		goto err_put_mbox;
+		goto err_put_scu;
 
 	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
 
@@ -820,6 +922,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
 
 err_put_clk:
 	clk_disable_unprepare(priv->clk);
+err_put_scu:
+	imx_rproc_put_scu(rproc);
 err_put_mbox:
 	imx_rproc_free_mbox(rproc);
 err_put_wkq:
@@ -837,6 +941,7 @@ static int imx_rproc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->clk);
 	rproc_del(rproc);
+	imx_rproc_put_scu(rproc);
 	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
 	rproc_free(rproc);
@@ -852,6 +957,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = &imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
+	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.37.1

