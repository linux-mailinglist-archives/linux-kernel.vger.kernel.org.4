Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF929606EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJUEPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJUEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:56 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F0A248C9;
        Thu, 20 Oct 2022 21:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuNMsdQshM18qLnzjGmXOyg+DHzVDUrfjxzSgtrRSLY12jY62/YPlu5s37TkY7g6FUxKeqSPuIHuDKD6nNhe0/Nof/SxIHEZLpBMaXQPjVOlDcKQZ6lBy86mk7yVU+Ed5jslkMj3d0bLneBfLscb5qK50Qg6XtHhiBXWUO82a26MpSaRTQoN1apTlwKDlC3EjQt3dre3+gxbOzxS14Pa3m3OixG8Yq9zAUDPgbPU+ZCev5Hpf9/6qAI74TcjApCdaCaWMLhwqIJsokulVDk1pXwBVG+twz92KisoKJo2FR4dmpDl+ESFR7CGHgLY5pPbVxrCbxk0epZ0B5vfoGwxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXlSOq5mayofeEidHA9K1mueZiDPZvbynQwlfobd4SQ=;
 b=N6k7JhtAiOPxnWzG6CLc7gUZIReJ8vbrGiTWNcBTokxI6WnaRHsp5x8Fe+nncp0AM4uGsR/5pF6Mo+xx5ZnpBoYTzwtFt1g2xN4nBIMtsKv3iw+ozvFlkfgZQW2ev8J+tLfGi/pd1BYzI2GrbpTU77xLNnOBVOw0L47R0jblFB+t9iPJZAwAF6NPJljaSv5+Tu4IgIDlBcju0WF6WO2xjQWNLua1D72j0kLTIP58gkqb6/eyZXdRmLqlRFZn/M+6eL/jpVCHH91PpAsVo0wfVuJm1YzKpE1u4BviZKp7jJtThFJij05VBADCgE25HrxRlNJrP1S83gafIWwGwLQeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXlSOq5mayofeEidHA9K1mueZiDPZvbynQwlfobd4SQ=;
 b=b4BlZS0F+LFY82AEJAp+RjVEnzdsbSbkPIelnE7JzcotG5PWZ9uokJghhi3sBh7eqe+8Zn5//6JixsYS/447Ui2Enp0nLkdS8ivkK09VGz0WldsNNLvosMFiFtQepsUmUmJ6DBmRbda4cqKV1Yr/XfQKuUVItQBL1zaLGbHMfHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 4/7] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Fri, 21 Oct 2022 12:15:23 +0800
Message-Id: <20221021041526.3696483-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdbc4dd-bdd1-4d32-dc2c-08dab31aba30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0GkNf1peUQ/PvAxQghriwbWFDJGNh6BCa85Lp/fzDBi49A7n2ORAPUSSvolkFmtzLRssYG7ialxjpoTdH+DSAIgnyFocC/797a3H30+vPfvo6VaeNLKzdNSFu3iNCtUvyVM2WVW3IsSnQbJ+Tfii1/dR5PfhqV/Wq09lVbbAWRaJWpGi53eicEp0o/YoifQiyUlS5xWoyiluJ2QwBt+DsUyh1o+4w9hKVI4ksKtVXckFiHSfX4k5N4c/slVQxC521JbB6fMYT9LQFt+bGDvJSMter4SVcIu/G8U7UF0TTA2S3LnCU8LfB8Y1nssC7akvPDFw+8cxuoxUfU42tbDPX55959+n20BVQAERzZEA8EFiYdio4dKd18pE5Qt4AX7PdUm2SnqqnjP/p11qQ/Dz47qkyEuVM0g6zmbfh8laGQbObV9oQZI+T1IPm9TFBwwBZI9lUP8f6XW4nwNCqQIqilcgKHEc5bDlPvafCnAH0/I1PU8s7iqGhOxdGrESp5Mx+2uuyYXPfXzfe+6leiEYWrn0Abn1W1zC3wHi7FVYQ8RxNKJC4mlhfDaDfncvucgiACalOsnxh6AZpSJ8iS9Ve27Xx/woFflZ2i3XpTk8DLfHY4a6UVL3jySu68TRz5H7yZtp2GcgIFE5ald+OdNYK5qY/hCkS1bSHjzGFXaon4aJFJnAti5kozVcazfKoF2fh//7HX5yZDwO6mOHbt8rZCew7W0xV4SmNZjo9K3OstxN7u/u+B+52hF5kPuG9BwoxqEvr9C2gZ9fGDMtExsjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(66476007)(66556008)(8676002)(66946007)(86362001)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JIbUuRJBL4tXp6DsCkDMp++EGnxsZlBxWNVcPXjt7q398M70YeGhhKqtb+wS?=
 =?us-ascii?Q?Aw8rMaF63Avgxdzv473VN8x6fbE+939nDsXQ4dVnj+F7VyYkZ/WmkXI7Iby5?=
 =?us-ascii?Q?DRl1FmMdOG+np1ce1qFllZ93gbseP6CREZUirF0D3e8TGP7KB/yESFBBt9gg?=
 =?us-ascii?Q?JwotFBOg0JjQ5nPvLvhpw/TCObGTcE1sqdM6BiAi8wy3Td1tH3aZo4clzd26?=
 =?us-ascii?Q?Chfb/rHYxJG0MPdGAIRZDGwKARteMb9Jf53vNGStmJwjMY0iK3K7E+4l2aJ2?=
 =?us-ascii?Q?DrHUz8xNl6AZF/Ax4FQaHURtvIy3rnBLj/uB9NY3bQu5PnIfBkVxV1xgHGJz?=
 =?us-ascii?Q?A06L1kYNdeS2BKvlISsE7jealFJVAJaJcy2CdD2x3NfIN/cYRyFqxNazA/2B?=
 =?us-ascii?Q?+OddmnyGrXd94PKcwQ5ixRGRoq/ZZIfXnmUG8b+MFY5sx7OHitPHWRqCC7ct?=
 =?us-ascii?Q?wTXYtZF9A4Uo18TrIexn16JmQwEQSWgc2JZdvYEQgql3wh++3Cmn9PUagGo0?=
 =?us-ascii?Q?z4ESwa4CLCjbKAbIJo3A0R64xBgFr+rkgr4AGKgvgnVYOyL8rQYXPpBmUg6o?=
 =?us-ascii?Q?bqoMTpgisbCnuudekQcHS0tKbS/3Lg1rRilz5lZg96inbrJORGlPsQbXm1qT?=
 =?us-ascii?Q?ARcYHUmw1mj8QQe2cRwZLaznEAGG/1JD96KbDeMllGcjlkEn0DU+osVl07or?=
 =?us-ascii?Q?R3MOkzovMYiOuD44zbK4yreAec50yFqOr1I7LJJsnQw7JfczAHyQOCNPrU8o?=
 =?us-ascii?Q?p007uLUTkN0XHgVnB/icp0ctHaNJ8UE5RW6XrHEVDbCXLrnGCzVVsM/e7v4U?=
 =?us-ascii?Q?OcnWY5fJvP8+HpngZbJbPVKq6LKkFFdPR7jsHSs9Bgz4NlaraC9puO0q7BUY?=
 =?us-ascii?Q?2SjiXHlO88hn04cBl3WzM+tatSlsFeZe9/UbiKsC4yEvz7KtFOt0yTNkojBL?=
 =?us-ascii?Q?RIS3KBUKreOdQ4LG7EdifiRJ8KQeusPvYLds2m3wKI1FQp4Ak8IBBpBOK7ud?=
 =?us-ascii?Q?eyDULDRgkXrqLzC9xg3h/O9f6J2BALtFCZ+HvtbFWs31zroaq7/XqS50xnIW?=
 =?us-ascii?Q?FyqFpjRPInhNN8WrysjgDg5hTZEviBjBORHOLeGnqtiC2C2FWeVtc9HrsBFj?=
 =?us-ascii?Q?5988altEoQK5MpLM5SOTxSTB1vByP+Y6UZ9bUXkU9G8KXDlkQ3TtLIZUD0d0?=
 =?us-ascii?Q?WnX3NBJBs16ykHK0qX5xZ+HIe5obJvopszVQZlw+ZaryffNjjFH0MREH6aD8?=
 =?us-ascii?Q?yIa8q9LHrqBckLxkNNW2tghOJcGd/BjmQD/YxmHChgLQR+5u+FVc9FsrL+8Z?=
 =?us-ascii?Q?x65or1MQOdu8ADg5rj1Se+0qaALSThpIT1oF6QBIouIIYSgIqZBSw1E/27xx?=
 =?us-ascii?Q?Kv0zp6RYQaIg7Wwpv3IbnrRMZhfvtC/Gi0U5VLP5RiqXo1dvlgvpK5X5n8aS?=
 =?us-ascii?Q?xm+jhKqPp5gA+lGQtpiJzp2PR25uUBG/KWeU5aq4kiLPb2NpRGMBcsMJIYEQ?=
 =?us-ascii?Q?MzPBG4FiFXF8nkQLbO3abj8dleA8Y6YDmLusd0mcNnyeGMi02YQIWQSUomQm?=
 =?us-ascii?Q?gFuCRj331PttF84SW5zYymrHud/krhKKlUfyU7iB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdbc4dd-bdd1-4d32-dc2c-08dab31aba30
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:20.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzbNffWMJe/WatScRNxFrzJFN7rWJYbkPokA3l8ZKkVO2kt7BVuznBmH82sc8twvaFgI1nInn2JodW//f9zJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7294
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

