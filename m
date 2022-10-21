Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC48D6074FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJUK2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:28:18 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748342565EB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTYE3zoO4unfhLQ6rAi6vh9xV9jXAdm0/FrkRH2ybSRh//rl12vWR1pcIaGI/s4om3Sd5Zheu1gr8BSpAKhIg4rEE+DzuDCvQ4reBekBao806GefaRWHAp3A7Ttzp+6HjcsAA1v7ExIETQ/GmsmdYDXCvKz1jE5Ztn1KPjzcqj9R8ymxz/NCwW7Jz7+qpRJ0vGkLewhqExMa5KwACSFKNeUhTXC0OzbcVm2fEnFzrLbqZtT/G4HsVHCcX+04TrxJ5ByXsdWlk4FR0/Krc4+d9pIYzbMK5aWQjYAHyeY7Y12FB0FMJTc/Lw5XsadWDDHe80HDVePHvLoEK2xw5QfPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg3/qsHJrk5suB5PcnPhWs0D96zAfpa6pmV4KfO8MGI=;
 b=PIWIl/V0V78gfbp/U5OWVGy6eJgFY9Z/hbpbrbQb3S4wpCqb/cTvAc0RhRwdX0Cc3H45O6Q29kDeT25rXfIl5HmbQfbBb+PYRAUBgRUAjv3UZJFZbMjBYegm0IgTifHGgvdCCjcepSIn6P6jF7FJIMuZfFb938fojC/6qAYmfXzaleQOzTwgRTiCscjjGnFHlgfHua5RoP1LTDWGgYxF2y+QdZRc1Co1mz+P8DNj8VTF2nq05XMPYkMCuDCg5r862dVJbQia8+SQN/FKfIIy/SLaOYYZqQ5E6imL9qT1kodxZpKLOL/PUtR+sqhviK/GkrS2Zxqs9yZuC7WBa7dMdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg3/qsHJrk5suB5PcnPhWs0D96zAfpa6pmV4KfO8MGI=;
 b=japW/9V/7gSzA9ZR+Rf5o2zBwpl/sf4hMEY+OJwSLungYjBXSCC9mt6WsifiIZwLXj79SZyAvqnkAgI/rAV65cIz94LSfjYx7sL3bMnsdJpQBHHd8oyPTFzIfQISKaoSFZcK5mLpGFvoy34lBOKIr4lVl8ltJECksKvLab+1ZI6bLv1PDX8ngkpd5DuTyXyWr9qWi8fvzWxJrG8XRuozZK2tMeKJLE2gqJkYedjeeAdZg+pg48occmp9ErkhBJoWEtOSMFkJLLYMV+V8JB5B7BUkqqKqYPo95xjYh7SGJEky6cW/z1IYUVcZBzZeVnnig27168qQ88STjILnuONtYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5711.apcprd06.prod.outlook.com (2603:1096:400:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 10:28:15 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 10:28:15 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce max_order_discard sysfs node
Date:   Fri, 21 Oct 2022 18:28:06 +0800
Message-Id: <20221021102806.25459-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 91df8b63-0fa6-4754-4ad7-08dab34ef641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lm68IejcCrad1KxI+Kz38aoC3vD6+70NkHj01K8p2vuizpiRwPsmSNR+QpNkzIt3P26eUZEQK1opsGE+p44Wvcl84ukRb/M+cuqOC0BB0VAnZ1ZfCVRo1lfC1N4l3VActzFnBYWlEVRioisxS8vOsLCgBP/T729/MbkwJfY8MaiJlYOegM7S+a/qxQ55A+ApcISXvzLslEpo1TOPzX0+8d0M5tm0vF3XLhyeilNTTG/Im9+ETITl02AdZzGLdqdoLcA5bZiUaiy57aGWQFEE5/6dHpNzB/8xsrAeIlkW6ZvYHFgo85FVPqPwDIolLfeU2FZwHwHMguDobmcyMTTuXx8oHe6Ge5dIoDmHcfvFMVfqurhyJJJJQPtpHE9kgNpZh440mkDH+wPzLd6hXXW92oVUH+be5ezvuOLbsAs6vPajUrW49sBhrI03NEV0w9A0SeH9+JOs24IVFnASpYxy7GIN1s8qTofxFixu2euj9aNn5J70ywMD+mjiGd3HOesNip6h7qD4kqHb6K+4AuRf1wPc6R/FsvqMHrBr126zobQWcSsXveCClZ3q81PFFox2p4FFFBT3ebAgdQCA5gs3aK4rjT0Im6pdaQG/MkkWIqnf+yhCSi/e+lCJcAJlZwz6S4bKTdeFGsTg+ifgjKPe1PbrFWU9G5X292g8V951xQWEvuS1r41siRDD0enOvrLBT5+YiPWR34hyHGleGy/eKBTU9Xu/lwcBm0a/s420vFb82zkSPTs+YLSqmXMFoouYVUrU825t01BnhnE4tShW+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(8676002)(86362001)(26005)(83380400001)(8936002)(41300700001)(6506007)(6512007)(4326008)(36756003)(52116002)(66476007)(66946007)(66556008)(5660300002)(316002)(6666004)(19627235002)(107886003)(6486002)(1076003)(38100700002)(2906002)(2616005)(186003)(38350700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSfPBl7bhCqOSj44NPyCK269s5Fxfo5XgXPqz2gQHMPOwpvTR0J8RYKN+Shx?=
 =?us-ascii?Q?rQE7RWupfSjIbQClC1v6tC88jzOTwx1FZ5m7X2VI6NbPXAyUAOzBik63GSFz?=
 =?us-ascii?Q?CuGa1is9NncOE3VA7DrB77KBU6JI5LX89OFFHSercNNBcjmaVGAqQ9tUSkkq?=
 =?us-ascii?Q?vw9wc1q2sFExP493jcQNSAG9HYQ5wooLO4zoihG0cRO/FMrL0ZMBSVL/kdpD?=
 =?us-ascii?Q?EXKJUbOWVLnYx6bXyauxW8XdSqfhA88KL7Vqsqq/nicHFsEZnSwh8LaWtIHz?=
 =?us-ascii?Q?kWZAWvxIe9Wf/c9zYJOYKR+By1tHYCiGIShflWD/CC16IMT7HJCJH1bnwI17?=
 =?us-ascii?Q?DD7eaSaN8j2fv72pUv+VOcNIUx7UWABWzG0I+BkWkYLZV3aX7IvJGaWGjcG1?=
 =?us-ascii?Q?exCSr7gal3pJaddEuVz0oynnzzBBEZBg1NOdg8b/XSXMEDvBlMlzzZQnGljc?=
 =?us-ascii?Q?S43Z4+R2ZR8MzLYfJhUk0RdKpQlRxGVNUMvlAVhM1yYg8RpQXRDoVf7H5n90?=
 =?us-ascii?Q?i8G/JYR412l/XoN6R8w3EPAE1kpbhcJsjAXcf5/7dFRqTwQgtj9X6hcug2Ma?=
 =?us-ascii?Q?VjFxtMG0HC6buPs0y2L41Qi6QEpE0jEuTzMcT8Ihs+mYvkmkIw5P/2Rl+sCv?=
 =?us-ascii?Q?EG7VUAjcG3F0n2bBT4T1rMQqPX1RyrUyW4Gu9VzBIn9tOxosD+WTtoARMA1o?=
 =?us-ascii?Q?2juOzSekbD62D7g5TOvQlX9/hr+v6VvzKMeha2rguMRwCg9t8cGvYljA2fup?=
 =?us-ascii?Q?FXLqzgSOajfEZ4jIdLPlnklYY+gkKnW7fVEWrMhIJew6p6QTMpnTfeFUdXOA?=
 =?us-ascii?Q?aJqrDLrWaH1IRgYVhsHZXv/iO8V+zuioonrwSN9+HEyby1r1uUR7dJfdROyA?=
 =?us-ascii?Q?qEt4VimBm4ZV46vVOPd6mMN9sgSrFf0DgcXUhrvI4JQPCfc5KXdUogpUe33n?=
 =?us-ascii?Q?wKPKN4fnoo0M5tZC5Tm4t6tVNR0Ye4i4QYfQayA7oCSNZhx/+f+i8gIHcQ/9?=
 =?us-ascii?Q?UptUzsBMB0PaxaHd7jc2WdulC293/uQXLrtLQMhEXDaPE0IuSU/KlvumCeLP?=
 =?us-ascii?Q?9StSDpxZyFAolylslr+0ixBO5pS9zUrGL2SV71EeHqebzbcsVLFCQJdv8c8Q?=
 =?us-ascii?Q?g0W1oSWcTT6eKZ9FeTktgcdlidNcUYbqebBDmyMsxsHd/TPyEoWVgF8quua3?=
 =?us-ascii?Q?0rH5gmpkqxgDngzQ3sqao4UdADsmhbjAXDkMVC/MCDWG8cJzRTvfbsh2j4QB?=
 =?us-ascii?Q?2aYqCvXAV/AhcJOULwOR7esIdtssxTZFRKlG4a2U9eNT1WXeXk8otQlYNaQt?=
 =?us-ascii?Q?MmRbGMTMD4gaSv27bw7poJ0QU4PEjz/UPPlTzytFalAd1+Svnwwz++QcONUj?=
 =?us-ascii?Q?vTaU08Bv1kDtfBt7k333LgEVM5qXSFIXM0rbHmvhT73xsbWdUbNkyWXqBd+C?=
 =?us-ascii?Q?hjLrJKVFLHrc5QWVBKyfsnbVGmos3glA5MxUbEocl+fGrTeqneLhyXelCTd4?=
 =?us-ascii?Q?rfKw1qZTNr5davMKdz4gRuh5rXIruM5XGnZ0SYeQYbbHO+9EIO9CCG9IT27p?=
 =?us-ascii?Q?MqXkfP24Iu/diMumIlXqW5FJag1IKI+WIEEyIKhC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91df8b63-0fa6-4754-4ad7-08dab34ef641
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 10:28:14.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqeMMswWGKIYk/sGtizn4IjIHl+mBv0AeI2SPN0vOusrGIqLO/VuQwpWSTYjdWO5+3jr3VFi18b4MK73U7qW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5711
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current max_order_discard is a fixed value,
change it to be configurable through the sys node.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/segment.c                       |  3 ++-
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 11ce4a8bdacd..8faef2078a7a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -99,6 +99,12 @@ Description:	Controls the issue rate of discard commands that consist of small
 		checkpoint is triggered, and issued during the checkpoint.
 		By default, it is disabled with 0.
 
+What:		/sys/fs/f2fs/<disk>/max_order_discard
+Date:		October 2022
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Controls the maximum ordered discard, the unit size is one block(4KB).
+		By default, it is disabled with 16.
+
 What:		/sys/fs/f2fs/<disk>/max_discard_request
 Date:		December 2021
 Contact:	"Konstantin Vyshetsky" <vkon@google.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c444f3f86608..070dee37b915 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -330,6 +330,8 @@ struct discard_entry {
 
 /* default discard granularity of inner discard thread, unit: block count */
 #define DEFAULT_DISCARD_GRANULARITY		16
+/* default maximum discard granularity of ordered discard, unit: block count */
+#define DEFAULT_MAX_ORDER_DISCARD_GRANULARITY	16
 
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
@@ -409,6 +411,7 @@ struct discard_cmd_control {
 	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
 	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
 	unsigned int discard_granularity;	/* discard granularity */
+	unsigned int max_order_discard; /* maximum discard granularity issued by lba order */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	unsigned int next_pos;			/* next discard position */
 	atomic_t issued_discard;		/* # of issued discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index acf3d3fa4363..921ec17a40ce 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1448,7 +1448,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		if (i + 1 < dpolicy->granularity)
 			break;
 
-		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
+		if (i < dcc->max_order_discard && dpolicy->ordered)
 			return __issue_discard_cmd_orderly(sbi, dpolicy);
 
 		pend_list = &dcc->pend_list[i];
@@ -2046,6 +2046,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
+	dcc->max_order_discard = DEFAULT_MAX_ORDER_DISCARD_GRANULARITY;
 	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
 		dcc->discard_granularity = sbi->blocks_per_seg;
 	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 555849d4c744..81f628aed2e5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -487,6 +487,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "max_order_discard")) {
+		if (t == 0 || t > MAX_PLIST_NUM)
+			return -EINVAL;
+		if (!f2fs_block_unit_discard(sbi))
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "migration_granularity")) {
 		if (t == 0 || t > sbi->segs_per_sec)
 			return -EINVAL;
@@ -801,6 +810,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_order_discard, max_order_discard);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
@@ -931,6 +941,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(mid_discard_issue_time),
 	ATTR_LIST(max_discard_issue_time),
 	ATTR_LIST(discard_granularity),
+	ATTR_LIST(max_order_discard),
 	ATTR_LIST(pending_discard),
 	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
-- 
2.25.1

