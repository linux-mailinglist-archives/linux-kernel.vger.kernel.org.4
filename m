Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77C68EF4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBHMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjBHMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:45:48 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98743B67E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQ0gvWeXrV5xGXGki6g3dne04x1Enl8+lJdj2oMPlc9jrFh4o/mY2+KpBF61hZ9D9u3Q7V5aoyRiSEj8LxKv/GdreCtpovS6qLYc4AOE8EGr1Q64pDWH3ItJsB8XMqc/e+sz/RnX1qaihWqVTgaV91639BlqhM+EKKne994QBcSwOd0RYR7zbG3ReOQoQZNmvROY4ERAF+bvDiArNlsCyhnvGpw6LH5BF/nT22nIu6T31LF5MU+06apBF1zdXjrHhc5ezw0lwUis8h0g+NCqTHsmiZ9GUzWi8EVBUvHEV15alvjCs3lRk7O3S2Svk7RYdGhcgYoFmSdDojsYe5QENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i+ONMsEbmGZiODzvUSBtKOQj/8DHV60kfIrdp+ZzqQ=;
 b=lYnApHVi5zFLFKcCGrLu09myO2f19VLX1K8Pst5g4GSrnmGwF0W+/8v/3B5j3H0wGVqKL7cUkBirGecyP5pwVZgPqmDqvI0CcnxZqZdrkuwDxN0sv6hzwUKLRtI3eiRfBmoLTbUTg0wbsioAnMmWLspgXNHBHuTYDh5VLMOXGKuwh9C/BM6FY3BSh5ccH3C4vtIg7ojRcfGK/OmF3A/Ccmt1xUuTJFgj0B4YvzsEui7E/4mMKoHc1queX+6TXAR+EJ9xTXYM28Zrcu48Yp4JRTHu3L4+8K+YwCsgeZeqTujL/UnIjKoaWo57M1cHn1pXbCbxKAKYnFd5qMlOlDAppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i+ONMsEbmGZiODzvUSBtKOQj/8DHV60kfIrdp+ZzqQ=;
 b=f5iED/Tw/1YO526vQ3dYXTNmOKLdyTDMQ67Q3za3sp8XwIdqgVHo1nkm3Lv7gzz2/gkJApfpJn1yDSZqKkgte9ePhxVZk9giR+26hrIVCw5BS1TFeDA/MSPMX4fTqbE1VavjsqyfIJn933MPNP9ri+BD+FPvetBbO7MOx2EkcE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 12:45:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Wed, 8 Feb 2023
 12:45:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [RFC] sched: show cpu number when sched_show_task
Date:   Wed,  8 Feb 2023 20:46:55 +0800
Message-Id: <20230208124655.2592560-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbca494-8e99-490b-6ef5-08db09d260ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhN21Hm5Coui/E3kHkaN3QY1Sq7AplzcnjL9iYSgyo9hfSfXHxuDR0esodwcjzu9XgkCcfiI19Y3o5orq5jWbKV1ZXJBMD2+UEVChQzsYSBFTKQN44xrGEvVZm5901Uw2raC7AxfZF7lWP/bH7sAvwvno0uSsSaWEluOJvFoznul7BE3fNUpJ+eB9HEhoJkJ8WiOPZT3l/Q985nBQe8aDVehkQLuvkJjdXwsMPyS868vKn4VgEe3Z1RGUxn03bn0PmYhFiI4dlz+WS2BLYyogCZWHDcYtsloK9BHoGZ9wHNYoBjoXK8c5SfGXmvUp/dC5nrTxYIEu0xX2ha4yn8JI0bRmOkI/psABVyUXKNDeKEQY1mA6DEM0RUeyBkpuUrlIdXDBkzRRB1ALUJlpUzB1VByHdWtRcPhp303rtXbZzH7z4cEQ5pNyClTHuTeyxoD36sz5O+VfVgbwthEnEDVKBINyr+/dApYw1ZH55lHa911Qk13LBObUFURD31vJpbmZDAtNQKRVHYFAdYjX/B9EgHB2XWQaKVhlh2CnDeNlfFj4RtpBlu4WY/5F4DE4dYZzcka/pLuQKZO4bhvq0xfjSsF7KUgtPsNTcZmyEk9UZ5uNn4pjZn5+ivkKVl04jS7nFh3DpZGGkh5rjPxcoNd3Pfvuv/cxdyltFl0YCzTLh2SQtGbeID52kUYjT0MNNaa3JgaBQ7GYZQ09LUsXy4qA/vwCcWvwgBgkGwABPjCD9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199018)(38100700002)(6506007)(41300700001)(8936002)(186003)(26005)(4326008)(8676002)(66476007)(66946007)(66556008)(1076003)(921005)(2616005)(4744005)(7416002)(5660300002)(38350700002)(86362001)(316002)(6666004)(6486002)(6512007)(52116002)(478600001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HAeFGKeY2HIDWBehQ1RvR8niR5VSVUk+eRD/FQxc32QAO2aWTYy99zburet?=
 =?us-ascii?Q?HhGJM6rmHvw4kPM6Dm0WQT+vSVTdl0WNM080/T5PXspMoxlKH8B56YygqDkz?=
 =?us-ascii?Q?2cjzqTpsVYeP5bMXIiy4nFjRujyFIwsZc8P4Cv/BB507ZAA+U6Vqo/lfHLbV?=
 =?us-ascii?Q?P9dG86V1Xo6/QwhD2hw5pkqNQe2EIuvKK288exzY+ASV+RemlSEtJNt3HVFH?=
 =?us-ascii?Q?NH30AzTN7R56+BeTOtnGf+OWa2W5E4ki2ks9hP5qXhpOcngZcOwH0w1mrrDn?=
 =?us-ascii?Q?sUOf9dK5pvAwnHSrwJ70rL5DGaxQnU/ckQn4qh6tYBlB9kZShBmDCbGHxV3R?=
 =?us-ascii?Q?wsZr9+E/uLRYf7BjG7h7vXFSag2yoRofqv4y0LGLb40ggbeOLVTvC91J+kqd?=
 =?us-ascii?Q?mshYj4bnhtAJnzOaPDhv5i3oUcQBAd2MwFDKf1rmnb6yRPYMMMGK3hNDrhXg?=
 =?us-ascii?Q?pogb8DBqjVvD5R8ma08Hz979b4n9RhM/GlWMV+9gqt9MG+mFwVS0Xyo/fa4y?=
 =?us-ascii?Q?VveYRBIlnM4ke3FnEScK2SgdYUUkbIAcu9Q9VIU3WBcAaVs8AcgyQjtrUVdP?=
 =?us-ascii?Q?At6iTgOhyRjoHkQ2oTFCRSFpbPr1JudVaEwoUzhheyqpjxfdCKd6ZAH4MMZC?=
 =?us-ascii?Q?I9jAfqq2KSVxoBMlWDIoB59CSxZ3/MN3BaWm4cEPdGJMg+PhII4uJYMPZhby?=
 =?us-ascii?Q?5aogUJQi/tLmkB2+0xApyXtEX/n1cV9MutMP8DOVjvPVIvW2wJ/K6JfVQcmM?=
 =?us-ascii?Q?bzG3IsUClkKUldAybWQBECWH7Q9VPyLQfdHD+0rWNnPPqxLXwaFiAqje5Hy/?=
 =?us-ascii?Q?csSlmpXdYUT25Jn6cQz3v3HfVB448PtBzpftekSrsqcUoQc6zgrbizPJ3ga0?=
 =?us-ascii?Q?DqG5kgsK3av8R/E74dIacPxwntqEsmuQJxOOWQyyNerD7oLMONNHIHKwcb+c?=
 =?us-ascii?Q?AcDCtZKgCd8tEK5qdYteJDUYtvD9wk7B2aICqyKO3p7Cn2mbCPH2anZWBeKr?=
 =?us-ascii?Q?sZO3oLGyMKyKZQZE+zXwPlDHsBYsL9r1OnIuTTCSOe3uRE5wysKbh+g7nBPg?=
 =?us-ascii?Q?WlHti5DSxzDpcWVRpI3S7W7bg6GPbct60n6BAhj34XDo9sM3wexcaBIlkbGc?=
 =?us-ascii?Q?ajZi/6S5ZKIWo7G+UnQZMLYBEazRPaA4VAMOj2z8GuWT3vDIMYtzXyzg+ole?=
 =?us-ascii?Q?S+zBoiAs/kvE3MjHld9ZUCPBmOsX5NHYESFM9WzhaNgxs6pDI4unZoOwjySi?=
 =?us-ascii?Q?sraqUH4ciiR6v/F0afcAWV3tjsOhKLxfbRSZO5IuRt99I9X6mtJP/12aMYIy?=
 =?us-ascii?Q?+bhGpkeWva3+m0+gBvxcuVjQ1jigpGgDAvkMsw+bNe/IxfPp3ShgWxwCXith?=
 =?us-ascii?Q?3oOd9gcAonzubh3yuyUCRGx95yYGsQwgID6lrtaWVWHQbONUSR0R9VLYUgi9?=
 =?us-ascii?Q?ymPtGdtBdaHEAQnHrKgV5t4EcIzZUCc+RBvZ71iMQyxWh9MJ4IuSOy3FWbZN?=
 =?us-ascii?Q?woyXuaR8i4Uk3BSTxv5OBo6I/Z1e2GkMkr3RqXMLLmfYqGY5DUQ1m8jHVX/W?=
 =?us-ascii?Q?SC1ObXargDth+hlpe2I5WxyzWkoZbpgb0k8G9QwA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbca494-8e99-490b-6ef5-08db09d260ee
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:45:38.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FttLjkEWoY+1EShvpc0+gtlSgXKat+jo1a9nPkubrtpxTUkRdslv8rvptYrWBZnN0QCwc/UpkGemp/wjR/RODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It would be helpful to show cpu number when dump task. Such as
when doing system suspend, we could know the failed freezing
process run on which cpu.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..0c7a1b2f7baf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8876,7 +8876,7 @@ void sched_show_task(struct task_struct *p)
 	if (!try_get_task_stack(p))
 		return;
 
-	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
+	pr_info("task:%-15.15s state:%c cpu:0x%x", p->comm, task_state_to_char(p), task_cpu(p));
 
 	if (task_is_running(p))
 		pr_cont("  running task    ");
-- 
2.37.1

