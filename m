Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31266DB34
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjAQKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjAQKbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:31:03 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C957298
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:30:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzTDMHtcGqG1eVZBoidOVKHoiNvwSfZnfb2/sQp93Rq+0uQhjKZJ49VdwDxGL4EGrO/VkG7N2kzQca+aNyWAqoWiHGg1fQmKP3izPKyvVNjhjjS2Zt1+SPZgt3W3kOLm3oKpBoDhLvh1Qrca2UctYc9TIzz8FpinqVY6seFAFzwGBZOXd5qp6y8ShytF+0wkxMxezH+8n9X9xtWXUdjHNn3jurfU9vURShKivDMfEZqhboutzsJzUiSwaVE09kQAx4EdHDap0kYBFibK7XwpyhDOT1dAHqJYJqY/fMANta/xL3cOJ4S/UYyS/W+oV+DRgwURG5kAgJpzN5Q2cURTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xl2A1hT7mb5Bj9AkO9Ap/vQVKaTsu2J2jzKIX7YnJQ=;
 b=FJ3Hw0/5tZXx3NRLSYiv2THsMnuybJdbD+hmNmVSIGhhNvEFew7GypcM/XncadfTo3cnRvuKZZOnDU4Hq2Y+aD2vQXNeYGxY9waoQxKTkOmmmrLY3+I/6ifmq9fyRAshcZqxVdSzf5PYF+S8IaAo2UxHTh5Du+2FkNWE/6PPGTvXdoVBLAY+19dr/4qCSi8MSidNjvnHKagV8RbWBeEB30bKCjN9edhaKPFp4DdmwKgF27ig2ozD6HLFZFh++x4IBhXLhpVl6xzYP76SJ9Gh5t//KUSjP6hD8F7WzTCT4v6B/ttULh4+f9sLq7GQ88WDpkOvtAPbRpESBkdUoeWtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xl2A1hT7mb5Bj9AkO9Ap/vQVKaTsu2J2jzKIX7YnJQ=;
 b=mBjw5KEK3qT0M+5H5ymkyiXOdGK81cfavK28QOupicBWU9ZtuKog0jAMhy21dNRSF474QVHmbModBTtCr2N5zeG9l4g6z1ceRKrmOBiFe5eHjMTEla4uuOBnT1PUTItHey5xpgPYNGDdl9TpmN/u6pcsusdDy1i5XnfqUmdzet6iGOu/2J7NEzQLK1pdE3VWJkhyNWRkqLTLE0jVhxkfjZV3gS+3BC0hBQnHIjCldAEQTMGdDvCBoTN6OUd5nXmSljikDl4CByCgTO67UVoIV1wKMXlmjyD3DP/h6USt8TZpzbzCusL1Gl9ExPS5kZdexAYSRvBd3X1GAN8wLHW6Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6070.apcprd06.prod.outlook.com (2603:1096:820:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 10:30:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 10:30:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: set *_data_age_threshold according to user_block_count
Date:   Tue, 17 Jan 2023 18:30:42 +0800
Message-Id: <20230117103042.2509-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a534d76-4c36-4170-f19a-08daf875e853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzsGntapHpXAq4FBJn8yEb6/kbJ59E6LYr4QGu5xnGGGi3F6V584WTFJSTlE+EChcMEmGnI6n4lNLbJLqzWALMETw+TSkLB6LW7RpxHby2X6fjUGtGSavJe9Azw7ymcCr32rg36EKu+QAUF2Ms8oK++K0WflQCBDYyAOA+vGUd2J9cigxbqRqVKsnVMMa+ApZDB5Xbbncavj84jw4i3db5xyihZFUI5+gg3RD7fUEhhK3wssLvjVOFwdDM5iOMOuraK5qqOnp6SrMqMQ10Y5Rcuj9RQ5KChnjq76qxqPpO/Dtpc0gckCG+eXNG336g8u9t4TfCMwx/SaHNxu98E+KXg0+2N2EhHtYUTffnrP3/H+Xrnl1MKHQ0U9vlcNW4heNM8+dFte4Bm2d9ImNF1VrXWiIoFWVlHsTgjHRpiiCBsPIBjeJTmUZj8ffmsFOiYC/acXF58ewYT2JcR2iEEinv6fbLyALqRkWmP5Bx/dVre7iaCf6t6eWmS55f1m5UgEArm2DU2Cs6NVokLop87bArQTozXPzRjq1fecQJr19rVBltimwcEI6Ypv7mtQf7pwSmtI6vo3q4o7khJ7ZwsLKZs1JmZkpv6IUkdoRGYiTjuTXn0yY16Z1ZKALuZZILeP9XTtY5LEP3PjVYSUzAuSMl4zXAuudkAoGBWOC703oGBX77/qBdBOm64EN8lYUwN9VNSTi64g9BsbEDnetQkXRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(83380400001)(6486002)(6512007)(52116002)(36756003)(478600001)(186003)(38100700002)(38350700002)(2616005)(1076003)(86362001)(41300700001)(2906002)(107886003)(26005)(6506007)(6666004)(66556008)(8936002)(8676002)(66946007)(66476007)(4326008)(316002)(5660300002)(19627235002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+Vx+eOjZDA3X7P1mmrb+o9VSpx0plETpPvrDpxThOKVJOhortJiRb/CYyvh?=
 =?us-ascii?Q?CMuJy1HIp2naqMRW//i13WMu3IfNa6BN8nzt4C12dV7WGIvIlrjvp3u3yJ++?=
 =?us-ascii?Q?F11MthBO0oPURJv+mLSeZOyUC6VRydaFfx23cKLlE8rCv5fypk3wNpQHujr+?=
 =?us-ascii?Q?rk3kg/nrwdELo+YvTKRH/1p891OHWa8Ai7ZV5nlpL3X3qu51IXgp+CJdtK+o?=
 =?us-ascii?Q?sJgqVfp2gAkqslV6+QL9nzZUVD5Dl0YUWPCOajWQxdA3Mj5wpTNnDP8/KELY?=
 =?us-ascii?Q?8gJZn+mciVjpfQ1ZDEpW4SEHcEz62WmWPVJ1uqE5fFcvw8bjl2CZOmtGCsB/?=
 =?us-ascii?Q?s5bfOnS4nP16Z41AtirqBq7taIYDgT9I/1No2zYj3KXX+xNvCzwUYQ3wCkU5?=
 =?us-ascii?Q?FLWfW1nff7JIk2cCIpSjVBse3dxUpg/h4iYyVx9NY420A1oX2F+lGSgT/k1D?=
 =?us-ascii?Q?OjG8YpNie+J1/Z/XI+h7fXbDNnFbHID5pZgHDkqSLIo6fbXR6eFE2s6yw1xu?=
 =?us-ascii?Q?5p9uCdVn+rSozTiWbaY6hGU1gdiRioiQkYJJr09c4Di5JlRtA/siKR2SFn4o?=
 =?us-ascii?Q?SCfN4tmZuBZkqBMR3KkMCkgjqrSYvJOQ9s8N/n5m67VT8zjBfkSEKrnc5hzP?=
 =?us-ascii?Q?wqblmyhLAFRxkS9VGnvhoBkS4RVBOceETNnWSr2Raxb6m9QXuCgAs180oRPO?=
 =?us-ascii?Q?NOYwmg1PoOyyiVA113bcg1Nf1O1pBv+SbJIGLeygNvmXnCaOtueijTyjozWj?=
 =?us-ascii?Q?ta6JPKVHKGaHxWnSFtt7ecV3JO1LSS/2nnfcqsK2xtHousy08e9Bwe9fKVZW?=
 =?us-ascii?Q?ZyPR4RFHcz+TtGByZ22YRKGlAORDHrdv4zzqzfe2TegVXXDbiurkT/NJAnve?=
 =?us-ascii?Q?1Sx0YMm2m+ChHsU4F1DFBI+AFBYWgLXrkb/RA5T9/Al2XrgDeDMJMQSWlkE+?=
 =?us-ascii?Q?gvNhigf3HMY9c7qDkr4dYW2bHUgSrRtgRffkRAGtPAFnqIfFBxO0NFnwx121?=
 =?us-ascii?Q?OdtJQY36ROSHohH9EgJeXAsbPeHVu37AHuRIQ/wQlApwK394Ad9qKnrKTbPD?=
 =?us-ascii?Q?j0j1O2OMucLrilGyzcahFENYxlTNrAvlzMg9XKZ45P0W+j2xz8fU/jJZWiLW?=
 =?us-ascii?Q?eD6t8LgQ+IjCn/OVv2Rviy9rFxgBMt7Y3DGiVjeeIjKfRrwg61xHRbj+lP9h?=
 =?us-ascii?Q?QweSbRyfAsoupIQ4nBCnqJqByHMTfMCpQU7ARWDzdNY2tlGplj+jnQeDKMdM?=
 =?us-ascii?Q?Zmhgd+dNt/A+Yso9hjvGrwWhrhS/A5pIL1oEcAYofabGfQOOqL9wMR8FMFLH?=
 =?us-ascii?Q?AjrEGbEStGJJshMTBPbJVHmOHRRoF34T2h4TX6Qmilit+Ph+thdyzj5D352x?=
 =?us-ascii?Q?IVKyuWbghedHIc9y4UFMP9eYPX8D5ACUOFhmKAJIWJNRRfEqNCIPRRzsocT2?=
 =?us-ascii?Q?6uoSpCDQoFs8THymlGz2tggG4EdSUbax286j1X/MGTvoUrYn1ouz2NScTU1G?=
 =?us-ascii?Q?1b1kHZc2HorKlKHV0gjz0gAFObASiz93O2C0ymfPRiRDF3qgv4qvpZm5P4zZ?=
 =?us-ascii?Q?Hcog8qgZxNmG206AxJ5I7qtjqfv1HyGxLg1zQG6j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a534d76-4c36-4170-f19a-08daf875e853
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 10:30:52.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZZ/DjQYavl/r3ZlDyG3y0aaM4GqhmNrRUSnd4KzOaqSb3Dt4OksS1Hm/x4C4E/oiFbiY1BC4hCWZrhBRWrmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71644dff4811 ("f2fs: add block_age-based extent cache")
introduce age extent cache, which experimental data is based on
a 128G storage device, and hot and warm data age threshold are
set to 1G and 10G respectively. But it is unreasonable to set
this value to 1G or 10G by default, which varies depending on
the environment. For small storage devices, some storage devices
do not even have 10G.

Let's change hot and warm data age threshold to 1% and 10% of
user_block_count respectively.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++----
 fs/f2fs/extent_cache.c                  | 2 --
 fs/f2fs/f2fs.h                          | 9 +++++----
 fs/f2fs/super.c                         | 2 ++
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 75420c242cc4..c7952f1baf59 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -660,15 +660,13 @@ What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
 Date:		November 2022
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
-		the data blocks as hot. By default it was initialized as 262144 blocks
-		(equals to 1GB).
+		the data blocks as hot. By default it was initialized as 1% of user_block_count.
 
 What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
 Date:		November 2022
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
-		the data blocks as warm. By default it was initialized as 2621440 blocks
-		(equals to 10GB).
+		the data blocks as warm. By default it was initialized as 10% of user_block_count.
 
 What:		/sys/fs/f2fs/<disk>/fault_rate
 Date:		May 2016
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1daf8c88c09b..9c7e304d5660 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -1235,8 +1235,6 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 
 	/* initialize for block age extents */
 	atomic64_set(&sbi->allocated_data_blocks, 0);
-	sbi->hot_data_age_threshold = DEF_HOT_DATA_AGE_THRESHOLD;
-	sbi->warm_data_age_threshold = DEF_WARM_DATA_AGE_THRESHOLD;
 }
 
 int __init f2fs_create_extent_cache(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f3c5f7740c1a..3b853c302a43 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -615,11 +615,12 @@ enum {
 #define SAME_AGE_REGION			1024
 
 /*
- * Define data block with age less than 1GB as hot data
- * define data block with age less than 10GB but more than 1GB as warm data
+ * Define data block with age less than 1% of user_block_count as hot data
+ * Define data block with age less than 10% of user_block_count but more
+ * than 1% of user_block_count as warm data
  */
-#define DEF_HOT_DATA_AGE_THRESHOLD	262144
-#define DEF_WARM_DATA_AGE_THRESHOLD	2621440
+#define DEF_HOT_DATA_AGE_THRESHOLD	1
+#define DEF_WARM_DATA_AGE_THRESHOLD	10
 
 /* extent cache type */
 enum extent_type {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5fc83771042d..8333ea5b8ffd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4088,6 +4088,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 					BIT(F2FS_IPU_HONOR_OPU_WRITE);
 	}
 
+	sbi->hot_data_age_threshold = sbi->user_block_count * DEF_HOT_DATA_AGE_THRESHOLD / 100;
+	sbi->warm_data_age_threshold = sbi->user_block_count * DEF_WARM_DATA_AGE_THRESHOLD / 100;
 	sbi->readdir_ra = true;
 }
 
-- 
2.25.1

