Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0986526D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLTTMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:12:27 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42EE1BE8E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:12:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRquStp6BCtUwjjM09IL7AekjV5WVzciTOVIRhkPCUFHcrEm8mDc/MAbJ/JzVRILDKNtAkMQJFSBZs9A0zoehm1WCpRW0XJATgoKG/BPGDxhFu9sdB2FOeNpsjRGW1aY6hJ1pORSUWTzvFxpHMYhOcHEP617djXh5yUBgLgxcBYvJyiACrt32J8jj3tk+BzWFUSorSaZfgoZzBxuuQX31jxvUdOsdKlSd0ybqjNK0tBL1gq8rmrTIAhWJ3jVylEF3FYNycuWHJxXC20sSap8tNeKL7n9Gn9uizqi/ckrFAivXvwTf2BroQ0UTAFmNt8Ovq756xQqAnQkJh23WWJ/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYlb+VvQ45px35aMZ1Gi7MA3009LbaQNL6M02U86kIM=;
 b=YQLnIsx7wdwlGzoX0BSabQXd0LApvXbIaQRkrrwUAoR5eu6qnROb/M/OGQTjTRj56dtqIPmkwWTdJ2GHG8ErbNv8jHRyHOYziXxnOGZpeUPXC/ZxCtZ4avQFo10zNZ6y0bQ/EoKqmanIBiGxRV6j2Brvgcjoov8OgyofTMzgxSYkD3xQ8AqmckUeyWaYapsyxFrxllH/ttDI1OP+Womt3udbkMs3Z0zHy8BMhlFS84DeWz01bPGL3VOTjX9CrA1etcztH6PverFqUInbJ1mDy0Pjz3OR39SFteUnSZUx6DAPgUkFn1qWJta4bG1WFM+mieo6fhVpi/CeKo7u98lIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYlb+VvQ45px35aMZ1Gi7MA3009LbaQNL6M02U86kIM=;
 b=UyBaq1bOZmqyMAygQ41weTOpsNwfjSjV3p5L/EocUzPMmtwaBl0YG0do1dQ2srKs6o2yMUduyS8X16+SSNXiQG8HbCLkG6aSb5szgiXoVxUTl8mdo0OpiqQJgqPof5X7/b0e2HfIVNLe1FvYmISDbWoiaL5DmWzVQwgVXpp1BlvhCSJsw9rXsAT3tWJvjnj1BV6p8qxj+Ee54vibsszFLLHIxaEhPWx4W82m1bfH1iN6z1fblaQCJazQoWpbFFDC8Abw1JgPH/Urm671ig0s2EdzK2TKzRXRkk9rkL1Pqd7DEbMduMKQUP1X6N9mLISEEVxTsPoEwAiRdBaThRwefA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5786.apcprd06.prod.outlook.com (2603:1096:101:ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 19:12:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 19:12:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: add a f2fs_ prefix to punch_hole() and expand_inode_data()
Date:   Wed, 21 Dec 2022 03:12:12 +0800
Message-Id: <20221220191212.58042-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d1cb86-61fc-4687-eab5-08dae2be1f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vm0AZnLtYiEhBs61BIZJJrEI3RDtJxAzUyFCYf4Nax1zLyfUumfZDzWMSw7XZJ33MsQvvXz9X3MbrY854euGsxKdLM+P59hBlgBTzymsXpmcRfqtpb3QLF474Qp27cGGy/SAgpN8nPY5upju7GaHE3mOAKgi+eQBKzJd2G8cHS0UgqOBQNsHcbscE+XkJOtIczI8dg1Fpddni0ayBCnNa/WuRjhWTCmVSCx3g8dcKXwl5B0dh3hFvsJ71KXkgAq9eDX+7CATaVw85D1Cu6BXCLbSrygpDueLNVhA4da+uN6SEPBbpGKUQJQv3RUMZ4lO0hLumpVmm8mRIamkGNdpDB/HVzJkT/KovJzPxsENDbdaKIJYWhezMfnhVIDRnLxxig9Wy+tdrWfNyYszCG+U+ZGz+GdBxNmeCpTfSuUG62/1kJOYHKD+M4LX67Oe7pnqYvYW37tsdXbVSKObGR1cpOzat68B8bCQRf2hBQSKe+BLfCeZ8U72u2d4CFkz3VlwEnaDTrdScGBzO17v/s5nKTXLblnHY3hvOfExuhiJ5BLV1Xpdt+J4IDIQSbz/R3JjZw7VDTWOhH8TSYRKHmeFvQQ0HSgIRFERXOPoqSRyDR1wSounPkgILCkHyNbO2xFjHbt2Xix9apktCp9D47TsB8d9ZZByGtabpCjWHQhuUmOOcLVB+78OBOrJS9AclL849L51g6yUswVzOXFdvtRAtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(83380400001)(41300700001)(2906002)(8936002)(36756003)(38350700002)(86362001)(38100700002)(6506007)(186003)(478600001)(5660300002)(6486002)(6512007)(26005)(52116002)(66476007)(66946007)(2616005)(316002)(6666004)(8676002)(4326008)(66556008)(107886003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua0C6Fiu2HYiRwy5vSnULE8DAWFpAR5UprPl1RhG2a+KVa/Y8MYKlINWF4b2?=
 =?us-ascii?Q?qBTzgQf9diZIWWSjHFVXyMLTJf+4R2fp5i92AQvIaDeBF/jQsGecFF+knjzL?=
 =?us-ascii?Q?kTVQFlJiT3a5Tis2Iv8CJjj4VAJTT0P9k7+Pv4QbjVAVzsC3nyNDo4KkDQP/?=
 =?us-ascii?Q?gN8jjA5iDw9+o4paXnTffjZ8yRv8b8IjKOgECUJS1w/vH/yrfR0vdBwZNJZY?=
 =?us-ascii?Q?dqIgPtLnKtrH1S+ZpOpqzDKFSghhiFMy6sWkq3EzPZFDk+R6g8I0LKo9Fzs+?=
 =?us-ascii?Q?LZT0zvOtj0F0RcCke3WA/fpdb/kKphc8JT8n7t51j+QL0y3zQvbvOyb2YLhc?=
 =?us-ascii?Q?mBOWE09R022qm8FLQeacT+3VtAk/Pf5dSjqlbwRH9YXzGTqFqRLIO0J/3Ryb?=
 =?us-ascii?Q?qlG3AJ7rJvUm0vEUuKmkrxQNnlJy1b5kpbbtMlDxEcyFa7uWmdOY6jI3BbvK?=
 =?us-ascii?Q?ImW5tGTqVp2tyXN1ljQgDBDO3ekmX4jeOiSLHPcSUQM9GcT4x2Yd6i7ZDCyR?=
 =?us-ascii?Q?WQ0P+YWTKfo5yj1/NgyjklN+yiuFTO1Io8+3myDM/uzB/nMeiZVcsdPd+Ew2?=
 =?us-ascii?Q?xqh581hQKa3uHepZGytOhd9UMU6mtmF3i8wKNaS8JcBZ5xhu8qs5oiFPpcL3?=
 =?us-ascii?Q?9QnLvfRCf0s1QRex3wHcua63qbPqYeEom2ibS+O4CIh52biskT2KNAfsh2ig?=
 =?us-ascii?Q?MkX9f8ZFPbJ0Rim6uQ06azYCEb+tIe3jmYg1zzPb82raGJESbkzHZYMJxwNL?=
 =?us-ascii?Q?bvALmq2ZFpyhyMFGTgRa3Am3B3Vu41VKmU3kkBxi0FYz50VVLftYZvVXtktj?=
 =?us-ascii?Q?N0NwcR2STiGh/Pyau1EqTtasTkfM+ofXrSQF6YLt2uvR0i7op9zgwt1XNOwu?=
 =?us-ascii?Q?ZwufAgdqpmkCl7TIK6jHhDExLJ5REyw6K+rpc3CCqspiv8neMTAsiQ003Wvc?=
 =?us-ascii?Q?fS2f/yypxdyJDR3yqdQVO+ygWPl0KBQELb07yWCur5QQDV0sqqnlV8R3FyXG?=
 =?us-ascii?Q?Cb7ATTx7UpvmUJ+DicUkjApxdyvD8hFZFu4w0fjcSdi79M2/+aE8+QDNP5VL?=
 =?us-ascii?Q?pqD4OG0W6F8nYYRQ+gbmjiETc5BuobLnZ+XtNhYEBqQMdkAgdmWfXJABgTuE?=
 =?us-ascii?Q?g9mDMQ4IV1t5Yx5DKTck3lGIIJ0mYZbjFz0qri5Fn7Xqn2F/FMUzSXCEH0mA?=
 =?us-ascii?Q?9SdXFNF593Mkki+9+rvWWcwHrzDPmnq8RbqIOTXFR1whnW1RnsLXuFyY8k/m?=
 =?us-ascii?Q?SEXtaj88yylkyYttfDbM/DdhHV4B2psnHCr6hC+PbYZMd37TEoCOKNCTVuH3?=
 =?us-ascii?Q?G2GjqSoDbuL/euuTDUWKIsSdPJ12sn56XBKG/FCYrlOXa1+iLowsqICmurUk?=
 =?us-ascii?Q?jR5yh9K8VqVQZW2Xd/mvdmFPa/rv0bEBBpyRdks6+L9EyIG/1JAUY5kvxQgI?=
 =?us-ascii?Q?mQdERZtjYjlqYlGC7qLFVUp1Jn+VL49IwcwnujLIp3W2+7dsHHh+cBq2vEQN?=
 =?us-ascii?Q?wAzYX5OyD4clkGxPKE+BMEl/NCD00bkdb2/OTb/a4DAAscsFN78GKEo3W6zW?=
 =?us-ascii?Q?aaZDNhjIHJAODxF8ssrjA6ginu9kBClDdCLzr6l3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d1cb86-61fc-4687-eab5-08dae2be1f43
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 19:12:22.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7s6aXnxih4Y7dvwsURV2U/m49MKsL5hdOJDjHGO2Qg7XCAI1qvfDAhBUouNppMZoSZlgijfiKzuJ8sbUFvjuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example, f2fs_collapse_range(), f2fs_collapse_range(),
f2fs_insert_range(), the functions used in f2fs_fallocate()
are all prefixed with f2fs_, so let's keep the name consistent.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ecbc8c135b49..d5371951b14c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1112,7 +1112,7 @@ int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 	return 0;
 }
 
-static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
+static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	pgoff_t pg_start, pg_end;
 	loff_t off_start, off_end;
@@ -1684,7 +1684,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	return ret;
 }
 
-static int expand_inode_data(struct inode *inode, loff_t offset,
+static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1832,7 +1832,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 		if (offset >= inode->i_size)
 			goto out;
 
-		ret = punch_hole(inode, offset, len);
+		ret = f2fs_punch_hole(inode, offset, len);
 	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
 		ret = f2fs_collapse_range(inode, offset, len);
 	} else if (mode & FALLOC_FL_ZERO_RANGE) {
@@ -1840,7 +1840,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	} else if (mode & FALLOC_FL_INSERT_RANGE) {
 		ret = f2fs_insert_range(inode, offset, len);
 	} else {
-		ret = expand_inode_data(inode, offset, len, mode);
+		ret = f2fs_expand_inode_data(inode, offset, len, mode);
 	}
 
 	if (!ret) {
-- 
2.25.1

