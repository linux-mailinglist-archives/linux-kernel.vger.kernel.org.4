Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B116B0A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCHOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCHOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:07:58 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B35B5EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsqLL0dQeJwOVnBwjP6h8fsFTv4GlCfD0OQQScZ786tBeMY1VlTQybZ39wOXvuvl6Uk1OzE678CDl5xvy5mGY/cR2UdUfhI4A67METtzyZeeyMg5CwjtVzWhWaRYCv/+QLW5zWVt/v47JyaDDx6k/0Axijp/TOdbniWRafR5rjzrAYY+6G54cQk2QBZ0YcZjHGC9QXw6ZB1cxb3xVjNrzXf8I+1C7gpKw7D/aBlgEGOQ/ncxuLsgBM7FMbuc1XlC2yy/GMgFOFEi4GxVlHRaXEL1qJ6C7J9VYfQaBCLrwtLujrjooKs909uqejvhBniIYUvfovDf14siRnaFhpQH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD1P0zCuZE1mOzgafX/9VHR5R5ypvA8ZVLVRhF2+K+c=;
 b=AGK/48C9R4fCGCBfCYk5uoljn/FnKL1u8KaqO4VgJ7ctECidjG7IBE51qzWnE9UHtKzfgUi8igJ1pQ+Bz9zrCESEt1sFVczvvoKw2kZHeu81L0yqZXY2TaMUUWDfR3bleKyxMBsyPiJX+h6xETLfsnQMZDuLIcl4+jFZcwaPC75PdFw/6bTr/pSuD09ZvLB4ovwpNk+j3DLjD++nzpPs80EETY8/hvfki/FdNk2MVyxrqnEqLwYOwtRySoyDOq4rmooAhhfCywFdNNBh9lMZHPjrXgdhgNo7DpVEhd+TxHspWr3WgQXG++havoLMR8snmsn9JbsXVMSXmveQhwjI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD1P0zCuZE1mOzgafX/9VHR5R5ypvA8ZVLVRhF2+K+c=;
 b=U8AgldkVsQ29s2sce4haB0ndpjd3D4etPN/6yr8Z1pX7rh6J2W+csZt1vQy/wJxANwNkPGr4Fa046ZckT1kQjnwCfSthSXUJeG2AT+AI7xJ1S93q3hAmadNKaCtQMQJtdqZ7s/XDmrD+988k6inYPAzwsd6YuQIyKSyXBPFEU6SvUhASM587vobw/5m78sSI3VL6E1/7HL7GAE72LsPgg54fkkyhfnSy85XlA6Hkz4bIZLnC0qWaqWWDs1echaLl7PrYrKqANqugp7XfAshNtGfMmlqAraBji5FuXO7yI/b7jRZGvkwA7aGKOUmIpIFMaA0MpFnvtBD1HTg4Bf/dpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4138.apcprd06.prod.outlook.com (2603:1096:4:ea::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 14:06:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:06:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()
Date:   Wed,  8 Mar 2023 22:06:23 +0800
Message-Id: <20230308140623.35942-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: b97905e0-4d9a-4a0f-e881-08db1fde542e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gq5si4ao64kmI8O+8gcgqJsqhP+aGv4Xt+MZCXxqOOlntlTXJ+OLPltAmjm+Qya4kZL/a7t9frcs+WYRF1Iv5F0H3kYAYjapfltxhac8CHgJEw+rabUYNjVw1ulAWQ96UHzY3FkyVBRuJa6JIMVPNjh+Tzq/C7E+kkSWbQ/C96VTku9NiI9xW+zL0ZtO2iI/2IVFLU8rUsq2BukY/qzfQgsrReMUglIRtwkHsuwp6KyIzavtoxwoZYRpnvQnnA/hyiaAr60JUQypj3SHc9EjEqBSnf1Yw19AsEN/t6fwbDr/YL5MAZw4XsRJO8x2xtcmAHwoCL19Hny3zq6yAJrCW5wwTogR+IGfh4yyStCIjpofsbrXMX+1FgodcwBHYe99NIAMsizWsfB3krfYVj7UgdZ/AHSDxWYesqorgoEGK8xk84eVnwnS2GQROnItQk3/QgJVDVjyqf1MEyrLs2gUjgb00a0XL1C6fgGxKLEev1Hchy3bXFnTTs1dFH7IH9zdNIdZWOXC2C9H9uAviMrsAVcpRigpuOUhvI+x8ERKCO9o8hIRx10y26xP+NmVEPEjkFfEBdU/odXq8OtexwgkBmBxw+x0b8NFtsw7EtrOwihYlxpNzUw/RnKK9ZwzfBWsRg+KZXIrJEtKsV7Lx5iqIhF5LxwE4B8rCRuxiSVdnCJIEEYTEp0kGUDNC6IcGIaHh+NhicMRqbwQRn3klaVFCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(478600001)(5660300002)(186003)(1076003)(107886003)(6512007)(83380400001)(6666004)(6506007)(2616005)(26005)(86362001)(2906002)(36756003)(6486002)(38100700002)(52116002)(316002)(38350700002)(41300700001)(66946007)(66476007)(66556008)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pVsuDP3dbByLpOkksbTQNGiuWmzc4uO6ZUKs8+JYWbvuNlSv+qiLvKV7mScl?=
 =?us-ascii?Q?j8KlEhAS91ZOJMtozIUoNhxa6k5WwaeiZ0q4jN0hBZgWUyqzKLJM+Ln5EThJ?=
 =?us-ascii?Q?561JK1bDVQeYqsbAD0xVSaO7AwcUnmdT6je//dAl2x3xSyabUkIhAHScqgYa?=
 =?us-ascii?Q?v6yXdhETseMnZvhTM/2dEXpqKlifBD8E+UfkR0NnDQRyjed2Wnv2TJVnMLQo?=
 =?us-ascii?Q?VQVK7dUsqaC4uJssqvzMBfnTrRlRQeM8lSsquoJWDikAEWTTYqp2CHo5YmBe?=
 =?us-ascii?Q?Efgc4lF7wFyg+gmGV7Zin3o5JFYXNyuVbDfY3oahF1P+askMyldm0uw5JG/m?=
 =?us-ascii?Q?0mAGQdCeNodLs+kA4F2l+g6tckpaqoahwTfkVtvGrU3cobdKeJDT3dCIzrrY?=
 =?us-ascii?Q?PlEjyJ3uk5NzxA36Id4f+2XR9NA2v5xeu0pKZWrnRQw9Si1D0VQUzgEvQNZW?=
 =?us-ascii?Q?Qdj9xM9mqmVOfipNVcxh3+lMpcC5AsYw6VKz7BFXScmM/uRveIsJTECXNJkM?=
 =?us-ascii?Q?7rPkzQsqQD+0WaR7c/OVxEXp8/tAya3mWibSK3550q32GZfg14zw9QegMkJV?=
 =?us-ascii?Q?vTAKLOkEmDgqCdQCo/JamPcH08fkk0zTUQwYMFyF/8LlW/iz2bcf7+g8de+r?=
 =?us-ascii?Q?idjqic4RKB8eDMe/RKBeOmLKlElf4V6DmuOIq2YaZFPV+oBIshqnGkoX43MC?=
 =?us-ascii?Q?+iKR0oTuNpuI9wss5Me8SrIFXoxsp3ZBO4kyaoDsxlmcSWYEDWXFH1NSalVU?=
 =?us-ascii?Q?K+ify9PzC4mUMOWAzixkJqr1B+HbLpme/MZqV0ekYo2Wkt0ckugm8fSgFOHG?=
 =?us-ascii?Q?TA45k+vjZi8GBEIrNSgD88hAQ1SALBFS1ReXkY6oz0+Jvrb3lLgR1/ZSGHAF?=
 =?us-ascii?Q?LtuJ8LLhbTOWbIp7+9aqK/RfrYDesbGc3ONiGtz0tJffWr+d/4V/p9nQuOyE?=
 =?us-ascii?Q?dPxDDSQ7qj5Iz2qjzgWqihtiZS0Y5yNrXUjx6wJeOL/DhWpcgfSm0j3uqKhF?=
 =?us-ascii?Q?EyTqJWT4eqI4ZO25MkmVd4oScDyKWpONejfpg6gxJO/gZf9qYiZrlt6NZMSX?=
 =?us-ascii?Q?J9JHSzKAqmwQq+Xh22Oaxzkc1rpkbkW90/Je8DwpwL5tiXNcHx584KtCTWHm?=
 =?us-ascii?Q?zjj1qBny/iV3DsIHMeGUB8r1Hm7uf9KwOYJv3THpecIpS5Wvi2UT7OVouGjZ?=
 =?us-ascii?Q?/murTFiGT4/a0VECZWv5nj+XXZ4NOQy54iXxWe3nTO1x39HaD+VevZNhc9Xu?=
 =?us-ascii?Q?0XRv+sSTeHZVdoV+F0bVuR3P0Lz86PjlAKjB/PsIsIHHDE3WQ9UdsUJ99OGV?=
 =?us-ascii?Q?8DzFkiF882Cdckr84m1UGozC2wGoEmX65aFyR2CmnYp2GDXUwA5Vvx/X3VZe?=
 =?us-ascii?Q?fxuOaEVYqAU0iesUiZwdj3QMcsPg9iQ2qo4+6/m+7sulAM5u5+TR5RAyRaVY?=
 =?us-ascii?Q?F45AgJQyAANau1bQi89U30ZzpcT+y4HOGU/7rW0NHe8fKy6xUZ3ZQkICVVVg?=
 =?us-ascii?Q?6Q6vdJyO1LVhf7qjWa95RZTQbOkjc6ZqxmvuhRHsQFQiwROzrYBcLcB1Cr2L?=
 =?us-ascii?Q?jVtfypXVEnJOEivT7UqGf/7ljiotSDPI10bo0ZTR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97905e0-4d9a-4a0f-e881-08db1fde542e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:06:36.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFAwxJx530YHdpJXLiInqIYl0jSzRvarWlBXjG0DZCFR1DHT0dlS3SmA35KQXFTWxCyZmxhnxZ/iim/AbhWpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIW reduce the s_flag array size and make s_flag constant.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-make s_flag constant
 fs/f2fs/debug.c | 36 ++++++++++++++++++------------------
 fs/f2fs/f2fs.h  |  6 +++++-
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 30a77936e3c5..99c7fc832ec7 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -336,22 +336,22 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 #endif
 }
 
-static char *s_flag[] = {
-	[SBI_IS_DIRTY]		= " fs_dirty",
-	[SBI_IS_CLOSE]		= " closing",
-	[SBI_NEED_FSCK]		= " need_fsck",
-	[SBI_POR_DOING]		= " recovering",
-	[SBI_NEED_SB_WRITE]	= " sb_dirty",
-	[SBI_NEED_CP]		= " need_cp",
-	[SBI_IS_SHUTDOWN]	= " shutdown",
-	[SBI_IS_RECOVERED]	= " recovered",
-	[SBI_CP_DISABLED]	= " cp_disabled",
-	[SBI_CP_DISABLED_QUICK]	= " cp_disabled_quick",
-	[SBI_QUOTA_NEED_FLUSH]	= " quota_need_flush",
-	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
-	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
-	[SBI_IS_RESIZEFS]	= " resizefs",
-	[SBI_IS_FREEZING]	= " freezefs",
+static const char *s_flag[MAX_SBI_FLAG] = {
+	[SBI_IS_DIRTY]		= "fs_dirty",
+	[SBI_IS_CLOSE]		= "closing",
+	[SBI_NEED_FSCK]		= "need_fsck",
+	[SBI_POR_DOING]		= "recovering",
+	[SBI_NEED_SB_WRITE]	= "sb_dirty",
+	[SBI_NEED_CP]		= "need_cp",
+	[SBI_IS_SHUTDOWN]	= "shutdown",
+	[SBI_IS_RECOVERED]	= "recovered",
+	[SBI_CP_DISABLED]	= "cp_disabled",
+	[SBI_CP_DISABLED_QUICK]	= "cp_disabled_quick",
+	[SBI_QUOTA_NEED_FLUSH]	= "quota_need_flush",
+	[SBI_QUOTA_SKIP_FLUSH]	= "quota_skip_flush",
+	[SBI_QUOTA_NEED_REPAIR]	= "quota_need_repair",
+	[SBI_IS_RESIZEFS]	= "resizefs",
+	[SBI_IS_FREEZING]	= "freezefs",
 };
 
 static const char *ipu_mode_names[F2FS_IPU_MAX] = {
@@ -384,8 +384,8 @@ static int stat_show(struct seq_file *s, void *v)
 			"Disabled" : (f2fs_cp_error(sbi) ? "Error" : "Good"));
 		if (sbi->s_flag) {
 			seq_puts(s, "[SBI:");
-			for_each_set_bit(j, &sbi->s_flag, 32)
-				seq_puts(s, s_flag[j]);
+			for_each_set_bit(j, &sbi->s_flag, MAX_SBI_FLAG)
+				seq_printf(s, " %s", s_flag[j]);
 			seq_puts(s, "]\n");
 		}
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 199b1ca6b9e4..407cb35ac06f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1293,7 +1293,10 @@ struct f2fs_gc_control {
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
 };
 
-/* For s_flag in struct f2fs_sb_info */
+/*
+ * For s_flag in struct f2fs_sb_info
+ * Modification on enum should be synchronized with s_flag array
+ */
 enum {
 	SBI_IS_DIRTY,				/* dirty flag for checkpoint */
 	SBI_IS_CLOSE,				/* specify unmounting */
@@ -1310,6 +1313,7 @@ enum {
 	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
 	SBI_IS_RESIZEFS,			/* resizefs is in process */
 	SBI_IS_FREEZING,			/* freezefs is in process */
+	MAX_SBI_FLAG,
 };
 
 enum {
-- 
2.25.1

