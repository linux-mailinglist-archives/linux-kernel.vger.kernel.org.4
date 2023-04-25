Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803A26EE74A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjDYSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjDYSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:03:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31C17DED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/DWDayLGr35P+lI54/5MIf0dORsl2Rmdd/pEK51E9ZJBcmSB40RZ7JUlMiP5elNZilF0Wkgeua9IT1AMa9Sn9AJfrVaH9oM1JdAAYw1Vhovtoo+VA+T4EA4BAw5bDi/Z0YwUOwp0QFxPcO+kKrQUwptpqpxPqlzsJC1Vw3+q2nZKRvt99frSknKpuryARTqvHB0orBKS9YNM2euP9azJtFfRZ8688Jh8DUUX6mzEyUTsRSCn8zJa0WqCjzAvcXkqoBe0mBNq2ALiCCa1hd8bGpMBvYfq40q68XBLQA4dMMhgLbf7AxLjCL8zBTLpzBAmY8wgwoF9JeGwmkiHlMrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4KJ4WThwLq2cocKaOEx7oU6Zfzf1j5Y5+VfMZmDTB4=;
 b=eka31/Iebm17hKIxc67Z32N8OUWsv0h0zOwZ52DWwIbpwypHS6baYcM49tGX6mnzDR+9HK58K51pOLEFH+zKDMEd8tji72s5mXVqOkbcL4h3+ttZmGxMCoA51azPH1vcYXce7Y/U0DGIBgrsl0ieX7wGV7fW2eZ9a1boUKWVRsVcloJkYOTH9Ba8cNMPiKygMt7x54FJOENIKmqVBacnAohPwNQkhM/Ker9T7XZ+WQuZ7lECCfcCCbKV0gX6F1vsEx1H6g1i31YArZ1+ZbrsPumigJyjwDAQ+G4KuXxFbzlhPuDC9GlN+0nj4OZlxjjeB8CWGMwLW0Lq8o1tKaqMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4KJ4WThwLq2cocKaOEx7oU6Zfzf1j5Y5+VfMZmDTB4=;
 b=JsdWvpjI3FcCJS9JpxyMeiOkOROo7DWYhYs2Y4SsBXu22DKauXU9T00iBzwKHMCY1UXW1YeCMl84tJ896JlJIk4YK/njHAEc3ozvdIGxp7sU3e58dT6EAAY5cVZRdsyXCvCzHFGOlERmhGJKqyWWFAz6flY7V5LpG/TVGBHvQddKlPUaYJNdlLZVSHG51GVjCNU6kFgYcnkVebrpp5o4K79o1C/wYvlbeLlcLsjDzmPUkTBfgKMW4qjamomTJNKDOJXiLX82TbrYYppgcpDgH5NiWUdxN4HAh63d6BJwqBnIDk9M9wn+yG4nxHC3VwLNzkN7bffPAsw6p3SF02hWaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5967.apcprd06.prod.outlook.com (2603:1096:101:e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 18:02:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 18:02:54 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: introduce mount_errors related api
Date:   Wed, 26 Apr 2023 02:02:43 +0800
Message-Id: <20230425180243.9030-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: abd394e6-8b2a-4221-11c3-08db45b74aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6wWqfHntFjdI7i3hqABYcE5HYIBZaISHU7+SVjYBybJDFNPe+K/IAjXSlpOX9dnSRyJyj5l0UMOAkZi9UvLdrLsFDAWfcrkUInsPvIb4fHuvnfyzHphwTl1VOhi/mAf3WxW0EoWRUDgAcRIAwaTmSc0SLjzKbfPSeUTMXFbvh6AY3QFGjydPJ1LnpoQrKgNwO3CQmu2X0CQQJvlkYwd3BAvGr2vhoJtjdINCriIES8LayzvvWWZcJ6HVnl+6PBz1rE+tJo4wZTtp877jwfqZPC9rI2Gwf7gBgTiO5qiJeis40Yfk6TcPgjad8/0wn0OYWskAnRv832o8Y/3MnDXn6IbIAl2tgxVx0Ne1VarcxQROj0+SNfQNTXWCr31eL1Rm2mmQ9NXalnJIAr0ZsFohZ/PvzbMO4tFKHmMQYgkCnBYYMD63eMA5wazroe3NAhCmP59LaUS7BwiWpZCQADjWuDjAJwvbvdypsYxVQ6B5qUhj0gfnDI0oIvoO2dL++MydGnvig1V9Kb82a8iGVJSSFtfR3b6qt0uy3qzj2iR/zmATvMA1uZzp6+kwjyDysuIFWKJF8VAS4VWHP2Povf5PGKMmGVa5GF11pLk3MR8yRH9v6AqLvd2AQOXb4Mmg0om
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(38350700002)(38100700002)(6506007)(6512007)(26005)(1076003)(186003)(2616005)(8936002)(83380400001)(2906002)(8676002)(5660300002)(36756003)(478600001)(6486002)(52116002)(110136005)(316002)(6666004)(4326008)(66556008)(41300700001)(66946007)(86362001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Y/MSXrGXao//Row3UttJgT1yIMBeFsWye2R8O7xo/i4RKnZvL2jLwIWJowR?=
 =?us-ascii?Q?YpKcSwTulOY8RHWTHtfKkVVZIXDNMTiWDuu35bk4Xn4Kddm62t8vtoQZzWxa?=
 =?us-ascii?Q?MX5ya8SPjk8wv7w4Paiy6hN+PhK0emrexUY6evsMYrvYeRg0C3SvaaNAmsLy?=
 =?us-ascii?Q?tne91FkdvaIGKbjzdP4/u4mRRoxF1mZ16b+BLvR9sRE2Tn9tr1aOwaehEO2r?=
 =?us-ascii?Q?vLmQwYVMxApV7v02L7rhL6OW/MiPVSK/IDj/wmhZN/KlpMEWyngDNUcf58ex?=
 =?us-ascii?Q?0Z3gwz1bpAEXCowEYm2z0wrvKsj3oVDThQi0Q/YrAHHfG8QWgbE5QRZcUVKN?=
 =?us-ascii?Q?648sIEEXSDlav6Z2KpnGWOLOfJtko5XZgbULPaHEaVIFr8WZ0oI+mjWBQIt6?=
 =?us-ascii?Q?z5sPQwC2Qtk1GVMhYqRWsZcsWjJewt6F0tJb1HHB1OkwvtbMlT0NzsThcR2Z?=
 =?us-ascii?Q?mhNVPR2PgTomauIDnvXtMoW/o38pO9uDbxmzmQNz6bDKF9xm439/ahuPm525?=
 =?us-ascii?Q?hAVpj2AQ4mkuq96fqIsDef92sqku27q/38ZHKhJt/t2e4Of4e4qJeZg+QYYR?=
 =?us-ascii?Q?Z6b0TQKirV5Xr7FpLNoABroNAUQjX8u0NH4pR4Y58mPab3KJj046o8feULGA?=
 =?us-ascii?Q?BeVShIM5feUvT8iwKb1gQiqPZcj74XwfX+wx3rL4LyzjXE5S0O5sj+/KvqOj?=
 =?us-ascii?Q?mYJp1fbY3L3AGwCoMztZ+FTA8piXE3hw+sj52OWdmw8OZdHTugv52lp8fsJS?=
 =?us-ascii?Q?wsfMNr6yq+i7QXxhMMUcQtQ+FhquomJn2ZXhDH6reR42svTTGCNLmf++3uCt?=
 =?us-ascii?Q?4G0lduC0G/qxGKJlfHn8gs0XOpxSRHFy68ATy9yvqZ6pWPXncH3JPj2CIjbp?=
 =?us-ascii?Q?gcQFVokxfpd8I5hSkgGEcPBCIe0EeyVlUAl1lVgWayDjnKWtnc2WswesFJhQ?=
 =?us-ascii?Q?wRjihfHP5c8ueNc3iVTWhroPFBLTOPFaHgNcbImIEMSV4yPGJqHWKw7S7zjl?=
 =?us-ascii?Q?UufUQV3ZF/0as7Orrhv/tZ7SxYSAlYJzmN2azBylPDg3hU8mPJi9WvFyaRH4?=
 =?us-ascii?Q?C/B/qjDToKLeXz7t0K2q7ZnUP5DqCL1+wxeNOPFmilhlghK9nUT1nQGSFctj?=
 =?us-ascii?Q?Xt9sCOC7W9xJEFHEQfw9R1wqmyBguWGDwQ++Ui2cm4gfVot3g9Bj8ORlDtKb?=
 =?us-ascii?Q?UwNVIYz12YpEkNNH5J+gpxE1tTe5gndO1/ThdoSxOqaS3OXVMFb21osaECdX?=
 =?us-ascii?Q?oltmTnTQ9SzosQcqy6URVSDuzl5bsP6lSxZInt84IE5A76SIRaeRBCMvTfg4?=
 =?us-ascii?Q?JucpuRASfNWkqbD6+dJ0x7rM+IBZHcaj1V/nXQw+atRRTdnrYl5oAMZwVWFu?=
 =?us-ascii?Q?6hAaU34ZBoGDJutEdznb4sKtRxcUUsde04LWXsQI0raODjgu+3cs5kvVylCa?=
 =?us-ascii?Q?xz+tXEwkBKQwlZpl9X3jz6Dfkf2w6MMzJ0HBT8r2LkBtLY7iPv+ZEz46oX6P?=
 =?us-ascii?Q?XTPJAAdmdzyIixS4yqvNFT8t3mNS5CNRn7VHy92KDeWw8C1AwbujFyVo2IMi?=
 =?us-ascii?Q?5YYst/+HY28acZdcv3WL7nhzG67lB+YuLgbJ/NBE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd394e6-8b2a-4221-11c3-08db45b74aae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 18:02:53.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTclPY805kkDuXa0d7bGlwBwLDZWu9vX5x+TOBhPQyDB6N9DxoZIg+W3/Rm5zldgeaT09d86EJUXe8lgiv56qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces mount_errors related api and uses it in code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/data.c  |  2 +-
 fs/f2fs/f2fs.h  | 15 +++++++++++++++
 fs/f2fs/node.c  |  2 +-
 fs/f2fs/super.c | 11 +++++------
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f26eac327d6e..475635c0a905 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2809,7 +2809,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			goto redirty_out;
 
 		/* keep data pages in remount-ro mode */
-		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+		if (mount_errors_readonly(sbi))
 			goto redirty_out;
 		goto out;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7afc9aef127a..d75f58851b58 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4456,6 +4456,21 @@ static inline bool f2fs_dev_is_readonly(struct f2fs_sb_info *sbi)
 	return f2fs_sb_has_readonly(sbi) || f2fs_hw_is_readonly(sbi);
 }
 
+static inline bool mount_errors_readonly(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY;
+}
+
+static inline bool mount_errors_continue(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE;
+}
+
+static inline bool mount_errors_panic(struct f2fs_sb_info *sbi)
+{
+	return F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC;
+}
+
 static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 834c6f099c95..168dbd884631 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1597,7 +1597,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		/* keep node pages in remount-ro mode */
-		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+		if (mount_errors_readonly(sbi))
 			goto redirty_out;
 		ClearPageUptodate(page);
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..107585797ffa 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2076,11 +2076,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
 		seq_printf(seq, ",memory=%s", "low");
 
-	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+	if (mount_errors_readonly(sbi))
 		seq_printf(seq, ",errors=%s", "remount-ro");
-	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE)
+	else if (mount_errors_continue(sbi))
 		seq_printf(seq, ",errors=%s", "continue");
-	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC)
+	else if (mount_errors_panic(sbi))
 		seq_printf(seq, ",errors=%s", "panic");
 
 	return 0;
@@ -4049,8 +4049,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 {
 	struct super_block *sb = sbi->sb;
 	bool shutdown = reason == STOP_CP_REASON_SHUTDOWN;
-	bool continue_fs = !shutdown &&
-			F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE;
+	bool continue_fs = !shutdown && mount_errors_continue(sbi);
 
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 
@@ -4068,7 +4067,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	 * could panic during 'reboot -f' as the underlying device got already
 	 * disabled.
 	 */
-	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
+	if (mount_errors_panic(sbi) &&
 				!shutdown && !system_going_down() &&
 				!is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
 		panic("F2FS-fs (device %s): panic forced after error\n",
-- 
2.39.0

