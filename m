Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68C85B5C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiILOjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiILOjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:39:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01lp2176.outbound.protection.outlook.com [104.47.23.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B3738E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7tA08Mlhx32qtQ7W594grxxiS0pw2Bbao+Hq5uib6hiu7ro4WcogsVnDRtTmygLYzX4TFTcAjKA0PLELNe035sGoEGO80qtg9SeffsU/4Vt526PtMAoeuGn6OyBOMNYxc8Jp1E/DUkFzMX7CNILNY6xMz0nWHwtnvkxrePnEKv4SRDtnF33h3Ht2funhGv2HQgJwtxFU92gNeZ+RVfgEYWcGujwLACqhnmSF1k4L0TXJR7kjTlnLTRe2Mz1SpcT56coO4AIFSLVXPrn5GcTrwt6ateMTXMSXq9e1/b9yF23DCyfCecZ8vD/+4kLA2YRTnUGwJPr4m4TokKxFM+Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EAFIRTLI3lMRYU30pzfpjFQEyY1HfZgZk+GB5sDfrQ=;
 b=LPKIinQe5olBFWb4ZL48PGa4YHfnrwGNXqTcceCUibhTlcMpsA/CMOj6MkOUYRf6YM4C2Vuay205Wc/+yIe5XxJA5qFqmIFLkJ5PMWDWArhMfhq4KBWUpTp7btCJsmZdp5s3Pjh0fgkceMc+cEcDyUkuWYi5VfFDlciDQN59BQzdEZVDSdsTHIy5Rf3WAZSHY79ef6MLmmN/3dPOP3mKIJQZZq0GQj9y3lVLupVqW6h/Lke5jv/OscDqYNGOT0GczjPzBQsj9L9ytM3bnhG0+y0nZunCYvPSIXVOBd0MyPHm3NMnmUaIc70izENX3+8HdDTRUbscHsEiKumxuE27tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EAFIRTLI3lMRYU30pzfpjFQEyY1HfZgZk+GB5sDfrQ=;
 b=HKwLz+XZ32juKl6Iwo2Lh0gu81AmAY/kxCQ4l7gX+UxwUml95C64wF1C37UOd9ANvZRzbQqvODkqb1SobYokpImKhn3x4YbIAOqpXSpmHBPZ6LwGXmVy1gw62lwGaLOAc+eaVjMXMp5xjk2vwcSJxM+xbRagbZeyFfJWhHkl86zIu29a2KbBdIXbZCNk4IjzFYR7IdCSHPQ7UuTVw3BdkdnH4iSB9IzylTwlT0sn3JxEWoN/I4aUNd3qW5OCXRH/XpZe3fduQNUwa8IcsMK+8AxPzFsTsgsEla0QNlijBBnD/hzqYdcvYSUdRuS3a7nzkd2d9JuBO/2vMdAYxJAdzA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYWP286MB2528.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 14:39:28 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8d69:1a6d:5def:16db]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8d69:1a6d:5def:16db%4]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:39:28 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] mm/damon: improve damon_new_region strategy
Date:   Mon, 12 Sep 2022 22:39:03 +0800
Message-ID: <TYCP286MB2323DA1894FA55BB9CF90978CA449@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [sVWPtShicKCXAwjZlIMlGDB4RwBbz+y2]
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20220912143903.33688-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYWP286MB2528:EE_
X-MS-Office365-Filtering-Correlation-Id: 505165f8-7154-4580-a14f-08da94cc98af
X-MS-Exchange-SLBlob-MailProps: 30ekHghIwFplBPqP8VCCscci5FKlo3HhUHNP4M9WR6JkwAcfNZGUDFSCTc+YA21qVZufwwWDnO5AnbbKslKu2DgnGd5Vp99PtqqwAlWcUC8jTnmVhTK+FfiFv/WpCP+tBYossNzNTAn5OFAD5CS8AdoX4gun1zPxZIbz9lXjKDVIXKOprpR5V8vLxPGWMVRcao/70VGQLMuw7LbPOjk2766L1Uvfp0H0siOq5hWnc8V+zgvXbndJm2L+dqV/DsBtQ6iPxf4LHKSV/eKgIcvsYLUSY9/ZOqyY1HD/9asXjT1dDk8TjtKIFGrCnmKq4zV6zONiBdSav4lpjEuddUvUhY/oXYlWgUb/IAq1AJmVEX+gylNpRBdt3bWXdHseoOPIuRaizesBGqBsijgKPu///WNRiWC7d2hjv+AIQeSW6CZcgP+t3FyeshjyRMVpZEMZ/VxhaWoUnLl2IhEd+FmZ1Cda4mB2jVVr0Zb7J0p2FYhK84hXbj/bIfqGGxcEbYDMRPoQkBNhguEXm3SEIeivdlO/pNHuer8jqUi6lc4a7GAhUXFioTTsHboSzygzkqeKUXMVFZiKbuU6R2eNKo7GDmctZ3EUeTgXPFbTXEoIOAqqVttXWhScUWd8segak2QW50VWjs3Q2FcBuvymtV5FPXrjNA+AG1ffUgFQlZCZJgKooVME23R0a3Z5KHawwh/3JyjNWNtUM09yJfzFWXa/tJxP9zh16ZbAC0MzB8f9C7SNUIz0pokiuiKLygGEF2Ql
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yEHfnOfobpj/9Ca2MYyvu2nfkGIDZ1WDUCXzlmzu5qbXXOzgaHzR3mFilW3f0kR40KBZ43W4gShm2YjCezyZLb112+yWF6JfbM4hiLJX0iaINyYvZTdoEljVw1bOfH0FvWhctsbcGbEbbsaNIq+I7svBIGP8rWSpqqYGTRSf9ytWIc4GBo2B/5OPMofSyjhb9mEcDmCtSTWb8IdobvSE/9YCgam8WMbvK4/Aypy78DyaEYeTPKI2tOtkrpQYrjxpEQmMr8bDCLaAg6MXs0JcPlpxpGZ9M6jYSweVvvrz6d3H/FKm1NpAj+s2KvotI1dOZLyHlRrBjGnFL7kU+kIH6Fu/v0OP85tMZCCTnK4QwOHvoQbeUo/xJcOupu6YicoKWCdLxarOobESj9gsQC6xsEXKDewoXFpP0tVyEZmhpap0Kz6ovxMIBXnptdkwjTrFmIVpiIrD7Kwtvi9eGTfaxRhMGbDj9PBdx8ZDulzwoQB2RfeWMH67HustBhFIfxcAvW1A5EVjnMLrGBLxsPjvKQQuoGIKpo8ZP3Z/dMqyyRMtULWcZD7LHixv5E8VTqR79ft1XBm/ZnIdj4w8MC9w8YZc3ko00gLwTOuYf5U7J02BZ1ZLGwta7j1KbXDWtEguGql7dm/Sc4PZpkBmUl8hA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XDsCPbRgA9LJgRp7v1kd5v1dTkYqCaUQ9dLNuCzsP54rJgr/hY3lBOV4XIVu?=
 =?us-ascii?Q?TgZol5loa+Q3+E4QeCfbcAPmtMWtaiM/rbbQXFaCQc2kwPqMZNdnRb8xYJlR?=
 =?us-ascii?Q?77OhtO+Q4GXGnu9hPLd7PgxS9WOg8bhGw3+6XW0ruY0hd/7/mcDo3bnElQF3?=
 =?us-ascii?Q?f5p6EU8YNoeLeNYST/ofwq1ZaK1PAPgbEBLhclTdQX9Jvi7Mn/AVIYgtFTqw?=
 =?us-ascii?Q?5rA5CNMHA+H7NnaJim+mhbVn3iqC/pti3R07SKLvqaCSncNEn00ntVt4V3Yj?=
 =?us-ascii?Q?k/1hNMuS7P+Zfob0u9QbjTXADivdDgRnCe72PLfR5OLjlh6IWM+wRoKblrLk?=
 =?us-ascii?Q?kB3qXqBGBt7fAzkCqQ6khdU+aCm+pfnh1Gx012hSZaBwBqIIWNV+pXcFMduE?=
 =?us-ascii?Q?fEHigh46FCvstp/f5SrjD5sD9fCepeqVcNP1ZwVNJ0LkI1l1pC0/hEhCPPIU?=
 =?us-ascii?Q?RwyYLhQMqPUhP+sYJ2GXnEljLl6uXW1ldOFdpsYklNYeAJTwmUB0jjcz9EoJ?=
 =?us-ascii?Q?pSPrmwlMGyvKaTdbzdH9f3hlblGb19EKk5C5ye2ayXIKGmghMdNDCgVhWEzW?=
 =?us-ascii?Q?bSG82MpCWDIN9g6fv0iPTUbZMeLADb9yLRbJp0w69yp0UrEu1DjF9GnYBBLP?=
 =?us-ascii?Q?9jFHJkirJyhWycrdaZUuzdf1cGmXhbZyQEQaqmmY6GJbV4UPL2ICy1aijfK/?=
 =?us-ascii?Q?pm7OQ4jnL2Qq8gYjv3fd6WuRZIWup3aEaEIw1SxaL1WU3b3DtJLticraOduW?=
 =?us-ascii?Q?3ug22dmxmdn/6q6/8dIrfnSMM1AJhNtURqEhx/h8rEi6Re445YqO//FbB04N?=
 =?us-ascii?Q?6fWrsjJ4yqATO9bVN3DmlepdRffhKxdCO8oMOylhHWvWrBrURBYQew+YM3hL?=
 =?us-ascii?Q?LtPoa/8pZmyCCl2CJeATErsh6r6aUEBhou/hHNmV8WaEWDgcHCV0+XtMmOnB?=
 =?us-ascii?Q?DhAKLfwkO+X2jZoea6HGdTzBtEu6i59erFW0bHLINla6R7WmBd+8gYZ3YMry?=
 =?us-ascii?Q?017B+MsseRln3vXeYnYUHl5QeYtdDMj0XlJndEjWePc1eR0JltgQU68/WIUI?=
 =?us-ascii?Q?qxN2rUWBsZ1aUFtEFfbNbxmmtdo54+6FlZ9TUO/o1V9atUqDMq8DtleriwUC?=
 =?us-ascii?Q?xIcaceGNdnnUpFaHB9QKLt5nig3crWxCWj61jAXeBcUhY6Qwn4QVFkrnIbY9?=
 =?us-ascii?Q?4LAc5EX9/Ti2l2cC4Lb8FGXZvbKNxI7qEQmhi8RkWxD8elhaQe8R6sYYuauM?=
 =?us-ascii?Q?XEDdpPipbwxd9L0zClC0noBxqXhbE9XIzDzF1+srXQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505165f8-7154-4580-a14f-08da94cc98af
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:39:28.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdamond is implemented as a periodical split-merge pattern, which will
create and destroy regions possibly on high frequency(hundreds or even
thousands of per sec), depending on number of regions and aggregation
period.  In that case, kmalloc and kfree could bring considerable overhead
to system, which can be improved by private kmem cache.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 mm/damon/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 029ae384e6ff..0b1eb945c68a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -29,6 +29,8 @@ static bool running_exclusive_ctxs;
 static DEFINE_MUTEX(damon_ops_lock);
 static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
+static struct kmem_cache *damon_region_cache __ro_after_init;
+
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
@@ -119,7 +121,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
 
-	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
 	if (!region)
 		return NULL;
 
@@ -148,7 +150,7 @@ static void damon_del_region(struct damon_region *r, struct damon_target *t)
 
 static void damon_free_region(struct damon_region *r)
 {
-	kfree(r);
+	kmem_cache_free(damon_region_cache, r);
 }
 
 void damon_destroy_region(struct damon_region *r, struct damon_target *t)
@@ -1279,4 +1281,18 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
 	return true;
 }
 
+static int __init damon_init(void)
+{
+	damon_region_cache = kmem_cache_create("damon_region_cache", sizeof(struct damon_region),
+		0, 0, NULL);
+	if (unlikely(!damon_region_cache)) {
+		pr_err("creating damon_region_cache fails\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+subsys_initcall(damon_init);
+
 #include "core-test.h"
-- 
2.25.1

