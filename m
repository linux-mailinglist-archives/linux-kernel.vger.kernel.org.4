Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14BE6A6CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCANAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCANAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:00:30 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DE3E622
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1r8uG8qWyjt3Bb5ZHerL0K1F8yw/Vh+72HIfWRN21+PizqPsBe+NJ74QvLTuDMu79VMjCph0IdloxK4cXqb+HWr3Y1WqDXn8bPOhWYNmd1TtQGC2ippwtF1siITBt4IWfYMn379zfPcpTXEH8xR1LLJ6N8k4SjtPOE/NjA/e3dTbUxZCAHxavLzxx3OEJ6ehA72DuSIve1VhHiYJzfBSdN6RXQXg1L7qozvMArLgM+Ita7Lp6p9Uyzc/c494L7AyqP4/GDw+y2VO+5MnWru46Ii8RSdvjUDxCJHAeChD/s9j5lYNM55NlsCKzHHKjZhsHkobeIQ30DvUgkapTD0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU4FSjhEo0O9qIFVF5+Jn38YQjyhBGHTVyGIOmzLxuc=;
 b=WPDZh6/1kKiV7/zEzVRVyF2qntL9hz+uEHn+UdFFcIaJGHfI0E9aSHhSnQvRVhoMKoCMYoYSF8x1BwKDPsPFI6zTrcIzhW1qwecazdke6LjSJIrIdpmJ1J/JEgfhSFThK0mIerzaQetS+6Wq6XbVCyoJyQjlAhu66xHL6qiJgLiIAWwwhJ917rAwPRiRSjTY40qVMWlCzv2p7SvzCQvJz6WgzmMX26BFRMuy4Rl1B/dvs76uuJ2/vjTrSgI95B3GcciScZlpEwMcQIxVnkmUnXmc0tbXoqt0Zu1H4h3XgdXdIiyYhJODzWmgpTe+LSL/P2Wyps9rJhr+/J6y1GyyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU4FSjhEo0O9qIFVF5+Jn38YQjyhBGHTVyGIOmzLxuc=;
 b=Y0lF4WL9mj7Zim6LgD/+v9q0Bli+ki07Yac+06GBw9lK005mQ8ke9wGspdz3kgc/BtZ41rZeoYEnLdCpEia+Yyn3MAjlCISDgdxIaoc6/+Zh85vUb48+9yvQ541mmCQX2Uahb/kkD0FCpQC3oa/cwxI0jqL9KGyjTKGhE2wsKJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Wed, 1 Mar
 2023 12:59:41 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 12:59:41 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, m.felsch@pengutronix.de,
        jindong.yue@nxp.com
Subject: [PATCH v3 5/7] soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
Date:   Wed,  1 Mar 2023 21:05:55 +0800
Message-Id: <20230301130557.3949285-6-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c18eb1c-d37d-4407-994d-08db1a54d1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mejNS3+qRVsiA2v1TPb/GjTG4Z5dlZRzqyIrf1sRSLoXX0KDV5yYQ2d4cElUEGTBYgBQr0I2iXO/wqrbIuQ01vqaNCTIqFLqdYS/Jp+XkFnid7Cat3cKrMmkahGDeda+PVsDXibxhNT7H5isOmRb7MrFNPj/NqPwJwv+VZ1aacrcmLkWtwY53XE3O0II31FAnc/24QvAoEcVfftwpYFbslJP5BCFbko9B9M0OMAgEd/nuVZKWX31isr0Mxz45nBOHAZiTAMvk6L0zLxvOjXKUaIEJGhdIycxoV+3w9yoRR771YWOshMC7pHlPoZ6Wav5vw6x2uP8MeAamDTFw1jOubcL6fVHifof0B+0WQ6TgAY53moIw95GvmEoGlT+tckrG8n2YZQpBS8PsOhPsD2nect3tTQLj1a29p4OhBWrJXNaim1sIYilq8Qg/Gc3JbUigd7m20+lJAk2f8uCsZTnMgwE4u/bCJJCI1l2EnsaKUgcBeO0z3ZAHqJr+lN9DVwS59PSAKR09aCTHKqRTaXMblgKB6llT6ZymIIJkmTOnh7XNLB3ZcEfHK1bYcqvc9a1V+SxODyRaDdx6m8ijrTxi8XILhs6t7Q/kV44PW7/mf5v2ByWFThCN4i0etMldt0cmagxwS9mEMnx/YIu/rVruEzV2Vi8+akPYFcrJaptOjXq0PWLpKb8GtRz+Jy/Imz9RMxNeG360Aq4929gJ+/ZKyIGoRl3ens+spC7mgobwIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(4744005)(36756003)(44832011)(2906002)(5660300002)(6666004)(186003)(2616005)(26005)(4326008)(1076003)(38100700002)(38350700002)(66946007)(8676002)(66476007)(316002)(41300700001)(6486002)(6506007)(86362001)(478600001)(6512007)(66556008)(52116002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5H4Q8jXy7IQM+nl1vnPqRz5ykU+1XBn9WienOeWw/Znp6gpf3AcBnAMb9hB?=
 =?us-ascii?Q?ES4/XimFN9TW+3iAQg8N2sWA9YVpt/Yqru2jWspkzNrudP/gc71to3Ja+reQ?=
 =?us-ascii?Q?z15HHypm79e9VHJYS2HV6wYeMh9S3xwCgv2q6AfexC7tH37pYSqknbx573he?=
 =?us-ascii?Q?ZKrEeLYj4NiE8gmRLAndoWszUgu4ImhIJOVRTMLkDry6jtjPBXgaz/+czULy?=
 =?us-ascii?Q?NT0Th3og8dd4VSg7gbbo7BdGvHJ/6cMH0PuiX3fQMGR5K2ubqsm66Ij1z9Id?=
 =?us-ascii?Q?PgWAgB+RpKxX/KyIRDV+LJDqqOiVNVeMc/fft3qxSY3iw0Zr9pR4KG3lz9kB?=
 =?us-ascii?Q?z1f2PtlOIPrm2BST6aAvnuplE7DYPPe2Il7Ocxq2G8OOL03Kv5zOEYpy8RZx?=
 =?us-ascii?Q?Pa5NFRqF6wMBnyVBLVHI8AIgAeG5QfckrbCEL07RHmYZSbeY/8qzji7IEmNS?=
 =?us-ascii?Q?FTQO680sHr6tQjVPnK0FS8W1LEeFv6AlmzibfAuRTAc/kzVlOBVv5QkP34JJ?=
 =?us-ascii?Q?4XHMewVR2tFKRCgTJkAXOmDny+XAPf8PG61wLhz0DjxaRh5PxKEhRE258U2Y?=
 =?us-ascii?Q?welLZbMFwdzPLKM2ARWZ5+niQi2e+1aukHSZxlnwc9BWuvqnw393UlJHhe83?=
 =?us-ascii?Q?IAAkCuUsp9wAUAsPuQcKcrq0jwyHbaREwANlkDva/v2BZmao4TYsPYBG9BL+?=
 =?us-ascii?Q?pPBN4Sd3kcHPnvmEDb1lLzIKGIzW42eS7rV/tQq7DdF1x1Yc09laPIAaIgf0?=
 =?us-ascii?Q?aoQqWM7VvbZ2ETG2g84fEqRz2m3k8VORDLHrrIZ409nN1HM3BAabtfMm1Fgh?=
 =?us-ascii?Q?z0lNGzXtZLBwzwhDQey/2v0bYwhssjrNFte1VAkcQnWrjgaLOT9enspYNho4?=
 =?us-ascii?Q?4WjnY6BjyCY+dEmANR6aApuEIRm2lUQlhGqUISqh3iB9GCa3i8DihF2J33S3?=
 =?us-ascii?Q?R2NJLIlFknTCyFPJmJv6v2joaJdXRjcmVCcFKkKKk7oMEIRndIgF6NKF9Db+?=
 =?us-ascii?Q?hn2422T/Dpb3bz5JuxGPGf7sJJIi0m593iunQdkknCmggoc3LbxtoX4HPp3D?=
 =?us-ascii?Q?3CBTAoxfAT3kNlggS7/vAlSmJ5fwUo/AcFTjpweA7oAksaI0tEdyN/IoSp+e?=
 =?us-ascii?Q?QESkqbsxS6ya2tmnQcujSN/zMkSENiqmTHR0Xl8tHDV3a0A/UqxtpywP4Xeb?=
 =?us-ascii?Q?v1sOBPkNEvylQaIZ+4lNq/rkGeAVusF0vpKhPCgB6P/vN6pKSXsaKTkIICKx?=
 =?us-ascii?Q?EvUV+fPep7F7mR+KfNSPMMOZmYi1sBKSxd4fsrDoxeMZrRjVizGvtlvDFCs4?=
 =?us-ascii?Q?0MwBM0BwPccX/KILPItiRoG3fRgUj8HERnR2J9TT2OU5RQBPlujtGKA84zab?=
 =?us-ascii?Q?pAsEt4p3qjGvVCzrI3e1TvwGuj0bktVDSkal4+SpsqkgPnWB2CrLf0QSwm4t?=
 =?us-ascii?Q?dTFF7HE00NeRjE5YdYV7rOD9Z38nxcCIotvKrcN6vN6eG0IaZ+/J85iW/3hY?=
 =?us-ascii?Q?+kTKVQDnLZssaqgndG68sSfex3qldrymOTA4tuMqfuX594wpa3t9pa5z5RDr?=
 =?us-ascii?Q?i/M9MSZrNMp4SL2rNfszI+Cc0Ghjw69aEe9wIVHF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c18eb1c-d37d-4407-994d-08db1a54d1fb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:59:40.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k28WdfJOTgwTak7ApMGP0TWiS0Akix0CaEXm9p3aO34I/8uFGxmrJOS+Odur0LoOeQJco4gdWNqHYrtCzLEpBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_LICENSE to support building as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index af67f2c3f7a1..a955513d6d68 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -891,3 +891,4 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
 	},
 };
 module_platform_driver(imx8m_blk_ctrl_driver);
+MODULE_LICENSE("GPL");
-- 
2.36.0

