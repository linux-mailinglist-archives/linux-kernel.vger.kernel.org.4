Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14B667341
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALNf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjALNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:35:22 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2106.outbound.protection.outlook.com [40.107.117.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52E3FCBD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3Iq50GI18yGgwoz6GfM87dLA9qaV63zc/BGCFQtgEatK7OP/zUzNYKjxRzU9nCTyx13tx3LBEyDr8pzyDgAYZ543LZtFdIVFB87ZiK/NgnaAYd3DJGrZDcyO9ZInddJaEWVZi2wNNbR7J7+BIG8Zv492PDoe8YDZK7nyHjtDaIkaB/HHSD+KfoTuErVsSO0E1yZDpnzCtyb24euWORRiCk4o5EhAm2DUbV1mRB4vNG89QouDQKXySX4bhzahNimrbWXjx7iVIU1bk9OPhrd0SsGYjkNrXx5KY2/ijhNd8TQI9U1q4K+GATX1rZywY+539NrlacWXeIz6QD2/dKKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBoxDRRiNObZbWquwZAPXj1shSi9v5yIgx0Kejvjy5o=;
 b=KIArNDbQbtm7bV6dCMnVCK4wpgvsQl22Moij9BfSIIU2yaOTNVs01Vgp2gEIzwA/akBD3IcTjv9SUl1waepz7YygvgqLGuXDLPt164VhHIw8Y2qIxiekUwiCHkx8Cx1isXVChC9HtB+eYGGkvB5US2USiDjGNtvyRq+Pwj9MP8KyBcI2AbZ2IGvRYe/OJ/p+DH6yQRplEZJMW1XN6CISq91oewQTkB03XabClHOzbgm0Qx4WIGwG2cewM0jhAMFtEuflmTzmoCRg/+rrNbHzeOVhmbgkyd3kUURWycl0x+4X5KyCG7qcCqtGvgoMO6eP5pB+bcphSErJD+Q6xx3YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBoxDRRiNObZbWquwZAPXj1shSi9v5yIgx0Kejvjy5o=;
 b=QfNubbFm7B7WmH3LlF+SVHPIDJ4oocLQvy4Jfmm3KVPJcv4C6o97eLMA9Ouw+I8+POcOn9M98w1sD4V4pNqE7Jt5FGlQtZ4aLBuN92ErLk1p0HBL8ZV5cDnVd+6H9foZ/sP2lp94jLWEklAlPYFxTYZTLlSkh3V3ybbsrN3ssfmdz6puVs6SEGS2KRIll9aVgy7W3hwJijZro6WxuRnzDbnLQi7b6WgrrTNgSmi3F68v9JgUevAiwl8370uMflNSvPBZQkLF7PJxwOLZAoP3iVV0MVDrPz+pchOyT7qKK6yifQUJ8B1AeAkpz0fV6P8rGLxG8Im8S597N5bTskPIQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5072.apcprd06.prod.outlook.com (2603:1096:101:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 12 Jan
 2023 13:35:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 13:35:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/3] f2fs: add F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl
Date:   Thu, 12 Jan 2023 21:35:03 +0800
Message-Id: <20230112133503.16802-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d41b34-1742-4662-3eac-08daf4a1d5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k5miotvS21Xl5q9r4k+qbmfJpqefDDYs0CFnUk6W2rDJL0EZesZUxh4QIgmcoCfeZxZmkoPY6RZNb6wS8QRiLXnmzVAiKnRRD2F1garY4Zoa4Dp8qnhJqO8kZ6xiPqRp1G1X60KkfzvkMMPg2VTW/TekoBsjh0S8EgS/Ah6nct68gACs2Cw5JOQXPgpLlXu9Eugl/vMyOCrtMOY6NDTXPdaOd9/2mQhGpE+DtEpsvF3E/jYHtgz9fbUlx8VFVmZN4MezZuphPB37LKlgpfpEI9JHygq3gVSyQ9hW2az8QezEqCtdJUGQE7T16WxUNYrqZKID/P8t1aDcsZcqb9bDEW4pNwVRIKxpFct4MaZgCa9wZ7/u8DcgXIgG/s5Qawik+2rpIazKmSlQf5uwof3mp9LvTijU+NFByaFvcKkRQhw0McGpOYbFvZb3HMFJPgZby1bxvZIOKD+RU8MOMu2zfSmSivCIvzXhOt4da3qWQvDDmMGv/p7TX0ANWrclEIz9IJLIdVy5vdZpUjxH7bztR43j0CA6yiFMPNndAB9YdgEhYMFQ4hXX40tOrVJn8Y/Q30Y6HAJtK3KgDWUNMGyZN/FuglnTNV3ZzR1geuS0m70JPrHkJFZBfcOvfwJhzDtrpA5FA4P+2HN8PwCDuv10DCgpNuXUavjs4OqpFtXP724jw5WmtrH/xDb9871UdYxX3MM/yLkc0mk8KSeQIFqxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(107886003)(6666004)(478600001)(6506007)(6486002)(86362001)(2616005)(38100700002)(6512007)(186003)(52116002)(38350700002)(36756003)(83380400001)(26005)(1076003)(66946007)(8676002)(8936002)(66476007)(4326008)(66556008)(5660300002)(316002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1CCMffZIu7xzE7e+NmZk246+cez6X+JwPCbSPo8174KC0tguti6FX3YX/7W?=
 =?us-ascii?Q?kVFbDXweeodwDobrJIjyGty+zvepq3rywpIBfWRCg52OgyZgjQenrOQibOLQ?=
 =?us-ascii?Q?eHdSc5pWaxj7tkrQRhLo+VDpKCrOG5Zp3LcN+vySy92C2UG06AphO1BsChND?=
 =?us-ascii?Q?mSF9o2iqtUGNoSKegTMcBjK5Iw7Wxlmamf2DZoEfeqNm3tKDbyey1PZQL8hl?=
 =?us-ascii?Q?78fIypOQSibQX3e+ddtH58CNmg6CtybepjofPdShN+HAx1Mwc3z2azmJMvPG?=
 =?us-ascii?Q?kDmlxOHnS2zYDoakJ/Evs9SqdAx2CWtcUWHoLMMhBRjwJEaOfZLjY6aXX+Se?=
 =?us-ascii?Q?gOqekUU7+2sHdjRfC7YcDoQY5jPjNRmDYajM7Q+n7hXWqZUNbZiP+YSiIpqP?=
 =?us-ascii?Q?Kxbo246FI0LqVS/x1JvPf7SiN8P9NSLz5QFZ4SNE8mmNFuac0CAl0s5pkAkv?=
 =?us-ascii?Q?PJP58ey0rwFfX5ZVnbXVO9czPP9FxGOhuLpDlqYNdbXr4Omso6O2V4LBharE?=
 =?us-ascii?Q?Mhq+JuTVyFFWd2I2Cns9S+GS8oINAgsapDq91aKdzBG1K/RROksj7Gu9hEuk?=
 =?us-ascii?Q?TtRjfcBtLmT8mzxDMT/PSDcZeBvWEMoJ9Y5ZGdAvoiJC9appK5UboOVsHcoz?=
 =?us-ascii?Q?W7/90St1WgfS3pjTkwmGBTDARXFUEe+C7RXx0AslsSVUNu69AqIYFRkr1nl3?=
 =?us-ascii?Q?l99/3ZaS2gmL4EskBxRvg3HNllWGCxR0LhzgWiZxsdTwo+zPszUn6ZUjpCRx?=
 =?us-ascii?Q?S588nc6M3anGdDUpGrswR2GYkec6rHLVtcXeg1D1vBqoLDFLKrGQkDutNlrn?=
 =?us-ascii?Q?zhNCNDKNj3jaEDsdto/racLC06d6kzMnBVZ8xBoGFP0mmYmT2Hbly5/gOr5e?=
 =?us-ascii?Q?4PrCuE0QesQV8RSmC5sLmRYUgA6F/Drr5nqjEItUQV3sTMG0CJKn63lkYjve?=
 =?us-ascii?Q?jEwz7L6QPMn075XN4rD2wtZcgQ6wPQoTaWRW6JjjWZOA9m8ZZe9RDPrSeM6J?=
 =?us-ascii?Q?dyDcab+ys7v9Nx1oSZNSynmI3Jj1Gs+O8akqppcMvfRC20ePZDHwbrQF02YN?=
 =?us-ascii?Q?MdBniqVqG/lccOdDr83C3DGIFWjYnVsgvaIPnKMG9Wgii1W4lEMO72mdjw+8?=
 =?us-ascii?Q?FFbC3ntJaA1CQaVk1T2z2B/TraIw0DuRbIZPGYA2W4pnPTB5U+r1vmGoNPTw?=
 =?us-ascii?Q?yPPQFmQPlrY3kpnVv9CstErPTZo1pMEBmTGdVFIOtcB30fV+8KbZGBVzPuhz?=
 =?us-ascii?Q?CWeWsAHx0bAfgc9gvceprqrsCabuJ7ZQaL9Em9DXFmVDmd2YvJTcLSjHE2Z+?=
 =?us-ascii?Q?RYrG1ttzQOyycUC3WX5UxgWKxZcFhU1jX3c8Zt0bEXvnDGdlaVgviUuKhpzK?=
 =?us-ascii?Q?QA8ogw9rXiE6Ib4FMTlnTCdpItqisJyrdXUIelEVLdTFguwz1p73MrkBA9P0?=
 =?us-ascii?Q?vnEalmS9jCTnwBtUlBT7oJVNrvOV6zu2bFBh37jIDHNj+GCYgDywf+0NOOB7?=
 =?us-ascii?Q?VCyFfq1JYjY6BNG8anLSQCkf32ABytFPxJHyPFW80cciQRdi8oSl1V8BuT9B?=
 =?us-ascii?Q?w9TNgQ8Ns9fPVVZ+GurlpnEQCGc0W5mcveTWrZyj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d41b34-1742-4662-3eac-08daf4a1d5cd
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 13:35:14.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67czQ1ZJxQ0zSlTLiI9e8XT7ukO1dDL+OeJ9Bi8W41KCXnUvThnx676ggvMP7QG9ukEIk704o7/fH5pP2D6xUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a new F2FS_IOC_SET_COMPRESS_OPTION_V2 ioctl to change file
compression option of a file.

struct f2fs_comp_option_v2 {
	union {
		struct {
			__u8 algorithm;
			__u8 log_cluster_size;
			__u16 compress_flag;
		};
		struct f2fs_comp_option option;
	};
};

struct f2fs_comp_option_v2 option;

option.algorithm = 2;
option.log_cluster_size = 2;
option.compress_flag = (5 << COMPRESS_LEVEL_OFFSET) | BIT(COMPRESS_CHKSUM);

ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION_V2, &option);

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h            |  8 +-------
 fs/f2fs/file.c            | 41 ++++++++++++++++++++++++++++++++-------
 include/uapi/linux/f2fs.h | 21 ++++++++++++++++++++
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f3c5f7740c1a..c2267f44bcf8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -25,6 +25,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
+#include <uapi/linux/f2fs.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -1501,11 +1502,6 @@ enum compress_algorithm_type {
 	COMPRESS_MAX,
 };
 
-enum compress_flag {
-	COMPRESS_CHKSUM,
-	COMPRESS_MAX_FLAG,
-};
-
 #define	COMPRESS_WATERMARK			20
 #define	COMPRESS_PERCENT			20
 
@@ -1521,8 +1517,6 @@ struct compress_data {
 
 #define F2FS_COMPRESSED_PAGE_MAGIC	0xF5F2C000
 
-#define	COMPRESS_LEVEL_OFFSET	8
-
 /* compress context */
 struct compress_ctx {
 	struct inode *inode;		/* inode the context belong to */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f5c1b7814954..719706ef0d46 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -25,6 +25,8 @@
 #include <linux/fileattr.h>
 #include <linux/fadvise.h>
 #include <linux/iomap.h>
+#include <linux/zstd.h>
+#include <linux/lz4.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3910,12 +3912,13 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 	return 0;
 }
 
-static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
+static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg,
+										unsigned int cmd)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_comp_option option;
-	int ret = 0;
+	struct f2fs_comp_option_v2 option;
+	int ret = 0, len;
 
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
@@ -3923,8 +3926,12 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
-				sizeof(option)))
+	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2)
+		len = sizeof(struct f2fs_comp_option_v2);
+	else
+		len = sizeof(struct f2fs_comp_option);
+
+	if (copy_from_user(&option, (void __user *)arg, len))
 		return -EFAULT;
 
 	if (!f2fs_compressed_file(inode) ||
@@ -3933,6 +3940,21 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 			option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
+	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2) {
+		unsigned int level = GET_COMPRESS_LEVEL(option.compress_flag);
+
+		switch (option.algorithm) {
+		case COMPRESS_LZ4:
+			if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL)
+				return -EINVAL;
+			break;
+		case COMPRESS_ZSTD:
+			if (!level || level > zstd_max_clevel())
+				return -EINVAL;
+			break;
+		}
+	}
+
 	file_start_write(filp);
 	inode_lock(inode);
 
@@ -3948,7 +3970,10 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 
 	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
 	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
-	F2FS_I(inode)->i_cluster_size = 1 << option.log_cluster_size;
+	F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
+
+	if (cmd == F2FS_IOC_SET_COMPRESS_OPTION_V2)
+		F2FS_I(inode)->i_compress_flag = option.compress_flag & COMPRESS_OPTION_MASK;
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!f2fs_is_compress_backend_ready(inode))
@@ -4221,7 +4246,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 		return f2fs_ioc_get_compress_option(filp, arg);
 	case F2FS_IOC_SET_COMPRESS_OPTION:
-		return f2fs_ioc_set_compress_option(filp, arg);
+		return f2fs_ioc_set_compress_option(filp, arg, F2FS_IOC_SET_COMPRESS_OPTION);
+	case F2FS_IOC_SET_COMPRESS_OPTION_V2:
+		return f2fs_ioc_set_compress_option(filp, arg, F2FS_IOC_SET_COMPRESS_OPTION_V2);
 	case F2FS_IOC_DECOMPRESS_FILE:
 		return f2fs_ioc_decompress_file(filp, arg);
 	case F2FS_IOC_COMPRESS_FILE:
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 955d440be104..aaf7f55273fb 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -43,6 +43,8 @@
 #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
+#define F2FS_IOC_SET_COMPRESS_OPTION_V2	_IOW(F2FS_IOCTL_MAGIC, 26,	\
+						struct f2fs_comp_option_v2)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -62,6 +64,15 @@
 #define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
 #define F2FS_TRIM_FILE_MASK		0x3
 
+/*
+ * Flags used by F2FS_IOC_SET_COMPRESS_OPTION_V2
+ */
+#define COMPRESS_CHKSUM				0x0 /* enable chksum for compress file */
+#define COMPRESS_LEVEL_OFFSET	8
+#define COMPRESS_LEVEL_MASK		GENMASK(15, COMPRESS_LEVEL_OFFSET)
+#define COMPRESS_OPTION_MASK	(COMPRESS_LEVEL_MASK | BIT(COMPRESS_CHKSUM))
+#define GET_COMPRESS_LEVEL(x)	(((x) & COMPRESS_LEVEL_MASK) >> COMPRESS_LEVEL_OFFSET)
+
 struct f2fs_gc_range {
 	__u32 sync;
 	__u64 start;
@@ -96,4 +107,14 @@ struct f2fs_comp_option {
 	__u8 log_cluster_size;
 };
 
+struct f2fs_comp_option_v2 {
+	union {
+		struct {
+			__u8 algorithm;
+			__u8 log_cluster_size;
+			__u16 compress_flag;
+		};
+		struct f2fs_comp_option option;
+	};
+};
 #endif /* _UAPI_LINUX_F2FS_H */
-- 
2.25.1

