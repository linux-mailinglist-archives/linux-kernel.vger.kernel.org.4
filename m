Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6863F5FE766
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJNDLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJNDKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8055C10DE45;
        Thu, 13 Oct 2022 20:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv/ya0CdRAlDzCjM5WG51vhe6pPXHSTKNXkunoMBZNBbSiLwdLqKm5w6Z4uC6ptJrU0k//xqZKuRa31YdqJ/tD0DkjOvfZoiC+MFLob0wswW1rHR/xMCuhkn+HrbPDqNaUOdQdJ4IuyEPguERyNMMDqi+G4dRC6ri4aPrGwTDFoas2SLjbXmrl5LvvwnHwiOC2p24KbIaiSYC68j0gDkRf1UN5s0OWSn74E6f7dcaQrP5AtUrt6kqQRCjQ6P/UdPG4kDlIaDkV8LBWQtIHlDu8iav0RvByT2Ol4gnxPU6URLJ+iwxOFwwpSGC2CIkpBuvjZy56bU3PJ+CctpOPQx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXlSOq5mayofeEidHA9K1mueZiDPZvbynQwlfobd4SQ=;
 b=cYwEj5xNlV6uEyKGzgM6UQ3DpaDvaByXyFRW5NA7/BgNiPwuMwl7NJaYynAF573FnJ1MxivKXo3Y4FXLDL8aQdhXRS9mhW7tx/VEQs1xAeWc5oksYAi6XCBhUm4yOrGY+wufbmIc/d19Vj1UTZGJ7KtgzpK3JtvpF6/CHpaHUEqW/HIbRSiCDIiX/GHzgkjXUSUR6kvgBZqVBd0ec1NSyHA/3iK1H1Hpv6zcrKi2mprr6K4DGH3TdW9qd5yeSHWddZ1zOVX79j3+e9SQ3iHcmh1j1Rm8zTl5PBEBYR+TtFWV6czJ7iwsnKJ+4JkLQdY0IXAui/Bw3K4TjiIdexMaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXlSOq5mayofeEidHA9K1mueZiDPZvbynQwlfobd4SQ=;
 b=LbLXOLGNUrT6k2cOiIm5opT0vSdKd6Ygw3h9Sjm1L4Phr6C+nS+ovQEzNXZq+MitGlmJQljpuE6iKt9XLRfgI0WJvJSQZwCH2pNpMLx0H+pXiHZN3azcWynXXWXH7bP5dtJcA6oDazAJtHwNBYsq4vwWmij23D+70DtsDFGUwK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 4/7] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Fri, 14 Oct 2022 11:10:34 +0800
Message-Id: <20221014031037.1070424-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5eeb59dd-1666-401f-669f-08daad918098
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQ6xSOg3vEMKsueyk50+bYpGPFL1Ln/kxL8E3rUN4k80wh+V+7jQxRa0SC/Tyi3ilAOMysXHswFe8AeUDXtUcNS/IdAnZFIwaok+apMJLZXXkOkiteg4Ah37lUeQke2mZM5EQbjo5hjcVFvnRX1TqrS5l1l1GKvQIgHdUVBIBiajaapv8B8r7A5mQUlitjYw+1sappj/j85ombpt+2xi01xSuFFehYR5eBnzMr6WnSLDwNLhlNjlmiJxUSrg6nXVFIVAAHkb8tsK6v+TQ/I1WUsknf2S1Y7X/XpX29W/XunWNp2YpJuqTZVqROLLojfeHWaAF1zwnNICjI/W7ZkKj2nVWLJhniS723hDfVO6OwZAj5J6lnD8h0lJoW7PdmjGdtfX2vyiG+gQAroLF7j9JK2ctYE8Skdav3N0NcvC8vYam0cMQLFThpeC9KG5F/pTQviPucRRbWn2ZXgv8U3gk9drlSgi3j+vkRi9PNDDBse1JtepYhlRHX4jzgV1FZidG7dOGQb86Evw95ICPDDbR6upg7VdXSHSojLDc2ck6ZXQJimvLUIt9Al9pbJMDii7YEuLybdea7mw+T9Al+4d5xOgNfmrSkIry9jUfkISZzoPRPQ8wJ9rbeb/Zshn8r6AoDG8QXWqIsUGJVQAHFyH2NkeGZekIcqlVzlqY1n4Qxq4iMXE3Tb3ql3KoqyKokWkCcRMGaj7dQZ+ahfuomNaUUIFgButoUviTcsIhzAV93txAx3yNGaW+DBkfRUFq9uYXjodC90RiA60zZ20hGqaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8w/23Im0dQyuPgAu+hUe4xTdN6uqvkx1yjSnD9jXLMBPMZCtqUuot1/iAxUq?=
 =?us-ascii?Q?j0mzBAp+woh6xCssoEuJnVcjiZMwlUiYPfSXQpAv/jf2aW0ANc2V32PBWq5A?=
 =?us-ascii?Q?fsxxvriwp6Ow4B/hzynNsrQdEL3blvay6KQ2/kWDtFNOx+zt2FrCNNIpZGh1?=
 =?us-ascii?Q?9E4RpyhwZB7ajBXgF2q8x/GzGZflvmOZcgN/m73TAalR9rVFJ7bZvt4vZKFP?=
 =?us-ascii?Q?Yuvye5KzGh3VohbVq59AksW0nVYcmb4xjZId5qVrCImc+3N4SPvDhvNi+IoD?=
 =?us-ascii?Q?UvopeAAcZLaMI4+A5a+RfJyp2iAU6aSYqB+L1NBejxw+4JxLc9E84lp2SpLa?=
 =?us-ascii?Q?bWPOJ7qmqzKWRxWIyVEQbz9XLTp/mKABxsV0qhvnl4Eqttse8FKEV0jXcsQl?=
 =?us-ascii?Q?PoPTLhlgwTRk7oVUVZ/vXNkLJ+0NqWf0ZQFfYLd/yQ1KBvWQeB2GZV677JoO?=
 =?us-ascii?Q?MX6OMC52NfmnZZlEdEJoP9Gxaa4ZdpmMeJoIYlo6K5bThZvCGrZ9XNtwN8fl?=
 =?us-ascii?Q?45uOGOzoL/sqayjiS8cmaEWgT9Sk5Xmy2hiVmUwqOQ7xYgeLx4rpPoXq+AtY?=
 =?us-ascii?Q?n+rWFA851wmOzlk1gYwX+ccx4kJ4G9AswE/UOtbzBwEY3xe2ldqB6Rm2BL7z?=
 =?us-ascii?Q?9bbFkGBOfe9wOMrFjNsSeHiiyLZd9hIH5kszSsgElsP6qNCRx8rI1BrdQqdz?=
 =?us-ascii?Q?Cqkhx3wtuMYAm3wlaBMxtYW3VZWMrDFabuFbZz7+KTsgI5arKSbK9Q4tdVT9?=
 =?us-ascii?Q?e6z+ng5iqU2uf89o0wWAHFvYImSpAenMYwZ2gbBNgRGMAF51Q25RTYsw/7nD?=
 =?us-ascii?Q?BtUPC33XlqHIA0sjAJmQUp8vVj+C+Y53SwUaphMlsHkORSumsIxpbu6jRjn8?=
 =?us-ascii?Q?pGNR9MTln3cMZ+wGAjmbewIcDFchIrW/QUZE7A7lpMjFHaFXl4IsSvk8YySF?=
 =?us-ascii?Q?wePOskYpw0yYCJEH1FkoA9PfCvVsoMc4jzuEh7oAS8MADQnoiSGg19u10g3O?=
 =?us-ascii?Q?tLP1bOe41+DQ7a4lJkd77PlQwqAvbQhUziFqmV7GwijQ1EMhKagerG8LUFQY?=
 =?us-ascii?Q?w5mHNcnoD9Mn764d74V36/RwkSIBP+Oy8Z62Fd6fVToKi4SyafLUp0/UH1+x?=
 =?us-ascii?Q?bAEvKn+PcSaoA4uZTCAC/rK6fNEXBB7OLykKGRicdO6GU7mJFZ7qMTm0RhAz?=
 =?us-ascii?Q?Zzt6JD8lMOGKecWv0pClr1m3rFaFYhovCfb3bnkC37n33yktOjFDWX41Q5Nw?=
 =?us-ascii?Q?69+iyepo18cV74ftBGeotFDWylqABWjHgM4gyhLnhNZeuVQMyge1wzo1knhG?=
 =?us-ascii?Q?tFCYwds9RVZxImFM6hcv04uwrjn3gDGKKnmBziHaXZz99Shs7x1VirnJOM76?=
 =?us-ascii?Q?b9yU7wOs5dznSYeFb0Z+cn/EZwOpHnCAQsE0Ge0iC54IVkKbakLlQ34g4nFo?=
 =?us-ascii?Q?79jFGuF9gmtXB62o0vEoMBGt+HniqWBrrfeg4HHFTmoR7Z1VJ5fiIgeno+VR?=
 =?us-ascii?Q?erE9WDpQwoKri0srPJ7UuIWSsXGd9bDGb+I4dpwl+3ebuXwDiwLNoI5zb3v/?=
 =?us-ascii?Q?wL9jsVeKuqFonuw+gaozV3xkugux+KqmQn62sYzv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeb59dd-1666-401f-669f-08daad918098
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:27.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ewl21UZQe9jW1zTGuKo2soYd1uWfOxZ8qoktryhPV0lTSh8fCCTUlYDeTLuY1KeXjhHORk+a3Hi9cDehBhn3Q==
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

When M4 is in the same hardware partition with Cortex-A, it
could be start/stop by Linux.

Added power domain to make sure M4 could run, it requires several power
domains to work. Make clk always optional for i.MX8QXP, because
SCFW handles it when power up M4 core.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 96 ++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 5bbba6955683..372cb4a346b0 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -16,6 +16,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/workqueue.h>
@@ -79,6 +80,8 @@ struct imx_rproc_mem {
 #define ATT_OWN		BIT(1)
 #define ATT_IOMEM	BIT(2)
 
+static int imx_rproc_detach_pd(struct rproc *rproc);
+
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -96,6 +99,10 @@ struct imx_rproc {
 	struct notifier_block		rproc_nb;
 	u32				rproc_pt;	/* partition id */
 	u32				rsrc_id;	/* resource id */
+	u32				entry;		/* cpu start address */
+	int                             num_pd;
+	struct device                   **pd_dev;
+	struct device_link              **pd_dev_link;
 };
 
 static const struct imx_rproc_att imx_rproc_att_imx93[] = {
@@ -335,6 +342,9 @@ static int imx_rproc_start(struct rproc *rproc)
 		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
 		ret = res.a0;
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -364,6 +374,9 @@ static int imx_rproc_stop(struct rproc *rproc)
 		if (res.a1)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
+	case IMX_RPROC_SCU_API:
+		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -713,8 +726,10 @@ static void imx_rproc_put_scu(struct rproc *rproc)
 	if (dcfg->method != IMX_RPROC_SCU_API)
 		return;
 
-	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
+		imx_rproc_detach_pd(rproc);
 		return;
+	}
 
 	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt), false);
 	imx_scu_irq_unregister_notifier(&priv->rproc_nb);
@@ -736,6 +751,77 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
+	/*
+	 * If there is only one power-domain entry, the platform driver framework
+	 * will handle it, no need handle it in this driver.
+	 */
+	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
+						  "#power-domain-cells");
+	if (priv->num_pd <= 1)
+		return 0;
+
+	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
+	if (!priv->pd_dev)
+		return -ENOMEM;
+
+	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
+					       GFP_KERNEL);
+
+	if (!priv->pd_dev_link)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(priv->pd_dev[i])) {
+			ret = PTR_ERR(priv->pd_dev[i]);
+			goto detach_pd;
+		}
+
+		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
+						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (!priv->pd_dev_link[i]) {
+			dev_pm_domain_detach(priv->pd_dev[i], false);
+			ret = -EINVAL;
+			goto detach_pd;
+		}
+	}
+
+	return 0;
+
+detach_pd:
+	while (--i >= 0) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return ret;
+}
+
+static int imx_rproc_detach_pd(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	int i;
+
+	/*
+	 * If there is only one power-domain entry, the platform driver framework
+	 * will handle it, no need handle it in this driver.
+	 */
+	if (priv->num_pd <= 1)
+		return 0;
+
+	for (i = 0; i < priv->num_pd; i++) {
+		device_link_del(priv->pd_dev_link[i]);
+		dev_pm_domain_detach(priv->pd_dev[i], false);
+	}
+
+	return 0;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -770,8 +856,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
 		 */
-		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
-			return 0;
+		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
+			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
+				return -EINVAL;
+
+			return imx_rproc_attach_pd(priv);
+		}
 
 		priv->rproc->state = RPROC_DETACHED;
 		priv->rproc->recovery_disabled = true;
-- 
2.37.1

