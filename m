Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9086864AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjBAKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBAKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:47:23 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47C423C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:47:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyCaxmxVSf0GD9U0VOiIiksA6ewdVoQUPZGsT0vgbmgXXnUtzqXDqnYg1H8J7nP/+7GPV18xyu3uKpbGtWzaNCuBuM52TcX20YMUmpTDt2VnRNws3Csk3enCn8PCLS5txwISGeHxDvuKMeto6EwyfZlvCvT5j+r4bxw3rKO2yVZZ0wKHuSfxcqyZNw2JnOVvUt30kDrNipU75D6P+hvxvANxkPhuxMTFD4+YKLhNghRnH6BKpy0wt7JMnh3MOn61iLdwUybFdC8z7FvWUNJbdZ3Siio+Q7nUXO3iLY1hojHCEEx+XfHqwk1RP1yonulSGK0H/6x3vsG/wuMCJX+YsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1+0yBg9uJ6KPm/svwEjoQC2zBw7FLVIUxl7fHlcrVA=;
 b=fOx5BP3bi1e64YE88VjfvQvt5CtOZ/72Fu7uAERLDJDPxLmOQbkNMTk1/1PWt3o1zVc5QXPdY3FYYY9nm70LDHeczzDLDU9epFE8G8bdQFiBwM7JiTXsmjvY+OD9AmnKSY2yHpp2l/kWsIb3ma5sKgCh5Zst1zWKT3u2ij23bpHLuOOwpYqxlq4JUcxkOg+UYINKJm0FU1yjyEXc0tcQrwd3/zvZ2929efLUpaVzslFYRWetK7GgNwonvyLyNx+rOhWqEb3BGv3VlgMYeIZXmWZYnqD9jBwMxk5c9nNh6xx9GoFEcUkQeP262pbT5/KFeF0CLnb+o/bR8VaRPTdRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1+0yBg9uJ6KPm/svwEjoQC2zBw7FLVIUxl7fHlcrVA=;
 b=hagYmxG10sTP+X8ojg92GynXDC9GBHd4e7EvWD4YwFAcpnJoIFu3/o3fttO9LzZm/FVbcZD7CQ+lg2odaOFRTSLphcKrIF9X5W1LlQ3jSqS5VveNwp6pux2YeJxJoJSvXxox+MBEWgacag6SU6gkUWjGdRcYsTf7xNFbb5f7ORmpmOaPJX8eVwpU+A+Up2GBNRjnsDyiRJ6nmYfo/7meu/bt9YilZ7xFp0zQwjgzC1KCw5AKEr5qIFyUMOLXTtjZMDdoAtZekl6bWAV8vO2653j512bvYvo43i9dNfknIjn45weOY8WykR23Yh9f2X5LbZYYy4KiYyBC2b5mOCmcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5282.apcprd06.prod.outlook.com (2603:1096:400:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20; Wed, 1 Feb
 2023 10:47:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 10:47:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 2/2] f2fs: clean up parameters of iostat_update_and_unbind_ctx()
Date:   Wed,  1 Feb 2023 18:47:03 +0800
Message-Id: <20230201104703.31008-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230201104703.31008-1-frank.li@vivo.com>
References: <20230201104703.31008-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 844f63e8-e7ff-46d8-b408-08db0441afb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNIWhqzkniJrOIx/bOREh8rFLTJKngCOO6kUg133QLErs+zFuRiLEUx1qMUHkdH2+O8ST9JU5GU2W47YwTQ5gLfuS3eJzkI79JrubI3SgXsKCYO/bufDXNnVJqo/anEWP2jprT2aRJ6Vd3/ZXJPXJFscUplO+oZjYCSEmfG0PXtssJo1Q3sgU3Em1Y1JBzrJdx8ihbNJOXTduFsl6195ERzCSlLwIC6mErxVjIM9vA40duDHNhhaY9EYzxoYbACquWz65PUlkxjBd18x5aHb5Fnyq1LJOMG8I6rB0BhNuULNJgeE/BWPx22Sx3otrYW0MF4A5sY23B4ZrHJj1hbqmo8EF8oOZrSg5YRPS4I+hdFRoW42wT0mkTLlp6ixSMGipSjsjMCZlDBeR2T6mHkU1dpbWkOQwsCpskfN8UZSoi/zZNKX/QKXNhtcSA4srwLWbOMWlW7OboirMtj+BaUYbzOlX4DU6M1eYJfdY1jnR2/ZpS/ahvWc8JRa110KJZR4gmGp8nISC7Zujduy9MC5wZdYpUUWPWcWdhVBQWvzwF7HEtiG23k2ml5AjX48idqZg3X0hWCNszGv/HGxnG2rQe/fLVZiA3O5dxcUjI28nG7y6Spqb6+zB92D4WvomuP7JSGF5qQ5/y+sVuyFPOAQaXpdNK5BNNOsyy4oDXPm/eA6gXQQiyk4vcGJLtLr1ktIzO8FEiG3ng7AHbIbBlGpbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(41300700001)(66476007)(4326008)(8676002)(107886003)(8936002)(66946007)(316002)(66556008)(6666004)(5660300002)(6486002)(83380400001)(36756003)(26005)(1076003)(52116002)(6512007)(478600001)(186003)(6506007)(2906002)(2616005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?agAMKZpbaMYaP4d+r5kcVyIWnlVPUcM4VpUP4Z+31WaY6MFELg4eVymvmd8e?=
 =?us-ascii?Q?YuO9B6gmxFOPA5bZWrqpFjXZMyTegZZNuPvRA7ONAheGAutCyirbmKASomA5?=
 =?us-ascii?Q?wC4k8h0Ibby4SOCFmu/zs7LgLxmfyonKW/FCte4J4S1o477BDtBmkbv7/KVy?=
 =?us-ascii?Q?VWZmqBqSxJkIzkA0AjtYERV/AIXA4ioWatA5h35I+xsJShd0L6DYO/tFMlcL?=
 =?us-ascii?Q?tbPPx/Xy3x4yYcE4f5Ymo2SjSi/JBToi7govC9//4i3Rpt72cl3D1eKQR+u1?=
 =?us-ascii?Q?tsBvGDBHNtVeniBD+oEXZjHUc8JZB6rIpLmUcfT+R06RNXQZNT1wwI0RG4Cq?=
 =?us-ascii?Q?fboq3aGB7uNgGwq+K78Zx2Yg6pZIpvMnl766Sqy0QM6uMjm1EsT5QAmLWdGR?=
 =?us-ascii?Q?zCUdErP9KVWZIGxN2YqMSC5n1wGGCz8sgg90S85WaBsnQRWHVvZD0VkpYq1a?=
 =?us-ascii?Q?uqTcspqIcVqOP7A9Sr6ZGxBSlWZrNuqPyl994sCHNFatmYM+YUDaa7Ri85BD?=
 =?us-ascii?Q?EWYrFNCcit0jHGV2BhaUimdDXR6FFbAsJPFhmz4YXre3LdUE+lBXP64Yf7EF?=
 =?us-ascii?Q?KZhcf83bBHQrWxIt2K/HtVPSbPDVqf4NWvls5N57b/yPgmJ6f/gfxpzfgVEP?=
 =?us-ascii?Q?YIAJBd/yOJKcmyC+6Nv7Jdf0WLplvJzxZ9cRBk7a8edOF8CHekayhMk+hBwt?=
 =?us-ascii?Q?5TDnAojGC6slL3wWYA2cBgzMaDjCNhDnjrkRLI6qLKDt1IQ4nFOzxT2b6yhB?=
 =?us-ascii?Q?WmX2BiZxIwb6scA28yJ2NpO7LhtyKZZiNQL/FAtx8cTiocQKXn1eG74j4hTN?=
 =?us-ascii?Q?KE26sxU7py/4oxiZT9NB8riF7fePx24zHtSJTdMx7XEEGhoXp7R05C0JVvjS?=
 =?us-ascii?Q?kWy+VU8P06e8fLG7BXPb303jLg8/DkW9rjpwUo3wTjeKVMtMmwAmU/Yi6hjm?=
 =?us-ascii?Q?Fr5DnIrLsuoRh9cUm1GeETLic0rkMwZ7I+vQ+15gYKfy9hz2r08Utw4Xw/Z3?=
 =?us-ascii?Q?JDb+oXWE7c+sSrUaX9Zu+2mjoollmkuUmi1nbFzPcSgan/+8prjBhx2OahUt?=
 =?us-ascii?Q?ORwQ3ff063j0N1AxSa4sIQ25nVQTlyu6j+gpbwdZTFBNK+0Ag4MMr89E7rjE?=
 =?us-ascii?Q?rfMnTcizTKl0ZbwZBh3qz1F4X4P+oHzoBOP+VnlpRaTQtbSUYfeMxEPmhToN?=
 =?us-ascii?Q?THceLG3lMQX4HEfx3OSDztgO04HWjhn/cYiu/GNBS112BueJ8CSBLstpw+HO?=
 =?us-ascii?Q?JothcjBzikZEvCyMuf0YhvmUUxp79S3NvGjzV2DxAccoCaGi5gs3sk6RV5UB?=
 =?us-ascii?Q?ksZILVEMcm93uZ1rJ6KxGnEnQJYEiKM7TpHseOULVAveG74erZfLf4p4S+Tu?=
 =?us-ascii?Q?DDubLS5kRR0W6nbThusGOPGFdBHLnkBSKkxk85JyMnhvFEFbh5E4ffphCdx/?=
 =?us-ascii?Q?9rr12hOEntHwYWIDd1FvaDhjfDb/pikH5xwzrbg/IVXKgnJ5D9px4nssE4Ip?=
 =?us-ascii?Q?2W7vA7HPjHhArO/ogJ0EAD9B1tG3lwRluIwqZcof+xDCwQpuUpjRdZZCfWaE?=
 =?us-ascii?Q?vfYfaX5zHMeYRm6cMM6fG0+tpIof3A0LIfUtYNJh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844f63e8-e7ff-46d8-b408-08db0441afb1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 10:47:17.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B42UXjfHKsfb0lLuVmNRzsIEcApmYBIqUs4rscBYpZpIDM2/N/bexcpLwkbF2a+LBMp6i0VeQd0m7dmsSvmdfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao@kernel.org>

Parsing sync/rw type from bio inside iostat_update_and_unbind_ctx()
to avoid unnecessary parameters.

Signed-off-by: Chao Yu <chao@kernel.org>
[Yangtao: remove lat_type check]
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
change:
-remove lat_type check
 fs/f2fs/data.c   |  4 ++--
 fs/f2fs/iostat.c | 19 ++++++++++---------
 fs/f2fs/iostat.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 86fc28adc970..82e326c0e11d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -292,7 +292,7 @@ static void f2fs_read_end_io(struct bio *bio)
 	struct bio_post_read_ctx *ctx;
 	bool intask = in_task();
 
-	iostat_update_and_unbind_ctx(bio, READ_IO);
+	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_READ_IO))
@@ -330,7 +330,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
-	iostat_update_and_unbind_ctx(bio, bio->bi_opf & REQ_SYNC ? WRITE_SYNC_IO : WRITE_ASYNC_IO);
+	iostat_update_and_unbind_ctx(bio);
 	sbi = bio->bi_private;
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index c767a2e7d5a9..3d5bfb1ad585 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -228,11 +228,6 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 		return;
 	}
 
-	if (lat_type >= MAX_IO_TYPE) {
-		f2fs_warn(sbi, "%s: %d over MAX_IO_TYPE", __func__, lat_type);
-		return;
-	}
-
 	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	io_lat->sum_lat[lat_type][page_type] += ts_diff;
 	io_lat->bio_cnt[lat_type][page_type]++;
@@ -241,14 +236,20 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
-void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type lat_type)
+void iostat_update_and_unbind_ctx(struct bio *bio)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
+	enum iostat_lat_type lat_type;
 
-	if (lat_type == READ_IO)
-		bio->bi_private = iostat_ctx->post_read_ctx;
-	else
+	if (op_is_write(bio_op(bio))) {
+		lat_type = bio->bi_opf & REQ_SYNC ?
+				WRITE_SYNC_IO : WRITE_ASYNC_IO;
 		bio->bi_private = iostat_ctx->sbi;
+	} else {
+		lat_type = READ_IO;
+		bio->bi_private = iostat_ctx->post_read_ctx;
+	}
+
 	__update_iostat_latency(iostat_ctx, lat_type);
 	mempool_free(iostat_ctx, bio_iostat_ctx_pool);
 }
diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
index 1f827a2fe6b2..eb99d05cf272 100644
--- a/fs/f2fs/iostat.h
+++ b/fs/f2fs/iostat.h
@@ -58,7 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
 	return iostat_ctx->post_read_ctx;
 }
 
-extern void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type);
+extern void iostat_update_and_unbind_ctx(struct bio *bio);
 extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx);
 extern int f2fs_init_iostat_processing(void);
@@ -68,7 +68,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
 #else
 static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		enum iostat_type type, unsigned long long io_bytes) {}
-static inline void iostat_update_and_unbind_ctx(struct bio *bio, enum iostat_lat_type type) {}
+static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
 static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
 		struct bio *bio, struct bio_post_read_ctx *ctx) {}
 static inline void iostat_update_submit_ctx(struct bio *bio,
-- 
2.25.1

