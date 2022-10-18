Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39904602615
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJRHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiJRHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:46:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06C44CC7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGijX5cdBsLQ0HeqsyUFr+ZTLOsSbMngAp9fWtmvay+4S0STDXWMYg/nj7+zij2x6pCFGD0+cteH3oyrJeY0dJ3Qr7/ftImaXu8T9fbGRHwYwyNKEVS1ZxLgPudguPq7YEVZWyc2gIlG1V4+gTmFLSDR2sojrwFFWpkwlzWkhKzmDyj9HW9nBKUB0O8hXAUwP1Q68d5WSYeRy/b40fiXDC0tE4f3kGBBruRHfUSwsl6HW1ppWq92qeFMg4JrAPtTim58Pwccn2Jigtsc2A9G3HRXIKSWOpk8I/yi8mSl6NVUfboPRHpAAYTJC+WfFWZNUXAmXurCXs7t3ME5Vgy1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ulRy0s/oUODbUjSm4inAeZIy1XgU44aubn9hGnGZI=;
 b=kIeFdXFFJa0qn4WkIGX8I4t/SAqrHrimx3RjQZgc1m4u2MSqOWVjA/o/7QARWNiV5Z0lZNaBL+dnpMpiyy7SPfSEKGuOz77hmjbg+SM1U2HA8ajWWaD2C1Xcv3lmmsRdFvsUiin5YW27eV3d8dCcTOzgbX9VVTJ5/xwLLao4s/VuHtG1XxiNhx7ANV91PMNUVBtuilD6cM2ovtaXr6ppM+SxVgn5PfJVQz9Lr5Qfd+IyPL+Aqc4kD4YLbZWPZOUVDJK2cZVuqNWsbJgvV3mNl3ttVTrkpuS97OrJ6bPxsc+qbbaigqS4O0wSPctoSByuZDYgAVWvdTW7LrYigCHu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7ulRy0s/oUODbUjSm4inAeZIy1XgU44aubn9hGnGZI=;
 b=hqvQGb8nTl2LGWv1udgWy1ZeVu7CP5HJDDtPvwjMUnFEkcRVEXMHUgq0C8jUuVFyPO20eOYSguDskbwXL9OiA/7zZAlmnoqsJvlK5YGHPATVEHSijuX5X2lrexu+hmwwAeL1eshxK68XM/S+dX0aVq+Kn61ELtDeA667lWaCBHChyNePt6WH4rCwQ38L/K+PzhE1SAHg5QbHhlOB5d1KE5DXlVnButo5MN5Ax6Bmcs8KZsPCIOK6IAqotd4S6pdun1XPLkGuOonNcgi/sgIigce7APlptSTXpbdTGSj+PH+ReHJ8wFJTnbf2UtMS7jV2kgeC1jx79L0TlUDrcXHMjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4604.apcprd06.prod.outlook.com (2603:1096:301:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 07:46:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:46:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce gc_urgent_mid_remaining sysfs node
Date:   Tue, 18 Oct 2022 15:46:21 +0800
Message-Id: <20221018074621.16019-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd70b47-acd1-4e80-eafb-08dab0dcde6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvZdx3/BtJV/oLFYcrqj1AjVGpdNJXkWx3fF24F/uOHXgDjkkNJNxsNMUhbTpG/DSpkiAvQy/R8Xh3k2PVbJbJgKgEneJB41r5vFo+DCC4u/92lNHfLe07hlZ/6tug8BHDCtmhYO4xq0pIcSJl8Oa6JK1mvcCUIH2gGZ4I/cokN5qIOCUrbMPKe5JTDFirD+Inczb0HAa/f6qJcGFRc+ZegwtAT/OOEJIXNSyNhfpof2X42rLbTBJ6jb9OD0s0J820jEaWv1OV6sgGPo7e3GoxaghmggkzhSTlk09laug9guoMS0G9xj2JfsTgyJ+xREApGL8n2KTIHjeVzi1fmq8enStqzuPsbakFdHI9xB67QvMhlHj4ikkhjMJ9g4dAN0Iw7giD+PBzNCl9MnaSwlnEr+SzSUD5mLuL5evSrY29Z86ZdFzTWIePurRmuiF097EFEQxf4T/rR4JFnM7jphAc3VS5zeLd1q4+dSM565+57Gkto5bLmP505PRni+7l79wP2HkPxTa4V7NFsK6iLEVKml1Kv4DPng3rx7/+0fO4a/nvaZ5pTQIuQLVnTvGSp6asl2uP+csgvkgvrAWfrlUADNPQ/i2QQKXVOH9Y+/mO9vBZQHoRWxcEA6ULOooa4Y91JYNqXXysLzPfP0lq5oSXBOq40Pr85wqMfTHHVgUhHQ1R2ie+lSLj4CjdvOC1u/hcFUDfmpKkeKd+aad4xT6i1PeuM1h07GmA0KyMy2cc676vFeT0FadtlXT2roHv+TWLvKMdO3TuN15bAquv/15hRTUxTIS0HbIDUlYx6iiN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(36756003)(38350700002)(38100700002)(5660300002)(83380400001)(86362001)(8936002)(26005)(6512007)(6666004)(107886003)(186003)(19627235002)(2616005)(1076003)(478600001)(6486002)(316002)(66556008)(4326008)(41300700001)(66946007)(8676002)(52116002)(6506007)(66476007)(2906002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gu4kY60G462yfkhw37aRxn221NxKb0w7UuQrF67bs+z+hBLD7f3TJO4qWZ2J?=
 =?us-ascii?Q?c67bhdrCfgy7KLPGVGNgZEQo3+RvefKurz4LDYZyH+uVAKLpuynFY7cx/zN6?=
 =?us-ascii?Q?hFnMXhlp3S/dIC0MJIobFXSQaXtgepdw2TLArfDYxRx10SPTnyB2NIUh/JHr?=
 =?us-ascii?Q?Pxq/jKzdx4R56W/tHeJNOQrPUP1zvFujAojYGHptUUnSjY6hwn60SMumxqk2?=
 =?us-ascii?Q?FSAGVGe+dpWhZAt6V1RA62LfDPaCrR79ro9+VnMqNEXMJDvWA3z2kY+vHdqc?=
 =?us-ascii?Q?FmqoRA54GXo5usJC5syfZCt2jwcVSjAbFEoP+hAqKiLM4B44l2dc6/eE1IhJ?=
 =?us-ascii?Q?u2TOFGtGLKfOl4TTIE8hX7j0PJD2k0Lo5qWu6IUk8i48BSHNxFzTajA8sipJ?=
 =?us-ascii?Q?mVHGsPTrI3XXzpwa70euiOWhD1Oep0ISOzkFJmzSmW+Ng/NqsTz8AKaFdqpC?=
 =?us-ascii?Q?WkxgdbcNS2uqDTb7wVGrzQPsokQQQ6VzaKKqz0egkSgBnDrnXNnu/m7/usDd?=
 =?us-ascii?Q?ClOuzHSdFMH7bAWJGDyLWdKvnNg3CIrkkTcEu0Fny0S710JsrdSTzauN9A0s?=
 =?us-ascii?Q?M3f0w/WiYY13pokfDeMi3rhahqkju4Pk/FwoB4NZSQsx/paDghR5B4mLHRb0?=
 =?us-ascii?Q?Frl5vlYRqihvKd/GQSexNKwp5DFrD+cd2X9bD4owIQVhcslD8L3Wsm2W2sup?=
 =?us-ascii?Q?0z0DV5teCGBn+a9HUeXxnKBK1Go1n1XH/5ae6QZ+dfAMxOEhOXwd5EoR1bxf?=
 =?us-ascii?Q?Dn5+juNgYW6DtU+lJdyWL8FBqJB5TQGx6RZrXxYiV/Bxzk0oL5S7GA+hmDk+?=
 =?us-ascii?Q?gscNJi6dS4OyBQyVPxApAjRVtB7VksVsOYYdz41MHZa5cS6vKqBqtQ8ZCBPt?=
 =?us-ascii?Q?+PCkXvad4NY1CppyCahi2XU2rNa622kyPrI10jxW8N3J4pEv7Fm7mSrfr9PG?=
 =?us-ascii?Q?hbbHGMjS5mQnoTYswewH2yBOsvvgbqkNd5Ss8qRXeGXZ8zFkPLLJtm2s/+31?=
 =?us-ascii?Q?uOYdhcbLdrWJ17DmYr5Vj2nfDqpzObDrmtYYfum71AgiP0AjKBadmzi/9Ftb?=
 =?us-ascii?Q?Y+svm3WR7LUUlwtJxg/0TClw8HSW1TDZivpps5fl7eKlbccAA3cKGTsmORRR?=
 =?us-ascii?Q?bofMDylOsJg2qpjdF1qLGXD2C+rg2p2hvagRCgpaGPD4UQOBKljlI12A3xv8?=
 =?us-ascii?Q?dmgjLY4B1qtWpnv83NZC0g2Ur1zOhMO3ov+gqvGkKiSG6Bw5z5H716R09vb9?=
 =?us-ascii?Q?R8/FQFj8+SIhxAsq0DPoW29kOgw3XEDiZmhZIbPQI9M7SMps4IYjDjiFGHVr?=
 =?us-ascii?Q?FMIaDpuMxdHLAHxtuvrO8htzEd33MP2GK2ItH0yUwtPKiyP063a41BHRxOSB?=
 =?us-ascii?Q?r8zvhBUCSleqq6YNT/ZffD64yM6uZj9L9qpwahdrLu3jKenMGLSVF2iNErHy?=
 =?us-ascii?Q?KXjeBjG7XmEbljfWhIjwgeIVKjomLQRPdNqEOu3seuY6V9jdRK58l5O+kjE9?=
 =?us-ascii?Q?Md1CLn1Cocos7V6+WJk8TxxUjwTES2Hj5GOgExhp2KA7mmtrtkZp6nyTb3D6?=
 =?us-ascii?Q?pV+9+/VFhHv5Zuoy41P6Uf/jlsftNNMMc89s6FCO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd70b47-acd1-4e80-eafb-08dab0dcde6c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 07:46:29.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57Xz/shAH9wqkKCNv2S4rmEVaLPnJFi5l7y7HfSWtX8r8rCwysuahHL6ho8uxx2k3geYTGueg+dHI6z8e1lpeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a new sysfs node called gc_urgent_mid_remaining. The user can
set the trial count limit for GC urgent mid mode with this value. If
GC thread gets to the limit, the mode will turn back to GC normal mode.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
 fs/f2fs/f2fs.h                          |  2 ++
 fs/f2fs/gc.c                            |  8 ++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 10 ++++++++++
 5 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 483639fb727b..11ce4a8bdacd 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -599,6 +599,13 @@ Description:	You can set the trial count limit for GC urgent high mode with this
 		If GC thread gets to the limit, the mode will turn back to GC normal mode.
 		By default, the value is zero, which means there is no limit like before.
 
+What:		/sys/fs/f2fs/<disk>/gc_urgent_mid_remaining
+Date:		October 2022
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	You can set the trial count limit for GC urgent mid mode with this value.
+		If GC thread gets to the limit, the mode will turn back to GC normal mode.
+		By default, the value is zero.
+
 What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
 Date:		January 2022
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..2f33d6f23a26 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1736,6 +1736,8 @@ struct f2fs_sb_info {
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	spinlock_t gc_urgent_high_lock;
 	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
+	spinlock_t gc_urgent_mid_lock;
+	unsigned int gc_urgent_mid_remaining;	/* remaining trial count for GC_URGENT_MID */
 
 	/* for skip statistic */
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4546e01b2ee0..39d794b33d27 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -104,6 +104,14 @@ static int gc_thread_func(void *data)
 					sbi->gc_mode = GC_NORMAL;
 			}
 			spin_unlock(&sbi->gc_urgent_high_lock);
+		} else if (sbi->gc_mode == GC_URGENT_MID) {
+			spin_lock(&sbi->gc_urgent_mid_lock);
+			if (sbi->gc_urgent_mid_remaining) {
+				sbi->gc_urgent_mid_remaining--;
+				if (!sbi->gc_urgent_mid_remaining)
+					sbi->gc_mode = GC_NORMAL;
+			}
+			spin_unlock(&sbi->gc_urgent_mid_lock);
 		}
 
 		if (sbi->gc_mode == GC_URGENT_HIGH ||
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..13919ad152b7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3617,6 +3617,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
 	spin_lock_init(&sbi->gc_urgent_high_lock);
+	spin_lock_init(&sbi->gc_urgent_mid_lock);
 	atomic64_set(&sbi->current_atomic_write, 0);
 
 	sbi->dir_level = DEF_DIR_LEVEL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..b4476adea776 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -539,6 +539,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_urgent_mid_remaining")) {
+		spin_lock(&sbi->gc_urgent_mid_lock);
+		sbi->gc_urgent_mid_remaining = t;
+		spin_unlock(&sbi->gc_urgent_mid_lock);
+
+		return count;
+	}
+
 #ifdef CONFIG_F2FS_IOSTAT
 	if (!strcmp(a->attr.name, "iostat_enable")) {
 		sbi->iostat_enable = !!t;
@@ -826,6 +834,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_mid_remaining, gc_urgent_mid_remaining);
 F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
@@ -953,6 +962,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(data_io_flag),
 	ATTR_LIST(node_io_flag),
 	ATTR_LIST(gc_urgent_high_remaining),
+	ATTR_LIST(gc_urgent_mid_remaining),
 	ATTR_LIST(ckpt_thread_ioprio),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
-- 
2.25.1

