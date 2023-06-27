Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED773FBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjF0MWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjF0MWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:22:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE11BE8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUNv2EBrJPodZxDTZQj1hoFx4sehpadyHMI2jZlHYLyhwwXr5deFqXFxQCM+7C1SNSS8scDVYKy0c1Foo8TUIIsQf7RcByYx8lrzY1D02c6tpiDovGO+TgtlLjUeeZ35NCtwzQboz09z4UCh+vqTL0oEVVh0KdADOeNBduxsGzKJ+jTgR3fNi0wRdccKoCzJdf1+ck2M2yEDkt/kEwri4lpyJHt+HJ2C5MiLwG1T6rS+QV2bt0JSDKXTB1SYOb9mwRKbOZikSdg1N5W/gnl+FPg3E4EZGwhc1NHZ4VduJZ7W8441u1rrSxK7Mz2m11uvxMl/e4Ynu8hL+gvGPzu0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVRJ4yj55AQDnJwiQ4jidx5L+KkMG/7iVIne/1PWLHg=;
 b=IT159XsOV6MJi30kPEX+kJ4b56Aje2jSFL0F3yr2k/tQJe5XQHqKa1xBFscCRR8RWPEfDXtn1pQQESNqcO5ZzUu+hd1//FzELXncjiTvsP2NryhXY2aEiHi//isxEalSUs+YNe4adkB/6uvv5sz3plQRHBl6ERxh3IeCd//SzCSY8MmiOGNoADUWO5tllWEc/TmpZddBR9pBPlrwwy2JamsOCNEy81yOJGKRrn11rRaYb62TkX7Yf187R35bfMXtH4IsEyb8HA11yUSXGxpSx4Ct+5LN+ctuxV7GH/WBjI5yLzK3lg7xiltJ3HIP5YOmu47k3vswE7VBsvELzPJb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVRJ4yj55AQDnJwiQ4jidx5L+KkMG/7iVIne/1PWLHg=;
 b=P/SYs1ZdVhI1x/AzWcR82nRQY8u/tKfPoNZEm52owc80fTZ4PQTUZ4IFHt6j/PKwi0H5EmRm9yPLRP/+1+MjnZPLtHtNowzsyqivGkh5yc5KVz5BQnnyDe6H9Hi3vtTiGkXy+fsRtalufAS98njAc/xJ9zsP09qdqrWFxZRGXT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 PSBPR02MB4469.apcprd02.prod.outlook.com (2603:1096:301:e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Tue, 27 Jun 2023 12:22:26 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%7]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 12:22:25 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: [PATCH RFC] f2fs: only set release for file that has compressed data
Date:   Tue, 27 Jun 2023 20:21:53 +0800
Message-Id: <20230627122153.1557656-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|PSBPR02MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad00763-6d3d-4fe7-bace-08db77092a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQRSpoBPYRELFqlsPMVlDhgnnzsj6qluOWxxJe0joJDX4pS9NzV5E1uWamu5y/czaSdWFJ7HPHtBozgN9AwkoPESbUPbhUk0oZVvAwYWVveRPiNVukuKACj4C2L9/icTnOz6lcqcLxVwB3Vy9GHjgf1m7T8i/55IA89TQ2i1dxpCiIYCZRjgeoOp3TCDe+dHt3j/rKRwpj7p5KFrwPvEzUN4HQYKWoB4HbSu3ooRVokIjT5CAWaqY+sqmYnLDZkihw1USGfvHy5zM58npQ3Z/OmRAbT1tKobZQINp77rUctiU9tIquRp9ddSlHrUa0ARrE5koglKdpuLHsiv13gU5Fkp9RspdDbVibQjwPVU0WKChZILCOZt+xZ6yfwMiOLTmQ3REAw3d28xgjkimOSpNBqpyf16gYT0jdr/nc0Mj+txDsGvjMNmwFXf32MI0/FlrIhtipSAEnYa/LFLsOC9eVQ0E+TpKiHZvMXd/Tzl5IW/owyRwVIZWngrnKoZBdsyVTDlhv1Wyem3Nnp1YaCly1ltLGr5IdLSt/e3u/SEGzdXj44oiItlT4R/BVExgrD//9wUXmge1r+B6w7EcpwxhSCB5e89RLjBopJIcuJYq0cPqsFF5xquhBt3IEuS4J4d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(6506007)(66476007)(36756003)(38100700002)(5660300002)(41300700001)(8676002)(66556008)(86362001)(66946007)(38350700002)(6486002)(186003)(1076003)(2616005)(316002)(107886003)(52116002)(478600001)(26005)(4326008)(4744005)(6512007)(2906002)(83380400001)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vb+thm+6V7MtjslUv3qRt8aUCbVPia0/WsPdSJnW6YeJdxKPm3I31PXQ4Q7j?=
 =?us-ascii?Q?6alSSSulo40wwY4A3bmnbtLRt5a4lJE+98MsVuxRRvmsEnNT4ixxnM4cOWfp?=
 =?us-ascii?Q?VfnHXRN2FO05yifKdPl6ex+eS34wVQkT/X0/hMRPtQ3H+Tn60dWN6DUqnl32?=
 =?us-ascii?Q?GQehw3FcOPL5zavmsTs2nOkxcwLge2kMwLZGxVhxCG0twYc31JVVzIvDOVaL?=
 =?us-ascii?Q?k23kfB3ZJmRXsD7b18fg5gNlAoLRbuyxS470NKqZ1gqLhUI9XzeRttexGBRE?=
 =?us-ascii?Q?NWcyofH1n+vrVdxQgh3rWLvYLZPc/7xMNveTnZhGlzVxl5dvrZJJFb1gVrU+?=
 =?us-ascii?Q?O48tvBFze4At75usEeELLzbgfYUbg4AEEtbCs9W5HjZ/eeaxN1FSHEyyfK9t?=
 =?us-ascii?Q?3oeeKH3o6zRdmKvVnp+Jxm8dlKKdPKUTx5OmHvkrct/qXrnUSmX/0nfAqXQj?=
 =?us-ascii?Q?fgqgj5vCO9ACQMHYYmWQAXIqcitYy2yrO+hxjFiHZZgeA4PwUAaxnwPXF8tl?=
 =?us-ascii?Q?FlSq4ZLXzzfjhD9fd5tVj7qjWw/D5MwGhR2RGCPjNAORooEscg8uXrnzP2fh?=
 =?us-ascii?Q?Kxeddf2puz3R89VfY5ku91S7HtlIgL3iuldsZMMD2cmZFKvuW9p9HuQDcGtZ?=
 =?us-ascii?Q?Tq5MvjdDs766+TALZ8NKaKINBfZ0MS6UY8PHqwXcfOBF01/HgU33I51bqice?=
 =?us-ascii?Q?6vekKJdmrOcBePiJ5gUo4b/jcrDTKhYiNOmBypzHhtrey1Q5EgoV/ZThRyiZ?=
 =?us-ascii?Q?vTtgyR6gWcONh0Ed5dUZ5ocN4txl0AEMqPjGd3yG2O1nbUEvsVCchfwY7OBF?=
 =?us-ascii?Q?0dV7uBnWrP+UppentSvubLGGxfIAXniQA8LjlzELsdwzVSVPtPuingv4MnmZ?=
 =?us-ascii?Q?Sm0RT9akx9h96xOyohZXn9iPr5mkH1OOY5IzotCPFGUUpa2QA7S+oopGfNjO?=
 =?us-ascii?Q?bnh087lrjfNWnUnYdtBIZAPQovv1UasPmMyXfMNKFsCBiOzFIygD7SPKw+fk?=
 =?us-ascii?Q?+ePPU36I0/ucQEF32FKfIzid3c5HLsU687ZAzOyWd5b9+PTFT2YewNsqFZ18?=
 =?us-ascii?Q?6dbCcf/sQcVfaHa7XWFaHW51EVYhNvHn+vmAEL1zRPQECNRV9RfguWtzsX3j?=
 =?us-ascii?Q?NlRNJJcVnPsAWDwbjB/ZVT/63pljRE1yShDCMC5kQHin8MlPb3qUpDBjvTPn?=
 =?us-ascii?Q?JO0/DWHvNtwM5oc2U6PQaWAU1NgqpY/B4zyvDNmZ4+YhdHbFVduSqIWkgYx9?=
 =?us-ascii?Q?clCqkaidvMnPHiG91x7/LOIq/W62YyiFiWYAArdSyYJV0mKMyFyl7Xbpqvut?=
 =?us-ascii?Q?2KnTaDuF/0jR+dvLxsNYyA/dUr/hx9qvUbcPAv0hFYKUB3nOhcVQK+RhqOvR?=
 =?us-ascii?Q?zQSVhRcjh/xXI8iGrqE4VIp5WuJwapm39PGn2IPzG+nX1UCkLHbKpX3nLfhI?=
 =?us-ascii?Q?S88jSWwiBHQKNQZRCEo9og4KPUiuCSXBgYJt8umrBd1JVCTZeDWF/xxmVkQi?=
 =?us-ascii?Q?0kvpoDUmJqgkfHZ/2NMlQad9YEBxzYdXR+w9Z0gWV/RM+xIVno9UKtPHQ/xT?=
 =?us-ascii?Q?pdPSJVc2PxYnHe2h82qoktr6Jb4j/k+gE3wV7FFu?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad00763-6d3d-4fe7-bace-08db77092a39
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 12:22:25.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfc7DhzkzDk24AOHR4mAAsinEVnXqiNHAuBKChIY0x4E/0bE13HBzMzbq6RrViLlQSOMzUVnQulolw5RCz01aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR02MB4469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a file is not comprssed yet or does not have compressed data,
for example, its data has a very low compression ratio, do not
set FI_COMPRESS_RELEASED flag.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b1a4de3b53e01..0f54c1ff02f71 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3510,13 +3510,15 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
+	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks)) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	set_inode_flag(inode, FI_COMPRESS_RELEASED);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
-		goto out;
-
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-- 
2.40.1

