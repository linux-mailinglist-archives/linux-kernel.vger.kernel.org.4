Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE937623A60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiKJDZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiKJDZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:25:41 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF91AF1F;
        Wed,  9 Nov 2022 19:25:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6em3TZTMsTnvAHbVhhitk/CfDW51HIV+8cVRcpkI81fJpGFQZ1eZ5SOPL/YPiM4tUS8BEGTHQq113REMRMpRlAyU6KqZ5ek7eq74hqFjZPVmouBz/ObQr+fccvN/knxqwl1KehIQwWgw5Zlb5plT8l+rzWFgdlxGrwOZlJ4MMA8ZFRtSRQMF3WaYqpgMKuRL7unGL5b+80sOB62J4UAPf93KngY4rjE1wSgqLNQR6jTyCGwicaAYNgBFBU01rgp93mMP8RhvATO7DDzKduI54Z4cQijExlJKNnLfNJ4kXHnsayiN6HNinQjxnEnsEM5pfVbbE7zGE0AdWlMci7Jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wPyyHBJQGsaAkG1kjYbUM145q+ru7B+Q0qI7wS5KbM=;
 b=LT1SER/Qg0ZHsX2TjA+v5f1GC4G3ugvP6RCMsgnG6YqvpRHM07mQXG0idr0gSLLhvmVnrIRqBD9kOgMDKYpF9FuMKOWDEogf3caBlT7oavVa760drQwls5OX29lT+hTBeIF9jZ1rBkETt3GVCNm9hUNKfbbEqpjakfF/4jR8m8Pe1LG69kbu4ihvn8GsLlCFwrM9M0BIUQKkmHjLWw3ViCZWpDzCvcSixT1AdeRHwfJAFrt3uNb4r59/l5jMNJAgOFUgHwr+dLaqBh9h82mGUU/Q8Qir4X/l4drtoOSQlGgePtfXohSxL+Bxjkgq2NlObf/sTQkfCUUTTuwtF6Y06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wPyyHBJQGsaAkG1kjYbUM145q+ru7B+Q0qI7wS5KbM=;
 b=M+v73/nYwwQNgNJC2bQxHdPl2Z3YdYT689UbTnqDKLIQUvfKilZmTR8GC+uol/q1PFr5VgdBekKypWflpvVQttQ0QBlxFyrz4J1z68anwqXReoWF6sr2SeQXHsuIk1s5Tx+YDmNdMUcoliPeXAvQnRmbgaV1rMNwZEcsIwykZ2atv01Nwa07M0GSYmoIP7+2pdmsUk/fxCCt9o14H5djRjuCJu+MvtwLpkE9qqUSHAMX9jlFSA86q5s5PQSulxUhLpexUJIpg/ZWVg3q9uYqEz6j+P608Kdle7ChGef4yfxgGOs1nTdvlDwAFIQfW5mQppq6tR+5sphMQkyqkVlhfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4588.apcprd06.prod.outlook.com (2603:1096:820:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 03:25:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%8]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 03:25:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, corbet@lwn.net
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: support fault injection for flush submission error
Date:   Thu, 10 Nov 2022 11:25:22 +0800
Message-Id: <20221110032522.64043-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 529480b5-a492-4878-b677-08dac2cb3a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCiMGdwXwreI+WQHNxOwOZ1KrOuY3iwIKKuJYo31tAlrgHHu7wYacJxTwQfieMZt6Vb2IYfKrQ5AVSPvzide4r15MJAa2n/SJrwmLpfPLOBK+BG7eUKHbyrv6TGA3AlgjjCtgI3EAzZzIaYVFJPpq2eggvOh3qaCcuXUaDE0iCMD/tTz2P6gsJNg10fp9SQCzrhdFUJvwuSDcgQanpy2LPjPhbo2Ybr1HUQsCFITHlDN9/C79yOMHaSKfonTlGuP/+iG0sPeZ987gKRiOz/qODe7zlrTKUZPmSoKO7B51hATho4/BVyHagLKObt6CY/O91TbCwVpyjAl1h2gdEfYknCTx2QugKkgLN/rybxqJPmfweTH/LAqelgBxx+nA7mCM3RRDyJjT4IVQ5e+zV31Zx6MlSZQ2BLznPEIJUoqWFGAD+ejXLnBG+nvbUym1U7rjGlO76xNUKvEm2URh4OrXeHe+U/KAtO5QelewtpvlEWvOnlZDdAPHWWk3mU3FvmSx1AcP4uMxALnIyPw9769u8sOygrAM4Rj5RQLMbB08khCT0c2anNWf+6ohATeSMECseM+UlCvyfHtBJ3Kp4xeBkA0GAs/EbFLv4Es51wn1WmrPb0caSY6lc07xeYJoxwheY7Q2uFPjtgv4y4XpmlCnjvby5L7uvMLgZ3AwgcgZ9e3PsxGJsCBiQY1Jmnvxg77S/6/w4e14Wk/THXAUVTRBzlr3XfYWbfSa2uCCqjxyYKgKO4EAh9Vge2Nsh/TgmL5FzjtwXMScmR0f/fcOhlpcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(478600001)(38350700002)(186003)(6666004)(1076003)(107886003)(6506007)(38100700002)(2906002)(5660300002)(2616005)(8936002)(83380400001)(6486002)(52116002)(41300700001)(316002)(66556008)(86362001)(66946007)(66476007)(6512007)(36756003)(8676002)(26005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lYxO9JImWUds3TtxWFzYI2DqoeOiD4aDJyIFChmuvmdyDzB9+6CbuVgrJEv?=
 =?us-ascii?Q?Qaai40l0sD1YCKdggxTW2H6cPOg4ocQmfK9hdgwMCc+60wG19yXSzgJCaNXH?=
 =?us-ascii?Q?cjV0mlpytDEQ8tcfhDB8iuu+AAPxesMIuQArTXBL9gTJSVGdKUDc8jgdRRbA?=
 =?us-ascii?Q?WEoa297XQeMePfLkUoFrJybFL+h0nAksuCTJfpuVMV95jHqCidKJHaRm9K48?=
 =?us-ascii?Q?6l7kGGfS4ozSQGY6m+J0RKlw1OSWxY9Bx93OsnskI3X9HBfhgIC0gSfA8WFi?=
 =?us-ascii?Q?31PScIzukrfyz2B8z8jeafjrSG3ia7mesMeWsqPlC3Ia0PUTGZkeCbh2t+/2?=
 =?us-ascii?Q?J5IoZ9bWs5p1SJz0gLUxaZhYeP0R2AgYBZHbHG6R0Oqv/ZmG5KwWUER9fRu4?=
 =?us-ascii?Q?MHO9+e1N5+/FjS4R9WYtX425jM/F5q3pgJNVr+YwDyzNlwnVj5/SaBlAooAU?=
 =?us-ascii?Q?T+hYIoqWftjxJMUJtoinBuWs3WdCupvYgMd4qxtanDlniGZD/m1FspV8flAr?=
 =?us-ascii?Q?shpOQDerS+41aa6b33feIiDwmDCXHZsmZyhtB4p+k+AzhpJlI2nAmxZGuOPU?=
 =?us-ascii?Q?6MhVjIp9TYWLiJ/+yQZqjOTN/mzKKnxYObImRidLNmyg6oSIINIU+bNSbxuR?=
 =?us-ascii?Q?STPsO14YSyzK138hW/fGaZz07jqd1PeTS8LMCJWEzNNWdjNEVEN0Z3vAKYik?=
 =?us-ascii?Q?mK3lxd9Uxr1x5UZBR36ZdlikpcUvoCJwIDNFAfHHwa7czxEd4OXp8Q7HR6nb?=
 =?us-ascii?Q?2nxYA0YP0e3L7kQRxFYEOzNsE5igCkQR5zwAIqncHYHiZcEsmY1SLwwyQN3t?=
 =?us-ascii?Q?TtIkM0uSDLa4GtzENYkTNLCzPAeuSme1Vzirak8vqsfylq89ib8mRcZ56e6E?=
 =?us-ascii?Q?UcMmWcI/cGFYQZtUwyg9hjL0lI5k0ec9LzqEJ0YLlXxbKo3wV3+koVc5i7Ls?=
 =?us-ascii?Q?kUAV6L+QrFkR6VpJgSFotIUtcYc+jWuAl+/0RXiGLIMXTC5UUCo/zlOu8ejW?=
 =?us-ascii?Q?E4dAuBAQVN2MdHKK7HW9eeOhoXCLgmFwnLlaXb4987hJD3K87IhFzSgtAglv?=
 =?us-ascii?Q?Bqi+0iFeG7CQjDaUnwlW1rURCTyJQKfWelYnAMm77RxXWi6j/pzTsKRkpOtl?=
 =?us-ascii?Q?p3Alug1B8kSWzUS0ZR8OuMPvtTkgqR4JXPIptnRIa6v0xIjVOE/a7QCI7KpV?=
 =?us-ascii?Q?3gu1i4lNRlfJO3XbYjej8ggYLaWthl/ZFTBGe0zMyjResHgbGUQPkczIp666?=
 =?us-ascii?Q?ndny/G7r+J5N/eDLhDsP6LbBFk1TB3kO4QJZAjfOJ42278YtIlv0TNGXpeRQ?=
 =?us-ascii?Q?uxWDDIBgsKWgfLgv1MovmG9siDpplgUeLHiGGq+VIrqfxZO/x5GH+2D+ELZ9?=
 =?us-ascii?Q?H7CykWzCrCDu6edDb7XnqFv7XyZn3nbCYGYwmCdHaDVdVT84JFbEeupa0KhS?=
 =?us-ascii?Q?AI4/xjqpbq9rY/LbAU16xzzbqZGKmzths7EfwRokjM5PZ6kRTq/V3pzF1NUw?=
 =?us-ascii?Q?o7akQyJ4kkjHGqreuq6abB3RxnNapllqcRKiHHcx0nF8Pw8mqCQiEpgcfxnt?=
 =?us-ascii?Q?yBXupPqRpMg4T4nXm4gaqQLWdoEpO9uRw/2FglzI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529480b5-a492-4878-b677-08dac2cb3a27
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 03:25:33.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHXSvxqmeNW9cq/qzaRR26W6FIG2+JQeyxhltzXPMIOB7hhGiZJmwZLQOCG8zP6B12sEDxG3Hoj55rSMIem/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now support read, write, and discard in FAULT_INJECT,
let's add support for flush.

This patch supports to inject fault into __submit_flush_wait() to
simulate flush cmd io error.

Usage:
a) echo 524288 > /sys/fs/f2fs/<dev>/inject_type or
b) mount -o fault_type=524288 <dev> <mountpoint>

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/filesystems/f2fs.rst |  1 +
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/segment.c                  | 12 +++++++++---
 fs/f2fs/super.c                    |  1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 6e67c5e6c7c3..316d153cc5fb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -202,6 +202,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_DQUOT_INIT	  0x000010000
 			 FAULT_LOCK_OP		  0x000020000
 			 FAULT_BLKADDR		  0x000040000
+			 FAULT_FLUSH		  0x000080000
 			 ===================	  ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 04ef4cce3d7f..832baf08ecac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -61,6 +61,7 @@ enum {
 	FAULT_DQUOT_INIT,
 	FAULT_LOCK_OP,
 	FAULT_BLKADDR,
+	FAULT_FLUSH,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aa4be7f25963..a4813fa33c0f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -486,7 +486,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
-	int ret = blkdev_issue_flush(bdev);
+	int ret;
+
+	if (time_to_inject(sbi, FAULT_FLUSH)) {
+		f2fs_show_injection_info(sbi, FAULT_FLUSH);
+		ret = -EIO;
+	} else
+		ret = blkdev_issue_flush(bdev);
 
 	trace_f2fs_issue_flush(bdev, test_opt(sbi, NOBARRIER),
 				test_opt(sbi, FLUSH_MERGE), ret);
@@ -1126,13 +1132,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			f2fs_show_injection_info(sbi, FAULT_DISCARD);
 			err = -EIO;
-			goto submit;
+			goto skip;
 		}
 		err = __blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, &bio);
-submit:
+skip:
 		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
 			if (dc->state == D_PARTIAL)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a43d8a46a6e5..3d3d22ac527b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -62,6 +62,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_DQUOT_INIT]	= "dquot initialize",
 	[FAULT_LOCK_OP]		= "lock_op",
 	[FAULT_BLKADDR]		= "invalid blkaddr",
+	[FAULT_FLUSH]		= "flush error",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
-- 
2.25.1

