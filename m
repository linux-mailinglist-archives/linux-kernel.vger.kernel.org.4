Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374A65E357
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjAEDR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAEDRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:17:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E55165F1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI0gu3xN9iY8gFnKYB5J0YTzdZ5SqkXZn3FEP1rRtIH/IHXsKkpcpbMBIlbhdkGGkHLRas5aGx1eqmSk2duvY4J1ct1xspAIw2oujSMr4VkBv7rYmD33wMTrZULJ7FsdHribwcXclhXETMCK05jCn51wvg9RnP8sCmUaPmVgqoHmsTWPURhc8zvE1WCUkwphEaW9GMXbW38mHSme0uPeNM4DIy3evIPgOOyR//fiQLnsqDMQYCtJzndieXjGhmYrfFeg9VlfPFnKp8mGOlSjOaainnnKj4BLIime5CZ2XLt7O88puZ394gz4AmlEmWwcUTl8mp0dBo9BWV9B+lF5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xS7u2JsI7nu/fTgiF+s8tH/r037JWRPiZk3hfcQtrY=;
 b=jPbQ24G6+wgmEojAkQxkKAWLAKN1iioLw4/S9KLWUEENAWfO2NjIX+O28YFFsMD+0WkidbimsF+4GLL4Rh32rR3g5zdVm9vA/7CfDGLXRrXJ6HpJzkfbQuTVUVgXcJlJ5P3hbucUC1ImOl6FjkSRAdYz8HsJ183irINXBuTm6cNWpJbgnxa+tHP0uunWoDSq5ZCs+XTHO9IlJRGNsXAoPIn7xKfQl1l+3mJHkppmJ/fFO5IMZEClwL7igND152Nzy+DedeH6er0xfpIPxI99eOiW2MLVjjET5iXunYCmnuJOBdG9HevMOKtcdj32op5Mj5Giu+38K5I6iALk1/R12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xS7u2JsI7nu/fTgiF+s8tH/r037JWRPiZk3hfcQtrY=;
 b=csjx4aIwKMuxCTPwkcoC4ifKwCUXkK43Jhn1u1wTDYxEst8K/Ahx2Vpym1ES6HWSq5PMPCFt4OopwYAl28L54i+hKzvPzlCMoDPpEL/zNYBymtUjjdbtaJQX1ojJ2GnTi+rrjlvvTKdji2NM9kOAoiR3xQgAKv6mP7hxp9LvvpwT8BBlQUWGtDutMZoWMcVeoDK6uLZQNysKnv9G4BEpskkzCi7LazoD8hlVrFJmIcbesowneO3IK624z1WkcTYHMrXmHGgnXaJyq4TSB1YkRdpPt9/2RHzxiTE5uiz2Tkmo09niq+5SDjiSx2NsRnOi3cFW8oSxhvjAu6vaLZCuNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:17:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 03:17:42 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-2-ying.huang@intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 1/8] migrate_pages: organize stats with struct
 migrate_pages_stats
Date:   Thu, 05 Jan 2023 14:02:12 +1100
In-reply-to: <20221227002859.27740-2-ying.huang@intel.com>
Message-ID: <87y1qhu0to.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 678aa34c-268f-4cea-8e03-08daeecb686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sTWk+Ryi3xDpI48aKhGl6otG45o5YYTjg2z6Y7ahCHjNaSiHQ5xTloGDXQrDtOk6GWGDNIue+7G3drNq7uheCfpPedG83Vm7Es6HMvOAjX/cVc7okXYiw+Yeb/YpKaOAYuLIfW2Ra+YzEDK6uAIzUbp5qWg3PLqnxwnw9Lbw8zH2Ga6m4qkQ0Txh3BuOcC5KKwNdgLs0+FmZOQ4zj1C2dpBwJDtxz6HXE1YxG4ob2KZYwX6YnWMv2uJotzfqvacHvCyL/yKRkmc3hNGy56CzR+dVsNwf6sIa6Rjv+B2oJ+FPj0aKbHOAPSgCATSm9SGhLAD4vVU/8sFAKkSy4xZ3B3kaJmfd08mmKhPGwpQG00ywKBWtomo3/GrSquyjWINM69CcZpAKxPhBcBArfsGOfvfDJJHVNmQdBAxMqjOQTMgjxkyUL/P+aKoY4qPP+b97HaJJreEYh/LJL5u83mkjcuclCOOUpA0PCMfU9WLfEsEt7kq6eMYsOqxBCReq9ow+cSY9IcOv8wpomFpM6vigyZw3SmbF+djp0iBLaJyRAXMbEPZ4ahXyW5XKSA+GbPbZuaSgOdr8F4VZZ/sA+UqG4VdiWiHUfGFJLukjBRbapkG7vfrrLAygxz/7MDXvr3QCxttslWv7IPPahYDYx06ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(66946007)(8676002)(4326008)(66556008)(5660300002)(66476007)(8936002)(316002)(6916009)(2906002)(7416002)(6666004)(6506007)(6486002)(478600001)(54906003)(41300700001)(6512007)(186003)(26005)(2616005)(83380400001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SCxXP4n0tXgjK6ykbaE7eGBHRBHvseTnkka8Lu46G75Uf36HbHpKmB/aCli?=
 =?us-ascii?Q?v0NVYGS0suJOy6YwbUZzkI/jjBfvLIPV7Xap7zduYkAC8HhTsYswUiry/uC6?=
 =?us-ascii?Q?PD0rjimVwxboPaCnuJuSujLtgElaRs1ngdwKpNnxs9HzrsHYLpPzBW033iS+?=
 =?us-ascii?Q?wUdzczfIxuk1AXM/xLKTDc0SN91iKb+YGATINFe3gPyNxh3McmBFiG4KhXyo?=
 =?us-ascii?Q?hPmnmUZFTBFX+xgG0EEEIaoVc/i0DFzayRrEODpz+CqOa2BnWfdCiqb16zdd?=
 =?us-ascii?Q?I82RuVQYxmnIkvcH+smtm+M4EFoFQ6uw3BDhajYlzzwwzNwXKNQU4C63ASBy?=
 =?us-ascii?Q?j3rZ9+/mU7fBOM6/HDlGd4ipPQKdD9nNVYZol/L2tCcKqgExYyHAmuePmz4V?=
 =?us-ascii?Q?hryEG5QEB3w5f7RebIfwDsEExOlSdVdbHk0395m9UUluIz1PERnv6+27zgmk?=
 =?us-ascii?Q?OEJMDys6DQhrufNMVo0liU1zu7M53KD0wnDwMGmZmgyU7Bxs6Uwo3rorgySV?=
 =?us-ascii?Q?u84hK42d/UbLsLwBZdSF1xzkj8Eaomcif0CvsnZa9j6yAzOjTtfZ3QW9r1Gh?=
 =?us-ascii?Q?E+20oc98aqdUQBv55+GyKwApO03W75ggRJn/tsPivj1PX9ZhTBLgD9k4nger?=
 =?us-ascii?Q?0CFOvokollmzuENvzPwweFZXOQcJfwnBjaHCJTHiWXOgRtwM4AAXVTddi9u/?=
 =?us-ascii?Q?SWCERzWqYsGqZPgd+mIYRnC3BdLO4qdrX1QZ/MrZEhwTTsM4cL2yar+zYE4e?=
 =?us-ascii?Q?G0m4F5swZiCsLkouqFIHD2A2Bv3+FLqjhszBssohBJHBSr0h9P/9cxOcvDIZ?=
 =?us-ascii?Q?dMoxceFkCfLMr9ocFoBGhcwgT5ZkrTBOGSR6omqWk6xdIuJBzmHoYAU6+DYG?=
 =?us-ascii?Q?OL6iXv/nAqaWZFRf/m420CMH6aruyKOCxPOLM88oupYJzCICZMjAK+hS2lFo?=
 =?us-ascii?Q?+Ok0oR3CyBqSf4i18ENVbdSDRSd2K9UHtsCq9uGAloc+jhwk33ZX8yez24Mf?=
 =?us-ascii?Q?PjzsjXxUmo3815h035ERJ+BUYvFqDYKmjCPAXNTmDqULsKHi5zDApQnSLM6M?=
 =?us-ascii?Q?gX5SpD+plcc/StetlhhUNSE+izbC/BNXHEd7cVYuraFnC6IAST0iuKTF6sO+?=
 =?us-ascii?Q?+Hw4CdDPrnc7AdsYlBEzd324ap19QZU+AlhAAfGBQJrJHI1uzeT+8IFyaQIk?=
 =?us-ascii?Q?02irpdkqWJaKCLoDVql3aR5QPOOHH3kCYwMnGHrbCIaTcC6Bbf7+ZG0bGR8r?=
 =?us-ascii?Q?prx28RWLdV5TLYOoLTRzaS/6ueFskHWDnizv+PvsZiswBRyjBH6nOZpsycBf?=
 =?us-ascii?Q?G6rHBiGEhcZVOBf8X8Ws2vuG0CVqjW5bzRQ2arlgpIlhPXfct4+G+hLsEreO?=
 =?us-ascii?Q?0gNuzXHHQ6I0IS9y/PC+SHkyedIybKzjDkWJyTJ4ttDLr34Xfi1TOR6jGP42?=
 =?us-ascii?Q?vNN/6MuR862Y0BDYVrlDqsSWe0mwBhwnMt5IhsdWd8Ayfr27sBck8OwN5WPX?=
 =?us-ascii?Q?oBVlR/1aBoRhvK5Q86+vkbC1xISgoPZo+tWsqTMpaaMkzB/k7iP6puBM6YBr?=
 =?us-ascii?Q?+GuM6WQekKL4MkPwpC0YLkEm9jVblRPj6I1CwAIf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678aa34c-268f-4cea-8e03-08daeecb686c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:17:42.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta4N26hzuwEIgQZMtAcy20XXI1VnI/76v4tJSEgC/jZ+CGhxx0RGLLYUYGwFhnYzxBp1WGNGL88XroVdYZJguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> Define struct migrate_pages_stats to organize the various statistics
> in migrate_pages().  This makes it easier to collect and consume the
> statistics in multiple functions.  This will be needed in the
> following patches in the series.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  mm/migrate.c | 58 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a4d3fc65085f..ec9263a33d38 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1396,6 +1396,14 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>  	return rc;
>  }
>  
> +struct migrate_pages_stats {
> +	int nr_succeeded;
> +	int nr_failed_pages;
> +	int nr_thp_succeeded;
> +	int nr_thp_failed;
> +	int nr_thp_split;

I think some brief comments in the code for what each stat is tracking
and their relationship to each other would be helpful (ie. does
nr_succeeded include thp subpages, etc). Or at least a reference to
where this is documented (ie. page_migration.rst) as I recall there has
been some confusion in the past that has lead to bugs.

Otherwise the patch looks good so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> +};
> +
>  /*
>   * migrate_pages - migrate the folios specified in a list, to the free folios
>   *		   supplied as the target for the page migration
> @@ -1430,13 +1438,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int large_retry = 1;
>  	int thp_retry = 1;
>  	int nr_failed = 0;
> -	int nr_failed_pages = 0;
>  	int nr_retry_pages = 0;
> -	int nr_succeeded = 0;
> -	int nr_thp_succeeded = 0;
>  	int nr_large_failed = 0;
> -	int nr_thp_failed = 0;
> -	int nr_thp_split = 0;
>  	int pass = 0;
>  	bool is_large = false;
>  	bool is_thp = false;
> @@ -1446,9 +1449,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	LIST_HEAD(split_folios);
>  	bool nosplit = (reason == MR_NUMA_MISPLACED);
>  	bool no_split_folio_counting = false;
> +	struct migrate_pages_stats stats;
>  
>  	trace_mm_migrate_pages_start(mode, reason);
>  
> +	memset(&stats, 0, sizeof(stats));
>  split_folio_migration:
>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>  		retry = 0;
> @@ -1502,9 +1507,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				/* Large folio migration is unsupported */
>  				if (is_large) {
>  					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>  					if (!try_split_folio(folio, &split_folios)) {
> -						nr_thp_split += is_thp;
> +						stats.nr_thp_split += is_thp;
>  						break;
>  					}
>  				/* Hugetlb migration is unsupported */
> @@ -1512,7 +1517,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_failed++;
>  				}
>  
> -				nr_failed_pages += nr_pages;
> +				stats.nr_failed_pages += nr_pages;
>  				list_move_tail(&folio->lru, &ret_folios);
>  				break;
>  			case -ENOMEM:
> @@ -1522,13 +1527,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>  					/* Large folio NUMA faulting doesn't split to retry. */
>  					if (!nosplit) {
>  						int ret = try_split_folio(folio, &split_folios);
>  
>  						if (!ret) {
> -							nr_thp_split += is_thp;
> +							stats.nr_thp_split += is_thp;
>  							break;
>  						} else if (reason == MR_LONGTERM_PIN &&
>  							   ret == -EAGAIN) {
> @@ -1546,7 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  					nr_failed++;
>  				}
>  
> -				nr_failed_pages += nr_pages + nr_retry_pages;
> +				stats.nr_failed_pages += nr_pages + nr_retry_pages;
>  				/*
>  				 * There might be some split folios of fail-to-migrate large
>  				 * folios left in split_folios list. Move them back to migration
> @@ -1556,7 +1561,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				list_splice_init(&split_folios, from);
>  				/* nr_failed isn't updated for not used */
>  				nr_large_failed += large_retry;
> -				nr_thp_failed += thp_retry;
> +				stats.nr_thp_failed += thp_retry;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_large) {
> @@ -1568,8 +1573,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				nr_retry_pages += nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> -				nr_succeeded += nr_pages;
> -				nr_thp_succeeded += is_thp;
> +				stats.nr_succeeded += nr_pages;
> +				stats.nr_thp_succeeded += is_thp;
>  				break;
>  			default:
>  				/*
> @@ -1580,20 +1585,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>  				} else if (!no_split_folio_counting) {
>  					nr_failed++;
>  				}
>  
> -				nr_failed_pages += nr_pages;
> +				stats.nr_failed_pages += nr_pages;
>  				break;
>  			}
>  		}
>  	}
>  	nr_failed += retry;
>  	nr_large_failed += large_retry;
> -	nr_thp_failed += thp_retry;
> -	nr_failed_pages += nr_retry_pages;
> +	stats.nr_thp_failed += thp_retry;
> +	stats.nr_failed_pages += nr_retry_pages;
>  	/*
>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>  	 * nr_failed counting in this round, since all split folios of a
> @@ -1626,16 +1631,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (list_empty(from))
>  		rc = 0;
>  
> -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> -	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
> -			       nr_thp_failed, nr_thp_split, mode, reason);
> +	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
> +	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
> +	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
> +	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
> +	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
> +	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
> +			       stats.nr_thp_succeeded, stats.nr_thp_failed,
> +			       stats.nr_thp_split, mode, reason);
>  
>  	if (ret_succeeded)
> -		*ret_succeeded = nr_succeeded;
> +		*ret_succeeded = stats.nr_succeeded;
>  
>  	return rc;
>  }

