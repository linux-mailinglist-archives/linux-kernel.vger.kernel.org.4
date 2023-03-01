Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9A6A6F53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCAPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCAPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:51 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F40457F8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8zLObmgndhTUMgt88bDPwqkCAAZ3JZxmLUqosSrRZHatj6Vm/KibYTBMTjr5XsNAGl6oX0IVazUU7SXJsLNvED5Z7o249KxuFOuRQg8sqgXaotl5ST+dgnZXzorkbMD+q106LmvN/nWiIDmHSaXTPttYZojQAicHob2ZFc6MacYza4OyVFFLPUS46Kok2bSgEJSlNxfmhx0qsaEFCQODNNFWL/rsDch9kR8/BzLPVg39bjctltn+ZcdCHYhYPxuVM6LvgxvT4cOJw9BTRlDLBmIRHPd+Nf7Qkjs8kvrdalg9WOGSKX7L9dHUtUESRdunsIszN2c0t8yzZjNg7logQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F10V0uqpXrHxW3jl3+/Zd9UO7+6nVRpVAWXOLjY24/M=;
 b=YE6oyx5YLQLuOFcKf2kmXKF1LcDyHF/QBC5L2RaMrAuWi4FqB8k6HXDdUWOjwGfgcDb7rGw4y1dcqgT/CK3isucDwkSEIS+PrHWSWaqySfTUD3K6cl0s4BkmFjnbm8EBY3XBLW++J2gY7YBeFqfI68tg8/EP6gYbvWDg03u+CvLzlQzvucOR+KUOMdruVFY8xS87ptqIAW0yUUmyjGQ29BbIYetTEmuaFawPLmo5PGKbaRcvBL3MO08FS0QUYluLvW1GHNw0sZJBNdB/CmDBwbGxyh83y/s1qBrWKGOBkyRihqkvKnBzP061ClQEAaiURWC6KADlGA3+1ihAR4lZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F10V0uqpXrHxW3jl3+/Zd9UO7+6nVRpVAWXOLjY24/M=;
 b=DXBFK4jgZmjMgggwYw54wdnupnpSP1dTT/cvIkUeCVlOHmYzB5veiL2DMnKiC23LFKIYr24KBu5CcLb411Mptas+wkGh+gq0E+GIkcHgFR/zj/N2NcdKXylF5E2TkeHwB2AR6Sh1jl/432u9/jl/1vV532Csntca6uutFqGy5+SqtkC8tCFNoMrwWK9TKPBkBlvsAkBGLP+mKiFIXaT3ih7NeSoyRncpaJk1P3pqXmO8gT5VLpLHaNWbCOV1g2X5mnDwF/4vdRnU/Ejlfwbggvx/RThUu+MXA3/r102/pgC2LNn0Gt7KaQqeERUS75IKyXfsCRrVqrn7VXnsmUErCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5890.apcprd06.prod.outlook.com (2603:1096:101:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 1 Mar
 2023 15:22:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6156.016; Wed, 1 Mar 2023
 15:22:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: add discard_cpuset mount opt
Date:   Wed,  1 Mar 2023 23:22:12 +0800
Message-Id: <20230301152212.53951-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 797a8b36-ac7b-4369-b30b-08db1a68ccfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqZFqJsTBt+XAGTCEBsMCe+ei2BWfUqVi1HIMQINLmmVy5GTbrtvXGtuNR0q1PBJAQJyiS7bvy1xbYMWji3NvxpMrsoUYQN9mgA+f6W0meZrhBIh3GGyY73P9SgclGJjmTTt/JPklZ/0EvlpKWWKcG65v8N+HPJA9bEzQZf+V1kVNXhGtKY8/Q+0xXXGnvpI9Qy40OAcvbP8cem20iCg3CPgKYL4X+tZHuhr1RnhfyXv0tJfnfi1b258rOn0KEjYRJP4z4VIXdFtEreVuXzgicc6TlYiHpQmJMTuD3dJ3isUySK3GqNxwqOLu1UH3Mn1/mh4m9EBI1oM8Rgxji/g/33rp75DHaw9eBwXcIxvVRBv+YuepusOxh/2oU8Q2YqSziNHgtc2F74KCzNfGRuW2dyGeF1gmpqGR9b21r4c8GykJsYbhdPCzCsNtB8koTdhbc7Pukbd5xUUCP8Hw389Da9j0it92PK/fgK6dEFygEmFGkysD6ygQg6GL8WNxeGr+ZLhwN8oxoaASZTqhQe/oBGdDdCqPTZDgIv033FDatAwm41ytd6EuqhVhySw5KMmJ7rUJCUy3BXZMSSCT0Vl7hw2nHgXZ3mtj80tX8dnThw9sqj4/5IM7jZDi6KGhjcD6aSZDkXojZm5fcm4cWgHSUx6hVCAhrXVTnu415V0PKNq0Bdq387JzzQFYmyurYr8nZSoUMZhAtjQx0ugYT3DkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(8936002)(2616005)(316002)(5660300002)(6666004)(107886003)(66946007)(4326008)(8676002)(86362001)(66556008)(36756003)(52116002)(83380400001)(6486002)(66476007)(6512007)(1076003)(2906002)(41300700001)(26005)(186003)(478600001)(38350700002)(38100700002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZujFi79JdDbH3qdNiYBjW/0IWcQCR8cRoGjBp8taV7k7mno3H0gTbfFhL6w4?=
 =?us-ascii?Q?pJzByRJ7pn+ZUdZm0ba28xBb1ibqA68TymLQQKkExhGTVZ4Ir+XzZ8wOxIuV?=
 =?us-ascii?Q?PEmGd5q8xpv+7M6goaYfAx4ZKYPV3RB/vN18g69IWm8WQmMj7J0JX70doOMP?=
 =?us-ascii?Q?D2/OzLn+pJ0ezGn2EJVTQUxhoCn/mBxk1i9hvxzJqZstaoTz+CaX2JU6Z9ZO?=
 =?us-ascii?Q?TDN70eZhPb1CtpgYKEcnQQgyWYXGyPnStsWKtMtj5CFvQ4u0TMCdOr6OYWB/?=
 =?us-ascii?Q?vQ2tVQfwZGGBERyVr3fUh9NKlPVYx6P59K42jTCq/ZBO/rAoiB/nP4kApihu?=
 =?us-ascii?Q?pQ70VVqMpZ6IRvQ08ld23yyEhxfQlMtiNkTR6fI1ld33uFykmmHHoJ49mLJj?=
 =?us-ascii?Q?zmrdtSME4IwPpzc9aOj4AHn2p4aooxn8/mrtOPqHiSl/CEFZeKX1Z96cx6rU?=
 =?us-ascii?Q?4ltcEEfIkmwY1/k4olMFsRdJ+3JLY3hXSX8kKcQg7KOoRl6kif2iP2bMyVdt?=
 =?us-ascii?Q?tcfqALqsb6JKdgMiW4MGSGyckXnt0w1CWQ0HZBffuxmo5PL2NLkM3wD0PbNV?=
 =?us-ascii?Q?hqdI0rZqALrNitIhLlGUIHvu5y2HKmURrBo/U2LvEUhYmH45W01xZiZ4GDgg?=
 =?us-ascii?Q?JvXijN3IqnA/9+Uy97kwhco4uroZzQodE8zMk73H+RvNN4S2M6QOyccnkul9?=
 =?us-ascii?Q?EEgkE9kasafdknTF1mLrpZmuCmyvBdktwAzlh7NqHU2vs3DIlAoweLc0dBmD?=
 =?us-ascii?Q?zQYvPjwHjCWuKMmUmzguGFIpUKwJHfffAyut9IqSht05WVuUvMoI/LyArzv3?=
 =?us-ascii?Q?H3QavWU03epRrTL3TCQMulrhNIqwx5/c8UlPmB4TndtU3gNlEveAJcr1Xugb?=
 =?us-ascii?Q?kPtC2TnA1ylTHRS2OjwlSLfuQlfwheXsPLXOUQLzWYng13j3zEoUKCtYf0fT?=
 =?us-ascii?Q?U5Y4o9xV2u7j+HzCGkl8mN/Z8EYwRX5bWp+dWfVVRXYGb7/t99uaZ3rOudzX?=
 =?us-ascii?Q?TKtGZc6H+dpqs6vatpvcbl4d+COxqcOioDztWuP7apYBhesyBimppDcHgSMs?=
 =?us-ascii?Q?nLGLaIUj3a558lJymtGqZECmDbo4V1TSW0WhPi5Zq08nb6R7qNisoMd6Z2br?=
 =?us-ascii?Q?6cleuh+KpbnATbOmITOy3Pjohkifj+EGWzEL905Zc+oa8+yDL6yZH37cgV6U?=
 =?us-ascii?Q?euxpqG2VNXVZn+bq/Lpl+fDPjzVqHECsLig5hrrZhwlUFkYG12z7Rpuy+bpR?=
 =?us-ascii?Q?aUeZ9gnjqWjj7SH8y/8DK66HgKi+xJJ8NACqJmdNgNbAzpwUTtWLYcBXgtt6?=
 =?us-ascii?Q?5yeGZClrqVGVIVDcu3SBkHxhd4vKPVJW2JlMszCtbun0PIWbvYUXA3aOWlJi?=
 =?us-ascii?Q?s0uNKMGXB7bkG7IyK+EIdaeCysNk9DLtWjYnNEpiNRHwhDPPYVNJZpBnOvXx?=
 =?us-ascii?Q?AcjUc9NFQ5Qs+uQE6qP8/kw5QD95jbOAQjAXoYQdQ8EuhFL4diksk7G2fF8l?=
 =?us-ascii?Q?kZnDXOsb6V70eok0t8QqXzoZeYiirTQfCKorgheezHJCsG23dV01KcWopZAt?=
 =?us-ascii?Q?jjbutavw9TjkYcP0y6r2oJx51qMwLalFTChU+MZL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797a8b36-ac7b-4369-b30b-08db1a68ccfc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:22:42.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aN7vsx9mf2wgpWBuWhSIPVyDPhsAq3Ht3fYPszH95VnpQ3KuGn/ySngIu8Vvl11revCb08+YI0SUURuB0dHVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes the discard process run faster on a more powerful CPU, or not.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/filesystems/f2fs.rst |  2 ++
 fs/f2fs/f2fs.h                     |  1 +
 fs/f2fs/segment.c                  |  8 +++++-
 fs/f2fs/super.c                    | 39 ++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 2055e72871fe..dc005f3b784a 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -351,6 +351,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
 			 data block update frequency of the extent per inode, in
 			 order to provide better temperature hints for data block
 			 allocation.
+discard_cpuset=%u		 Set the cpumask of dicard thread, it makes the discard
+			 process run faster on a more powerful CPU, or not.
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0ab2062038a..62ce02a87d33 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -183,6 +183,7 @@ struct f2fs_mount_info {
 	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
+	struct cpumask discard_cpumask; /* discard thread cpumask */
 };
 
 #define F2FS_FEATURE_ENCRYPT		0x0001
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 227e25836173..2648c564833e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2054,11 +2054,17 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 	if (!f2fs_realtime_discard_enable(sbi))
 		return 0;
 
-	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
+	dcc->f2fs_issue_discard = kthread_create(issue_discard_thread, sbi,
 				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(dcc->f2fs_issue_discard)) {
 		err = PTR_ERR(dcc->f2fs_issue_discard);
 		dcc->f2fs_issue_discard = NULL;
+	} else {
+		if (!cpumask_empty(&F2FS_OPTION(sbi).discard_cpumask)) {
+			kthread_bind_mask(dcc->f2fs_issue_discard,
+					&F2FS_OPTION(sbi).discard_cpumask);
+		}
+		wake_up_process(dcc->f2fs_issue_discard);
 	}
 
 	return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fbaaabbcd6de..e2d0fcc2369c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -164,6 +164,7 @@ enum {
 	Opt_discard_unit,
 	Opt_memory_mode,
 	Opt_age_extent_cache,
+	Opt_discard_cpuset,
 	Opt_err,
 };
 
@@ -243,6 +244,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_discard_unit, "discard_unit=%s"},
 	{Opt_memory_mode, "memory=%s"},
 	{Opt_age_extent_cache, "age_extent_cache"},
+	{Opt_discard_cpuset, "discard_cpuset=%u"},
 	{Opt_err, NULL},
 };
 
@@ -1256,6 +1258,22 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_age_extent_cache:
 			set_opt(sbi, AGE_EXTENT_CACHE);
 			break;
+		case Opt_discard_cpuset:
+			if (!f2fs_hw_support_discard(sbi)) {
+				f2fs_warn(sbi, "device does not support discard");
+				break;
+			}
+
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+
+			if (!cpu_possible(arg)) {
+				f2fs_err(sbi, "invalid cpu%d for discard_cpuset", arg);
+				return -EINVAL;
+			}
+
+			cpumask_set_cpu(arg, &F2FS_OPTION(sbi).discard_cpumask);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -1358,6 +1376,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
 	}
+
+	if (!cpumask_empty(&F2FS_OPTION(sbi).discard_cpumask) &&
+			!cpumask_intersects(cpu_online_mask,
+				&F2FS_OPTION(sbi).discard_cpumask)) {
+		f2fs_err(sbi, "Must include one online CPU for discard_cpuset");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1884,6 +1910,7 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
+	unsigned int cpu;
 
 	if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC)
 		seq_printf(seq, ",background_gc=%s", "sync");
@@ -1909,6 +1936,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 			seq_printf(seq, ",discard_unit=%s", "segment");
 		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 			seq_printf(seq, ",discard_unit=%s", "section");
+		for_each_cpu(cpu, &F2FS_OPTION(sbi).discard_cpumask)
+			seq_printf(seq, ",discard_cpuset=%u", cpu);
 	} else {
 		seq_puts(seq, ",nodiscard");
 	}
@@ -2222,6 +2251,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool no_discard = !test_opt(sbi, DISCARD);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
 	bool block_unit_discard = f2fs_block_unit_discard(sbi);
+	struct cpumask old_discard_cpumask;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -2232,6 +2262,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	org_mount_opt = sbi->mount_opt;
 	old_sb_flags = sb->s_flags;
+	cpumask_copy(&old_discard_cpumask, &F2FS_OPTION(sbi).discard_cpumask);
 
 #ifdef CONFIG_QUOTA
 	org_mount_opt.s_jquota_fmt = F2FS_OPTION(sbi).s_jquota_fmt;
@@ -2340,6 +2371,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+	if (!cpumask_equal(&F2FS_OPTION(sbi).discard_cpumask,
+		&old_discard_cpumask)) {
+		err = -EINVAL;
+		f2fs_warn(sbi, "switch discard_cpuset option is not allowed");
+		goto restore_opts;
+	}
+
 	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
@@ -2481,6 +2519,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		F2FS_OPTION(sbi).s_qf_names[i] = org_mount_opt.s_qf_names[i];
 	}
 #endif
+	cpumask_copy(&F2FS_OPTION(sbi).discard_cpumask, &old_discard_cpumask);
 	sbi->mount_opt = org_mount_opt;
 	sb->s_flags = old_sb_flags;
 	return err;
-- 
2.25.1

