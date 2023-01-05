Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055C865E4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjAEE0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAEE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:26:51 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD940841
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpHU+v/YmohGZArR3281grbU+nVwyAp7vwq2QDIIqwYQ+nQqpaAQ4Bb87iOf2JfasBy1PMjEcWFjc2o1qhRXgbodKfDGZgid4dVXgAACMjHf9fHxgB7FRQRpuV8xHx+yNIV0RVU8rj5uEkFgljPbN6OZdTO5QBkTuaowyTmGbfR9IzTv7BOS6cXAwgUuNfCGWPXPzeGEV1PAb8rOI51irCqSGKOzBlWoroD8xD8rr2Uuh36jVahZeLXtjochsjFa7KTsYY19C1nA9eFg8Yo2mkwEIx8jrlSfFFlCUYDrI+AfgV8jnvaAoPoYW43N8ib1AwvIqdn9/z0kh35QDJ6bLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcXmPr+oSk4WmW3GibcxiiU4pmRgBtpIMtLxP2ybBtw=;
 b=d1EVc7tvNg16MUDW1HF4deBRX2QxDaafePsmhpP7JYs49AKx0TCCPKOMKBgzLkjhO1CcO+YmmHbb3aUSCzBLZvCzi2bmywXI+AnQ1b+K66/sRB6TdyHEkXon/aJhhGszlsZ+/WZybeLLMwnHXP5bh6adw0bubIzVlce97Rklr0l/N5kiL/CwRXIKdBLoLe728c7bJkRR+9NJLvHEURYUi5EKhwJGTQceQ4+CK+qlubXDpRVUH7Szi+eKLBTS3cO2PNW4i6z9fFKaUG7Iqop15h6LtKOBEM+acK541X4LpjKnnH/7iwXGbSCssX6XKIv2fIN/eIcQDUyiv5f0XqBz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcXmPr+oSk4WmW3GibcxiiU4pmRgBtpIMtLxP2ybBtw=;
 b=PazXr0LSIvawTd26M4SdyJ750KnRq/puU16dv0lVQkVUgMw89ojEkxq8anbzm94KyckW5BqyHBR/b0vC0pnPmzNwsLGKyLGsbxYwGPKlLgjqEOnwGdbwBm/eSpqQ1dOfpSJbtfdZHCD5YmbBqlfCnyFS8XPum8DCL71YleRqU342/MLIWI0uXCwUghpPRu4Ti6YD4b6UOtEmIp+608KGQAideKvEivEf574W0vYNiRNqGAqj5H6bpAa9/ilCJJmnsJSHU5VtTWrMQBo3/gvUoiYjUxzvJ9LiFGe4IAryPcOSE2O/i4uyCz/gQpsIwGZQ1hd3I0bP1QoeELVZ5h+etQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 04:26:47 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 04:26:47 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-3-ying.huang@intel.com>
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
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
Date:   Thu, 05 Jan 2023 15:13:25 +1100
In-reply-to: <20221227002859.27740-3-ying.huang@intel.com>
Message-ID: <87pmbttxmj.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: f2678296-8931-42f4-b6f4-08daeed50ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2Xu+7MisE/sxOJVrzMkS6fQ3e0D92bcmETLkyNvKiWhIyvLxGTxEByXeVyopWMaJz7sOhCs71qCPeDUEmsSH7ZZmw0907DLc35WdwSRthWA7eZysqpGBD5fl27wqXXs1YSXB6FlO9NPeh4YTNvij3g1Cb/bh5fsB+J7UaSrEvBbe2UQXYrMmnIfyCC0UDsMctUSiE7d2CkEMy5HnkGSusguuExLyvPM1jBOcX0L5A1zyWlSbdNFzg+FLcKSC1OleOLD9HZeG/dRWQKpWdtEpbWy/y0rQzE0EKf2MMVqvFc0PdOdHhO5Xg5o01MUylnthN5AEAb8qnJi1aBS6zZ7TlPTI427w18Bhu6ft/sKMGnAlQHblkVLX7Fr3jdnZFo2WRMlR+Z4mXUvM8x7vSv4+lAXmuy1ciyIcHqZfQcm348Y3U+8Q2Fi3GdltVDBN0y1qPDVDhJ1L7lRoXyPT0xoQUUeeTN3nunk5SXlma29KQadL13oDs/ZCiD3u83X/4sWjVnRjuaemi35WWn6QIjTnChK+IQGeHC0Fnb+Tg7j8guNd1cA+0piLrYjvUBqujcT312dqu5wkHbH95yYH1bL+6/q6iIzhcnCpwrxctCrUAG3DvxrbzZfpv5CDB99A+7tw0XQsIj8VcmJRVSlYYF2Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(6486002)(6666004)(6506007)(478600001)(36756003)(38100700002)(6512007)(186003)(26005)(83380400001)(86362001)(2616005)(5660300002)(7416002)(4326008)(66476007)(8676002)(8936002)(316002)(66946007)(66556008)(41300700001)(2906002)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K53deAgpPMJM639Jt2bKFh0zz+LomeGg3Fb+uv1srMaw2ycFYVTmjq+pmaM1?=
 =?us-ascii?Q?NHUcKf5FG/W4W52Kby3avwUwCyimyer0GbUQB/on/J7z0CaS7gjyfJZg9rYn?=
 =?us-ascii?Q?45VFc3JR2lVab3OikVa8WiaqK5tz0+kLByFzF6V7cwV8+oxnRG9yu2Mys0LM?=
 =?us-ascii?Q?8GDc6pafzQVdUQyL9xRyrOS8lJCGWr84VUYodZZP7bpZIt1enhfyKAFT15gN?=
 =?us-ascii?Q?LZ5qC6vvsopX9LFwEa7qlwx0mFx3CEALlv4EH9hRKRPMY7D89rIhMk2BjDY+?=
 =?us-ascii?Q?/Edte/ZqOnDaMKt3brmndysIOrlPl+wyvYZux9Nm7Rftb+/VQ/ucGGnt0s3N?=
 =?us-ascii?Q?F38ahlp7o1q55d1JSj2Iv0UCmWGDGWzEYdPIfHdgJydVHhgaULk82hEdpAj0?=
 =?us-ascii?Q?GkqC6LdbCjFIEXH7hrFDCKGiMCyFfHCcUSE1mn1zay9d8Bm60JCEqiPgpbDS?=
 =?us-ascii?Q?adhGW+b12Gjp7Um+e2Id9BHsscjLOU3OYlhJbyBRptstNPpKe6TuzBBoGXt4?=
 =?us-ascii?Q?OU3qG/zXq8fZXHd4uED3wLs4aA8urhmBYBVzAOVoVlY6i0j7I6nGoLtRNiH2?=
 =?us-ascii?Q?lXGAZKaXKJTvQtS1Lny7ufit0C0o6cJpVzHUz2TN2FzZOFVALYryu16QL2no?=
 =?us-ascii?Q?48f0pK717+zaeh6DQkI2vDVeoobckOxNItJwaKtvMFfcDS8NklsJIj8Sfx4g?=
 =?us-ascii?Q?TXAQ3DRTXvsnisl2W0pTrt/ZEW7+SAEYG6IVP+6O1LZsvcsKAaSgu0O54t3X?=
 =?us-ascii?Q?E9uPaZOH9Y/z9JJUE28h/DT13t5ZXZO0Sukn9osobyvBd+bwrcsR2CjCXeWV?=
 =?us-ascii?Q?uLkjE5Ht0ufFbzDWXePVUMnuhQMEeHXFFTAMqDbipGIFmfPO9bxFfwdfIDN8?=
 =?us-ascii?Q?RJ/RuM6Q7w7Ut8iLGoqwwTBD5P06GRsFiQiTs0Gz2s0+EVdA56/OT6hwDJ0f?=
 =?us-ascii?Q?XnAKLY6VjCH2hG8C123qOvl/Fk1TOgNLrkglpQot1F2SAPrqnVptam+ot9Jy?=
 =?us-ascii?Q?66rI377yaWj92ATXAZoe/I3wzXHZXICPylsE5WOHixLDLWp1VH9rXMKMDpgs?=
 =?us-ascii?Q?WOObXzEYUQex/h5x857UtU0rSfCrq6455+dkTR/8QrRPxsD2y/vpJ6+yTaXf?=
 =?us-ascii?Q?sxhasQpFFIQ9NNu9E2arDmNJnREZ9Dj9XoVin4PyK5YEoOHNropmcWYIKYBP?=
 =?us-ascii?Q?iYF2kDBkoXLhRH2AzrB/XzB4mMAa1sQWyOF9lUPTOU25Pw1VdrsPHPe1Mrux?=
 =?us-ascii?Q?DTK/xeTDxebAPaAbuicgcHc46T1Ojt3kPEMMXcTeumwmzmKpUf6xfTi4Bwmm?=
 =?us-ascii?Q?om5zUogA3o/c547LHW/xR+DxXE/ocT06Sl1Peb9HLIpvVyp3+MdvK5szl+5e?=
 =?us-ascii?Q?lnOznhZerzITvGRroix7sSxP5Wlb/blp+Ub2FAREv3VNkj5Yyz0ZaKNM9R+R?=
 =?us-ascii?Q?0F8/qFLTlIi+2h4KRb2wnF/StJZQy1bQg2hnb7BzXLBCCyKVVqUaohS/uCd5?=
 =?us-ascii?Q?RpPmJ7H0gN+8TnOcvu4Xe0o7F+hV/QEKRDjBAmkZHlUW3P4sqmZpJbm5mQtf?=
 =?us-ascii?Q?kqb/ytiB8Zt9DqucEdE0bbZmhD2GitrGDDHPmlYt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2678296-8931-42f4-b6f4-08daeed50ed8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 04:26:47.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDWQZ3239A5NjP2F083z96J2cD7Q2zea4OFG7BpYHjQfiZQni6hd44uplJ7BedpMC0CaXBRGwgTI/obVyD1zxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

> This is a preparation patch to batch the folio unmapping and moving
> for the non-hugetlb folios.  Based on that we can batch the TLB
> shootdown during the folio migration and make it possible to use some
> hardware accelerator for the folio copying.
>
> In this patch the hugetlb folios and non-hugetlb folios migration is
> separated in migrate_pages() to make it easy to change the non-hugetlb
> folios migration implementation.
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
>  mm/migrate.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 99 insertions(+), 15 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ec9263a33d38..bdbe73fe2eb7 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1404,6 +1404,87 @@ struct migrate_pages_stats {
>  	int nr_thp_split;
>  };
>  
> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
> +			    free_page_t put_new_page, unsigned long private,
> +			    enum migrate_mode mode, int reason,
> +			    struct migrate_pages_stats *stats,
> +			    struct list_head *ret_folios)
> +{
> +	int retry = 1;
> +	int nr_failed = 0;
> +	int nr_retry_pages = 0;
> +	int pass = 0;
> +	struct folio *folio, *folio2;
> +	int rc = 0, nr_pages;
> +
> +	for (pass = 0; pass < 10 && retry; pass++) {
> +		retry = 0;
> +		nr_retry_pages = 0;
> +
> +		list_for_each_entry_safe(folio, folio2, from, lru) {
> +			if (!folio_test_hugetlb(folio))
> +				continue;
> +
> +			nr_pages = folio_nr_pages(folio);
> +
> +			cond_resched();
> +
> +			rc = unmap_and_move_huge_page(get_new_page,
> +						      put_new_page, private,
> +						      &folio->page, pass > 2, mode,
> +						      reason, ret_folios);
> +			/*
> +			 * The rules are:
> +			 *	Success: hugetlb folio will be put back
> +			 *	-EAGAIN: stay on the from list
> +			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
> +			 *	Other errno: put on ret_folios list
> +			 */
> +			switch(rc) {
> +			case -ENOSYS:
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				list_move_tail(&folio->lru, ret_folios);
> +				break;
> +			case -ENOMEM:
> +				/*
> +				 * When memory is low, don't bother to try to migrate
> +				 * other folios, just exit.
> +				 */
> +				nr_failed++;

This currently isn't relevant for -ENOMEM and I think it would be
clearer if it was dropped.

> +				stats->nr_failed_pages += nr_pages;

Makes sense not to continue migration with low memory, but shouldn't we
add the remaining unmigrated hugetlb folios to stats->nr_failed_pages as
well? Ie. don't we still have to continue the iteration to to find and
account for these?

> +				goto out;

Given this is the only use of the out label, and that there is a special
case for -ENOMEM there anyway I think it would be clearer to return
directly.

> +			case -EAGAIN:
> +				retry++;
> +				nr_retry_pages += nr_pages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				stats->nr_succeeded += nr_pages;
> +				break;
> +			default:
> +				/*
> +				 * Permanent failure (-EBUSY, etc.):
> +				 * unlike -EAGAIN case, the failed folio is
> +				 * removed from migration folio list and not
> +				 * retried in the next outer loop.
> +				 */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				break;
> +			}
> +		}
> +	}
> +out:
> +	nr_failed += retry;
> +	stats->nr_failed_pages += nr_retry_pages;
> +	if (rc != -ENOMEM)
> +		rc = nr_failed;
> +
> +	return rc;
> +}
> +
>  /*
>   * migrate_pages - migrate the folios specified in a list, to the free folios
>   *		   supplied as the target for the page migration
> @@ -1437,7 +1518,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int retry = 1;
>  	int large_retry = 1;
>  	int thp_retry = 1;
> -	int nr_failed = 0;
> +	int nr_failed;
>  	int nr_retry_pages = 0;
>  	int nr_large_failed = 0;
>  	int pass = 0;
> @@ -1454,6 +1535,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	trace_mm_migrate_pages_start(mode, reason);
>  
>  	memset(&stats, 0, sizeof(stats));
> +	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
> +			      &stats, &ret_folios);
> +	if (rc < 0)
> +		goto out;
> +	nr_failed = rc;
> +
>  split_folio_migration:
>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>  		retry = 0;
> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		nr_retry_pages = 0;
>  
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
> +			if (folio_test_hugetlb(folio)) {

How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
any hugetlb folios off the from list?

> +				list_move_tail(&folio->lru, &ret_folios);
> +				continue;
> +			}
> +
>  			/*
>  			 * Large folio statistics is based on the source large
>  			 * folio. Capture required information that might get
>  			 * lost during migration.
>  			 */
> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
> +			is_large = folio_test_large(folio);
>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
> +
>  			cond_resched();
>  
> -			if (folio_test_hugetlb(folio))
> -				rc = unmap_and_move_huge_page(get_new_page,
> -						put_new_page, private,
> -						&folio->page, pass > 2, mode,
> -						reason,
> -						&ret_folios);
> -			else
> -				rc = unmap_and_move(get_new_page, put_new_page,
> -						private, folio, pass > 2, mode,
> -						reason, &ret_folios);
> +			rc = unmap_and_move(get_new_page, put_new_page,
> +					    private, folio, pass > 2, mode,
> +					    reason, &ret_folios);
>  			/*
>  			 * The rules are:
> -			 *	Success: non hugetlb folio will be freed, hugetlb
> -			 *		 folio will be put back
> +			 *	Success: folio will be freed
>  			 *	-EAGAIN: stay on the from list
>  			 *	-ENOMEM: stay on the from list
>  			 *	-ENOSYS: stay on the from list
> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  						stats.nr_thp_split += is_thp;
>  						break;
>  					}
> -				/* Hugetlb migration is unsupported */
>  				} else if (!no_split_folio_counting) {
>  					nr_failed++;
>  				}

