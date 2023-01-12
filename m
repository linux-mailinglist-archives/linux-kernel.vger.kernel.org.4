Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB5066766A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbjALObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjALOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:30:35 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E45E093
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m//U41P/AJLPkoqJCC6Osfh2PoLbsWdGRZSRHhvsnUyAnIdZ4/S0ABH854ghK5G8g0HzNuXTqp8+45clXEVvx+gQO8KDLzkes1m1uY8fNjFsfP78JUNxpZPYWjyMVEa6409WJ/+DMC0AWNXb0SFi1t+vJ2KvIm9Yxb6+Kz/2hPUsbY7y9t2Nqd7F9E9ukKzKQL932JEih5l5Y2a+96IuoYo61oZuQOoW+vIjUfiaj8UORB5+tm0YSpw/4Y+vLZQW1tvUpQnFMw8cSas9PFhofFR97D/9USGBY/ybGIII5VzEvYBFr6/HH7CNtjIpljzTIXoUX496WcpcQCtvynTZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbi8lnORPLsRlVi4gnEfVMIckbTcRLKyiyWVjIOS1yI=;
 b=LuaKTKTv5qvWR8fsDs/kXDFEdOyugxi4IBi3RuhvXqOqo5cKiNwu2OlYEAI+FP99X/DTMk7ckH/rcvLI1MU2VPtpUCn1ZyvoRcEo00dAKeYbFQf3/3qWc1CMcqWKF9sXtW6XV0lsvVVw4CIj+9G/8C8XsXVqgkzDqL4fw8MGsWepGuLhbZr9mIfPdDGVUkz90Txwi3yP8YecvELH/UTsf055LhFGy0wIFmfN5XS4QDldgTXBwTQzdkQcyHQWjD2UydH3tD/kolPEnUoidf46sVw9xWyhft0p4MlhO46yYs93Ilpjjo3cEJQx5HLZ7LM+ib3t8n/TzhobGaa+MGQddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbi8lnORPLsRlVi4gnEfVMIckbTcRLKyiyWVjIOS1yI=;
 b=apsEcCsvTyLt3HHLSQ3cP1hNAdB0yi8HXY6r3wQYdJIro46yt7kLftWTL90/OxDijTP1a4+qw/013pDNYzEFi1+ZxjQ5wTNI1WUk7PNM0EgcAgok0R9m3mkNaT8Aim0ltKh5ZcLeuhuh9lp7FDc50wKf2QuHKevqXZSdIW4sYKALRshm8jGe3bANuhefgzZ3ONvVsBuopceHS7Gn8GWmFYEOhMlL1WI1Oix6pyxkbANwZMVjm/kHpnS17ZbdKwssaMVte4akJj/AMkL8v10JuqUDdGv/O052I1JRbBw37VPaqGAqauIbzJQ6/a/8n3iSNWF7EgTwVC2GVkf0y+G86w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3903.apcprd06.prod.outlook.com (2603:1096:400:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 14:22:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 14:22:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce sanity_check_blocks()
Date:   Thu, 12 Jan 2023 22:22:13 +0800
Message-Id: <20230112142213.22784-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3903:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afcba88-d3ab-47e1-1304-08daf4a86ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/MqNpUF5k+1o9R/bmJZzUmP9F9yqZzOjqYyAWjM3AYr3ck4AUN0ZQTOhP17duXCMT2CvuEOR61+qMynRsae5OJTPYni5GSN3CbWTqyCH7PTxg1oBFIg4sufhv88gmnE5RKPjgrK0v+4dAxtVqCTNIYtIIPtdFzeB4aoFYvwKCFwxYofb2IxXTTmx4faifMdPHtj33O0PBp/ZdCPCIXo/ZrspGf11MCgoHTCCLz6PNcFYiFLN9XtQ0eXV7HYjV5KaWbqONiEVSJJWUMuydEnFFcpnC9S+NJYa4wJjn2XjIDls5/UXL9zpJkNktEIXw6JuJqcsZYboajuQig3fSJI41Y6BHXPrg00siC1pxbGfhb9/jZXdwOFHOCyg7Nr6Og5tKv6z4vhlSekm/E2B+EzEuSCJEQRU+VWdwozxcDQPSsYx+imQI697o8Dwonp3mV8gW5Br1ItbVm3viGqLJ7NCwDmRW3ChbKZVYkkNL8sW3zdxMUvKb9HoJnnK1JgJOrsaVBEXiTd2u/nr9BCakBPlf/twOWCS2xhzXOOM+YV5BTRivqmjzeIvGFqmquDPS9GWRgC+f82KL1U4Zkrf9hyebpgmrlcsRGxregNsnqvMjc51rDuKQbItVf4ZavjGZ/GHNGnjN3sre2P1F1n22ScGVTMmfevQB61w8EtBAzRiPzqixdRAp3gOLNa57i0lYPd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(2906002)(66946007)(5660300002)(6486002)(36756003)(86362001)(8936002)(4326008)(316002)(38100700002)(66556008)(8676002)(38350700002)(66476007)(6506007)(41300700001)(52116002)(83380400001)(1076003)(2616005)(6512007)(186003)(6666004)(26005)(478600001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e0tBtrDnnocBr5vuvXgM6apR7lFDuutfLZMYp4pvgRJPM4dIftFkHWwKBOnM?=
 =?us-ascii?Q?pm7Rfx/iJVdwgl8EfQLCPNSSY8+ejztman6CAnS9Jn3CwJe57PcdkZQpvG+d?=
 =?us-ascii?Q?tBcCaxRHpeRv5GQStxGhgzKEUWsNYlD3uOhhYNf+tvJMMtTLqayBiAjRcnRF?=
 =?us-ascii?Q?ttKt80entT44JB3oXC+/iECgoxUdU6P8H+j2XYPLibulIkR6OgjE4p/dX0ab?=
 =?us-ascii?Q?xoV5BZiF034dHv3hxL2TKtUihHoSe7SbYNg70f3019qT+c0ZTSCj3F6N8mK3?=
 =?us-ascii?Q?Ce3YGJO69HmnTCbGDiSLXSW/XmoQFa+U79JDOvraxHdRRUYeqpzMgponDWAd?=
 =?us-ascii?Q?y9VWVUxCw7h0FxaZ4LOP74YeaNgRW1fB8QHl84WCmzlwl0XMJXaNzFrJ8SIu?=
 =?us-ascii?Q?tMLZ2CsIWTFPvegZ0wo+xuD86+oCej/RjbqlS+eu34j6xthO/pVJmUc16dHZ?=
 =?us-ascii?Q?QFmgy8ZvxUZx0ZybmDx/gVteuqL2IUNoPaqBQoN/HmbUQmVyVRDZ/bK9hnLm?=
 =?us-ascii?Q?I1TjLz0W2oMVgGr9yU505n1TKZozP54US7lg2oR7xRzltbkvPKzeksRndQXg?=
 =?us-ascii?Q?ey062fNbtQLQKD2MRPFF089N4mENRqHQLkCm8TxSXmkmvaa5NQT1dUdMy5uK?=
 =?us-ascii?Q?dEaskFU3i8XBXbE/3Sm9qBy0i6f0+AvBkv2sKVhhtW2pPgrAV0gl+Wq9vc/R?=
 =?us-ascii?Q?ewmjqrY9yN9s9qLYGDT4EBHotRtalc3iq9T/LyWxIKOCvIiRdiVfT4Pihdis?=
 =?us-ascii?Q?eO3cDxy1xsiZnElpa516N1m+oBFMB6y/5V4uThY0nHtHj5wUbPn6cxmHSfUf?=
 =?us-ascii?Q?ShFnDKgiB8gAkIHCCTJZimzxto95aZO/BBrFpScD5GmWwhwE+r22FY/l2Kr9?=
 =?us-ascii?Q?4nC+v7inO/bq9yl6ZW2JKka9H7Pe/EgltE2T3JbOw+483Uale8qvbAl1leWM?=
 =?us-ascii?Q?5irX1Td/mKDlGuKOKNjB97J7vzcjKvSrpFxTlZOE2z1vQpzH04CKp5qyvcDU?=
 =?us-ascii?Q?ifEmpoCngONoi+XQcCLYpKRN4W9mdlbKxFzQmKKmmSi7EWNONigtQmlwJrTd?=
 =?us-ascii?Q?H4galahnj82XhJOF3sm5QulOY+749R7YsqtXY/p/Ylil9wclAqhj5mJNNpAn?=
 =?us-ascii?Q?yWmS2QdcYi5ehQyQTAQAfLjV4R4jnilAkB+wp4Cnw33S9wHs5I8HDk7YVosv?=
 =?us-ascii?Q?OyQYWq5iBWhQQG++R0rw3N9U0wwqLe5L8VHFbxXIdam590ImJHAK2BFxi3XG?=
 =?us-ascii?Q?NizyznxMTzz0c+sSamvdcUI/3qIiMXbFZZqMwNturP7Z6tvhYA1l3dRTHZj5?=
 =?us-ascii?Q?9WAOYZ9irfuarqs/I/8hLsM+5l3EE05OUoqhj/29wHtZx4gQjcK+7vdB0uCI?=
 =?us-ascii?Q?c8tjKo8XdnsRuDTVtI9BKhV02nemR/4ATnGdRJRhQyc4+K9u+APnR7itNrNw?=
 =?us-ascii?Q?g3V6zt0quZ1YEIAEe+Gn8bmc9JVHzbkt7Vg55dQFOv2WJI4+s8FKrKi5Ou8J?=
 =?us-ascii?Q?RKMUPCc2zF2KfrIbnw2ac0e4gIgFBEHR1gA5bW5yG8BLMqzkFdZNHD0eVN+8?=
 =?us-ascii?Q?w8erzddnlM4D2R0qtl+xaEo7AkrA/vfBSY0z5zWM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afcba88-d3ab-47e1-1304-08daf4a86ba3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 14:22:22.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXsS5MxDRDq/0Ydn2J0e+/AsaBpDQpSgcBOsWdgSBxre8FVmvJ6qc3HDZzhUCSlRNTddxEkRhkNcczewW4fMwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are very similar codes in release_compress_blocks() and
reserve_compress_blocks() which is used for data blocks check.

This patch introduces a new helper sanity_check_blocks()
to include those common codes, and used it instead for cleanup.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f5c1b7814954..0d539155379c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3369,11 +3369,9 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
 	return put_user(blocks, (u64 __user *)arg);
 }
 
-static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+static int sanity_check_blocks(struct dnode_of_data *dn, pgoff_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	unsigned int released_blocks = 0;
-	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
 	int i;
 
@@ -3390,6 +3388,21 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 	}
 
+	return 0;
+}
+
+static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int released_blocks = 0;
+	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+	block_t blkaddr;
+	int i, rc;
+
+	rc = sanity_check_blocks(dn, count);
+	if (rc)
+		return rc;
+
 	while (count) {
 		int compr_blocks = 0;
 
@@ -3539,20 +3552,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 	unsigned int reserved_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
-	int i;
+	int i, rc;
 
-	for (i = 0; i < count; i++) {
-		blkaddr = data_blkaddr(dn->inode, dn->node_page,
-						dn->ofs_in_node + i);
-
-		if (!__is_valid_data_blkaddr(blkaddr))
-			continue;
-		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
-					DATA_GENERIC_ENHANCE))) {
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
-			return -EFSCORRUPTED;
-		}
-	}
+	rc = sanity_check_blocks(dn, count);
+	if (rc)
+		return rc;
 
 	while (count) {
 		int compr_blocks = 0;
-- 
2.25.1

