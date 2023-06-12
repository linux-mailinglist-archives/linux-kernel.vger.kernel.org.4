Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C6072B594
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjFLDCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjFLDBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:01:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A81E4A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyPbewnLX1SqBcLlQJ3Q6AYoEq2WoyJPna2C9C6ioNoGdwwnnY+g1dt75BfqS7ldjBinBFUSWmkBYmGk7tInZSP3wybwlrojBVsj98f6VeYm5pmP/hkLzOYUTLWlRTwNZeRrLZ9MSrnl5RUhbmZexNis2R3Rmp68uecP+of5qtow18o3FCsn4XgTux6526xFbf4LIRsuSDvlw6/sKcNLyXHx6d0jINFBC2GjB2s0qfDloH8AViQU82AuavBim7f1FoL4uIIdk6/uVfToc51crNby4zpk39bIEGJf58ApNVyETyITW3Wd022i2meBd3XBbYJhUcdAhxA7x0atjtQRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKUnwyC/3gqOQ5IDTKfKbE911KLBhciRAlD1Y3QD7PA=;
 b=jO4ghU2YUxY/oZqXdNMb29qMNjE+ANPO866uAXT0tFzee8Hir2xueBlV0nfvA5ZgavVj4LLv0NJcYdSKiPFcPCwUcSkZbg8Xrq/Uwd/y2fjNxVKEnhdU5So+3ZvP4mRiNAo91ChujNhhWhTVZsovf/inbTaoypg1+TZ0VOi6zwpoWez36oAvl5F0+gIdSUHvtuUqu8hSrIXZOOjV81ANlQnDsmhbU8vwp+PZ1//LtANx0L1bUaFCZLgYzAA1PuCXd0SgXkpvNR/oQAsk8dYzGAEHOoZPA4ucWL+TAb7CIyaRzsZcu3UsHn/uRGLZchQCDQ76dWIPka/SkyTYV4zCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKUnwyC/3gqOQ5IDTKfKbE911KLBhciRAlD1Y3QD7PA=;
 b=lJe922hJ/B5rOoE139STwggd1N8o7LZHkUCMzEmOwXGWBtG5DwzqPTy732UuRUGGSsXiCpa4FYTuA2cgAfleXSQKkhC12p8vh0vFyAgoTY03pUBhrPQwZVUs6XyurPPOItqvUG4p0KgUU1MwvQn0SpAZkA9b/UP0Z2dRQk68BTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 KL1PR02MB6259.apcprd02.prod.outlook.com (2603:1096:820:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21; Mon, 12 Jun 2023 03:01:45 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%6]) with mapi id 15.20.6500.020; Mon, 12 Jun 2023
 03:01:45 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v4 1/6] f2fs: add helper to check compression level
Date:   Mon, 12 Jun 2023 11:01:16 +0800
Message-Id: <20230612030121.2393541-2-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612030121.2393541-1-shengyong@oppo.com>
References: <20230612030121.2393541-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|KL1PR02MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 974a3f92-7b30-4a0c-3107-08db6af15ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJRww8yGYpFgXVhFu5kRZyIIVvgSO4tQpjU+11vfzcuZCsAW/z7fWRh2l3UyFjzk1hibJG4Up2kX2ailmQpSb0IgsVDRi01Fw27ZrQdOVa6ZZIAvPbDp81ts95jX4d5MsQs8Y2R/ZUuga/MSSlEKGQDnRelttm5Yr6vpjLArNVyROjPrR3hRy/CGksY7ayBVjfwpai8LNew5D+WPvBjoXNHckoUtFfXTtcTKs2EEDpPP4HIc2MjzGJz4mToNXzRj+d4j11O5HR7am2OW+2ORMOiMJwYc2KgVdeyl91EruUmRuFC2JAOBKw/N2G/dGvDsW16/PW5gwLHoTuyRHNL3qYRGahjsMvYaqltTuOkfNkkAW39A78W+pZMh4StM/0nTvXdGindKFL++8nrsByxrDUCCTsYx6irnMzo7r7ajuRcRxdFkLrB+YK7OouyufoQFWMPn/x9endIid3MHl4+bzbPxby9Luzztfblgcnw9SFRqrRyFelqI+CWL7ycd8nYlCEo0iryETp80X4m3WAuluGL7AE+XMFn/XpiI7R53wAw02W4Dqf3NlVHDCAwHOq2YWORIh4ap2nsSwWIVayxUxhpsQqaVeYnV/gILuDmyX/9hBDiyKEcllMcDx8v+6lF9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66476007)(66556008)(8936002)(5660300002)(8676002)(36756003)(66946007)(4326008)(478600001)(6666004)(41300700001)(52116002)(6486002)(316002)(38100700002)(38350700002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(107886003)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SEC8H9JRq5/89BmcTRPqKuolxfgIyDYtc9GaWeDy0Yh/Z+ZnVOVJ9VSu9WjE?=
 =?us-ascii?Q?CxQcmy/Xp0QlFMJ0bPMkiQN8L3xxjnaZU738tC18Mke4Q/pd2iBNXMCm4PJ6?=
 =?us-ascii?Q?Gm4ZcRjYrM8xAnGLCkAkbwQuQFpxPt9wcw+HzS/NQqvblKqvPWXhi0W2Q82H?=
 =?us-ascii?Q?kR/sPaCL3ryScDppNlKJRmy6/Ct2/ig2RgCCUGa7U/vX9rzU9TLnRUBfNqpg?=
 =?us-ascii?Q?6tL20btWBBtJ9C25lD3TLHwRanCWcnzqCiCZrz2jOD9/xpv6reRMXXJ3gbXi?=
 =?us-ascii?Q?fXrdwRPe9HiUa6K/7674EY95VgKrscHfOEaAbHFOoYPV5T5XoLuH6hMoqvd7?=
 =?us-ascii?Q?JxQX+Y/1OS3eO3z9y9u6G9miot82LHks3OaWzu7dFNJxf0QBO/wpsYvScZuI?=
 =?us-ascii?Q?T5GaqE93j13F5JEuMb+EsPE9o1pD0IBag6OfpCSxtJqVIXRCrI388vqqjKty?=
 =?us-ascii?Q?r52UEBvITrpIV7nDwQHBfJOtAW4D3+K81rOBzBDuXsEkvhCqLWEeFbvct/kx?=
 =?us-ascii?Q?WsZfatyRZmJHz+4ZmxsIfxKDKE1P4n+/eyUPfjCL2/g7M9jlbr8bQwnEnyjN?=
 =?us-ascii?Q?kqNXa/s1rqo2kCWLSx+qb9h81c2Gwx7eTTNWt6ffyoQbfbhTEMb1TGdjSJ08?=
 =?us-ascii?Q?mMdwc8zzqV/c3q7CIaqkPieLWF7xdHeMjb7hUyxB1Et6IeEO1Lc0KHIxo9+D?=
 =?us-ascii?Q?p8so1AP5z9heaeFXAczQKpk6e05vB/LKHZvwqVfCB6yBpyf94daPYWeGiRF3?=
 =?us-ascii?Q?OWz4rmzPBDoD/qy/nhR4wyAbKtcfAvcB9IPbDv9iELfuf6Y1sN4IPzw0HCv1?=
 =?us-ascii?Q?9ReMzhy4fnC5COEUX/ixmMMAk6T6Aq6pOiiIc1iScKPulWidwMyzCrfg0ml6?=
 =?us-ascii?Q?tUaHabj/SwymgzlryM5I9QsRYVSOWCSkzySkXjIu8fV4zLKtG9WyeiALYDq0?=
 =?us-ascii?Q?h5Qz6mW824krrLhQ7eRAZFtVycDcmX7ouLIpoKHPJWt2SlKjceRxmAFJG4KO?=
 =?us-ascii?Q?bBsUGk2pODrRrQvTZfN6QRB/xvtm3Ss0OUVlOQGiSHRnd0eXD7CWgTaqSVZY?=
 =?us-ascii?Q?2k7u3Vi0AGSosOxsEHiTVe0M6o6qzHHHJIS5ayXxAjg/tT+/FKCScdfwv7Br?=
 =?us-ascii?Q?JtTRerg58I46HnTyVAGTJdF8b6SlO54sWMpubbzjjEdDiqpbLjgYbRg94OTU?=
 =?us-ascii?Q?uc3fp2s2E93OOccfEm/Yhj2flmG5lYWbN1afinskI0VbH/hNHu2uH6KQhqEV?=
 =?us-ascii?Q?NRxti5Aqn0u6RuOS5YOfK6D2keNnNanujX3rxFoyOoQO52WdcMHu+vKoz2sl?=
 =?us-ascii?Q?tEYDSBcHReYx/DtkNveR89+6sdPzJ45jzgbf5+hDiodG+zm3nXCzaCLcufMv?=
 =?us-ascii?Q?TUkCc/PEAp6TcVbR1lvLwIVZMI+H6VOGmQnvJW7MpD/CpxLl8oQLAwI2YUzL?=
 =?us-ascii?Q?ObI9sCQSjWyFw+Je9SEEgNzDCTI8DFBsYVea4TflMyxdizKc91DUGBJjdPhS?=
 =?us-ascii?Q?lJebkzqNX/I72XDPwg/BuZGMcOxkC7oQ4Uw97NxqiZ3WHaK0lnv/jV2jSx/K?=
 =?us-ascii?Q?ZWJpvlGt1U54DAVdNoWyV4/fuIVMoAwKax1BjokF?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a3f92-7b30-4a0c-3107-08db6af15ae0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:01:44.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDUJGWFcQWIbiauI+Ynd+9XGcpaT3uQaOY/JM+1s8oXZUKyNZ3CfJLFX68+HTq+EcD0UjbPeq8c0pvReG4O4VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a helper function to check if compression level is
valid.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/compress.c | 31 +++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h     |  2 ++
 fs/f2fs/super.c    |  4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1132d3cd8f337..63a496137ebe7 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -55,6 +55,7 @@ struct f2fs_compress_ops {
 	int (*init_decompress_ctx)(struct decompress_io_ctx *dic);
 	void (*destroy_decompress_ctx)(struct decompress_io_ctx *dic);
 	int (*decompress_pages)(struct decompress_io_ctx *dic);
+	bool (*is_level_valid)(int level);
 };
 
 static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
@@ -308,11 +309,23 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	return 0;
 }
 
+static bool lz4_is_level_valid(int lvl)
+{
+	if (lvl == 0)
+		return true;
+#ifdef CONFIG_F2FS_FS_LZ4HC
+	if (lvl >= LZ4HC_MIN_CLEVEL && lvl <= LZ4HC_MAX_CLEVEL)
+		return true;
+#endif
+	return false;
+}
+
 static const struct f2fs_compress_ops f2fs_lz4_ops = {
 	.init_compress_ctx	= lz4_init_compress_ctx,
 	.destroy_compress_ctx	= lz4_destroy_compress_ctx,
 	.compress_pages		= lz4_compress_pages,
 	.decompress_pages	= lz4_decompress_pages,
+	.is_level_valid		= lz4_is_level_valid,
 };
 #endif
 
@@ -477,6 +490,13 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 	return 0;
 }
 
+static bool zstd_is_level_valid(int lvl)
+{
+	if (lvl < zstd_min_clevel() || lvl > zstd_max_clevel())
+		return false;
+	return true;
+}
+
 static const struct f2fs_compress_ops f2fs_zstd_ops = {
 	.init_compress_ctx	= zstd_init_compress_ctx,
 	.destroy_compress_ctx	= zstd_destroy_compress_ctx,
@@ -484,6 +504,7 @@ static const struct f2fs_compress_ops f2fs_zstd_ops = {
 	.init_decompress_ctx	= zstd_init_decompress_ctx,
 	.destroy_decompress_ctx	= zstd_destroy_decompress_ctx,
 	.decompress_pages	= zstd_decompress_pages,
+	.is_level_valid		= zstd_is_level_valid,
 };
 #endif
 
@@ -542,6 +563,16 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
 
+bool f2fs_is_compress_level_valid(int alg, int lvl)
+{
+	const struct f2fs_compress_ops *cops = f2fs_cops[alg];
+
+	if (cops->is_level_valid)
+		return cops->is_level_valid(lvl);
+
+	return lvl == 0;
+}
+
 static mempool_t *compress_page_pool;
 static int num_compress_pages = 512;
 module_param(num_compress_pages, uint, 0444);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 80c783215b5a3..1b17bbe7e8656 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4236,6 +4236,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
 void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
+bool f2fs_is_compress_level_valid(int alg, int lvl);
 int __init f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
@@ -4300,6 +4301,7 @@ static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
 	/* not support compression */
 	return false;
 }
+static inline bool f2fs_is_compress_level_valid(int alg, int lvl) { return false; }
 static inline struct page *f2fs_compress_control_page(struct page *page)
 {
 	WARN_ON_ONCE(1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fd23caa1ed99..023981824d240 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -606,7 +606,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL) {
+	if (!f2fs_is_compress_level_valid(COMPRESS_LZ4, level)) {
 		f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
 		return -EINVAL;
 	}
@@ -640,7 +640,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (!level || level > zstd_max_clevel()) {
+	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
 	}
-- 
2.40.1

