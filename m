Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A85EEDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiI2GQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiI2GQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:16:18 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50077.outbound.protection.outlook.com [40.107.5.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E03F12DEEF;
        Wed, 28 Sep 2022 23:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzAfp7Vn1oB8bk0GlDMT2JVe9lj29UKKvcQnZT8AGm3xfkyqdUlLxgmgu+QsiE2jdmfXo1HXFEm79aNhIE4WDlTk4N344REkwb7P7XftgzGQ0puf4hB3zfGXc5SL1nZqwlHzAVUsOFbrlxrIeD9LnR+XE9OWfAX+FDkVniY7jkMyP1NbWTZeXs4LXPZ/+eveZiLObdClwDZpGdyfNxUdziuqpQ1hKJrL3Kc8tYbH1VEVxe+1cjtBbFAwZf0ha5x25hDiAkwKN4fB4Qf/F3EenaDjCvyQxQZxrsnci0N9/Frkh1kMqjWYVTaJtqn6m+e8+q5fr5tDX0wV82lbMb0Asw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01Yg2aj2QKUmt/sWL3qT8uDmAQ61PD0nN1eXHFbFUJ4=;
 b=ZbBlPWhxVe35KN6IEhgW36s8lruPE0pCnKYk1MTN541EhledIa1Zz9WZ3czInP2JaI0cMXcjME2dQFnARSJFxi5b2qUeWIQ6nemmxUv9+B1NB9mGz/dqm8AoXo5VLlDyt6hyqhvnOq2rqYEQcgBCWXK4LpbQYqPhhBxWnjBIKMqoZy2eWCBjxF0uG8GaZwufXeHaQVcZx37sUxa7KpLPW3B/QMCbrKApvRqghPrchi8kmVj/qYy8GkoNPspqC0CTVfrKCZUwfu2mD7gGDfS+t3FANn1d8UxjhKC3trXeilevqvrvUYK4ndDDUwlpD69sFlBi0ogoojRNNHsdyIbZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01Yg2aj2QKUmt/sWL3qT8uDmAQ61PD0nN1eXHFbFUJ4=;
 b=ccRZ7wBrZVuXxsZKQ4BBIrkj89gwRry8+Aoo4GHqHKJWXd6qa0+TglcbYTCLbqJuUczihEqfVjTFVDwqOCqcwiDcMXeD0+VH9vyfXXdZlhwuR3HEGjCKgRWO98sb09JhEaT+bciaV4+brXbwLGWcpS2LWJ1dCm+DEgTFMiuM5vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8221.eurprd04.prod.outlook.com (2603:10a6:102:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 06:16:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%7]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 06:16:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 7/7] remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP
Date:   Thu, 29 Sep 2022 14:17:04 +0800
Message-Id: <20220929061704.1571746-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e2ad5ef-3fcd-4fb2-edb7-08daa1e2186a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: euxtdeM27NHtAJmH4O9Pqa9As0r4/rQWm0tF1fvHol8GCypJM2PA4G3NvFCQqjsWjaHJse55tkhMAVv/SQZWxwYBQ+DhmYqDpQIUbYvBly0MEulQTmIscm6fye6h5jT2kWMRCFxEb8ssLPKk8k4qY0S/lYR7yxSyvZA0+iEyFPPanZqfcSOs+TSmHpzGaUFLXVL7vis5w9J9Gm/ooniN2bXHuwoZSunikKLg1yCnC+UTZw/PMluiz/JwIGLIUYQUnd2pDvDTLhGWTG6LltpZNxYrlI+Wl6p6eN1TZzMLB49pZ5/S3ogeeVAeag5qyZNuu+RH0vbecXJNTm/bRKeNhXfV6Hwsffy1Kg4Lvh8ELSm9z0/TRad/GTKtk+42ZBSAjs/DjBc8/wPMO5KQTyosbQxHzylkjzitIcq58LDQkuS/xiLwAUbtGnBrdiuXl0UbLGDEwHWludJTI4H+ZGP5QcnydHnk4uSinUqgZVIv+74uTSr0paxgL9fJhv2NswcIwA90/rn76lwclRhPdraK1xNpEXPmpPCIY3K8B4NwgoLym6Y6fc7ktIhuy52ALjpZ26HpXZrkCmeuKRKyTr1Zzut/jABQ1N2rO0TY73BdNBeWd6sGEAlvwFt+Js7Q1x4KCh3krde6mBp9EgDgp+LMXHr5CmsLd1BEozbM7djfQaP1Xg6kmGAhNhoy21tdomUETM4t0qAN1L8f53238w82wKTiUskjugkHDATNxAiZgoTgd2BFN6Zz9kK8dIgRqlMUsSvI5vwt1NuZfVwMtNYcVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(26005)(7416002)(5660300002)(66556008)(66476007)(6506007)(6666004)(41300700001)(8676002)(4326008)(86362001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(186003)(83380400001)(6486002)(478600001)(52116002)(6512007)(8936002)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpzP8EeGU02CFYVlYBHua/Kf5LEKeb0A5jDDbq0rDKM0a7mU0Y5neF1tLNh8?=
 =?us-ascii?Q?xk6Bf7qus4sE8L2yShMOr0xwQkEwCIluwcXpTBu4pRxFsBsPee8NvInMRas+?=
 =?us-ascii?Q?mly9Mhqw/NSCxG6MRPTKU2AQdSp8eMRB+ryJmfeKVueiF35oRZdWGAaaYR3q?=
 =?us-ascii?Q?CnyyEYBkUBFEIXOWd1sZO0JsN8RCkOkbj6VNxwB/9n3ktM2Hh2RAvrsWVoeQ?=
 =?us-ascii?Q?YxNwrwztrgYOqvCu4ePSk6l2QPE4kFLQzEUL57pUzMksSDexpXtThMc8sbgq?=
 =?us-ascii?Q?TdvkImVg781yVl+r85lVw7rnpI1mCAOQM4SIsBeXUYK/jNi7PKHaXW9GfcDe?=
 =?us-ascii?Q?R+vXeH7y9tXxtpNTNmHpnzUJ6nE0L3bzTkn+3a5R1uuMXgVjpA9tM3xbfc2B?=
 =?us-ascii?Q?s7Y9DZH4qb2riC3M0QKxkVqj93mdNWpKNoHNSJheJx7w/vOWuwIZx2dAweXp?=
 =?us-ascii?Q?c9AtZ15Y5/n28J1rGRIL9X/bs+tV6K9HNtdwzgdRRQdLFX0sVsqz/LZcR9Uz?=
 =?us-ascii?Q?RqYju6GGi0zb8Skm0IlcE/mN194M2fy1p/clwB5GxVWPESw9gknWtdLCyLwQ?=
 =?us-ascii?Q?YvsIn6k/MI7VU8UB9q3eHQbhKcwvGL8d+6Gls01VEkidd2AFm0xnNv4PTZsU?=
 =?us-ascii?Q?6BAUqIjaq41tTbvyfSoZQ46PBksmhnv8Efxo/rXKo8OU9BfXe966N0bQ3pmp?=
 =?us-ascii?Q?7JYhB1HbP5tv2Vo4qurOkTPoSm0lNfBpPl2nEq/lk3hKfwUrbdQEAvmhUNd+?=
 =?us-ascii?Q?DbErQ7yR2jUJ66q9TbKAwkkY7VtoxoZJswJE1r8GVv8gBNhs9t6gIKLAr7Rn?=
 =?us-ascii?Q?+EDvlo6Xh2X7fLQ/Tp0QN2x2swB6+v6/jFzlqRgQAL3Gzn7y7v9l4jg/OR4C?=
 =?us-ascii?Q?zG1h9retg2QkA2xsMAvsjMpyaRWABjsmsDVe1U4fZKOKbdO4ALHfM4jffFNf?=
 =?us-ascii?Q?u5oBaZkVerxhS4L3LGkUrV0kSrDjTciDlQ/YtW7kwVT0CT9EgWB0mrrcX2JK?=
 =?us-ascii?Q?wAfTLzYOnQs0ajvO+0cDE1NQu/WbuHe/5hzjdB06Lix7BMRIttkpO0ezMc4y?=
 =?us-ascii?Q?z8rsSxQgRJnycXTfmUfV1UDx25EnBIqfRdJ2rB4Hmry9o6HDz4eu9V3N07XS?=
 =?us-ascii?Q?WvumxsP3jDAU83DsmrFkP9j7agX5StMU7ZGxWrv7/HzVGH3tN8CfRvGiZYy1?=
 =?us-ascii?Q?SLMUPUFaIzXjuiGlgNE7c8TBPUg1pH0wkC++FecA34QK0NEw/h2pD3Dq6tTc?=
 =?us-ascii?Q?DCLStC4FVOC/6JT2bdFX693D7VaC8I6lBDMll1PcpXj5SnVqDVGXWsg8FcKL?=
 =?us-ascii?Q?kU400k4uue8DH4INEns7dtamB8p1zteNuP4bK6hA0gDsgk5iA0khF9zHxc8K?=
 =?us-ascii?Q?TZ3hyWrHb2GgGZJpNAdquwgQb8aNDaqJnpOXjEws9wdDAuBiEQZfD+VTQai1?=
 =?us-ascii?Q?y5c+EOdx5A9vCYzAnkpb7sk7uIRbKVbVCXXfIMTG98tyQFc9JheOUtnRn9Jf?=
 =?us-ascii?Q?95ucE9spyCse+DHAZnVy1PKt034wyw3+YgUgVKEkFT2qMPyRwvHmOESRmeLm?=
 =?us-ascii?Q?JzZ+gpaLdZtKSwYUN55qDiMmKGnXb2jbK4eM1noS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2ad5ef-3fcd-4fb2-edb7-08daa1e2186a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:16:07.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGV2ZH0hr+l2ObDHbKO8jmuEl3LEFPhBvj6eBkJXqqbJFvG+PzaCCTvwkY0rCp6EpLSrzpk8nYOtsL0pXxIOXQ==
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

i.MX8QM/QXP M4 could recover without help from Linux, so to support it:
 - enable feature RPROC_FEAT_ATTACH_ON_RECOVERY
 - add detach hook
 - Since we have detach callback, we could move the free mbox operation
 from partition reset notify to detach callback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index bece44b46719..4057d6f33813 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -603,6 +603,22 @@ static int imx_rproc_attach(struct rproc *rproc)
 	return imx_rproc_xtr_mbox_init(rproc);
 }
 
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
+	return 0;
+}
+
 static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 {
 	struct imx_rproc *priv = rproc->priv;
@@ -618,6 +634,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
+	.detach		= imx_rproc_detach,
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
 	.kick		= imx_rproc_kick,
@@ -797,8 +814,6 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
 	if (!((event & BIT(priv->rproc_pt)) && (*(u8 *)group == IMX_SC_IRQ_GROUP_REBOOTED)))
 		return 0;
 
-	imx_rproc_free_mbox(priv->rproc);
-
 	rproc_report_crash(priv->rproc, RPROC_WATCHDOG);
 
 	pr_info("Partition%d reset!\n", priv->rproc_pt);
@@ -916,7 +931,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		}
 
 		priv->rproc->state = RPROC_DETACHED;
-		priv->rproc->recovery_disabled = true;
+		priv->rproc->recovery_disabled = false;
+		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_ON_RECOVERY);
 
 		/* Get partition id and enable irq in SCFW */
 		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
-- 
2.37.1

