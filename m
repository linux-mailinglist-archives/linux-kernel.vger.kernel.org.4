Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846963660D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiKWQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiKWQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:44:17 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1965E57
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz0+Z50VsZX5/enrJ6MPrt16FV5htdf6vlOoq6VHdzyiqo6/VOGOnX1Hl9Jc67UtLfSpx/3hyNpfyWCnWthJxp9dgjXQpXCD75TvfFutQcujui6n+cg7xrSqMKJE5xtKu5qcDlLRuSOxtYx5n8NERgvYsIPjLkISe69I0cBgjXj6TjwjjHKfU4SHXsNvha9l8Xl7KZVTudvBFfJ759/xaO0SIn8jhe3PQbEswBb3NXTlHydyijv4t9NEwlKUIw4pdgFtMewsAq+zHQa4FXQjoWVhIhFREJeEoeCK3BCfeUT1O67DQ7CtKIJ6tV7uJ6A+I9A+w+6c6mojXuCtyQtIPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdD87Cty8XzbQIbcEYc4ded00oVaIUFtan27Ztul8r0=;
 b=fbQaGGWQhSDVVLz7WsLbQmhwtyRs2iwc9BX0Iv4lHgLF/V1E07pKF/p5r7+f7MBlGqArDy+o1PNhqDRaH8Bip6VZD7cX5A8HqSvu1Pr7VaB61Z4IMX5bFvWmQfoYrw62WbAK9aa8LaN1xLq0P10NYt7opbWoE/GmY7LxxwCfllh95ILTLetL1VVoSi5Z6A9UXuwiGYeJpgzrilrj03DRiTTLcmZwKRU2VaFS/Ij5kX5+QSH5G9r+Dv8r9s/BjRqCRO/ckIkd2jdeJnUvv0NYs+XjnqomDZQjfJXf7GksTC4Ag+u/zDRJ8wnN83riRRMuUvpNM7tLj9x0T1hIG5x0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdD87Cty8XzbQIbcEYc4ded00oVaIUFtan27Ztul8r0=;
 b=lKCuJNnrFFngBxfjoSlm42aCGTiuAfUxvfa7DRjihaXuAUDFB6ZWUpv6zj/nCACbIhB9qrzUjeP8OE4KNS3vhRLE2H1/d80u2otX3Q+iSTJr044xnnr5QmhcTsYxgyxz7tWYTZJnFd4u5mLQu2Ruqd24esw6Mwlye1hnzHryn59kXxXRnJfppqN4wfRYO6lIOGGSppxv76psFhSpuLQ2m7qrhUDXo7Qb1a0VHcGMck4zDqNgHC81MQDu9fwxe4K1zTgB3U1/YmaWE+apBe78vdKyHuOrGO8+77sQU/3ml/4hu//7iUBzYWtFFbqka7OAG3AjmT0NxDtkRaQ3XJzQlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5950.apcprd06.prod.outlook.com (2603:1096:400:333::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Wed, 23 Nov
 2022 16:44:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 16:44:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 1/2] f2fs: define MIN_DISCARD_GRANULARITY macro
Date:   Thu, 24 Nov 2022 00:44:01 +0800
Message-Id: <20221123164402.13849-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: f74fda78-ac00-4638-16c5-08dacd71f3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjF4iwYER3Y55w4kHZn41d9H3s3opZy+o3H3pNQrZrxRUop+gXCgWXhHhAzFJmJoKQ5eakp/kB+RxElZosRVX3k5+gKlMR22Wzy9+Fk4wHYkq6IexuJuB2NzLpPqto8D5858QfnKlrhGt9DVIs9OupnFniUA3tj0VhAApqTDJn1ATcZhY+xLWhUCEaRYvZL9rHvWLwV88BW0+haKWQyyo2TDwK5a01SrhtSCHge3SJunsxbhkv5fo2byH+Fe9PbiOHMivKLewpERqZ6RaTcgINdnc1oP2TesQTgHJiXp2jN5WpcUrqIqogulHigffijGrHzo4JaEyWoXjWhwBOPVQPjmPaXrjyhGKeeQf/uBW3haMbqHbSsJq3yMCI/43bVMtmlw8AFiPZLQ2M2L9LBIgP/gajVd+pdQBSoPLDnTBsuwfggf1IISQXM/qyMg5QDA5Q2/ljmXza/J8A8WFkFoBBGFWrWfVqXWoFWIjMyIxvCxcCKiQAvDv8IdwGH2+5/e0KliLHyK1c6cev7P9Vv3ry466Gxtjm3jXH0mIaD8Rf7Z7hs1IsWCWzMwQMIkFwHFFVnNXDJAJWnt2uVL1gW9DlfhtAu5DuWyXL0sxQkUNBFjg8yBHsHBgkxvWhjdsYGwXbZqUgZsT9fjRFJNl5SklWZjEDTUB5XnDgeqJ3yx2PjLIAApEPSG3i58sqZDl1NN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(2906002)(83380400001)(6506007)(66476007)(36756003)(66946007)(41300700001)(66556008)(2616005)(1076003)(86362001)(38100700002)(6512007)(52116002)(38350700002)(5660300002)(4326008)(8676002)(186003)(316002)(8936002)(26005)(478600001)(6486002)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrP5FuOsg4qclIGdnEP+zu7aYuac4XMxOI5hGDMYbQiD4p0goqp4oyJ56p3L?=
 =?us-ascii?Q?BAFrvxPCg5PeGwfAmMAStp9tCW9mOBXMSnFNyD5XPQTvXB7JpOYkE/jhXtfX?=
 =?us-ascii?Q?Yvap691MKrEoIDtYfZPr/I56ZRNupHrEQUSAyk+82d7C9L/FdAnOOXcz5oRo?=
 =?us-ascii?Q?RYZzD4xjikuIm/rx6r/ARF8b7BQrmVtiAKgmWauFi5ZBPUmCcVaSzg2/uY4o?=
 =?us-ascii?Q?M4XTUEo4BO8b50lcSB4efKWjRDdroBVHiG7zqqAwrvT3qYqI6HJHcvmLzGqV?=
 =?us-ascii?Q?bO4W83Cze9J52TSb3hduWWsYjBb6FOfazS4ScN7R3CYKMaD0JV7NCJgY+h8b?=
 =?us-ascii?Q?6T53yL0xeaFXs157Xm2oRogzyyHF3j/2QHZHMAX9tqKAXW4KVYedGJP0uRr9?=
 =?us-ascii?Q?LQePCOoVb3ZnHIOXfAeo+UUxPkZOrpWjL33LVihROeFjxM/Q6ERVBj8uEAiO?=
 =?us-ascii?Q?lhtrtzDT7hv4TTkw4YlRu7Vp+4iFOv+mEuTRVxwev1BmDAeIDSIhSWSjuqBb?=
 =?us-ascii?Q?zGy5ibyBVYXXWBV41MkQwNHTC0vxedeAE0SalGVL4eBCVlgCRCm6+RbCRCSD?=
 =?us-ascii?Q?x0s1UNWoC7J389wqsjBmtfDfooF9U/MJpf3o5hOvnWhpV6PrjperCRdMWSK7?=
 =?us-ascii?Q?ryTtMWHkzL0JTbRBXvcEvKXlgFq8NBrz91PFBni3Nyvgq+BFa8jw1NSHpbGn?=
 =?us-ascii?Q?1PWM+oZt2n5s9Fcax17rWYqba5L+0s0WalpH/yQuPCA/+Aq1iBohyhcooqIB?=
 =?us-ascii?Q?+Yx/h/GEfsszui1VeX9IXUO995nOuNcezGGIg6yfJSo4nj9G04Onm6nfLRv4?=
 =?us-ascii?Q?PH7n+N+5SWwd2VdQlwmSUD4p+27lkB2iGrx7FVdvtlYz12cazmv0hOLMfTzB?=
 =?us-ascii?Q?4YZmq8971jl9sFSKzMVL2J8ajruEdaUmufXrlQwQ5UX69Er+S6yCsaO9yHIw?=
 =?us-ascii?Q?0Z6hLSa3ZyS3hFXUc+D/ib0PU65vRvLSAFqvy2fGipAqg8aqHtfBNAHZ+H7U?=
 =?us-ascii?Q?ycfRStrnAEN0YkoSrj3kerNxQB5rcnUMP5HKY+kE0anpJS4ch2jpZxhi7Ct0?=
 =?us-ascii?Q?3KomTCV3eucuzqaVm6EmugPs9SSsP4PdM3c7Z9Tbp1GxzDywN9OLZDf1F4LY?=
 =?us-ascii?Q?5395sslxU8UgZ6xSnMEF561jkMJNNVIwwh1KvVDgGjVwDovE6+O5Wl9zP+q4?=
 =?us-ascii?Q?OcECdp9FppmAmoLbKgd9J/uXjgX64xvwSG6w2jZBq0WZQc3p6Wt0f5pSHpv0?=
 =?us-ascii?Q?j1lcmA/I2kPbmTIYna8zRG9M+ZUKiafWcvwCbhb8uQ0Ql9TMU4kWxBcXen4W?=
 =?us-ascii?Q?YRwjUTfWbR+1jzPVq2Uecnhrd6xyD1sgJCiyThLfA67v0sB3dkX3F6T96ib3?=
 =?us-ascii?Q?lgi2Y2XRuDNIWOhEqeBNfigZTADW7zhXHqbR/tlRDHyUAlY9LZLqI+Umvwp1?=
 =?us-ascii?Q?e/bt4eYMpkQSNRU+3ut4tu7I5wbku0bU68Yg+OOJXU3UYshRmximMS0KU43P?=
 =?us-ascii?Q?e2z1gamLxYJfuH4fldPcQLv2hycs/DH0QzFvOU+KgdAXBpZjNCrlfpTxsdnp?=
 =?us-ascii?Q?8HzkywVPli9q1l06tl0XCrORUjxfUxaCQKQlZ3ns?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74fda78-ac00-4638-16c5-08dacd71f3b3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 16:44:13.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rB0gtQAJ3rMX4+D8vZl9xvpIWmtIajOV4M6TgOto0JhaNhM9oHXWuvho0OiEwLC43NrPaLS8ZGipX35eVKrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5950
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do cleanup in f2fs_tuning_parameters() and __init_discard_policy(),
let's use macro instead of number.

Suggested-by: Chao Yu <chao@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/segment.c | 4 ++--
 fs/f2fs/super.c   | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0833638f59e..4694b55b6df4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -329,6 +329,8 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* minimum discard granularity, unit: block count */
+#define MIN_DISCARD_GRANULARITY		1
 /* default discard granularity of inner discard thread, unit: block count */
 #define DEFAULT_DISCARD_GRANULARITY		16
 /* default maximum discard granularity of ordered discard, unit: block count */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b0b76550578..a993211ded1d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1070,7 +1070,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
 		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
-			dpolicy->granularity = 1;
+			dpolicy->granularity = MIN_DISCARD_GRANULARITY;
 			if (atomic_read(&dcc->discard_cmd_cnt))
 				dpolicy->max_interval =
 					dcc->min_discard_issue_time;
@@ -1085,7 +1085,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	} else if (discard_type == DPOLICY_UMOUNT) {
 		dpolicy->io_aware = false;
 		/* we need to issue all to keep CP_TRIMMED_FLAG */
-		dpolicy->granularity = 1;
+		dpolicy->granularity = MIN_DISCARD_GRANULARITY;
 		dpolicy->timeout = true;
 	}
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31435c8645c8..daf14b55a972 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4080,7 +4080,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	/* adjust parameters according to the volume size */
 	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			SM_I(sbi)->dcc_info->discard_granularity = 1;
+			SM_I(sbi)->dcc_info->discard_granularity =
+						MIN_DISCARD_GRANULARITY;
 		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
-- 
2.25.1

