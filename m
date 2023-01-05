Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAD65E4A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjAEEW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAEEWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:22:55 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2C72633
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:22:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWThv1V8QfC6tPLDqeYh/xlTCgG0B6U7zLoilxm27ZnLTWAW9l2XOE4yK3yXz23+AKZqvuSql21yYhs4YNWlKZW2ZCZop4+bIcsuhHytBBImVccc2GV9owrWg3tpGnTw4gdqw3oxhEcdDi5sDdVOp9rBUQE45zoJNWpwAwrExDJGyV2TazlZ1/tJMH5DUqb9y7k3amhAQxXy0dMwtL5t57LrC4FxkTzhOAMKIXE1srwS4BrNigOxVaBklO8AYoF5+Ef3kd6CgHarKGoVo6w169UtKu1OEczKiSpDq0F35h/afAtmksx/EP3avFu9zl9PalfKrBH8hBZ8BlLMdwcqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui1eEIXTQI+cFsCrQ6psUM+KLZSb5HugIt1x+5g/wrs=;
 b=BE0S8a89tG4G2vCoMPRPtEXHk4SrWUyBamz6003QbIDQb8iRmfniYJvdvuXhExlVk+awsGH/1E43t/sv4DEvIVkTmn7HknG211iIii1zyDwzuFApJs9x2ZEIPGc2C1M2hHMFF0El3Gwsd7oqMWB8XNIUkmx2oW94nR1licgNa8Fd/UOjqv9IvFfmwrqZZYsDCXLDvaDcWQLOaMpGrH3/qaXlQkOTlCuH7D1eqKRM9erMU7KyZuhrDDzUkgnuziW9+SdyrvokvY4mS64gLnjpB0OVGHF0M6D362EHuNzbmT3cdDKXDwRE9SPjV2JmBQhjVMZns540TiH9x/e5jLEoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui1eEIXTQI+cFsCrQ6psUM+KLZSb5HugIt1x+5g/wrs=;
 b=J2Ml/ExAwHZFRr4lPZvdR0eYLv5tutdL9NTVq3xQVElz/GQ8TzqXCwxBgAeGj48QN5iu4mSBEwGESA5BbUxYWZtpX3TpcZUrz9L1A7h8BiH5f0xZwd4NXtk6RrgUlO0ef2XBnD5rj4Vj+P59dAq6tnk7KA2sbpLLgCmWZWgwQLHC9vTtOdDbTQ4xXisOE+wtsFkVcdMewlLpbg69osXu2HEsmaEE36oeVSkjI5eTRtkjddri7Aq8/tt4/iu05byCij8XZ4u0ESjsL7SLfQ112rVy3xcl1D7FRh39XUK3XmfqnVt2l65qX16+GVOMXX6GKHcimJsfmCU6atvykcbY/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5567.apcprd06.prod.outlook.com (2603:1096:820:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 04:22:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::7969:5a45:8509:7d80%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 04:22:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: use iostat_lat_type directly as a parameter in the iostat_update_and_unbind_ctx()
Date:   Thu,  5 Jan 2023 12:22:40 +0800
Message-Id: <20230105042240.24738-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: ff931ec9-9de5-4fe1-b3fb-08daeed48114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWy/xAI5bBoVLteW00wzAYhl9wXNNvE/NFaHsbVAqxLyuySKOc3xJzLVg5hagQU7IBpyGCaH4tJByyMXQBh2+QAnV55oNTdaFpulwD7ez32y4DENSm0RhU0oXCAstLYS8+MHLHYozzbExSO0Hv4CmhEvUyp4glptV2t6phRVMeNyMy47UjXdsUioGcl2LouUq8Z4EZsjSKUQuE5geKJUyHqnCSkqR5DtoufpoDtqBL0+NtBGbiKaD09/UEGh+H1hBpxIFEZxGNJk4kXbfWa3czdLIVm9AwGly7S4EevK+qXKzjLTu9hbY34w9NlKDG5j7HqGmQ0AD1VsqmxIwvG6Rd8M6epTAqEGZNIAUc66AiHN720CYuoDmMQKnvN7/k+UQfYSD4zf81q8bwLrSuCFk38Q0Ts6WyhO+8vOYwP/72YbXGvux6nIszCiGg2L3SftVForR2wHPFH2hKjZcWyyGnsQtPCxi7gTqr7U8VMy0PoB4l0ZOaX5q7znlTQ7lT1kjrLwKXXBnez3qyNsdxK37PlBx9NWpEcoch5UjklaB1aEROLCordz/W4y64pGqueN49AKXrQcufX/yEi/jpAaJomP9irrKeYnU9mG0+TAmwRH5FzEyebHzYy0hySCOiq+jVOF8gNWzJAjGTfhBw2wID2qoK8KXQYEKPTM9qS0ooI1/+eRyNtJJx9V+SIjmGz8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(52116002)(6666004)(107886003)(26005)(6512007)(186003)(6486002)(8936002)(83380400001)(478600001)(6506007)(1076003)(66556008)(316002)(66946007)(36756003)(8676002)(4326008)(2616005)(66476007)(41300700001)(38350700002)(38100700002)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9t72ct9ScK2QQ9uI8Vxk45z+798mt7b5mVb9A6ezf8PvqCuBGwZnxtfHLlM/?=
 =?us-ascii?Q?B2u4FQvT0zRptMXalcJBq489OpeS52jcXZKLPBIWt0uKamW2YHL9w1yvjhDo?=
 =?us-ascii?Q?icNsfMp2mlVKjU+aXIbIDOv5F/dfd7/eNx0lHXbRqdm+4RMJh1p7hQXNCd+w?=
 =?us-ascii?Q?NtHpFFnGR3A6ThCDQmCYx6LJ+KGsKCI3oXuhom8Xs8AdNGjh4CVBdBlUfQFw?=
 =?us-ascii?Q?udmFDXdPrZ7CbdAZQ7P0NekKFWi71Rl9AO9uixgafdj6WoU55Tja00/IHp99?=
 =?us-ascii?Q?7cnX4d3WLorZL16kiIIZSTQLlnPQayikrQVPg0N7BSCETK15gQxnmZQvuHPg?=
 =?us-ascii?Q?YhZTk/ZsXCcI3NOaAyVv82CLIu2l3o0JnQ/lPOFrV12zhLihLLx2w+o0eh/c?=
 =?us-ascii?Q?IBljIVZ31ZKUbKaNEM2Dnw3eTgdZZT6zY7xbaSrIUrRpD9TSR/JPRJlerBqG?=
 =?us-ascii?Q?HooQnZtt2clYQf8wDdEyaJfaSCEU6ikTj+YUoUVY+ZJS0vnZrZx4AQoKG+es?=
 =?us-ascii?Q?Qtbgk0lAXyxsl0ZYXIuViwHY7fDg+tBx3RBzYy8bAKjZvJ2DbGSpw7KbTQWJ?=
 =?us-ascii?Q?Vut9aK6pg1uHewHc/+I/qZBfHJAtAVHfNx9R53NEL2UpYNfc1FZbhqsWSGom?=
 =?us-ascii?Q?ZXGXhIb6mgTxjfcbNIiDmYYoHg7GAUh3vBteJ3U3W8BaYkWyGY4reu6qjQck?=
 =?us-ascii?Q?JPFERbzE/W922kuXr3EE+PpphLjsoWXHZH5WHuch2N9xKw+wXtT+kcBYpMAD?=
 =?us-ascii?Q?E5W+L/KsA41AvDbUZUy/hqTjSucCaLLHvG0wZD/xOy9zzR2f/m+oBMpYkK+U?=
 =?us-ascii?Q?2QpVQzHorPNGJhszyzyyytQLnGhthdztrrLmj+LE/FQXY2ErQnKeHLtLu/Zz?=
 =?us-ascii?Q?3h2J0CraPWKitFlK3TGR7+UcaKV46kIGMkUaevA5C3U+eiq7NHTqOrF/gb68?=
 =?us-ascii?Q?mUF8CZsEE29rOkIIx2TWdlmCyclimcOUZBnZ3p77gd3JN8ljZdY5jPDkQExi?=
 =?us-ascii?Q?fBrNu0xma7YZabyquTI2xGN8QPVzTxLJd5QszZsez68RdPOr7LO5LUwlP289?=
 =?us-ascii?Q?90sqXSBY0BgYLi/yLTDB5fL7Vmqt5VNsYgIT6bPhKbSqwmVYuaYOeZ/MmcPm?=
 =?us-ascii?Q?bpCkT8RsFrVZuSBWNSTqfbByRO0uHb7ng3FiGgQcRl1MLTgD228iOAjzsqXC?=
 =?us-ascii?Q?alMERQNYkdfDIdPuCXotrbO/Ix3ho3fQW1rhXTlaANuRh04mjVoGFaCSuL1d?=
 =?us-ascii?Q?KtRBFNsawZvmxkkr0Tpa+z66vSL/2IxNvoJqcscI7KZqQ4N8n1KFsgYCthNH?=
 =?us-ascii?Q?tO7DgWp/nQ9jHh7AJSalexbY2ECoUQNYI2+gL8t0GuNnd4Olx1CCzVcAIHr5?=
 =?us-ascii?Q?LdPoJW/logMJ1JY4jTuqtXKmnlqSRG1WzcoHWe5UZpznJOJDaiytmUTzXyba?=
 =?us-ascii?Q?nzg3cJ37N4/NKTz7n9ywVnUl7XgdLrPUp41s23++FxmsjpKvtx/I217t+mJn?=
 =?us-ascii?Q?z/ceqmaM7Nje0XyDufBRj0maYVAWKq5PeA2qrENFmTqrpFMO1ue/a7cFNM8Q?=
 =?us-ascii?Q?FtBuvyb0SjJdnX/+ITa5hns6BubJaLlJAN7t/Z1r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff931ec9-9de5-4fe1-b3fb-08daeed48114
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 04:22:49.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 746NxnkW42JLnHTOxdD/jf5/GIPyUp0OwOhHetvCt9VAJuHX9P3GER5PzIq0+68FswB6HMIYiUaENXJdjQbCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use iostat_lat_type as parameter instead of raw number.
BTW, move NUM_PREALLOC_IOSTAT_CTXS to the header file, and rename
iotype to page_type to match the definition.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/data.c   |  5 +++--
 fs/f2fs/iostat.c | 34 +++++++++++-----------------------
 fs/f2fs/iostat.h | 19 ++++++++++---------
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c940da1c540f..4e8fd5697c42 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	struct bio_post_read_ctx *ctx;
 	bool intask = in_task();
 
-	iostat_update_and_unbind_ctx(bio, 0);
+	iostat_update_and_unbind_ctx(bio, READ_IO);
 	ctx = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_READ_IO))
@@ -330,7 +330,8 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	iostat_update_and_unbind_ctx(bio, 1);
+	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO :
+										WRITE_ASYNC_IO);
 	sbi = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 59c72f92191a..20944c4a683a 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -14,7 +14,6 @@
 #include "iostat.h"
 #include <trace/events/f2fs.h>
 
-#define NUM_PREALLOC_IOSTAT_CTXS	128
 static struct kmem_cache *bio_iostat_ctx_cache;
 static mempool_t *bio_iostat_ctx_pool;
 
@@ -210,49 +209,38 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 }
 
 static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
-				int rw, bool is_sync)
+				enum iostat_lat_type type)
 {
 	unsigned long ts_diff;
-	unsigned int iotype = iostat_ctx->type;
+	unsigned int page_type = iostat_ctx->type;
 	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
-	int idx;
 	unsigned long flags;
 
 	if (!sbi->iostat_enable)
 		return;
 
 	ts_diff = jiffies - iostat_ctx->submit_ts;
-	if (iotype >= META_FLUSH)
-		iotype = META;
-
-	if (rw == 0) {
-		idx = READ_IO;
-	} else {
-		if (is_sync)
-			idx = WRITE_SYNC_IO;
-		else
-			idx = WRITE_ASYNC_IO;
-	}
+	if (page_type >= META_FLUSH)
+		page_type = META;
 
 	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
-	io_lat->sum_lat[idx][iotype] += ts_diff;
-	io_lat->bio_cnt[idx][iotype]++;
-	if (ts_diff > io_lat->peak_lat[idx][iotype])
-		io_lat->peak_lat[idx][iotype] = ts_diff;
+	io_lat->sum_lat[type][page_type] += ts_diff;
+	io_lat->bio_cnt[type][page_type]++;
+	if (ts_diff > io_lat->peak_lat[type][page_type])
+		io_lat->peak_lat[type][page_type] = ts_diff;
 	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
-void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
+void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
-	bool is_sync = bio->bi_opf & REQ_SYNC;
 
-	if (rw == 0)
+	if (type == READ_IO)
 		bio->bi_private = iostat_ctx->post_read_ctx;
 	else
 		bio->bi_private = iostat_ctx->sbi;
-	__update_iostat_latency(iostat_ctx, rw, is_sync);
+	__update_iostat_latency(iostat_ctx, type);
 	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
 }
 
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 2c048307b6e0..1f827a2fe6b2 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -8,20 +8,21 @@
 
 struct bio_post_read_ctx;
 
+enum iostat_lat_type {
+	READ_IO = 0,
+	WRITE_SYNC_IO,
+	WRITE_ASYNC_IO,
+	MAX_IO_TYPE,
+};
+
 #ifdef CONFIG_F2FS_IOSTAT
 
+#define NUM_PREALLOC_IOSTAT_CTXS	128
 #define DEFAULT_IOSTAT_PERIOD_MS	3000
 #define MIN_IOSTAT_PERIOD_MS		100
 /* maximum period of iostat tracing is 1 day */
 #define MAX_IOSTAT_PERIOD_MS		8640000
 
-enum {
-	READ_IO,
-	WRITE_SYNC_IO,
-	WRITE_ASYNC_IO,
-	MAX_IO_TYPE,
-};
-
 struct iostat_lat_info {
 	unsigned long sum_lat[MAX_IO_TYPE][NR_PAGE_TYPE];	/* sum of io latencies */
 	unsigned long peak_lat[MAX_IO_TYPE][NR_PAGE_TYPE];	/* peak io latency */
@@ -57,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
-extern void iostat_update_and_unbind_ctx(struct bio *bio, int rw);
+extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
 extern int f2fs_init_iostat_processing(void);
@@ -67,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
-static inline void iostat_update_and_unbind_ctx(struct bio *bio, int rw) {}
+static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
 static inline void iostat_update_submit_ctx(struct bio *bio,
-- 
2.25.1

