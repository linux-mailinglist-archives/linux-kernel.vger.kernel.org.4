Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756015EEDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiI2GQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiI2GQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:16:16 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50077.outbound.protection.outlook.com [40.107.5.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725412DED1;
        Wed, 28 Sep 2022 23:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azb1E0RDSCiKQYMIXm66o1wVyO3EEQvJrzWWQccCNO7AOkZj7LllPx21XFtFCIb4WueUQHBuURbRWvtdIIczeMMVd72a72SG9FkooTP2AlEy9hktA/B0Rb17Sm2BcBPDWm5plN2igaX9kmUkD+jbvJ+zyP+FAp1lr5yEN9nUtMsLHrtBam/+DzMFJS4Xqj4J+jLqFbSaAkK8qNkJWI7qvTbSBsSTx23tTqoY1d3Mkt+4AXkTSOnXMtt1/Gt7nBJPaCkOxBkMoI8KuqFw6B7PWJ7WD5G1RFt5wqdAT9tzPJ1G0cj1Bhm28GloHJLqmx8cyRn/h39Dm1w0DVlIlB2LbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrmc8GrQff+nlFWkrupevpR1x9RJfRLdngEobZCbVmk=;
 b=Q7VxGICBDjh9A5ZLn7MLNOpB6kPQ3aNcCLwW/Z+JXgnYZ03uBr8ZkzE2Cf+abbMydze4TAcNX+vZPzLxOwlCof0RusM/vL62SZWU6IFmGTpS+DII8/hy4l0FqCwqt6G/BOVOmfrpZHV0Yeu+3Nuxr4AAdDr6z4rCX/6zoyD3LFj0vKZH6KnTqg/ePFNJkYDdcOjFh3YVvCyUTX/YGQN0VTaFVHPXYCpz04xNeJMstBo9L464liLvFFSyZJLsEUCQxS6Z4W2m5Fhj848sEy4M1Wm/UJYSwSch3z+mJeEDS56Z6WMnUdpyPTc/s/JXELANXVmxQvdN8MFMthC0CrDFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrmc8GrQff+nlFWkrupevpR1x9RJfRLdngEobZCbVmk=;
 b=LR5yfa2h+WmZFNkL2b4RlP0o4aPFsEvymlxtuF0bDH5yqisSsW1Cvzto8U4nhSgRqEYaSYR7OnYnFAt413hfHa6JgUJFo2nCtl4ckknopngPps41AxRxO3W93CV41dX9yS2SsIkVOREfwpRLZSWhBigidjcNqAJ2G64rAWq2jsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8221.eurprd04.prod.outlook.com (2603:10a6:102:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 06:16:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:16:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 6/7] remoteproc: imx_rproc: request mbox channel later
Date:   Thu, 29 Sep 2022 14:17:03 +0800
Message-Id: <20220929061704.1571746-7-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8221:EE_
X-MS-Office365-Filtering-Correlation-Id: 442c83e6-2cba-4ee4-bd82-08daa1e215d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWAZXchNaMnUYY3wMJ9PHyEFfgOsSYO8G5yweD96VR8cMpSd2/MvqZWy7dWjuP9+2IY6Oec486aNqiXkR/DvrgnELnI3BiY/2aqUbZv8R2k/xs3Nbvv36xwCqXGfStXB81WgqWS9xyC/NFyBD0c8zMeX/aeB+mRvIu4nDM010agrk+KW3Ot9LNF8c6wqBOryqebWhuHYDZZC/bRJ/ricCVA4AtnkQeollm2yPRP4QvWfmq9HcmJaHvR31zgLGFGKUPIhyGfjuLCYXlJRGCOSXNc/ugM2D7vJOigRN5kNUVuIuzhTP8PbwI+bJEMDdBWhLLh2TjPCx0a9gSZfUCjw0Cdfj7Ridrw9fqPNiscfGXcFPPL7fJG1nHtkKJ2y5DsM/xZ6ileCvp5Uz1Cd/nEJIRHejpAoTgjC48+4YoFBwatFJcg9/J+C1QcYKYdtL29BG743C63OFemQ9bCxwzPBXu80dfx1E8LBEctQf6UsNPT/j7Gt7p+teFjB6wwvo4U3BY2w/Hf48uf/qwlwzXuakGHjHKLRYwU56ZRhYJDCb+UpI1Do1LQC1VxP2f/aFY0Go1r+tu6srv8b+XjTrK5vLPNuTZWaohjn08qhfU7UAhQZcvvYyTa5XR3ztpO+P9JmEzmdR4xftcTlUFqJV6aQM8/EO6Q0j38ppoUoMI0mjmMGdeytrPssYkN2a3/jjoXkgGsqkaMJeiNRiaLVx9ghBccmOY9Ly3BW6SErgzKbqzCmYwkh2VD2n3c+aPu4V7b3gZURVq+UqFlVAt4w+O72OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(26005)(7416002)(5660300002)(66556008)(66476007)(6506007)(41300700001)(8676002)(4326008)(86362001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(186003)(83380400001)(6486002)(478600001)(52116002)(6512007)(8936002)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?70miz2TnQUjbSt+I+xX9o/uJ4WNh5x5pV1OzQOZmB1Sm99CMhHwlBBDgxBLB?=
 =?us-ascii?Q?tW7kvw1w5Vbd2rzDdiOgzFBBzCJGsjOKi5QcXeZD7GYfVFizXYy/SbspkceZ?=
 =?us-ascii?Q?340xghEWFAK1CFiTAY1IajUyIcH6Qns/Rl/kYPMm5z5fIWyr0YfQjrW0cbP9?=
 =?us-ascii?Q?YEkhtqudMzdhIsvalC6JhbeOkVypOc41vNFMFLPK6Kbz9LGT0zauF2JBrJ1v?=
 =?us-ascii?Q?TQHxD/BDKOZXlzIwQ4BcDNk9DSYXPCnij9N6qC9AFW6hGuLASxmP763VdMxY?=
 =?us-ascii?Q?sboCl1Vwb4HhBrWeQkp/9Qk9i5WT2Q+IQZTedf+BG5co/dNYjiVWIlFRAXNd?=
 =?us-ascii?Q?aaq+CYyrHEzGE33Gewr0C3cQIB6v/wJ87zpxDBdw39PNTGi9WBFbZM0HIVBl?=
 =?us-ascii?Q?pjEF0y1++Zz/TKPOCyQOg4NDtJoR4ikdaVpSudLQv0nKau2Ohsu/NhtUz5A6?=
 =?us-ascii?Q?7ZcZ+pIUNXucJeKxsnLIFjihqsaw1QZvOCxrTxfpGd2U/1ayFaRTLoII3bep?=
 =?us-ascii?Q?168aaBCw+iLgthw9Nye/O4xvp5ukTkXniU2ss9Uh7yeoD93XIHF7W0Mqrc6T?=
 =?us-ascii?Q?6ARvi0byFSxc6447OLdRSX2MGLcZ6f0eYAps/P8QC9VH3S2fcmVMNoiH+Q9m?=
 =?us-ascii?Q?Dgu0wzJ3iDx3wQxr+3GZueVtqQsVtbERahMm0QciWOw7gF01IF3qXvwjOUg4?=
 =?us-ascii?Q?wYYhZJmvzA0C1RE3YXez7VKlleqPqP1CwdTpL/RpKK1t+RfECEHoQkCD/9tl?=
 =?us-ascii?Q?IPhzSv4rbd7zzAxa/VcbH0t7BJdUdZ+JN/MNVI8jBZVCr+muO7zDJ0wHyTUR?=
 =?us-ascii?Q?MCTia8kPe6oabgzxnWnBzfYQRt48tr2i0k/6KwW40HE8aBqtcXskhi5dnLHL?=
 =?us-ascii?Q?0JWzFWfazFWcW36h32e4Gt0No1WRiuqOFiEqtZg4IXEorRuK+4WtZ1qQQk35?=
 =?us-ascii?Q?w6oGrn+fTz6xIJtW4TwvlFSDw7aEQh6mRmEuIgDFkVpOkiGV2SiBYOYBDEsb?=
 =?us-ascii?Q?Qir5zOZqMUpm2huOmDlKyGIvnIhIOSZIIM6sn2sOLYapuQo1dHGpCbEOwq/8?=
 =?us-ascii?Q?BnWF67ZwOM+xXhIyGyu33Rqqvt5MR4gqyhahM5hyinZXqZPXzfzpzQLuWUiu?=
 =?us-ascii?Q?QAgym4iJXQjFSD6yaRkq/7wtA0Iec5T2+F/UxiiIju0seS+3uK5R4oi45zA0?=
 =?us-ascii?Q?7zoDffKQslaw/7nI/gXCAdNlSu5qT6e/pYJETAQXbzyJn9nVjaEkByrOEiyH?=
 =?us-ascii?Q?uh5tJzK2dxI1BpeGW2hRtwTjQhV+F0ogx3FigWXkkg0FH7nhEOR3VTD8J84y?=
 =?us-ascii?Q?sir5ydFUPPl89Y8uF7dJzkBecnQxxgpXJd6WQJWEkasKZu2t8aFItd3IgE3t?=
 =?us-ascii?Q?sYQMBsLTjCiDMJimIsQhxV1RMVmokxTMgjQeOr7vKBm3/mfFgO2JWkRWmiHO?=
 =?us-ascii?Q?JXhETxG/1iOuDBGQfHIVRDJNyMVrKAGXEXUi29Z5Dl4PMLIQWhUDiNGBD9N2?=
 =?us-ascii?Q?uo7XWo3bEHcK++sBeyoqBTrqeKLJzLoQW2eedxhGzulpjr44RH0CFwNVIIiA?=
 =?us-ascii?Q?cYsrEdjzysdJjIMV50t30ACurnINKfl7zAjGT2AM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442c83e6-2cba-4ee4-bd82-08daa1e215d8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:16:02.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvYwh3PSSOYtRJYHyWXMO2LpP8A+6P6As7H4OnyTTXaUfvoQOJ+mTYYjEYPzMSFuUoxNlDcjoy1j9bz4hYuRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8221
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is possible that when remote processor crash, the communication
channel will be broken with garbage value in mailbox, such as
when Linux is issuing a message through mailbox, remote processor
crashes, we need free & rebuild the mailbox channels to make sure
no garbage value in mailbox channels.

So move the request/free to start/stop for managing remote procesosr in
Linux, move to attach/detach for remote processor is out of control of
Linux.

Previous, we just request mbox when attach for CM4 boot early before
Linux, but if mbox defer probe, remoteproc core will do resource cleanup
and corrupt resource table for later probe.

So move request mbox ealier and still keep mbox request when attach
for self recovery case, but keep a check when request/free mbox.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8175c4c9aa22..bece44b46719 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -84,6 +84,8 @@ struct imx_rproc_mem {
 #define ATT_CORE_MASK   0xffff
 #define ATT_CORE(I)     BIT((I))
 
+static int imx_rproc_xtr_mbox_init(struct rproc *rproc);
+static void imx_rproc_free_mbox(struct rproc *rproc);
 static int imx_rproc_detach_pd(struct rproc *rproc);
 
 struct imx_rproc {
@@ -357,6 +359,10 @@ static int imx_rproc_start(struct rproc *rproc)
 	struct arm_smccc_res res;
 	int ret;
 
+	ret = imx_rproc_xtr_mbox_init(rproc);
+	if (ret)
+		return ret;
+
 	switch (dcfg->method) {
 	case IMX_RPROC_MMIO:
 		ret = regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask,
@@ -407,6 +413,8 @@ static int imx_rproc_stop(struct rproc *rproc)
 
 	if (ret)
 		dev_err(dev, "Failed to stop remote core\n");
+	else
+		imx_rproc_free_mbox(rproc);
 
 	return ret;
 }
@@ -592,7 +600,7 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
-	return 0;
+	return imx_rproc_xtr_mbox_init(rproc);
 }
 
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
@@ -720,6 +728,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -749,8 +760,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
 {
 	struct imx_rproc *priv = rproc->priv;
 
-	mbox_free_channel(priv->tx_ch);
-	mbox_free_channel(priv->rx_ch);
+	if (priv->tx_ch) {
+		mbox_free_channel(priv->tx_ch);
+		priv->tx_ch = NULL;
+	}
+
+	if (priv->rx_ch) {
+		mbox_free_channel(priv->rx_ch);
+		priv->rx_ch = NULL;
+	}
 }
 
 static void imx_rproc_put_scu(struct rproc *rproc)
@@ -779,6 +797,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
 		return 0;
 
+	imx_rproc_free_mbox(priv->rproc);
+
 	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
 
 	pr_info("Partition%d reset!\n", priv->rproc_pt);
-- 
2.37.1

