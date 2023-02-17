Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9269A592
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBQGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:23:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BCC59B5E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:23:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRAqP7KWKWHaiOoW5z1Ov1prrA8WRbyoHPzkiW2WwPn4zaOnh+NcuxkeYdzYyn6cejsD9qjW1ccOYG5YRs5a2CcVQyKSl5k7+zXxUwNErG9gtUBG9gbDSFLuMLF8h2lAp7rKQF60Y6oCX7UpaSqvpklncFTOWJILk3mNgd2nrVCejNhG3DoDn4L2tlJps99GHGzhMAMw0E9mDbb5jnCJr/ZRrY6tq5Nnd1a/0wwOAIf4UteE+Ee9uGblmG+KH8IbCQ/fG2me3fMS5ZaFSA0hue6PIi8RqStTvaApemVNUuSNGh/BzCQJ6Y953/JyjrWhcqhObVsE9+hOO4mrfAcBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhBkYvjPE5SbejNzYX0VsOsf2+DeA6gxONrd6bcrTnU=;
 b=gUoAD3uAfzGspL/QG1ogRwxRAIyz4Ry6Yqyf0FFIxTGq2Cg+EGZ9Dwe7ru/AhZmkbHg61ezsayVC7ztWPHyJ2pZo68P1XbMxvaq0sPZVlJOmEkQYhzWz5n2KWSL1sMj1SISpjCe94fduyZahvU80ilErTg+6/jslqn27awD79eWRoc/dKJiFCxJLdzUGF37zI9iHZyEoyH443j+BCKAX8IVw1DzH7swdXUts3COnLKJ/xd4pcs+BcGkFXxGDHBTZT1R/U0EkGnZ5Kg/PwEmFMblaHsxjnZa6yH7lJEj4TY8yEYvkWCx2d1VGXjJ7a5P5VFTvSRYlPHalypWXPd1yRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhBkYvjPE5SbejNzYX0VsOsf2+DeA6gxONrd6bcrTnU=;
 b=loYvy1VLYsSSPlkcySWXgeaxNCOz9sN6K7gyoqxMQbw1hA3xQTHHG9EqQqdtQ0CWGMhVS6ZmDaVKS1P01n2KqDvDF0CQoHsSo/CHFbFkhrXUy30SL6hP/rPXxw7IVJ/eHiav7R33KJoWOkq5h5AQe3ms2vvHKXmLPlUE2usIAYGAExm4R6RhJhi6xnO5HV9qJmTLp8/ZVPOylR14XYHLPg5ejSc8V89/1j7eBs+9RqxHftLvzNMMs7K/aD0eQ/oCjudgLgMHwaKvzNKgipIpRBerUZ7PkFEZfp5qdzq6ZEz9/Kk58D95oG5gL/aZ/RLZnz2CPmI6JBl/5WkB78/oeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TYZPR06MB4447.apcprd06.prod.outlook.com (2603:1096:400:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 06:23:02 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Fri, 17 Feb 2023
 06:23:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, terrelln@fb.com,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: add sanity compress level check for compressed file
Date:   Fri, 17 Feb 2023 14:22:42 +0800
Message-Id: <20230217062242.60998-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS3P286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5::9) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TYZPR06MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: ab29d2c2-bf48-4441-53af-08db10af6c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxLTYlNNXmpljNKZYpmhG+h10AIEJxLT80iW2xJ2L6wpjt6gruBqW7NdPMlMro5RatUxfsVxO+bGH+WGh0rUUVTvdtrnOCJw6CUDJcOPX4AfKtk3DPHZx/T1PsV1S4RP1Puzoq2kOpoTICZrGFBeuBpqkEmWVVVOSE2UD8mhtlbpRsnZQqKYk7NQW/gOSMncdwmwDMKEf70nPKvpROOicR1V5gv/5AARXbC69psihoplULQc5CdAeU38/KELtt5UnXN1Ch8LSJ3+ChCVtr08F5jdvtcSM9Zm7zYtx4jZ/qSXONnfMu8OJwjMkVdpJHAUkW9qfCEYsi1O2PuKBSySLO/SkKmoesDwWhcYTi89AvQdQSFcPSSKZqczpaenqzK0uV2tA2nPpTM56KPTkOp+LEtnmn8N1gREpc/6sHIe5qcaMBYjIqxM9aKwlk95nxkzabkYTW0RwkLUqajASdsnGBWedokg3ZlhkTIecbn3N4mulBjwElZg2Mh/ZWsmdZWDAqnYZ8wu/i1AUIsmeCHTXxNXyLqeJ5VhZPDJZwo7bQNYP+di8AicVk7nr0nZCN3FhMwCgOnWwDaoWMdIsXpcrB/QhbNq4g0+ADvp+SF2LCjZhdGW2yaHmgmJUOVC2P9XQ8IcVUK7aDN1xnsM54ocdvAixIym8H8k5TzeWtij4GoLulXrxEZ6M3T2imq4hAXn05W1/y6QUns3hiBjisYNjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(451199018)(41300700001)(66476007)(66556008)(4326008)(8676002)(66946007)(316002)(86362001)(36756003)(8936002)(5660300002)(2906002)(6512007)(6506007)(6666004)(26005)(1076003)(186003)(107886003)(2616005)(6486002)(38350700002)(478600001)(38100700002)(83380400001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSCBpu+vqIqDt9XL7H0KDtGWD8hhnmsRk/KYyT0hmxRSU7sNtDQ9k+Tnchot?=
 =?us-ascii?Q?f7xIHeBlHaR7mKvh9DXKlzb1XSH+5z0rQji/BlIlXBOg/ehM5PDcuvHJMAlz?=
 =?us-ascii?Q?PBpEUNxNMquzx25K6QDet2bqFSW1BmL8ir1GssLlfDjY2UxqR4fxVYAD7AfI?=
 =?us-ascii?Q?mq69Vq1IYLJMy1JDPIsYwFqK3b8RaMnq4He+rOyo15YD0ZHnhTbQcFDFujPA?=
 =?us-ascii?Q?FNSHtIJRO8OTdPjGVjxL31hp3s29zrbyU8YyNruVTmRxvdwJVha1ctONdIy+?=
 =?us-ascii?Q?26i14MX+IFUchMabIhkgbp6PvupH/NwA94YuxDxxOJghcZM5Vb4zvoS6zBco?=
 =?us-ascii?Q?qTycPAjnV+nUCApIbxI7Bph1pNaTJuzJYm8nf5sDlKp4enGBWsf1bjmFsdhz?=
 =?us-ascii?Q?Jyjdbhxo6pjOMmUFsUYYGQaSBB67z6RwntzWpkNxuFPDPHCoVKejjvPWxyBO?=
 =?us-ascii?Q?g4xz+UaG1SMC3grPy399c9xZlfd/UAjPCfVnq6YWB1en0No+v0l1P4YuvdkK?=
 =?us-ascii?Q?nVAiGpvrL7insVLim2zj9zNG+gFYCn64+44VnFYS1ROAdn9v1/lAQi89b0LS?=
 =?us-ascii?Q?moq3PGxR3ojH6tRuKVYjYxmhPnJqfDxyHivmJi9LqEvyzqAAP40R95SkUQ6a?=
 =?us-ascii?Q?FovV05/oE/alTMnuKWED6fFbLRSxfCaDtm32zKJoIv/OUIEZYKBRWXAvIjLS?=
 =?us-ascii?Q?l/YC+imK6PRQumckxReQXpTqaLn9QrT7xa4HFnjJgg1JZRHBWc5FBWLe5tYb?=
 =?us-ascii?Q?8sjYjo0ZCoX/iDb4zaaPnVgBeFjjcrLbJHk7OAIpYyrN5TkW5sL7qS4jG4CF?=
 =?us-ascii?Q?unJy0EN+OuBwEQx798LsHIlQmkKTwYkbExZnsPm4ofygKq62LIOvpRRHjZJi?=
 =?us-ascii?Q?O+bM4cmJmXL0eNq1wDxw2FV9c+mLsyFxrAmsYbowJki+xmpJml3uRl4Mhdyf?=
 =?us-ascii?Q?bi7UWEkOLKkyx9/OlzWS2EFEsJIkB7Q7TtrqR5lhvAlxZL+h8d5qdjFduHm4?=
 =?us-ascii?Q?Lxh+XjvAYg/BVstRClpfFHO/MlhyMM93RXQymhvqaly6qUyf1eH7FFuVeIOM?=
 =?us-ascii?Q?GtCpMXmTELJ72zCA/gADID553ScM12Nzy6RZGtHDq/VsAtMz2k32sqiWZBWM?=
 =?us-ascii?Q?xpQwWwy2ZMnpCN6qGrD0WoUWSDbCs72r/+UU5lT3JjV8GVtIg3dBh9llLRHn?=
 =?us-ascii?Q?71yPAUDCwsRlNZJ9Fybkte3sFvD7005KRN2dTyCteHkGWXHSt//dPMwR70lm?=
 =?us-ascii?Q?wrycYi29R7MeAyJw+aBm8U4h2ZRJHEDzpDkfvRzZFmT3FEl7A0MFiGp5BLbe?=
 =?us-ascii?Q?onf3MwtwAnWQtIp3mNarzPKTn0i41F+YlMx16YYkGVQfrbRE3O6t7uP534tU?=
 =?us-ascii?Q?sBmllhmbTz+nBru/K+NcJh4VUkvaCpXrHrpIBvxZheE8rPlhxrH9Qk9bX46r?=
 =?us-ascii?Q?ZBps4LXytwhUzEIjG/mtpN9KhXbsC2SXGeZWfvp+n00BDx+qSgGc6XRTGG9U?=
 =?us-ascii?Q?wZr/LtnYNATD6Pd0srEgqXnJgDBkcPMRZODzK4e/5GBrTpUaELuDyIUyHqBl?=
 =?us-ascii?Q?Gf7dO6CuHKM9etktSXedvKyyNkk/62gBo6faGuow?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab29d2c2-bf48-4441-53af-08db10af6c31
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 06:23:02.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqQ2PP2+PJJqA7hc3X58a+GUtfEpVOzakeI5zT9pYBnpha93dOvUeY8g/iKmPnLMwNlloywQpocZ2HnkgFzTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3fde13f817e2 ("f2fs: compress: support compress level")
forgot to do basic compress level check, let's add it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/inode.c             | 94 +++++++++++++++++++++++++------------
 include/linux/zstd_lib.h    |  3 ++
 lib/zstd/compress/clevels.h |  4 --
 3 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7d2e2c0dba65..3dc973aa40da 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -10,6 +10,8 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
+#include <linux/lz4.h>
+#include <linux/zstd.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -202,6 +204,66 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
 	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
 }
 
+static bool sanity_check_compress_inode(struct inode *inode,
+			struct f2fs_inode *ri)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned char compress_level;
+
+	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
+			__func__, inode->i_ino, ri->i_compress_algorithm);
+		return false;
+	}
+	if (le64_to_cpu(ri->i_compr_blocks) >
+			SECTOR_TO_BLOCK(inode->i_blocks)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
+			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
+			SECTOR_TO_BLOCK(inode->i_blocks));
+		return false;
+	}
+	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
+			__func__, inode->i_ino, ri->i_log_cluster_size);
+		return false;
+	}
+
+	compress_level = le16_to_cpu(ri->i_compress_flag) >> COMPRESS_LEVEL_OFFSET;
+	switch (ri->i_compress_algorithm) {
+	case COMPRESS_LZO:
+	case COMPRESS_LZORLE:
+		if (compress_level)
+			goto err;
+		break;
+	case COMPRESS_LZ4:
+		if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
+				compress_level > LZ4HC_MAX_CLEVEL)
+			goto err;
+		break;
+	case COMPRESS_ZSTD:
+		if (!compress_level || compress_level > ZSTD_MAX_CLEVEL)
+			goto err;
+		break;
+	default:
+		goto err;
+	}
+
+	return true;
+
+err:
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
+		  __func__, inode->i_ino, compress_level);
+	return false;
+}
+
 static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -285,36 +347,8 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
-			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_log_cluster_size)) {
-		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
-				"compress algorithm: %u, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ri->i_compress_algorithm);
-			return false;
-		}
-		if (le64_to_cpu(ri->i_compr_blocks) >
-				SECTOR_TO_BLOCK(inode->i_blocks)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
-				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
-				  __func__, inode->i_ino,
-				  le64_to_cpu(ri->i_compr_blocks),
-				  SECTOR_TO_BLOCK(inode->i_blocks));
-			return false;
-		}
-		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
-				"log cluster size: %u, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ri->i_log_cluster_size);
-			return false;
-		}
-	}
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_log_cluster_size))
+		sanity_check_compress_inode(inode, ri);
 
 	return true;
 }
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index 79d55465d5c1..ff55f41c73d3 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -88,6 +88,9 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
 #  define ZSTD_CLEVEL_DEFAULT 3
 #endif
 
+/*-=====  Pre-defined compression levels  =====-*/
+#define ZSTD_MAX_CLEVEL     22
+
 /* *************************************
  *  Constants
  ***************************************/
diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
index d9a76112ec3a..b040d9d29089 100644
--- a/lib/zstd/compress/clevels.h
+++ b/lib/zstd/compress/clevels.h
@@ -14,10 +14,6 @@
 #define ZSTD_STATIC_LINKING_ONLY  /* ZSTD_compressionParameters  */
 #include <linux/zstd.h>
 
-/*-=====  Pre-defined compression levels  =====-*/
-
-#define ZSTD_MAX_CLEVEL     22
-
 __attribute__((__unused__))
 
 static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
-- 
2.25.1

