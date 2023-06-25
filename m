Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B3F73D0ED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjFYMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFYMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:30:31 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A8E7;
        Sun, 25 Jun 2023 05:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMwAELTUOvzNgo7e3vCBqZwNItRVgQp6W9llbhR2JE1ONgyeuAQ5I0x7wpOo+x3ZtwB+SWx3EGkYLHr9hJ2+icxQRyqR2z1TKizzpQcCvSLPqtrrvqoF/aS2dzpTzlpeZgrU5yRVVS9klzGTZfkbnBh1+dO0F7YaWLTk5ZTkh7AFxeHcrTiAdhFkVDANhrfYZJHVjw52rB0NBt7MnQP+r1eyKIlt6/21AbeFtlLsBWaPtj29kAfQaJT9BFTUT9vNBh1piUXtEQ/YlRX0VX3Eqr1rY5Q/RVaWGarI9kjpDYLfRE+BWU9xYQYZv6SOTEfaGy96x4dJfw9sxjLwnxjc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC1r+bR51QkblR3gPwo9xPNkn+1wxEuu4PDRDtPmhuE=;
 b=bCoXnhWFjNUU5JcA6cXaRTCLy71XJrYj6Ee0M3unw7GhSQK1s5uKNR7kq3vwKuFj0/wkOUUQjD0md6KL+9cO/qDg4XXU55bHaiqjNlVgQitpGt9FdEQ+V5cOCIAA83+1s+pk3VrfmI4xpYjW+dMu8kmVSZgu5k7DHtgsvlUVGNkG2/gwoNoTlhjdeyx9E1PEvEQd/bFtpzZ/T5wBGkv15h5YSYjtGrCWV36OYCfxBSnXM5WtnsSBxuWiM6yslLo5tpI0W/ETA7vSrRMzgqLRDWweM05pnTucCXBOYS/x7lNSp05U1Mb0WcUxiOw3Sl/DcvBlJwB3sB8NSls1cXvzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC1r+bR51QkblR3gPwo9xPNkn+1wxEuu4PDRDtPmhuE=;
 b=RkSut5TPNk6bHe8HeTXwTVgf+qcrnSBPj2MTZTadG5gHNZ/jvSN+cKimM3B3j2V4aqn2uib/8lVoQ3jULIC38fpth+NYL9yD3ewTxdZPZ5kKz0wtwk9igOscNg+Z9IABnuyuQPYm8VmUbaDLFKICxPahjj/Ypyby8EkbEaKumQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:30:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:30:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] remoteproc: imx_rproc: iterate all notifiyids in rx callback
Date:   Sun, 25 Jun 2023 20:35:14 +0800
Message-Id: <20230625123514.4069724-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf4f93b-ea58-4d47-0e87-08db7577f27e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIAynDpew0gvTA+id5pABZD0354hCaw3PUovN+AY09M6gYJnI2ABpE3iDITOpD4WFcX4yT9mtqM/Os7r2Crm/iWe4Y+pshoXjiULz+nwRHuWb9IN0sPO2wl9UaGNK7fKJBT4A7Po7BlUtu0J1qNsMIw054MfiVXhl3zb2ftDFATjOzONumDduu09mysc30WFyZiWGDJeivXRudwqxhPJlmyJ6Ztnhf75UPtlDpBo8CaZ4xKXt29Y7WEEYT1+5WQwJTwD6l1Ef6EGKTpksiky/3na6XkaF1cjRHkwbQCnpryDs0vSbBQD7WGvrzMbY47duuckg68JgMMsaNBHkmV5a49+GD3d4HLp8byornp7YX3ow7z2AB1PpXqrgLFazoMxksK0XGgQu5EG9F0njXSuc9HqQMTAuPWokizouwLFok+zQdWmCAwC85igJzvGjNjZ22E6EoPdtAIPqyWPEQGtSigIfPIS+0mUJUiiI82W2gKFTmO/vClwZVKuL+Z1y94axWgwMqngeWZ1n4WDUYrRouOtk8r+bIqzDwL8spgNoaqBQgeltFaytcZYTvtbM4XYAmq9Ynd+7mDgPjVlC458b+un9YiNAAhzuGdpIRu+Bn4JIJuF5pxVfnIC6u2Dy1IX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(478600001)(52116002)(2616005)(83380400001)(6666004)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(5660300002)(38350700002)(38100700002)(4326008)(66946007)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cB5171z4kNLOI/c7EVioiPZSAGWNYYdrCryWeVh86jXZAEP5kV2kDvLXIT0?=
 =?us-ascii?Q?eqqi8V2USgzFcQPOV3rzWUgdaYHaZaSi/AkMAsxTPjIYedcoz4ZtHUA+ak+v?=
 =?us-ascii?Q?3gsGwB8yJPXrAJYr8SAsiQW8J3bYo+ClakK25xXaYrXCyDLpMo8NMJe7bozd?=
 =?us-ascii?Q?YqUop3pY1eR5E91T6SzS/UatYZYCduvKKusglOiO9Uw99d5hMWdLGZywpT9c?=
 =?us-ascii?Q?rRhlChjAv4J+L4PKADbXrnKi7xHn3pEa+KtZqdAFjBXB4a1dEO3UhhhB3xjB?=
 =?us-ascii?Q?I2S/CGYMS/1ZivR8Rfl8WzAWYu/D3Od74oHnAi+12aiXK4kRc4HrUgrXt3N5?=
 =?us-ascii?Q?P9Mi0ZZmv9p6QqfHfQsHyKjVBUNDusd9iGRW4GYn2OvvcrC6JsfLws5HV3gl?=
 =?us-ascii?Q?1nNvfkVFDvDvb2HPvuXKCtJhWQBMnYg9YAh3OXlVgdpZfchIa+5Kfh03zVjV?=
 =?us-ascii?Q?7RKb25eLIPaqSYm+IrhIuarJYDUZIjgoVox3DBnk3kM5nMtceQZLSK2thAC7?=
 =?us-ascii?Q?FdvGvwkvnU8wOIuoBlwUusmSuT6PEPm26a2O8p3WwlEh3FsZE9LD2dRYk/gU?=
 =?us-ascii?Q?b8yY+R+/xxpTiloV+9tZnEtyyvKA9u8+kyK7soT6/p3ijM5IHz7x1ywS0zeA?=
 =?us-ascii?Q?LRVXndatyWKWs7aBhOxGLUlNoVP1Y8sc4+0Q3iWxdVMozl+gvt+4mUJKdkCQ?=
 =?us-ascii?Q?pYOPonMpFsYu4aRVHmYCKw5AoG1JgKUk5A9G72/GHp+Xat0+1QCWpDlETevV?=
 =?us-ascii?Q?2HOtgkcNuHsWK68uPjB2KjSwQo/nisEqMPJvb7nLamhe5O0XTpN9pxqzNeOR?=
 =?us-ascii?Q?WPWuTcA/9hOga0GLCY4hqD9M+jS6WNuol+KrwO6WwZna5OvSBaITCnqrr3Cw?=
 =?us-ascii?Q?WzQdTrugZyk14bRkF2Qkzj/TUDAEzjjViAzObX/RhfmR8KjImoq7bypSgS3G?=
 =?us-ascii?Q?Zjq2IbeWFK7ThAi8KoLhDtXwKr5/9YWS6q/ZviMnP68rCsY23BZ1lKKgmk0+?=
 =?us-ascii?Q?Kjip+4bQYAREFrR50xDjXo6Qp0EfGOgaeYOvwSEOM1ruBJNVmY0jZTwx+K8e?=
 =?us-ascii?Q?UV1x/L1vzSa2U7oMM7rvqIy+Tn6OXWfe5gNh26loaNuARgM10Td8wwJUps1D?=
 =?us-ascii?Q?sujtA0E/sV91TBagA/p4ikSlo4JR2Xs2jgiNnEQyaYQI8XwyvGBv2JEfq6V3?=
 =?us-ascii?Q?lO2q5ZkBxJeTT+CuKi//IAORgOmaTBWwi6zDNPEG572GnQH2x1HIUhAOln1h?=
 =?us-ascii?Q?16MQClivYW7eGEpXN6OKeuWWd43MS2iktglnnmGM0M8EpUT+WIYdLgJgHpRy?=
 =?us-ascii?Q?7WDl5c4IrqQBJ6tOhJSYKvrmzQPwVwjKr9/6Ef2QOB5MTi58nBQJpW4rz0HE?=
 =?us-ascii?Q?M39M+rZja3VCb3LJpRcwmTycDnVbS5+1WDQt43LmMLlrnpubTcJ+MQk58dc+?=
 =?us-ascii?Q?gg0xRH6p5VPv2ZneU4rII38YKE0vcvoU403irk5OwPFa4QzqUoiXuxFFYy/+?=
 =?us-ascii?Q?wXKqqDDMwvsdmhPT+46pQIR3dEDdtsJ+m++hFVRNDETSiY8p3GuP9apeRtqU?=
 =?us-ascii?Q?UUAMcgX0XntlI12wNwOt8N82kAeaYm0hjqxTkw8Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4f93b-ea58-4d47-0e87-08db7577f27e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:30:23.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPTNA7rS24Ay1B8LF4oWvnqz9c2eQ2dosg2gN2cKhOcyPydjGeZkoayO6h4HXlbpt3DfWWmpNt6/DNQKvUs5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current code has an assumption that there is one tx and one rx
vring, but it is not always true. There maybe more vrings. So iterate
all notifyids to not miss any vring events.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
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

