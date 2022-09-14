Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E815B7E12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiINA7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINA7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:59:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB514D17;
        Tue, 13 Sep 2022 17:59:50 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i3so5110783qkl.3;
        Tue, 13 Sep 2022 17:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7Ygc2a7zFUOpTRr5fFVTb8yN9D9ZfZYmNOPFpvUHUuQ=;
        b=lKEY2q7aar6XrlZKbMIH4phInaENFrHa/YSCJMCVoQzEjsT1ha6NBBahCldNIhKBg4
         wv0rE9xxFElY9UOciw0vh2x1IadY5l/UsfM285e044N65AdVPKTpbHSspLiUG+icLVNu
         syzXtky3e4G/wtKhPUaEEvsVbAgsMJXsrRF1HZ+J5DHfu4WD7/p+9xjWkuMwxU5BBcuX
         mQNx+cHcsVyGmw5nDhHekXil1IlNaZpy/DSUwLoO4+54ajKFSQZp/1ZJDlfPWChfzl7d
         FVVTNAFbX0Y1xTCA8DpRL1Qm6gFb2VU8eqJAxGVX0qHUVZMq7aGNqUJ0hKqKwdxbkoxK
         6Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Ygc2a7zFUOpTRr5fFVTb8yN9D9ZfZYmNOPFpvUHUuQ=;
        b=F5GFy5bFk/RmevDpiAGhMkl4alxqU9nvMRReEeK+S2lyv1P1+QL2wUEU1g0D//RK8h
         efHzrtCdSgCUhOXg7FxS5XTtcXDHMzpT2jjE9BQdsGFN5wczegoWUD8ZKdvP6AV/gwVc
         UPfPW2TSied9nX9d7FiH8n2dMue8UJdz1t904Z0+PrYTj7zFjNp84DGR1oj7JM1T97w/
         3FcilMqBhPldpwQqqreqtHqX6XlmPumRSlL5K2QKqNKKCtav04PcCi/aGlJNdPlrNXPs
         DDZ0L6l2u4ft/hd4DEhvDfNBEriDjdizKCVRlTxVXRltQIPbLY4/v2wU4tLpgYEXiEyp
         GbtQ==
X-Gm-Message-State: ACgBeo0ZgcHuGQAl8DGL2hUnz83hBAgmhBmylGWFryWm1hZqRf9Pf4oW
        Cif4LhT40wvvUJH9nFRcrl0=
X-Google-Smtp-Source: AA6agR7dMWGP0iSvZ0sXq9Rz8YJoklcIXN65K7aCsyYoukqmr7ac1lgNLDoGTHUroAxGyFnrlIvjFQ==
X-Received: by 2002:a05:620a:2685:b0:6bc:374a:8f44 with SMTP id c5-20020a05620a268500b006bc374a8f44mr24790219qkp.165.1663117189214;
        Tue, 13 Sep 2022 17:59:49 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a244300b006ce3fcee2bdsm865004qkn.50.2022.09.13.17.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 17:59:48 -0700 (PDT)
Message-ID: <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
Date:   Tue, 13 Sep 2022 17:59:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-2-opendmb@gmail.com>
 <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 5:02 PM, Zi Yan wrote:
> On 13 Sep 2022, at 15:54, Doug Berger wrote:
> 
>> The function set_migratetype_isolate() has special handling for
>> pageblocks of MIGRATE_CMA type that protects them from being
>> isolated for MIGRATE_MOVABLE requests.
>>
>> Since isolate_single_pageblock() doesn't receive the migratetype
>> argument of start_isolate_page_range() it used the migratetype
>> of the pageblock instead of the requested migratetype which
>> defeats this MIGRATE_CMA check.
>>
>> This allows an attempt to create a gigantic page within a CMA
>> region to change the migratetype of the first and last pageblocks
>> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
>> failure, which corrupts the CMA region.
>>
>> The calls to (un)set_migratetype_isolate() for the first and last
>> pageblocks of the start_isolate_page_range() are moved back into
>> that function to allow access to its migratetype argument and make
>> it easier to see how all of the pageblocks in the range are
>> isolated.
>>
>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   mm/page_isolation.c | 75 +++++++++++++++++++++------------------------
>>   1 file changed, 35 insertions(+), 40 deletions(-)
> 
> Thanks for the fix.
Thanks for the review.

> 
> Why not just pass migratetype into isolate_single_pageblock() and use
> it when set_migratetype_isolate() is used? That would have much
> fewer changes. What is the reason of pulling skip isolation logic out?
I found the skip_isolation logic confusing and thought that setting and 
restoring the migratetype within the same function and consolidating the 
error recovery paths also within that function was easier to understand 
and less prone to accidental breakage.

In particular, setting MIGRATE_ISOLATE in isolate_single_pageblock() and 
having to remember to unset it in start_isolate_page_range() differently 
on different error paths was troublesome for me.

It could certainly be done differently, but this was my preference.

> 
> Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
> so that migratetype will not be overwritten during page isolation.
> Then, set_migratetype_isolate() and start_isolate_page_range()
> will not have migratetype to set in error recovery any more.
> That is on my TODO.
> 
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 9d73dc38e3d7..8e16aa22cb61 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * @flags:			isolation flags
>>    * @gfp_flags:			GFP flags used for migrating pages
>>    * @isolate_before:	isolate the pageblock before the boundary_pfn
>> - * @skip_isolation:	the flag to skip the pageblock isolation in second
>> - *			isolate_single_pageblock()
>>    *
>>    * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
>>    * pageblock. When not all pageblocks within a page are isolated at the same
>> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>    * the in-use page then splitting the free page.
>>    */
>>   static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>> +			gfp_t gfp_flags, bool isolate_before)
>>   {
>> -	unsigned char saved_mt;
>>   	unsigned long start_pfn;
>>   	unsigned long isolate_pageblock;
>>   	unsigned long pfn;
>> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
>>   				      zone->zone_start_pfn);
>>
>> -	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>> -
>> -	if (skip_isolation)
>> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
>> -	else {
>> -		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
>> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>> -
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	/*
>>   	 * Bail out early when the to-be-isolated pageblock does not form
>>   	 * a free or in-use page across boundary_pfn:
>> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   					ret = set_migratetype_isolate(page, page_mt,
>>   						flags, head_pfn, head_pfn + nr_pages);
>>   					if (ret)
>> -						goto failed;
>> +						return ret;
>>   				}
>>
>>   				ret = __alloc_contig_migrate_range(&cc, head_pfn,
>> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   					unset_migratetype_isolate(page, page_mt);
>>
>>   				if (ret)
>> -					goto failed;
>> +					return -EBUSY;
>>   				/*
>>   				 * reset pfn to the head of the free page, so
>>   				 * that the free page handling code above can split
>> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>   				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>>   					/* stop if we cannot find the free page */
>>   					if (++order >= MAX_ORDER)
>> -						goto failed;
>> +						return -EBUSY;
>>   					outer_pfn &= ~0UL << order;
>>   				}
>>   				pfn = outer_pfn;
>>   				continue;
>>   			} else
>>   #endif
>> -				goto failed;
>> +				return -EBUSY;
>>   		}
>>
>>   		pfn++;
>>   	}
>>   	return 0;
>> -failed:
>> -	/* restore the original migratetype */
>> -	if (!skip_isolation)
>> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>> -	return -EBUSY;
>>   }
>>
>>   /**
>> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
>>   	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
>>   	int ret;
>> -	bool skip_isolation = false;
>>
>>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
>> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>> +	ret = set_migratetype_isolate(pfn_to_page(isolate_start), migratetype,
>> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>>   	if (ret)
>>   		return ret;
>> -
>> -	if (isolate_start == isolate_end - pageblock_nr_pages)
>> -		skip_isolation = true;
>> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
>> +	if (ret)
>> +		goto unset_start_block;
>>
>>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
>> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>> +	pfn = isolate_end - pageblock_nr_pages;
>> +	if (isolate_start != pfn) {
>> +		ret = set_migratetype_isolate(pfn_to_page(pfn), migratetype,
>> +				flags, pfn, pfn + pageblock_nr_pages);
>> +		if (ret)
>> +			goto unset_start_block;
>> +	}
>> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
>>   	if (ret) {
>> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>> -		return ret;
>> +		if (isolate_start != pfn)
>> +			goto unset_end_block;
>> +		else
>> +			goto unset_start_block;
>>   	}
>>
>>   	/* skip isolated pageblocks at the beginning and end */
>> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>   	     pfn += pageblock_nr_pages) {
>>   		page = __first_valid_page(pfn, pageblock_nr_pages);
>>   		if (page && set_migratetype_isolate(page, migratetype, flags,
>> -					start_pfn, end_pfn)) {
>> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
>> -			unset_migratetype_isolate(
>> -				pfn_to_page(isolate_end - pageblock_nr_pages),
>> -				migratetype);
>> -			return -EBUSY;
>> -		}
>> +					start_pfn, end_pfn))
>> +			goto unset_isolated_blocks;
>>   	}
>>   	return 0;
>> +
>> +unset_isolated_blocks:
>> +	ret = -EBUSY;
>> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
>> +				migratetype);
>> +unset_end_block:
>> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pages),
>> +				  migratetype);
>> +unset_start_block:
>> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>> +	return ret;
>>   }
>>
>>   /*
>> -- 
>> 2.25.1
> 
> 
> --
> Best Regards,
> Yan, Zi

