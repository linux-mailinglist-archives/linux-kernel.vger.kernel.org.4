Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3A6763EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAUFMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUFMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:12:31 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729AB73145
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:12:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub1qAgIfOpoXscYD1QQo76IABuXtiK0R8gAtjcB3qIYejCCL8tYe3YRnULcez8UIWPU6vbpXi5PXdDzl8bGm/FUIQPXzoGxqyqeeOiYdfp2pW/PRIKEE+e96DSN6/zWwFUyduuytzHQQZHVlQ8TC6e2aRv8ya1nHLc2msi7Kz6MMMfpC9sWhH2QjBXXFVB3wud9szLUKGeyzq1hvNAfeN4H81q81u4HHQuZCoApeQwfgjbtCn4TPQ9xBghplGRZ9G62o1ewpnNSQsz2VyCLTZ9MvwCoCE9wvcBEfpz9yymJD4O7/LwZcNt/M//6Dc/r/i/jxxGqtNYVqY8I56TzYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QlNOhb/vZmUKtW3U4P55tgvX0xlXx7iG2CVOS5BINs=;
 b=evXNVNDzvfEvwVDNKVd5J2FofBLkFpNMG0mC2CIzUPdu98329+05GTmGq8ldCy0GSxVRj8O+x9O/0bmBNAJ0U7mJyYHTbQeiDmMtRM8S4Xkzrou4k1x9TF4GH3Dk3pHhDK3fhAMzOAClJbjITr4h3zun5Yfx9y2IQtvsrsMuFj7uZJM3eLFDrIl/8IbTkrIUlDPwI2MyRLkn1y5tv+4DZ43Xd0LwhmrzJF1mKdAd/NJ5U0y3lOlOTtTVrpOFhl+czZotgTfgblWkdf4zJBJ+2IM7baSILlCmPIQQqk+PAbdFuHuGGj67Z/KCHXIzBDt1WpUrcOkZdHddQe0I6fg0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QlNOhb/vZmUKtW3U4P55tgvX0xlXx7iG2CVOS5BINs=;
 b=ek62lkChsNTqV3ZHXmrmhZ6YdqJkqr/2H6DNnGzHSgjrahqqCH1c5UtaR1hQJeG9PZYebgV/FDlNsdE3s0P2Mfhs2Rah4JkQ6BUtyUHd9S2touDM3w4JU+TyUcr92SYCQ3LUDTvcGhT00YbS0eOGcMRQxH8kdfCq8Gihuo9eizuDDBuHdGw6KTr+ughUnQ/ieXvG2gE0aiRWO3tHl5w8ZBvu+Z7+c/gD7ksCZAmvxflyr+7Qnm3iekYgRLaILdnNw3VQtgZZXMphcvT/5zdbAxtOsYgMhajenWqTefP5MSNBrhD+7E6k6u/SHCKhD1rzxG2r1ZnJfNE04/ryzlY51w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3885.apcprd06.prod.outlook.com (2603:1096:400:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Sat, 21 Jan
 2023 05:12:24 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Sat, 21 Jan 2023
 05:12:24 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 4/5] f2fs: introduce ipu_mode sysfs node
Date:   Sat, 21 Jan 2023 13:12:03 +0800
Message-Id: <20230121051204.81251-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230121051204.81251-1-frank.li@vivo.com>
References: <20230121051204.81251-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3885:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d3cdba-a721-4d2d-5a0e-08dafb6e1531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZEnPrBsUMrLyJR6zajh61C1G5cOdeyvmCrzUiieHidjHFev0sd1k7f8Cj9ElzlKpLhkMEoLXXrd3k89oD3uYIaL0Wc63l40y8UTFNMHqbb2e/V/aQcXi4c9lNnFnLaNtnmpKim3OzIrqSi+1Pr5VSnGHygwZKbFbdgPI2RyOOnNOA70RbULOx8l+xR6X0xSKHCCIgvhqHC/za2DmP6X+e60eq3Jp4e6QDew6vzoxeZXSzAia7QR4jAA1u8u2QmCc2Tx83w4YUcC+RmRhefoCIb1a9nbm4FPfo6pd05bV6I4nUap18fCKzwcM5hlR6TFLjOUvYrMgN0JxsZrS4UH/7Th7wkuNqA7t913cU5CwyE7iSG8fnwRZbqJSK6whTpPwyj8MqR1BmDDLSrI7NNfoAmUFAzqvb1TupZtdzVzJHN2ZzDzid4O7PgJVDpRqFQocRfUjYOAgddbTpIEYyHNp+CqvVVqRxfwbnVJm/c3OIk2K+QqgiTXon6Ad9RnQt1xxZtOAsJch7sI+rQxhoyc4r8pi8mCMEAhgu5/gzDJqkmnAsRbsh2uJMQCc0aBmOq8tE9FnX9qhUxQmpnP/z/k8SyZL0zkmJJO0ui3CJWWSta135+6S/S+smJ7Ge+bZ6TsbVv/v8llIArWzBRnQZ0Fhk9owbIyrlRQE95HUyKlidMj/pFQnzEI3TF8oUataCXXw3/NRoLbjYX3OeMqILDoTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199015)(38350700002)(38100700002)(86362001)(6666004)(5660300002)(8936002)(2906002)(66556008)(66476007)(8676002)(4326008)(66946007)(41300700001)(1076003)(2616005)(6506007)(6512007)(186003)(26005)(83380400001)(19627235002)(316002)(107886003)(52116002)(478600001)(6486002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxvugdCBnbopGCgsu+l2VKEJR6sPbIFpbIoS7ygx6P904pthxVuTLztXOVXj?=
 =?us-ascii?Q?jAzzLzxDaLzUT4DiX8+Sxya9BskOWWHuwxQfXehx82YZLO/iaTMwvY5ruQIW?=
 =?us-ascii?Q?HAb3+pUSC1Fkquh8vim/t59ADNtBpvgQFWBhw02HprNdjUDPSiZ3X50UUz1q?=
 =?us-ascii?Q?epmzKnOKUYoLCgVMVm+PynyxWyZNWCps7CH9k7PD8pxaM4Ip91IdYpmbOAOT?=
 =?us-ascii?Q?D7rfItz8xY+kGeui8BFI4fnyetUoTlFbciRzsLfYWWElTRI9f6wUBslrJzwU?=
 =?us-ascii?Q?Uo4zS+C2dSDc4FhT66RhnetLkxgJ7/0SDxswuYp9LhIdUJIxADCyB4qVayMO?=
 =?us-ascii?Q?y039m+qovPXGNkmuuKYskWghSpi8cleo/YnOoFkLodpjnDn8yB2F9w/4WnG3?=
 =?us-ascii?Q?ccX6eRLv3SHFqlB+O4G9x7hGtaZR0uhj2oN3+PY+ieWpXCdzzp+tO9/y3Qz7?=
 =?us-ascii?Q?XbZEn/HyeGJ7s+pOm0cpV5lfIVwstmz9J/fda2jrpSH6d1xaev0KSIKG0zjW?=
 =?us-ascii?Q?q/vEWtTg19ZKCurkaUnnqyAYJW7hKoxiP2yOjvGgRUrUoAUC/BqvJRP19Wvl?=
 =?us-ascii?Q?u9q6tQO+LV4Nkn7g/cToIwOEKHwTaEpw8hVNb53+adiJtIgPC66a5Iib07Cx?=
 =?us-ascii?Q?Uw+gNiq1VBfLpH9xe4WkImFYv9eFLHeuD08psAvEEoX6q7JJFtChaBnCLV8K?=
 =?us-ascii?Q?KjiYS70Md+WtJhSQCfSfxijVrnQTvk0zA+7QJyIAcKl1B8W3dBPDYpc3E9Vp?=
 =?us-ascii?Q?aUUaS/EgCFw/lOJ4Jli3qhbV6MWfxFIyYrx9hR66rrD2rm40p1CKjiFm0ztC?=
 =?us-ascii?Q?ekvyApVefaJOqNXtN1CVSlcKQsqCzW1EDUWvNQoH/XV7RQd4a2DE/G6fHFjX?=
 =?us-ascii?Q?SOiGl5vtgBgVJJZhrnacdCvX2tM8JVyyhZdae8v0eT2OGV5POoeu7E55mnYh?=
 =?us-ascii?Q?l3/U3/Kf3+KJxXDSglozwjXs0QxzoVVZj+/yRXRgqAonk0/NdafqpJtLtBQG?=
 =?us-ascii?Q?YIsd/wQyikUaIpj1r/mGYZeIY9Tk1KwBAU8V2Fd9o5RV4YSBzblnmiAEc71T?=
 =?us-ascii?Q?0F3rc+PL4udxAm+T7c6JTpht5CsEBZJPnFv/FF6WD2D+4kC9kfBFXrB6IcPL?=
 =?us-ascii?Q?/05FMppsbLLxze+qfF6pPzR1BR2V3dFLeaGSxVXOJRExWAP/UekXff9f7UjX?=
 =?us-ascii?Q?fPWZ+xbaKhSWvNWpxx7iepy6HOxvYIVYuQfREJfMIx4HwY6XUL8w8YFlSw1G?=
 =?us-ascii?Q?3JstBNHxQHCT2s6oKchkhnsjjizgTYw9s8E1gx151gRCwGUovp8e85OJnR6W?=
 =?us-ascii?Q?JzDs8fSFzlk0667zBb+5obNTPgP5QL4sS+7sRvVlDFyeCFMJ6SpuLpv7Whzd?=
 =?us-ascii?Q?X27YkMeBTAaJMjwlDCkN9fZmSMefu/fpLanr0pkTySATyz+XXvTpfD0uwd4B?=
 =?us-ascii?Q?KiOkSbzinsmRwLgGT9RmE4ZFkFGau8oK8WCrYqxY2S4l8wwv1NCo7i5V2C/j?=
 =?us-ascii?Q?uB+BCk6+XuNcybQSvND6bVhp6nThJfeXgUQh4rb4M0F1mUD1q5AejuZh50La?=
 =?us-ascii?Q?xwj1cs9XrfVSey0crqsBu+x+oeF3eJzbMrIQNhTd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d3cdba-a721-4d2d-5a0e-08dafb6e1531
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 05:12:24.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWao6zwkOyVyj/t6gP7HFHoP01QyPseeDM3pnbNw8/rvJc61z2BTF8ENkkhIwILNM8e98IfOoR56Z1MOhsI8eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ipu_mode sysfs node to show the current ipu policy as a string.
Since we use ipu_policy as a bitmap, and the bitmap API parameter is
unsigned long type data, let's change ipu_policy to unsigned long type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-remove type conversion in sbi_store() 
-convert old_ipu_policy to unsigned long
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/f2fs.h                          |  4 ++--
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/super.c                         |  3 +--
 fs/f2fs/sysfs.c                         | 28 ++++++++++++++++++++++++-
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0f17adc80488..64b15a28fe30 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -722,3 +722,9 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
 Date:		January 2023
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
+
+What:		/sys/fs/f2fs/<disk>/ipu_mode
+Date:		January 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Show the current ipu policy as a string.
+		This is a read-only entry.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9edad9ccc2cd..b221a3bdb3fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1071,7 +1071,7 @@ struct f2fs_sm_info {
 
 	struct list_head sit_entry_set;	/* sit entry set list */
 
-	unsigned int ipu_policy;	/* in-place-update policy */
+	unsigned long ipu_policy;	/* in-place-update policy */
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
 	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
@@ -1323,7 +1323,7 @@ enum {
 	MAX_TIME,
 };
 
-/* Note that you need to keep synchronization with this gc_mode_names array */
+/* Modification on enum should be synchronized with gc_mode_names array */
 enum {
 	GC_NORMAL,
 	GC_IDLE_CB,
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2cbc24f64a5f..7d98ba537241 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 #define F2FS_IPU_DISABLE 0
 
+/* Modification on enum should be synchronized with ipu_mode_names array */
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1d2796863f8c..ed4a0a721116 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2155,8 +2155,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
-	unsigned long old_sb_flags;
-	unsigned int old_ipu_policy;
+	unsigned long old_sb_flags, old_ipu_policy;
 	int err;
 	bool need_restart_gc = false, need_stop_gc = false;
 	bool need_restart_ckpt = false, need_stop_ckpt = false;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 576e6416ffb9..15e9921dcb01 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -51,6 +51,17 @@ static const char *gc_mode_names[MAX_GC_MODE] = {
 	"GC_URGENT_MID"
 };
 
+static const char *ipu_mode_names[F2FS_IPU_MAX] = {
+	"FORCE",
+	"SSR",
+	"UTIL",
+	"SSR_UTIL",
+	"FSYNC",
+	"ASYNC",
+	"NOCACHE",
+	"HONOR_OPU_WRITE",
+};
+
 struct f2fs_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct f2fs_attr *a, struct f2fs_sb_info *sbi, char *buf);
@@ -149,6 +160,19 @@ static ssize_t gc_mode_show(struct f2fs_attr *a,
 	return sysfs_emit(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
 }
 
+static ssize_t ipu_mode_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	int len = 0, i = 0;
+
+	if (SM_I(sbi)->ipu_policy == F2FS_IPU_DISABLE)
+		return sysfs_emit(buf, "DISABLE\n");
+
+	for_each_set_bit(i, &SM_I(sbi)->ipu_policy, F2FS_IPU_MAX)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n", ipu_mode_names[i]);
+	return len;
+}
+
 static ssize_t features_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -711,7 +735,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 		if (t >= BIT(F2FS_IPU_MAX))
 			return -EINVAL;
-		SM_I(sbi)->ipu_policy = (unsigned int)t;
+		SM_I(sbi)->ipu_policy = t;
 		return count;
 	}
 
@@ -907,6 +931,7 @@ F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
 F2FS_GENERAL_RO_ATTR(gc_mode);
+F2FS_GENERAL_RO_ATTR(ipu_mode);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
@@ -997,6 +1022,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(pending_discard),
 	ATTR_LIST(gc_mode),
+	ATTR_LIST(ipu_mode),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
-- 
2.25.1

