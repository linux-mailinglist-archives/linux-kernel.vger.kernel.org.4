Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B75EEDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiI2GQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2GQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:16:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999E128A39;
        Wed, 28 Sep 2022 23:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw2CNTgotcMBsfS2NSpgtdYJzTklEYBdDlQeJ7fxt08arrbCPGrAqsqOVR+NcOgrfNCIEE+rYuYvbje0YFKf/zaDxCv6AKuo81jMLG7SB/NWJ6eTTEn0EsxdFTnu5tI+nLjv86v29cJVvpCKErc+ZJg0CeaYumMuIOJZqOMFc8nVrLDWkaSiA04KaPW5bkgGrms4iHQCMaItoJ4ppcRlsamfodftYsvvlt2lm0Pi+Al+7aeW4wpp5z9JPTBUziFvnRj0fsDIRw9RBGVvzJYunzJKF96lwxhGjc3+K/kGdf4E7mZVmJkVZNEvi3FHr03QUe1FXrA0fOVlfLeGAppqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldGGpIspbke4mwqjGHf37eUjpoFCJqh6a4WohoIZ9YU=;
 b=efErvu7ZXn1z8bef80l3bS81O2dhkn9L/+O33vg11aqs7VV7WUSFXYaQ0Lq4n/vf7X6LIRMNidFaWMJDlmfx4LI12cqIh9O5w2B49vgRxFg2ku5xdk+yDNdTfi1UhRvL2BceJ0/MDczcqpYbGTjKkg7qc8GvsiCi9qliSDLINuwqtcllZS4PDUHshCG2XU/CtvaI/01JxueUCbRRNq3bo6g7P6aa654uwBFOkhKhzo6fq/mmhNnVU5glmjyrzT9VhDUPnYUOjBInT4O6VvIr4GNxicRQsbO8xufTlTvYH/ZJoz1PA0tnkbAAxhFFI+Dzu/CVeHDDIJYOjVeFC7xRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldGGpIspbke4mwqjGHf37eUjpoFCJqh6a4WohoIZ9YU=;
 b=lloPvCU3QdKq4DB3EiJUpE6MecbOeCtwDYqgHZ3Phu7/LSYB95x24MHd5pcaa1XphWuCm34I6F2CUYCEZMm3TYYXczqqnAhfJ7OTYwKHaZnslGieo8JyGACW8VZA0tQQ+Jz3yLYebcBhulZxMSl5Yx3iqH5zlGj9MAyrA0FiqPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 06:15:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 4/7] remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
Date:   Thu, 29 Sep 2022 14:17:01 +0800
Message-Id: <20220929061704.1571746-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
References: <20220929061704.1571746-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: a4109050-be61-40a4-9a40-08daa1e210bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6sSUFV9xa3gM383KPrCnuhWgCUGSYPRzkgaLyWJNz9yR44HutorcopdDTJHL0w0T0Z8W4RoF7gsGcOjaoj9H85S/lYgeuJH2o3yFdOLctIBLkpKYUfj6/hV2PC+Q1V/3LbKTZklp2fDcX99wZNAWF7PWowV1An318Osy1cew4lAo9xTmbfeqGBW1m+yMe93XiDjwd6Gbzf1grRvmO6ZXWT4F25/J6MgrKeel+aeFvjkCt+9jmVwUJrOxmAWp6sb9TlFuKSeTkhXd6YXQwBwbEZiycNUzsw3t5K+rhZ/Bc/38o6yCrzw1Tt0xzdpSoang2hVBklvuEyR6I2dQc1+Q5T52I5sqq7mBQEbSWp/ChAf5mbh7sjwcaUHsO1PqDkZuRdBE7a26pCuu85/S8zvwTLFSIwtTmautLWv9MIF+bB8q78rwIBUxwBlAXIV8LMww7uUewl7ZUfQVJXhP3vtvL/+zSPkKiew6gwxchlktcRhZRBra5fdcIEhvkhhfd4c6JveQ/UUMseKaefzRTqxh+AD6Hxo5HiwFURHFBPot6tmeD+Ng73Na4Ke+2BN4PGTM4joch4CSnr5gMwjuYboHbtqSI+uFpJl+nZmJZQsBRIDFiDuuoyNyHpkOKk241VVixijlUkUOaT7QLOBFs+/ujihRogoADJ4kI7XjTPW/8EFbVE6MKq+L3eMdJMBeaXuzPeFc1bsHw+WhszMoJtMd0nCK6LPE35P8BYhG8RwO3YLR8J5HQi6E4lqd1IIlFie0EM4TnzJp+xifyOcAR6+gHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4326008)(316002)(86362001)(38350700002)(38100700002)(8676002)(66556008)(66476007)(66946007)(1076003)(478600001)(6486002)(41300700001)(2906002)(5660300002)(83380400001)(7416002)(6666004)(8936002)(186003)(2616005)(52116002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CtDvBxxbpNRRPMHvI/cX4eIWI5mno70VQmoIOhZoCopFZ50gWeg7OGdCZPms?=
 =?us-ascii?Q?3BpkdrzRHWBVegJg9cpcuSEq1S+47eJV0UJrnNpMW4DqMlFJPgN99sN1q8lb?=
 =?us-ascii?Q?dJvbTtBPbf482VVqlti4kxaKmoDuAcYkLSZkkGfr9M8m7jNKvqiIwFN9iX+T?=
 =?us-ascii?Q?1Kaz/nEcox1khBvLqHC/UR5b5Kyq13q3l7BfVIxC2p6CSkPQIQULebNv+ghv?=
 =?us-ascii?Q?5zTLj+fg/gRp/RpS8CM1QL27VwfO948JsRThUdaPbtgKsTEFGTbryQEhd469?=
 =?us-ascii?Q?J9o79JJlMqXtbanSkcOVcyCNVIit/UI0Y/yUWvElW9dwlp65eyh64AbjSO6n?=
 =?us-ascii?Q?IcJ0+gj9keMy6cqEhpwSF6YBz0QhSqw+LfJSrvLCUzRrHtiATk8itA3MYY6O?=
 =?us-ascii?Q?v0GJrlJFKJSLPcoaY3LjtGeQJUk9YdaERfRNr9PsuGxW3Kv/Xa35oWPae5+6?=
 =?us-ascii?Q?J/UxvjZ0HJ+TGDI2sQ5IJ5uYOk/KpRzCj02NA/9+0Q3E92x0ailkyS2Gy/3j?=
 =?us-ascii?Q?p8L0y6OA3OjFnailD3YjxFy/9N6UAd0wSr6juU/r2gjqssQlIhj0zPz/T6PM?=
 =?us-ascii?Q?9q+lG9wKu/vlbxi7eQ5yUAIA61X3hT0HjFfP3u3T4K3dcXt9M4d7v8F4wIdz?=
 =?us-ascii?Q?ooQLbOfoSL+CWrQ3mPxO5baqDoYduIxTlwDhAmQuW8+vjkRp0A2Gyk1/+X0B?=
 =?us-ascii?Q?8fhcrm7MguRm6PXWXMPHVly9RpqJw1Rk2C6z5a3XARo6yhtfHk37rPbIBn+b?=
 =?us-ascii?Q?wthx3UJEY96PTUsTNkgAlfJjuxiG1X/TueUvy3G7RkqMUXA6IC/BlZmq7E6d?=
 =?us-ascii?Q?0YRVlY/m42WL8KnBIbT9Ruh2zYsPMVUPwLn9hSesUvVns5bA3xzFA29pxonr?=
 =?us-ascii?Q?3iYp49a/gZVfpNUnR2klStvDrblPOL7hM6RRmq3mmvPrPiQkpuAPiMd1PdfF?=
 =?us-ascii?Q?+wBrmfqym1qLmn02//lPyscTdct3YWvM2r+gV7RmCv+oDSkreg4JoW4zurFA?=
 =?us-ascii?Q?m/O0eaTpgwFSY3Htm8V55ozsQ8bdqLewN52+jHi9TG4mg5BvRk8kh171YlkT?=
 =?us-ascii?Q?7GDunpf4UwlViqoswHfNPgiWyt83RnNDIjLc7KoWUvKmHmUXD9Kg5+yB78ib?=
 =?us-ascii?Q?NOzXAijNfOesuU1fg6MM1H56/NuQXq5JSesET08ResNyll4KzgebFVyuQL6Z?=
 =?us-ascii?Q?0TpTTbAvQuPV9IFCFrtMMT32tPESMj4Pf1uv7q4FLshsJmqlbWkC6pe3C0Mp?=
 =?us-ascii?Q?Cd1vws6b/8FGAgKJSoO+pLe2ijSBsAZHpfXhPdSx0U8mCVwd3CGzLd6WIcyV?=
 =?us-ascii?Q?bnzU04e/uNhyj0srd3h259+oWbLufW3iinzjK7weqOWaGIlMFwKMIWUkFKtX?=
 =?us-ascii?Q?LHfyi+4w3IzInEkwE7rdMvUM+kLyxPC14Xj9BcUjTVYqByASBVgdRyQAx+uu?=
 =?us-ascii?Q?uh0b9H9BAJtDA2bismD1m9nkgW5pRwOFPY+nkYwFIdR8q8iwD9k+/JJSVFf3?=
 =?us-ascii?Q?RrQaYLQaWOr4qOtm49Q2tESMYJvtbz11whRTiSl0a7tx9GPff4tktqT6vaZU?=
 =?us-ascii?Q?r2UZnBxO03q1VNt7BI7rUqsp6uemz9+CxA1LknM8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4109050-be61-40a4-9a40-08daa1e210bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:54.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca6OVb+8o9s6d135dkKKYVhvFRIfF74GqZgMGGNQDT5GE62+SZ9p9mQ3jcQDz97TikwR8PMqYXrLvDUFXRPiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 88 ++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index a56aecae00c6..7d2e11aed0aa 100644
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
@@ -736,6 +751,69 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	return 0;
 }
 
+static int imx_rproc_attach_pd(struct imx_rproc *priv)
+{
+	struct device *dev = priv->dev;
+	int ret, i;
+
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
@@ -770,8 +848,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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

