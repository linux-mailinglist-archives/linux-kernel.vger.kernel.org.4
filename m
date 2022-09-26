Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B885E9E06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiIZJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiIZJjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:39:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A74621C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtMlDU828JYw9xYOu1+rq+5x78z1vg3NH5dg/CdqQ0UIRYNy7S2w/30b5WVya4uQGdBdRQ1xkJNc8fTOgAUkDt3Eech/eVPT2r2hBdoWTvlf6TFw5KVe3y/TL5I13xpUV/xGcM4fWUM+Pc1uJwvwQszyr20owi2BhBfEOOKH3BuOQgbXmBkjT+XloxnYq/aXSK/uQVqEU42OfJkHKT5kr0TPhgdL8g0yKsJJVdTjARJ1R4JKXceiESELT/gnRcx2tQ5fX22D405tVjOszaKAlYD0M4HPPRtjEi53Ajp1X5gS5C/mRE7rumauM2BhQ7gxBpx2l9XmmgK8UmmhvWqwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxRu8HXomsfkBh6v6Un0B6vIJ4C1PRBRXCyFbCcG+4E=;
 b=bUrptsKBnuON/FkdC6rv+Zaf6f6ngRgnuRlXfhvl54zvx7jatyJZncEX1uNDr6v+OphQa7diVSE14zhKyMXSyY7QxxAHOiQglvIIOQ2kdBmSHukkcG/lZMgprZ8HRvYMchSNmr0k/abUvZCYRWUiAxE7HRKOFetAD+XFZOd9yjEDE34U68x5llJ05CL/j+M/Pkwc+I/ukXfZHRW5pZH3NoAc+XmtgwXHlCRMQCPdNqzkOQs1se5/rvn4lAEa7D9hyv/iXgb6eR8Rab5EIjOXx2RzUEiDK6dZycYYPS+5ZP7Qa1G05pyvMQoc627WQfwCI+MyJSbAqtZ/ngfSyhp8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxRu8HXomsfkBh6v6Un0B6vIJ4C1PRBRXCyFbCcG+4E=;
 b=VfBGgiDht/H+/lHwun63vJ3lO0h/NylqEB7ESvDrTTC/eTFk1RZZY3BF+Y0w6lFmQxMXqM0O9DzaQeHP94OmIGFAi4LSypBP3zcPVhhK5k+OC6178/yZkAdgC2zMGyWCVIOXS/54ay1t180xBgfN3jFV16H58Az696Y/NDe2xSCHbxMLgMrq/h9kO4CkF5Xj8jxCEv0J+p9581X0TL/PYvymVRk0hgQfXQxY/vbp9QvpY5vg2sP4X1S8czkhGTAcbGjCclnYTAVFR7BR0hXyeedICmVNy+Xm2CHdtXgOtv/obygoN5L5MIh2t6J35A4w/zcbcAtePeEFH3+Yf3qKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:37:25 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ed0:a520:ac8e:9966%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:37:25 +0000
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Date:   Mon, 26 Sep 2022 19:28:42 +1000
In-reply-to: <20220921060616.73086-3-ying.huang@intel.com>
Message-ID: <87o7v2lbn4.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 4163b3fc-865d-493e-6ca5-08da9fa2b86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vujlFb0gTCUTpp+1HTGAByY+47UR61v90bsepemeCY6NBsp5uTZhgZEPClKfBJc5bw5dQN/OSI6j00zSIMKlBB2G/raHvCO2hfvj2jBmJYFqwNKk9JHSDo3M3is76JWrVK2TESDuOypo7ARFg4+GpA02gCEZDFRInhT5CRBEY9nGyt2a2xF161jevWjWA/oihinVBAzKg0768YJT/wRBv/5sjAJkzj7mTaB+YScoyqlaK7AGJr/bhLRJc58+6/0WzqkL6vLOKcb0Djm9rS+4IPRoiWAC/lilw4s5TdWpgFstai6Z8JHoOmbkHVILv6Lo45s9uVJnBhwSEXFvh00iT+GoqTazYXHb6QBgbggjTmFhx+Iu2xoiMynqmg5q1LwQf+e+QmtlzWp7HbqX4529NbpEFN3sZXtYHBgnN9aNjp4MVl3BR+VqcZIQXg9E39NaUpAD0XwGtFpz23HpScqFIRY+9gYbiuDkWM3K45JRpkEuEYVt4HCxXwqP4/OdFcOqtmuzHktT8BQAbQi/Yzd9m/dLmUb5j5bQ5q33WodG6WJpIfzxkSaZNBj+Gm7939COO1FLB4/B3lLEh13KuipqNEphjj3x05/2zMs+faak1W7cU/9pB1tGwaG9B2DUjF0f7yCqbC/UK4muppvQ136mndgRxaZd5ZoC7izx1EuLh4V78NZ0GZ80UXSEMsiO3zsx+nm5zhkI6VJsbgMM1FnQy8q8MtahsseTTOGpMW2gUEMqs4z7ZOcaQ9ws1a7J/M+D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(6666004)(83380400001)(41300700001)(26005)(9686003)(6512007)(186003)(8936002)(2906002)(86362001)(5660300002)(38100700002)(54906003)(66476007)(66556008)(316002)(8676002)(6916009)(6506007)(6486002)(478600001)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0wBlZKHQB5fSNymkObW1IkV60yeGBhw5AMK+jBSAM15R884ANhYGkg8VbCM?=
 =?us-ascii?Q?Q602da/RRcSRJacAQ45pWkzyOSxEDdD1FGC1AozxbqTex2udU6FH4YBnqwer?=
 =?us-ascii?Q?vLKKvnOkHfUbpiGE1t5pKZxeHUqyd7rWpJpzYKGcM6cAShwdvsR1LBmofCzC?=
 =?us-ascii?Q?nDf/kf9IMYuCHdwjiilKZsSl4dgE2/YHMI41AlXd27mL4xKJ0KYpQTHwdSY5?=
 =?us-ascii?Q?J4Aejn3mJBfcCIoSw60GeUsMW8G73hzZJ6q+zmUtsHHXb0p36knhW/EB1Mz2?=
 =?us-ascii?Q?aKifn5PpsFoMsG+atHTEkBoq/B+y3C88CuLIsBv/rAEJ8tbcKHhWW3RosNTd?=
 =?us-ascii?Q?oEXZ5QQJMe4gTmLWLkSwru0cN1nD2naCIktiZ3ynGHqKs4TFNLNsmyBZ/K2E?=
 =?us-ascii?Q?vzJsT5713/HG+4p17zF3IhIKMP1yNmMDcI5fswho28+AEK2U6AAnA0w0LQre?=
 =?us-ascii?Q?RPQIB3Em50QfhnHaYxgu6q1/m/FPNew8KhENYQFM/NXW9PXC/ksrou5W5RrW?=
 =?us-ascii?Q?xpnKk54VIycGqgDknV8TM/DvIfVbnc2NqNA1eweRWSwOs1oZJhvCnmTfR2c7?=
 =?us-ascii?Q?DBEf6LbN8gx693FGO138e4lFCLXw4/PBLrB9Suc1ju+GkwZEl9JRcvUrQC+5?=
 =?us-ascii?Q?gEHatzcH6GwjMYPSUX2PiXEec6/1J3Zj4kDF4ymPuMZGGl7uHEZCiDOxzwh2?=
 =?us-ascii?Q?6P0IAi5tnfGddAANG7KslMHU7l0VwEu/SMC73Zh6Xffe4KnsomokISH7836k?=
 =?us-ascii?Q?DLuaxzh60VZ0aBOR5h4JC29h4CumWM7J4z5zEQTGwyV6e9vkNniTYoSsLcO7?=
 =?us-ascii?Q?rRazgNVkXI9Kgd3eHWZrXxu69mhBGHQqX6s8uRc1oViGLbKXnnt05zSLO210?=
 =?us-ascii?Q?2f7+V6Sif1AHaaAQOA5nHaiCk8txR5g9jbYMHvERGQzsRulcLz4m0RVSTctY?=
 =?us-ascii?Q?ct9eWh4VV0Vrvo8VOcRJpLXNakarJh3QtG8CYUpT4HQl0FplWTR6C31LUYfj?=
 =?us-ascii?Q?7MRvll2vmhAwM+BFSAWryDUq/X1kS80aWMA00ap4/LEu2EaVRDkvPqvwp0Ln?=
 =?us-ascii?Q?EealQeVGCnyODSCDcZ2BcUMj3KfpPCd7utmlsWHuEXA3y+SAKnfMyLW83MD6?=
 =?us-ascii?Q?WTI8JDXHl4vxXlsKRnrJ6jBN+tK8DjrHcAG38Md5KsCGVn/mVauZ/KjUvmbg?=
 =?us-ascii?Q?OdbNN8l+sLhPzXxmB23wR8/pN33pwR5Rr82rQNug6U0yCqBs+XeHEVR6I6g3?=
 =?us-ascii?Q?9PW7OmQZDylqcx+laGVo3puwI8lUVk5eAakgQbFco5m+BSjv5U/86P1anHkq?=
 =?us-ascii?Q?H3MfDY5qjAXVYLBu8mCqyFgq4M2TG2bbgIU7bq844o9eIoWN+prW4v0S7QWt?=
 =?us-ascii?Q?ywvw5XOtPlT9iOkV9gMvIgWsh3B91Cttre5TMX4BBG1d4LfPMAcgVspDZe/e?=
 =?us-ascii?Q?Lxo0RYNrq1JE7JBqS14N8I6+6g5fuvl+Mhc6kwPKzTfx2e2cdRbD4QQzxNIL?=
 =?us-ascii?Q?xsAwXnkqJtPuZNm1b0xmuvoNYxyVg5EFyBb8PgmTVu1VF+Ux5V4//yibF26c?=
 =?us-ascii?Q?DEAomzFlJZ51S1m35nQ7quGAD8SmUMRe7S0Sx4LI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4163b3fc-865d-493e-6ca5-08da9fa2b86d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:37:25.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUGOUnVCasPhWwRqbFgphJylgko1QPeRhHwTMzRAFTIIZ+oNFL53BrqFwQNToB8Z+S/WUO8U9UMD7uFYosxaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Huang Ying <ying.huang@intel.com> writes:

> This is a preparation patch to batch the page unmapping and moving
> for the normal pages and THP.
>
> In this patch, unmap_and_move() is split to migrate_page_unmap() and
> migrate_page_move().  So, we can batch _unmap() and _move() in
> different loops later.  To pass some information between unmap and
> move, the original unused newpage->mapping and newpage->private are
> used.

This looks like it could cause a deadlock between two threads migrating
the same pages if force == true && mode != MIGRATE_ASYNC as
migrate_page_unmap() will call lock_page() while holding the lock on
other pages in the list. Therefore the two threads could deadlock if the
pages are in a different order.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 164 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 42 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 117134f1c6dc..4a81e0bfdbcd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -976,13 +976,32 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  	return rc;
>  }
>
> -static int __unmap_and_move(struct page *page, struct page *newpage,
> +static void __migrate_page_record(struct page *newpage,
> +				  int page_was_mapped,
> +				  struct anon_vma *anon_vma)
> +{
> +	newpage->mapping = (struct address_space *)anon_vma;
> +	newpage->private = page_was_mapped;
> +}
> +
> +static void __migrate_page_extract(struct page *newpage,
> +				   int *page_was_mappedp,
> +				   struct anon_vma **anon_vmap)
> +{
> +	*anon_vmap = (struct anon_vma *)newpage->mapping;
> +	*page_was_mappedp = newpage->private;
> +	newpage->mapping = NULL;
> +	newpage->private = 0;
> +}
> +
> +#define MIGRATEPAGE_UNMAP		1
> +
> +static int __migrate_page_unmap(struct page *page, struct page *newpage,
>  				int force, enum migrate_mode mode)
>  {
>  	struct folio *folio = page_folio(page);
> -	struct folio *dst = page_folio(newpage);
>  	int rc = -EAGAIN;
> -	bool page_was_mapped = false;
> +	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
>  	bool is_lru = !__PageMovable(page);
>
> @@ -1058,8 +1077,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		goto out_unlock;
>
>  	if (unlikely(!is_lru)) {
> -		rc = move_to_new_folio(dst, folio, mode);
> -		goto out_unlock_both;
> +		__migrate_page_record(newpage, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
>  	}
>
>  	/*
> @@ -1085,11 +1104,41 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>  				page);
>  		try_to_migrate(folio, 0);
> -		page_was_mapped = true;
> +		page_was_mapped = 1;
> +	}
> +
> +	if (!page_mapped(page)) {
> +		__migrate_page_record(newpage, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
>  	}
>
> -	if (!page_mapped(page))
> -		rc = move_to_new_folio(dst, folio, mode);
> +	if (page_was_mapped)
> +		remove_migration_ptes(folio, folio, false);
> +
> +out_unlock_both:
> +	unlock_page(newpage);
> +out_unlock:
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	unlock_page(page);
> +out:
> +
> +	return rc;
> +}
> +
> +static int __migrate_page_move(struct page *page, struct page *newpage,
> +			       enum migrate_mode mode)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct folio *dst = page_folio(newpage);
> +	int rc;
> +	int page_was_mapped = 0;
> +	struct anon_vma *anon_vma = NULL;
> +
> +	__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
> +
> +	rc = move_to_new_folio(dst, folio, mode);
>
>  	/*
>  	 * When successful, push newpage to LRU immediately: so that if it
> @@ -1110,14 +1159,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		remove_migration_ptes(folio,
>  			rc == MIGRATEPAGE_SUCCESS ? dst : folio, false);
>
> -out_unlock_both:
>  	unlock_page(newpage);
> -out_unlock:
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
>  	unlock_page(page);
> -out:
>  	/*
>  	 * If migration is successful, decrease refcount of the newpage,
>  	 * which will not free the page because new page owner increased
> @@ -1129,18 +1175,31 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	return rc;
>  }
>
> -/*
> - * Obtain the lock on page, remove all ptes and migrate the page
> - * to the newly allocated page in newpage.
> - */
> -static int unmap_and_move(new_page_t get_new_page,
> -				   free_page_t put_new_page,
> -				   unsigned long private, struct page *page,
> -				   int force, enum migrate_mode mode,
> -				   enum migrate_reason reason,
> -				   struct list_head *ret)
> +static void migrate_page_done(struct page *page,
> +			      enum migrate_reason reason)
> +{
> +	/*
> +	 * Compaction can migrate also non-LRU pages which are
> +	 * not accounted to NR_ISOLATED_*. They can be recognized
> +	 * as __PageMovable
> +	 */
> +	if (likely(!__PageMovable(page)))
> +		mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> +				    page_is_file_lru(page), -thp_nr_pages(page));
> +
> +	if (reason != MR_MEMORY_FAILURE)
> +		/* We release the page in page_handle_poison. */
> +		put_page(page);
> +}
> +
> +/* Obtain the lock on page, remove all ptes. */
> +static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
> +			      unsigned long private, struct page *page,
> +			      struct page **newpagep, int force,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
>  {
> -	int rc = MIGRATEPAGE_SUCCESS;
> +	int rc = MIGRATEPAGE_UNMAP;
>  	struct page *newpage = NULL;
>
>  	if (!thp_migration_supported() && PageTransHuge(page))
> @@ -1151,19 +1210,48 @@ static int unmap_and_move(new_page_t get_new_page,
>  		ClearPageActive(page);
>  		ClearPageUnevictable(page);
>  		/* free_pages_prepare() will clear PG_isolated. */
> -		goto out;
> +		list_del(&page->lru);
> +		migrate_page_done(page, reason);
> +		return MIGRATEPAGE_SUCCESS;
>  	}
>
>  	newpage = get_new_page(page, private);
>  	if (!newpage)
>  		return -ENOMEM;
> +	*newpagep = newpage;
>
> -	newpage->private = 0;
> -	rc = __unmap_and_move(page, newpage, force, mode);
> +	rc = __migrate_page_unmap(page, newpage, force, mode);
> +	if (rc == MIGRATEPAGE_UNMAP)
> +		return rc;
> +
> +	/*
> +	 * A page that has not been migrated will have kept its
> +	 * references and be restored.
> +	 */
> +	/* restore the page to right list. */
> +	if (rc != -EAGAIN)
> +		list_move_tail(&page->lru, ret);
> +
> +	if (put_new_page)
> +		put_new_page(newpage, private);
> +	else
> +		put_page(newpage);
> +
> +	return rc;
> +}
> +
> +/* Migrate the page to the newly allocated page in newpage. */
> +static int migrate_page_move(free_page_t put_new_page, unsigned long private,
> +			     struct page *page, struct page *newpage,
> +			     enum migrate_mode mode, enum migrate_reason reason,
> +			     struct list_head *ret)
> +{
> +	int rc;
> +
> +	rc = __migrate_page_move(page, newpage, mode);
>  	if (rc == MIGRATEPAGE_SUCCESS)
>  		set_page_owner_migrate_reason(newpage, reason);
>
> -out:
>  	if (rc != -EAGAIN) {
>  		/*
>  		 * A page that has been migrated has all references
> @@ -1179,20 +1267,7 @@ static int unmap_and_move(new_page_t get_new_page,
>  	 * we want to retry.
>  	 */
>  	if (rc == MIGRATEPAGE_SUCCESS) {
> -		/*
> -		 * Compaction can migrate also non-LRU pages which are
> -		 * not accounted to NR_ISOLATED_*. They can be recognized
> -		 * as __PageMovable
> -		 */
> -		if (likely(!__PageMovable(page)))
> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -					page_is_file_lru(page), -thp_nr_pages(page));
> -
> -		if (reason != MR_MEMORY_FAILURE)
> -			/*
> -			 * We release the page in page_handle_poison.
> -			 */
> -			put_page(page);
> +		migrate_page_done(page, reason);
>  	} else {
>  		if (rc != -EAGAIN)
>  			list_add_tail(&page->lru, ret);
> @@ -1405,6 +1480,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	int pass = 0;
>  	bool is_thp = false;
>  	struct page *page;
> +	struct page *newpage = NULL;
>  	struct page *page2;
>  	int rc, nr_subpages;
>  	LIST_HEAD(ret_pages);
> @@ -1493,9 +1569,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			if (PageHuge(page))
>  				continue;
>
> -			rc = unmap_and_move(get_new_page, put_new_page,
> -						private, page, pass > 2, mode,
> +			rc = migrate_page_unmap(get_new_page, put_new_page, private,
> +						page, &newpage, pass > 2, mode,
>  						reason, &ret_pages);
> +			if (rc == MIGRATEPAGE_UNMAP)
> +				rc = migrate_page_move(put_new_page, private,
> +						       page, newpage, mode,
> +						       reason, &ret_pages);
>  			/*
>  			 * The rules are:
>  			 *	Success: page will be freed
