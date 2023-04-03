Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52FE6D3F37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjDCIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDCIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:41:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2D19BF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=corWlnQbvyFeeEA5yECst8pJXBx5t9qYluqrZNzIp9jXeiF7PDDRwFAnujsXbNfzxN6YC6NhNGZJVVnG1hFKi91nvJSxLVZTcQLUMj6bful8BSuIft+omMk1tZArPxLihFTOjmHKEr652Spld8MKP2iHItyDUNnler/poAGqO05X4rRLpr5kRpncR6UlubesXJDSAv1+WU8xJxF5VTq99gxY7/G59XTnoQ4EEED2fgb7kdz5/ZDiRYLrbMCg5ofKeT+vFYL+7aPCcm+r+mQPmlBett0bI9hsNLoY20f8huREJmfFxsEJH/Tli2bsFQxQVHU7nCIdlNjOuY2k2gzbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLrsLzjyMRlBeXTe/gW3HzqmTd8IPC4x83ju3uTFvfE=;
 b=ay+57BHAqY/QmouNPaKJUqJLa32c7mxcYMJM4UgJXh4iFT80eaHfvsq+JD+zLggP0uPFSOZ5vcCiwnf6iv5gCMsBQ6j997v1gp5sBYYn4cCZdkVmRo29XoweuPLUQkA+BuHHIswwM2rABK15+EWJdoG0m7ZJ8Rta0Drnc2Vaukrg5xS9HDZuGUNJsuqRh7O4BlI/c5jDnrutZkGEAAt9Hj8F5QnniF6eElW0V2jALYruaheD7L2aBkRvi2OZj5vQ7Y1UOqaKRLepcAUqb7kgHDcslolL8LN9el4LGBssRQSIgZfE/ZTuogHKLj+CRDErOWxmRNvlrFAQ/j31kQwxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLrsLzjyMRlBeXTe/gW3HzqmTd8IPC4x83ju3uTFvfE=;
 b=nnsVQ6S/cTLlVrDvLDIn6VAJocgJWuq4Rs64mwjuf8vnecugx/CP5WDKJnuqlo1bcTaqy+GvHLoHJS8/HFgoKqw8EFRqlybe2odqlrmOls6+lGLDYWiqQtw1u2UzaD6fO4Za1u74kcDw6RC1/IptfpqGwGqiXhjATf00t3iN1ylUEOaHcoLW2heC30UjK3XML5csq5nCPg4sYIZQcaAIhkMe7qXq5iQqWl6MC55pxOfkuhpduo64GQSNS9kxcrvrnAXb6xTcmE/7azCIzH1cBHMghaUZ74y1KS0a7kfhHvPBgVyw3TioOy/w5PSzNUbmZ32Uf4bc4KX+EaQkNwF7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4300.apcprd06.prod.outlook.com (2603:1096:4:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 08:41:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 08:41:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: remove struct victim_selection default_v_ops
Date:   Mon,  3 Apr 2023 16:40:54 +0800
Message-Id: <20230403084055.21482-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2b0231-bd1e-4c50-491b-08db341f2d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVV7A37heW2uKnBLBJ5/bEwTSbvff0gHxnb6K32++rxZqGojoIlll+TD1B0UEbhIDMcN0f8iTTX0/rr39MzI4noAyYeG6BtP71II1SCLCbjcuXO7jutiewZ7/G7VYZ+FPU8pok0rToT4dhe0TTp5xQ7HYvANUTI4KT+60KRj7qB91yE47hsqCwaGYU86gOsd8ASSa+6GqvIeMdJziVF83IXAY6rzp5aOzmmy9gXj1DBfEuQsZDNjowIz7bAcpIT4cjR08/t2BN2qIyQ8TeOVs5r8NygtzxMZCfN9NTzedenhgIqh8iD8kS/Q4otypdBHskHlc7SwtqVWD+7lPEXjSmDSfiupMTCtDAV1+5G1Tt+Mo+1WFGXIgeN4PvOsdG+ss33Z+Y39H2WWcdStrQJTSOBJYhVoj92zMizzdEYECnJXnq7ZCT2wbjy9PhbspGLmLn0x4v8XZ1FJPsPac+9y45Er82CxomTOfku+susIk1hfATi4mOrEznwiUz9uxvck93IP5iiMTxqQpuegdRUUU61xkv/pn1ygSGEmmxiufUcRuDHyaez4ImxCTq3rRx3t/mDvc2SO1n8EsuDVwVhsDyYyuj+/+P8sHWRA9ImWOJzBy+HG36zvOvQKAs40CYaE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(316002)(110136005)(8676002)(66476007)(66556008)(41300700001)(4326008)(66946007)(5660300002)(38100700002)(8936002)(38350700002)(478600001)(86362001)(2906002)(6486002)(52116002)(6506007)(6512007)(26005)(6666004)(1076003)(186003)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bz5/MY3MEIhmkONHQehtwNF8FgH/eugBbZXA9259KKSvG35aLigrYnj+1kZq?=
 =?us-ascii?Q?3pqnNjhOmsefnwk6BVJ6bcs0WQiUKCvWrwyGb5G1DRvNNlZG6KnfU7BBq0/P?=
 =?us-ascii?Q?e/b96OaRlyQWgDhL5rGyKUCWu1legCPFp1i0f6FQczrY0LRL+ct5MB+ouu6y?=
 =?us-ascii?Q?PMo294RBcXX+GJgvG7OL/vwEG6114Ho7ZukUeUa5bnZ9eEdNJXQwhK+5rpLu?=
 =?us-ascii?Q?TQKLR2MXr8t1mQZuRbCSLIYQrX2F3xFg1WSS8DaqkiBpwAk5KJM7XQe7+iEp?=
 =?us-ascii?Q?G0IW0jKkTMdD8ltVGjWVxGz5XZCZ9uAB178GPSrCgNP74OGPUWtHLdRIBYiF?=
 =?us-ascii?Q?A9AlQGQCh/ZAvIR0aRs++jRUiMbF4AzhfQqwboWA8Mgc58ATOU/rpqsox5og?=
 =?us-ascii?Q?ctEuDdnSYEPPelXvXI3GzQgVEjlXuATtcQOsxXitex5jekzr/qEc3GLhMBIp?=
 =?us-ascii?Q?k2QLvimDAH9AML4aYP0x2lBAe3jiszTrSTHoX8sipo6xe84FEQNnNCOqiDjt?=
 =?us-ascii?Q?3SNN92sXKh/vwKCL8mBGKokR5M85gl1QSHGlWvml37YiRdLe4QgtwqbieWFe?=
 =?us-ascii?Q?2bCPrN+7X5R3Cmc1qv/WIgCcMeP1vBdoiO6EMcv85SNH+osdqHk42N7L+ALA?=
 =?us-ascii?Q?mHLSwD64RHq/Ky2kp8a0s9pOCEhJikI/nwzKvGOgneCHNRY2LF/ycEtjR7HF?=
 =?us-ascii?Q?+h+wVRiz1DiO5WJjuvNuawlMwGFgO6nJmnqy0iexeRtmeuAOXOv7cusXdsW0?=
 =?us-ascii?Q?DFfd5n0DIKvXPnDxn///f/o/CKZizJ3pMHkd8PWIDtQtFq3KEhBF2g0zpQIG?=
 =?us-ascii?Q?SsTCpsXM4MN75vnqNUpyUps2ACd+Gm4eh0LDp/6pxO2bzgnv5dzbLI1lQqFU?=
 =?us-ascii?Q?BrULywWcBp4IYVPgLyfbscUyI8rW2ErQFHlqqUKxVlNz1biVgz2MwqC4a/u4?=
 =?us-ascii?Q?vW2ufCEAnzwQKLItvv12Eg6yLTn1CPHprDUKMm2ZhTBhxn57da3PW+qepdFk?=
 =?us-ascii?Q?Me0+X+HzfkDbEDwTXHNMMUI3HKheNN2EStrBj06/FrOgTeg5w7XFSVgQ/cyP?=
 =?us-ascii?Q?sOLoFpsXY2ASkuUY1OdxoIL4jWoRi7C5yjGdCanhj+rEmgK6R4qSsKF2312C?=
 =?us-ascii?Q?o/EyYP9/IRp4yCuZO3SXtEaJdBZZ11HYpvMvEj6ofUDJXfzVe10Ek3ouhTOe?=
 =?us-ascii?Q?N26A0HqEcQ8Gxoa3e8oYNWlz27T4FEOzxdb0yNmzhOdnFNhTt35T7b+jMaJk?=
 =?us-ascii?Q?hhPrR/ckWBV3OffKBDPo5apdS8bpYwYVfGkrBJzfX/jgisbqKjaKUtJXOQp2?=
 =?us-ascii?Q?u3wPdf5GL9lfZx1Jm0RGszYEePip+j+O+KS9Y3y/fP6Nffx445nMfmQChHEA?=
 =?us-ascii?Q?ib2XZ6sc9FHv9NfEN453jCjh/PzuT3LJijsKrhWBoWab3hN/iGsVdnB25sVG?=
 =?us-ascii?Q?iDazChwnfT46izCKD3T31F9Eo/PMdkt4tH7iqmmS+IDUkwqR+DEm1rUdWhop?=
 =?us-ascii?Q?6+TswWvyI4MpcxjD/Cs1xES14cgpCUl80wIBQlTx63JDuWspdCWO2WdpRVbe?=
 =?us-ascii?Q?6DFNzHBhqEBHhkzwkYp4T9mowL8LZcmAN/+DZ/X+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2b0231-bd1e-4c50-491b-08db341f2d01
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:41:10.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HOVWeiolj018KbbmzyemMfCEz3RAEZ8yQRmaIcl0al6PS21WPZdv2pjlG3hTHrlma186XOx6zT4N0hwhr87oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4300
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only single instance of these ops, so remove the indirection
and call get_victim_by_default directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h    |  5 ++++-
 fs/f2fs/gc.c      | 12 +++---------
 fs/f2fs/segment.c |  7 ++++---
 fs/f2fs/segment.h |  7 -------
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8d5124569a03..9a1ec5515121 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3871,7 +3871,10 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
-
+/* victim selection function for cleaning and SSR */
+int get_victim_by_default(struct f2fs_sb_info *sbi, unsigned int *result,
+				int gc_type, int type,
+				char alloc_mode, unsigned long long age);
 /*
  * recovery.c
  */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f1e0e01a5dd1..f3f0020633ad 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -741,7 +741,7 @@ static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
  * When it is called from SSR segment selection, it finds a segment
  * which has minimum valid blocks and removes it from dirty seglist.
  */
-static int get_victim_by_default(struct f2fs_sb_info *sbi,
+int get_victim_by_default(struct f2fs_sb_info *sbi,
 			unsigned int *result, int gc_type, int type,
 			char alloc_mode, unsigned long long age)
 {
@@ -937,10 +937,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
-static const struct victim_selection default_v_ops = {
-	.get_victim = get_victim_by_default,
-};
-
 static struct inode *find_gc_inode(struct gc_inode_list *gc_list, nid_t ino)
 {
 	struct inode_entry *ie;
@@ -1671,8 +1667,8 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	int ret;
 
 	down_write(&sit_i->sentry_lock);
-	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type,
-					      NO_CHECK_TYPE, LFS, 0);
+	ret = get_victim_by_default(sbi, victim, gc_type,
+					NO_CHECK_TYPE, LFS, 0);
 	up_write(&sit_i->sentry_lock);
 	return ret;
 }
@@ -1969,8 +1965,6 @@ static void init_atgc_management(struct f2fs_sb_info *sbi)
 
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 {
-	DIRTY_I(sbi)->v_ops = &default_v_ops;
-
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cb8aacbc5df6..c9e674fe477b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2881,7 +2881,6 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 				int alloc_mode, unsigned long long age)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	const struct victim_selection *v_ops = DIRTY_I(sbi)->v_ops;
 	unsigned segno = NULL_SEGNO;
 	unsigned short seg_type = curseg->seg_type;
 	int i, cnt;
@@ -2890,7 +2889,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	sanity_check_seg_type(sbi, seg_type);
 
 	/* f2fs_need_SSR() already forces to do this */
-	if (!v_ops->get_victim(sbi, &segno, BG_GC, seg_type, alloc_mode, age)) {
+	if (!get_victim_by_default(sbi, &segno, BG_GC,
+			seg_type, alloc_mode, age)) {
 		curseg->next_segno = segno;
 		return 1;
 	}
@@ -2917,7 +2917,8 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	for (; cnt-- > 0; reversed ? i-- : i++) {
 		if (i == seg_type)
 			continue;
-		if (!v_ops->get_victim(sbi, &segno, BG_GC, i, alloc_mode, age)) {
+		if (!get_victim_by_default(sbi, &segno, BG_GC,
+				i, alloc_mode, age)) {
 			curseg->next_segno = segno;
 			return 1;
 		}
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d66c9b636708..89619969ec85 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -289,7 +289,6 @@ enum dirty_type {
 };
 
 struct dirty_seglist_info {
-	const struct victim_selection *v_ops;	/* victim selction operation */
 	unsigned long *dirty_segmap[NR_DIRTY_TYPE];
 	unsigned long *dirty_secmap;
 	struct mutex seglist_lock;		/* lock for segment bitmaps */
@@ -300,12 +299,6 @@ struct dirty_seglist_info {
 	bool enable_pin_section;		/* enable pinning section */
 };
 
-/* victim selection function for cleaning and SSR */
-struct victim_selection {
-	int (*get_victim)(struct f2fs_sb_info *, unsigned int *,
-					int, int, char, unsigned long long);
-};
-
 /* for active log information */
 struct curseg_info {
 	struct mutex curseg_mutex;		/* lock for consistency */
-- 
2.35.1

