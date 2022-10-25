Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96A260C211
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJYDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJYDIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:08:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925A201AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpyqrkDb3aDgR+TEv0s96i2jxxARa+kcy9TT5SZOXO4xPfsb39p5PGG5luk1XONTKTEDNxfHpxXntpyyFyd3HZER2b7G6RPj8sKXDgCEfWaYz1niS4LkfqwUFdfzT4EQKIWEsfWyYVQ7kh6lAIslW9BFtncM/VAKSbIemSh7bRM1sjic0uJLdD7jYXBuDWKdb0fyy6i8pyNaQY9JcHdfITJ2pf25vK+Mo2VAQhC8jxa7LqP7lxGKyALmrpPV/4DJKwLVZrS+t1qgwb7+pzKzC/61zvaemsGFzzQzVnFkDmPzWWjjZ1VQ8ehI435dgb4O/g/QS6v1iNwBga6bPJtJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vztr6GBxy9chli7oqmBT+UVadngpfK49wFahpBbZ17s=;
 b=D7PR8J2GwAILjpskmUelOUPtSBbt3wfgiLRoB3oCvqFrEVl6ZnlA7Bg+LhOSzICRrFRY/CfsLFy6JMWpO/kJ9DLG2dNefKo8ppdQCvPQph1VPDLmaZ3Nv0WhxSwBN/xboGZOFht5uQmYwwXgBHluq43OGqEODKEGhMBx4br7/MGSA5jT+0w5mcs10yiO6BrWDmQH64QET+cwGjoofyn3VOQMFc5Kr7266hRVrAvMKPlvyi2RqhF+P6LiV05zBwnaoBY8q067vHmlwpot2C3y2bc/S//muvM3e6N3lnFTVCzkjyPM71Gbmvo09b56nJkGs0W3DKYm7+5F5ZyrUHgi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vztr6GBxy9chli7oqmBT+UVadngpfK49wFahpBbZ17s=;
 b=H8zIHPTRE4vcbhwlx3Um1AYBAJGCUMP9Drd/zDnWluaQu94SRXeT9MHWikXlnsuiFPB7tw4mlSztuxbYirdUzQmP708WaQN9jpgitw2w465HCxlcNbiqigqB1iHKExYHE4/6IjhONVKaEbbMXPl5PcikfHHYedXfGFZl6G1gbiFNzUux+zN2Nv4nXWzxSOjhWAEN8H6vp+5cz9PQvb/TfG0TmnLEC/k44c/bLmqh0hP4mNyw2V0CGpa751i8ulTYUTmOiylroDdRxT2ZMTQgwEalgmy3qJyVqTrm450of9qvnO2XRrUYkdilndpxeFBuugcrkrRGfkhwYqhMD9DHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5063.apcprd06.prod.outlook.com (2603:1096:101:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 03:08:41 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 03:08:41 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: remove batched_trim_sections node
Date:   Tue, 25 Oct 2022 11:08:31 +0800
Message-Id: <20221025030831.53888-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: d23e433a-47ae-481c-d092-08dab6363847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fcwDKSkICzFd/WrrvF9B4kNanDss6Oaov55eLrjxE8CRvAZGFqOZJCoPoP9b2+/Bb1yEqgl8u5XdGqWjYLd6BKldpvcApuQaD6TNfft540yzXv/jv3IQ3cPjShX+7FbyhaDR9XapwLdAq4d9C+pS1eUK8eoU44ZC8eDkSBeKciCuJXyh5FQrWfYc7LfOu+qA5+Qs8mejnBKn6vVaaPHvCakDpfnV6BLK74+5cG1NpPEGdMSMIxNlLWGYNmrXeS//dQvHkF8n4MlIBxVo5rRqM8xDTugEWCIkvQOnzV90BwH9g7/HYOALpX3mOzrLXfNXDVaLWPqftMxYuZBnQIu16ICgT4fHQEZFL/t8J0yg9LeRtSg+A8OA6h6pMeFJ9qyI/LQCISEzNafVD63ymuZOAjBK2WESL96q36bzY4wyOJ6xRYQsQYk3iTcJIxGDutRFF670Wv+fL5o16FQEG7zHsZhjJGF001YwKykpbvOXlNAOtGg+m+7H7hBI+SbfBtMNWW5zDxyFUwHlF2twQikbcYktDR3/YVCIG8WBKSxpLF45C3mQ9vz/BZR7N4n2M363dKE/oliAQRiKy7wjKVOnjKKb7EvTF4sNtR94T/ISKeYGVFYeZUPBZ91qAVKVD6uPubgRT/2/XFilUEG5IaJl1Q402Yn+dQJatI9MRYOZds+E4SSiWmjsmLlOJ9TZRuUPC9lNg1iPYs3eQ+UERQ5fsP26J5KQNYyKQcwtHs7XvN5KvxWQASlykP64SmJnuDoFHjhdrgRbgE+/Vml94nHiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(83380400001)(1076003)(186003)(6512007)(2616005)(26005)(2906002)(38100700002)(38350700002)(5660300002)(36756003)(41300700001)(6506007)(52116002)(107886003)(6666004)(86362001)(316002)(8936002)(66476007)(8676002)(4326008)(478600001)(66946007)(6486002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ui+xkZfS9qwprtcAQbZbUFQmEaQmD/t2viX/zfD9DSzRQUs19FA/0mmJ2tKa?=
 =?us-ascii?Q?msiQ+FpJGCXM7cw/oKBNCTRejC6xx3QwVZDQuPNEwIFzNTXfq2xFdgJQbIcX?=
 =?us-ascii?Q?J5ZylbAMQRpwDjWvksLN3Fa+PiLJ+2CW6CyxPNdFas1sk+l6FBbpRBtLif2v?=
 =?us-ascii?Q?TT4wEAvhlEiz6MCiB0nWGgXKvAZ3/+RaIsjrgG5eYY5X3BY9dNuDh97PSoyk?=
 =?us-ascii?Q?VCP87UsrXfHXqEYrKKT5TGVx6XBdCeQfaxBXcfp9RZUgk76Z1EkRqsNLWjxM?=
 =?us-ascii?Q?5bcx6LyXYU5AEjAr95iGzE8W+9oj0xFvPdh0ht4vShqQUtkto3buG1JusHse?=
 =?us-ascii?Q?wXfmhjQkeIDtusEbB+P26Ab/TPopoyLn094aKht7AGt6Aki1PSiqL2RJMNTo?=
 =?us-ascii?Q?7TXq0JiFTbGTo0rl7Bq6cJm/7+0vFChi89HH6tEIEwf3q0zD5XNWs9FvmF/c?=
 =?us-ascii?Q?M3UuY22yipVW9YM0e9lhKdALJyUYSHFn4u7LX+0CbvUBHbZc57ySmXC5qt+n?=
 =?us-ascii?Q?32q8cN7GKcnTqPXGIWYlWbGf7DNgIAyFQVTIKkCaJtnWQCHN/4KCID0lTi9u?=
 =?us-ascii?Q?Y5c1A3SpaTE+DYj9DvL+9iPpW+ujJWcVBxXLF87EubNA9WxJ36ru8fAe4CYw?=
 =?us-ascii?Q?+pOYiHduDdAbl3L1hGMV/I6uq0dQm02aQ1clUzhyqj3UlQiH5qztpcXp5Bc6?=
 =?us-ascii?Q?aiE/VZIiRHAp+Gry8ug+Y43EvJ0h9hiPsSEbeA5n1vBz5lEf2OEMcVQ579L0?=
 =?us-ascii?Q?UOm+xrs9ip/cj5oTBGA2PiGZXfFl0hnG2gVEjR7ixY35Oybevo9qZIc1+5QR?=
 =?us-ascii?Q?wPUWn+EZ2xLBmDA97y+oePsxTRei1DS+c7QxV8/Dj6Iw/+1dvUQ4eqDP6+QQ?=
 =?us-ascii?Q?Q+F1VJELiLbbJFKUV70/+eqIxv9MCZ86nwN+h9vU4nqW7tAbLOLgrO/kHhOH?=
 =?us-ascii?Q?B3JJ8ho9QhrFSB8BYK7EzFPYGJFt/3AY9cY2F+NpZhJNczSuC5qPsUUqPws6?=
 =?us-ascii?Q?6oLc4gX2DRWLb2jpKBkqcFcUspJQIqSx4gyxWVTjE10J545EoBE/8quf6akg?=
 =?us-ascii?Q?WlZs4Qrz8pKNqZt33ixtl0WIjvyhC6FZCRiXD6CJcRAgWYbw/XhcSL3aeRwO?=
 =?us-ascii?Q?6+zHFIPdbLtSUm68xbYv4hze4NGRegfq4YY/nwDXROF/MgMsGddW/Jc2rrgp?=
 =?us-ascii?Q?+K/2Hn/fNQKNVkt4wWU+uCkMh146vdDN8KZlITFqLs33jINzO3bAKfuBUnUM?=
 =?us-ascii?Q?Qsdy3WyC3AqUovWs1dE0yHpaUQrsg1EwUtrqhRk/pL/rpnMQRjmgOCrcR4qc?=
 =?us-ascii?Q?XtskJW9Km6XnKEh0PJZoKlBrqH9LflJINKeS1YhEjwsDMijnNkjkLTqw2iex?=
 =?us-ascii?Q?v/TzUHGiFyEOMu+9AcSfpnqF6FckfHpnWHINOtIt+hI9Xg9iiIslLx1nebMl?=
 =?us-ascii?Q?4KgN+1SXEKNyNmJYjzGcfGDTl6JRT8FmU5SzRjH8HTIb2JO1dS7KpoDxewoL?=
 =?us-ascii?Q?1JeEo4h9BpI3KToD6XegVH4WM/wQ5bwQa+npbwiwBd2nTTr9mWJyndIL+B33?=
 =?us-ascii?Q?57YNRebIJhW1p2vpRnl7inyRRXA2zpPuEreOfI/O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23e433a-47ae-481c-d092-08dab6363847
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 03:08:41.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yreVD9NzY+serQ0W3otW02xq+vwYzQuQXAcTciDxouV6Z+TZFTEGH1g9dFb0/vv7QRl7jISXpe0fJHfxzt/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 377224c47118("f2fs: don't split checkpoint in fstrim") obsolete
batch mode and related sysfs entry.

Since this testing sysfs node has been deprecated for a long time, let's
remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
- merge "f2fs: fix to correct invalid batched_trim_sections node"
 fs/f2fs/f2fs.h  | 3 ---
 fs/f2fs/sysfs.c | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..9c480835adab 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1062,9 +1062,6 @@ struct f2fs_sm_info {
 	/* a threshold to reclaim prefree segments */
 	unsigned int rec_prefree_segments;
 
-	/* for batched trimming */
-	unsigned int trim_sections;		/* # of sections to trim */
-
 	struct list_head sit_entry_set;	/* sit entry set list */
 
 	unsigned int ipu_policy;	/* in-place-update policy */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..926b7a844362 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -488,9 +488,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 	}
 
-	if (!strcmp(a->attr.name, "trim_sections"))
-		return -EINVAL;
-
 	if (!strcmp(a->attr.name, "gc_urgent")) {
 		if (t == 0) {
 			sbi->gc_mode = GC_NORMAL;
@@ -790,7 +787,6 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
@@ -919,7 +915,6 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_discard_issue_time),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(pending_discard),
-	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
-- 
2.25.1

