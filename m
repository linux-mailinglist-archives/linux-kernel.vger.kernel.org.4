Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084DC6969D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjBNQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjBNQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:38:20 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982D526D;
        Tue, 14 Feb 2023 08:38:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XONhM23+fARMn3OzTKIhAC38+2dF9ufYi6GNG8etI74L16g6yVM42jJeVmofcb5HeddVTUiFbKbVyx/i9/mFam7Q/gCPfpXZEALtGyItQJ9/rlIkUbs638FtDqDYU5w6HyqL+dkpaWEQd3uePXJOUYobuN6QOlVA3Z7qqp00DMasrx+HDRWP8IKEN6OP8OkmqZTLL6u3THaMWx6l1pTfuAOAXanb6DVNfBcuCey0tfKE9JfRw1zG6ue611xMylAPB1uUpirv6VNR6/WnM4G/CR4Bi/lpRF4fN4wxg8ruzwVD+okG7wWATLO1YaX5iI21bCbHOYw7zQAY4qDYwE3B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAl6gIA17Mz1pK2Vil7NVCv/mqP3zIwSaDxX0gcMffI=;
 b=Gs8ClC7e2bDrcYIC/VV2CCLz/8QE20DIFE7sfycmTe6VOHryfS81DOBkv0SzES7gbpeN8VOrsE3M/OPbGtCWXtt3zUkpBqJXjWvC+oi2BJOALwsCqtI929PEjutZdp+N6ognaJd1ZWWY7GnVXTEATKD6eI3EhRECwYPe13wvMLoHTosIQJRIfdAvbsUyy/k47XqWsGAFrxL8p6x2Zqn7gDBRHMnZSRMAka3AX1I2LOCOuVZGaBIQpSGwvz4pSjXcRXVQYAmQmsD1VkgFbr3TmdHmDff01vm1G5yED/posdMy4tanvrn4Vulcc37FkuKpojwwM3pfGEhulCXHaCwklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAl6gIA17Mz1pK2Vil7NVCv/mqP3zIwSaDxX0gcMffI=;
 b=ESGpfAeHqegsV/9po+o40in+75O+/eRJ+vdVaqdAdw8+YFAHQKlb56sqS1gXwCDpI6lHuKOJcg/0dI9vb01ulGTNsI7piYA+6V2nGvLbinYdvv++9IYajDmvR9ontVW5sns5hMURL6SoLzhcKk2aM3d8bnoi32n9kQeE87Ec9vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:38:12 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6086.022; Tue, 14 Feb 2023
 16:38:12 +0000
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
Subject: [RESEND PATCH v4] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Tue, 14 Feb 2023 18:37:44 +0200
Message-Id: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::15) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: d7caa109-26ad-435d-9281-08db0ea9dcc8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcFQSQKz2BYknjAAx3UfI7170B7RpVCpoQntQIAc9v5hey9aR+PVJipwDt1DCltez0nyKQR8CztHM4YLdIBKEy/CvVl2wCIrAFp2o1Zf3HYWVN7JDVBgONY2+2rh4DgMtSU2mTvEZMPnO+fTyUMME/i1afW8kvP/3jN78dRK4ak8rRmY9VM4gVudcUojeflT0ALJ9B9mZEkrpWrhoPQAGBLw4swbgimAfVtaGeEtkgvX8Z275njOJTA7mVCIBMekEladjFB13CmcEXknvwG1wCnlfnoAUx7ePK7tYLA0ATK5Anh9SpKzeeIMTV0YJk+/ZcYpzYLZkRvCZfwAfAXcrW3rpLjBtgr4ktAW/sxuf3Amk0NYlc/BpgAZPDyab4kWDVcFy4A81kDmoUvVpnK9nwNW4s4Am3BCTr0HgfwhlVNvbzrIzKFpMaEqPDGdQNY8RiILxdn9ztl3WR1H9Iefeemkzt4+WK1AX6gf8UwKv+GTgzVS87FU+lj9s6qHH1pFDwRIWWr9OGS0RKXGmpXaac0Tz8Vj9qmSSvLItVki25TaJP2GJe8QJZd/jettb8YLuCGw6vQYf8wmNY37ljapUSJeF8qq+GTIFdByIOxJ9rX7qpsvNC6lKkoYcMNnyKJRNv6SZ7PP5m6JQoiBtrx/OJGaZn35c3exgvoEwSmWjnPsRLB//aA8eNuxZke05HISv0CsC9mtGX22ImOr/xlGYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(110136005)(41300700001)(54906003)(8676002)(316002)(66476007)(4326008)(66946007)(66556008)(38350700002)(86362001)(38100700002)(1076003)(52116002)(6512007)(6666004)(6506007)(26005)(478600001)(2616005)(8936002)(2906002)(186003)(5660300002)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dSHdmwd2guJf8C0Ew6lumDUNVqccGR74TgLdXP9yC+WRk1y7ZvOlOV3BW7K?=
 =?us-ascii?Q?aYbmnqnokWo2hIEcKobe/LNfkpG+Xh9fHIs5Iylu5S5ZX3cU2xB7DpTkr3X8?=
 =?us-ascii?Q?Qgan8ztZhdWaLMROn5yd/QsIp3ewOA6+fkPwcrLh6inHeVCw2FdC40XW8DVr?=
 =?us-ascii?Q?zIjNVpWkelDru/gS9i2HtvIXwM2QrUum25rpcc2Uwn53fBt6aHB2ZciTYTK+?=
 =?us-ascii?Q?c2ZMIi4k8E78PkCSrV528ffBL231W6LJ1pCg9VqVsNxi7QAILs8c+hAXflMQ?=
 =?us-ascii?Q?ln6jfb5Fpo46HdZryW5rW952cxtjbXSmp/wtTy3LYAsYPxuJL45qiaVCQ1+f?=
 =?us-ascii?Q?1iT1XUZEnJc9VVIWJlTjxOP4NJ535U/EsYRc1I8MuaCpIbzW99CjYxIATNaP?=
 =?us-ascii?Q?wi5cz9JVM3VZwg4fR2yPA4M6fF2v+bk2HjrrAe+O9Q8PPtDXc9aOFmRa2/tp?=
 =?us-ascii?Q?QhPkCug7enBhEDZ3lDIXXpY9mEWXsgrb6chWVJeECMAKKJxMuaq+nfv6dJ2N?=
 =?us-ascii?Q?Z9WzjykSszexWQKN5oVMPnRBjz43Ip1tTBH4pYD8pR7HraqAAzFmA2an0iH1?=
 =?us-ascii?Q?+xsnGm4phQwPy5APX+v+vzIkOIp5dRGJl1ex/jGQSjsT+G8o3AoOEieskh3l?=
 =?us-ascii?Q?/YOhkI1UD3plvn3yhS72ymBkj0LJ6vZM87n/pym5kCJowUtYOwP5z1iEABtL?=
 =?us-ascii?Q?yHi+Nzqy+JlxkHUBWuyO7vT4xYnNQofd7inqrkJI3XyWBexovPDL+3YkgMpF?=
 =?us-ascii?Q?fPoXQTgUQ4o77h0/amk+F4m1aHFCyaj3Ut8BHHeFoDpdtRWE4Jjs6ZWDAgX2?=
 =?us-ascii?Q?vCFwdFG16XbCLLnAp7WeoZ3w1PFZCB9wiZkTIvyljmxgV3DBi430fObHLU2f?=
 =?us-ascii?Q?1wBga2SQlgDejvdt7BC0K8w2I3TayaHnmwwWEF7VfzrgO9feBHR2qS9Hiunu?=
 =?us-ascii?Q?7AvuinGr4MOgCoifFI4cSJxJ+LBKKs67AEMYZtonGX2nHQ8mDGn134SrWbZE?=
 =?us-ascii?Q?Iltr0BVPif+4TLLkE3epxlrzh+v4gCBVePW7vXsKvcR2BkWU1gAA9tQTimW7?=
 =?us-ascii?Q?fDhEDPxNNeXE62/OaFB35AlyNceK5J3ig7LuBkdqZPimGLYD6rVPnHNvHVLe?=
 =?us-ascii?Q?06J2V+iEvzYMsqIuh89DOyBEyF5A3djdwglKxGLOZT//S2zbIp2wAgdfyUSL?=
 =?us-ascii?Q?MiG9BMbYxAqa0eTpT2fo5Ia8vSlXUMUYFzmmi+UmFH65psxwpflbkax0ZMEE?=
 =?us-ascii?Q?peDmvZ/mubsE+E2V6rGrwe4tIqcnqcxMgwVJ+RjkmMyJYWWXs3WtsdemKof6?=
 =?us-ascii?Q?FHx9EET+sfexxJs1d7wzg5euKZOVrCfVmV+OQ8O5tIQ2PcxsXIepe/zgbPsv?=
 =?us-ascii?Q?9vCTjpe/yLsEhEFx8c/TxbHeko7GZt0aUaAad/sk8wRflu/ft2LGXQKNRKxO?=
 =?us-ascii?Q?oTdhU0I3AK3mE0AAf9QMOI+puCIbEHRKZwW93JQVpyOvHy4R7wV+3HYooNUH?=
 =?us-ascii?Q?dYhiMhDUOaSlESkgjyNyX2Lw0VCjwNfsrxmYT5BMXGejeAS0uO9h4pa3o458?=
 =?us-ascii?Q?+rxsQN/FL29hd0N1i7z85NcEdU1GjsfXp0AFu1wKB9yLQP2xEtePwS0VnHAI?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7caa109-26ad-435d-9281-08db0ea9dcc8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:38:12.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1d2wslRmLEbokIs4LLrxAmh/u7czhFtNd7FM+eCuId0LOckaC7tzrMpfMfEyBw2PjkR7CSJNo726dMgfmQKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818
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

Added "ignore_dsp_ready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v3
- do not instantiate static var to 0, this is done by default
- do not initialize mailbox if not IPC between the core

Changes since v2
- s/ignoreready/ignore_dsp_ready

Changes since v1
- change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT

---
 drivers/remoteproc/imx_dsp_rproc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..fb69f4e8ee96 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -26,9 +26,18 @@
 #include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
+/*
+ * Module parameters
+ */
+static unsigned int imx_dsp_rproc_ignore_ready;
+module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
+MODULE_PARM_DESC(ignore_dsp_ready,
+		 "Ignore remote proc reply after start, default is 0 (off).");
+
 #define DSP_RPROC_CLK_MAX			5
 
 #define REMOTE_IS_READY				BIT(0)
+#define REMOTE_SKIP_WAIT			BIT(1)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
 /* att flags */
@@ -282,6 +291,10 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
 	struct imx_dsp_rproc *priv = rproc->priv;
 	int i;
 
+	/* No IPC between the cores */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	if (!priv->rxdb_ch)
 		return 0;
 
@@ -503,6 +516,13 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
 	struct mbox_client *cl;
 	int ret;
 
+	/*
+	 * If there is no IPC between the cores,
+	 * then no need to initialize mailbox.
+	 */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	if (!of_get_property(dev->of_node, "mbox-names", NULL))
 		return 0;
 
@@ -562,6 +582,10 @@ static int imx_dsp_rproc_mbox_init(struct imx_dsp_rproc *priv)
 
 static void imx_dsp_rproc_free_mbox(struct imx_dsp_rproc *priv)
 {
+	/* No IPC between the cores */
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return;
+
 	mbox_free_channel(priv->tx_ch);
 	mbox_free_channel(priv->rx_ch);
 	mbox_free_channel(priv->rxdb_ch);
@@ -903,6 +927,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dsp_dcfg = dsp_dcfg;
 
+	if (imx_dsp_rproc_ignore_ready)
+		priv->flags |= REMOTE_SKIP_WAIT;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

