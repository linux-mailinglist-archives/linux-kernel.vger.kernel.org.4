Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19B56FBE3C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjEIEeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEIEd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:33:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375A5B83
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9gg1Rs/2k2fgGXMCAEgTAtyjypnQWRmivtWl+cGJtDGfmE891ZUlbDkiR2/mArW7tpR/s6dQVbCfWK+AAwqBQlgLCKSq7bLhZgc2l+3qZSDeOwwpl3MZ1eLZ2NEcfQl0/x5Tu/MD3tLOAfdpWMl3gtrRWGo72sRgV+Kxab4xE95IAfLSgIwCAzZB0Jju6u3aq1fRlvzvyzlSz92WEmwYjjIKpZKcYTnDVsEwUAqbi3Vw6qVU0JCE9b55RBTbmFNX9m5VlQP8XGZicgrsudcLK/oRZ9qO+FuUumWimEcEfxYxcwwOF+3TjWp9GZSYZDZCNeW6UtmC1ib+rA+JvSv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5+qU6AvMky0Ka85CmNAOqmuzZBU4bxOz43JP2w5ok0=;
 b=biCTtvWNFHsAL5TGCKA6whX8q9e3OZjyc6ena+ysrIgvHVRuiTTnZpsZ+U3gAPgPA/HXpjHZNJ6VInzkQLHTzkQzlHCUMsCUhjETyEngB/ss1hR6GnLR6UwnNJ6JCcgHSH+hWThd1iYWyosGdfGGlpJT5lnmhWdqWBVrhLfnhGTLdtBE6xFZsKBhM6lE68m1g9ZNg5ZCgRp1FxxSdcMKlQ7kOWWq2WddHJ9nMWTLyxw3XEFqTOknHi6xxL2+jQmvArWcgNKAiIp9qanJsT4qoTueVNnj691gH0R8+HoPbf0HNEX+N61/TOZ2MGlb9JnLN8+4Vx9G8q+rvMqhy6wEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5+qU6AvMky0Ka85CmNAOqmuzZBU4bxOz43JP2w5ok0=;
 b=I7FNxRM44Nbw9o/kS+dmxDRpNM9+nh6LY1QWFIlEI79WA5y+/ncaRm56UmndSprWabVzSrepHSb90XYJ4AuW7/skR5rhPf00SB8QJPt4BNpexs+J35aoedoWplakde1kGndHgwih9eV/Cq9/31VtME7/Y4m2jQ51JIU2/Z1npn52oPa9fUMv7KkAPJOZVjZNUGLjR1Qi3/9bZL8jCKhcHbIfOZpr2ORQxaFaznjy4bJS2doA2z4IpDJ6H91usZ2q6PCU8qWRQQmDEMN2NmhqM4iytIDZfL1BE07BnPpxLp4LXdbvaBiezRtaxl2kBHC0P6xmbzJgfc8D+fI0H3vF3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 04:33:48 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%5]) with mapi id 15.20.6363.026; Tue, 9 May 2023
 04:33:47 +0000
References: <20230509022014.380493-1-ying.huang@intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/2] migrate_pages_batch: simplify retrying and failure
 counting of large folios
Date:   Tue, 09 May 2023 14:33:07 +1000
In-reply-to: <20230509022014.380493-1-ying.huang@intel.com>
Message-ID: <87pm7aktso.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1a5ee9-8448-4407-0362-08db50469499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLH08nvJJqMmEWZGIWr+DbK0eZs0PgD0dweGIPEaVndQq3V9STHr22xNQk4t7zPbqZ+UdGtMsiIkhQP7WkGrg1sVqBydEsZzCcYzxFKCIx09hhxx10WzyTECaCzIhMXGcvvGOdIxiLcmNqWdRS5ZUuHeaNE4M6qwFM0V6mpGkX6MQjqKqlada9CaB4IR6ullTdL3Ar2b6XKQm5nS6Kh2n/SisP1EityWNerZKbqXQSePNhSLV353gXmUdaZsbylYkR09z1mUgoC0KNLnnZGlKmK1N8k7AKIH3IlFP6VqUQMXbVXR6lE4IZLJg/a31l2z/F1C8lcaRL+txU8lY4yLYbA+HuUesZlYgHuDPAEgu/mL1NUc3Or3v6I3E6zobDJAjXkqm2cjoabfiNdiFyduor/pyz7wcB+sqpiOykOB5/JH+dxpJiTZRpzZbm9AuvGBMW3CoA2p3Nxpk0QC/c0TYKz95NKrdgCGkxPaV0IIPa5dCYhgKcOacGWJWFy1RLUJCy5XiM7gFPaD11MOP5TLJxIG8CHJ2vDWdI7E7lkirST3fisy6pW0POYqR1AR4EYo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(86362001)(36756003)(54906003)(6666004)(316002)(66946007)(66556008)(66476007)(6916009)(4326008)(6486002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38100700002)(186003)(2616005)(6512007)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sY4o/mAVgYh/wONAtttc9P0vbr8kkx+omqfP/jynhroGL7L2WonB81TuUBBZ?=
 =?us-ascii?Q?CvVCqFW7fHOAy3mia16mUrQ+cB8Vun3exKIC5daPy9INUzOUXHN9B6ADy2V+?=
 =?us-ascii?Q?gCsUrByOem+tkPrK6qa6XxgRYDa5Yg3tm1/YYyPjpvflECoVexh97VjijtZp?=
 =?us-ascii?Q?0tIKVqIHlpws+h84KdtttTIEfSSXo6ExDSl2el+ji04Z2uDI0bZapNTa/15w?=
 =?us-ascii?Q?kpqSD0lT4dOPt5J1m72of6f77dGS4Ji/wZ/UjaNEug/B6NVj7qEHmUUFtLxF?=
 =?us-ascii?Q?XIw+46/nLFCeOrVJAaqt5YKWZzkN1G0FmzEiciUAEIP9OfyBU4IdE6JICXsD?=
 =?us-ascii?Q?B1MhwHfvp7g9jz+jWIijHURcVk9PUh1Xku0PJEiok0iK9O18MSk+5sp8Dam0?=
 =?us-ascii?Q?e/VlEuyvXXgfaxOOoY9Rb+LobiqfLLjvPHUDjiWQfyZ+V1QV61Ktd/r0P3BV?=
 =?us-ascii?Q?DsHNtShpzOa/ip15/1siv1tLlLNshR6rRcke1pNOdDc5q821J5k2Ni+lrutx?=
 =?us-ascii?Q?bEJxA8E1vQonbih5qEN7sAGakGwJA7mPkNAqGJJNxxl8pbnxnzh5cEprI9zo?=
 =?us-ascii?Q?hpO8aRhFEvw5XC0sl2ZrhLoMmYjdtNJV1xDl09VJSd/WNHi/GYVKo63TotFn?=
 =?us-ascii?Q?75oWAyh/m/UAcbH/KMaeabmtSOaqKWpVQ8uFTx98oWj0REf46CwzVQ4QDhxX?=
 =?us-ascii?Q?+aSQcdszQ0xC0W7SJL2KG2XoGzDVilkkiVPiPJtExwZZpMtpq3vwR6uOwVCa?=
 =?us-ascii?Q?cEMQ87SEWgwqshr1dWH8xZHVbNja6x6WGpAiZr/GN60970uqsGZIvg5y3kPD?=
 =?us-ascii?Q?63MsuOr8iS84Z/VkxvOEf4rXqFEJ0NCmGdAELB0O9kjLqJENGu4msAR51bd3?=
 =?us-ascii?Q?x5UzS8RivhePqNzPvTfJDUk4CKvdlH1op6XOcpJdrWh+qQyRWFthu8OjnATK?=
 =?us-ascii?Q?zwOSfnzPV3QW5oE5r9tXNeOIhdXBIBcXNtXVKE7ungoGQZiHQqlszPUs4BvS?=
 =?us-ascii?Q?NvnIdFMP19Viw71BsPLmhnOHN3OL/at4ovbicVa6ObRU2gkE/FSQg2+qMxrd?=
 =?us-ascii?Q?G1vmCtz5gz9NHpoLoLqPvvQbgwZJjQVHCpOrr6HDCrUhKca5yUpo4K0wBMTX?=
 =?us-ascii?Q?XRm9WUF0XsDX4tIwpp3gZ14PpFLUB0wWOuCOYqSSSK5Z131cRng/gmg1VMvM?=
 =?us-ascii?Q?IcgINo4unbc8I1KytFsE7NSa8Z9Cnw0+v4ZcVpMHG+/H5+SMOCJSrKsPFoxI?=
 =?us-ascii?Q?3kbedOtIbOeHDYHVmzn/GNR4HZblE9sXvmFtsdh3gK1uYlFyy1K3y6kX25gT?=
 =?us-ascii?Q?O5ayJBqu1YHLn7mCnYx7tvIpLiUAYqd1AbtZIveJdcZOeY+4T9N8rLwrSpDN?=
 =?us-ascii?Q?z0ILI1QwVswPuAIl5PCaV5IaL37PyO7VJ4yB/JDJY/CNT//oFTcdHdimbGP5?=
 =?us-ascii?Q?S+f7Tx+nJZZFKQNNt4T0T9jCy/RtFLLqPASUtwjEa2KyjFpCFVIZebFiaYuA?=
 =?us-ascii?Q?hIeAxIBWh2DGez6t5mMSkwwd/yrWN79EtiaRsvSEbrfzs+4b7RlUejvBJvBK?=
 =?us-ascii?Q?gEcgEleIlIMAmh2+pY8UWfi23sJN5POz95nG0fbW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1a5ee9-8448-4407-0362-08db50469499
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:33:47.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT7RSvRzLTzGHni7cCPXnFlopCFoAnwFYQBKqLVSp2EqHMCWqmaLMPh2f4bN3Q60qQrLE/bucKZOPUXExRSCVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> After recent changes to the retrying and failure counting in
> migrate_pages_batch(), it was found that it's unnecessary to count
> retrying and failure for normal, large, and THP folios separately.
> Because we don't use retrying and failure number of large folios
> directly.  So, in this patch, we simplified retrying and failure
> counting of large folios via counting retrying and failure of normal
> and large folios together.  This results in the reduced line number.
>
> This is just code cleanup, no functionality changes are expected.

Quite a nice cleanup, thanks. Feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/migrate.c | 103 +++++++++++++++++----------------------------------
>  1 file changed, 35 insertions(+), 68 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..10709aed76d3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1614,11 +1614,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  		int nr_pass)
>  {
>  	int retry = 1;
> -	int large_retry = 1;
>  	int thp_retry = 1;
>  	int nr_failed = 0;
>  	int nr_retry_pages = 0;
> -	int nr_large_failed = 0;
>  	int pass = 0;
>  	bool is_large = false;
>  	bool is_thp = false;
> @@ -1631,9 +1629,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
>  			!list_empty(from) && !list_is_singular(from));
>  
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>  		retry = 0;
> -		large_retry = 0;
>  		thp_retry = 0;
>  		nr_retry_pages = 0;
>  
> @@ -1660,7 +1657,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  			 * list is processed.
>  			 */
>  			if (!thp_migration_supported() && is_thp) {
> -				nr_large_failed++;
> +				nr_failed++;
>  				stats->nr_thp_failed++;
>  				if (!try_split_folio(folio, split_folios)) {
>  					stats->nr_thp_split++;
> @@ -1688,38 +1685,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				 * When memory is low, don't bother to try to migrate
>  				 * other folios, move unmapped folios, then exit.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -					/* Large folio NUMA faulting doesn't split to retry. */
> -					if (!nosplit) {
> -						int ret = try_split_folio(folio, split_folios);
> -
> -						if (!ret) {
> -							stats->nr_thp_split += is_thp;
> -							break;
> -						} else if (reason == MR_LONGTERM_PIN &&
> -							   ret == -EAGAIN) {
> -							/*
> -							 * Try again to split large folio to
> -							 * mitigate the failure of longterm pinning.
> -							 */
> -							large_retry++;
> -							thp_retry += is_thp;
> -							nr_retry_pages += nr_pages;
> -							/* Undo duplicated failure counting. */
> -							nr_large_failed--;
> -							stats->nr_thp_failed -= is_thp;
> -							break;
> -						}
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
> +				/* Large folio NUMA faulting doesn't split to retry. */
> +				if (is_large && !nosplit) {
> +					int ret = try_split_folio(folio, split_folios);
> +
> +					if (!ret) {
> +						stats->nr_thp_split += is_thp;
> +						break;
> +					} else if (reason == MR_LONGTERM_PIN &&
> +						   ret == -EAGAIN) {
> +						/*
> +						 * Try again to split large folio to
> +						 * mitigate the failure of longterm pinning.
> +						 */
> +						retry++;
> +						thp_retry += is_thp;
> +						nr_retry_pages += nr_pages;
> +						/* Undo duplicated failure counting. */
> +						nr_failed--;
> +						stats->nr_thp_failed -= is_thp;
> +						break;
>  					}
> -				} else {
> -					nr_failed++;
>  				}
>  
>  				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>  				/* nr_failed isn't updated for not used */
> -				nr_large_failed += large_retry;
>  				stats->nr_thp_failed += thp_retry;
>  				rc_saved = rc;
>  				if (list_empty(&unmap_folios))
> @@ -1727,12 +1719,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				else
>  					goto move;
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>  				nr_retry_pages += nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1750,20 +1738,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				 * removed from migration folio list and not
>  				 * retried in the next outer loop.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>  				stats->nr_failed_pages += nr_pages;
>  				break;
>  			}
>  		}
>  	}
>  	nr_failed += retry;
> -	nr_large_failed += large_retry;
>  	stats->nr_thp_failed += thp_retry;
>  	stats->nr_failed_pages += nr_retry_pages;
>  move:
> @@ -1771,17 +1753,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	try_to_unmap_flush();
>  
>  	retry = 1;
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>  		retry = 0;
> -		large_retry = 0;
>  		thp_retry = 0;
>  		nr_retry_pages = 0;
>  
>  		dst = list_first_entry(&dst_folios, struct folio, lru);
>  		dst2 = list_next_entry(dst, lru);
>  		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();
> @@ -1797,12 +1777,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  			 */
>  			switch(rc) {
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>  				nr_retry_pages += nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1810,13 +1786,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				stats->nr_thp_succeeded += is_thp;
>  				break;
>  			default:
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>  				stats->nr_failed_pages += nr_pages;
>  				break;
>  			}
> @@ -1825,14 +1796,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  		}
>  	}
>  	nr_failed += retry;
> -	nr_large_failed += large_retry;
>  	stats->nr_thp_failed += thp_retry;
>  	stats->nr_failed_pages += nr_retry_pages;
>  
> -	if (rc_saved)
> -		rc = rc_saved;
> -	else
> -		rc = nr_failed + nr_large_failed;
> +	rc = rc_saved ? : nr_failed;
>  out:
>  	/* Cleanup remaining folios */
>  	dst = list_first_entry(&dst_folios, struct folio, lru);

