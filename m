Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BD66D216
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjAPWy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjAPWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:54:23 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C927991;
        Mon, 16 Jan 2023 14:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPsp6Gr2VP+RAlmanXDn2l6dLd8yxVQtCwwe4/04MCicGR7bKcLWYG2fFR279v0r8kQrdVSd6JdrVbmIbravebAYd+JyJtiGuPKHsAYlIGLnvOvGARUUe8rIz26hRMcI9wZzADaRh/BrVXSWqvFZzfb4ljOwYqxBqN/z1O5HCoob5QlEN1wydKFx6N0TKs0TDJLv1jk6W/l2qa/HyjGc/Ile9hCCW1asfaBM4igJ3dcT0LPed2g03CFeOpIo1FaFiCo3PwXzowVlOVAgGlWuB+FP51eXWJkurSKh37RL6qJUJIzfNZbNXZPf6ojcGPE7BdGOYInXjhpl+Uoz8ZxK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MW72iVyfS+GVVhp9E6ZcxVl44gtRKH724lhg4hjY0E=;
 b=VQ5D5F6koI9O8983r8G+3rTg4Cp+gzW5aovmIfmRVOvu/h+Nh4lJfZa+Omq0PAP2v5lGEmGKzjuBp4XczW5a63F5O6L4MRgdOaS3/OgcMZdY9e4RDzZsAZHVyz0WEDsZv0U3EJxBYczUgoq968iZKSDzmCLfdhwVXBYLMLwpMFTRxjeqHcdkRS/xNX7zroLKAS36Ws8+afDmrP6JOKMip9nwDxa9nKWJncG+oULwa9cQN0cruH4BXFSna2alkDfMuoCfO9iVxmDTffXDw45319chYDgVkxHL666RqB91gCpK74W5sXXov/o3rKLhe/IXIuTH8GDR2bjnG39IQ0IIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MW72iVyfS+GVVhp9E6ZcxVl44gtRKH724lhg4hjY0E=;
 b=J/nHiiR4VmlcsLtDPvJZ+YskJ3tcAl0orR/7S8RWPBxv18jB7KpbptT18XUlAtYBAaG9o/pzP9oUSCHnwjGvTTtk7jB/OiZjCEAmkS6n/zud2IdMsCy5ToHNLKVYr55qHj1Yylyle2n5ghAskyDBtiVUuH+LftubPmfaUp9D2Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PAXPR04MB9140.eurprd04.prod.outlook.com (2603:10a6:102:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 22:54:18 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 22:54:18 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        SOF-Team <sof-team@msteams.nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Tue, 17 Jan 2023 00:53:43 +0200
Message-Id: <20230116225343.26336-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PAXPR04MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 89519b81-dc6b-4809-2cbc-08daf8149901
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eH/H7RT1U2nGMHP5DKohvf76cI6AryJVVIhA2zSmCcY0s2oOQlRT5K9dXLqAMHzdFwXJGq4OjLNEv1cjAkN2zpqvUIYh1NMN/ne3TFcOySSdNHb3D3BKev4JB2v0y6frYde8MpSY/4Z0OCDYNg2qD+9m40WR8VLb25jMN3VURpSwXmwC6C7tTSJgjOLKl6niwahobg2gFjlN9D+2sNKmuKqKpgdTcB9erHGVLJ2vxxMdjjeuevYfkFuVbTKNdSu1QXgkAXsBHCEcqePWGaGLfhxxiAlUAWRe+/0FcClxEXAUGzDcMsF/h4b4DA6/jguqVNbu6U92wNjDKlhu6UgaGqo/zhVBmAm4F92deHti1SJ6IUIOCqUmfNfNP/xMLEai1wKC0GO227DjIEFEKGEm68lLTrYQpGFx10wGBWv7g0HsVaVVnUReHC10TiKxCnXX/nI5TClKJkHNEuAVOWdRVe7oLxTUJiUt9Oo3N7Z2y9mSZXN1ufL0Av5t7NxmwDFNcRGcbAVJRKrdw7M3AdnJQxbz15B9+Rdwf6U+5oBLOaPqxOm4mVqIgZep8jvYRrmBXcnsW5FzmTKXjDtjPl9aXeq5qjBxj12W4MqwrpdwULceKROQ8SXHePNU/EUgcn4bK2QnsJ50fICDE/SNqgO0WreLRpiKEYsRW/x8Wcbz62BnAsmQhzXYEfVS+1P3aXnK8rP13nR7+0E712uHyKcWdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(921005)(66556008)(66476007)(4326008)(66946007)(8676002)(8936002)(2906002)(5660300002)(38350700002)(86362001)(38100700002)(52116002)(478600001)(54906003)(6666004)(316002)(110136005)(6486002)(41300700001)(2616005)(1076003)(6512007)(6506007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZ9zYIgcUgKnwJ1TfOs562b7bzgevdBm8/s+HKwqx9E9xxHu4QsRWgtdF9oP?=
 =?us-ascii?Q?8DhbZgambdi32yzO7cCVQZdtwcKatmy8/i9zxAkaxa40gfToa7aasW7fWXIz?=
 =?us-ascii?Q?FAS9Y8i66nWuW+SdOSDTacWBaNrv6DGEnIw4oJSv37XyEpPodKQ3NYpIIzMv?=
 =?us-ascii?Q?Z/yYPSsMpAHSogXXf46RV6069aFqH4FKkC2Jmfnwegq20Y7tgcu6Ec5In0vQ?=
 =?us-ascii?Q?cKk193Rv96uQlnOKuH7O5w5rJZ1l9VA4V7qmzydSV5GGZb9zrsZElZCdOubL?=
 =?us-ascii?Q?ahT4F7RrK+3pRtLTXHDu/ScTxhPZ4Q3Lr7DGWGrsmgaiyFjWxzo/Lxz2X5e6?=
 =?us-ascii?Q?nvoxHvP/6rm3kRDMPvR9459IYHD3c1K5SwIhx2IMeajG+b8aqvxluWHL5WcL?=
 =?us-ascii?Q?S/0mumks+zx8Y+1jg3q+QXMHi1Wv3H+suBRpyiDa8ygPabg+6MznG5r7qNJl?=
 =?us-ascii?Q?ZP21AkeHBMnOEJ2ILZjM7XLOq4WDQGPuuf0DAM0gho1S0Z1fIsVRNeax5g3D?=
 =?us-ascii?Q?231eoyBMaPLBrMdQKNZWrEB1cqF8ESG8FE/9BsFdqZoZCQOudp/H6Z/9AsWR?=
 =?us-ascii?Q?rqu7i+FDs0TUkomV7JaqPWOILSiFHU1vzHH9wmwflO9GTQZYXU5zpbYP9oDv?=
 =?us-ascii?Q?pOqsRXzKLtbbjyGGo2kWjVGYjXMn1IAeKJxDQMXqbMvZBlH1Z5Qh462XseiE?=
 =?us-ascii?Q?tztrUFngdU2wWktxJTg8G+eaY8zBNX/jaNuEH52S5tKmJV5Zu4czHcSKXgvX?=
 =?us-ascii?Q?fCHWdjkZtM5iLV4aeQN+2tl9RguRpdGQCgl25BPykgIfw8cTY8kIu10a549H?=
 =?us-ascii?Q?UADd8wjLCBez9L8hgL7BCI8+ZS9jGZrKVofd7SGSxKEyi+S4i0pYYpJKnYys?=
 =?us-ascii?Q?u4InDsII67K11gMsN9X6sX7AnsBirGatTfADA3INyXJPy5jPs1IeXDbJH8oS?=
 =?us-ascii?Q?vl8JvEd+j8HF7cuNQnTEU8HESdNba6Qg4dbJRPBWYp2agMvMLVoBJcBIR+4B?=
 =?us-ascii?Q?nxhRSMFH/smQwJjS7ik+mg6AFFukQW5oQoWXqYeK1xjYUVGpKTYZfn6xFdDD?=
 =?us-ascii?Q?cAHKOO/ZOwd99kLxwlrVtHNl8nZ9zGjLjUZsftLfZYAaSWLYxgNImAlk9SF6?=
 =?us-ascii?Q?85NWxBhNjX6FI5cF7eDFFGbfsC7ibWp91JgJgEZqYjKXs8AkO6meoKxumeER?=
 =?us-ascii?Q?TnXM8H39fwAlecMzDyUwlXgpnJVN884QPM0uF6itZQNFmfWx+wJm65GFctx+?=
 =?us-ascii?Q?SJEAJCxi2PMFjnN06M1P0FvheaXUmk+apc6G0xLiiM9EMRK/xfm9HlvIUGrM?=
 =?us-ascii?Q?W9Q/sKKbwYOGwmVbLBxXenxFNf4zSjBitpxQdRUnzXN8qv0GJtIXrJrUkELU?=
 =?us-ascii?Q?wxieTywr9Xg4Xw6t6ow8uGeiHEgBspAUYpL2b6M8W5I0/rJ8B9BK4EUgmXE6?=
 =?us-ascii?Q?P2hpt72Sk++9PcVniFdjd5Qk5H/9Xe5mWcxTdWyBw7zxghPoVPMuF8tjTsVH?=
 =?us-ascii?Q?Rfz3QExUy6Z4/krL6TzTevNlcxeMyivc3U8KFIBGETTJEVV1tfzpK2ZoVhnB?=
 =?us-ascii?Q?XTmEvjXmZXeuSWhBygMgMy1BRX4gHvB6gbF3Mb4O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89519b81-dc6b-4809-2cbc-08daf8149901
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 22:54:17.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkEV+o5DaMeRtxzFX9V2XD5Q5sS0TpVWQDJbzYTxY/fLuThYs1NYjr6SAWjEKVQs2H//zAKMmcRbHSG2YTgm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9140
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
Therefore, skip the wait for remote processor to start.

Added "ignoreready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf..ec298f8b019f 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -26,9 +26,20 @@
 #include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
+#define IMX_DSP_IGNORE_REMOTE_READY		0
+
+/*
+ * Module parameters
+ */
+static unsigned int imx_dsp_rproc_ignoreready = IMX_DSP_IGNORE_REMOTE_READY;
+module_param_named(ignoreready, imx_dsp_rproc_ignoreready, int, 0644);
+MODULE_PARM_DESC(ignoreready,
+		 "Ignore remote proc reply after start, default is 0 (off).");
+
 #define DSP_RPROC_CLK_MAX			5
 
 #define REMOTE_IS_READY				BIT(0)
+#define REMOTE_SKIP_WAIT			BIT(31)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
 /* att flags */
@@ -285,6 +296,9 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
 	if (!priv->rxdb_ch)
 		return 0;
 
+	if (priv->flags & REMOTE_SKIP_WAIT)
+		return 0;
+
 	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
 		if (priv->flags & REMOTE_IS_READY)
 			return 0;
@@ -903,6 +917,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	priv->rproc = rproc;
 	priv->dsp_dcfg = dsp_dcfg;
 
+	if (imx_dsp_rproc_ignoreready)
+		priv->flags |= REMOTE_SKIP_WAIT;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

