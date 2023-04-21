Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779FB6EB1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjDUSoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjDUSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:44:28 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D9173A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 11:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkHb5wczHY4StKwclaRNXC5uf7XlB5H+LHlCxIKy8t+9z5Gj+J0+MYiG9krSxa3XjzHa8GRALtFRbP3frveHJRbSIhFxozCosYb4SFqM8faJrBvDRY4EnTjBsaItzZLimbNo5HCM0r6tPxZrHVGBVRfRtKzr7GHRIW0lRZ/zn9yIquQeBj9NHSGFxUnjKhKqCs9OWYRZrIhU1O6I44UVrsNyXCWQAu8h1H5p0l/RVvNtjcG1sVR+iTMbseczZuY6W4CeCVm49TYpMSFxPlPholcYujzewQWGZvjDNjdLYtSE+xwN2R2uL2acKWkOLbcTy4cGozM/AzWj/Auruk3INA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAmwPvZJHPi5vGNadcx7LkJyKn8D2L6Kd93JeEnFhJs=;
 b=FlQ6QdCS4LwLL1FRoIB5sYf4Yf46U2aB8BJ1qch4RhPAcvddZ8vI9dC3lmV7zhJdXAgM2alUjvAeESWhDmaMxfp6KsalQ1lIHJ0194py7uU5fhpKISPLKFQqiTFrICU9vgurPyPXfOXJNALmnKVu+h1ocz2Aj5nkAoyGJeMhT7rC9IeN5CGrORitBJd+zlY+BW/MznQFR48VIgQP6dZRB4b1nqXtPttASx4WQH0KBroISTsv1DR2kLteeCz9/Igy0q5bAYjXRhGy+QlalJUjl7Kwor1gO6iXtSORyIrHN4TIQjKOiuyinpYVYiA9iPlX7/364UUsG0f7bsl4HMm76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAmwPvZJHPi5vGNadcx7LkJyKn8D2L6Kd93JeEnFhJs=;
 b=KmwvkcbA/eAe899+tC41G4kUg8JxGPeA3hOcZSzG3CJ0RsIBjufywSy3R8Fs3p4jB7NNdb7RYx5Cni8ErIwvj5KN3Efry7NvJGhEX2va9kBFa+6UPN0gQT4ZbLosypgcIGw4wPPFNS4ZaEqtHdE3y/WGW2vd0rv34ELgC88iRLMWxZqp1AiP4/E0Otpzh8Ke3TafIpKc6Pg6E9uab1gR8ECDQMO6s7bRVmUCSz0F6r5aR2T2dtmPaLTXe1heu5LV8AIInR4XPdvvjr1HFwUgJYSWpk8mD3EIWzDPIrv30KCREOHTJFkVPm9kpfc1of5BiOogwj9lZeqi40V3/nHNiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5604.apcprd06.prod.outlook.com (2603:1096:301:e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 18:44:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 18:44:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: introduce discard_urgent_percent node
Date:   Sat, 22 Apr 2023 02:44:11 +0800
Message-Id: <20230421184411.77009-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c3719a-a6fa-416a-186f-08db42986c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/U9DNIBJyBLjzBCB56BZPozj9oUXhSAr0/F1ef5Jwf6EQyqgZDiYLKMaEKa2QwElbvwwhx2preb4r02mwAG5vAaqtW1Y8WtMrss+HDdnzBYhRrJ0sjLZwnPhoAX6yqs/jdJ6DjeBBbvneHsejPI3xFzK/9Pk8zIgGdWwEBMsBQlTNAC+MmuBWb4wTkMLOsX6h8F5Ik4+Bh5VkcZOtSmQn3Q3vsyeJmEKJxmi9E4SLbfURq72RjX84YnKmKCg0a1RalaPgjtSwAoABHM5gGcZGLCzqVM8XpBOxHGIS5y4p0FlmPTi1YdXRYac//Ubd0i4X+G+7Un6UeSgvvPt9OrngkUPniWXQHJ0gtQ9HxEMlMhrcGm0NB4vQDPYX/a9BCqEgMfa625UdrZEgHzqUuVPx/XnvfFEE7nUzu34VH1qbozK5r/Y0I90jWBbNDUXE8erscNYEJSFXFNqlbOYOKJfzDarlBBf3j0Fm+APku5w55SsH/MPIY5avhCTetmLgKAEvdxbhyvZ7owOYK6CdFyOKEBWz+nZjWwHKR9OG+yPBazG9BEsnQ3iwr518JLvnivVnGa4Ztct/K26YKmp8TGvbom5vyqr/OZCkpcWRnIWwvGAclCkmqO68QSXiH1JgbP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(38350700002)(38100700002)(2616005)(83380400001)(2906002)(86362001)(26005)(6512007)(186003)(52116002)(1076003)(6506007)(6486002)(66946007)(66556008)(478600001)(6666004)(36756003)(316002)(66476007)(4326008)(5660300002)(110136005)(19627235002)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKM5xu/O7ZtstJlLGBK2ngFqcG6hZF5ncsx/uR+8NT3j3jDOCzHdzvpvhZ6N?=
 =?us-ascii?Q?C9uGgy1630Agp73aKThKYzVAAQbQLhd+FDSU/C3D9raqv8o0VhU3DWrO39jQ?=
 =?us-ascii?Q?C/Qwvwbubax4h86cqQbX3gxtYxmJH/+DU+OpXeWijUQmhcFzGDDSZ6cxTAHu?=
 =?us-ascii?Q?YSiCr+o9Xc2czuFLiW6Z23qnoj4eD9KWFqpQuKOkLXFoQdFnz1604ITDcp2p?=
 =?us-ascii?Q?3df157hvH9ddXgyTwg+jyQRwJ2+YXII3PzaOvLsQ7sQfK47jHf30eLMhptXZ?=
 =?us-ascii?Q?yEIzlgmV4jhrXZnz30p/4AbJfoqf5bxM83Aza5aZ4CeCKoiH0Z2GVK3K/zFi?=
 =?us-ascii?Q?tVM6wMYY+ZtF2pvqnbxfAbimpdeNUZAFXwM/5wO9Dy6+jo2v0IiNIG3M0IHQ?=
 =?us-ascii?Q?Gd3Slf6r5zWwHFzdVTVhybOVkhzIAPcHjmTw0QSpe8C6CgssAvzHMAhi7kdz?=
 =?us-ascii?Q?eMmdT2xCw8sum8S3zd8yhq7wZFYa0EUNbIsohUPKn06+TGCI92ZDSHluaBVc?=
 =?us-ascii?Q?jvDHpELdPY8YEIfydOjS91bhDKIZy2tRnjTaEoJBXXy6FcNFZAFt388NBVeP?=
 =?us-ascii?Q?xpV9iPd3qvlAPnG7RMkfCiOWIcIcHURVlUZVv7ckiXhbVl0PLq3LxDURbNJ8?=
 =?us-ascii?Q?PxLpIrzhu/wkVszYs8Po2utmw1YlQ3BUKQ3u4BqQC9Ha0YaOG74JJ5Eph7Tp?=
 =?us-ascii?Q?cpsMaIuVFPALno28el1cd6kNRozUn1RbDiw2Y77FeoEyXrDDv9VwYqPT+ZkZ?=
 =?us-ascii?Q?KVqvst9JK2r4kgTWGcb6y3VoDTsPKoFT4TWdoUzj/Y4+F+S4PmA+tHh22O2h?=
 =?us-ascii?Q?TJ9ZPRC+PPBqDOJ2bEceaNyGyp+UkfxVFTPPiDuYRdcb7tBRkB+eKsg4Lg9i?=
 =?us-ascii?Q?Xl4HolvyNzChE/rbptCQq0jphQvlCupfI8MaHevtKbK0gM1GKoihBGqcM8oY?=
 =?us-ascii?Q?3jxhBDxFj+VhNPrzyacR80cx/d4zfMoqLy8qDKzal9lou95CQfG6k15tXJ9V?=
 =?us-ascii?Q?Nh6g45fZYPy53oN/FMDyuGqXITeOyJgnbrW8eieHjEnO7Fi6lg+LgTjI61sC?=
 =?us-ascii?Q?a6K0RQz3hO5WvD108g2jAMRa4VtHLJVDqMxm6bmFPohiuUG0x+ALKEe0gqL3?=
 =?us-ascii?Q?ekS7t4zW6Vwgo/lHpWh2Z/cRgesT2JQ0Z2yjeYeOEsZKjdctUYLCZxaT4/mO?=
 =?us-ascii?Q?XJxTCMhg9MO+xNwBIauZ0yV0aV57yGOvfvmiA//e9QymEDFe6549mo4CWUlo?=
 =?us-ascii?Q?sPEyn376edGIr7VICSVxiDYeUTByhj8/yU+9ra9Z1aT1yfy/1siRKDDUAUkO?=
 =?us-ascii?Q?chZKWeXhFyzCyz76kss/XFVZVPJQnRwWAwfuO+zabhD5uRbOq47+O2Ht1NSI?=
 =?us-ascii?Q?4Du398A7tCGKPT6bjqlsKA+UUCF3ajBbTSFsNh8B+UqXnMD3f1LTJP1g/WRH?=
 =?us-ascii?Q?Lv9TWaEgpqewmJjgWUZ+AJ7puavVJKw5ZSwIyrHnpE0rOuAAWIbcqThUwdYK?=
 =?us-ascii?Q?5MYSfzpKPekH1UBOPF9uIEFtG8ZxY4tlFrgGlDkMUl+X/ddnfiTzD1uAPdda?=
 =?us-ascii?Q?7p1Shr1cz5A0dkmhrJbKgAqzZEEWJFb0WE2CobTs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c3719a-a6fa-416a-186f-08db42986c04
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 18:44:22.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrLgQtXWYw0e8IA5MGzt5YERl/EXyXDY1QtjZ8opgc/oRRVVpXZ0zLBRfni4fVQy/mox0ZRaEocUlZFIebHc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be IO performance degradation in the following scenarios:

  -The space utilization rate remains below 80%(e.g. 79%)
  -There are many big discard commands generated
  -Always have read and write IO generated

The performance degradation is due to a large number of undiscard blocks
while the space occupancy rate is high. Space utilization is always lower
than discard_urgent_util, so discard thread is not running at
min_discard_issue_time interval. Since there are not many discard cmds,
the !f2fs_available_free_memory(DISCARD_CACHE) condition is not met,
and there is no chance to execute the DPOLICY_FORCE strategy.

By adjusting discard_io_aware_gran, the accumulation of discard can be
prevented, but this will affect the normal read and write IO.

This patch introduces another solution. By considering the space
utilization and the proportion of undiscard blocks, reducing the running
cycle of the discard thread, and reducing the granularity of the discard
cmd.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 9 +++++++++
 fs/f2fs/f2fs.h                          | 2 ++
 fs/f2fs/segment.c                       | 6 +++++-
 fs/f2fs/segment.h                       | 8 ++++++++
 fs/f2fs/sysfs.c                         | 9 +++++++++
 5 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 8140fc98f5ae..2fcb80b073e3 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -740,3 +740,12 @@ Description:	When compress cache is on, it controls cached page
 		If cached page percent exceed threshold, then deny caching compress page.
 		The value should be in range of (0, 100], by default it was initialized
 		as 20(%).
+
+What:		/sys/fs/f2fs/<disk>/discard_urgent_percent
+Date:		April 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	When percent((valid_user_blocks + undiscard_blks) / user_block_count) exceeds this,
+		do background DISCARD aggressively. Does DISCARD forcibly in a period of given
+		min_discard_issue_time when the number of discards is not 0 and set discard
+		granularity to 1.
+		Default: 80
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d211ee89c158..7a7b380f5307 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -233,6 +233,7 @@ enum {
 #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
 #define DEF_DISCARD_URGENT_UTIL		80	/* do more discard over 80% */
+#define DEF_DISCARD_URGENT_PERCENT	80	/* do more discard over 80% */
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
@@ -403,6 +404,7 @@ struct discard_cmd_control {
 	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
 	unsigned int discard_io_aware_gran; /* minimum discard granularity not be aware of I/O */
 	unsigned int discard_urgent_util;	/* utilization which issue discard proactively */
+	unsigned int discard_urgent_percent;	/* percent which issue discard proactively */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a005948dca93..47a8d97bb291 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1166,13 +1166,16 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
+		int percent = undiscard_percent(sbi) + utilization(sbi);
+
 		dpolicy->min_interval = dcc->min_discard_issue_time;
 		dpolicy->mid_interval = dcc->mid_discard_issue_time;
 		dpolicy->max_interval = dcc->max_discard_issue_time;
 		dpolicy->io_aware = true;
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
-		if (utilization(sbi) > dcc->discard_urgent_util) {
+		if (utilization(sbi) > dcc->discard_urgent_util ||
+		    percent > dcc->discard_urgent_percent) {
 			dpolicy->granularity = MIN_DISCARD_GRANULARITY;
 			if (atomic_read(&dcc->discard_cmd_cnt))
 				dpolicy->max_interval =
@@ -2197,6 +2200,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
 	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
 	dcc->discard_urgent_util = DEF_DISCARD_URGENT_UTIL;
+	dcc->discard_urgent_percent = DEF_DISCARD_URGENT_PERCENT;
 	dcc->undiscard_blks = 0;
 	dcc->next_pos = 0;
 	dcc->root = RB_ROOT_CACHED;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2ca8fb5d0dc4..278b85acddac 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -669,6 +669,14 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 					sbi->user_block_count);
 }
 
+static inline int undiscard_percent(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	return div_u64((u64)dcc->undiscard_blks * 100,
+					sbi->user_block_count);
+}
+
 /*
  * Sometimes f2fs may be better to drop out-of-place update policy.
  * And, users can control the policy through sysfs entries.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e319e05cf23e..a0798e74a870 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -724,6 +724,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "discard_urgent_percent")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -913,6 +920,7 @@ DCC_INFO_GENERAL_RW_ATTR(mid_discard_issue_time);
 DCC_INFO_GENERAL_RW_ATTR(max_discard_issue_time);
 DCC_INFO_GENERAL_RW_ATTR(discard_io_aware_gran);
 DCC_INFO_GENERAL_RW_ATTR(discard_urgent_util);
+DCC_INFO_GENERAL_RW_ATTR(discard_urgent_percent);
 DCC_INFO_GENERAL_RW_ATTR(discard_granularity);
 DCC_INFO_GENERAL_RW_ATTR(max_ordered_discard);
 
@@ -1059,6 +1067,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_discard_issue_time),
 	ATTR_LIST(discard_io_aware_gran),
 	ATTR_LIST(discard_urgent_util),
+	ATTR_LIST(discard_urgent_percent),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(pending_discard),
-- 
2.39.0

