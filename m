Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC275FE76E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJNDLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJNDK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF1D2C5;
        Thu, 13 Oct 2022 20:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYfbJ7z2EJSa0KxpYS8VfQK+tBu9rlBtb/s3z7yTV5+zdpO900bnOmEZzrMeDlYT1trvi4eAJfWp/ipNBM+srU7kDukKLQnvCqv+7tZV1wMVa6nOpgujJ2rCxwN8nuvhrs7lhZth5eLmFIyjhENCNXYDlAm/uwOq+gIHZ12pEgULw6uWv06oXEUkiqQIR3Bi48eQpOyONtPHm23IG3g+LP+UpNK8mxVfbArmaWXGHyLj6tPajVDIcKuGLYgfaKPQI8G5JD1z2NwHU+GQ+gY9y+kIpkUB02lEV3XDWDQ75hqFiCQcUSZNPcApnjucK9un6EF0y1NuJurrEwBeQq4A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4646ZjJwzZP5/JYwNJ7p/Znkm54pACVl2VgFh2W3vj4=;
 b=OXawGEpbnvDiOfmBwu7r6wd0l4z183QIMjPkDZKzMFKpCbaDHGf8AuOeU0ArAhtevjHwGfMFWC6djcH9rXc5gos0DZGY600T1KsvQal9g+vgCSDN+Foc4sSgQq255s+SvmkBwzFotaZOJ/o2k/EWhPZj9fi5G7kC2YiK3MUX+lSk0i8lwUDgl1yHu8dqUiPwCPkJJIdYxyZLPQEtrigAmC3Mj83UiJEfzFEcijTxqWRT52548cuGKmWPK5Y3AG3TVqtKUP+Kn+JLLA+HVBgoa+IFhjQ6Lkcgh+sNm6juD203KxlGLm6C395aVQ2vH2k5C1OvocvsIFZm6HFZR247fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4646ZjJwzZP5/JYwNJ7p/Znkm54pACVl2VgFh2W3vj4=;
 b=DD6JFKvjDdTzrV7uhrnS88RZJTiXA17QSQ3KaaomLuDNfYqhJ85wDGCkyIwvRVb7IPzGS4qUFgkaKniHSNWXaM2DpcNG3+thqqVWRNPDUT+FdVFGL8RSed62tusxrVXctxXDU2k5VIL0lNTHYZo+y7R9cJezV2lcEwp9T3rg+LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 6/7] remoteproc: imx_rproc: request mbox channel later
Date:   Fri, 14 Oct 2022 11:10:36 +0800
Message-Id: <20221014031037.1070424-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0bf928c3-fe14-43aa-06e9-08daad918650
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6An8e2XyneoIcB5az6z1akk19KP3jUVFgWnJVwbhGl0Wv71cakJAtfPnsA+VLlJdWamwQ7CZIs9gOmDfXkxiXqJtSAl40lGsHA/3+4FM7SmFhKllufCnRO+GgDMYl1JwbbU6Mzzgw4nD6FoPiIKDc+ewmVc7Ez2wofRhhVfh7Qk1i4yddHpcM17+iZRaad8Q4mf5VdSyA9XOURuId4AcwrlGiYjonAIDjUp7jIAwpRY5d8wYIm+qz6ng9BRwMHcK+rRzXfVB9/mEY6rIBI81rnYHWrZjV3LLUe0T/vxd9oouTOyQeM5vJPPfBv8oRQzOQe7jNguWNC2velnZJQlxphcloAIqCqeXYn5OsYXrCoen/LR3ODn5t8P85pR6VEln8Sg+Fn0fv/aYphORM/wUIaFBWhxEM2mWY6H7MO4D9xnvxvallSFzh0Z5ZDZEiyA31Nbun/73eBrZIHi8l8Ae0ihF+YFY9Mv3bidxKOZNbfRvJHepv60+SQsOdc949Ry8sbtHu0cFMZOgPck3Gu9Mixc59vvxS26nvkSCtBnEyCaQb7NyJk8+kJdDyjzITgfc1pzRjmeZvig+N1FpOAJjZ0p570vwq9st5hgIpDLCz55d85lCi60NCtnogmuwvjwiuZvQKCFHUTujCvhvPTmyUK9Eng02hfTwSdoF9vT2ZHw/zAsv5H6DhL1L0BepHYqrVsCBxgns2bT+Pr2hfD6x1Tu6XbC3LipwJr2BKedtH8kVpawHWaB9Jt4jQEu5S1DctAUXlT4lGnYoa3sp8TlaQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UE0hxYcBPyUN0IHQqM0fI1Qs++IHXkSkYKiOqVvApILTVhy93zCJeEBkaHY?=
 =?us-ascii?Q?AhltIOjoPJSmp6JuGwYkqLL21EIfx1DdDfW1hOjsjMw9pIJT5PpHL/RqTqMH?=
 =?us-ascii?Q?Nn7EIMwRHsCrbUJCrIB+Ou1x5ewPznp3KOar2kaDeOJ+ChD712WnhtywDjez?=
 =?us-ascii?Q?cYMYVk5CGY232V/4XVKDo5Zeas2QxanzVk6SZzbKoGL8VjprHdPfNIGsZHbR?=
 =?us-ascii?Q?UfA1Kbvd8TIya7lPM3KJTSfOa2T/5PfgtPf/pwMjGuJr+udVtgNnGMyNe23q?=
 =?us-ascii?Q?8Rbe0Fbm3DE4jeX//TmoI+wydxay7xm9FeUT8sc//6Wr18H6h1Vbo9thRjpe?=
 =?us-ascii?Q?EYMncCNx2jGqXHGR06J7h0AIJQfYWth2pPVhVjGv7Vnsks47n+4xieh2xLSY?=
 =?us-ascii?Q?jR640oKS3vizXL0rsbMgkmjSzOELD97X6eRWB+FUkjs5GSm9Mq5Z7G7UZGYz?=
 =?us-ascii?Q?pk+PXvYKvCfXhC9npcVH6gTWJglDEdnj/4L3ukSzQO8HwEw2YEFZBNRGBMu1?=
 =?us-ascii?Q?PNcbgQnl90g7TExTs1p5z+ena+I/irsniyn/jfEIe/nZ8Jcpf380PoMjFvdN?=
 =?us-ascii?Q?MSiOPXrzJuhL7/vrhnkND2ueRstkr3IiUjEovAEgSy5MmdMFi/Y+PaUhyzu7?=
 =?us-ascii?Q?7RUgWtOvuLE9T91XMv5Kk0Ma6cGiRXLAuanAe1JsLZ7pCw5uDtCh86Fc/zFi?=
 =?us-ascii?Q?6jQ8DdczDwc962u8N1QOglhVmitMxCyb3ZhpyGc+z8M43j58X50JROHJIkYe?=
 =?us-ascii?Q?BG52bZZ/xiY1qrtauP14Xp0pn9sjbC9gfcBxQdHHppm/9EW+CWfMEeqIiWQW?=
 =?us-ascii?Q?qZiaB0rjOhDqBWazoY+ssdMC0Nm3FZNJ09qXX8+A/6W1XP/cs0vo+3pLYKre?=
 =?us-ascii?Q?yZEOuo7+xwGS2l2kbuolPPiXg7cGsCF3o8Lt0+SlEe1yDoSMtWUyV9+W4MzF?=
 =?us-ascii?Q?FGxyVlGPKFCSqjHJs5YZrCAzRi/Gn9Sg5HMnDmEFzc0jHQpeDV48mpEqhbJm?=
 =?us-ascii?Q?tQfxmQo48JWOShvNOXgUGsv2mTYUCIWkbXTFllsD1BytdUYTkancDnTRJMuq?=
 =?us-ascii?Q?YKKZ6fN8rnMzmLAaTTPQWbsjsQ2OS+gH3QWFtJvTN8C46HCnjBFbyzZWrFOr?=
 =?us-ascii?Q?zmsi5z/bMDpRAGkteqwsYbMDtG1wHhTLrssGqCp8dkT9OW8b0QazRkqHkHde?=
 =?us-ascii?Q?yV72VmjMhvMxEWTpvhPb1j9o1tMIM2BAys3UvJN9/zEk4wtlhJyuxcKBAsQO?=
 =?us-ascii?Q?y50RBzB83nvgLAKHniauntRgny2KL0nfDEEGZmKn6qATYKUsrtkhhczebyr1?=
 =?us-ascii?Q?o4lbsijp9IXH0fpJN7es2qKuUqjUAD4wGpifY1zfViVzxh4hjyfpSmSk2EnU?=
 =?us-ascii?Q?svXUSrUU0Qz+Fk+DW0V50ZEDDTO1BIWrQWkX31b5yEgxgkBmlH2Z3yOi65Dh?=
 =?us-ascii?Q?WjbbmbwZ61zmuRdLY6l0Kmic3jHcUGfY93ZgFTogMz3es2UUrVvCBH4qhLqi?=
 =?us-ascii?Q?JVJD5JQ/eRtQFhmtTqjeLDhQDHMws8GPK8C5kI8L5AV9nHdmoHJtvkyQNg3J?=
 =?us-ascii?Q?D/8A+1OtfFvHPumEf1dkdsxYRuaeeEZUToIfYUdo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf928c3-fe14-43aa-06e9-08daad918650
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:36.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHMyl2sJuX0CORrL80u2iBiGxJjRlo+Ad1wDp4R6MfpBvSyB+0+PU1fdJMpwuWLp7Hz6aBle5hv9SxjiUbw85w==
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
 drivers/remoteproc/imx_rproc.c | 39 ++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 917e6db39572..1183de84a4c0 100644
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
@@ -592,6 +600,22 @@ static void imx_rproc_kick(struct rproc *rproc, int vqid)
 
 static int imx_rproc_attach(struct rproc *rproc)
 {
+	return imx_rproc_xtr_mbox_init(rproc);
+}
+
+static int imx_rproc_detach(struct rproc *rproc)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+
+	if (dcfg->method != IMX_RPROC_SCU_API)
+		return -EOPNOTSUPP;
+
+	if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
+		return -EOPNOTSUPP;
+
+	imx_rproc_free_mbox(rproc);
+
 	return 0;
 }
 
@@ -610,6 +634,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
+	.detach		= imx_rproc_detach,
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.kick		= imx_rproc_kick,
@@ -720,6 +745,9 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
 
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -749,8 +777,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
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
-- 
2.37.1

