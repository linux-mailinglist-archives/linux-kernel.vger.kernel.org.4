Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDD63FFAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiLBE7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiLBE64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B19DA207
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:58:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQYIGbmU38ld0u/zL+fHsEOz4ACdSMlARtgFCsz3Jq1VICXwlyE+9O6FE7ij61thkK8kLEfjfSXGdkvye9ljeE86q27XAFBsduukwu08TDDWyWwZspVDsNKC76Gr6AxwvwUVamSd/Q7jZFE3TLhbaqqx3zncHZxptdOIEj8uYGlYERlpS11ZqiqUPeQj6wli6ee1+yMLWmy6AErgVzBHBZZmxlZcRFTn4AO1C4GpyP6ZIAjAzpY86BLoqUkv69G0k4zKewIOBuam5Z7eda+ull6+EeSEupgSEQFLjFRF6SUsvWYBt1CD+DGo7AMwSjWcwSQQ9rCxK5hsMA88GF38Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z47m0ybNwf18b/RmNhOwKotYNmUbPXgFB0/nVhF3oEY=;
 b=XfJm18gwm6YZ5oxhZNuIPU5cwJetwQslAyS0CHYDCsLBc5hOhudcAimLF1nTYI7ct1dP3DdO2DNGprqnUDUsqJZIyn9J3XVwkJjlbvlhd1rHQu9/YC/P8Eg3o6vMCvbUL7bk52nA/mBOyZW/PBZd7FhTe8qs/zzdAnxoEf8iXvHOsjWLqo2hM8NihLpWgMx90mqQsR9aRyppXv5IUI1Th34BytqHIu9qx/V1Z4rM8fsO2se7pzhTiyDMCIl3C/cgz4PYNPoECtusz3EQ01gzAYbkwbrssO2oa5UryKDPpW5d8a1YbZelcyTdO65eXb0ojEe36/MfiH6bgkGgwO1L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z47m0ybNwf18b/RmNhOwKotYNmUbPXgFB0/nVhF3oEY=;
 b=GIJxTc0Qm2YIyZFLu28y3F3UrRbHjAngoaWsQkva9xWDd5qCDIZOov+IFzAchLm+mEVHHNkD2dL+OW1yGgrM6ueJq5c4hAkXkISUcGTWtSHYQb+HNyA4bB+7V8KWY4pXJ9H+zkU2fXKzbZZgAfc7+poU80+h4A98pFtTscOykSYcv16JBnMj/90mTFdvGvTQUAqTUQr8Cq+AnPh/3C19ImgKOTP95sPiAgV8fZg7pokbTAB4fTz5UctgE9GIIvfH9CYTzqKwZHeb/lHqG4zapLdaYHQyTNakQAWxAbKFi0lfd260wn7HTRaFcPQcbCtDbRX7eQ65DIWc098vuZB4dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4462.apcprd06.prod.outlook.com (2603:1096:400:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 04:58:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 04:58:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when discard_cmd_cnt is 0 in f2fs_put_super()
Date:   Fri,  2 Dec 2022 12:58:41 +0800
Message-Id: <20221202045841.9888-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: e73fb099-e42e-48e5-5db7-08dad421e868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecLpyN97y/xFdIEDjneR7mteYercXaXiC6szm45QGvUlzPH5agWm/3i0v+/EkzWe+Q3KBxYjNt8uW6Mwm/8cYjjccWnm9+W5/jjvfDMATyh642HBUR0nqKp6LbwISXoVdHqaEbIj139M+wf2BKK3vtOZ/MhUx4y5M8XpPJHGnNLt9Jaiufgi0EUCMX8tpiIHguG0ZZcfjOkEv7KuNQ3HD1gQXshfZsXXemLj39O3mVIm5YPjr0hIk65Niog78Ari7Qky9pULA+JT2pekfMNEzyhMccR9RDErg/GpiHIeQZlMDim3ytVPL8CIY0a7htQX6UWAD7bm5qyXX15GOvFh99g2pyM7bStyx4xYUgzI2qn7k74fG6ZdCHWh4R2U9fQrx4DekMIXyD1t9Xkz6+FSybC3wbx6/CLJncIETWCC23mdoYvys2wjelQsgjeRpqRBAefOfP5jARbyTusFAiBKMpwMP5OL5iP1mtaIiCKjzj12rqY2x7S4clmGH7/X3WkxP9uEQ1c75fIcHhJs05J/fRr8flcCPzcBCy88YmRfycZCtxGphbMUWuaSBwak/xaL5COhvc0piyAgGEw8/G3yTDVn4J6FckjYvb3Nb3yuqdqTwbAyto39TP/7TLx201SF4OggQ5TN3wK5qttbYc9AcXhXrzGlQRExPStqHSlajvfnRW9dOTDRJe8+7PzV4mMH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(376002)(366004)(396003)(346002)(451199015)(2906002)(316002)(66476007)(8676002)(8936002)(41300700001)(5660300002)(66946007)(66556008)(4326008)(83380400001)(6666004)(2616005)(38100700002)(52116002)(86362001)(186003)(1076003)(26005)(6512007)(38350700002)(478600001)(36756003)(54906003)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UntMt2PQpnMrLGb/swUfmTcgyzDpQCDrdlh7SslTWtvaWNCzsXc4pfwsHFnn?=
 =?us-ascii?Q?eySswJRzsRqR3ctS+k1sf65GYPHQEUfnVadMFGwHKr2kDbibUBviU2IBZjuT?=
 =?us-ascii?Q?vJG3DhwbaokmXSR1XPTUKBWHVq1fnMTsIwQY4tXWZwuweloRqskn1Y+bqc0s?=
 =?us-ascii?Q?EggmcIAUA+jnFLUdIMM/RhFWmaiQb2vggSaV9B13A6BNXiZ7fjZYgLBiJcAy?=
 =?us-ascii?Q?B1RwqWewx54f2KF+GZlu8wSA56Fd/m8ls1B+f1Ib9dQpN3I9eSv8IfhSCEMj?=
 =?us-ascii?Q?wmhsya6IuvQ/3o+ANYWj8PD0m+3eDDk2i74Z8DbWn9eUYzGYqgFiZrotvYCG?=
 =?us-ascii?Q?y1bYGX0UTFoCQwgoHpHBhxYsI4mU/I8kUVsPUVd1H869KTJU/FMurm5AaCZj?=
 =?us-ascii?Q?FDGuosWCVixdnICcdmIXmuEHNkfvHU9M1JI7q2aJYC/sIubceSAVjO1tv0AG?=
 =?us-ascii?Q?71dX0cDG9tB0n1hRJqG0LAHxBfN5SC3q/5B87T3yr78e0nqm54cJhsdERdvg?=
 =?us-ascii?Q?VrG5ClyEudT8FQoj7jopT+fGRE6ZqVXj1Fk+JyJe9VvgidNoz0CCdR4IvZ6+?=
 =?us-ascii?Q?B1X737wXZOdNN9JK77t+EnKyS24M9PyrZHIntOmHkJCGx/x55Q56GkViVTg5?=
 =?us-ascii?Q?u6/PoUQx0dUykSlfYp+RkXvHEfLMgtD/rpJgAi2BX7tgu4F4DA8k5IfcDaNv?=
 =?us-ascii?Q?wj8Up/nWxEfJG2Ab0LV0AruiNluP6Cs/Eobanku4PdI/k8bxax/hZz5w+Cr5?=
 =?us-ascii?Q?cGs215llL9EWPoUZbP+15e5ov+VejEubGQVu8udxBowCxC4aulLnFa9KNUOU?=
 =?us-ascii?Q?BVZ2ELzKHbLCkhd2Emh80YwyK84xE0sdconUL+sYZwmE83AGOBrDpviaGJgQ?=
 =?us-ascii?Q?SFipe3d5yAhjfabBGAJsXWx4engQ6cgBL7zLUnXxuMjs0drU0RjFd+NKZVjy?=
 =?us-ascii?Q?sGVEF2jpWT0OOYRY5dxPf0mlOlcW/rQezVyG+jum01OBYwiEzmmgWgqXXroN?=
 =?us-ascii?Q?zLwPpOz3i5MHOkiY86IjoVPsnOiL5OHX+nqXZ9PEu4j+WFvtXDaxxhOogwLb?=
 =?us-ascii?Q?O8ibBTysTGa305s+hwnxpSpMD5G0ERjCcrGCXtl5htTRAX838S/W1WUCgls4?=
 =?us-ascii?Q?aq6+ZZycloWOpskF2gXrGN6mhFuXuOOmOr78IwnTe1Ys5T0OzI7xneaFDDt6?=
 =?us-ascii?Q?aSkonY1Q2DZKkcuglianvNTUREcgnDO6AAGhJ+FwlmtGqE4rc0m0fIpjC7EJ?=
 =?us-ascii?Q?IJoEZ6U3sXwhFp2Pxv4EJq1MUDrJuSD3ssbqd+p6XfmcJbrVhfwBsyqOVs27?=
 =?us-ascii?Q?q81izYxJNGktwjVB3a8oKXUZ92+RytF0p5f1LFGxsjrxPMemgo5KXi1dftCY?=
 =?us-ascii?Q?5sJxhEaXL7EDs40hBWLERSC1LQguRLdaoxbneOwWwYE3am/yioSIRQZQIFDF?=
 =?us-ascii?Q?EA+ZSKQiDUbyFNdKPhBj/NXZhByZjjWlkXVwEtFq/THmED4WR/3GdtaC9jvC?=
 =?us-ascii?Q?6HrvvrCjxaTG72B9BEJnoPqWzt7fuxqsEp2Ct89gf6ow3tQtyWpN0pAzDKSH?=
 =?us-ascii?Q?loifbJOuXpEIjp8iCufi+pWlCxDIyEJMc9H8YpXb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73fb099-e42e-48e5-5db7-08dad421e868
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 04:58:52.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyLxKyyoQn4BSbUG52srAb+XNqYqQf7WQ1EXRuVM0xWaMtQXnsVW0WzURgDLghITLQFI6Zk6v8mYDUdXrSjUIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to call f2fs_issue_discard_timeout() in f2fs_put_super,
when no discard command requires issue. Since the caller of
f2fs_issue_discard_timeout() usually judges the number of discard
commands before using it. Let's move this logic to
f2fs_issue_discard_timeout().

By the way, use f2fs_realtime_discard_enable to simplify the code.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 6 ++++--
 fs/f2fs/super.c   | 8 ++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9486ca49ecb1..d5f150a08285 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1655,6 +1655,9 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 	struct discard_policy dpolicy;
 	bool dropped;
 
+	if (!atomic_read(&dcc->discard_cmd_cnt))
+		return false;
+
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
 					dcc->discard_granularity);
 	__issue_discard_cmd(sbi, &dpolicy);
@@ -2110,8 +2113,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	 * Recovery can cache discard commands, so in error path of
 	 * fill_super(), it needs to give a chance to handle them.
 	 */
-	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
-		f2fs_issue_discard_timeout(sbi);
+	f2fs_issue_discard_timeout(sbi);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 79bf1faf4161..aa1cadfd34a5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1576,8 +1576,7 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	dropped = f2fs_issue_discard_timeout(sbi);
 
-	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
-					!sbi->discard_blks && !dropped) {
+	if (f2fs_realtime_discard_enable(sbi) && !sbi->discard_blks && !dropped) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
@@ -2225,7 +2224,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool no_discard = !test_opt(sbi, DISCARD);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
 	bool block_unit_discard = f2fs_block_unit_discard(sbi);
-	struct discard_cmd_control *dcc;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -2406,10 +2404,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_flush;
 			need_stop_discard = true;
 		} else {
-			dcc = SM_I(sbi)->dcc_info;
 			f2fs_stop_discard_thread(sbi);
-			if (atomic_read(&dcc->discard_cmd_cnt))
-				f2fs_issue_discard_timeout(sbi);
+			f2fs_issue_discard_timeout(sbi);
 			need_restart_discard = true;
 		}
 	}
-- 
2.25.1

