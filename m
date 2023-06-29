Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCB742344
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjF2J3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:29:15 -0400
Received: from mail-vi1eur02on2076.outbound.protection.outlook.com ([40.107.241.76]:16896
        "EHLO EUR02-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232620AbjF2J2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:28:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfpINTAskcWNYfxqLJquRL0Cw5oyyf9Y8J0AUgxAC/BpSDIUwtIj0G4FK8DhidPTHwsTYBBck8VjsfeGjBvhd4arVk/c3HawY9Q7jCmrRXaRs+45X88EOrihbJct4jrHzCHYiXF0dhC1tzjh7zq5gBj8FJIaizy4iENWkSWDP8FCLBJnZi5DtzrQ06VX3wWGyjTgodUuZFpneynHQqtWlYoYG5sssoGd9L7lEPu/jhSLNtIeW+DBLQ/cfZ/eoMwoyQA1n7Gia0fWcGNVhrBVQvcvX5B2L+pWw5o2i5/rasU2VR9+hfYc4P3PsiJfG3SdvKPx6TrnyLb7vr11HBx0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufXtIx0oKtdXw6R5tdCkNrK3lRf8lKbSPLnFmjCzzQg=;
 b=ZtF0XW04ocvhpcRf8FYpfPwkxNDMv9XMGkByDV0Gc67rrB6nAWOCTNyTOQkSHCnprbQmFTKz+sN2DD51XF18khIsmtm96CNpRivJeGuys1ZNDOFQkaBioXx9oQqYckKrHifJx0hyhmi2wMxp6YIFPpLPKxNHflUzhsYMw6+Uta+auwYnyXh/e/3fDVU2lQMGrLMOL/YVbUYRkn24yWOj5HQS+MlWrw8lQBdkZar5nwWCx4q8tWEpUHtpuqwB7eAQrhGm0h8hNbWvEwBasmebh5y2Lkm5TCzd4ayDoN/6q5/xhboemPIiXTp1H8Y8BSBezb9I3eDCr+UQ8e6+BuzJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufXtIx0oKtdXw6R5tdCkNrK3lRf8lKbSPLnFmjCzzQg=;
 b=S5qLd3M1KCbW79WGJ45MXhdNQhaNWqnho5n+L3LpWyP2YYorSaMuKBj3C+lpMJ7bcFbTpmJ2pNJpqgMs6Z+mYBKnci0Tpf3GGNKL0tUolHroI7z47ou4EtY3eFp7R1xASFaW+HGbxMtxsKKZeFDJg/VTLc462nIHcNEHY1u9AU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7608.eurprd04.prod.outlook.com (2603:10a6:20b:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:28:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:28:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] remoteproc: imx_rproc: iterate all notifiyids in rx callback
Date:   Thu, 29 Jun 2023 17:33:27 +0800
Message-Id: <20230629093327.3376308-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2746d1fa-7abf-490d-710e-08db78833967
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2+JRqeNkWjsL9PVYW8oT5uDSFcJyQzrleWcwtebIGyV1xlMKoZI119IHxS+CJ44aF5T+7HtpGsAuQjr/dU36f18wqLVkl+R95sv1b2kZJkyT/mb9Axtr+9gZQOA9LReGraz3cnA82unxORiOEwXzCBDgSAUwgfpL18QHcYCcbibWY7TOshPgeFsd4hYumZclB09Nklcm4hjklkcNUtkJ61r4Q61K0qBi7M8dP7gzVI9dbvZr+3P8ecvU0s5HKv35+ecf+BOwk6xlTjV5D9wKAFJxp40vSX//MtgAGANumKECe5lsxoN7+jt5sPiFJiNbJDRn66epUeQXysO4VaTCByP+Ev9Cari2fSlo5gMi0gZAwzZz1RhXwAgnEHakP8EKpZfdHfbrDv0u1nlTAYz2Ej2TNuRirkav4RvN5Cix9nHJtfJVO5ciQSgi55xqoWDPGwUjmVKXWkYFGAC12U63kKxniWtYy3xafVUr3FyqfJfapElQnKHm7bKUcTmpLeRTVq0LHyMbaXjyClVOuhHofscEKuQ2DBUBGQp7B6a/eOEh6fD1Xuh5QRvBRl3hkB5Qq1dB8xI5TQtc5Xe5CpM4L9/CST2rjtMrtSjWHDEclPRCBbn2vk4QjnPYBUk2jgX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(316002)(8936002)(8676002)(2906002)(6512007)(6666004)(41300700001)(6486002)(52116002)(186003)(38350700002)(86362001)(6506007)(26005)(1076003)(2616005)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJkQHKCxCKn9Mizxx1BFzzCcneE3Km1TPBEJ2ur8XOnaZPz4kfO9NVrH2U8R?=
 =?us-ascii?Q?H+eMkbzKd+db7B6EG+fqBK5ggbrxAkHkzWO5FCt1VRMhVNlVIyMHFpRL50xL?=
 =?us-ascii?Q?PxVow61ls41dXZ4YJZKwNbxfyr3KfSS259Dg8yi9qqh49A6iuCs2YVuQKAmo?=
 =?us-ascii?Q?+K1x3MVevAYLMFpNKIAxrNc7PDJCHek5uK8IEPPsr+DJforZOGWScNCorWIe?=
 =?us-ascii?Q?7c+o4c2dC3Pz/f2AXSs928LH48W0EPZ0wfivMo6DyS7HTgmAfQzeOyNo4fbA?=
 =?us-ascii?Q?1vNN/d3FHjtCbP+EAlpKR6VJBEg+x9bDxghPJQD2CyP7rgrGCleJUS3L+/XM?=
 =?us-ascii?Q?A+rVQOGz1zp2g6Gjayv5/UhJLaConFELrjtvdnx/BwmbX+ANEbryE+lL2Dh2?=
 =?us-ascii?Q?o2jqytijOozCbnDs9Fwa7/r2Rafw+C9Sz0py3bWaZoRN8gecYQ0cRQD7huTx?=
 =?us-ascii?Q?LrLS+9kTqHlHtolsgV2LahHPBHQUMxdPtnYErWi+bc3DfK6Hm0RewKvOIbjJ?=
 =?us-ascii?Q?erT0hJmTYb6a5ewJ63O0DzwG40tS4acqYxzlpBYmyrAo1FZk1gGZPa6rOO2p?=
 =?us-ascii?Q?DcUarklO2tXZvO9Y1NTF8BByJb5+iq/QtzWgki5wXl+jh64lMyQRrq9ZRHaO?=
 =?us-ascii?Q?vd2LWRZpnsaiSJIcCYD387nOwEHKFRObUbfJlEFdghAUA47jUsQgr5Lahg36?=
 =?us-ascii?Q?kcFQOsaliZH52426S9DNBj2rQnmX80MiQNSx3/YR93Qg0eAgQ4ufOFIsm3/9?=
 =?us-ascii?Q?w5+fStSAQRLPKmvalPyC/ZIgFznJCEJoyUwAZ/IgJlOBMLnslFIYJ1YB76p3?=
 =?us-ascii?Q?fBT+LjS6lzs3T+x0pPIsbDxZk3LgW1bYKGhKhqKRRjKkW8/GH89UqwdJQrIZ?=
 =?us-ascii?Q?Xa/YOdueFpP8qDfB/wgDZ+XNsYwo+YTpOeDFRMoARIdoSEvJgZbive/kbakl?=
 =?us-ascii?Q?97I+HGGKX6FEOWsE7A2fL3rncd/NxqwDd4alRuS+y76r+WNTmR6HNGTc6ExD?=
 =?us-ascii?Q?4N2NuQUeQwsiSF48FQEp9VKugYTJY7YoYxhsOdEyzJsQjvkJuTPedeg5rvC1?=
 =?us-ascii?Q?ecNR5IXW2luJ1HwVmyTbxpM4r6UQphtJR0Q/Q67UPc0xgS8kd5SAy+mcu3mH?=
 =?us-ascii?Q?7Y6DKeeoYeTnOQmi8Z2/begdbJ7Jho/112WrNMziMdHVE7oHyNWS6rOp6vJD?=
 =?us-ascii?Q?d9av3KAXS6AO38+j1+lW4COnESuKDhqdQVeGCkfJh9jaCyMLxuztAFO53rdj?=
 =?us-ascii?Q?6jMjk9i6hEiAhYnWRw3Dgi3iaoOEq8UK9EELDSV+nfpmP2/4FofhiIjwiQyZ?=
 =?us-ascii?Q?FKJnBWFqBfyENDYgiNRwOzrvJ0MSOZAV7z1ZGQJng8dUGaO4h/xptUx2fCji?=
 =?us-ascii?Q?AWUOAgA17aSw+BoqGajZx7Icb4lg5+G1YbxmpE0R0fyoLnLpFDBiWYZVm2A0?=
 =?us-ascii?Q?O2W/LCJ/gefQvByeL8n/hzwcCJ6gxT+NsPzMSwfRuAyRhSD6XvXxNYGZUZVX?=
 =?us-ascii?Q?XJD3DLYb5CBiMute/69Lylnuv/xxOrJgG932qXVnD9BjK1B+oxOw1Tzx6ri6?=
 =?us-ascii?Q?eC4NZ9NKxQIufiJRpYcH3iJEu7tTsdgvXC+4dS5v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2746d1fa-7abf-490d-710e-08db78833967
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:28:40.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB83yAdqQYbu9bMFTj0FNl1HceuREkdP4suu9CCYX5H2WUESyDHv1/p9ZUHKMXgrM6YeLA/g8GxN+CaD2OBPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7608
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current code only supports one vdev and a single callback,
but there are cases need more vdevs. So iterate all notifyids to
support more vdevs with the single callback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Drop debug message in callback

V2:
 Update commit log

 drivers/remoteproc/imx_rproc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index f9874fc5a80f..986d3db81596 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -725,13 +725,22 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 	return 0;
 }
 
+static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data)
+{
+	struct rproc *rproc = data;
+
+	rproc_vq_interrupt(rproc, id);
+
+	return 0;
+}
+
 static void imx_rproc_vq_work(struct work_struct *work)
 {
 	struct imx_rproc *priv = container_of(work, struct imx_rproc,
 					      rproc_work);
+	struct rproc *rproc = priv->rproc;
 
-	rproc_vq_interrupt(priv->rproc, 0);
-	rproc_vq_interrupt(priv->rproc, 1);
+	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
 }
 
 static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
-- 
2.37.1

