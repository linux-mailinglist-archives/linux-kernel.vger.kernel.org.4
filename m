Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50956126E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 03:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ3CSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3CSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 22:18:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2037.outbound.protection.outlook.com [40.92.99.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C001648C88;
        Sat, 29 Oct 2022 19:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWPFMBntAOvp7HGyugY24seknsAIH5eWekYWMlQU+wYclKXioc6Z5tOhz1TacWmow5XKgROy3uFYYSWk1LgG6eK/316kuEJUXoK8mltObzrZV9mLRuT4mSVh/f+yXdUF1wzbPwtRjKdhQ2HixmOyzS+RX7IsupX8bkNCE095Ax6/luYO/ECvfi2JwSupMbsZMWWExvIdkB8h5P9WP0SK8D9etpmPusDBiiQS88NA8bKk9OCG0msJRgcpE+ehOHnswqF7f32DRAEjrWeAUiN8Vz27FdaimFaW2BwWMES2Sa7x2LnX6TVrfakcPZzR5Xo3m9aMG4Ui75nw/QzegLFVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO+84D9jCg0WxptftHfpbztfGm5ak1HXCre0nWNImkk=;
 b=HGdnjJ15Ontv7z7F8GboWzo+6J6vGFQFpH4J7wnfzPL+xRVVdnTteDpAynevcldwvSxYnVVqH/MIwLrRrW5RW/hi0WxQ/eatSMRUCjD5U8bQBT2rvkpsG5G04NfRVQuzRZAs+rPUknJYb3BIiBPGJgfjEYRfsIJXOtfMMgoMyzx5n8BnNMT0DCyZ+yxBuCFC9n5d2KdQlHcrRhM/PpwYZMPT3rJvzlwfDgibJRxrCQFq14Sgph1oTv8SyZUjn5lWvqLzHlB2WMDl43bzJJ4k23wawrNGNc7NTWqR6UnJwTkb17xcFUNI5mGD/dnbHN+Y8xwt9KcJJbXSGdv3bf6Wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO+84D9jCg0WxptftHfpbztfGm5ak1HXCre0nWNImkk=;
 b=jeF1j1m4/a1D+XorYrCnbhuedVgEz8+wBFKPYZDLQQ7Qs7k4bzyrWp2WKvbLqT4+6TsL9KJsW4VlddAVIBC7aOil2ZndFIyo2DqBeDEqdHzO+i1awZrGQWEM0z+DdxQda/Zwizqopx9J866RuTCoCUxWQ5l//GRbqpwGbP1zESSwWO8ErqzLaAPhoRMplUe0EUegfovsLxDuNDx3aibVwVXgY5jh/p6+SqynXH0aPyCptPZs8OJQvB0/b3J/fhlOa35S/deHOPDeXTurKY4TwJj1MoKMmasRzYbIRJwKE7yzo8daPN2H/jXKS/VwXaJ7Fu2WlRrDy1Qx2AMdKURjOQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB2425.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 02:18:28 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5%7]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 02:18:28 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] block: simplify blksize_bits() implementation
Date:   Sun, 30 Oct 2022 10:17:40 +0800
Message-ID: <TYCP286MB232371C798BE0500E979E24CCA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9HSdnovjQQHzSqg7rseYfRemzlra+KSE]
X-ClientProxiedBy: TYAPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::17) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221030021740.37524-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB2425:EE_
X-MS-Office365-Filtering-Correlation-Id: 818c2ad8-76d2-4abf-5d20-08daba1d0811
X-MS-Exchange-SLBlob-MailProps: ZLYX9kf+sFbSGQPCthfGnzMHvcLRKUdKeNqTJvdXx5yW499aUNx3ai3ufwtx6YTCv9APsjdUkxNFRm+W4CDyL0aeCBVTv3RyjB7vn1hOenEwWERvjCSLCT2JpqWnbaxsnjrpOmyBYRSg8ey0WyLZchf38pa8Xs3uX2plGKOS85CfeaiM2syBVokfxxyEO+03Lzig/gjeY0sxeVv2/fe7FArIIMyKtNSLReC9eQriDXqgtegImThOoQiIURaojmJ5mQ29GdOMshnKrj6tIuF5YLheRlaJUZellgObtKTGhB4rh6G5zsb/wZd3NM6RtdihgYH61hA3TgJp9JxknputXr3mwjdNDzkuw8tuw21R4+mvgBPHa0eSQwSdPYQVC3ZWNt97l5JWWjASeoif1CpfwC1ShUZwy92WXJiEhvys/0QeRPSyKT/KAETyDbx33LJmJxeEWPEWhPvv835WQ70u2YDj03uOF+XGMAJY3bx8kcMqTlToJHqgIG9im2HTksWXliANNa1bsb20cP31zWdVX8+kMvjRgIfYISoQkp/ypKPhRUOnOBPQJMRpmQZt0Z/FOyNpJlw8t32SdzDzfriRWFFtlqsrF1uKKTWAORKjwMCKi3PIpzix818OLoZDhEFBPnQZAA/9HC68uE3vtnv3jH47DDoxe3jQvKKaepaWyzUWCYy+LRJGfIlfp5feOw0lwzGZTYXO59tqRDKC3IE9ZLoincrVq8c0wkebMaUHoOi57f3n/OdW5OAdBNj8101JITJFe2RFoGf6LzP6SxliT17Kw/fekDKu/nTv/vt7o6ndsJKqAXz+MA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgGglKtnksW3aEzrZle22xf5OZhSo91UGT7IluFsbelX6QraTd9FpRBplv4UjNpy+ahvZKPTUqcXLYEZJ/cGFovCV2oqqK2LDGMqCDz75ib5O/bO5JOn7n8FPv8QxJGHKxcMSuDoExVrGgfx+F2iOa/5rYwiMV2NH+iHlbVOxt2UjQOPvufPP6CuE526jLGrhPpqzokg8ouo6FdnOLwfibaLv0ERdH+iTGERB5mW1DZZvEAEWL3vVqfdJ+OsVPqsDK1xZgMPncDoUU72YBGYHWCl3/Ni6+qGqcX/ErETqJ28hZiP8PQ+KC57VI21xfWuvUvrwcaUz6+KjdRunPwFhn5ubfs5G+7uPgjhvBaZkkSSZVShuti52unHuuR4FBxtYfmQOVauU+3ibSB8yVFVkHU1+vyME1wlO2uzaLgkrkJjmekE0qsONdyBSwahPAdWHnb/MglS9C2nj6DhMxxRloFoZ1wUTYJ2x0ymWt+S9paIJf3bXT44a1imD4jtMNq3LCekYdAL8LrEn1TGOvJqWOINNd7LnIWSj06vt8Fp3sWtBJ9PiMKpb9dI97PzQ2EUwgOgcC0knkGGoWoDlYLsWvAYaXW6VQTzGD04EHlH4LC+aEv4y0RqBXHkg+vSwyvEij7t+5DYlEQj2SmIa5CXVS2p+C15rXVzwVKZj/n+7PrNpm2EZ2hDTnA9mZ1GzOV6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ruya3tDFaqfFouQgd2+/GBntvSKTIhzpPnTWgjCUk3X3BtktUiK2AuIq+/L9?=
 =?us-ascii?Q?LFrV6T4PPRReZMXbXC1K0MbdoxmojMUm+sdN9DQn/pqDzadgIUAQYtuoXO6v?=
 =?us-ascii?Q?5LCETUcC6cERYgk6HNJC8d2jY/6xikL3A7Wk4s5CBpsu40kN8DvRVMr0niX3?=
 =?us-ascii?Q?56i6jZ4on8eV8GWl5KxmOKyw8/20ulHF0F1lY0J0IwYudwv8RIsFdP4uljRA?=
 =?us-ascii?Q?El2UWOc/ErwP+gQ4PDivaZ3ai/eSYmlhURC+RkY9iwUqSWH4cqQ116g+b2fx?=
 =?us-ascii?Q?KtTmOG1/btU6cNO+brD30za7yhW9NVsGSG07osJeOgb+KMbTMqdF5nkXQKmA?=
 =?us-ascii?Q?xaFNfcoF2HMrzbzqqvuh0rhir1zvhOdzii5hQinJACknbzPSceM+xr5c3GvY?=
 =?us-ascii?Q?+RrbsF5BEYqJiD7141udVZglT5ZfcVAb5wyo/eAssaxlrClzJ/BO7xKpMBjJ?=
 =?us-ascii?Q?SxUsODLXkEYXY7cbn9G/Qq/efzqxO7zvJseemaXo9aU2Ku4ZHN4sQ7xKdeE5?=
 =?us-ascii?Q?Leu1XzSRnSJeXJsy91hnkDt1fzEigPrhXxM0LmHdjn/IQrNxeGs6MRRpHi54?=
 =?us-ascii?Q?MjdasO3/jiF6KKLgrFeNMrxRt44m0YN82qG/TrwOaeAzoVhvawVqhsglUagU?=
 =?us-ascii?Q?JEQ1RNbEDP68HGULZdoKG+Ac1TjZcv3J/hnb2ltvT3ZvD/dmZH/ttCRJEona?=
 =?us-ascii?Q?L5awYTIZNOy7BZ2LWuZFKSO9VOAZvy+eoO78IPw1deGZhn2HUYpfXIxtKWXj?=
 =?us-ascii?Q?colVLHGaG+TYd526fh0vNyF/NotldnqNqi3qvyYND/BFpUNHNc27kK6H+66u?=
 =?us-ascii?Q?osuL6kaC+m3Dh7fdz2Fi7WEwHVPgmTO8UYQjNUboDsRZzmr+oJZLrPFf6QhZ?=
 =?us-ascii?Q?DfWtrn0en9AgIMU31JysFVkMdQ58kDJxqwGq0R84tUjg9igr36yLZelgAxkJ?=
 =?us-ascii?Q?epo8uAkfZTpz2GkKUim1vKSR0Jfwtms6xGjadeUUziOqo5gxSXYNitC0B29o?=
 =?us-ascii?Q?D1VpCjINVcx2oYYFEXR3+Z6ge1xRqTUyRt+bebJ6Uini+6k+CFNQsyShCpO3?=
 =?us-ascii?Q?5WGll7LqmSu2ZH/3Ml+aSygPMA9vU23isp7qBeJ3ESTPynQ54PP7KmEQB1HH?=
 =?us-ascii?Q?GvoTHIJJR2vh0oZowFipTFTiirvvMnHh/9eRZNuqKYSlS2T//JWpKE0skZOD?=
 =?us-ascii?Q?H9pYwJnVaugCJy21SEJnO8RdreplaktnkN3G4v/2IamJCX2c2PnDLduNX5oj?=
 =?us-ascii?Q?YgajVSnLAUBzk1/CSEFtwjJ/AouIh4ZfM2rZCJ3Q7A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818c2ad8-76d2-4abf-5d20-08daba1d0811
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 02:18:28.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2425
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert current looping-based implementation into bit operation,
which can bring improvement for:

1) bitops is more efficient for its arch-level optimization.

2) Given that blksize_bits() is inline, _if_ @size is compile-time
constant, it's possible that order_base_2() _may_ make output
compile-time evaluated, depending on code context and compiler behavior.

v1: https://lore.kernel.org/all/TYCP286MB2323169D81A806A7C1F7FDF1CA309@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM

v2: Remove the ternary operator, based on Bart's suggestion
    But this may lead to break for corner cases below:
    BUILD_BUG_ON(blksize_bits(1025) != 11);
    So make a minor modification by adding (SECTOR_SIZE - 1) before
    shifting.

base-commit: 30209debe98b6f66b13591e59e5272cb65b3945e

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 57ed49f20d2e..7b537afe8b38 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1349,12 +1349,7 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
 /* assumes size > 256 */
 static inline unsigned int blksize_bits(unsigned int size)
 {
-	unsigned int bits = 8;
-	do {
-		bits++;
-		size >>= 1;
-	} while (size > 256);
-	return bits;
+	return order_base_2((size + SECTOR_SIZE - 1) >> SECTOR_SHIFT) + SECTOR_SHIFT;
 }
 
 static inline unsigned int block_size(struct block_device *bdev)
-- 
2.25.1

