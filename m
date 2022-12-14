Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3F64C539
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiLNIn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiLNIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:43:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A66B1E1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfY2lAXT0x0wqsjhlJ+KqUBJtu5uP9T6FJwKUvOBPNJEyi/u48HQrYd/p/DcfM2ym14ZacaIx5ED5LzeGwYGwXSvMUCrIYjSfEi+mb34GwmAH+O2b6D5O1dGyQYOfe7SaeP7Q7qEGYitKcAurohhoYJIiHUoZ/xKMB8hXsZsAIcKz6lGOi65ATtdkXanOtc/21Lwaj+mAfKA7KtB0VIkTjiI/iWdyBonilIN7Q5DqErkLJQt+8S2yqwZEElm9SHUjIZ8Z0aWEQnoCXcwL0RCqCFVboC9w0igXDhJs7Kg7RsYpw07+6A07yyJMvFlaQxsEKw43Xvt3meZ1wPhaz/LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVeZsiTgL7POcug0rTB1K0gQlPR59CykVkueFr8Mu9U=;
 b=NKJBwR+RBseIAZbkPUY9JErixMeO8ArTuJKMeA7Dbg+1I+mV85s+sKK5nLdtLrcLqkutA4nT5L1jdVZW9gDwud9wBtTTaZ87ETFqgbuqRukJUzbKcn0//aUiUOpMx6RDZTEqDJL2hdjm5DFtLGpnsa87s4KzAFbvXrLdJJxFbE9xqY+s8psKjJTzfGvYQhKPt/GV77B4cDyiKuh+MJNEK4zfrBq+94ygtSu2hRndzLK8IYZZP5M2myobfMnydAiLfChz1rqtEWNFHM3oC+gOjMjjUBZE8hefgelZ4Fcv0NcFoido4CJPo4m0L//VTUNhHyua9+ZHSiKCtp6nnBveiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVeZsiTgL7POcug0rTB1K0gQlPR59CykVkueFr8Mu9U=;
 b=r51Lgpw9lJbhOsNMsAg6+vYAV4Cy3alwCddg9ttZ5+iy2SkrlTtAOlll+SqGzARv5df/3voLqTxryVxkYje3x0T19XrCrGuZ3ngje5VkhXyevbyKAAJARrqsGlRfPCdYkYZkkVk+/3E9UjS77zdg6Rs3gXml/RDQxKIqunT2epKnIWjBpD0Yq8oJ8Nh+XNph/i66tmfnee+UunUs404tAZnPzR0Y+waJ1wGQizDzUsX5mak/r56gx7PiXstEr+xKYkQR6uo3e+vP3lTI47AQ9G25cg8yd0OUo1C1hZPxxYIj4QOV/ylYEvlIl2Nkf2Ck96chy5+eN0Pt6jXHpZJxhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:43:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::7895:c4d1:27d2:5b0a%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 08:43:25 +0000
Message-ID: <f149df8f-b3ae-b9ce-eb4c-4f684cba0fe8@nvidia.com>
Date:   Wed, 14 Dec 2022 00:43:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: move folio_set_compound_order() to
 mm/internal.h
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org
References: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b43771-cdee-4c48-a6a1-08daddaf42f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6h8ETwLaTB9oOs4AVe3L8XDH4ig78pzCjYdjIMx6swy3lpXj97U56cqGaN/sW4CrE1LmVlcG2qzOCy1ArxLcIAgxoIpR4tjBl9YxFrRfWRQj7Zg0oeeuazo7vjGmtIubYrEapc+IGC2UtE7F6CMNRWB6sftmqAVFjaAZKsN0Ns5Frc+5U45lU1MeZ/IIDCuryN6aq7hrhSUR3tEEN25yPe1WxPBlg2KCqRm14eVjdtEKTk8Xq6KpdOhDi0ujbfuY4gDOSHDinAKWmKDwEwgvh6/yC/t/6v462aHjWokgDd5ZzOEIg/rn99i9lAgliwxfcTYRrTthcCMfjGXDb66+GMhCV5y8UbddIKqgs5mJzhrbemCUK1DBZj9g+y/DkCDtrmpYaHVREmdwNcIn++QSoAaqynlTM2Et5tLQ3Z7nhUsaUYKSpGCs7jYIcjw+DEpWZppROhSZpLqvK/mrIgNL6FCPWXvdyy92ZCsAKXbXAfoCd/KU5yNJzyhbJK1EmP+MpfhW1gLPHHzUGcfyATEwStkfcGmBmbLOeJ7T80xvPcsQCR4X+sDOA0Ak+IoHZRLbTeJAdh2hVmB/LXPMfU+gW5gInD1uOa7GCGn6J/5Pnmju9++UxIUZseepE3tL84wHaJ1tVC0fc0FsEbg4utF71DiMvAFYvjGXRw3WtpIbPAusPRVBtestQhStnZym6DEKxvyziqXxySe3+HPUZ/GImsMnqL/1P4jWdryXHZiOY23AKKoDZqWUwsPnom8JBItclFelWNYmLBymFBNDGR81GLJd+c3lNUfcyWJWFuUz6rVgkUSwJurYlqWt3HRFyfgW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(966005)(478600001)(6486002)(31686004)(66476007)(66556008)(6666004)(316002)(26005)(6512007)(8936002)(8676002)(4326008)(41300700001)(53546011)(36756003)(6506007)(5660300002)(86362001)(38100700002)(31696002)(2906002)(2616005)(186003)(83380400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFVWTFyMG95TjU1dTZubXo1eGVVWDA3VnJUU0QxRXkxV1V3TnJXSklrREpz?=
 =?utf-8?B?UWwwMmlzbFFOVjI3aXFFZGNEZ051dnFNcXdOTXN0MHdBKzRpKytrS1NNbUpG?=
 =?utf-8?B?K1lFc0JSdlpPdVltbUxRK3lxajlTKys2WUJ3VVppNjdOd1JDSjdpdHRQQW9u?=
 =?utf-8?B?WE8yT25xUXFtSEVsNU5nb3ZCT0pFTXN3UXAvVmVtb1orbUNGUzd5UmdncjlF?=
 =?utf-8?B?WURFK1pMaCtyc2NUVTJVZE5KR1hRdStGM1FBbVlqamw5RURyUWRTVVNwcG9p?=
 =?utf-8?B?WVU3MDVhaVg3SjhxUGJ0Y0VrVFhOTHovdHlPZlE3UkZNRXpQV0NFWU15WEJr?=
 =?utf-8?B?NVp2Sk1uL3FlM2REOU9YSEFpZjBRbXVWYndteGRpSU1KWUlGc0c4SGVWTXla?=
 =?utf-8?B?WW5mVEZNM3B1V2VkYmVxN0VCVTA2d0hQWFByNTQwN0czU0l1RGtOK1l1NW8w?=
 =?utf-8?B?TUxFTDNSQ0VDVWJHbVRkSVozcFZ1RkMyT0crSkMrTnJKeHQydWZXcXhjYldQ?=
 =?utf-8?B?WEc0bXF3V0xkM0c5SldrZXdlZG92dlJQOXFDM1E0N21wczZoRXNUTllvWVVQ?=
 =?utf-8?B?NVRsa09KRlB3SnNiMVkvYm1oZkpwZFVJN2FTTnVuL2pCMkwvUFFpZE4yZzdJ?=
 =?utf-8?B?QzR5WFBCdHJ4dXczcE5RRUtCZlN3YzNmM2JvWmFsZnRaQzIwRndmK0kvRTV5?=
 =?utf-8?B?NmpiNE5YaDNBK05sOC8wYituREp2aVZGalNESkplUmJ1NXErczRHNnFLay9Z?=
 =?utf-8?B?TmFVN0RhUkoxczBKNUVtMGtnckM4Z3NIME9WQWhnaXJBdjVubm5YYUJuclpZ?=
 =?utf-8?B?TDJtR0dpc0FtZUMycGh6WkN1Z1RiWGFlb215OGo1Q3JXcWpCckhHMlNKS0Q2?=
 =?utf-8?B?UlNrbERRUHE0WitIQmovZVIvTkFQWktrZ1JnTmJsUFdRQ0gvV052aS9zUkhC?=
 =?utf-8?B?UThiYzVKcG1PQS8yYVI4N0VEZzVuV0IrK2UxK1k2dUhSUElIazhNZDlybkVl?=
 =?utf-8?B?cW5aUWdBcHM5b3ordGFyaHJlNkVWd0NHREh0dmJzWGJqckpwN09KSk5kajVz?=
 =?utf-8?B?MTFFUmdHbTR3UGs3MDVVUi95aExMeGtaZjMvWk1LL3RRU25ueXpEbU05ZUNv?=
 =?utf-8?B?c0Jsb0VCc3V3ZUY2eThjbUVPUTRER3dpYnNNSUpjYmthYXFid25ZUVFSa00r?=
 =?utf-8?B?UU9rUGJYcVN4Z0tGOTkrTzMzdnlUK1pRY1RGbE02eVErUWFuVnd6YzV0ak5U?=
 =?utf-8?B?ZUtyNWlEN3pHVjFGTEszenF4M2NEL0VVVVlBczRDS2E0aCtaZU1rS05nN0FQ?=
 =?utf-8?B?MGtmTk9ReWVBbEZiTnBQSFNPbk9Tb3hpbDFuc3BHeVVWc2pVdkRXVjM0TkNv?=
 =?utf-8?B?emYwaTdUWnRqYlFmSHZ5MXBCOEFsZFdhZkhJTW5ZUnRWOHE0VVVJRU1hc2Jw?=
 =?utf-8?B?ME4zWkxBbVVKWTl6OUR1R1k1VGdLdlpBWjloa3hQaExCYnVLbDZJK2JsdHRF?=
 =?utf-8?B?Tk9kSmIwQit1SHBQOXdQWlp3VndTbkxHVXl2SWpEcVdmM2ZvZU11cmtQN1BF?=
 =?utf-8?B?c1cweFY0aCtaNGdhdmpJTEZqVHJPeEVRVXJLR3cvRnRKSHB4ZHlMcDdpNlR3?=
 =?utf-8?B?SjBXVENFN2lESTVsQXZPTFZDR0hhamZ3K29td0I0dytPcHd1cCtTSFZUblVx?=
 =?utf-8?B?Q1BEMFJlRHhkclF4dEdxRnN6QytUdXVkT3JOUTlqc3F5U2c4WjRQL0hyTkwr?=
 =?utf-8?B?MXlhcU41ZklTUDhhNXQ2d3VocGcxWTRtL2VTR29vZmJLdjZHRXE1djZKdXlj?=
 =?utf-8?B?Tmk0dnM5YTRPeTl3RGtTbEFCQUhha3RXdXYyQ2U5TjVIYkpzYXdmY3NCeHdW?=
 =?utf-8?B?UzlpOW5leEhjdE02YUlHNzV5QnFOZWpOWEUzRERtdEFQWGRkNzdRclF2UUI1?=
 =?utf-8?B?V01lYnp6TkgwcnVlZDFkdzYvTkZYVEQrV3djaC85eEU5YnYzRjlKS0hCdFBK?=
 =?utf-8?B?TGVjVlBxZFZEV2IzM3ZrVUk4cmtleGtkVmQrbEpSU1dyQk4yUWxxQVdocTFl?=
 =?utf-8?B?RnQ3MFZjTkNPMFhDKzZJME9tc0dFbTlaMWF3NEdzd2FJd1J0RTl0UTRTSmlB?=
 =?utf-8?Q?zKX+6uIlmaWxcJJ5RChPcDPxL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b43771-cdee-4c48-a6a1-08daddaf42f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:43:25.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVS6iJo7DiqonspEHL3FSmyJIuX3Y+HpTwKGGoA9l1lhPq71xaOqJTMRoUJ90Dbz3MKFu5Ua0fk/QHL8NpOuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 13:20, Sidhartha Kumar wrote:
> folio_set_compound_order() is moved to an mm-internal location so external
> folio users cannot misuse this function. Change the name of the function
> to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
> handle the case if a non-large folio is passed and add clarifying comments
> to the function.
> 
> Link: https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle.com/T/
> Fixes: 9fd330582b2f ("mm: add folio dtor and order setter functions")
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 16 ----------------
>  mm/hugetlb.c       |  6 +++---
>  mm/internal.h      | 21 +++++++++++++++++++++
>  3 files changed, 24 insertions(+), 19 deletions(-)

I think this looks good. One small question below.

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7dc376052d40..300d92d2b49d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1019,22 +1019,6 @@ static inline void set_compound_order(struct page *page, unsigned int order)
>  #endif
>  }
>  
> -/*
> - * folio_set_compound_order is generally passed a non-zero order to
> - * initialize a large folio.  However, hugetlb code abuses this by
> - * passing in zero when 'dissolving' a large folio.
> - */
> -static inline void folio_set_compound_order(struct folio *folio,
> -		unsigned int order)
> -{
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> -
> -	folio->_folio_order = order;
> -#ifdef CONFIG_64BIT
> -	folio->_folio_nr_pages = order ? 1U << order : 0;
> -#endif
> -}
> -
>  /* Returns the number of pages in this potentially compound page. */
>  static inline unsigned long compound_nr(struct page *page)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7cdbcc22587b..810e840bb4f1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1344,7 +1344,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>  			set_page_refcounted(p);
>  	}
>  
> -	folio_set_compound_order(folio, 0);
> +	folio_set_order(folio, 0);
>  	__folio_clear_head(folio);
>  }
>  
> @@ -1808,7 +1808,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	__folio_clear_reserved(folio);
>  	__folio_set_head(folio);
>  	/* we rely on prep_new_hugetlb_folio to set the destructor */
> -	folio_set_compound_order(folio, order);
> +	folio_set_order(folio, order);
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -1872,7 +1872,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		p = folio_page(folio, j);
>  		__ClearPageReserved(p);
>  	}
> -	folio_set_compound_order(folio, 0);
> +	folio_set_order(folio, 0);
>  	__folio_clear_head(folio);
>  	return false;
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index bcf75a8b032d..829b6a60ceb7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -378,6 +378,27 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
>  int split_free_page(struct page *free_page,
>  			unsigned int order, unsigned long split_pfn_offset);
>  
> +/*
> + * This will have no effect, other than possibly generating a warning, if the
> + * caller passes in a non-large folio.
> + */
> +static inline void folio_set_order(struct folio *folio, unsigned int order)
> +{
> +	if (!folio_test_large(folio)) {
> +		WARN_ON_ONCE(order);
> +		return;
> +	}

Would it be better to do this (below)? I'm not sure of the value of
warning on "order"--it's a little odd and unexplained and doesn't really
do anything more helpful than simply warning about what why the code is
failing, which is really about !large, rather than order. Unless I'm
missing something?

	if (WARN_ON_ONCE(!folio_test_large(folio)))
		return;

Sorry to drive you crazy over nits. This is the last one from me. :)

thanks,
-- 
John Hubbard
NVIDIA

> +
> +	folio->_folio_order = order;
> +#ifdef CONFIG_64BIT
> +	/*
> +	 * When hugetlb dissolves a folio, we need to clear the tail
> +	 * page, rather than setting nr_pages to 1.
> +	 */
> +	folio->_folio_nr_pages = order ? 1U << order : 0;
> +#endif
> +}
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  
>  /*


