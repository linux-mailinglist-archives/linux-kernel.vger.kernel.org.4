Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF68606EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJUEPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJUEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:15:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01714D179;
        Thu, 20 Oct 2022 21:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMIO9Mt5DRNyhuX9qi4AbQz5zekDhePWK/c6ZRIeMyhixXGTYSuRSvazseBfyupP0rXagLqFoPh3axkOAtUXovsiDHz39lyGJna2gIfxBodOVK2kMRYnTOQOhI8s3qoaE5b8ym08hxyqMVUM7I8jKfI1veydNAjCXKCmNBoFhA+ymV7VyI2P6+BZta/3hDCTJlnoS3HNuDXNCDgpz62Rg3yUAzHPZutUREpGds2l46Mivx8SpkvBPtkZeAEyCvrlBgx4wegPnjXgDnakozly+c+TBYDiNNgRgLP3s5CGqCtOBObYxmWT9FYr4AJ4YEe0sogJkm+2A4ojJ28Bqoq8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g4ticVbSfJTXiIKBwpQhaSw8lLbSSXvitD61nOORHY=;
 b=Je3Ts+4/WN3ooPe+aH3HwBLemAxt1xH5LGSX6RHTYQnGjSoy7K/4epT/Iy7oXHBRLRGLXjxQOh1hogdxaSLqAMxqy10z+gFzwT8f+BN71oiVkEQ4MpgkUjmN8aO7iA/7aI154x11JBJ+rxZ2kP7tXFSW12rkucBKW8meK81OFjriOs3jbogfBGL9i5lUlYBSOa9T5TxisAFY/sICPwOs2Y1Bs31yMp23TR6o0BScbQ6cB+eCf1rQbGieovu2vUSQ9Dd59hFvVDm+9x8P4SXmuEuErCmQV5nkoP3eyrC89MqR/gtjCPSOv7BSldbYQelLZNKjiMn29amAjMWHRvZytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g4ticVbSfJTXiIKBwpQhaSw8lLbSSXvitD61nOORHY=;
 b=F1nxB4ic5gUfO6grdTtCoQ/XvWuDMBveZRqNzBrRPFeqVgaGc0rFAeJXapnUzxwBm6DcK9KkMg9um9eG1yL+EX3cr4p8TbxU9pi5UKv4vL/V3izely7OFoM0zgBLwzi5ALaqIQriFQRyqkyHqtX6L87ua2vONbICzohJ0QqTUU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7294.eurprd04.prod.outlook.com (2603:10a6:800:1a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 04:14:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 04:14:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 6/7] remoteproc: imx_rproc: request mbox channel later
Date:   Fri, 21 Oct 2022 12:15:25 +0800
Message-Id: <20221021041526.3696483-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86b4a916-7c9a-451f-e051-08dab31abfad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oI0SH0XtUJqL8rRHF6i+EZMJk69xRX9uQt8p3Qm0uWJrfvDbmU1zgKveKXKCIcbymLNhaVCVqROltAaiLnsjAHpdc/FX9c/HgYEHsc2UkxNROLqm+AROVpBIi6tVQKwrcWUqO+XwmTWlPfdtfKbXnnEPPV5d7UOegKm+KrtgC+m/aZuvOS7SPXWaz2NK/kIVMyHzPjumc6AmKPdXqZGB857UxGZuXB/hw2HR8GwINQZ9jVx6Z4xQ1/De5jUxfNAkE4EHpIklP7HJeUDDoo9tIeMebJjrmfwOgqx47dfAhKm7Ys0CL66NxsTtx7hycItQJEwCMXsJ8acCJc3+BG8k7756/7Etu13VfgJpE7w7B09MXFPNicQsHz22WzDzKiRuS/XtPucnJzci5DwBa0DSd5wjvgO7cfb2SwQCUvmkg0IZueU8YTJ1xm3sztRhrLZKRER90ikoHw4b8hEy+Atj92wpvfTfx7J+aBpmlvTo36UjcK0ez5sjE5dtYjflIUt0CnOjc5tv+ajj/TLZ5qKr4pnH/h2LwSQru2TVKkvYgaqDsaf9RUHp5xhyGUJA/CflDM9i1UIxuzWMSR9KAszpYy6X2WEBC0zdrEjO2dzODQdAwWFBPgB/33i/fr9Lk4n4TJX3eSZlCOlvWmIwFH9q/OoeGu6Xhdk24S/b9+s+gYPAw0cjn9s1eZfuGiBjvc6mx0SAJXImNsekmKnI9JoDAqJopSS5q4pV/xAm0b6vymIBAxDeG5958SINit63VqS7eVyn/xCX6zOQbNqTZBj3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(38350700002)(186003)(2616005)(38100700002)(6486002)(2906002)(1076003)(478600001)(66476007)(66556008)(8676002)(66946007)(86362001)(6666004)(8936002)(316002)(4326008)(6512007)(6506007)(26005)(41300700001)(52116002)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1dFFDyVY/23dGzbnkWMZlgmF4KoWvXtvinX+GM/sb//NM/E/e6sZ763iNeX?=
 =?us-ascii?Q?pXebQL/sfuQ01VzFHX+je8hQ1mprtfU52AlW7eXg4lK3Oe0eS4HDpoMwE3aC?=
 =?us-ascii?Q?YyF38TZVdgxzh1UGiyKIqkULud6aYXX9b4WlXXVH68Cy6oNjcNC6z4PzKHVW?=
 =?us-ascii?Q?YtICUasP8UZUe6mBYQZJq1XV9JXFu9z9XY1oLTXs77b4N8SewGEhXrAWi31L?=
 =?us-ascii?Q?+AkQeTZWMT9QwNV+qHcO6HV2WTa83/WEclOICXw1TQpfFFFNIjXc/7tT+tfL?=
 =?us-ascii?Q?SO8jmaDALnFDOcNHn2J0ggce0nxJXrCHcKGBThJY2hFo+UeYSnTeF5sdylTJ?=
 =?us-ascii?Q?e6AObYO5nJzUcqPiV7ecqGv0Zs+5xzwx03dJXSfonrS6mwEksUxEz5xhzsI6?=
 =?us-ascii?Q?F0ToRpNqEie9Nw8Y1PN7JNXOXUvM3XQLe7RQyXR3NZBq2SBVbrBKgPqzMGYe?=
 =?us-ascii?Q?zDVSaFdVi8n3Oi/YpXPU3Mhn7UDGhdfo+veKUkY3gh2sVGwBGyCAJv9sjYtn?=
 =?us-ascii?Q?MOSNdJY4Tu/PUczHDlw6134idMEhmrL1dQGVji7NmSmmi4YR7ycTvllzqu9w?=
 =?us-ascii?Q?WqE2ynd+thFMMpK5vvEZABMTPm3p6Hz335T/R3zDpseT++aOjWUE86GM8pt2?=
 =?us-ascii?Q?ge/zDSnmFUQXFqJPq91BHG/X+GAR7syGa8R0UagkPNwAmPzuk0Jt8SxE8AEV?=
 =?us-ascii?Q?oQE7YxO7g8eGFsZY0gD5GWO3vh8qfW9uiDR9S+L29RhUvBkrKAXXX9ycYQOP?=
 =?us-ascii?Q?klfiLlIYWPeZ2+VpMeiLt8I/VWqeWrLwOXx1cecj25Wrf4X+HdoVAi1rjby0?=
 =?us-ascii?Q?8GrU8IO3lfJFy8ImK1cAs3Xy8ahjdC+kfaarlwFxF5wwXCrXUvkmDt7tnw0x?=
 =?us-ascii?Q?rW+6ia65hZYcmPMU3+8/z0sSXYj2wJzo6TMRS7zrJfLw+OXxC7N2Jbt8pjCv?=
 =?us-ascii?Q?9aQgQEUrwHn8oCk8XHTSPqquBjWnbp/Q7BW6BV5oYp8jpVIFOwAZfCDj2aZu?=
 =?us-ascii?Q?vdymAGJpRkmVrxDlWos309axb6nD+1J6+CqeaunUhDlEn1JfjMHWAjmVDWlQ?=
 =?us-ascii?Q?lihEe4hmKlokLYkiYwaERDJwdkdF2cNmyxeJNg0fGjOSzR4UFhhl/IahbIpn?=
 =?us-ascii?Q?r0yuCzaOPHfUkxLoFR02MudVm66kLj+YM6WRAnYDpEt2TnJaWOcs1r21C5lY?=
 =?us-ascii?Q?qis7Ceh4Wwo+KBnSIjpi1GHJ783vkDjUhZXVkPSSeGLgoJwOr/mUbKTIGPQ2?=
 =?us-ascii?Q?noPsRy/qottpoo+2eLQfLB4ztf0MYCbUAWieDaCZmAiM4HP7I3G0Lo1ToKAU?=
 =?us-ascii?Q?0qblBO+9KErqJpBoARFQwAE1hirKuL8v24C/Y1VFFun0QIQb72Xbwy2mHtpm?=
 =?us-ascii?Q?aZ/x9+ntcJzTVl02JKwDu4sCu9pV4hH8JRSxJqrowAHpE+Vt9x5d5fmk7auQ?=
 =?us-ascii?Q?Icd+5/2bQhes7ODI/Y0Uxul2d82Mn/ZoLzlqhBw+4yS43kFjyH2CU/EjdFmN?=
 =?us-ascii?Q?gCRBJDtcR6rEemJ9gNsTQHRAK/Hrbju1j3D5hosoT73x5cTqEvo5MzaJvxf+?=
 =?us-ascii?Q?goPPjwv6QzMmglHRv7VvsUuStXgR75DC7KD4TsVg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b4a916-7c9a-451f-e051-08dab31abfad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 04:14:29.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkOCI9TE6PLvjLBUvB9qiEofaPwdCUKu5v4u4tyoRBXskfxfV5iolcZCTqd+TSP86Nux8UmWGnXaP0883lMozg==
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
 drivers/remoteproc/imx_rproc.c | 48 ++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 917e6db39572..dda4e8a12adf 100644
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
@@ -720,6 +745,18 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
 	struct device *dev = priv->dev;
 	struct mbox_client *cl;
 
+	/*
+	 * stop() and detach() will free the mbox channels, so need
+	 * to request mbox channels in start() and attach().
+	 *
+	 * Because start() and attach() not able to handle mbox defer
+	 * probe, imx_rproc_xtr_mbox_init is also called in probe().
+	 * The check is to avoid request mbox again when start() or
+	 * attach() after probe() returns success.
+	 */
+	if (priv->tx_ch && priv->rx_ch)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -749,8 +786,15 @@ static void imx_rproc_free_mbox(struct rproc *rproc)
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

