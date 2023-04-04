Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9206D5762
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjDDEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDDEBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:01:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2116.outbound.protection.outlook.com [40.107.117.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FD1735
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 21:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNXS6D5IG6mb+GUYSsEUHO5i/SZuO6xqfmVkoHdzrgC0CyiZUxl/4/UDLgx7Dz7kCbkbqrG+aWrofFDvBWr0HjaPi703roR5XOJzIZhMLXdJoH36fueHR4dUVmytt5BrjRH9a8G57KJY1hWMVY86XKnzs7OplXV306fFwkeKJqOePQTOWxvykR5f7V1AZsIaVbInss1RzSS2AkQZj9R2P1FDB3yKyfaY8CXtD3+C/XdRKVESFqFG7tAZllLrU80DCWytIszs8zCD/Tt7n7Md3vJqzzy8/jPESd04NfAODTXOD11f+pPoJGTe+Nin8t5mbVQv9jfM67g3vuur32EU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1OiDib/D5yfL0i4HU/G/wu+9pDHLxc636AnGzvuiYo=;
 b=Wn31euivro9W56LD0AvysPkF4W+k2+TMfWba8GwgIGxRasy4IjL/Brx7205kYYsKVljunrJJXusIekmE5BEus440tBeqvGDX5WxmpTCx81WwvPq8gJ1gpMhmrlDB/eBJ3XJ1MciDBpdNtJNEG1rAfVY49YBLILPkajTFllelKXpV4H3+iWEFKZDsxPnA4iqG0tt2QwEClFkNnlg0h4iPEFJ5g1aGIQlyBLwtO+bLp6XE7hZDFehiC5WmxrKNk0yjvaFUuyOkMOCg3UDHaQvurAaB5tBqCRn+cpx6ukoEBCyiWcSOiUpqkoAn9B6gqrj9/surQvnSfYZnYOrdWMF/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1OiDib/D5yfL0i4HU/G/wu+9pDHLxc636AnGzvuiYo=;
 b=iFkBQ2cHpKIMLE2D7FEcbbIKdMMeoL34iL/MVHFRa8/XVJdNUUMUn4gkTADtREyOZ9NDLeto3D6/0YvjjFBI8zq6xjtRzkY318JstEqMXtmum4Q+Ps/p1G7LRKwN8Vh7Ved0hTj6VFzWaWWMFTHYSTjKx29hvyatV9yP2C3wvqn4KzHDrdyvKX1Bx7SMGrlpwRv7lWXR/Q873hkQF5Q49XoD6kSCpMOLiwps2CFLj4QFVR5CgJgqwot0Oj1Vkfrib7sKv0uiRfc39mYZqH2kqDOo7yPghcV6mhKNypgug/TSCxLtcd4oi6kEPOTS+td4b9YGMkLRLh5ReDVIUEpZ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4029.apcprd06.prod.outlook.com (2603:1096:400:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 04:01:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 04:01:04 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: remove struct victim_selection default_v_ops
Date:   Tue,  4 Apr 2023 12:00:51 +0800
Message-Id: <20230404040051.50726-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: 54775c97-6e91-44eb-9ea9-08db34c13645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/pxdkLIWko5hzA0gyXn8hikAZ8lMwrS5ktPsgPtY4neE/aDNkaRQXSJ/ZR+NAIo2yKLRzyRcw0HGjgiP0AEPexZ+KE5M4RfIebp1CqS61Ld7Rfws6LbQFlpaSGWTIz68h5byyMR1WfncJullW4epI+ckxvHEtV7nBWXXHdI0EyX9sqn9aEOeoQi68GVmwxQU3lPnjDEouBxiixAAKEVFWnja8opCSldvKrthtS1v6eXqm2RcY7eBBZR4N49jOEmfOXbPWliVVBypu7B3rduoulrqzoRuon0b+DCla1F3jeCR9952wMCuTSMljRnkVDrlWKetkD/6XJpOhk+xM+lu43jideFm3I1/o7Zpe3gNN0cnD3Lso7R7mAFn9FEMrtZbhSvwyGVc8b+RqIoPYhbTSj4Ae8yMHeJcL6ot7YkA2ntexgqp90/lZe7VbOv5szDLGEh82tgiqF1QwN70CI4OZc25sdKd9zx+AjcBielhyDqr8/zCIFAbZv5gUifwilgArMndQM7zntQ++sjJRAou2LqmV8bqnrNHpkv4P2XbI1Fj3PsCOJ6/f5w9cw2YQbE8a5Z3yl2dJjlp7CYJVNbYV/QFeFEjUER7ecYnzRHNpLS7j4g3A6AzhamTOdtKrqJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(2906002)(86362001)(36756003)(2616005)(52116002)(186003)(83380400001)(6512007)(6506007)(1076003)(6666004)(26005)(6486002)(41300700001)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(38100700002)(38350700002)(316002)(110136005)(478600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzcmwx4w2zUAnfZRRBsP5MYfiNjRWkOQIsBoB5+8/4wUUZcu+QJ1Udh16cb7?=
 =?us-ascii?Q?VrA5MTdOtMsETEjqCxbrl6VhkPrR3a/uiM5LZ/obJ7ruX1YGRmfiTXlCP9Eg?=
 =?us-ascii?Q?Bp9lnY5qeU/QT2s9Wnz/J1kulVQetDC0mOdGcIe/eFvCRzlCCRM9/zduFGXg?=
 =?us-ascii?Q?u232suPuiX8tjg3TL8zCz1bPwpR7GklTxddnkxMAY5fAfb8tImZIuXUqiKUw?=
 =?us-ascii?Q?gxJn4fRLBPkhZkIUCF0aM4uork95bEzu8OAI/tlrE6PSiZsZVtMhkTc83zLD?=
 =?us-ascii?Q?oUfokkYZTh1774l7FREPTG7FVOjcP77YcARwxTHbLOdjQey8B3o4ohZ9Z9g6?=
 =?us-ascii?Q?U2nGkH11uySKWRPCeCF2aXsplyF3DI4eQXJ1mk4KllPziEGwdS4SFs7Z3mAR?=
 =?us-ascii?Q?UO/Y1hVjFeDud4zWPW7Cd/brBbJ7nlRkD7gOqFDPgSx5GbmvdScCaChvv/bp?=
 =?us-ascii?Q?F8NW08Q8ZOYbqrAtOSiocvIecnchBqKTXPOrGGc5KCpGNXsfvFVoCCRfDxPi?=
 =?us-ascii?Q?jdoUWBnbpnuMQGLvixabMG9+lMtRsRrP0Wy31XyKFkBkllDoFRYbfJCFHUe6?=
 =?us-ascii?Q?5I++Sp2RV+wBKk9XFfcWxfTD6atozFlxAxIv8yuQotqG12R/97nfqMgVpQXv?=
 =?us-ascii?Q?7eiBf8xsygWzB2ihQFXSk2pIJURhgKf/vULpUqN2aYbRrHtNTsOZJuwMtpnh?=
 =?us-ascii?Q?CMJ2Yjm3hd1fXqW4GHwAQKVXwluTBr+4HdS3vosD0bxNG+RvxF7Mcotsj3k1?=
 =?us-ascii?Q?Gkm3buleyEw8bOxJN5mzyQzAVZOPmWo9XFwYW/frgtE9EZjIxpQcF50DSgr6?=
 =?us-ascii?Q?pV3baF+QIQgLvlyCn1c3vRb+61385fJOfS3RLgcTqnFALJlbue6/jUDIGD8i?=
 =?us-ascii?Q?2V3zC49dW57Oh7QgcDR8m3yGMXm2m2nJ8vtFEGJAiz/sK+PthISZq9PuogK3?=
 =?us-ascii?Q?QSG9FbF3DDEOc4gWzWEcwiS82blcGEe6ugXUFxOgnB1arfVoz1mkCb9rTvfX?=
 =?us-ascii?Q?IKXn2pag9+mGpiUZQMZcF07aQc+kR+0gpWzoIM83X0BxyksmGFCLryHt4FNg?=
 =?us-ascii?Q?cv1AgixW0jyBELkDn6QV8+RviKpnviNzN0hDxzJNmq7qT4+6Vxe3D9rx6ASq?=
 =?us-ascii?Q?Ak82cck81m5TToOlbrLMreRIPYoS9/FdFUub36aQZT3nAugYVj6nwk5AwFOr?=
 =?us-ascii?Q?m1IuJrHNQLG/apKcMskga4/C+bAHXPdTfD4PnkC+bOxCb7iTWtpp6/eMp44h?=
 =?us-ascii?Q?iJtpYb3LC7kSOERHkMei9FcJiJWVjOBKmdXjMf2LGzLsTqGdQ1UNV4vFszZ2?=
 =?us-ascii?Q?TJy/DgQJLJdlPg5ceaU9KCYAYn7vGWJy5xQ9f9LXwceIOgDR+9okd5dFFlXb?=
 =?us-ascii?Q?9X8nORgnRi46zepA8UIV19G8IMcWbDISr4p//vobAmlySA1Znv7Z5yfusXFT?=
 =?us-ascii?Q?TPrKqI4cxvUKvN4b4FTmeEFxR2+6iM8o0zMxWB8rF6R+EDoeb2JoYJTHytIW?=
 =?us-ascii?Q?hS2TGfzHksHFfGvSsjp7dTbcGFACbFoT5Ole3mRpPqqRyWmmTLvxMSRQDX7X?=
 =?us-ascii?Q?AX0CNSzsjfhiPc97k2oeC3qMh7xxTe87gsCGfMox?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54775c97-6e91-44eb-9ea9-08db34c13645
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 04:01:04.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ucDf07s76XF6cEjeXMBXJ6Ps0IYPK9GNBn7EZ7JKXaSZPpE6GfUZlTpx/K+PH83nsiJ/bhUXzONwVtv3+PkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4029
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only single instance of these ops, and Jaegeuk point out that:

    Originally this was intended to give a chance to provide other
    allocation option. Anyway, it seems quit hard to do it anymore.

So remove the indirection and call f2fs_get_victim() directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-rename to f2fs_get_victim()
 fs/f2fs/f2fs.h    |  4 ++++
 fs/f2fs/gc.c      | 15 ++++-----------
 fs/f2fs/segment.c |  5 ++---
 fs/f2fs/segment.h |  7 -------
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ea571e602dca..7a09c5228e1b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3871,6 +3871,10 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
+/* victim selection function for cleaning and SSR */
+int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
+			int gc_type, int type, char alloc_mode,
+			unsigned long long age);
 
 /*
  * recovery.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f1e0e01a5dd1..35e25a2ac4cc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -741,9 +741,9 @@ static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
  * When it is called from SSR segment selection, it finds a segment
  * which has minimum valid blocks and removes it from dirty seglist.
  */
-static int get_victim_by_default(struct f2fs_sb_info *sbi,
-			unsigned int *result, int gc_type, int type,
-			char alloc_mode, unsigned long long age)
+int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
+			int gc_type, int type, char alloc_mode,
+			unsigned long long age)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct sit_info *sm = SIT_I(sbi);
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
@@ -1671,8 +1667,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	int ret;
 
 	down_write(&sit_i->sentry_lock);
-	ret = DIRTY_I(sbi)->v_ops->get_victim(sbi, victim, gc_type,
-					      NO_CHECK_TYPE, LFS, 0);
+	ret = f2fs_get_victim(sbi, victim, gc_type, NO_CHECK_TYPE, LFS, 0);
 	up_write(&sit_i->sentry_lock);
 	return ret;
 }
@@ -1969,8 +1964,6 @@ static void init_atgc_management(struct f2fs_sb_info *sbi)
 
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 {
-	DIRTY_I(sbi)->v_ops = &default_v_ops;
-
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cb8aacbc5df6..813b431e60d1 100644
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
@@ -2890,7 +2889,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	sanity_check_seg_type(sbi, seg_type);
 
 	/* f2fs_need_SSR() already forces to do this */
-	if (!v_ops->get_victim(sbi, &segno, BG_GC, seg_type, alloc_mode, age)) {
+	if (!f2fs_get_victim(sbi, &segno, BG_GC, seg_type, alloc_mode, age)) {
 		curseg->next_segno = segno;
 		return 1;
 	}
@@ -2917,7 +2916,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
 	for (; cnt-- > 0; reversed ? i-- : i++) {
 		if (i == seg_type)
 			continue;
-		if (!v_ops->get_victim(sbi, &segno, BG_GC, i, alloc_mode, age)) {
+		if (!f2fs_get_victim(sbi, &segno, BG_GC, i, alloc_mode, age)) {
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

