Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED16319BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKUGea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUGe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:34:28 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693130F73;
        Sun, 20 Nov 2022 22:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtEDrR7eL5UJcS2PYSQSMp1bSHyXUPzfj5gKCvxlNRgautsPGGZ7LLbZfsacCJr9olXrqssNJPU3FiK7cL7UI3zz0nM6ejuWNejx2OJo0HqBHuiTiOGYCXTbGivrN+K9X06cEL4JYedBzmDT0H7pJOlhvipQVQ6Ma+KWdCG3zwCVqcO/VjUU/wq4UT9RLxTZXEFNSL5cZCcpULaJ5BLyAGsI68wnxCaPzNJkFnX4C2ByAG6YWna/z/J4AXHg+YAYODKm57BJrBQfIxOe5EW+oVBmMXe5S3G8Vl93WauLieOg7qA+4Kxng4l2/KC6deWFhwLYkPPWoq4wKK6IFemBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JflHKlYZmBKZNnJsTXXhJIB6LzGhT9Y0Ng0hOtUdIo8=;
 b=lg3GE3YuTETXG+cfk3dhKoAzFAOCIUKiivug13J/S0B7SUoBDCRedCsIc0AcXdQCCTTIPIvHcNNKYpfWnPMi/vnVRRoptS+/r/jy+t55OdcBBs9KZpdybG12Q82J/Fpe6Z1SnFdUfeTZcuCIcGO8QYVtfOHQStCyBlyczLDmrfQXyw9qMcRK6pqD2mKJpE8ayCU03V35e5B75eu0mgauVkJWQCSybDVdFsMUq/pwFnc/Otc7l3kmKooBg4Rt1tDgrp6bdLi025lUj5zGsPZ488sWLRL+hvgmESA06SKIbLH3hGf5l8ApESUPFoqz4bnwNv+QlrUzJY0YJ7lUrl6kpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JflHKlYZmBKZNnJsTXXhJIB6LzGhT9Y0Ng0hOtUdIo8=;
 b=L8KyEfkX6SKC0wbOzx4mR/tQ665DCzQ1PDC7yXZMUZPifluYsFUowZc1bDFy+8Yg5PxHbkRIbBkCnHCfqxSvKNkLhU1ZXJmi90v/cTbQcgTBaCHS6u3FwEaGObrLrVL1nysEq/g2MQ2E8SJXSV37m/5S8S+RSjPbTd7WfBoWL8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 06:34:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5c78:27ea:319f:d11%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 06:34:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: cancel vpu before release instance
Date:   Mon, 21 Nov 2022 14:34:07 +0800
Message-Id: <20221121063407.7770-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a60fd1-fa03-49d9-20de-08dacb8a6e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JjugRWAQMxMYRtoEEpGVMlxaQvqn+XJGA54ThM1KfaYJeQLBbVJYw1UhUPsTsjisY1miXBOIyMVo9MzCYxwelwUkRcjDT/fiWz3Qo4NnoKz7GWmTbv81bX/cM7MXxgbFFNG8BR7Ny1ng4fKSOpqHaDHI+/NtBbi+7LFeYnLMXXWe0qe02TOuMgkiAYAKOyIZoxUcSndCJuevXwabrLwrgYXdmHU3QouoGiM7PiY9CHbDOO6HNjHwg5WJ2CQfqUCtv7EQqDrIiTzB4FBPvMrKsEfdzer1fd058nySETclWaw3+HpNdv2bNtXk6OisWjW/68K9WXTaetUSG0/AXwYF+ZoxiSNmpb/czmmsIjc9zOWJEnxc+TJqpwbUWFXoo2I4LuI8EohYTvvIZrC0zClh6gaipmoW2CGbMPGoHzX2F6eZHVxYDQUZ3FpsNyV754k4AwzA86FL1MAudPuPrdO1vhJ5o7QDc0KmM+HyFec5EC6a4ahMNasfFbs9XQ1cjzkoBwNn60ajGCB2cDNrc/BtrsjIaFT9zXhrmFhz1KtqWYdO890Tk4t6cotmyDlyibrSXGFH2j1P3hMfs40I09W6cKsKYT6oeveH5REZ2K+m7uLEtZRsQukKGZbDZJuXQ+Ymj5iyjGNtd4TaO+Uk2ly0s5Jwa0Vhwsn40kEx/DLPZ/4Sqo2qlcBwsNo64IiVFWefzBPHdpbJD3bf3xSqkZDOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(5660300002)(44832011)(7416002)(6506007)(316002)(52116002)(66476007)(8676002)(4326008)(66946007)(36756003)(6512007)(41300700001)(2616005)(26005)(1076003)(8936002)(186003)(38350700002)(38100700002)(2906002)(83380400001)(86362001)(66556008)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMmqRuUhvND132bILu+UfELstXcupo5kEHtcT3JztXDcnXKFGL8wE5vf/oTk?=
 =?us-ascii?Q?veKtDxOFC5AZezUooBw/0ltYYQpeHjMh2g+TG7JjAY3YebZ+26B5ou3tc24k?=
 =?us-ascii?Q?g16SljcrAxjPSc0qY/07UBoIT2AyM4WvXYzsv1V2/D1UAturYnt5fWLuA8k4?=
 =?us-ascii?Q?M9+czLNlp4JQiMJ2Ojvx7y9DCxoxN3XuDp3DgpMJbDPWXGpDZmv+5ZvrW+/a?=
 =?us-ascii?Q?BHL3IQyy3MjqpSH5sLGtYFoTHFdhKcyE9k3vQ8zjnsF+Y736R4S5SKNFadYy?=
 =?us-ascii?Q?QqnCU0DccSLPwFX5hcfo1M2ZuREn20j7lVVNR6GLMYqCEt72LzACz5py8MeF?=
 =?us-ascii?Q?7sI+rMCR6LANd9gWBw2Lk96chGQVNYBxI6ahGJvsBphzoovlmAaktq0yJz1q?=
 =?us-ascii?Q?VzthY2i5n1zM5ic/McoTIG1r1s772Kl1VoxgD4AoNLmfHOiuHUln0+fLYOH6?=
 =?us-ascii?Q?N3rzrBdKTO9Km/+t2gvhmxPHs/XdtGJyHgHfkkdtnZlpZepZdF585VPVN7Ms?=
 =?us-ascii?Q?DhvP7TU2E0bXqsWM/3jo8J2wqvdjNLOGAaLZ4T/i0v/Zhp2/nz2UFPh1ip5l?=
 =?us-ascii?Q?9mKNALgZ4fdWTJDl6epwO6CY5Hg0AGo3DFvSsyheJ4nXHfZVqs1SBSjUcoqh?=
 =?us-ascii?Q?Y8GEHM+vTmIB5z0pQGgv1Yzot6uMbjxnwcOlum+1MvQ7f73Y0/AdWcEW4kRu?=
 =?us-ascii?Q?AEMvRgcxvoxHDukp+mXgYng07tOmCyaBlxeX26IYJlslDiWiGu5uueqtlwN2?=
 =?us-ascii?Q?bz5akcp7PmqglQFO2nhc03xu6/N0EbrourWp3bIXkb0f2CaPNqiQjBWWGUr4?=
 =?us-ascii?Q?/BCEpArqQxK86St8nEMY34MD+qJGKGni0iLprFHB90UAWf/Er3EL8XaEoTGH?=
 =?us-ascii?Q?+BnO8YOMXHgNN4lpIDGuBMjOg3JDlWZAshS5xpI4tObXmJOQ1xYmCh80e+RS?=
 =?us-ascii?Q?lMWjdeAJqplj64OLsuAMzFmhHypsTV4VwHPYdbEf2fahr3SFcD7/PefZ6/oz?=
 =?us-ascii?Q?VYB2IanujGEeysi5KNOXbnc/6EnfjaLA69BbDnPzySeV/C0xKhZTneeR0ZJn?=
 =?us-ascii?Q?u2ZSWTpk2Z4n/kbG2mP46Ooq2FNbbkDtatp7wA75no6Pnn8Qg6fg99X4JZ04?=
 =?us-ascii?Q?ZA3KtUWR/xuu+1YLn6XTGFZqvSGwj87qKuQTaZD0QAofpQ7XyLdv19yynDl9?=
 =?us-ascii?Q?kPBvKqT7P81tP6XnsfVvhDuJKV8J51bUx+bzDs8ZzLdwe2WKjKZ5HePhNWG5?=
 =?us-ascii?Q?wchJqv4Mk+PDJsMEa66f6JKxeCnq+1Xr3zYAeqqFlVpACyupyxfZPrHtTRUZ?=
 =?us-ascii?Q?jgjir9PIJwy6GIXkoVF7zq+LWrOwMvMu3mk/iZyszcCMPc7S+qIMMvaK8Wha?=
 =?us-ascii?Q?q+n4wFxpaF1FvnoWSfNxZTfSd2urO0TY+uSObMaX0hmRPblSqi9Jb1BdZPRt?=
 =?us-ascii?Q?+I87a07AbqM5/POA32RTqYNpJLFJFDaCFzqmr+KQGew8S4mTUk3XCheO0BRX?=
 =?us-ascii?Q?YlBVvJj32um45vTUxIwyZm7++4LLwynnJumGSUUJWfgkdCtl3mxtSVeDd3uz?=
 =?us-ascii?Q?v9H9UBTIZNA01xWPvbMOdQiY/Ng4pBtIMRLtaUGl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a60fd1-fa03-49d9-20de-08dacb8a6e85
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 06:34:24.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsL3YeVX0/Whf58b8aBHDDz0CTkIQ5vTf5TUFoRSIR1+4f3fYo+Wu3rHT2BsqVGPYeUfyokgaLcjAU9oRiUg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert "media: amphion: release m2m ctx when releasing vpu instance"
This reverts commit d91d7bc85062309aae6d8064563ddf17947cb6bc.

Call v4l2_m2m_ctx_release() to cancel vpu,
afterwards release the vpu instance.

Fixes: d91d7bc85062 ("media: amphion: release m2m ctx when releasing vpu instance")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 30ce9f06d91e..33aaa86d465f 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -681,10 +681,6 @@ static int vpu_v4l2_release(struct vpu_inst *inst)
 		inst->workqueue = NULL;
 	}
 
-	if (inst->fh.m2m_ctx) {
-		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
-		inst->fh.m2m_ctx = NULL;
-	}
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	mutex_destroy(&inst->lock);
 	v4l2_fh_del(&inst->fh);
@@ -767,6 +763,13 @@ int vpu_v4l2_close(struct file *file)
 
 	vpu_trace(vpu->dev, "tgid = %d, pid = %d, inst = %p\n", inst->tgid, inst->pid, inst);
 
+	vpu_inst_lock(inst);
+	if (inst->fh.m2m_ctx) {
+		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
+		inst->fh.m2m_ctx = NULL;
+	}
+	vpu_inst_unlock(inst);
+
 	call_void_vop(inst, release);
 	vpu_inst_unregister(inst);
 	vpu_inst_put(inst);
-- 
2.38.1

