Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2591687620
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjBBHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBBHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:03:14 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9922BF3B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:03:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNLX/8Aa1C8onHkbW7u0RB+QdWKnE2tJUATME1BrFjwFyhks3CS8T+gkrhsImjyFxGjQJrHkE8QT4yPtUjiNjq9JBgPuu83dNzlylzZ09tQ8O9rNZPLAUvle45ZSUXon37iFMHQKPFMr0vvSO7k/o6c1RWLd7EIYD5f7pn2MKRLSOLvAnk09UmZj4erer/ZSPbkmXvzU+tbyHKOhEJQRQkaKvge4fhyCgCnycwUD54SocUOPdKgog3nkc0Wtb3ut33yPIhQhRdOtFMlWZXXpUlRAElE9TFnvh0ZSefTgO2bj+CC5FOD51bQXCBFFF9ZXP7TtDON6eKQqDKjgs1iSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONGN2cZwwgqqjveANKQrenMi9E05WaJ4EnlDp7F1R8I=;
 b=PyoV3jgRig4HCTctsZzulVDySw+z7bfBYyM+Uh+vqWLZ3U7wxB7FEWXmeBcXzSUKxOyGrGlQPS4AuIOXXEfZc66pyym38faQPYyydSa+mV1bkp+by8zllm9fouU1yOb9HUmD9jk6nk3JslsWfoQRwds5jSFy1frvLE53WAhig2qa0qqBKHHkLqVXdb4C0TsHkDATPSD0l6ZPdVsoFoh28g3zRFbV1dLY3eqcM+Rek9gS4Zj7rrpstsHe+KtY3EOir3KMK7Nz1auyQhcoASflrRHYFC8QNwpRFe4i3XN8Ue5zlm3VwI2Zx15GJ4oB0NqXG7cwhBBtxa86tRHSAMH9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONGN2cZwwgqqjveANKQrenMi9E05WaJ4EnlDp7F1R8I=;
 b=h9NYYgv/Qls/UoHM4wRR0hidrtQ2ZdN4SnszwXQY8e+ukdPPB+UEtBF1dnXcfx1Bw/QGshrxrGckcN9ojDGPuSpMwfFGBfXRXfnjBBjay9cOMElmjecPJKauQX1NcOAc+9z6/m4hC+WkVSWY4vJ1UpC2eOe2tZtAKwdG4yMbFmRdqQXgR1I72czv5Gfch8VQvH4jyGBqyq6u2zZyB1NZ+seYOsCzFa0dXvQSta4dK2XL/D7McooCefS1H9U2pMmYOH/0RLWy1W2PtPSLT5iZtYHlO2mdSGG1PQagmAeDlSn93c551QkrGlVRryPMQGUaABzVbJeTz3ocbMrmb1U2DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 07:03:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 07:03:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix some format WARNING in super.c
Date:   Thu,  2 Feb 2023 15:02:53 +0800
Message-Id: <20230202070253.41291-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bbf4b5-abf1-4d08-ddc4-08db04eb895b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBb2jp8ShwTPtDE+tU/fBROf9RZhlV+M8gt+Dvbp0RJkGvP5OT6zmQrtE8vquT6vzm6Tv5GSdOy+sa3ZToK5EA/9XdeDCSNrhmpmTQaTmN3X27Bn0Ra4xJUVUkKNQnQ68w8PNPZJkekw3SlMo9weEkQUTM8OrkKG/Jaok0ZnmT1zj8+i9Z2b9Ee40izpSxbON4g6+dhFPmbHjdNafFl0LJWQ+ZJjuHKRa5MDjld6PaiIdWSndEfk+ueuCN3dAQTNPjHL2GwbC9s62XD4gUqI+ZoqKisiclu5IR7uIMzc2GddtDTNcyKHt/jImATlLMEohvplZV3nQofK4dJ22Whp3v3w93Md4S22WzMdZBWxC7svEBMpsSLF3x+w+VWdcREjZ7Ld/0JNcxWVu+D9WuSFiccOprkgK+9bARC7anryyMkWSVFJM59Z25saZuRtbcQnMjThUi7IkRk+FXtFUjqSSZWT1kGiPd8gKYaomLvyhIZXuK6npaNaRDg2gHVri1sONx7K2/vQ0kuZ/xPyQl7NjcOV5NVmLm0ZmPMEbocBTfx9q1SduJIf9ZL3TXu8oXXBB3Q79u7/L6c/xcfZX7PyS3bjcrATV/C3cl7KYvCMjl10zjzuchtD3lACbRzhdXTkNmNju07A3golQPZ8Q/9H6vE0GCyw4GiSkU6wBdkghSIrZVg2JwbRZwQQ8FqSSdQqoH1ijpL23BLcGS74Q60ZmjGiLAf8IZ5Q3aIB7SRKlTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199018)(36756003)(8936002)(5660300002)(86362001)(41300700001)(38350700002)(38100700002)(2906002)(478600001)(4326008)(966005)(6486002)(26005)(6506007)(2616005)(1076003)(52116002)(186003)(6512007)(6666004)(107886003)(316002)(83380400001)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gs/l9cArqrj2fQhBWRwdm/eVi3RcrvM+vIrj4VTAGo4s6CU7yZ4hxmfPhdj2?=
 =?us-ascii?Q?HrrEh0415s9ceb0gEZAn8VaZILGJxPdEklgyTzEVqhV9ab+KMEyr9xVD5ccq?=
 =?us-ascii?Q?QhewoJ/6+AFe0vITYL2ooBt/tflTn1Wzy8f0t74IS/oJXvZl9c4RbGF/xki0?=
 =?us-ascii?Q?+T1NYLb/Lsjp6qItigsO1q722cG0sABPonJQVji4BwPPvHLhOEjN1ALKmMjW?=
 =?us-ascii?Q?5z0+DYDQGKP/N+B29GCnKUOKM6o09o/fCDwcbQo8Ld+E/V3OTcJ55vNscVsL?=
 =?us-ascii?Q?KfEMj6tC8GN14/vKROlHXcfHygJ6XRoS8tEMgP5Dazk2DLByEtFeksTrAJL3?=
 =?us-ascii?Q?Gu1BQUsdjIE1GKpHE6LTixKJ8r7ZL0WxJPQzybE99zWSJXEY1U4e8gmbeyfn?=
 =?us-ascii?Q?fpn6kRMQ2sYh0Awowm1r2C12ZWQmfZis9usU6CwCR/78Fj/nDT8Sjll/7bM7?=
 =?us-ascii?Q?65ylS2rHTrVXQaf52GXKut7OJ/PZso/Xim+rzNjUs25QQfDaFyaVXDexssd1?=
 =?us-ascii?Q?tvd06RQvZaUNZSLboDYPydIcgV8qXagwMXCDQCj19fgx2tkuh5CouoCUSLBs?=
 =?us-ascii?Q?bA2IwOqIWBlRWK3ecGb2rJSOBb3D2eDkQP/zNE1fCQaDRT7+RLjDt39LWddn?=
 =?us-ascii?Q?m7YetWw4m2D3DgdJDZjVEJ9CNt/tgUqWt7n6L03SbGkF4rTtCI0+LCjfvr/S?=
 =?us-ascii?Q?jd0y/3/AIu4Wf5ZS7kbZQwgzJ1vMkTkkplxwHZ7ewar1IF+5ZJaGLHwNVzLd?=
 =?us-ascii?Q?KQL0zqK9yKj34ljOgdLJOnIx0riS/qeWDdCyH+A26OEH6KJNmoEIFNacn17g?=
 =?us-ascii?Q?rZ2ZJBJD3XtBwoSuQlMFnWug+I48FsQhQl/AyNR3+KMqasTtCqkzbMnnb7VF?=
 =?us-ascii?Q?WFdr1gCUnJTnhLnGH0pVBMRGJd408Z6v4SOJGUd0haWHvyQF1tUaapmJId8m?=
 =?us-ascii?Q?1CSEdJuUqYKaOxMofCjUX78ZrQeMGuxeJJWRuHkx7G7/0b8wok8jE7gu8u5m?=
 =?us-ascii?Q?YBZ0phvdOf+U9XatQLdbfd4g/jwJACQWWyLQSDnM6H5wLkuVgfw0mmK4rPNh?=
 =?us-ascii?Q?IETNn2NeSqphshpHtdKYH23NTW4zHY9qMM+bMap+8WHg7vQJk2Z8jCb39Cum?=
 =?us-ascii?Q?6WmBWLMvDJFrE+7dHCJO47D8N7XmBbeOg9+4Kj6e4CZLsQcJ/Q5d+nRfNoja?=
 =?us-ascii?Q?Nyu1TPiS2uoK9jCZLSUE/sq9x3UL7pZYAbvyKBthP/86eTqFh6Ecy0Qxob7l?=
 =?us-ascii?Q?3OHGHBOVi4wLF3hBrcg213MUh0UVb2v5ovd3uhyQx4TEZkbLMiZbyB9fN2uI?=
 =?us-ascii?Q?lhdJMaqmCj7qkxu7tGB/g/7tXSwOIMoWelYaHIQDDRTZlpiQ73O+REDm3c6W?=
 =?us-ascii?Q?SvAt50MXmDEm/dLiqnRWz7saY1nu+4p24AwJ6GJsnaJxWy13kWjmxgiBr1VJ?=
 =?us-ascii?Q?IotMJ1xERy+9g3K74TH6CgMgVSeaOGIRqLRYzQ0h2lrBqtX1QlMasR19V+Zl?=
 =?us-ascii?Q?q+NpNHgU+QiDumON5EKpptNmgtyVTRpZuvTYcV/GGdmgnNWh/L/UNr61vbkf?=
 =?us-ascii?Q?mkcogG7z22t8K8EYFqAIp3b+d6IrUYu/DOFhQpLv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bbf4b5-abf1-4d08-ddc4-08db04eb895b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:03:07.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AITxF5Y1/5RpD29jcnTvKfm0BXVawdAHm7jBHCg7R29/9tovMpr8cY2bXZiylzGxbwdcMvwCURFG9pGB7dLSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix:

WARNING: It's generally not useful to have the filename in the file
+ * fs/f2fs/super.c

WARNING: quoted string split across lines
+               f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
+                         "please run fsck v1.13.0 or higher to repair, chksum_offset: %u, "

WARNING: quoted string split across lines
+                         "please run fsck v1.13.0 or higher to repair, chksum_offset: %u, "
+                         "fixed with patch: \"f2fs-tools: relocate chksum_offset for large_nat_bitmap feature\"",

WARNING: quoted string split across lines
+                                "can't mount with superblock charset: %s-%u.%u.%u "
+                                "not supported by the kernel. flags: 0x%x.",

WARNING: quoted string split across lines
+               f2fs_info(sbi, "Using encoding defined by superblock: "
+                        "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,

WARNING: quoted string split across lines
+                                       f2fs_err(sbi, "Need to recover fsync data, but "
+                                               "write access unavailable, please try "

WARNING: quoted string split across lines
+                                               "write access unavailable, please try "
+                                               "mount w/ disable_roll_forward or norecovery");

WARNING: printk() should include KERN_<LEVEL> facility level
+               printk("F2FS not supported on PAGE_SIZE(%lu) != %d\n",

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fddff5deaed2..6f65beec78ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * fs/f2fs/super.c
- *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
+
+#define pr_fmt(fmt) "F2FS: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -3584,9 +3585,9 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 
 	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
 		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
-		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
-			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u, "
-			  "fixed with patch: \"f2fs-tools: relocate chksum_offset for large_nat_bitmap feature\"",
+		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap\n"
+			  "  please run fsck v1.13.0 or higher to repair, chksum_offset: %u\n"
+			  "  fixed with patch: \"f2fs-tools: relocate chksum_offset for large_nat_bitmap feature\"",
 			  le32_to_cpu(ckpt->checksum_offset));
 		return 1;
 	}
@@ -4048,20 +4049,15 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		encoding = utf8_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			f2fs_err(sbi,
-				 "can't mount with superblock charset: %s-%u.%u.%u "
-				 "not supported by the kernel. flags: 0x%x.",
-				 encoding_info->name,
-				 unicode_major(encoding_info->version),
+				 "can't mount with superblock charset: %s-%u.%u.%u not supported by the kernel. flags: 0x%x.",
+				 encoding_info->name, unicode_major(encoding_info->version),
 				 unicode_minor(encoding_info->version),
-				 unicode_rev(encoding_info->version),
-				 encoding_flags);
+				 unicode_rev(encoding_info->version), encoding_flags);
 			return PTR_ERR(encoding);
 		}
-		f2fs_info(sbi, "Using encoding defined by superblock: "
-			 "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
-			 unicode_major(encoding_info->version),
-			 unicode_minor(encoding_info->version),
-			 unicode_rev(encoding_info->version),
+		f2fs_info(sbi, "Using encoding defined by superblock: %s-%u.%u.%u with flags 0x%hx",
+			 encoding_info->name, unicode_major(encoding_info->version),
+			 unicode_minor(encoding_info->version), unicode_rev(encoding_info->version),
 			 encoding_flags);
 
 		sbi->sb->s_encoding = encoding;
@@ -4415,9 +4411,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 				err = f2fs_recover_fsync_data(sbi, true);
 				if (err > 0) {
 					err = -EROFS;
-					f2fs_err(sbi, "Need to recover fsync data, but "
-						"write access unavailable, please try "
-						"mount w/ disable_roll_forward or norecovery");
+					f2fs_err(sbi, "Need to recover fsync data, but write access unavailable\n"
+						"  please try mount w/ disable_roll_forward or norecovery");
 				}
 				if (err < 0)
 					goto free_meta;
@@ -4666,8 +4661,7 @@ static int __init init_f2fs_fs(void)
 	int err;
 
 	if (PAGE_SIZE != F2FS_BLKSIZE) {
-		printk("F2FS not supported on PAGE_SIZE(%lu) != %d\n",
-				PAGE_SIZE, F2FS_BLKSIZE);
+		pr_err("not supported on PAGE_SIZE(%lu) != %d\n", PAGE_SIZE, F2FS_BLKSIZE);
 		return -EINVAL;
 	}
 
@@ -4790,4 +4784,3 @@ MODULE_AUTHOR("Samsung Electronics's Praesto Team");
 MODULE_DESCRIPTION("Flash Friendly File System");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32");
-
-- 
2.25.1

