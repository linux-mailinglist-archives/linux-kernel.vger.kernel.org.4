Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47A62A171
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiKOSkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKOSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:40:45 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6318B3A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:40:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG3Wwu4WPpVAIyO8P3R1vpwWcuMpcwOd1/WWG0BAbNII1rxCWbLW+2vOYdBlhnJc06iAji2Cbe5J65MuQXGbGPKenLyr3mxBsqDvyX5VT0/M5DecMI7R1gt/TOBC5rtQ+rzPyiMZXgO166N2Zm8R1a78C4mkK4nvWi1YI+8zBeUDuNJq5D4Q27QGWal/2V27ihEavZZnMmRZyGm3DwSxsb4q+qngDUUw1BJ60a4qNmjOs2WpUK1IlEyPCaG9QE75T9gMf36pN/nBQjF56vU7kztwMWq4htnQs7dUIfNq/hX6GJAdcyzpJrG/Ky9fe5tNkkTFTeopgZVrJKps1/w+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p1ECSfqgg32TZKqNKLOMQARE8n+fWv4MEOnlyk+ICc=;
 b=V3r3g4j5gVyDtAi1OQasr7z4QvI+aGjZPrUbjAyAh963ruob+Z4QW/yW5CxdwamTtXW6eY0PLZdO3e1Scq7rK2B4nSvqtGx/aVEZqZ4SMxSKZpKbMq6SWrSeTrPNVZXB7pQvIDzO0S/EorpLuhUKBTdYld8W1t3eUgWRNkB6sCJI4J7EimAoATztATDB1ea0n+M17SGewmhH8YVYI2gjNlG0rIA6glCAv4bdB8UkkRYZZcfjURnCs2JA8lkZuC8NhMyf5UVSmz9GJlRxWNT4Jl1b8vyx2N7KnlR2szfsbCx3Qzol5lwrRqGzx/9QhYUhhSg0s0gtzby4OWKtKNfbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p1ECSfqgg32TZKqNKLOMQARE8n+fWv4MEOnlyk+ICc=;
 b=N3PZzs3eXPrTdXWJtwgkadcX91A8oBkFipqvnFV5C1DbV45+acxcu3HRXIUpFjLG0vAmSByLD9U1HM9kM5XIlashAaloPzaFjdkyFKr3i3zWmKcDs8Gx1gYpM3dxahhVWDMmWp17EP2zCLZLOHN9MvEOaDgkzoNB/ejN3a19wzFMwi3sxM3G9QaC48T1PRNuOj1ruu8SKwmbjwcN/bcXs4SzHEqyHlqYuB2sBCbOxw7oYBSP4FEewmKMmjPl2xBhmGfjzKu9Fi8kPnliyVAcugO3ZarOiJW0qvo+qneomLonclIfIRxz3f+sLzkiluBsho7rNacz+FdBmrzfjlQGQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5609.apcprd06.prod.outlook.com (2603:1096:400:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 18:40:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%8]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 18:40:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix to set DISCARD opt
Date:   Wed, 16 Nov 2022 02:40:23 +0800
Message-Id: <20221115184023.78070-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d39baac-06ac-4fef-ef5b-08dac738e44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpbZMCyklnl3yE6t+pvWEfptxtWssNhm+LKXr5fuurk7u3jjnPqJAKWDT5j4RWzmAJHoCF6mG+lxfts8YQYQDdh6maFxNTjeCvQ/u0o/smKn4ZUmO6Dn8NUEp5S1RPOCJzPn1msfsSAAK8LSxf0wcHUxqSLZzRp7oJIrAGpS/EDbFVCc9psf3eaS/9F/OYBD3J1AGjrtmqZISBJhgSqZtLJeF2x2FJZQ/Lag0wDCIXKJJWNl4pbn0AuL6tBMy4yVrpRB411YYmQtuk3259gffEqRX8LITJU+eLs3mh2HtX2OVlJ3GQFwZ9q6NDzOtC8pPJ4TmM6QHN/2RGs84T8zG+Wq06V4YtbUKPZoPJ54fSkvz9IUmW214Re+VzCkcfhzIUmpgcbg7CcoMHVrDklM/nzRyIDZXCq9aAIBUjFOALxcZOLfVeq0e0UdXyr7ynl0YkFb1wLRaaAmiLmOg45iEPoyIwvgk2cciSZVeNvRqn+4z3HURweWcPfV2cW7LE4uvo0K3xAAMdVDO5gqL9/9gpJuMui+1Up5Yx4222j9MYFDxdAB8VVyMsyuzJ312zkPjtJ5Hr8aGzRfU8zJ88iDA6+1V5C/az9JZ4aaCDtlwZLcp8wfAX36fe+nOg1L4oW1VVu8ca1iu+hHld1/FZsuUyU8ipYCR7gnUriIW9UW5tgHfio9c+sodKV5Xf3ATLW3N2edDZPEXU874iazXlavCIJe64ycBJIaCqLUHBFJ9Zj6KZLE7+3XKOS/IYEUmkJRrmUAHyWX4bIyYWRSw4uGCY+ppqP0cYIq0hvTPPEskpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(83380400001)(36756003)(52116002)(86362001)(41300700001)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(5660300002)(316002)(38350700002)(38100700002)(6506007)(26005)(2616005)(2906002)(186003)(6512007)(1076003)(478600001)(107886003)(6666004)(6486002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yehy+7sxc8g2NipAgJBft5V4ozr8W/SIZQAqaiY6dKAvvpdxHwo2e5jPtwPd?=
 =?us-ascii?Q?46giGEuVjwqQur1zyv1SEmubtrXcqzGxcbH6vESrtLZodUkDYKcAbbF4L29s?=
 =?us-ascii?Q?gqRpYHfHguImyEPt4N3Zpkkj0WTGZGzT1XI4O35X76DAEH6qPfBjdM2S8Dif?=
 =?us-ascii?Q?NxHIU09VNphfv5ye1zQVyHbK5mgDrqOUgueHhpSURE2sRXD1yRPpe98jZ9uz?=
 =?us-ascii?Q?9Z4tBsrWe7J6qBKJ1V4L1gt5t3zBjEhlDP5xay8Ub4xf976RTN61oqG1bZr0?=
 =?us-ascii?Q?nM4mrWrh2KbLkrhqYD0QYJVaKojmzwnBIoYk6r9V09RyI7+2YnVwyQVbF0kv?=
 =?us-ascii?Q?j8zSxu9q8H8W2p9THVWdrowRYYHIMsUOCewv74uEFIOg+tEOoXmIdTdZOnDe?=
 =?us-ascii?Q?cKS3ND3Z/1jsfa1fHijDP5JbWVLjKUgOdhPHvTWRd3MdfSrQxAq36kxOj2cv?=
 =?us-ascii?Q?DO7SxwATeHNYVXLFLaXGZnnZ1R5Az/QI5fYjKhNHMQmhIcyrv2YPkdkEKTaY?=
 =?us-ascii?Q?j/z8V7jNhitLtaDU6eG2ychy2S5BDD+Ve42/te6tEhSrQ3nTFGrc8Sh8yNC8?=
 =?us-ascii?Q?qfJVKOePL70facfKw+h27FYsqk2GlBlnsMh8wQG7e27uKj/X0ugNBVwB90Sz?=
 =?us-ascii?Q?PpN9Q6qMzmyxedcmSmM9XUrsUFnj/rH05H4P9pB5rQHYB5XMIVImwWIz2pwY?=
 =?us-ascii?Q?S0QumDVA44ri4+PW2j5L2vtXEWPMvsBvrjjaFiJxytVDiiIimYEYrlluDeqM?=
 =?us-ascii?Q?hptmF4Lt4T5k3reFIiZ2L/J/hUanNlkL/ane1Rr3Z2nxLUN39Pl4ySWgVMHS?=
 =?us-ascii?Q?BNhsXVGrS+s0W6E8RpKm80Sam39Xkf1gFxRtlwJkpgMUwHTGjgy9gyU6AQ8k?=
 =?us-ascii?Q?4p/RWER/agyB27niKi7rnkUgedeSmS2ho4dP0NSZhXUQtp7/X61m+sBZJQGV?=
 =?us-ascii?Q?khePL22UIAihy04i4mrwDlPe9oRvesghJuZj98AfUSHS2L9mMcJhfnOPXtDK?=
 =?us-ascii?Q?BGGHw/U/evGgXKh1YCzMnM7ezBcOFU8ADwGRnJDY0dFh3nh/Oso2OTbfk6Z1?=
 =?us-ascii?Q?Bpbja0lDwaUFnG7o8rXR+9VrlmXFwA9A4apLeZaD+CVK7iZBAf2ea94rMpcH?=
 =?us-ascii?Q?gbijCuU9q+Dkfhk6vfH66VY+h3Y/KqaH7LErTqWUI/8XaB+TpAeuMnUBQEe6?=
 =?us-ascii?Q?cJ1MkSgvvj8dtU0sx/AZKdysv8vmN8Q3mLS/2BHaho3SFywdRadruDVTxEBt?=
 =?us-ascii?Q?UFqhcNj9Cs4UixFBvHwWPJG051A2EWpP81XG4+zQCk755HDmfOSKqIXTv36f?=
 =?us-ascii?Q?tbt2siSIjt6DRC7IMF62v1kRw2AUbRWnSFqzeghr4+froaK5Sir1lu5zyNTr?=
 =?us-ascii?Q?XX0QGqrnATRScvLiSFbe3GU/HdpKV2AhYbzoOmosyhb7aNPf25PW0p6Cmp4O?=
 =?us-ascii?Q?B5O3b+5JnMBVuVZwkscGsCtgo0s4d3IZ+TuGI8PTR+Atu98ms1vbBXhzWBA2?=
 =?us-ascii?Q?nNdVcp8txch66RpcY2kIlbTP3V/RFoKsHfTZyvptNUtJi1E12QhZnmEzNphQ?=
 =?us-ascii?Q?2p3/OYzSGLXubq6o6AYOltdrP0EXKyxAO15C67pP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d39baac-06ac-4fef-ef5b-08dac738e44f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:40:39.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5dMB9T92Sn+ShlRGcQR3t+x0v3bt57ws8nSDGW6ZrLiCGXTIn4efhEZmCzJgKzDF1ERQUkRpxRZjxou9es2Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor modifications to discard opt and related parameters:

  1.introduce f2fs_is_readonly() and use it to simplify code
  2.The FLUSH_MERGE opt is set by default only in non-ro mode.
  3.When ro and DISCARD are set at the same time, an error is reported.
  4.Display discard_unit mount opt when has discard opt.
  5.clear DISCARD when remount as ro.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  |  5 +++++
 fs/f2fs/super.c | 53 +++++++++++++++++++++++++++----------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b89b5d755ce0..be23059344b4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4579,4 +4579,9 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
+static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return !!f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
+}
+
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 75027ff85cd9..baa8f0860192 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1353,12 +1353,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
-		test_opt(sbi, FLUSH_MERGE)) {
+	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
 		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
 
+	if (f2fs_is_readonly(sbi) && test_opt(sbi, DISCARD)) {
+		f2fs_err(sbi, "DISCARD not compatible with readonly mode");
+		return -EINVAL;
+	}
+
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -2035,12 +2039,14 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, ATGC))
 		seq_puts(seq, ",atgc");
 
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
-		seq_printf(seq, ",discard_unit=%s", "block");
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
-		seq_printf(seq, ",discard_unit=%s", "segment");
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		seq_printf(seq, ",discard_unit=%s", "section");
+	if (test_opt(sbi, DISCARD)) {
+		if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
+			seq_printf(seq, ",discard_unit=%s", "block");
+		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+			seq_printf(seq, ",discard_unit=%s", "segment");
+		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
+			seq_printf(seq, ",discard_unit=%s", "section");
+	}
 
 	if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_NORMAL)
 		seq_printf(seq, ",memory=%s", "normal");
@@ -2081,9 +2087,10 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+	if (!f2fs_is_readonly(sbi))
 		set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
+	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
+		!f2fs_is_readonly(sbi))
 		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
@@ -2221,7 +2228,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
 	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool no_atgc = !test_opt(sbi, ATGC);
-	bool no_discard = !test_opt(sbi, DISCARD);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
 	bool block_unit_discard = f2fs_block_unit_discard(sbi);
 	struct discard_cmd_control *dcc;
@@ -2398,19 +2404,18 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_flush = true;
 	}
 
-	if (no_discard == !!test_opt(sbi, DISCARD)) {
-		if (test_opt(sbi, DISCARD)) {
-			err = f2fs_start_discard_thread(sbi);
-			if (err)
-				goto restore_flush;
-			need_stop_discard = true;
-		} else {
-			dcc = SM_I(sbi)->dcc_info;
-			f2fs_stop_discard_thread(sbi);
-			if (atomic_read(&dcc->discard_cmd_cnt))
-				f2fs_issue_discard_timeout(sbi);
-			need_restart_discard = true;
-		}
+	if ((*flags & SB_RDONLY) || !test_opt(sbi, DISCARD)) {
+		clear_opt(sbi, DISCARD);
+		dcc = SM_I(sbi)->dcc_info;
+		f2fs_stop_discard_thread(sbi);
+		if (atomic_read(&dcc->discard_cmd_cnt))
+			f2fs_issue_discard_timeout(sbi);
+		need_restart_discard = true;
+	} else {
+		err = f2fs_start_discard_thread(sbi);
+		if (err)
+			goto restore_flush;
+		need_stop_discard = true;
 	}
 
 	if (enable_checkpoint == !!test_opt(sbi, DISABLE_CHECKPOINT)) {
-- 
2.25.1

