Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C655EEDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiI2GQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiI2GPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:15:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91012DE95;
        Wed, 28 Sep 2022 23:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXaR55PnTpWRDnGMgKmS/+YyfTVQPuXPEG7JVjtmleWieD3SIlTMTqu8Ws9IHP46IVAqxn/le5MrTfe87zFZCStiUV9IczNHwAE39x+MQGj4kQ3zsSk9LsINBXCdLlKpHetvsKX1YTj2sOds/rd32bRIsiFLl8VxzuH4ANTBrDA0qW3Zlh8D5q/gJOgV7dbt+Pi9Rzu5CMUoHPP2IJabATD5CIrzwPpRMBGQdEDA5y4EE0WoD0dmhEv6XKz0gvAO1JNeG66u3dUn5SThTZ7Z93GXzxLYW/mKEHe3aKYVUssCWrxnyUCJnMpSSnDNLgSIodhu4mOsON1xs1FX0jq3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siiLfzFIYgN9GPKXpBepWlBMiKgb/ZY2FqqXi2MTDRE=;
 b=LA0f56TsSV1w62CT/Asd9yP0rSd83+DTQ/oaVmavekvK4EGVoNloAz0MPM9Qj7x3VhRAbaWDpUmW5uKpy+Q7jr7PVhikmPL6wFWjpWzbkGEmGFy7DkxFKZz1rjXkcZhiqLUNXF1BRSN7dP3/TjJBmTRkW+UJVMck5PBVScx9k4E79bxFPZo/KK/tYAGFtvezrYgfPRKH1aCQU7dTWcBRwHtG6Bc4sjtxHvN16Go3fp3z1/NO68uxaztwuBOrQMCOrhb0RcCVklRnOnDKBj7hloqobB6d42/4fcGZlvTs34ZtTsOkLP/P26oRN5ESzQTvBd5l+ac6aj81g2QTSCPjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siiLfzFIYgN9GPKXpBepWlBMiKgb/ZY2FqqXi2MTDRE=;
 b=KG+Ij0foUlcB3nJD/D+LCg2cMU7Mxy9UmaupsPKweKgNrs90gqvURNTKVQx8N14zYRPZFVNKcl0GQ0cDpIkDSN/9QkTxJGdEF4gvQJhZJgOuaVR1QPD8ht+QXA4GGFFdJjiUV8dVfni3XVMjDqQnmpBbAsX+mnfnhEgJeHeg9+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 06:15:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:15:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 3/7] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Thu, 29 Sep 2022 14:17:00 +0800
Message-Id: <20220929061704.1571746-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73bfed66-8dde-4a42-de96-08daa1e20e0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBepvTqXoqlthU69onaXbFZO/nlj/y1bWKtOB6C1XmRMdb+WqLq71AVfi4nHfcrxr2+bNR695bYQP9o7/tFZibcuSrldC1J0+vlan/dxNgiAHUJs3OgBjaLRlf0QUG4m86zDyBUqZCEbrgo7NDzV4yGhmk5dL4lmMWKbWkTMFSXfa1sVeZt8HJdH9uMxdoRABFXsHYT/ZB3H3cJcKuYOJY4R5Ha0ofK03vz9/dg2PHQzmmHNE+GWjFbP1Ss1jx11OzdpQC9YXSbH9O25YkEtrgukAkPFLhlac5BLjikk736xYueIB1q2iXq1yoI5cz8AO3QE56HRft0Vh3OrVFBXVt7K8YoY9Tt7uNVHoqkME7uLySOrQlVEQ4Asnw31REoOAef2szNfz2Cnchg83jmvAqUCxEKo1f6SQSDkSAp8lwoYq4RT4N5mBWpWxBslQ6+Bp80xSZgj4NmE31cuotSy2H542a0uoK9xgMDgCiEI+thXv5M3f9QuXZSf23VpP03AYCCl3A4XVl/TPo39nfkN1kpEHq47XJSFN7h8+Gv3Or+aDqgY+N/D/8fR0B9eQ5aQl/Y6eINhQ8+r3OS0RxGNDdTBxtmHzoDSbZypm57sYNYN0t/ZKasWVqz7g22ooncJfMWFZR3TXFfHq33m1a2WbLfCBgCBS4IimKedUI4o4hS5cAoSpJkScpF4yi5E/JV0vusxpqJ74Lh2KUjDG1GMJCjU765/yhBj3cucZjNZLgHJVZxJYO2dHcFYQ4twcFZIp+gwSTq9kMM2aCNMmM+o6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(4326008)(316002)(86362001)(38350700002)(38100700002)(8676002)(66556008)(66476007)(66946007)(1076003)(478600001)(6486002)(41300700001)(2906002)(5660300002)(83380400001)(7416002)(6666004)(8936002)(186003)(2616005)(52116002)(6506007)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qq6ZWrrwO3z9UuJBoe/VusCVRa/jDynNA6UuiOt/alwyAnjcf7s189ubQF/6?=
 =?us-ascii?Q?cBavFphI/Mkc/iSU5rLauJ1SMyIHkdyNWuomDy1LAPT9B48HZ9KXQZZFQsQ3?=
 =?us-ascii?Q?N9odDgqoAHtIPhlE+6/BvYEn3xR7LARQuxqtFTpCYUr7IR31sKrrn4VFKbNk?=
 =?us-ascii?Q?+X/ziAd2OlPYVHpGZpy4UeuMcnIt/zB3yKD4SOknQKiFD9s0Y+6Xcdnr4iMO?=
 =?us-ascii?Q?6FL/3k34l8gYkZi0rEUoGBkw8a52vbLG/Dwy7PH1bbj9425Tc1yQO6IFS2O+?=
 =?us-ascii?Q?FJ80NatSQuLxdNN/9OpCq1odFICm4d2op8CqCEVt4OjFkOpcwaZNJRlsMr0y?=
 =?us-ascii?Q?ewiwl95UwSl51Lul/LYQLPptcc9CdOLEKL/ZtuD8J9Q8LA2knDYpFzObT3qa?=
 =?us-ascii?Q?38wg4Msn08V3aYpltazI2zFfY3pu5nSjQYZjMmDMy0Qfz5dNwoTJXj9wb33Z?=
 =?us-ascii?Q?qM6O71qaJtJhD+hAwydf4amzo2ekE6yEegsYICUDueWmnkITfzkWfgclwFr3?=
 =?us-ascii?Q?p4zudy3ZoRD53gODoKIc4Yrc7xcrkJ5nB7BydtLRcEPIUHdtFJfXgnaQYap7?=
 =?us-ascii?Q?Dg/tjRVv0kRAxKnA2Xpezb5QyPkeOg8TzGomrSiho/+taiAmgs8kg9Ol9XDn?=
 =?us-ascii?Q?l41ylrRXe3/zpMQqyiz57lZViLHmiyutIrqyS66UCXW9+I1IOeiNWfH6LFO+?=
 =?us-ascii?Q?zo6SACf8RIDEcIpGR1PEu1/D3U/XrneFBSM0DQhd+xErCN0L9Pq+7vXvKWVf?=
 =?us-ascii?Q?sN1eL4ejTSM00xmYlf4RGsPYjKFdNZDzdlQUzSDmPrg9elp0viPnugy2yF1t?=
 =?us-ascii?Q?mYKaOE/bRU2T/ewMpN9um8enj9hCEjjwR2ATxXqBHBcSeBNRZWgDHCIn55xP?=
 =?us-ascii?Q?ZPAn9ZxhtLgJY9eQ6BSsvKwTzDEQ4jTMkPnJTGmm8w7O8IvkARwswH9dY9Ea?=
 =?us-ascii?Q?5cNq0DDjFukY+n5UThNF9OYhKoeB1yBll6kdbtbCdjxJkKXVrPVW3rfyyhlj?=
 =?us-ascii?Q?l36l1fos8JuO13YLuT5lJxVUU0cpGFcOyumGjxSCeUbAuXdSZDMQN3/HAKFr?=
 =?us-ascii?Q?UKKJvNN4Asoj97dQeM9cH/GeywBepBgGn6FJhfqvzcUC9ca2UfRB7sM39pOQ?=
 =?us-ascii?Q?R0fzH1jPRkSsXINWN5vXP5r9GpUrDNWrGUAw04Rvm4Hqc0JPx5UL85r+kveb?=
 =?us-ascii?Q?SBRAi+vSyX+5xEh+aFx8S281Heutcb6x1h3K93jbQocdhkhw+ROdiKDS4h3/?=
 =?us-ascii?Q?evJu9q+qLzsD8Jk4aaTUigDrTZGOvAxijUi6psxNsHDQgc12bFVAsny2GOSN?=
 =?us-ascii?Q?AO1dRKIIIK2dmNmjRwiqJgQ2T7dlK1p5KO5+mVSKUnV+ACqpWzYMvuy3OJJ3?=
 =?us-ascii?Q?hAv8mJEQXqihwcXAf+rneVUTtnqJU6jIagNEneftIq5aHBE6NtACE0NkPHGP?=
 =?us-ascii?Q?LzpZCJgQOjQqNsxeByy36raG4DxmVx/3A2vrXrS7TltrwFfwh7OoXwwM8/vd?=
 =?us-ascii?Q?PeGjP9hmnLH6WcL24TvveYOsrcPMnjue4V9OdHX7aGG4K0CFco2i0lwDPFnE?=
 =?us-ascii?Q?aklXGwgalrVsRYR3QbkyVHtyeiep6vxE7QFwro5D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bfed66-8dde-4a42-de96-08daa1e20e0e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:15:49.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBTJV3jmTFkeZoQra0O6hfXCD86Hte522fXHcEdh0gBvrn/UZzz/DMhG6KeUJebJRbcWXhRWLGsU8ol0Yn5ANw==
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

When M4 is kicked by SCFW, M4 runs in its own hardware partition, Linux
could only do IPC with M4, it could not start, stop, update image.

We disable recovery reboot when M4 is managed by SCFW, because
remoteproc core still not support M4 auto-recovery without loading
image.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 108 ++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 7cc4fd207e2d..a56aecae00c6 100644
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
+			dev_warn(dev, "register scu notifier failed.\n");
+			return ret;
+		}
+
+		ret = imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_REBOOTED, BIT(priv->rproc_pt),
+					       true);
+		if (ret) {
+			imx_scu_irq_unregister_notifier(&priv->rproc_nb);
+			dev_warn(dev, "Enable irq failed.\n");
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

