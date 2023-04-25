Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E006EE70D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjDYRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDYRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:44:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60586AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znn/e9CO7n5DxB7o0L1gPhO+t29QIl8L8houIRIhrWL+/rD6/omS9jwziqkQnEqFkjxJytGoMnIVhJVsPdoUOokqsgry2iPqdoF/9ZWQPJ3+VxPZVEXBUvl4TmDfbFeSpEa65olS8tbWlAsq90BGJ4N8kAhB6gsqvk2XOWOW8UtYQ23g7nJEZEO2A7MdQpJx9T5rahhLyQM80ex+qFfgl4/IP/gmKItlGkDOsHcpPEUwu3ko4K3mlgh3Gst0nfDgDGSlV2886op3+uctYXNOeTkbXcxqP+KYvumEG7PA0sZPBHhJiTyq3k359KuUae7YlZa1ZWTuaDhZGRtc7zczBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw0mEMKBPucakJ7PmEWsBqNbxhOtIZzkO8Mn7goxUN0=;
 b=HBcDUExPoZVI79SnyDf42iBPZ0Lok/cR15GP/F2iVLRIeKQC2X6y5sWMdmh2ooCIJXmhe3WPP6yIeUY6G+MMeW5imhJGeUqP2OfzlIAgZXBlumHYQapeOVTtXsGAHMdUK/5pW42/papJ8/8MHIuW0r4cK64vkunivVZE4gVFfHjRg3+rknkGRvM3xX/udgrY0Q4ptbC410V6CQ19a8jHO63vesZ+c+4KlwVWyaGn4+/k0TnfmUxzyDNxwQnvl4Ek9jFLz/64Ts5vZ+j/rjIUAobtsbO0PCK3wpyqp0dpSRbLLAEADFuXtbswPHjzp+Rzv3abS0u+QVacSOMHKBsxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw0mEMKBPucakJ7PmEWsBqNbxhOtIZzkO8Mn7goxUN0=;
 b=fgr50EFc+8XrwOVtmMmPYXCYSm902rVT+zEvDr0tpRaEYKBX3DgR7FI213yub9DRzpVvouL3n8FnCEDe92uUa3ftwrnpLSVTp2pGhZtcQrlCxFTOfv05MoxGmt3ILyK37KL7uPzpWgVwL0r++soQuAcvTI540Gy98vBjy7UrDgPRMbBjBLFSnI1O6muzM0RcsD1qv+dyimdPqppDUbMHQnkBzxMRjL4Orazg3FHidKI1rrBUwKi/uebrsUUqztCJeg/Whpo6Z67cxsNHu3twekcFaYrzmSIg3wOA7ySqqXhY8SL1ISOhlJLesToBKLkR3ZQi5Us1wT43iZmjwLcowQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6360.apcprd06.prod.outlook.com (2603:1096:101:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 17:44:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 17:44:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: introduce bggc_mode related api
Date:   Wed, 26 Apr 2023 01:43:50 +0800
Message-Id: <20230425174350.80714-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db0388b-7c2e-42cd-354d-08db45b4a741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yBC56UtnpYBkwX2YkhzguDgKX3mjE8jubgjAgkaubddN4FvAB4guMnXH9GF/fBwU+6y46nOf71Ba6Nd02fBqYHzURCX5GzadjjEU2/dmMlzMkOPCc1MzeLONm5p3shr6P1p6BdEwZVl9KUFyBMgRvkeG9i6XXKjuLZeV5FADhohpjEkxS6z9+CU4Ny+gOl8sfoelX4+pyZw71XXXbyiRXrPhDodkIdssaxFj7X5fKZxFIoGcJRqGfoy6JbNPza1REtKl/dcm5brjuWRJLGhNCzaKwtZN1jCII0G4uM5RdjYX7SbwRslLeO98yGeCqLy2ffYe3mm6kkSITddJb1sVwxPPPzRbZZsSfY+mulkmRad0Gz39VdOodt/ARTFkVYyS1S5aDz5fo30oAxqqY6a/ebr+BddaFemTyiRyB70l+gdB+voSzlNyf3HcVhiIFbbyY/z2I4gF9xR2pD43cSVkLLJ9WVo35+F/fFv01gDq52avC7RcAFZQlA5gSLFoSbo9NRD/qzH+rruN+4Dx4U1vVKGkmR848f0MB5epDkk/vmce/ZZ/6QzTX6Vf+gcDgu7U+7oWh9z6cXhKZ7gHJOC6Q9rCRfGpWB4jOqo1qU8tTb8ByOoWlAYmUY1hrRI1veQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(6666004)(110136005)(6486002)(52116002)(2616005)(83380400001)(1076003)(6506007)(36756003)(186003)(6512007)(26005)(478600001)(8936002)(8676002)(41300700001)(66946007)(66476007)(4326008)(66556008)(316002)(2906002)(86362001)(5660300002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmNApaXYVwZk8P1r+nZ8mfEOgZHu8TtANddANMHiUvZb60zFcyLfeHQkSfya?=
 =?us-ascii?Q?ttW3dQD3OBuMvSeKqVCAZ95pymBbghX53kMqmJl2Xyeo+EhoNu5od4xceP+k?=
 =?us-ascii?Q?yIgI47Gt36tJtlFuj/q3U/lj83SAKyW19rpZSpLWi+auzQ8BtJhqgd2gMXGN?=
 =?us-ascii?Q?NyukT6E8FJARYWm9YvavPlkSE2HKXiL7VsW6nXJP1RJZvdDbfeEQHq1azyzD?=
 =?us-ascii?Q?k/u6JxFlwkMxRamkRg30arFGRAKbppKTF+vpJ+ziNG6AADb5qOK0EwlrPYDq?=
 =?us-ascii?Q?P1Nnr0XDa84Iv5WYMqqCQ/CQ3zsbcO9sX5BEstloj8IWbLhWWM8SMUQARGzE?=
 =?us-ascii?Q?FWbFNrKNMpWQLww33zX08WGAS/us9qoF1YfB+cL4X5OJots+NbH3pWTljzPy?=
 =?us-ascii?Q?n+95mlAErLHvkiSBf/tiIvF77MFbl+ZBpwXk8CQNK4o2ExE6qSEv506bn6s6?=
 =?us-ascii?Q?kS0bCsggliSXSw+uJmxBlrMWawlQdXDoPVIjNn6Otq29JVe8GH1Kl22r8zGG?=
 =?us-ascii?Q?GllS3PihcmLJtDu/hyZZi17DRK1g3mZY/128LWIS6BQawNDOHaINQxx/LK0y?=
 =?us-ascii?Q?iQdL01wYQOv00b/4tNp+WsHAgVjXKs9MGuqMgR75D470LrG681k9yXkZjXKw?=
 =?us-ascii?Q?QF0T2DjgrK+wQnAgAl1e9BOMIOQnoBlo2kB8QGXOaJo7brlKOzi4v0lQNyRD?=
 =?us-ascii?Q?wRyhDjtYPoRHWdhQvOlrm7gwUAo41vPbycV50slaskP+ZGGdyIRrGrKCY4ee?=
 =?us-ascii?Q?e0cX7gB+nGxh2HQ3vlTiwVL/U208/DujeUolOJQdGJPqnifY5WtLQkZyb/Ui?=
 =?us-ascii?Q?hg4HMP+i0kzXxzT4nmRpWNYwTx9KdYnntr+T6kh+cfAAv+Ef9t6eAId/zU1h?=
 =?us-ascii?Q?VfyPDPxgKoZuvrjGcztS8Ye21pEPRSgGCJvIuYJoRW4HCz7RFXL3pttCnpsH?=
 =?us-ascii?Q?K5xdHhu/vyTyf4smMjDR/qcYLQaIrO/yDGBQNJvMBySdJ5tXxENBrv67ph1/?=
 =?us-ascii?Q?RcZCo0seyablH9St/SEwjZuLa/K4aHoXAKEPl8EWmZDwN8IPcUGd69gq9xK+?=
 =?us-ascii?Q?7kungbnXeIRIbiVt/orefSdFxxm1cnY5htDUu6qhAMcw2DF8jeU6NoV7esXP?=
 =?us-ascii?Q?02uzUZmGJQZPUYHG378JCRVuuQDd8B7RKYMcOm7XyMb+Ww+uKH/gHetz6yxr?=
 =?us-ascii?Q?WPO9wNfed9KS41MRJBk1OOn73QKrie5M7ZMQjTIt40YFtIx9AIwBhuVtS2Nt?=
 =?us-ascii?Q?JAYD/ih3m2ng0Tim6wmqqtaAZj3GCgbMzO/XwQrWiBd0TPA0KNXNUmBiGDke?=
 =?us-ascii?Q?Zdol2hntsDoNI/kThsYF5CuruWuvr8B1egDK3ws+n9x46xxJI0onomoKVjL+?=
 =?us-ascii?Q?lG1MiTCjSLZyNIb6nB5J9q9aY0hIcHy1owvwn60sH4HTEYqxhnLir8s/9RDr?=
 =?us-ascii?Q?Ibrby0EWIUL2D2MGYNQ009E18heMTx0f+WaoOFEYfPxmjSk3T+s7UL6ReQ/N?=
 =?us-ascii?Q?HiDnkSB9XWKw+Eo0+Qu59TtbbYjgKHyvyNDeVlzRivPhxeU1blJ6KTuIysEo?=
 =?us-ascii?Q?AaAZVTDSDAmr29makIWi50NuSFdHI+pvltRw87+N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db0388b-7c2e-42cd-354d-08db45b4a741
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 17:44:00.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qcfGuAKbEYeCN0zfpSzrobsuX0jOH8HrAdiqeB/Ixzt1ZeqHM0DNlal6HivEmP9BfIUVKM2oCekOgtX4pGqAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces bggc_mode related api and uses it in code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 15 +++++++++++++++
 fs/f2fs/gc.c    |  2 +-
 fs/f2fs/super.c | 13 ++++++-------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d211ee89c158..e507033756f9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4547,6 +4547,21 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
 }
 
+static inline bool bggc_on_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_ON;
+}
+
+static inline bool bggc_off_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF;
+}
+
+static inline bool bggc_sync_mode(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 61c5f9d26018..7a35e188c7d4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -124,7 +124,7 @@ static int gc_thread_func(void *data)
 		if (!foreground)
 			stat_inc_bggc_count(sbi->stat_info);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = bggc_sync_mode(sbi);
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9f15b03037db..9bdf4d703ad3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1897,11 +1897,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
 
-	if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC)
+	if (bggc_sync_mode(sbi))
 		seq_printf(seq, ",background_gc=%s", "sync");
-	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_ON)
+	else if (bggc_on_mode(sbi))
 		seq_printf(seq, ",background_gc=%s", "on");
-	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF)
+	else if (bggc_off_mode(sbi))
 		seq_printf(seq, ",background_gc=%s", "off");
 
 	if (test_opt(sbi, GC_MERGE))
@@ -2366,8 +2366,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * option. Also sync the filesystem.
 	 */
 	if ((*flags & SB_RDONLY) ||
-			(F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF &&
-			!test_opt(sbi, GC_MERGE))) {
+			(bggc_off_mode(sbi) && !test_opt(sbi, GC_MERGE))) {
 		if (sbi->gc_thread) {
 			f2fs_stop_gc_thread(sbi);
 			need_restart_gc = true;
@@ -4547,8 +4546,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If filesystem is not mounted as read-only then
 	 * do start the gc_thread.
 	 */
-	if ((F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_OFF ||
-		test_opt(sbi, GC_MERGE)) && !f2fs_readonly(sb)) {
+	if ((!bggc_off_mode(sbi) || test_opt(sbi, GC_MERGE)) &&
+			!f2fs_readonly(sb)) {
 		/* After POR, we can run background GC thread.*/
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
-- 
2.39.0

