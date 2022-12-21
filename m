Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F736536EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiLUTT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLUTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:19:54 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDC24F39
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:19:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB4bVNDeZd3lFxoapPWW7HPrzGT1jf9TEr5MukDOszaTyAj7gqWtUsnckACU4k9MZS9llT1Nn6ByBkAP5Tyd8at4TMDUDlTzSBhg6WPxJAZtpJLgi7sEoxq3TsXJvryl0/cMwHs/J1hl+8271SOgkZ2s8G/FRVqfbZ2Omzwsx0cv6MoLHejEg7E18ugmrm/qY2EO0YoMsVjlZcJxt+Ucjh0WMJrwiLPllkRHL1mpviq44mesLAbWaOfxIJ3Sw6jTQ//zRobqzuOokA402rS4i5ZD+x4SSw0hAileNH4VtGB8VdAQJuR8AyGhC8INRCshuIimtn0z31qVZGIU4bubEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kVl1rPlYnO7eXiagYx6LXP8jB+OttrZPL1IWnz2YB0=;
 b=OXm9FvwsQUs4zOJFK3AxTtjWyzDW79jW+ebkLWPfyrDr2NLNMJMdD5QUFKXgnOkB14z/HgtIN+gItkReHVLTHFjmIrx/AbV6BInYc6LffTLh4sHb6kOnZ80+HdrJAGFdnHapAiOqQpseyDOeVIlT/YBFjYyv/SldOvZlunJ/uoLNrVzHmhNpiM8yaypuGnUnJ99VFoMjwvft2zbwQw/oBOrfVcpVYaTSHB2LRsNJ8J4cc/aReY8Kxs5L14DEEZxRPhijQKYKwRAmhM1v5H0BimRqXwHZ32INiv0O22E8S9Yt0Q+fSmQafE2FLLiJdhUv0UqjzCfgXJ72+ZQqFZa8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kVl1rPlYnO7eXiagYx6LXP8jB+OttrZPL1IWnz2YB0=;
 b=UzLX1fZWdHFt11fYocUn9rxEFsgWMsB/anaYOJOvZtKh3jmzisCEBDC8P8c3kFBaCjo1cij3go4DjhIXhfcAhr07YqrSOnVDz31rUjx83pOszzGRtQ/tOcJ3w6sqobVtS8jyjf6SG3Xn+zGnagw9/Qz1bWgnJUvhWoOgKQa2IaAZp1Xb8bxInF14WIZ5e06R5tNInIn234Me99lxgXmAP1FW93TCgGCc+xqDbLoFe8GniLgoNgY6aFSCMdMZ0ts7WUGMZgP6jsga0OOcM3y2aiHewFkMWuivsrTNSPRII0dDgLH0yzQxZu7uC7gai69iZVagiHYzFbrPcovLiCvYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4106.apcprd06.prod.outlook.com (2603:1096:4:f7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Wed, 21 Dec 2022 19:19:47 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 19:19:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] f2fs: support accounting iostat count and avg_bytes
Date:   Thu, 22 Dec 2022 03:19:32 +0800
Message-Id: <20221221191932.17161-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd0548f-fc7b-4cfe-9143-08dae38852ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jr9HPWW/QhvVbxKFU6zwJjYzVEGHHAzCwrCbCN2rVv8LaRNUjc2ch9e6ugeDYEvrFcSGpL1lSoHGZ7y77oge6D9L8GKLH2BJpHeL3nqh5XJ92iMWihsivt9lzZrUBsUpeTyL33e6Dx3LUGv0sNShk100gnlCNhUsThARdpM7YfqjVGkbvGx2+ZQt9UuhgqHx4kDm1hOE2P7hJWgIgYUS6cGqYN0oL3trbnqvL5rsri42tmx1/4/bN82U7J+zvdT/RNcFPIKJEkX2PN8y9tPudKoKfd7lcY9u4lPFgkRK9NN8FdFOurr9Gqx+exuoLFwrWwgtjjBOJz9qwd+6DSeB0TjeaU8rdmaD2E6exVqX2QNhhyJ8l9OLgK6Vh6FWBLGkwN7Ya4pSogyxc1MXmKefG+/IY/LcdKZ0oM2JWAzmXX3tJM6ORX5bm0meeNa0VzH+eoBmXaMNiIpXRpOWeX6UVuhsL48CB+LjsjDV/NkkASIp3hLOrPxCMS0F5oExqIO3pHItUDCfTeJBBv0ha9RRtaF7BMooT1WlLgwrpora5mHWft7EMvPuaZAPQZiQt2V4FXMnQJDKBLCdUW9/G5P3cKbmEoT6a6+MTjxpM258wx3lChI+8nyeK76UY+dIdGXnlEZGnYBZZvm45g06NofiUn/MCdjZ+Uw/IJk0HvLlaxeZg7o9c6hU0vMy9bqQE0xT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(36756003)(26005)(186003)(6512007)(6506007)(107886003)(8936002)(6486002)(30864003)(6666004)(5660300002)(52116002)(83380400001)(316002)(2616005)(66476007)(1076003)(8676002)(4326008)(66946007)(86362001)(66556008)(41300700001)(2906002)(15650500001)(38350700002)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFQDBUlcSIJboc+OSgyNgqH9GDooGVHJCQ8Yrrt8WEQXWY+BC6S/kMtkSDMy?=
 =?us-ascii?Q?QpIV1Fx6tVKYLKbUy9lArFlXqFBO2dhZzmooIgi6QUCYCTvRbEGfiszlESmu?=
 =?us-ascii?Q?6/00hOlALab7zS8+rsZoMCoaClt+IqTnVS9coPLMx8guoC+tUOhBu3oJk6xb?=
 =?us-ascii?Q?mS5X+iJMY0P/LQW/S0ZD9Es3F47/Lf4+UYcYCpWpbWNbn/vUM+XfmaFeyzyG?=
 =?us-ascii?Q?mYs01jFHVsTYQCsKZa4l5kF8/Qv8l0vc8W4xl1zX+rRt8+5xrObvB9zH0Cbv?=
 =?us-ascii?Q?8VOgHCoJX7/tPh0d1EJoeu/c/Ni8BRHumMUKmdRcP+5LPmJS4ydJ64qT+Roz?=
 =?us-ascii?Q?foPrEgjTCgCLL5Frujz6qf1Qsm6N6pM69ekxpDp0gZeRAzWFMTomMB0C1kIs?=
 =?us-ascii?Q?Fk59KVnL1+DSXuye2FXRvEXE0IfgFjagiNDR23cHMF+bN2cUmCB1P0OXPhRM?=
 =?us-ascii?Q?S3VfBN4QY93VXUqbWueTuo0oWcrnERRGGQXNyRCd2BnxfKHfUfs5W4XN/Hmf?=
 =?us-ascii?Q?asUdmyvxBl+el+Tql5SFQdSkg/RXvHVcOVjiVafzEHI6qOFLPOHB88EAsm3S?=
 =?us-ascii?Q?RFQhPMvXcZ0NhcfyjjRq4yEbVykkE8DvffI1lAVWRmr/li6CA035jjr4iTv6?=
 =?us-ascii?Q?Edh3W2F43ozjlKw8cuTNsubpr6Dlah0ARdnU0TJNpCuleJJtR+BERIYdhknx?=
 =?us-ascii?Q?dHiW3AtCFAyCs2d89kKkXEZ4Sf5KEs69zUYozcS6Vr8tk/3NnT9PqnnPR4l5?=
 =?us-ascii?Q?/URGIZzWM+J3qvvDuEVCJ4VusBD7sOiJExzQeyC0MnGZIEyKjS9srYpqrxAB?=
 =?us-ascii?Q?5GW30krOn59Laj+VxVmF/J51T/vfiq7TptszdzRVAY9xJ/wpmimdPDy+qghh?=
 =?us-ascii?Q?3B6WXI6cSGZDHKi0h3Uf/Mk+njFs2zi8I8N3cns0iUR0xPLWjslQJDDEuyw7?=
 =?us-ascii?Q?FGp+jAgxdoJcIfqZJU+UtxqS3fT7W7wBG1uRNqBo5FxplMpdxkMarNVdsrOI?=
 =?us-ascii?Q?2h0qAK+cBHFT1RFpF5JZlEZ8LIs6ndPIslIXa9wB2LG0NfJ/RH/1BtJ9OHT1?=
 =?us-ascii?Q?YwoE7nOx8SHAC38MBxSXabLZPmTT+hnd4lawhAYLsWqLTh6XovvIYYnMX3xC?=
 =?us-ascii?Q?KE0vk4NXGSvu2yvuquYglu6zi4LjIa87XfpQl80UVj3ayQn3Cg10K55kVuH9?=
 =?us-ascii?Q?PuTZA2BKEr6dfNgZh0alsQhG1WJLdmq/lSW6zo1uBOZyv2/BvGLTeRXYGtU5?=
 =?us-ascii?Q?HmTNvV+rxsA1BPyJCa79NWoHJvI+WZSIGlrnRYbzBy4oWGKn2beZhuI1l5by?=
 =?us-ascii?Q?vNqcYgIJT78rRaGNOGiALrmF8naT3ONCPzKXb1eat72NlHQeu7wfSQ352Spc?=
 =?us-ascii?Q?UzT8BG8/qT3AlB8Eae5Q3+VtOVtT1YjErJwtpF0zN2mdYBCcx+eZsOC/QZfi?=
 =?us-ascii?Q?z5OCSPXLWK1sEtRhc6rjNy3Pf6IKigUngiUsfT42H0W55uuDbS66rC5esgG1?=
 =?us-ascii?Q?OHQSti0Bc5y0PMasv/tzJWlMAR8owfM3NAehtzHvvhfYgsaU39AxUEyoTgH2?=
 =?us-ascii?Q?tjHE/9cauATFXT0NOsEocQ6HXCkWVbzshcKOGklR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd0548f-fc7b-4cfe-9143-08dae38852ef
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 19:19:47.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V08WwwWsh2quEKlnF1Fl3FZRlygBJMD+nwX9jmMrjgs39cKaAdDp4SObfpqjZeIZZty1Zs3Ju7yU82UZaQr3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we supported to account iostat io_bytes,
in this patch, it adds to account iostat count and avg_bytes:

time:           1671648667
                        io_bytes         count            avg_bytes
[WRITE]
app buffered data:      31               2                15

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h   |   1 +
 fs/f2fs/iostat.c | 184 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 126 insertions(+), 59 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..b116c778fce6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1864,6 +1864,7 @@ struct f2fs_sb_info {
 #ifdef CONFIG_F2FS_IOSTAT
 	/* For app/fs IO statistics */
 	spinlock_t iostat_lock;
+	unsigned long long iostat_count[NR_IO_TYPE];
 	unsigned long long rw_iostat[NR_IO_TYPE];
 	unsigned long long prev_rw_iostat[NR_IO_TYPE];
 	bool iostat_enable;
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3166a8939ed4..3d4503fef183 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -18,6 +18,13 @@
 static struct kmem_cache *bio_iostat_ctx_cache;
 static mempool_t *bio_iostat_ctx_pool;
 
+static inline unsigned long long iostat_get_avg_bytes(struct f2fs_sb_info *sbi,
+	enum iostat_type type)
+{
+	return sbi->iostat_count[type] ? div64_u64(sbi->rw_iostat[type],
+		sbi->iostat_count[type]) : 0;
+}
+
 int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct super_block *sb = seq->private;
@@ -28,69 +35,121 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 		return 0;
 
 	seq_printf(seq, "time:		%-16llu\n", now);
+	seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
+				"io_bytes", "count", "avg_bytes");
 
 	/* print app write IOs */
 	seq_puts(seq, "[WRITE]\n");
-	seq_printf(seq, "app buffered data:	%-16llu\n",
-				sbi->rw_iostat[APP_BUFFERED_IO]);
-	seq_printf(seq, "app direct data:	%-16llu\n",
-				sbi->rw_iostat[APP_DIRECT_IO]);
-	seq_printf(seq, "app mapped data:	%-16llu\n",
-				sbi->rw_iostat[APP_MAPPED_IO]);
-	seq_printf(seq, "app buffered cdata:	%-16llu\n",
-				sbi->rw_iostat[APP_BUFFERED_CDATA_IO]);
-	seq_printf(seq, "app mapped cdata:	%-16llu\n",
-				sbi->rw_iostat[APP_MAPPED_CDATA_IO]);
+	seq_printf(seq, "app buffered data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_IO],
+				sbi->iostat_count[APP_BUFFERED_IO],
+				iostat_get_avg_bytes(sbi, APP_BUFFERED_IO));
+	seq_printf(seq, "app direct data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_DIRECT_IO],
+				sbi->iostat_count[APP_DIRECT_IO],
+				iostat_get_avg_bytes(sbi, APP_DIRECT_IO));
+	seq_printf(seq, "app mapped data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_IO],
+				sbi->iostat_count[APP_MAPPED_IO],
+				iostat_get_avg_bytes(sbi, APP_MAPPED_IO));
+	seq_printf(seq, "app buffered cdata:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_CDATA_IO],
+				sbi->iostat_count[APP_BUFFERED_CDATA_IO],
+				iostat_get_avg_bytes(sbi, APP_BUFFERED_CDATA_IO));
+	seq_printf(seq, "app mapped cdata:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_CDATA_IO],
+				sbi->iostat_count[APP_MAPPED_CDATA_IO],
+				iostat_get_avg_bytes(sbi, APP_MAPPED_CDATA_IO));
 
 	/* print fs write IOs */
-	seq_printf(seq, "fs data:		%-16llu\n",
-				sbi->rw_iostat[FS_DATA_IO]);
-	seq_printf(seq, "fs cdata:		%-16llu\n",
-				sbi->rw_iostat[FS_CDATA_IO]);
-	seq_printf(seq, "fs node:		%-16llu\n",
-				sbi->rw_iostat[FS_NODE_IO]);
-	seq_printf(seq, "fs meta:		%-16llu\n",
-				sbi->rw_iostat[FS_META_IO]);
-	seq_printf(seq, "fs gc data:		%-16llu\n",
-				sbi->rw_iostat[FS_GC_DATA_IO]);
-	seq_printf(seq, "fs gc node:		%-16llu\n",
-				sbi->rw_iostat[FS_GC_NODE_IO]);
-	seq_printf(seq, "fs cp data:		%-16llu\n",
-				sbi->rw_iostat[FS_CP_DATA_IO]);
-	seq_printf(seq, "fs cp node:		%-16llu\n",
-				sbi->rw_iostat[FS_CP_NODE_IO]);
-	seq_printf(seq, "fs cp meta:		%-16llu\n",
-				sbi->rw_iostat[FS_CP_META_IO]);
+	seq_printf(seq, "fs data:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_DATA_IO],
+				sbi->iostat_count[FS_DATA_IO],
+				iostat_get_avg_bytes(sbi, FS_DATA_IO));
+	seq_printf(seq, "fs cdata:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_CDATA_IO],
+				sbi->iostat_count[FS_CDATA_IO],
+				iostat_get_avg_bytes(sbi, FS_CDATA_IO));
+	seq_printf(seq, "fs node:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_NODE_IO],
+				sbi->iostat_count[FS_NODE_IO],
+				iostat_get_avg_bytes(sbi, FS_NODE_IO));
+	seq_printf(seq, "fs meta:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_META_IO],
+				sbi->iostat_count[FS_META_IO],
+				iostat_get_avg_bytes(sbi, FS_META_IO));
+	seq_printf(seq, "fs gc data:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_GC_DATA_IO],
+				sbi->iostat_count[FS_GC_DATA_IO],
+				iostat_get_avg_bytes(sbi, FS_GC_DATA_IO));
+	seq_printf(seq, "fs gc node:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_GC_NODE_IO],
+				sbi->iostat_count[FS_GC_NODE_IO],
+				iostat_get_avg_bytes(sbi, FS_GC_NODE_IO));
+	seq_printf(seq, "fs cp data:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_CP_DATA_IO],
+				sbi->iostat_count[FS_CP_DATA_IO],
+				iostat_get_avg_bytes(sbi, FS_CP_DATA_IO));
+	seq_printf(seq, "fs cp node:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_CP_NODE_IO],
+				sbi->iostat_count[FS_CP_NODE_IO],
+				iostat_get_avg_bytes(sbi, FS_CP_NODE_IO));
+	seq_printf(seq, "fs cp meta:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_CP_META_IO],
+				sbi->iostat_count[FS_CP_META_IO],
+				iostat_get_avg_bytes(sbi, FS_CP_META_IO));
 
 	/* print app read IOs */
 	seq_puts(seq, "[READ]\n");
-	seq_printf(seq, "app buffered data:	%-16llu\n",
-				sbi->rw_iostat[APP_BUFFERED_READ_IO]);
-	seq_printf(seq, "app direct data:	%-16llu\n",
-				sbi->rw_iostat[APP_DIRECT_READ_IO]);
-	seq_printf(seq, "app mapped data:	%-16llu\n",
-				sbi->rw_iostat[APP_MAPPED_READ_IO]);
-	seq_printf(seq, "app buffered cdata:	%-16llu\n",
-				sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO]);
-	seq_printf(seq, "app mapped cdata:	%-16llu\n",
-				sbi->rw_iostat[APP_MAPPED_CDATA_READ_IO]);
+	seq_printf(seq, "app buffered data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_READ_IO],
+				sbi->iostat_count[APP_BUFFERED_READ_IO],
+				iostat_get_avg_bytes(sbi, APP_BUFFERED_READ_IO));
+	seq_printf(seq, "app direct data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_DIRECT_READ_IO],
+				sbi->iostat_count[APP_DIRECT_READ_IO],
+				iostat_get_avg_bytes(sbi, APP_DIRECT_READ_IO));
+	seq_printf(seq, "app mapped data:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_READ_IO],
+				sbi->iostat_count[APP_MAPPED_READ_IO],
+				iostat_get_avg_bytes(sbi, APP_MAPPED_READ_IO));
+	seq_printf(seq, "app buffered cdata:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO],
+				sbi->iostat_count[APP_BUFFERED_CDATA_READ_IO],
+				iostat_get_avg_bytes(sbi, APP_BUFFERED_CDATA_READ_IO));
+	seq_printf(seq, "app mapped cdata:	%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[APP_MAPPED_CDATA_READ_IO],
+				sbi->iostat_count[APP_MAPPED_CDATA_READ_IO],
+				iostat_get_avg_bytes(sbi, APP_MAPPED_CDATA_READ_IO));
 
 	/* print fs read IOs */
-	seq_printf(seq, "fs data:		%-16llu\n",
-				sbi->rw_iostat[FS_DATA_READ_IO]);
-	seq_printf(seq, "fs gc data:		%-16llu\n",
-				sbi->rw_iostat[FS_GDATA_READ_IO]);
-	seq_printf(seq, "fs cdata:		%-16llu\n",
-				sbi->rw_iostat[FS_CDATA_READ_IO]);
-	seq_printf(seq, "fs node:		%-16llu\n",
-				sbi->rw_iostat[FS_NODE_READ_IO]);
-	seq_printf(seq, "fs meta:		%-16llu\n",
-				sbi->rw_iostat[FS_META_READ_IO]);
+	seq_printf(seq, "fs data:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_DATA_READ_IO],
+				sbi->iostat_count[FS_DATA_READ_IO],
+				iostat_get_avg_bytes(sbi, FS_DATA_READ_IO));
+	seq_printf(seq, "fs gc data:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_GDATA_READ_IO],
+				sbi->iostat_count[FS_GDATA_READ_IO],
+				iostat_get_avg_bytes(sbi, FS_GDATA_READ_IO));
+	seq_printf(seq, "fs cdata:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_CDATA_READ_IO],
+				sbi->iostat_count[FS_CDATA_READ_IO],
+				iostat_get_avg_bytes(sbi, FS_CDATA_READ_IO));
+	seq_printf(seq, "fs node:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_NODE_READ_IO],
+				sbi->iostat_count[FS_NODE_READ_IO],
+				iostat_get_avg_bytes(sbi, FS_NODE_READ_IO));
+	seq_printf(seq, "fs meta:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_META_READ_IO],
+				sbi->iostat_count[FS_META_READ_IO],
+				iostat_get_avg_bytes(sbi, FS_META_READ_IO));
 
 	/* print other IOs */
 	seq_puts(seq, "[OTHER]\n");
-	seq_printf(seq, "fs discard:		%-16llu\n",
-				sbi->rw_iostat[FS_DISCARD]);
+	seq_printf(seq, "fs discard:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_DISCARD],
+				sbi->iostat_count[FS_DISCARD],
+				iostat_get_avg_bytes(sbi, FS_DISCARD));
 
 	return 0;
 }
@@ -169,6 +228,13 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 	spin_unlock_irq(&sbi->iostat_lat_lock);
 }
 
+static inline void __f2fs_update_iostat(struct f2fs_sb_info *sbi,
+			enum iostat_type type, unsigned long long io_bytes)
+{
+	sbi->rw_iostat[type] += io_bytes;
+	sbi->iostat_count[type]++;
+}
+
 void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 			enum iostat_type type, unsigned long long io_bytes)
 {
@@ -178,33 +244,33 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
 		return;
 
 	spin_lock_irqsave(&sbi->iostat_lock, flags);
-	sbi->rw_iostat[type] += io_bytes;
+	__f2fs_update_iostat(sbi, type, io_bytes);
 
 	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
-		sbi->rw_iostat[APP_WRITE_IO] += io_bytes;
+		__f2fs_update_iostat(sbi, APP_WRITE_IO, io_bytes);
 
 	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
-		sbi->rw_iostat[APP_READ_IO] += io_bytes;
+		__f2fs_update_iostat(sbi, APP_READ_IO, io_bytes);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (inode && f2fs_compressed_file(inode)) {
 		if (type == APP_BUFFERED_IO)
-			sbi->rw_iostat[APP_BUFFERED_CDATA_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, APP_BUFFERED_CDATA_IO, io_bytes);
 
 		if (type == APP_BUFFERED_READ_IO)
-			sbi->rw_iostat[APP_BUFFERED_CDATA_READ_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, APP_BUFFERED_CDATA_READ_IO, io_bytes);
 
 		if (type == APP_MAPPED_READ_IO)
-			sbi->rw_iostat[APP_MAPPED_CDATA_READ_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, APP_MAPPED_CDATA_READ_IO, io_bytes);
 
 		if (type == APP_MAPPED_IO)
-			sbi->rw_iostat[APP_MAPPED_CDATA_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, APP_MAPPED_CDATA_IO, io_bytes);
 
 		if (type == FS_DATA_READ_IO)
-			sbi->rw_iostat[FS_CDATA_READ_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, FS_CDATA_READ_IO, io_bytes);
 
 		if (type == FS_DATA_IO)
-			sbi->rw_iostat[FS_CDATA_IO] += io_bytes;
+			__f2fs_update_iostat(sbi, FS_CDATA_IO, io_bytes);
 	}
 #endif
 
-- 
2.25.1

