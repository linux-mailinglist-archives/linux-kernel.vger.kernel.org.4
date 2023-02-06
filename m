Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4A68C05E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjBFOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBFOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:43:26 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2094.outbound.protection.outlook.com [40.107.255.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D519244AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqFwXfauPHX6pA+/Q2VTc3erQYjSBApxXdZt4TFTnQD0ANA1oY5JItClFS3AhUbf95xpcfKt/VQ9yRTzTR+EfySKeVedXlL3Jfdm3E3WW1pfSmoLnWrqXy6jqTLeWs6v5NsKdn5YsIyJMLs52Xk8j2tBNmL4COqty7qFUaeDZMZhv69NMkNkCZ+rbp+n+6+x7wY1Z3NlEey7e48rErfn8H3jpvtvUHDftP8lUq/SIa5aALp7h9PmWuHJc/EYF9fpQACwB42RbvLfZi8mSpMRyTss5Ic0BhdNuU/xB90xnWiW4N/sqj08qfxQb5iFmCDug0EB1ZRwp0JNjfEWE7F5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iikdIJXshUUDmQOlc2PXILnzDwFSNzD28AtS3qvMCXE=;
 b=IfyJdgwrVdwzt2fqXmzVTF6caJUSMPao8O+gNJfdBea+2is+cNWrM4j5rZf8R0r98JIGo1CqlGztK6rHOutcMliaXaJwH8gUmGLdzgnMDVXbo7XwnsNthvsgyp+pcomqeJAuImfpNeLrO8ByrhobC93eiRhR52YwS//I3ydhjjMMn/NUapN6KfOqSkqTyOtPkV9cllcMPw/T7IAHjgIDD8lTCWiMhN0v0aC8NRgraqUdJWc/4L3JwzrVvOGFTtpj/PFg8XeersFeTNhXnMkhp/xgUzh4qeZR4vMtA7rh34y0mXSXVc4VTeG0PeQEyFE08EuPe+UiX4l7v4EOybvxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iikdIJXshUUDmQOlc2PXILnzDwFSNzD28AtS3qvMCXE=;
 b=jZsYa8oGq0zuWRKZ4nNUJJUEFnFg1FY3kEELaD0h45dG+UadvTIWeZmcF2CaZJo4rRkGqDldPLSRttdqR4kbVcNEyqB3qquoZq2m1ybTgEdYNpAqDJPVwtU/368dQ82KwAOq4FFJNKU7IgGlkd6GqW32prgg8Uq+rAIJeqigaHlhREEX3qJATEbBpVK3CmfpA8D5ciyTeU9oBZAFhO48KlCj78GB7THpIqbI5l1yOuD8Tgby3pgwQqINAjCU99lVYqRh9vjbP8ZvMAqb2ynmCAWroLmLL2VXZoyFU9GzBX0XsUKSQma6trxrvqTZlsSQBOSRUjI5XvDWSGvGfvImnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 14:43:21 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 14:43:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 1/3] f2fs: fix to set ipu policy
Date:   Mon,  6 Feb 2023 22:43:08 +0800
Message-Id: <20230206144310.2344-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbf435e-9d19-443f-0499-08db08507e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RbrPXdgFfIZ7u8TU4AW2LdHe2zBP/5jAHRGC5676pvGo3S13c76EKwyScCwDcwude8QImKbRgSRLAwMK1otNwC9h4G2npm160hhfplxAOPkexSdNEvpJCkmv0j3lwn9o/OUJ6Uw/S4+iptVB9Ejz91NZMvRGWOJDIjQ1aRxhSG1AuuY27PRixtImEgGTWA0UhIPCwX+w/2xbogeodvfS1Fgn+en0kulMi133rSYxwaGN0eNKShi5m9MtVmbYxvUI3dX9vQUqr/ENxpAIl/2Ss3BRC30x5BW2PNqC5+KmF/dWBk1F9NetmcSqntUnMaBlUqdfMfK0JlX+scDpVU09aCTkiQtDFAylScF5LqHBXf3pV+gR7M3ZsNARBlvEZoj0Drb/IUsrf4Q+W62bQjCVgU83Jwf04NOJpRL4hHjQJjG2Ua3GIMvOo5C6xmOaf+RdJ9AuLWsm87K2490yb5llx7BlBJBit4bPv4Oqzc3lq3CZAVb01cUcvIhGv8TI9BCfwPPwAJDWaO0+mI1Z6BdOyCmX45MYwcvPLDpKDjPTaZs3pYgLPJSy1RNw0ZXpd0/dPyQrNgg/4Z1HKpIjisQc0AgcUXz0838Q4rtX7a02JXM8/oTRVnxL+WAHVzRQtbikt9GmjgSjd5NltjVdaDZOnb7CzukMFzCDVaIXjsrUntpJuX+zxLrNHTZQgKFXgD2mL5SFWspQVA9UVcY1SbKKaJnKfBbSBIri38c8NYpV80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(38100700002)(8936002)(86362001)(107886003)(6666004)(36756003)(2616005)(38350700002)(6486002)(2906002)(478600001)(52116002)(66946007)(66476007)(316002)(6512007)(41300700001)(4326008)(83380400001)(186003)(5660300002)(26005)(6506007)(1076003)(66556008)(8676002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pAv3ivSXgTriOlWbKD6fWDtuwE+2reNNf31oO273DneqinmP2IKlmJ4RY+my?=
 =?us-ascii?Q?582wkHx6ll3Qr2JnJBzbQX5v8WXKt21XP0f5MaTA39xh2iIjtfNylxeqo3zg?=
 =?us-ascii?Q?kpaEZIslN8Oo2+0FH9K2t23Bgv7rCB4yygpQM3UyzxNpW6C+JILUojH4jcre?=
 =?us-ascii?Q?Pt/Zq3yd/o7Lkla7NgblhRDMcPwjd9xEQwpIt4O1gi7SNrU11jFXMKbrMFKQ?=
 =?us-ascii?Q?PGm/mDZ9Mlqlyp1JOxHht5XsSkrrA5t8KCNY+DIMphDvfvqgN9P1rgVa4qNt?=
 =?us-ascii?Q?hXYlZ+h+kNz36CkU/Yv6tnWPMxH/JgqC5FXWjvgTPUY/OU9H7fdVZS5cQCnq?=
 =?us-ascii?Q?Iw9cFU6FY1oRqAzYiefDuF3CO0M+n7l1LgTm852Wss6ohG7H8sKnp7Ts/1BG?=
 =?us-ascii?Q?Z9qH9fflFVbaw+z0XZi9jNhDYsQ3vFqov/Wl8XW8VGo+rCCRyWwqbq7X3zXh?=
 =?us-ascii?Q?t9RH7LfHmstWSGU0hlRdYsTCXu73NLAUhPy+LF61g9JEUR897uZJQkAkRULF?=
 =?us-ascii?Q?aQGDD5+4luoBDnVTiTcEyunx3ddKSq34xRH557dsCEUM5+DMYyu4Hu6sngJO?=
 =?us-ascii?Q?vSewYznJ2RHJ3WrAhxofSmt7oSV3+9qBbgRY9qH1hwpzEZv4UEDkEU4FHu5O?=
 =?us-ascii?Q?7YHL61pK17rBcF/dRJdmJEe3VVXai2H0G948nlu42FRHpCE9g5OlxQh3rB91?=
 =?us-ascii?Q?QbuVfu3Fp3hdlwTJE8NVcKY/n4toJs8szgqCv5cyxqYfh4B2z1V6/7rHxBOn?=
 =?us-ascii?Q?5IpLuXBGhb5QrqleSPaPQPJEkHGt22HFhAW3V3GafVXyktyn7No356I17IOR?=
 =?us-ascii?Q?I/VaWpSwaIj4OfScf4JwoWfhXM+8KKt8X9AE2yLaNailJI21zcCzh8oGZ6z9?=
 =?us-ascii?Q?SrBcw0C2f48lpK/uYc1QWiU4OxfHUg43zq+dZoJ04Z2jyrPXn2PhK0ByKXG1?=
 =?us-ascii?Q?126hYRB5MmM4BcGZbja+0VC6V0NP4e3Xu732N1f1zKWdikcRYlJZujQK0Czl?=
 =?us-ascii?Q?thA0DZ22T1GgGZEhbiYiWQMFr1XReBXLk/uWjYA7xod3JXoLCMq9Z++gOrYj?=
 =?us-ascii?Q?+WfD0fbJar9zBiK371m6ENqV+5M+fL/7ddzXfloQlRm1kGP+q4mtzm8saeit?=
 =?us-ascii?Q?QGybldlzL2dIrxYbF1Vse/gyJmtb8G7NJFiWpc+PX8kr7P3MJ47Clbxepi87?=
 =?us-ascii?Q?cRxnTxLTpIYMnYQaC8ASpv3sss8Qfq0um4BjtXd2/arnXqErFI8aabchgq1e?=
 =?us-ascii?Q?9tEMgL79oxOuyzzZN+UiPMxvGPjb/LRpLiI3R7fcbZA7J6VnXeHAw1W8R1dC?=
 =?us-ascii?Q?jSaPzqyLDOnwExw18GoVN8sPmVax+3vi1JFHBdOhJH86gYCFA0y+VZHdmzMe?=
 =?us-ascii?Q?X9C1Yo1+j8pjX26fK5jZsBmZc6nzHeFi5Q/4yCLBAPPW5B6XmwvhVMeHrmnL?=
 =?us-ascii?Q?9u17a9EYRNSYLaCK4DK56yIjxCqLsQzlLldTIBOT42rIdAcNdpDAFIIQOmXF?=
 =?us-ascii?Q?ZKBpqAMYEmazC/8uFHqb6qVIGwUhf+6ShlT45x6JhHLclz6cipBsOePbFEDf?=
 =?us-ascii?Q?5mGXdY0NYmIi65Qnb/rD8AAZNNYxr3FGqftp40am?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbf435e-9d19-443f-0499-08db08507e0f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:43:20.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UDtFsB6deO1E6Rr+oNxo50XiZnJhBbYDLPBpmAlSEGgWjOsh4FA+D6ZqCqAk9haJiOzWCoZXsd55IidHGeAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LFS mode, it should update outplace and no need inplace update.
When using LFS mode for small-volume devices, IPU will not be used,
and the OPU writing method is actually used, but F2FS_IPU_FORCE can
be read from the ipu_policy node, which is different from the actual
situation. And remount to lfs mode should be disallowed when
f2fs ipu is enabled, let's fix it.

Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-allow set 0 in lfs mode for ipu_policy node
 fs/f2fs/segment.h | 10 +++++++++-
 fs/f2fs/super.c   | 17 +++++++++++------
 fs/f2fs/sysfs.c   |  9 +++++++++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 0f3f05cb8c29..8ee5e5db9287 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -670,6 +670,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
 
+#define F2FS_IPU_DISABLE	0
+
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
@@ -679,10 +681,16 @@ enum {
 	F2FS_IPU_ASYNC,
 	F2FS_IPU_NOCACHE,
 	F2FS_IPU_HONOR_OPU_WRITE,
+	F2FS_IPU_MAX,
 };
 
+static inline bool IS_F2FS_IPU_DISABLE(struct f2fs_sb_info *sbi)
+{
+	return SM_I(sbi)->ipu_policy == F2FS_IPU_DISABLE;
+}
+
 #define F2FS_IPU_POLICY(name)					\
-static inline int IS_##name(struct f2fs_sb_info *sbi)		\
+static inline bool IS_##name(struct f2fs_sb_info *sbi)		\
 {								\
 	return SM_I(sbi)->ipu_policy & BIT(name);		\
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4ec2cbbc47eb..09696fc844ab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1346,12 +1346,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	}
 
 	if (test_opt(sbi, DISABLE_CHECKPOINT) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS not compatible with checkpoint=disable");
+		f2fs_err(sbi, "LFS is not compatible with checkpoint=disable");
 		return -EINVAL;
 	}
 
 	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS not compatible with ATGC");
+		f2fs_err(sbi, "LFS is not compatible with ATGC");
 		return -EINVAL;
 	}
 
@@ -2304,6 +2304,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 #endif
+	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
+		err = -EINVAL;
+		f2fs_warn(sbi, "LFS is not compatible with IPU");
+		goto restore_opts;
+	}
+
 	/* disallow enable atgc dynamically */
 	if (no_atgc == !!test_opt(sbi, ATGC)) {
 		err = -EINVAL;
@@ -4083,10 +4089,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	/* adjust parameters according to the volume size */
 	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			SM_I(sbi)->dcc_info->discard_granularity =
-						MIN_DISCARD_GRANULARITY;
-		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
-					BIT(F2FS_IPU_HONOR_OPU_WRITE);
+			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
+		if (!f2fs_lfs_mode(sbi))
+			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
 	}
 
 	sbi->readdir_ra = true;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 575a5536c0e7..3c3dae3ce84e 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -706,6 +706,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "ipu_policy")) {
+		if (t >= BIT(F2FS_IPU_MAX))
+			return -EINVAL;
+		if (t && f2fs_lfs_mode(sbi))
+			return -EINVAL;
+		SM_I(sbi)->ipu_policy = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
-- 
2.25.1

