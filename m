Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1986996C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:11:18 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB24AFEE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0CesmbRYzqGY6jK4GA77aJcVcQPvDFVyXDkexsPWaaxt0HUbZFXwR16QkJcCgAggVa3MZWpxnjyOUxi5cJSwzLe7LDFCam6bNP+jNffdTYLHRPQQQIExEqxQTeKxGT2uJD7/x/JDVgj1AGLDP3WeXUI+PXa71pi63acRILUmdBoLYH2CUnw53SIgGnHc1pSu5qsU1WicGsVMrFZs4eu+ndZcmIPuzigg9EWEjd0FzCwu8iFIxwp2kJ0FqBkgUQ2raLXjGxdYz9sCAboOTB0cS5hJw7XuQYUg/UwGkr6SRhEiEPbqDcfHlXYBLR1ZNnf/xZC6FTvmRcgZako8YaXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njKBpNZG/OWGljuPOd7ZM34F7lFXHOxn3UcVLZ1fw9I=;
 b=TO/pvYI8lVTvCOif7nbzjXzxMme+ASSFc2dJEOEeWR9O/DcKoxzNUFdSYgOVumqN9Y7kwWf7mPGkik6mPFujCebqnm2oz2uPdlnBTwlKY25yinOSOvLut5cj05DClbcDAryaheikrQdF3BNW7LwXVgW1AIvfyz5jp08U6JNQ5Y4wjQCdbkkNkxNbxFTPZqkbhsR7Pizkec0A/1MTXpANnAuTqw181xRH04uvEIC62A3IiTa6a7lU584jccIx8icpQhepBdXRCFxbofons8vFczYlGGQ0WS7+9lFyalTu9EzN9R9D0On2Dc5b5wUqz0UXtrUzd5mbi7oL4Y03LiQ5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njKBpNZG/OWGljuPOd7ZM34F7lFXHOxn3UcVLZ1fw9I=;
 b=rCKrhMNnH++RdtyaFt5lQVohwFfmYS8R0k5SQgThwnp4edJF95Lpi5Z8QQhJ5QH07HhQ2CDGFR0VxgNECMVaZkhkdN+0lyn+iYiHC+E1T7VBj6+JCXG7xQj5hm1AA37wA1o9ok5RUv3Lz0FrTprsBWALZIvlwcKtX8wEBsl40Ha868EHPKXYUz3lUQWSjR6ql3G2VNDq0L+ZLN6FczLAyp+OYCTOA/9AdvDhq+n7od0vF8SvfAPy1TpNbA/g6bfXO5lrw3jxSasA5k4bvFFFwdEhb1/5IpATEjtcTJqEZ3gs5s10+rBvGlkb2rmBobTRnN1+0Ix12MnvaeYPb1s0Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TYUPR06MB5947.apcprd06.prod.outlook.com (2603:1096:400:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Thu, 16 Feb
 2023 14:09:47 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Thu, 16 Feb 2023
 14:09:47 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2, RESEND] f2fs: export compress_percent and compress_watermark entries
Date:   Thu, 16 Feb 2023 22:09:35 +0800
Message-Id: <20230216140935.20447-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TYUPR06MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a543e4-2725-4517-d550-08db102775a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITe7vSJ2AGcefPwgIsxsEOfDNb1dVxTbHW3VOckLzuUh7GgdVul91rvdKqp+S2kvtd0CumbnRn1EqzNrlt2nfK2zxSYIf1/87Io7xSdy5F1s8/G0p/uXCmBNu4vLQ02eMdEWPO1+S6a8qFUAgB1o6ufeVRi04ZlNIwEmlIvavUHu+WBkZ6BMPcmBiVSwlQY8iekc1A1pxYpcLL2mDl8bHlYCEmMUwOmmIHHOuFIF3+Tn02KDdzwQUpbQtcZTPmVwrzNO+xsxv7obDbv3hZpjFgzjP8k4/3JSKhWKmJEbs2Q3WnWbUZq0yyXvqYrzk6Wu8lu3/lbQiC5vjIo65BFJOoZZp2LVJUJgfNUL8QY/hyXNex29TH8ui6UBflqX/Ix9VKLOcftHP+xVCaV7pJ38HkIaratje7LNBaOjnjzDPxJGjBdUyPL5vQlg3nN2RibG10iR71f4HFUB0q6vsyzFpI1hecBrsa3tYrGdeOMN1qRbykJ+cDjjMZjGIGqHnX742lb18XOv/dcWaFOLoD96Uizu88E56A80diPTecNOgnfiDnHjsd281yEAO4Pd1QghIES5bweKDT3WgLzVwkFLmu1dKVr/0/KDIPAr6qL+UVs+8ZzhaKpGGpqvmjnepl+ZyRoLqT47jYNYcTmY4il9E/fG76k1J66bTz/QuTmyJPSod5ELcZSbnhUyVk42AE1NfxjwHs+quU8exrTM3Wb/YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(186003)(52116002)(478600001)(6512007)(6506007)(19627235002)(26005)(107886003)(6666004)(38100700002)(1076003)(316002)(2906002)(36756003)(6486002)(2616005)(83380400001)(38350700002)(5660300002)(86362001)(8936002)(66946007)(4326008)(66476007)(41300700001)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+vnNwnnV0qAOljwl/zEtHCJM4vRJavZg0ciz8hZzmqP9GvA0i9DR3ytsAzt?=
 =?us-ascii?Q?0ZyVsvyQKC0pxl5ZJgrJdZfHxL4UNpPjITd1+Nym/GcU3MX5TvgHke0ZTiL/?=
 =?us-ascii?Q?ChcSHw9CpCjM0bgqx1M+EQy5pHWy3ov7FA0wxw6pRJWPoWnb4/Y4wzIWwbGa?=
 =?us-ascii?Q?KgDaHxeW5e8uyPNaYHWA+zivvjcbDEejF7Yfvl5h/NVOVPUMYVDrEwH7+VzY?=
 =?us-ascii?Q?uNddsjHnnj6VMVqHgov22p/CFUkEpF2avqqXw6yCFZw+tqo9OOErJHpIhxU/?=
 =?us-ascii?Q?INevWO1NG/12DzqFCVEl33CbPViJIFaauWNsYmqc8VY9YizYExyms03dq8r8?=
 =?us-ascii?Q?gkmlIk0ExTYtMf9gyKVLK1j9xVZXscZL6uCY8lBfsl1dRc6cOidt9/IqIcjc?=
 =?us-ascii?Q?W7WLX+D+OIJ2j+UOP8GdI8vbZWskWQ9hSH44P6mZTzCRn8GvXZWnnlVTqUZQ?=
 =?us-ascii?Q?CwUnhFpHeSZXbYM5rvvaOviwyIWr+cwba2F/zqtnqYO7nbqSeqHHqKtb/qwp?=
 =?us-ascii?Q?LuIaWkVKyyQ2MiTE2ZHUssiVKuWXmsfpCDKdQ9rfC26AEvyKZQQ8HBLgeehB?=
 =?us-ascii?Q?HZVDHAAyMiUs6G4XnJzlr0sm2aw1MzFarhA/yqrZ6iGTK5A3yJwbvwgPYS28?=
 =?us-ascii?Q?6ZOG/RlE+TZPiuPDDWPlBwOUeRIsDIdgojAgCRBKVF3Lj5G9ihNttiZxaQBC?=
 =?us-ascii?Q?xtDg0Ml+2ilD+QS05bEWllwV5DsTd6aSGtouZ/jzYarnlEegzwkn0ipTBAkS?=
 =?us-ascii?Q?0l94e5zFw1OTZQyd/WCepIbUDDwfGGsie5p5Q6UcJkbHP3I+QI9BAmLbpju5?=
 =?us-ascii?Q?nU43KxjOe7m5Gc9W8o3sQiL9bIO5EQL0NVnD7GFr77H62P3DP6DGLpHyHMk1?=
 =?us-ascii?Q?o01+HsyfmvMLTNPuHjMiUwUl+ForGI/4J8VJRlBuWOfA4NzXT9JEwDHXKn2n?=
 =?us-ascii?Q?snrgNQH+HsxTMtDqJaPd79HX98qan4fgft5aGwpD+Vv01O4lHnWlox2g8Hi+?=
 =?us-ascii?Q?9ifgZV04iyV0QybBXuLsTmmMJNCIP4XIByrpvbQs6NNKqwMiMRRLyj94abDc?=
 =?us-ascii?Q?9YAhitNn6Ed1ZbwDdddY4f/vDPmBfwRupI6RgMPrYwea/KqpunAAvTNvMcMo?=
 =?us-ascii?Q?S/cG4bjfaAjm4/0txA4D2gLzQWk1Zwx/fT5hzZidAneGXVjSE8YtgRIBL3qK?=
 =?us-ascii?Q?OVVP/hiF2DnloAISoHyER+zi3cWsOSY7A7Ad/4omjvV0yN03FTAcqvrnXqFL?=
 =?us-ascii?Q?Wv39BkPA0Xkx8/a44ctRVQci4H11GWC371EqcGcSxBS4zLq2Yy8HsG7RXAA1?=
 =?us-ascii?Q?CMR3KdQM34Nf7NcLPCzUfQWM52bsgkbqUo/jE+dE5yzyrfIjPLniqCtSmKpR?=
 =?us-ascii?Q?nIWT/6uyVGR4ZG+nNyKpbEm0sV0J2YQLAuKbxp6YiGcdJbb2mP69RDhjVY3J?=
 =?us-ascii?Q?6aAjfq5KkeJqz9WfzJuP/VCaLmqSswHFnLCg0BsAQy15Zc6UJxzOuoG/fnXf?=
 =?us-ascii?Q?4FMFvVbVXvhgHh6GEx+70hS2KF2mMedKf7J3aJ4pEBIJpNfs8RaNkbbqIUbC?=
 =?us-ascii?Q?FR0ybdZzzvKQRJgr+DJ0hkvY7hoDMlZgjHFOyMY1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a543e4-2725-4517-d550-08db102775a0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 14:09:46.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkuD8eDqZGQfTbLLnw0fE6WWG3yvHwCqLn9rSAYtsGKC9txCBP2TjB9Yey5ZomXgk4NN4+VWLG9dHKEHNbhEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch export below sysfs entries for better control cached
compress page count.

/sys/fs/f2fs/<disk>/compress_watermark
/sys/fs/f2fs/<disk>/compress_percent

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-disallow to set 0
 Documentation/ABI/testing/sysfs-fs-f2fs | 17 +++++++++++++++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 94132745ecbe..c1314b7fe544 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -729,3 +729,20 @@ What:		/sys/fs/f2fs/<disk>/last_age_weight
 Date:		January 2023
 Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
 Description:	When DATA SEPARATION is on, it controls the weight of last data block age.
+
+What:		/sys/fs/f2fs/<disk>/compress_watermark
+Date:		February 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	When compress cache is on, it controls free memory watermark
+		in order to limit caching compress page. If free memory is lower
+		than watermark, then deny caching compress page. The value should be in
+		range of (0, 100], by default it was initialized as 20(%).
+
+What:		/sys/fs/f2fs/<disk>/compress_percent
+Date:		February 2023
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	When compress cache is on, it controls cached page
+		percent(compress pages / free_ram) in order to limit caching compress page.
+		If cached page percent exceed threshold, then deny caching compress page.
+		The value should be in range of (0, 100], by default it was initialized
+		as 20(%).
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 0b19163c90d4..5397bd8bfcf7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -598,6 +598,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		sbi->compr_new_inode = 0;
 		return count;
 	}
+
+	if (!strcmp(a->attr.name, "compress_percent")) {
+		if (t == 0 || t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "compress_watermark")) {
+		if (t == 0 || t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
 #endif
 
 	if (!strcmp(a->attr.name, "atgc_candidate_ratio")) {
@@ -950,6 +964,8 @@ F2FS_FEATURE_RO_ATTR(compression);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_percent, compress_percent);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compress_watermark, compress_watermark);
 #endif
 F2FS_FEATURE_RO_ATTR(pin_file);
 
@@ -1057,6 +1073,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(compr_written_block),
 	ATTR_LIST(compr_saved_block),
 	ATTR_LIST(compr_new_inode),
+	ATTR_LIST(compress_percent),
+	ATTR_LIST(compress_watermark),
 #endif
 	/* For ATGC */
 	ATTR_LIST(atgc_candidate_ratio),
-- 
2.25.1

