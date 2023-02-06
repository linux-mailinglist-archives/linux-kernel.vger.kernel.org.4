Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDC68C060
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBFOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjBFOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:43:36 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3525B83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajUfrzlqCqTv1/lbKpXmtFL9EtRi6KlPtkC1f2JOo269ViL6EE2x3Ooa4PYvE3NVlO0+9XQ2XeZn/MPQeFeXbQ6d4/mTV1zUD0cQZDkt7Sr4b07WaTH3f9yUqwZgG3JF14/cHQE0Bew7KpPXOigW91mG4XRdYmQG/AA8LMw6TsS399tBi7n+eKDasLkV1/2nNsEbFGqEBelXhtnisulGBjPueVKcXizAFvyZYddlqPyE7PiVrwN8Cc7+6n5NUr6KPYCVTLib6aEadEqQZpGd5z/yLQQEx9/80Y1ST9IQdQS+t3zFa5hNaxgsmdUErGO0GUdNCqIhB6L9RIfJ73pnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKDgtqNwjIKAF7DrCZY/KgODMwK1Cbj9cUdQIRJFGww=;
 b=gVoQ/96AelaQfTNCGqdsIhBS40z6jMbstZX9DJvJ49hpspg2AO4Wcu7/Om3wIc8fFnFj2FWVd5NB4jDwOPWFS17MX2BqIq63V0Lo/GTL/1YG45dVOZqIVe1iBudE6zk7SXVBjYP6jIo1WY2urtWJQTQqOvQ9akBwxEPQsbhXiK9nywgc8ZEGYX3bpTdZjMej7UHTk16VR/DS4MZ1ADWy7nu9rRpJYjH6PKIA22LHDY/mD8Z/d4lOgJAx0cUSxDDfVQc29LYq73+BEV5BApd3MEhjOFo90gpZI7JLSE5E/DqVw5mxpn7n+bdVVrX9LylLNxxPoD0JLODreuEzxJMNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKDgtqNwjIKAF7DrCZY/KgODMwK1Cbj9cUdQIRJFGww=;
 b=F38r7/DPXyGRZPZPdTRn1uR4cnGyvMWvm7mqiKhSK5BH4AkzruvhvNWGdogkLsDURrzuzerazXBPdH/ztfAhsM+uU2BRoP9r9Ef367LCLnmO1aN9dkK1CZOJVY5CqiZZbaQt6gs3wt7IVAI9NZbG8qlZeA2vft/OaujI3Gv/7sv+3/j+zn4B0ycTLJc+mmN0/0/CH5pDxrta147hKYlGLNLNsdZ3iweGp4Rc4fL1wOFN5oZ8XvoDUg3x6ZqunViYhNe5Dp3Ni9UAazub3/CGSrfurKReDVy3ICYkuCNhklFCepHfmkLOzxOtym9AltNZX64qz+NXQtM0eWcWIKe0DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Mon, 6 Feb
 2023 14:43:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 14:43:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 3/3] f2fs: introduce ipu_mode sysfs node
Date:   Mon,  6 Feb 2023 22:43:10 +0800
Message-Id: <20230206144310.2344-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230206144310.2344-1-frank.li@vivo.com>
References: <20230206144310.2344-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: a9effe59-6867-44cb-5a02-08db08508388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsWSSTUpDSABPWgq60TqPL3u+cbgQpl+m+SG6XFHQvgaxuvCX6bmDexO9jaExuJ0taDqeCbePUtcJoRMcHWa+jeZt2bOLcxr7iTGkortHSGWR5kgHBe5d3dci9ukFo4GeLavIHK0hiXyt9Bqz4lkcvKsm47lxeQpnuaRjv3XgatX2yC6XrEg+ynQ9nIDrsnQ+T2i+S7E8d0Jt2JnDqaBDSkM5UW/olCac/rQ+/d868grxcOfFnVDJaGOHD1t8b5asX+RMowSHe9b+FS9wbx3kkweOdMLLdLNtqW1z/IMcjD7PT7SpA0/qt+XC32nZc4zsEGL1SN6NyeODYVYXq49/xRU5mnqliAClXRTeeRfVRJEdU/AWzKyq/BaaRahxhdvxaJzg3P8cFeaagr7ILAjFVIIiULN+AMmP0lQoEFMAtK8OOJSIxjMyFsvvfQ4pgWxqbCvnfYc7BtL9/RQzcfrZHB+ew/LrpVhAeYwb7LsJmlFQ2cYgagdiveekdPHAa7gPYzsrTXg6VrUxM2m8GBzqmch+TOmsnL7lhTVr+eLHAKGf9jn/fLavLHFqzzw5MpcWyKLxOeSv+rkkfk1jFdCuAA9udnTzCVpQamNipuRsqAm2YvW5I6gKCX0hlqtLyRGHT78+AsXpPsjYR3hrpCm/5ZYF/nPM1tY8/rtCwlDm0TIp5GBGFVqHbvVIHDrAFqklLLfuXH++oDZw31yYKuLPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(38100700002)(8936002)(86362001)(107886003)(6666004)(36756003)(2616005)(38350700002)(19627235002)(6486002)(2906002)(478600001)(52116002)(66946007)(66476007)(316002)(6512007)(41300700001)(4326008)(83380400001)(186003)(5660300002)(26005)(6506007)(1076003)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4iKy3MLQ3MOKvpatH9vbn0dCXWd3E6xxEN7coPJI0ya7qvhG+UGnLNL+UPc?=
 =?us-ascii?Q?K/1Q1whLuPm2rOfvnTwMn3ovJMsdS1tKwVsjnn/ORFtAZe1gdmOvQXRSDu+S?=
 =?us-ascii?Q?LBVvB/Hvqo0mWHois8mskSCQQQ4Eu5j86rQIaIeozsaZgA8Y60TQJAwUTH4Y?=
 =?us-ascii?Q?ljPfz1N0FcVGY9FR0Cg1vgM2AKAwgRRXRN5CvoxRYKBjuU4YGc18Itx2dKMA?=
 =?us-ascii?Q?Ns80ax5expGMvgklau46A9yOfQH4x4+JfxEBos99ukumjz6tGs1oI2FIeY+R?=
 =?us-ascii?Q?rljaVkWSliXiMHxRTyQWTW3cUDKq8uCdpnvgicNi9zw01NM033rsFoSXN+Rb?=
 =?us-ascii?Q?Z3pub+fiBg0BZedm2+D5xGc9BV1Bg/aiL1zd6JWtTOCWOfueRJJIabA2ZSl7?=
 =?us-ascii?Q?CVbIoCX6KoO4faGwABgmhNYuLizt7gxmBnPvJs8Exf1diX2dcDq97MwwKNUA?=
 =?us-ascii?Q?k894S1yT5HzI8m4+4ZPnwY86zhxZtv3GBRltq0ZFebtH/+TDS8VSz1qa6Cjr?=
 =?us-ascii?Q?cuj6FMSD5WhDBWxzxebU3JjmWJ20C9GyIZ9FS5Ztw32YVmV/xv3FACVqAm1P?=
 =?us-ascii?Q?tqdoUq0HIG97aaBV58U8bDciCmnkBBP2i2v9Jvt2DgQh6RdnmaqqhNV39gpI?=
 =?us-ascii?Q?Qk9TiYMXktxpfRwj1+STyCT7zceyZKSLv0fVnxHBRnqCL4mHU7pyjg8Safj4?=
 =?us-ascii?Q?LmhirMMsF8FPugJSA2QKetpL/jv6lEvHoOuPjJFp37D+2MPsG6bCJvQC99Sw?=
 =?us-ascii?Q?PFWw3BYeJyLTpvETdQUNFMxc7uKgldSkU97Rprm2gTMYzmeU23ugu996W1xG?=
 =?us-ascii?Q?lanf5mQfM+IAFCEvLy+K/DzzZTryzqQ8d+i42fUuQv6GpDgfhpeMkUtUrtCF?=
 =?us-ascii?Q?iaf/URDc1Alu5ipc/W+U7inlZoCOPGS8fNH/hkjafyc0YSs7Yv3guSrih5lV?=
 =?us-ascii?Q?5CHgEcAepggtxiBAMLer0VMR/iQ+fMnrFK7evHnUZwWJZ/sjqCqSFzqmRSkA?=
 =?us-ascii?Q?vzR6RrXDNvVjEuDYGsx4pMpmJyqY/+HjbP2kvB59W4rh2aAdKSXp/PGADxH8?=
 =?us-ascii?Q?69CmZHeOO4DxHLmtDETsmXhcdbZ3RtTvkyxWutV4QzHRUQH36cis/0zK5PTt?=
 =?us-ascii?Q?NwX4ALN+AijiiDmGtz4BneCFmj+I7Jf+jt43stJGcTZAy/uAQXOqoCuUQGde?=
 =?us-ascii?Q?ntErsD6G9X40bZuJdlERu4Z/crnN+WQABpcqL+hkgONQjL8kEX5K1wackDYC?=
 =?us-ascii?Q?cUXAykyilm3kxQJFG9XiEA3eCCgKG0YC0JGBT9W0VWV5rZrCuCISmmYGT/ht?=
 =?us-ascii?Q?8pLNhwxg0QRF45SjvHKD6KtTSJWBar2uZNiQNLxYojEZFNIlijWCWYi15sAK?=
 =?us-ascii?Q?jrbcmg5Yugw7mA2pyvj9KaqenhISRkUA2CmITMY+7xHfYMO/v+Fhv/E3Gzsd?=
 =?us-ascii?Q?6y/CU9dB3ifuRXe7+efRtRLwmv/jWg+izJP1jI0v1JXzcP445diy2Zn6V05N?=
 =?us-ascii?Q?AgED5cRp50ClAvgVE3s7h/jO91Uqs0Huko1qmvpB4P5IHCPYy3+eXNVzqE4x?=
 =?us-ascii?Q?v5H6B205e7bPOh2z6lHqi7ojtQiQixUztKDt6FPi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9effe59-6867-44cb-5a02-08db08508388
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:43:30.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/4BZNhisKfdyvWaD4YeVHXzKYhRmWwVFhJVt7bJGsKYK0xwVlTvooMfkc7PF71bloB5UTi2kZSFxvjgBVZPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a ipu_mode sysfs node to show the current ipu policy as a string
for readability, like we do in commit a3951cd199a5 ("f2fs: introduce
gc_mode sysfs node").

Since we use ipu_policy as a bitmap, and the bitmap API parameter is
unsigned long type data, let's change ipu_policy to unsigned long type.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-rebase, no code change
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/f2fs.h                          |  4 ++--
 fs/f2fs/segment.h                       |  1 +
 fs/f2fs/sysfs.c                         | 28 ++++++++++++++++++++++++-
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 94132745ecbe..b2d8c1e84073 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -729,3 +729,9 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
 Date:		January 2023
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
+
+What:		/sys/fs/f2fs/<disk>/ipu_mode
+Date:		February 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Show the current ipu policy as a string.
+		This is a read-only entry.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 44f2d76525bf..b699ed74f438 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1070,7 +1070,7 @@ struct f2fs_sm_info {
 
 	struct list_head sit_entry_set;	/* sit entry set list */
 
-	unsigned int ipu_policy;	/* in-place-update policy */
+	unsigned long ipu_policy;	/* in-place-update policy */
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
 	unsigned int min_seq_blocks;	/* threshold for sequential blocks */
@@ -1322,7 +1322,7 @@ enum {
 	MAX_TIME,
 };
 
-/* Note that you need to keep synchronization with this gc_mode_names array */
+/* Modification on enum should be synchronized with gc_mode_names array */
 enum {
 	GC_NORMAL,
 	GC_IDLE_CB,
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8ee5e5db9287..92c8be00d396 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 #define F2FS_IPU_DISABLE	0
 
+/* Modification on enum should be synchronized with ipu_mode_names array */
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3c3dae3ce84e..4a2d895cd52c 100644
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
 		if (t && f2fs_lfs_mode(sbi))
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

