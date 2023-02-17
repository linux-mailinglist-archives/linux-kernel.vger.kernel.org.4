Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28A969A876
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBQJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBQJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:42:53 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B853EC1;
        Fri, 17 Feb 2023 01:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyU6Xj/kmQZ63+Uig9wozDxVrR6TKZBglhPgs0nnv/Rg5QTh8xS34sK3TT+JuQ+sKW94WzGi7OAwjOcQtwRx/wINIH+IFgYbvT4H6eZWYn+8u5EarbiLD+tVXYAnQ0nX4Vh8xlP8nqEQ0w6sSy/zTVHs32oJwP6yr73wIZlq5McE/YXRumbptEB9MnptIpcabS/JMysYQDyTWuP1o9RVLHnK6bT+eqKEJ6IqxA7KUFYxZZOcPYjNJj1mKwMk3N2+m+ugtQF28cWqEMUxV1NBiuhLUzeax74vrRBAI8u/jT7lCUL5+Q0WzY+itcrX5P342V+n2XYN0lVqRkfm7nAmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFGgEtQIr7NZ6o86XoV6zvrpx7TOR2gzfbCLSDoA1sA=;
 b=UIrXd2URfvTR/k+yUp1GkwYbk1bl+19rmLWuxONhqzihkQCgz3GXi8k0akYiwLvYtzGhCTsXTRi1wxuJ4sqKxfyIlv6WoIKFnc4aBx5antC1G8tl1QlbYRyTTTHfPGPCWYZL/LXrIqZ0FoEZ0/ZW1Jp8bRoE1xdJEQIPOb4GRIcyzoHXOCIevh0lobrF0jT3/KY1Gnk65PeVWATJ63jtvHtsr/jwbflgG6WRIFZdfcR56QGXwqgDjhL+nTARtu0SQGeFnO4NEusBFT8JwU3WVACFjQNpKI5PGfcus8kd5V+lfQZWpe4LjIMtmn0+zjlAcUFutC1HOl0ZVuwTvp4sXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFGgEtQIr7NZ6o86XoV6zvrpx7TOR2gzfbCLSDoA1sA=;
 b=mT7lLnwGFLmzvN80ff5blIXObjJglow+S0RUr91LVu2fFZdmXva5SjKpDI2iURZyPyRZyo0tXN+GUyqZYQBzqVJVyIf1szc+t1mxpt/uFc18aUHWKKITKILCIwgtj71X+cgDT2SAs4qxaNJIS6/QFKm1rWdedvxnJ3Fm62ujn58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AM0PR04MB6770.eurprd04.prod.outlook.com (2603:10a6:208:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 09:41:48 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 09:41:48 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v5] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Fri, 17 Feb 2023 11:41:24 +0200
Message-Id: <20230217094124.9440-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::20) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AM0PR04MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4ddfe9-4859-4342-6234-08db10cb3094
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI/RmH7F5I3jK0HISg33RdUSVJFd3r6PsZZtA0PDa2F7b0KBV2eukBvMjxNDKX/wfq7w3seJ5qOSN+IOuxG6MVjwRDxe3YuMATyG7Le9QNbiY6neQj2ST9dQzBveiCEz5xqztzGQrhxKxske9LIETed/zKBTDIPTbCgspojN33hTiA8YHHHujvRENnw5DmxSIhjMyVL9Iz7AzIZT79iLyfeNJN+/oW1YvOodJmmCBzpst3tUKwX43K7ti2EbFCeJbLZRsZ5T+R8df4/TAhTFIRPl5Sw7wvnKgTYOkBDj7j5hyIT1Z2Qck5tphx3zJc5PylNzcX3Y73g7KsTmxVeYvrit7BgBHFihlkbo2FodceTxntiqrc503cmujfMWGhngTZyE/emCChIbkzIktwawugBJXYcvuZrS8a1fYNWxUbZtucTjsEC6fguBke7gcBxVeatmpwzAxNzbAZQAG48kwXh/6y3o7XE72QyG2w9OORmzryTZ/4Kk9vLOt043l94hUk2Awi65Pf1WWckTBa+0SFWfqWOB2MYtxJjRIkuD/5LHp4mxVKTDfbE1nUwBdskTlZJlYVthlmVv3g5wQOjNPH7vbvIqoYf5AD0HcbfxNcu9draqulz4Ky3E89ZcawSgVjyRtaTwYPeRb5u+hrNEXuSeMmxi/jaKjGiGO4AtdxEG+sHNr9uCoqXM2tW+VbxTwlEFin9yvUE/GW45DhqQMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(6486002)(52116002)(478600001)(6666004)(83380400001)(86362001)(38100700002)(38350700002)(6512007)(8936002)(26005)(186003)(1076003)(6506007)(2616005)(41300700001)(2906002)(5660300002)(4326008)(66476007)(8676002)(316002)(66946007)(54906003)(66556008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubmUShPPsq3XW6O0oDiaxbILrsnvEQ5Pn4pp1C/Ta7d64+eCoWeeSqoheB3+?=
 =?us-ascii?Q?xePCzOwuuYOeK6qtngnj3Hc1oI3xE75Yd++vLQp9nRTDok9gjNqrh8yO2oNx?=
 =?us-ascii?Q?p4PIDhcM5USS0LWleIG+FHxLh8HWzO1PulKt7ZoWQl+crixHDwmufrjCnX3b?=
 =?us-ascii?Q?gtp2she+D2OEwTSzZ1WPL+/P8sO5lU1uZnYGZppJ/64C+snsV4OwnmSgBAYp?=
 =?us-ascii?Q?wjSuV6GU81mnjSoZkMg5PlBaGRnY3Q+OVTwdZYIRq32elsNOviCVeY0d0Klj?=
 =?us-ascii?Q?T8FLw6eht0wyYHOfFcjkMObLWgt8ZYJR7iwdoN7o3kQ1BFVaFlbFRv2WMiqy?=
 =?us-ascii?Q?6GcuE/+cxP4kTfKwtDheiqTmQ/gUxVcbPb3YS2BkZyD+bEZaCiWfwuIbAI9i?=
 =?us-ascii?Q?dT7hL7hPQWpr0X/HswLGY7V8skTrmGzTDSxnNwPJMDMPa3K6CB+S4VWEb8Er?=
 =?us-ascii?Q?VAPkSHzQOLN1+I7Ru3/IREnPLdF2lWLxqfFiYjcSWnvxVGNG3owTyHEQa5EJ?=
 =?us-ascii?Q?gN0YiVgantPWCh2WYrtxYKKzAnx1VDIErghMq3unQNAaNb48r7EFAK3BywFN?=
 =?us-ascii?Q?htCLp9gv1sAo/u9+Py7v+4tDdn4BC0Ck92A4kd9ZzOFNPbLlIF2tB8VcOf6X?=
 =?us-ascii?Q?6C3mJsM7yoYRD/wLR4DSt0/UyMfWGBE7GqxkSIk4U7B5zV+c/6HRrIfWRIIQ?=
 =?us-ascii?Q?D9j+F/4lIjNfRrpRyrF8SZkmu6xduRyv9Jhg+iTySTmEx1vxhfz6KafE2zdP?=
 =?us-ascii?Q?WtT5ifrcvCC9Z8/MnrSVowU3nR3AtuuxbkRA93IjNfrJOdENIQycKztZwa5F?=
 =?us-ascii?Q?r8TEsXM9SiMFLVV/MQxmUVz2bLkCuoC04yIssE8mAn8WAbwvYDj7Jh2IA33v?=
 =?us-ascii?Q?4fwEVDPlezdt4DIzuY+HuVqr7Alol8bRQpblcfeg472sNZapHIy1dtoMAtbQ?=
 =?us-ascii?Q?9tQCkQ/LRXWZT2K1MDyHXLJGD4H7n+K4RmwQq+RAGkFPL9MKX/gDX9QhvrK6?=
 =?us-ascii?Q?bpupm+yNssTkxXxryb0YFY6Wnf6GqTuz/ZimQwOuDqZ/3Dxm3Tfe7oJpbxay?=
 =?us-ascii?Q?5bOyMoUi9irSD1b5zZftuBIkNX1QdVq081FpTiNCdE2IuOq1IxAuAg+merB7?=
 =?us-ascii?Q?wmRXp0hcLxV9gN9jNjXnfjneCrOYC2XEdJVAk1CdWEj3I6Bo3pFhTzPR9n4Y?=
 =?us-ascii?Q?SzTocvzgmWEvM7Lv3pDTUhgNs5n+2t7CqiYikg1fFFuD05V540sPYvxIzavg?=
 =?us-ascii?Q?9u+sMRAKcCJQ4ZwecJzCZoOqw0bA+UCxz31Wv8mW+0vq5TJXIdN7SVDK4NhA?=
 =?us-ascii?Q?8lBy9/LHPwiMe3aQbDiYtSEKecNgZFrsa68NPaAozWQ+oxx+30p5kZ14PKEG?=
 =?us-ascii?Q?bSuhg6NkjH888ro+KtZBE+9P3crvmlxsJoVs15Anz6H2Wvjx/7kDrp9mfyfu?=
 =?us-ascii?Q?zH59+/tjstzqYXj/SIO90JfP5wU8XA7PnfmJAyVNxt4WcCprNE9551Va9dlt?=
 =?us-ascii?Q?EqOSMzvx53c3/Y5vVtRNqU9LnpQtcUbVeqscWfOw9Lu1dIxFECBPvRgdqTfu?=
 =?us-ascii?Q?+AzrBevbKl1EBy4i7E6mUeFe5QBm8EBSXIO7xbEWdXeaWNTJ94Vf2kMNezT0?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4ddfe9-4859-4342-6234-08db10cb3094
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 09:41:48.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXOP2a6nVli1dpRNftY+PwChF58t/fdTwk0Vt6NQGc/x+XtVl0zcq0EtQ0eSIeWfPamlbaIc7G7ySU76VtqLWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6770
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

There are cases when we want to test a simple "hello world"
application on the DSP and we don't have IPC between the cores.
Therefore, do not wait for a confirmation from the remote processor
at start.

Added "no_mailboxes" flag while inserting the module to not initialize
any mailboxes, and so ignore remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v4
- s/ignore_dsp_ready/no_mailboxes
- make imx_dsp_rproc_mbox_init() a function pointer which,
based on the no_mailboxes module parameter, can initialize
the mailboxes (= imx_dsp_rproc_mbox_alloc()), in case they exists,
otherwise does nothing (= imx_dsp_rproc_mbox_no_alloc()).

Changes since v3
- do not instantiate static var to 0, this is done by default
- do not initialize mailbox if not IPC between the core

Changes since v2
- s/ignoreready/ignore_dsp_ready

Changes since v1
- change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
---
 drivers/remoteproc/imx_dsp_rproc.c | 33 ++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..85eea85b1655 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -28,6 +28,15 @@
 
 #define DSP_RPROC_CLK_MAX			5
 
+/*
+ * Module parameters
+ */
+static unsigned int no_mailboxes;
+module_param_named(no_mailboxes, no_mailboxes, int, 0644);
+MODULE_PARM_DESC(no_mailboxes,
+		 "There is no mailbox between cores, so ignore remote proc "
+		 "reply after start, default is 0 (off).");
+
 #define REMOTE_IS_READY				BIT(0)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
@@ -172,6 +181,9 @@ static const struct imx_rproc_att imx_dsp_rproc_att_imx8ulp[] = {
 	{ 0x30000000, 0x90000000, 0x10000000, 0},
 };
 
+/* Initialize the mailboxes between cores, if exists */
+static int (*imx_dsp_rproc_mbox_init)(struct imx_dsp_rproc *priv);
+
 /* Reset function for DSP on i.MX8MP */
 static int imx8mp_dsp_reset(struct imx_dsp_rproc *priv)
 {
@@ -492,12 +504,12 @@ static void imx_dsp_rproc_rxdb_callback(struct mbox_client *cl, void *data)
 }
 
 /**
- * imx_dsp_rproc_mbox_init() - request mailbox channels
+ * imx_dsp_rproc_mbox_alloc() - request mailbox channels
  * @priv: private data pointer
  *
  * Request three mailbox channels (tx, rx, rxdb).
  */
-static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
+static int imx_dsp_rproc_mbox_alloc(struct imx_dsp_rproc *priv)
 {
 	struct device *dev = priv->rproc->dev.parent;
 	struct mbox_client *cl;
@@ -560,6 +572,18 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
 	return ret;
 }
 
+/**
+ * imx_dsp_rproc_mbox_no_alloc()
+ *
+ * Empty function for no mailbox between cores
+ *
+ * Always return 0
+ */
+static int imx_dsp_rproc_mbox_no_alloc(struct imx_dsp_rproc *priv)
+{
+	return 0;
+}
+
 static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
 {
 	mbox_free_channel(priv->tx_ch);
@@ -903,6 +927,11 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dsp_dcfg = dsp_dcfg;
 
+	if (no_mailboxes)
+		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_no_alloc;
+	else
+		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

