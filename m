Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41B62F040
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiKRI5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:57:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E98663C0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRydso4P/3q4AdZt0/LR2gTFlVCkd+0CLEASXQjDYXB5+jD4DdaDlvNx9v2JYNIP9/PEu2vruLBaAKzXOVWphhMTdAryD1aLAAtwhj1Y+b8v9VqKvNU7MSatnHYgklJBg2xJICMk24tQSZSqcOI6P9lSsZTbBtB9GJzF9JWiAhT9eoWps4tYAwqVPHb5ZBIOtmP93aDorBgqHBdaYBgLtlfEvEXNJ9n2K5mR9qpiGT0ucT7tbDxGn1L9Tp1zyF9E5UF6T7Y+epycB0alkrJu0900C8ekqvjwdPbWzi3sx0qs5QOj4D5j2lzvsIAkIxjIoAE2wjuJiAPDCTg3u660+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ym/lwxYuctC7huRuGkXibpItt0ONOOPo8wqS44nqAY=;
 b=RUWcQf4guPa1id37wZGrS4pBueSP68WJnEAmX/Ym7eTJGfOWUTIGEWThwLl9VUKmGtDnHZVvMFtGC52enOSVHEyIzLqjqiIkces+s45I5WvGv9/4MC8BZ+1t/4KTHqxNztSA4cjwss7z2w9RzVS7VAxxaoA/wmXPKnMQLN0alzSAsRTOR7M0JMTRrPRhpOATmDIT9GEswmlZSscNPElQEcolbktJJ9XqmcZgf+KGECcTD6bu1BrOxRejgyFWpGNMndvSzy8AZMaKrlB8GL2usy0mKrom4/iCTb4GPZnwO7zmYjaRbDU7Np4IcHje2YHDG8HmxyRFFDwimSvRDVKm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ym/lwxYuctC7huRuGkXibpItt0ONOOPo8wqS44nqAY=;
 b=Q6g0kD8zvo19vhayOdD+yAmdXmg4ARrUkVNSILVpc0R++XNY/x9OH6x70I0NfSgpi1Qqe+brjmPb3HEIRPoEKAaFhyZyyBCMB4dqenrkplrVSAjWANp4AYiI7Nax9zAhcBiSyBvwoW285KYpbu+27lwf9C6vLvws//+TN2SERWV+jeO/5GMLv9LuuaPclwd3iPhfB9tLgdA5TdsUMGobcM75S2qBi7I5gwJwuJ+Xz7iSPocu5sYT+cmMgEInyCgV1xsJvHPQvbmXM7pWmHFTpgrfDPTno9NTqcSdnGmuNX7vBFL0pys9brDYLzr2sa/yuZUBMe013Hp6zUr3Z5UsAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6191.apcprd06.prod.outlook.com (2603:1096:400:33d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 08:57:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%9]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:57:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce discard_io_aware_gran sysfs node
Date:   Fri, 18 Nov 2022 16:57:29 +0800
Message-Id: <20221118085729.58528-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:3:17::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: d24c681d-a6f4-4d2d-9961-08dac942f39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJuKPMt7l/qVlC3ebT8f2EmF1oJud9xQutMEIBxlK/PWSIutk0VaXFhKY7bpCNRqdL0y9R7c9SgX04k8GOq6PpCcOAPwgNNBnGvA9yw2bhA0Z7T0ReFkeH7zhAGl685LexFw5WxXpieJQrq20ImK9Bw56C7kth1B25Mpww/VtuYWuDbo7Zblk0tMOd7iKa8Z/BTCzavqu7v2L7fxMQKuTZ+z54Ix7zke9wi3nAKogxdfoOirwaT99eqGKCu5JnkRLHoSS6yz96U9XFFumuOcHKKJgwQ1aqdW6HnyTaoXvqG41jUrYuxtUB8MUbs0Eum2CTP7xuJvAi931j67A9Ikt4BE1UqMr0Q3wbVLMF6TOWPsCL5BK6JtEHZvr8XBSoUMkBJWrtmH0jdqCrRtFXLJaEl+zyOoZEHKMuhIXFniZ4rizkGMstTneBAkczD//X9J+81SnlLN/DXR8sAWuJOccOS2TCPMzTxPJbRVvi6s2l4BqLJTCd7xclLiY5WHvGY79n6ho69mOF36N06I4MHbAZg+tb7AHhqWsuauMQeoAL+66Onof/m/t8LmyJx6pBo1o15vD8aaYjRtVsBuwlrOwdY9AMJqLtaWc2o7vvIZI0GUiBJQWwdY8Rh3YGiOcEWSfu0BWrmnm2qrROefClHcRgZEF/3ZTQHKBD23SJWBNtypqJoLh1CaFcN2nXjwcGfs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(4326008)(38100700002)(38350700002)(86362001)(478600001)(83380400001)(6512007)(8936002)(6666004)(66476007)(41300700001)(2616005)(8676002)(26005)(316002)(19627235002)(1076003)(107886003)(6506007)(6486002)(5660300002)(66556008)(186003)(66946007)(2906002)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+HlCD95Q06NyIO9CRQVZV4msQ5xZhDQ2fOQfzIGKU8pVOXpewdIZ0lpdpQG?=
 =?us-ascii?Q?BWblGq2JGIq33HkOH6/cOoAhnZQLgjlhydE3G6K0KHPWUO3ETLaOAFBLrK4O?=
 =?us-ascii?Q?53YDgbJPzk3nuopSUcMfbdAJW82oXPAr2Dj45bpdXm/5DnOuo2JMqDa8XEol?=
 =?us-ascii?Q?b7ZE+3OSaDyIKcWDTAild6+UJT7GKKPiisqv7Ga6e92cj255UD+2cR4fwjgS?=
 =?us-ascii?Q?Ry53yIPgSXli5rXyeuy7hOPLUi3dExTKmuyRzeRC/YGAOA2elj/zOcTUMHlx?=
 =?us-ascii?Q?b2nNCjbrv0n3HLWMCJckzW3idTfByUQxAojP6v5ktgAsv9N87zSaGZZXCAMf?=
 =?us-ascii?Q?cVAEVEVVWXsWxT+5NYgP4spRFVZKOGoDHsQCMXdW9jkC9daZGdZosY3QpVJt?=
 =?us-ascii?Q?UZgiQ2zGnzrI7fn3uaGpMTGCQYxP5iHgcFTfvsYk0P7iRKqYf+EL0yc69Ai0?=
 =?us-ascii?Q?J0mnBvCvq/hZCQbXA1cwVyuc5eBQlHN/7MzDVLYA/kCxPLlN+mbTGiFbb7Xm?=
 =?us-ascii?Q?0dKsvgV23reU8d/M8qdOji7xRxatH59hYY3pYBy3J8QiSeeThvfUb4daerHX?=
 =?us-ascii?Q?802YvttmHpoBwMbZbA5kTrKFMZXYIIox5XAWIDeR7WmS/H3GdK/Ic7MU6O2a?=
 =?us-ascii?Q?+OxGDH2zVBBtPBsp00TKjltvODQ+rjfxX3BqgDFPc74xtOBBLaG9eU8oeGJs?=
 =?us-ascii?Q?KaBu4xa2+IMkxk88s9c4MBDhxOM4gAhTk3MYkK/48guYxeLMjwvFG4EBoJSj?=
 =?us-ascii?Q?b1KQXIg9fAGnUxAJaiWfqqYNdoa/BAObiJ3YW7feH+GpXJQn/YKGNlYBgz6R?=
 =?us-ascii?Q?XEE6YwpIuiUozohrtBDHQKHfi+0eQphmPaDkYHepdd7pT05+daBcAZOzZtFn?=
 =?us-ascii?Q?giJH+Q4ltWPbkOZ3je7uHQgowepnfBcDWlJWWZ5gQDukfLsoY1lnb4dDuPLG?=
 =?us-ascii?Q?+DxNFzuOkfxfBv5jkYcGrN2O0N3i+vS+QZOQISRG3pEsu5Or1I4InHarNWwG?=
 =?us-ascii?Q?sqSFgEh4FGu6a6R1pWz7kWUvWQMrhbwqr2yrSSmbgPwST9xgI7YJI1YOx0GM?=
 =?us-ascii?Q?6ymRIy/SNeuwdkmXxI3Z+QhnGudp2kfgVsUU4btu+XQZ/Wj8J3nW31XdM1zG?=
 =?us-ascii?Q?kaoZcQIAaBr45IT6PyHBgtsHtcKtUeQ5ga4ibR/sd5YnT5gycnsZd3TIbE0u?=
 =?us-ascii?Q?NctGoYRJBYkUvpq95HpCKL2cy/rBn+ItbFqrXk3s/CfuBcq+CQw+uPzaXGg8?=
 =?us-ascii?Q?Qy612izM0pzVgz4tGHZDX5rlKvRmRiHF0wJjmr50bVTcIZpnlfOzvxs0Gt7A?=
 =?us-ascii?Q?Aksyf8Nhea5eQgQY7DHqoMyI+VJSOpHjy/Y72iYjJ7AAwn2dfKhC03a9A7rN?=
 =?us-ascii?Q?nfo49h2/YAN1Kgz5xtEmGhgzlh8vkPLtgCs01J/Y6BCAWM3iWrpBRRyuqYI/?=
 =?us-ascii?Q?DCiJkx9LVIvR5pPIh1zLEwtqU7XoStM8T3w0uSNeCUN+m/kBt4HAWoAyLtTN?=
 =?us-ascii?Q?QRTKw5r/tVjmWwY1rHIWYYPwwQOjTrt3OWOxq2PwrRbt+Z06Oy6+ELni8IMJ?=
 =?us-ascii?Q?M/JPUeezLgZRh9M3rdrDDVwko2XyJ6s7gPDZBtdi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24c681d-a6f4-4d2d-9961-08dac942f39c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 08:57:42.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC9jk0WCLRtqnHrYCW/78hkSG3zcuLbMbe73GgJ6SMJ2LNL9xuHnwx64WnSNGpEkBgSDR2rJs1131z87RA+Dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current discard_io_aware_gran is a fixed value, change it to be
configurable through the sys node.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/segment.c                       |  3 ++-
 fs/f2fs/sysfs.c                         | 13 +++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 24e7cb77f265..2bda283bffbf 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -646,3 +646,12 @@ Date:		October 2022
 Contact:	"Yangtao Li" <frank.li@vivo.com>
 Description:	Show the current gc_mode as a string.
 		This is a read-only entry.
+
+What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
+Date:		November 2022
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Controls background discard granularity of inner discard thread
+		when is not in idle. Inner thread will not issue discards with size that
+		is smaller than granularity. The unit size is one block(4KB), now only
+		support configuring in range of [1, 512].
+		Default: 512
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dedac413bf64..c8a966ade5c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -329,6 +329,8 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* default minimum granularity discard not be aware of I/O, unit: block count */
+#define DEFAULT_IO_AWARE_DISCARD_GRANULARITY		512
 /* default discard granularity of inner discard thread, unit: block count */
 #define DEFAULT_DISCARD_GRANULARITY		16
 /* default maximum discard granularity of ordered discard, unit: block count */
@@ -411,6 +413,7 @@ struct discard_cmd_control {
 	unsigned int min_discard_issue_time;	/* min. interval between discard issue */
 	unsigned int mid_discard_issue_time;	/* mid. interval between discard issue */
 	unsigned int max_discard_issue_time;	/* max. interval between discard issue */
+	unsigned int discard_io_aware_gran; /* minimum discard granularity not be aware of I/O in DPOLICY_BG */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b0b76550578..075616e6f4e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1059,7 +1059,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	dpolicy->granularity = granularity;
 
 	dpolicy->max_requests = dcc->max_discard_request;
-	dpolicy->io_aware_gran = MAX_PLIST_NUM;
+	dpolicy->io_aware_gran = dcc->discard_io_aware_gran;
 	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
@@ -2063,6 +2063,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return -ENOMEM;
 
+	dcc->discard_io_aware_gran = DEFAULT_IO_AWARE_DISCARD_GRANULARITY;
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 97bf0dbb0974..6c977fc713c1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -473,6 +473,17 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "discard_io_aware_gran")) {
+		if (t == 0 || t > MAX_PLIST_NUM)
+			return -EINVAL;
+		if (!f2fs_block_unit_discard(sbi))
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "discard_granularity")) {
 		if (t == 0 || t > MAX_PLIST_NUM)
 			return -EINVAL;
@@ -795,6 +806,7 @@ F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_request, max_discard_req
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, min_discard_issue_time, min_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, mid_discard_issue_time, mid_discard_issue_time);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_discard_issue_time, max_discard_issue_time);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_io_aware_gran, discard_io_aware_gran);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_ordered_discard, max_ordered_discard);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
@@ -925,6 +937,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_discard_issue_time),
 	ATTR_LIST(mid_discard_issue_time),
 	ATTR_LIST(max_discard_issue_time),
+	ATTR_LIST(discard_io_aware_gran),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(pending_discard),
-- 
2.25.1

