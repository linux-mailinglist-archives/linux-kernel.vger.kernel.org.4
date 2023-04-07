Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2556DB1FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjDGRqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDGRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:46:33 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE879ED9;
        Fri,  7 Apr 2023 10:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhC8LLiGw1ZccWXgw/vhFAxiJnoynx2kGnUxXdh0HFmul01Z7/f+CH3WuzOfhNVKJeXJUiq43dmlMo2hzLhg0VFcMLw3smZNS+3hnHG6w9m80769nDwQ94qmmV6havDurd81xN2ryQOeIdoDUv1trCXrjskJ2BggnzJkTh2gnovs4HA2tmml6BwZhep+e76IOSsCsM1k85TBUvjuibE/hFBh87VaOMV0Qs/j+nWNgn4XbVf8XzkPHJfG9Txur+tx8MjSmxaSs0kPZA2CbRObRtW6D14Oic8J6uS2q3WLZjI+O5r/4f/to4nXKJez48xW0Lwza7w1XZAp+P6W1rBgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l13cqtxzQcUOoYpmE+V0PGtrr5i/usoTVpOWUdBlP/0=;
 b=PG7kvsGcNEVv696RpK5Wdk85mc85pcSRA302Ezt843ix+O9JNes6yXwLkILAj3/xu0WaqKyBoPkvTYqa/DtEwjqm4fBYB6lyumvpszZEZ2aYAFr/s3Y+Mdu9iH1+9ENRPNyl4jzaZ16WuYAXEHtjSNegQ67qVvnKafE/kQJiDFZziyEKOhAyt46oGO9h58wDpMouuY3tS5r6J0YqkjlUMBU2lU0R3I+9JBIbjM+09joP86VJ9xN4OqQ+jlB3leZWHrlrR2zPH70RgHJEU6hVPdRzocxCEZFUQb0QqBP8b2POyowMtwpiRa1r4Faoex6iDJRRrGLj+px4WHeSjUbfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l13cqtxzQcUOoYpmE+V0PGtrr5i/usoTVpOWUdBlP/0=;
 b=IavwA5O94j9hUSOqgRMG2aWsPUK9PLKgQC7o9r96puT/c62X6zgO6+gb6FhkszHljK1BvrGST1IB0JJUC1A70HhQTcaEQbWt96J1WwaShpafPIyI0m8npA42rv0RCo/XbXQZlKHvG4oc3lyLaz0f3eUcWtbomY7zqQHTHeLhrbfyRfrQZkkLYKkSn3NtOolmVKWK5TCYhheydOkTkr7+JHcHE3cm0CivQbneyx8D68pXgUUWWX1egqjld37WG3n2lACN4eexCrs5HsNCVQ7EvuxqiWVreNKMghzPsjQwExW8Q9ezIlHlhpcvGVlA2eNX3i0ZWoXaIs+iMuVhHNlQOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5613.apcprd06.prod.outlook.com (2603:1096:820:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Fri, 7 Apr
 2023 17:46:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 17:46:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] f2fs: add iostat latency statistics support for discard
Date:   Sat,  8 Apr 2023 01:46:08 +0800
Message-Id: <20230407174609.4939-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230407174609.4939-1-frank.li@vivo.com>
References: <20230407174609.4939-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 931756d5-9329-4742-dc3f-08db379000bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCu4mhKfhHqlK46MeUKEbcZCp5DOlO3D68Y/IbYPgbitYMafUrYR1r4B1CrFu9GRiiTm6dMZu8VimijMOzdLNt+2hvkUIlp1ik8NP70BlTrUqHOyVVDVi99OitPUclq5ik5R0rFhWQd3Jjv/Cfn7C4xi0DOvyczbTTrgkH6HxNj3h5zqxdJ8taCSJ8nC7D701DtXaeaSqSvaJS8svfGwrAbegu81uHazDF5ClKJ6vIzxWvPDynETg5eWUgQnvspunfm04TF+V6nEJDLXYRuoxQhzwoljfnjGyvRKGZyH5HiEm2h4IIZJUoIMD/CP0hkUgo15QAFlxZWYMYa9C4BayxhDl8fJoQhyuXV87atR8ttFAUSv4CBslTXTnuJsZ2Cju98EbLycg6tyUTYsVDmS2E45wm+GOMBlxtpyC8qpRgWvOx0lW5VcRIilbYr8K/Te4Bs+fsV33kznqP4wtNOeTAbXFbjFliwcsSqA2KHwa9vQ/poApyC/k3GSehNIDBBOK6IyZcXtigD4J5i23JaSohl8e/U2LaOdnB69uUshcll9pBvRooJZ+eq3mQbARMDSfvoH0tinC5bvH2WMznbkrAHc24VUo44wPgiG8v+FP1wgkxvouc7N2YlS3PmP94QR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(4326008)(66476007)(66556008)(66946007)(110136005)(316002)(36756003)(2906002)(41300700001)(2616005)(478600001)(86362001)(52116002)(5660300002)(6486002)(6666004)(8676002)(8936002)(186003)(38350700002)(38100700002)(6512007)(1076003)(6506007)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlxwxtlFsvIqiUilb6JIeVY+PWOnK7IecupfyEbocy75ceA/LfxBBGfb6riL?=
 =?us-ascii?Q?CYT/CVtOwcEOCzdfYJMgCjjZZRODR+TAdAbENgXdLW5lWJ4WYLtolXrG/NQo?=
 =?us-ascii?Q?6Y3040zY3pwlRp6CP3Y8aEUA1JZadTxguAOAs0FB2SZXv6bsRwh1VQtQ2cGc?=
 =?us-ascii?Q?OugnfC3l9mCMu3A5ZyDegMxaVe1pFedaZsHTnN7fI5QGCE4B/AGmh1CIdWil?=
 =?us-ascii?Q?LOLLSmQgAmnMRq7+xNqT61KwqxIqDEEbG00gMv8XyEKf1D06CPYMrOWfkRoZ?=
 =?us-ascii?Q?9oDYM7QNYp7oRTT3+9Qarf8D4YXtnXjK3H+bFWzhGDNH67yqea6ke1AAtN8c?=
 =?us-ascii?Q?fQXV34CNQcRzGIUCcJowKfKBoWGKK1sVNKkGdD5tOUgpikdgYqrdlaKARXpV?=
 =?us-ascii?Q?yToqwlQlRGXYAIan8ovtCVbrn7EFOsC2BiT98a/UYR9K2pnqkocKo6M5F9a4?=
 =?us-ascii?Q?gD9ZD9lKnUS7FsVauh8kf+Sv0qdUknjlGin+RWm5Hndmk3cozUzM02nY0FTV?=
 =?us-ascii?Q?sUwVsJBBvo7BUwXhZdrf76Ig8tkxaSBl6Y9i34LqvwZnXaGl7Z5M61T2S4UV?=
 =?us-ascii?Q?f8cwH0kh9hA+ewNqUB8KUXhCKJpXCwd6dVPxY663tU42O+6MLtxM/zSlmDgR?=
 =?us-ascii?Q?wlxM+GSNTRVqw8CqASPcRZG7N/PAIiJP+02r/Labgm7cDTaOWAO/ypftNfoU?=
 =?us-ascii?Q?RmxrZ8ID0j585tf/VkMed89IyLJ5C5S5fh3qWc/+MjSaIfUw1MeyLx5aWk0B?=
 =?us-ascii?Q?hMGy8+v4ic/Y9NbCUCd1F0b1a5bDhz/C4Uk+FbjvnNdSm6gKeVH4d1RWI9xr?=
 =?us-ascii?Q?XPmqEgrwgru9+NG5Y8/xO/LEi5yR1lCI5dACS2wm7dy3qHR39+Q8w8VqzxJO?=
 =?us-ascii?Q?2FTE0W2c7nHaY7AK5Y9fVKh4GZGa03L3uAYzktOnE159EoCBJbKa2KPWfHbi?=
 =?us-ascii?Q?oQa8Kqss7Yl8BJ+pPBY/Z4tDXI2QnTAQRFEYCY7bhLhImDOy1Ew9znTCgAHg?=
 =?us-ascii?Q?xdlPxoUgpnpZUlJOYbOfxuoCTO778NpMOM0VlO0JwzE5sNMU+NFDZv73YBo7?=
 =?us-ascii?Q?1anxKlFo2P2mjGNoxJJ6bDNUy2hfm4FJkotFDuZdTCsoqSslnABmR588yWtI?=
 =?us-ascii?Q?1PtlP3IHxn/D7R42XC0tKQb+Gxvvl4Zuf35lcszwB8HjMlNq5stYhlds11Bo?=
 =?us-ascii?Q?Sxsf35xEnBNr5jlCr9wwP9E8j7EFfP3+29uP0u+LrHwv71Mt8R4bMS7aVnZO?=
 =?us-ascii?Q?VlIe0QQNRSqiJrycFcG+2JeN2QXo2pUwJSiCdoD4wpWgvLuvOBv7OYDvwzEF?=
 =?us-ascii?Q?tqLi6bNIiER9OBBk4kgWPRCqk9U3u+Hqoxa2K9uHMkfQYSZF3Cy0Hy7r1tux?=
 =?us-ascii?Q?MvDt1XXq9urwZ1zX8qQnsrm/EBtxvgwePa8i1l9t/knw1LbFzptWG7OI28XZ?=
 =?us-ascii?Q?8xJ3UMtqbMbYAMNMC63OlrnS/RFu7h57qfKgKNoyedKba8W/QWKoAe2TADUv?=
 =?us-ascii?Q?AWAdYFHwtT2hrui8XvpI5bzdx320lH7ImngD+3XcKcFLN04DRytssYmJgGYh?=
 =?us-ascii?Q?oW7sbWWdf8eUMrloJ/Xput2d58qUoqzCk86040Rl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931756d5-9329-4742-dc3f-08db379000bf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 17:46:23.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CDNQp5QufVD77XIxJf7iTA5Z7SIuQ8n/T6h0TIFk5e4tENaNGIqP7t3PAxGO8MUlqQH2EzJnzcPAfUO/paqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5613
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, it adds to account discard latency. This allows us to
track the discard io latency of the system lightweightly after enabling
iostat.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-split it to two patch
 fs/f2fs/f2fs.h              |  1 +
 fs/f2fs/iostat.c            |  6 ++++--
 fs/f2fs/segment.c           |  8 +++++++-
 include/trace/events/f2fs.h | 12 ++++++++++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3d883201e7a5..1779f3596176 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1112,6 +1112,7 @@ enum page_type {
 	META_FLUSH,
 	IPU,		/* the below types are used by tracepoints only. */
 	OPU,
+	DISCARD,	/* used by iostat */
 };
 
 enum temp_type {
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 5d496d5b70d3..f40b8915ae1b 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -235,7 +235,7 @@ void iostat_update_and_unbind_ctx(struct bio *bio)
 {
 	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
 
-	if (op_is_write(bio_op(bio)))
+	if (op_is_write(bio_op(bio)) && !op_is_discard(bio_op(bio)))
 		bio->bi_private = iostat_ctx->sbi;
 	else
 		bio->bi_private = iostat_ctx->iostat_private;
@@ -251,7 +251,9 @@ void iostat_update_submit_ctx(struct bio *bio, enum page_type type)
 
 	iostat_ctx->submit_ts = jiffies;
 
-	if (op_is_write(bio_op(bio))) {
+	if (type == DISCARD) {
+		lat_type = DISCARD_LAT;
+	} else if (op_is_write(bio_op(bio))) {
 		lat_type = bio->bi_opf & REQ_SYNC ?
 				WRITE_SYNC_DATA_LAT : WRITE_ASYNC_DATA_LAT;
 		lat_type = (enum iostat_lat_type)(lat_type + type);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc0734e4fb92..be24e9c945a3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1100,9 +1100,12 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 
 static void f2fs_submit_discard_endio(struct bio *bio)
 {
-	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
+	struct discard_cmd *dc;
 	unsigned long flags;
 
+	iostat_update_and_unbind_ctx(bio);
+	dc = bio->bi_private;
+
 	spin_lock_irqsave(&dc->lock, flags);
 	if (!dc->error)
 		dc->error = blk_status_to_errno(bio->bi_status);
@@ -1276,6 +1279,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		bio->bi_private = dc;
 		bio->bi_end_io = f2fs_submit_discard_endio;
 		bio->bi_opf |= flag;
+
+		iostat_alloc_and_bind_ctx(sbi, bio, dc);
+		iostat_update_submit_ctx(bio, DISCARD);
 		submit_bio(bio);
 
 		atomic_inc(&dcc->issued_discard);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 040a430e1199..385291ac9ad5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2078,6 +2078,9 @@ TRACE_EVENT(f2fs_iostat_latency,
 		__field(unsigned int,	m_wr_as_peak)
 		__field(unsigned int,	m_wr_as_avg)
 		__field(unsigned int,	m_wr_as_cnt)
+		__field(unsigned int,	discard_peak)
+		__field(unsigned int,	discard_avg)
+		__field(unsigned int,	discard_cnt)
 	),
 
 	TP_fast_assign(
@@ -2109,6 +2112,9 @@ TRACE_EVENT(f2fs_iostat_latency,
 		__entry->m_wr_as_peak	= iostat_lat[WRITE_ASYNC_META_LAT].peak_lat;
 		__entry->m_wr_as_avg	= iostat_lat[WRITE_ASYNC_META_LAT].avg_lat;
 		__entry->m_wr_as_cnt	= iostat_lat[WRITE_ASYNC_META_LAT].cnt;
+		__entry->discard_peak	= iostat_lat[DISCARD_LAT].peak_lat;
+		__entry->discard_avg	= iostat_lat[DISCARD_LAT].avg_lat;
+		__entry->discard_cnt	= iostat_lat[DISCARD_LAT].cnt;
 	),
 
 	TP_printk("dev = (%d,%d), "
@@ -2116,7 +2122,8 @@ TRACE_EVENT(f2fs_iostat_latency,
 		"rd_data [%u/%u/%u], rd_node [%u/%u/%u], rd_meta [%u/%u/%u], "
 		"wr_sync_data [%u/%u/%u], wr_sync_node [%u/%u/%u], "
 		"wr_sync_meta [%u/%u/%u], wr_async_data [%u/%u/%u], "
-		"wr_async_node [%u/%u/%u], wr_async_meta [%u/%u/%u]",
+		"wr_async_node [%u/%u/%u], wr_async_meta [%u/%u/%u], "
+		"discard [%u/%u/%u]",
 		show_dev(__entry->dev),
 		__entry->d_rd_peak, __entry->d_rd_avg, __entry->d_rd_cnt,
 		__entry->n_rd_peak, __entry->n_rd_avg, __entry->n_rd_cnt,
@@ -2126,7 +2133,8 @@ TRACE_EVENT(f2fs_iostat_latency,
 		__entry->m_wr_s_peak, __entry->m_wr_s_avg, __entry->m_wr_s_cnt,
 		__entry->d_wr_as_peak, __entry->d_wr_as_avg, __entry->d_wr_as_cnt,
 		__entry->n_wr_as_peak, __entry->n_wr_as_avg, __entry->n_wr_as_cnt,
-		__entry->m_wr_as_peak, __entry->m_wr_as_avg, __entry->m_wr_as_cnt)
+		__entry->m_wr_as_peak, __entry->m_wr_as_avg, __entry->m_wr_as_cnt,
+		__entry->discard_peak, __entry->discard_avg, __entry->discard_cnt)
 );
 #endif
 
-- 
2.35.1

