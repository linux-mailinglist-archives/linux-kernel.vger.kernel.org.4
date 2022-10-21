Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F050606EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJUEO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJUEOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:14:45 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDA634E;
        Thu, 20 Oct 2022 21:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwvwLEvKhgQr7OYPaNXb6rGRQ4c++gi8sXS8OeJczm+mb0fg3xQKPjxXWIpvUlOA1rcIakqBQOw0mIoHnkI/5x8n8dreQzcL3mQrGPiIch4cd1dyUP3QhPLrFXDztGTLyIZgDyGtAiTFwpY+9wBc7F/55rUk+WXGocZTcDCmQwumetZ9330Ia0WcswApECRdFFtDD34JyJxEmwaRasRwXfEH67lSvq/hy7Mr7yc0fcbtd6CSCicdDswd597Kg9UlQ/UPjmZYeNQkUnKbxFyD0HUYqjWXZOjM35XME8mhLOru6Q3+RCaKwEzS+Enzb/NUgGOi/NIZxlsmM2CT4ADb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJfWI1YzYlvXMQs7TPShXS8gSDh/xbrUCZxc6bIVzUA=;
 b=CbgkVNYHq4DKsOqP3g2baNn1Z9PB/9mtjAXLUgLXa45dVSHiSn7uaPDBCxqMS8xH3agRFyv4CR4/v4q5EZ0dAdj42L2YSlwmNw8n3Ri0TfD1BOAgFEuS80fY0GtjvDTqndGGcBgdpDBbrhxP+YvxrJ3K4yP87mhGMmuiOx++00V7mllKTJSNcRvl9BYeaCMYmn5p1CGmyTELh4bCwMbEoGCJWxwQynzYZpMtNE4sVbdPV6JM/p10Dcu+JB6QrNgY7k2TY20NGsap+XQylNp3Rw+XfqqoSiaNsQjK6ZPx8QlJkDjazDEOXO2jRL6XotMPv/T4AfdwNQctnM5zK1hVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJfWI1YzYlvXMQs7TPShXS8gSDh/xbrUCZxc6bIVzUA=;
 b=MS2ZHy+lnhKpOMe7ZeI8j00b4DoS7dFnTTIDXA8vDhveRzD2ydvJbAq1/mGypDC19qSm0H6vGD1iYajqGgKyd95A+dHs44fg4ifuGdT7AK3CUArO4vMP9PxFU4Ug823e5B20PqqYryNxiN7GvV1se+TkWk9ubLGRcfwSGIgoeXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 3/7] remoteproc: imx_rproc: support attaching to i.MX8QXP M4
Date:   Fri, 21 Oct 2022 12:15:22 +0800
Message-Id: <20221021041526.3696483-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cefc7843-a1cf-4461-30eb-08dab31ab795
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/66XHy+QVuZhkalLA9FIYzxaQtiMUyN33m2zY7FCR2L/zTLQID5JSaAukDLuM4Fdu/iHXbtrev2vci9vEJp/lFeEBzJlGyd5yMgYnnNFcm53fgCY9fOKBbRe760uIJNEDIrdkxrdHEKIU9zGCmGV/7apNACR3iiA63NknUgkeSWH/QQRfAZleoJEmJTF0XrHwNk8WhR88CBFVNncNemD16nFDoYvDmrH4XvyTSvx0lV4mrBwlejJfsHgDzRLKNCkShE/MXlR2ofIlPsoUJidVcwKAQ54KL7JQzJiYWjHDT1tXB4k+YZHYSOkGXeoJIBflAG5t7ma249l5N9LhlEMAc0dnJaPAdY5X+2r76mCTJjFwcIkB/bePsqZG6QFlVI745SzOco1qgfKAH//gntnfNkAmXs0ES3n1yzvrjOoBdBc9SheAMwjaYgXabpYdyJq5TNzo3nOLEn161VRMGD/rkXE5i8C6BIcP0fmWAWpOtbNHCl8fQzLrP8J3BzRs6Vmx+3tqNJH4w3xMkWZkFJBJQ6scJMlP0b2OXBoAewO+qglzkDKLDihNWJVYj7jgayFr+Pe1SmnLuA88l8SMo3U3N/DLNjC9ieotAgzruzMcyJIEsA41bz/W/eML410lQav4SIwoLExwAjO5A21/tRjQyQQlLuBIQVuFBlvUMWbP3hw8XGM/JxcexwyfwKon5ToBCvubK94ofeTiCTqWDyVqy9xWbE1CPHE6Ryu6YXj41Kx90EKH8ZvBzjM2Uj4kUIMV3PTBYqWr0uiydeIE+ozw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(66476007)(66556008)(8676002)(66946007)(86362001)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYBXALO52xTbubZmDLTXWo9ZAkGFhZl7dlzCUgL77AvlPwKgkeO5y3+AYeRH?=
 =?us-ascii?Q?MuSzJVVqJnpHtDO/21v+q7qAUT0tN2FbC/Sfsjc3KJq78rl/H/Y9k3DKZP15?=
 =?us-ascii?Q?TJ47UdFos3HgD6ZewsuAwQudpjrOMVFWpN3A7pHfY0rAmRKvxHiurFyz8Gvz?=
 =?us-ascii?Q?k1RMDUsIqBmeWBOONFMY+nn7w4vH+XEBBY6yeREDEBPPeDUovuZ8V5Hqs40z?=
 =?us-ascii?Q?EHa67+/9eKsLfc+We/s5s4wXxg9rcHyzt6RhO3i4/wvd+UX4FXtuIUcFw5hJ?=
 =?us-ascii?Q?Dj7jySLMTuy4yphCpAhrna47g/B3HGr6zc5jJzIaBlMBWFIYMxElp1bZ6ihW?=
 =?us-ascii?Q?oS2gi545J79jEsDWuhQs8PBSO26RuObQL+59sLKV/HDXRkraVNSvawrbgp/M?=
 =?us-ascii?Q?7Gfaw66B6kjTG7SO5JZqviyguIWYv4ED+idgN37N6KtcAtYwy5LPThN2/xQQ?=
 =?us-ascii?Q?aIppSSIC86YyntkpmiN9pcroYTPV/Qt4dpgUWZtqONqvyLoNb1rKmG9drXES?=
 =?us-ascii?Q?JTSoc19paETQmheFc2TPchP+PclyOhsKB6mLhey2uYYQ8TnqezgX8gvW9N9h?=
 =?us-ascii?Q?1PyMYJZG+aQmV5aOQQMoNmYfj/KgBRnuPwllCG8LFRs03pjjq0AHagMGCZjy?=
 =?us-ascii?Q?PdKiT1UN3hIdIeCTFMRw/nOIyqAsymGaPLSnyrWbUyFw4s63QzMBJhxs7k7L?=
 =?us-ascii?Q?g93eRCMOFOqHGXhL3yn1//9TZKk0ymJA5pOsBRra4UZXrxX8EK354KY3l4Nu?=
 =?us-ascii?Q?Ulx7HY/yxEMNw4qhQzxgfQbWdi+fkxqdYLHrOHUlhXUc8cHyVkpo9IAGb8V0?=
 =?us-ascii?Q?z9Uy/iWHOAV1svzfv4LrWhp2BdoEvTan3hKLEhR31JkSJEiJmqska1nva48x?=
 =?us-ascii?Q?zQNZVdjDyWrhrSpcscUZPoq1NGDm+tlv/xDtuR981/wfMolpYJXfPiBMxjnU?=
 =?us-ascii?Q?l8Ioin/WwHmqDZM1AVhz7AHDNSivkZs7BUFmCgc0JXAM3ZUXCXUYllr5ViVR?=
 =?us-ascii?Q?bQ86OVvSBsk7Jr9kMtsefS4Wx7vzMqUHCz0OS6Xzv94Bj0mmnAK3Mq0hnnyB?=
 =?us-ascii?Q?KJKI3Gn+5wJOLYQTRH8UBn8z8fmzVC8I+3WJEeUE1MgpZtqVEnu/gfhTbNjU?=
 =?us-ascii?Q?w1yKhB05dxWXHV7finc/58Ui6Te7TjJU4sVrLF6ZkXnvR35HMlJ/RQzEMNYP?=
 =?us-ascii?Q?93f9jONwjadaOJ+fyrRR3jjgMoJvOWN2guL3hObLiBFvefDm7/4O3R7FzAFP?=
 =?us-ascii?Q?IsgHaVvtJwSSYpeZo7hp5wxRV+kZdNVvauki72Igba022sHmPl1w8hpXToAq?=
 =?us-ascii?Q?UCMRTkhdqz5tdtB4Q2nc3nt1jAjMh2uyofQlvZWRnG//Kt/+vXThMUIXBaDh?=
 =?us-ascii?Q?aLBp/8PSYmp5T4AEuRwF4RnJALI03FM8e6xIvuZL8wCtbIoESiaq57OYiGKw?=
 =?us-ascii?Q?zqtkxypEwzjOTHaA4FWyAzZJ2FD2HNAz0dpiX8mMDDpZAlCLyJSa9so5fo9O?=
 =?us-ascii?Q?1FeotGk8euo6FsVOKeYyFlmIjcBtvm82RIvXHi+dbrrEBHRJCFP7UhipfDyh?=
 =?us-ascii?Q?Z+8lEUrMUM/YvOG+Odz9FWdC1hgDJkAw+mdeBlM4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefc7843-a1cf-4461-30eb-08dab31ab795
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:15.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebD+xdpWDzzqUdYCXc8QKBTmy5wXO+BtbYJo5oEmKTwUdlYqOthAVLaC9828otGNaq5ZdFxHJbdUFE0WhYa3jw==
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

