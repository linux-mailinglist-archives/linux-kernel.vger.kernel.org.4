Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B074232B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjF2JYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:24:08 -0400
Received: from mail-dbaeur03on2046.outbound.protection.outlook.com ([40.107.104.46]:14560
        "EHLO EUR03-DBA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231450AbjF2JXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Puy2mf7OYXg0bxutnWASsYR1HuKl6+VW0hLald5PioGpl5EIeAESGg/MaOIfHV3znYGHQ+NwcsumQNZ9ukoulLpvMZbd/1waahPp0TOE00t0wEYESawuw5Z7DFffGqlNLJ/yUBjij05WQOLoZm9LD6w1WhRRPncHiLxCTaI5WZCnof12LKFhVkC2swW1tJ3a9mzR8JQrOvktqVWORIX5UzmfmFnRHvjfHlwJH7A1GFEByvm6wDkv11RkPQT/nunzB6XJP+u8A7TXs89BMr9TrYWCv9/lOjxazsk2kfew2Tv7Vr+xOhxuD9GxhA8/EDhJEZN7+L6YKDWmMXkCuJrShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnm2XpQJKdU6h8sEeuE+R3ANC6xXUSOqwO5EbIEAGgE=;
 b=NVtsQ/he0qehoGoXAbLu30r8ISU1Vd9VrNbBAKZVnFxxwogCZ/rqTBoJCf7PjisM6VvK3EaIj3VGoroqKSg8ndiC7OSRSlNfulqmZBfGmpyyvW50CqkKZp9Skzm7r2a/n4bnAqQCHTk55ZnZMy3fbMDBMwafyl0W2MvtvBt4VjzeYHGUPIjMgBeZbEhiE3o6sCzoEI0kKnt+U10MBM2HUu7jqV4BEqpgXzCMNBDl30n7iTsxjVdus3F8dXH/OBAxFNMBu9YCfKdgkW5xxdk0aB4dNqlEcV7A+xEPzIsvLp/6JpvgxviGwiOAOPPO2YgK6cNC0nGOxFqH0hwd91mKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnm2XpQJKdU6h8sEeuE+R3ANC6xXUSOqwO5EbIEAGgE=;
 b=JkNz3APNP3TuhKt/hOD5bDpi2r9W9vm6NVxTMpaJhVTAkxw8rIhShfyizXMq/nkyP8C1L4fToQHRU4/rmvz6Yr/OaWcz3yJ+D6uTWOHSeoKUIr4UUW7RPjN88xIyLbQfOwrg2mCAMZXihj7gTfhgIVQW7+QkbbSaL5iOZwSb4aY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 09:23:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:23:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] remoteproc: imx_rproc: iterate all notifiyids in rx callback
Date:   Thu, 29 Jun 2023 17:28:37 +0800
Message-Id: <20230629092837.3373442-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b70ca40-0f8e-454a-f9f0-08db78828b2c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOweDZwbS0UoWUrt8gBrIFBbOu0/sVQ/cIQD0mGlt7CbrXgad9YBFp7yZU+F+/6Yhk5QclcAP5f8DM31zNGbN9/35vBeQtE/bGrZjlXi2/VyNRNdny3qaV2mbJrPvTAD6RNWJN5FyNB4djRkNlbDzJLhTrXRQIsr+is5iWtN0KnU3qvt9TnvOm5iyESSUceAO6LaOy1LoTeyGjCdRbakX1XD4IvCXoPDsFDnww6Q/edhtiVZMxxFC4S9IXFMoI29jrZhN4/ZJAN8GTIwWhW9xHS4o/J7mbSgfrWumgAmDRQur7t6hFzKR/cWHbSxNZBxZZ0/1NTUrqP98oAcvKoeZ+aHqVcW6wuePqPaCGApsixnURT/zepmNzCL3f9qD72Y4Um4tIeEwcyRJC1CuT4bm4JUfoSA+k0IevmTt8D5NMcx8Mf+9iIu4MI4lI78LgRN3piiiXHmQoQSsxYka28uAA64Dum/aYwaFd3QZj907r6qq8njWE9WRwo55EUSTY4GFYe1TUihID/aDuJxFqcFe0we0AJ6Tnm6TqjUG50gMORqb8ygGznzUJ+cOlLWrsvRDuXcx1M9uR3vT8F5E46Fvv+bY0ilN8cptDDar8fKCEkX7CfokBNFObvZ5fl3fgfU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(6512007)(26005)(66556008)(66476007)(4326008)(8936002)(66946007)(86362001)(38350700002)(41300700001)(316002)(8676002)(5660300002)(38100700002)(6506007)(6486002)(186003)(2906002)(6666004)(83380400001)(1076003)(478600001)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbZb720yBU6Sk1hlgPHg9H0HMAvsJRRMA5OShjQc5dqC2rKL8zTI1LGJKVQL?=
 =?us-ascii?Q?5lgeEf3heXmZC/rQ7USd0ce4womIaXgKlr6LWHymbSs4em6cZ9E1IjbZaDDw?=
 =?us-ascii?Q?t8JJUYzIb34pq4F1+0L9W4jtM5eghuo2ScIqnrwm6f5w1EXeSAEtH5seg0Jl?=
 =?us-ascii?Q?VEYmzX8TdndnEIetS0ZWVrn1AEPvgFlLoEEWLOCKDfbgHXYhO7fL/1BkFsn0?=
 =?us-ascii?Q?D73/ZNG1Q2pqdRkiiAbQyqvdaAC65rCmLxGYXRpmyGWGSnK1mhQ1A6l+fsGd?=
 =?us-ascii?Q?CRCiWzDCZsOKmrSTiGA4fl45Tw2lfLSFClNkLUdr6Ej8b6M+8X41XuW79gDX?=
 =?us-ascii?Q?U43FghDAwOGAvfz+yQ4iNWhNVWuU11OUZL27AktdfXmvFOesk0OBzHlCFjlm?=
 =?us-ascii?Q?OC/2hck/Tyg5dx8Jq/jFsDT2Q4RVJ9Qx2/7PN/Tt9D8EsfquQpd7AIhwungD?=
 =?us-ascii?Q?x78s+Et4SxbuHWfawiRZh7zHgbdLdTwJlE+EXOKlFbLnczVxcGfPAwMpLHfH?=
 =?us-ascii?Q?BBVCa6Vgt2wnqb5v1RL+9ECgAQuJelmRtVCP0q5o6la/fPlvqxoalUofiqiU?=
 =?us-ascii?Q?fHH0EqiiYa+tDJHkDzBM/5+65nZV2Ti3oifK45XK5dnp1TK5MSxUG8NsvwsG?=
 =?us-ascii?Q?oIWhGPtPEjAkdzVuuKhsH7eq6k+e+ZUGwLrHrqOQ/xKaRUigf26hpo/hIqwz?=
 =?us-ascii?Q?HQji4pxV0+QD4xhpeDDr4Bad8UQ/kOluL4uWI7I+OPQqiZTe48yCFb23q1nf?=
 =?us-ascii?Q?KeA2nBMQ3yugfZWi5I5+5IS7xR/2xwspku3PJZJ9uMDM3g4dJbJ4+lezTiAT?=
 =?us-ascii?Q?2eEFKwpMfhcn5QLObmJfW1EZoqDrvD3J7aj8JKZESBk8LtHC63UNh5tJXlI5?=
 =?us-ascii?Q?mAojCofmNd+uL73xrCIzm3RllPN77ewMbIc1ZbsocZthNiW8NwlW4UHOjnAL?=
 =?us-ascii?Q?1MbCoJMm8gm22bK6a+YBAhO5rAaG/BqdMc+2aVpZ8aG420I7lhIy1JufKTWo?=
 =?us-ascii?Q?1Qp80+T84wiNHvlHss+ZZP5zW9PWfawIG+j4o6tJy5lge7Wq7cfdPU9kWj0H?=
 =?us-ascii?Q?RbsBVqClAV+0Yj7bJnaiYNkMbwhrAgJcyoeMsmfftrd8/JMYNY+h1BZdNr/W?=
 =?us-ascii?Q?2G0aSrRtj0PPmjT9C6q8PfmoXeXpwThBHbUjA5xxn3kY0E9dp0YLZXpBmsr6?=
 =?us-ascii?Q?Pxi+xT9EcgttelKsngQlyusPITK+OedUhtJSu43R3ckZhqNEopKVH1Ni3j85?=
 =?us-ascii?Q?M5xTwl0U5/XVmL7L13vaZuk/1iy8CutprjnRHgl0tw95QBbdsP3Gb47TMxJ5?=
 =?us-ascii?Q?9E3uepfqu76GPCUDoM0XOEQ/GkoNPE8cMnk2DKg3/REULXlor8dtqz+1WInY?=
 =?us-ascii?Q?Rdn/kj48lQqhU7/+yLqnb6iPerHjusY6Y2QepAU6h/xWaj917tOcNsQBvBuQ?=
 =?us-ascii?Q?BEjg9RAGz98c5suGVymRHRDb4Y+c2ft1uznaQnzRBTVS133fVPjrVB1mZ2B7?=
 =?us-ascii?Q?ydetkmVPpk2aQN9VCbdFTJsW1jiW3caXtRXkW698LO5cko7juGudmtMYSZSc?=
 =?us-ascii?Q?+tV/NtRmwXqIr10mbOlweHs+L1hQ1lbJG0d5YsnP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b70ca40-0f8e-454a-f9f0-08db78828b2c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:23:48.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktrepo8Xk6A5aWNsjAcGpnRiouKZ2PQUVe6Xow8/wTbRssG3nqEeCy3p98fnooGMdbldkuGz+ZP7qo7tQgCoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current code only supports one vdev and a single callback,
but there are cases need more vdevs. So iterate all notifyids to
support more vdevs with the single callback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log

 drivers/remoteproc/imx_rproc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index f9874fc5a80f..e3f40d0e9f3d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -725,13 +725,23 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 	return 0;
 }
 
+static int imx_rproc_notified_idr_cb(int id, void *ptr, void *data)
+{
+	struct rproc *rproc = data;
+
+	if (rproc_vq_interrupt(rproc, id) == IRQ_NONE)
+		dev_dbg(&rproc->dev, "no message in vqid: %d\n", id);
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

