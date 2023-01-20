Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAC675603
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjATNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjATNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:40:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880437DFBD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:40:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO2P5MaRaElfGvxtu6946t3E2PFisdEn5ym408QngP9qKXxQHdk1IWXqD2N7KWtnorsXqzmXuThWVIPsB9eeBu7OS0s/f+jPhxsX3VbZqMGymyt2Vmm3bl8meoybg9/KaqCsna2pNIFIt5h4wWZL6+pd2Szi2f9RUun9WQqJ7B683t6oIOPlmQYtJUbWD3qu9kLgW0eNJcIQpOYhXOZNqVgFHREUhLTYgqb6My8nrlUiuIT9+xGd9YoSZNkvz7sUYP4mTs4uO1xyU+b6DszXd+srifafSM4juokX1YvnorrSBfRZXR9LZiqzf8I4XayxdFzD2YQu6PkmCi8b3rq3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU1ycY7GCmUeqhh20nXHtH1ShX3OQjcr+pnw1xwkW1s=;
 b=bcLpem5r29M58MEsfZ3cwTmk2vZ8VKN7o0GveGEZJa6jkaiMMV7KNp/E/GaaikLydAt+uLk/Qglk/iGiI4ZJiIJ0+TdyGqOtZuQumjnzXxjFXs6IzKoIHUCo8QVUBC5jtIQoEULEy1Nfqk6sEPZXKpyaKXzMa7i5kHzyf8TsvcqZckWReGpz+4UR90CPZCKPwsBE5Y2wUxyNWkX07X35P3p6JsKJczRH89xU+aMJXAI84KfLYlfWEhnG4WyAl98WnBBZdY+TH1qrQD2fD6HxT/7DyvgiktJJRPwJJRSRg6u5XlWRiTer79ika67bRhGJRuDqeqv8/0Wtmn0rlHHXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1ycY7GCmUeqhh20nXHtH1ShX3OQjcr+pnw1xwkW1s=;
 b=b27vdpUFuztfGG43Fb25p1LuZi+peu6h69Uz+nmsAGUPpjgI4eJtG3yifu4hf7HscR1o3u6CJz9IBWltry8UAMfMNwzQUgKhNKyjwKa+Ci54TANGF8sDGS1hi3s6BRnGjQemklzhRONF5AMvjJW9OYG65/xHyhXI0T8YjuW+tI/e4ieCEiq8c8A0KG5fCEAtrES2mW1gNdZtYNbJwxuWFARBQeEK1PImzX6pmq5R4qdR0vHuPIOFUCq3O7qeyAFcKfJVQV2p88Ek6Rh8vGABM6dJB1OBt0VB3PpDV9+pcIVIzZVkWHJ3oQbKgP+oIPzaqaLPRapyzJ3ktbb2yTyrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5127.apcprd06.prod.outlook.com (2603:1096:400:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 13:40:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Fri, 20 Jan 2023
 13:40:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/4] f2fs: fix to set ipu policy
Date:   Fri, 20 Jan 2023 21:40:26 +0800
Message-Id: <20230120134029.69200-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfd678e-4f62-4000-a676-08dafaebf0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEPvmUuDh777qxZNYL34+3UhLk6j4CCWydtZhmrmQoDHt7xDY8mK2JNOs3KJnCs53G1waUq/1xX+4w/IevkVi7CSc1V469XVube58PBrG3EzRkCT+SL0oZAgYl4SMr8wPaBbNASQ5eeL926iQX8ILfbAK23FOxIVME0xeJmMRmU8VZ1yoXPA49aWVIvYAK/ReGJ3dHfufap/c7RXcMay1mKXBbiX6EqqxS4Zbm+0qSfRzAcHcJQHIrUsYpwAiqiR7qv/9a9G/hWk1hlwA8i+Jxzt7N8Eapg65yBbIzwiXlKg+7t11qFNeaA6n3EP5v9/yYtJyE9arrA+4zbVZAIzMySx9MKNF1Lz//V1T9rwh35Q7kr8DP80Bj2gw8BkXi2HrwI0aYHrxf6eQkkVo2vdlBnpTteu6x06qyKda4AJluBzp8Kz3yIq10xYqm1tPuGmktf8UDHu93S8rmRFMgzlcyG69FY0KixoiMxoi/xMOlh9NtPvkwHWKL+CRpebV+oxhNoSxKkL2ed5s6gshoCczf2sjNJiLh2C+y6SWuJL2Dn8P8GX7wl6EfHTVuQGYL2CIxGnv+oYHTMtepilDJLWNIFW4AastTt7Oflci3luKjUWqls0suWGxGf7aIcWGgP48Hxi96dLwnbpIQKJiqvf1mtfTlI55x974/722QJvr1kP3x9UY7z3Gt6d8Yt8CrgeoaqhHxI5PZHTLdX1o+8TWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(316002)(38350700002)(6506007)(38100700002)(66556008)(66476007)(66946007)(6666004)(107886003)(2906002)(1076003)(2616005)(4326008)(26005)(52116002)(478600001)(8676002)(8936002)(186003)(6512007)(5660300002)(83380400001)(36756003)(41300700001)(86362001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuuHN6IpVIvKaQ8SynbOuWqztiKXEDlA6UIHK0sJGCVwfeODxr4arARB4V6Z?=
 =?us-ascii?Q?1nM4Vu9e1VVX9TTXIgdfSeyBrnp7wn2Lvl4nEV3ORkTDguOKgDLB44AjHTKX?=
 =?us-ascii?Q?tRP3To3oHTKkJDertiBRf6cVn+LLPzQc5+RKFfsX9hKyk1hkpXJK3IqbnzQw?=
 =?us-ascii?Q?BDHpr733Ses7/dwEiaAS43PVFLK/mHQlssQFNCMw4AvHjkzNi1Mt8dj4/6TZ?=
 =?us-ascii?Q?IWoX+YaKKlkV2l2JwZYLOn8LlFcvgQjhqWL+WWBBlSpdtIRHV4rN25ZfG6pY?=
 =?us-ascii?Q?Q5pCvhQb7G5UdN4SSSpGBGRgHkQfALclz6I8avIffXdrcB0BYFWtHfN+EHOU?=
 =?us-ascii?Q?LdpR4MBaMx5l+cJ9HqY2ofZ2MYwZECW443tsxo3S0XLSoKduQdxUdrizi646?=
 =?us-ascii?Q?zCuqUFpjArcUdwyKqtlcY98GZ0fphjyotKCFd0+ZX2Fv23ZVfhIfwNue0tVL?=
 =?us-ascii?Q?+vxbcFHJ6CimrkQfHy5+VsEtvaNzVqxcYcRcVxcukVjGD1FYLRcAKaMWzTI+?=
 =?us-ascii?Q?9vspyOAoQTGyZ9YfmmAKPl5OTfXf6lI6bt1JrkVn0eDXSpJjNJe5+O0AnlpX?=
 =?us-ascii?Q?VH6QDwQXWpNcZkjJ1xrbogHASglL2ucpEwifPbswu5yUfVcFkTjU1zaQGWov?=
 =?us-ascii?Q?JADeXIPVjX9r+nA8fnKIqvJyEirEMIpsk3xN/j8ZAAUmsumO+K7eXltmNQhi?=
 =?us-ascii?Q?N3gnih9dpi8tcNjuv749h/YmxiTR1Six8KtUI/+/wN5fO9sji9jy5ll1niaX?=
 =?us-ascii?Q?eDs3LrJtRHP0enCEnnzfLlT9nLNIIwkCnZvpSA9yk72zNVqSJ4PpU0zJDnzS?=
 =?us-ascii?Q?NS9ODyqe0QyB6xsBvzTWXqZXBwyaDNEmKxXn1EYjl1Iu/7oOmkWfk69fFO4E?=
 =?us-ascii?Q?MKT1En+A4qIAkRlEBs2dZ1F8Ux7o405cYqJAYCLs6kFvaReb3fFWwfASRP3F?=
 =?us-ascii?Q?v9asSjxtOctcSXsVHW5y5BCllifTxUcQarIPf8ylCwVkMp8849RZ7T5z9jvW?=
 =?us-ascii?Q?joZ8VXMRBqviE9e0s5j9CnBgHk5yEnrQRI7QSYLBMNXpKjEifLk5ofo6Ht9U?=
 =?us-ascii?Q?0LAC2vj/OI7YLiV46LdbPqnNWpoFyupmkSDak4OAKI42t6uT4QQaTMl2KAWr?=
 =?us-ascii?Q?osCINj2jk54kPjqxnpUgBfNk6V2Up6875245bu/yb3p7/b0uetX0o8h6haaX?=
 =?us-ascii?Q?rgryGm8dM/ax7Spei39ndGAbT5Tijc4lCq6D+tLaJsXvbyn1sQJr8GxQHv+W?=
 =?us-ascii?Q?3yeIdh9jlPJzr8ta3KVa+wRRbrI9hPSX7OuUAHatcg4orpIAiI5quvqWWUwa?=
 =?us-ascii?Q?+AeHBoICSwHjeb02aPPnx3N2XqSPcCTuyZXecYMZgEtEWn2Df4U7BFjQ4tDf?=
 =?us-ascii?Q?zzTIhGpFqkb9v5cv1OB4HfIniNhXGK3bgsgxtOSnQ9XucCBtrLCjrInapUK4?=
 =?us-ascii?Q?w4lACZG92J6GvFdf6id+BQbYxdR9vtg5/sb6Pe6IY/96hWPaNFfpbcT0O/M8?=
 =?us-ascii?Q?PiW/009soLrpG3OeJ5HrxjyMvLOgHUzTSmdSurmwnBfLQJ2z22HQHgI2hRCt?=
 =?us-ascii?Q?5V2mh8DRx6ptWS/JS9ypv2L1E+lRFYTBO9u8Yunm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfd678e-4f62-4000-a676-08dafaebf0ef
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 13:40:49.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmAQt5s2l/zxaNKLCip/goliOWp3dyOpbVMc58XMMT+NjO1dYBgWke/Mc/XPwip+2BFXUpUs/xLxtN9k7CTyBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LFS mode, it should update outplace and no need inplace update.
When using LFS mode for small-volume devices, IPU will not be used,
and the OPU writing method is actually used, but F2FS_IPU_FORCE can
be read from the ipu_policy node, which is different from the actual
situation. And after remount, ipu should be disabled when convert to
lfs mode, let's fix it.

commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
warning") increased the limit to 100 columns. BTW modify some unnecessary
newlines.

Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.h |  2 ++
 fs/f2fs/super.c   | 20 +++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ad6a9c19f46a..0b0eb8f03cba 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -670,6 +670,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
 
+#define F2FS_IPU_DISABLE	0
+
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d8a65645ee48..ebc76683f05d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2272,6 +2272,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
+		SM_I(sbi)->ipu_policy = F2FS_IPU_DISABLE;
+
 	/*
 	 * Previous and new state of filesystem is RO,
 	 * so skip checking GC and FLUSH_MERGE conditions.
@@ -4080,10 +4083,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 	/* adjust parameters according to the volume size */
 	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			SM_I(sbi)->dcc_info->discard_granularity =
-						MIN_DISCARD_GRANULARITY;
-		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
-					BIT(F2FS_IPU_HONOR_OPU_WRITE);
+			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
+		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS)
+			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
 	}
 
 	sbi->readdir_ra = true;
@@ -4310,9 +4312,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			test_opt(sbi, MERGE_CHECKPOINT)) {
 		err = f2fs_start_ckpt_thread(sbi);
 		if (err) {
-			f2fs_err(sbi,
-			    "Failed to start F2FS issue_checkpoint_thread (%d)",
-			    err);
+			f2fs_err(sbi, "Failed to start F2FS issue_checkpoint_thread (%d)", err);
 			goto stop_ckpt_thread;
 		}
 	}
@@ -4320,14 +4320,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* setup f2fs internal modules */
 	err = f2fs_build_segment_manager(sbi);
 	if (err) {
-		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
-			 err);
+		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)", err);
 		goto free_sm;
 	}
 	err = f2fs_build_node_manager(sbi);
 	if (err) {
-		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
-			 err);
+		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)", err);
 		goto free_nm;
 	}
 
-- 
2.25.1

