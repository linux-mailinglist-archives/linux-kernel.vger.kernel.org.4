Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7560A6FBE40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 06:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjEIEfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 00:35:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3825277
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 21:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKu3Cr48oTZpx0n0+ZOb8EdxRqg5l4m8XzKDc3CVpHcZp8EQCMI7VpmB525/0TVbDYrBd1uExUo8UveHMwEh958mkyeVgADVFp9bhP6g+Hog7TEqCqEGoL0+1AWxaDWveYgAM4wzEKBVGCvohfp+mBJigF34R8IdC5VgNboi0skJdv2Y/YszGNA1uULGMBKoKIY5Du20oQXFDKbz/ZhrekCXx/ZvZ/TFvHn80aVAYtKSWTUwoF/C9b3zrI6oUDiHj+Cl9e49cThfNKRa5mO5jLmYXKZf49c3tDHBnYof5cCE/wZvdLhakbKICMh8Erll4AsxCvXwbmWtvjmywcwBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGCt+lEbuJiYJ0LeTMzI6mvBdMIDGxxK+DGCrtOTcaU=;
 b=Cwrclx0FvvMU1c/H+BlHa4AJdNvegcb4N3joBVTH2ZjthLSbiEV/ZWj4bATEwsxkGry9hgMP/D3dDBmR89wOzG+Ad2vZ5oyHHPLJwMphTxJpcsql6YC2JCUNufjsiaYdEcPu8kpevoN7tH8i+/LNlHVbaQL1+zc305OMfjNQ9rt4rkWUwqhJY6SuwSwcagmmWRjDelMne9MilIorF13PK9kwMuvjjdtZWvckN2RMllrAkBDV3h2grIPDOtzQyrkLbMBZYJZMzzKBeENkkwqV2OfL3EzazT7UdYrXHlYyWmwIS33L1pe4/iDdg4jC1L5wjNHv9sHn8yI+fsERp2MYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGCt+lEbuJiYJ0LeTMzI6mvBdMIDGxxK+DGCrtOTcaU=;
 b=EfC2RGZDRytbYnDr2mbk1/uhxY3Ng20YdEkHzbx4UGOa9/Co4CLy+ylrYKbQxpL0Bm0OUZN58sPFixKI7ScapApGvY5rXDalKomLkBMUliohl5Yk1enE0luwl4hk5JPT8aZvhbGiVJBWNyd5+fhaDVGn//EKBAy57G/MhdLeDAVYUyHlOei5bdxrCn0KJhTSpMyAg1X/n1RlgNntRUK+VfL3qXeoOXQTuRnOUDwSI9GwDIYk2q2WDHwo3tXZaBjmShELNc0ZCmo1jFWSZGDFFYwY5jzknPF1cfc5ZlF8ddmwToyBK1BjLA45PqT96RS6gpax5GJaEEjYyBh9jcu+Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 04:35:35 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::8738:993e:ee40:94b9%5]) with mapi id 15.20.6363.026; Tue, 9 May 2023
 04:35:34 +0000
References: <20230509022014.380493-1-ying.huang@intel.com>
 <20230509022014.380493-2-ying.huang@intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/2] migrate_pages_batch: code cleanup: remove is_large
Date:   Tue, 09 May 2023 14:33:50 +1000
In-reply-to: <20230509022014.380493-2-ying.huang@intel.com>
Message-ID: <87lehyktpv.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e4565b-78a4-44d7-931e-08db5046d46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeFVFcIsYMCCagbFDMYao2k4V43Qq0Ugio7Ke3NfJTK6h0I9ghduEIYpJ6ySi29/M9CB/tIj9MP3c46vhB+t+NWC0oSlRxecnmT/jue/CtZ8MqfeMCXVthYZwxh+Oglv57Pznjb5a4oweJAr0vUKOGQer3Ds2M9SQd7nbadLt8hGvz/eHOy3TFPEt8yZJhWt25oNxreZc4BTXf+7jzcohw59SkaPCBMNh6RXY6P6YQtkrXfhp1HbhYyfF9mbfnipa2bFDL1flZd7VMUEvyiuj+pfVCfgqLEFT6IQmWB4z+mdzt2n89KfpWYs8sQK7IdmTxvnO/+t5XCw1pFWHmnuUIRyOkOQMi5Oe/oK1pQ6ZzY/p+/fepkjLVT0TyS90c5dObltTPMJBxuR4e0IYFBFUvQ4hPBpgdWQVEiEsXJf/UMvAG40Uhj7SwjrRDjupxQbcwbKlnuY1V21DYKLeSaoiWPdHgHX/+u83yEtqcjsNc4OIOg7+p4iDK49T0spr8arbpxSeUsOKTrXPCn85cQ0LOkH6EfcybXIs12wlpOpSU5nOA96z0p7H2fkJgqT8k4r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(2906002)(5660300002)(36756003)(38100700002)(86362001)(54906003)(6506007)(186003)(478600001)(26005)(6512007)(83380400001)(6486002)(6666004)(316002)(2616005)(8936002)(66556008)(8676002)(41300700001)(66946007)(66476007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGuxiAeJ/Ymsfq+gHNv286ZGkkqoJSGp7+dPKMyftzWMNmCKOUOss3HhQrMg?=
 =?us-ascii?Q?z4uJVcZoCBYKqSs7wrBt2gXpZi9F7xf61EeGUZnp3bpS/LocTSJIxLzqp4lw?=
 =?us-ascii?Q?DPoM0qUjHqsJ+eUNu1WcvrJif8zzXnxRt3IJ6WH+NaTTgbb02arhRur4FjUm?=
 =?us-ascii?Q?p8/ulXswCwBn12Tk2efGTiHMPBh0krAs8C/cMJ1um21kifTPGHSbvX1r96US?=
 =?us-ascii?Q?wFRe4gLYW4GsA+UliBJKAG460W+QBnWlDrDoOoG1BGrGfvJJcfNcekrZD3J+?=
 =?us-ascii?Q?8E1ZAP5Tib6PYSKGukiBN0RDm55aVy3gTj1zUnlUQqrSSgM5llX61lomKNo9?=
 =?us-ascii?Q?IqxE1AMRkWcRUR0gTvu72DEoUKJyOzbbLRpjkqyCYC6PC0XiAQAqCakWtFCc?=
 =?us-ascii?Q?tOya3HIue/+lIOFLppCRu/psyNAi97V9HMNsNsdV9JykmU/v+LBzBSzji04Q?=
 =?us-ascii?Q?QK/lUqYSZ6uBb2xFtT50v36D36BIt2qgKI/3ZmXYEuyJK7blAIyy1eaFzUFF?=
 =?us-ascii?Q?CfJG2tkWIT0AA/vRmXMOsqCus5lcfzueN3Pqhjax9nEON2S+xHsz6smJQjQJ?=
 =?us-ascii?Q?lz4iEsb/I1Ujw9FHmjg3ONf2u4BGt5FhwMrNt3dq3uzR8RPEd3OTXNtC2O7j?=
 =?us-ascii?Q?qdFK1yOboAce5gLQOxlqIayOn7yPQ2vuPgGrZKG4Gf9FSXxK0wlCbH2t3owJ?=
 =?us-ascii?Q?TvT9Cwlxnk1GYQ5rEVce31BzowjFHtxfWgV9t1Df33k+SLC3GE5RmlzL4sUe?=
 =?us-ascii?Q?7b6ln4VXKcXmfYAisAc701f5g0I1o0RWLURrnLXnBSy1k4DrYjg7AuI0C6vC?=
 =?us-ascii?Q?OHXs8rEAOH2u326vN2UyYlx/j2BZmDGqWHa6bFWy0w7P8XJf9Bp1UzlDU3gY?=
 =?us-ascii?Q?OEjocr6tBXAWT5OTreJug5plbrsg4s6sxNpRWLlTbw/pioQAN0CZ+8b9Tvsw?=
 =?us-ascii?Q?05ozAvy7E/HgZZcRpRrskbYzp+BwO9P/NsGsDyfG/fVdpRqA99bLQzKTVk+A?=
 =?us-ascii?Q?S+UILREJMFhw6IJNvF7FhM2YGt67mA//rLB3XA/acQ9Bg5yj7hBuO5FTW3wH?=
 =?us-ascii?Q?SVpbDiHLQQYWKDuBzX/Lj5MegEPztc4wiZj50UHBr78EORlXOVsFxn3I8q1F?=
 =?us-ascii?Q?6JUXDQjaiORVLXNe4lN7Uc29egolgajjkwTxvVlqZ4RhdEGmnMWREeugNdn8?=
 =?us-ascii?Q?S6KwExe1CG5W3Zw1oITEuzKHru6mZPQBFdUqb7I9LKYEN37B9CLZJBhGzLV0?=
 =?us-ascii?Q?73+tDMwIop1ZzX6IvH1P9CUnULKgEfocO/SLDDpdspIzwDt6pxFWTD8oGlao?=
 =?us-ascii?Q?RUKZ6oI6Buh3UGySSfh8fMqgKNPMljCIn8z6D9vSrnHBcy3+DJCicfeG0RYd?=
 =?us-ascii?Q?QzY9oxZ8qv3/2MO4QArZO55nCiwvY8GFCn9PSh2C8YyfnNreHAwb/kJZ19TE?=
 =?us-ascii?Q?osG1/h7j+uyMy9/TcU3M8qUhKov5U45EbhgbAkWm6R/bRhEjmi7U1XTj/ALw?=
 =?us-ascii?Q?VmFlUbWWH+dgqDHHqhLE8mbJnFdIvYIEHcVOKg6ETcP9YyqKV6aWp66DElVa?=
 =?us-ascii?Q?JRwf9gj7E+0vxbX2JOY+A/hzavbNklq8wrS1bsW3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e4565b-78a4-44d7-931e-08db5046d46a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 04:35:34.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ1hyaHu/sYzjGbgUHXUc4tpB/aeE2p5+TU+H1cUMt/Hv8ZfGuBawZeKB5XeJEFLX2iMpRDFr5fJOo5zuVyfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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

> Previously, in migrate_pages_batch we need to track whether the source
> folio is large/THP before splitting.  So is_large is used to cache
> folio_test_large() result.  Now, we don't need that variable any more
> because we don't count retrying and failure of large folios (only
> counting that of THP folios).  So, in this patch, is_large is removed
> to simplify the code.
>
> This is just code cleanup, no functionality changes are expected.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/migrate.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 10709aed76d3..2ac927a82bbc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1618,7 +1618,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	int nr_failed = 0;
>  	int nr_retry_pages = 0;
>  	int pass = 0;
> -	bool is_large = false;
>  	bool is_thp = false;
>  	struct folio *folio, *folio2, *dst = NULL, *dst2;
>  	int rc, rc_saved = 0, nr_pages;
> @@ -1635,13 +1634,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  		nr_retry_pages = 0;
>  
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			/*
> -			 * Large folio statistics is based on the source large
> -			 * folio. Capture required information that might get
> -			 * lost during migration.
> -			 */
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();
> @@ -1688,7 +1681,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				nr_failed++;
>  				stats->nr_thp_failed += is_thp;
>  				/* Large folio NUMA faulting doesn't split to retry. */
> -				if (is_large && !nosplit) {
> +				if (folio_test_large(folio) && !nosplit) {
>  					int ret = try_split_folio(folio, split_folios);
>  
>  					if (!ret) {

