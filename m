Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100675B8E21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiINR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:27:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA67754C;
        Wed, 14 Sep 2022 10:27:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f13so7171640qkk.6;
        Wed, 14 Sep 2022 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hsdefQIEXRQygaF3Dn6cxv0ih/rj9SBPRQELvXoH8xs=;
        b=KNPqrb4tTswiBZepLgTh3pz+heERU63Ppv1xOyMh0I1PuSX3Lnk0mOU79XPiIWavEr
         x4ObfwfIkw6MnzIyiioQ6+DoggIqhv32CFD1qWjFDu+xaZM7NqKu+0/8MEdzZlsF9N59
         OFFVZ0D+FrhCD70WIGKmi3gPQa2LFRgCy3nWTmrU8j3EnwX2F6/cMuhQ0tN0L3wJwiEc
         0TgoCkiC7JCGDtAKiGak90qzLu6R+FjLZN7BPuhdgd49A7oDsqULQQ7lHZBuwtWlXuGm
         bpwjytq5CwnAqBUcwl1ah8u1tOcoXgQZFaQA4OUC5d1fADQN6jtQgxpAo1ypsEvGtO+F
         czpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hsdefQIEXRQygaF3Dn6cxv0ih/rj9SBPRQELvXoH8xs=;
        b=M7TMqY/pvJd0wNddiuVEYzdtXdevsqh0fEUogmj6v5uXrV+AtymRWK+Fx5pvGPFu5g
         gYm6FVElNl9wPJdGw3h2jM9zNeKTliyEK/8B6n4BzzVsQkLc6BQ8c5jp9AzXf0exYARr
         B1zHmVMIrG0HNAQqmjtr6W2NvoBO4WPULBrcxFr6zJ4k7Zou2wc9zTbG+WD2XH7o8lNa
         /X6RcsZY6JH4q0HwBZiVGdbm8nBHdQbHF2DAEUTkeD4fnxm7QlEPef0DtgA3AcABBApb
         LcXeOqKNRlT41naL9xC1lCFVDOyisExcc64goshTlVxksV3egZ+51Ug2KWGreMsRf6QB
         0DuA==
X-Gm-Message-State: ACgBeo1E+4jC1ED5eBSeX6N8R/3AlWl/unqTsipiDbay3QnXWbiYEeHH
        qHeVzmftjXRj6eoA1iPdYqA=
X-Google-Smtp-Source: AA6agR6OhAy7tXAa7z1dP6sffT/mOD1kKIjiCOgKDeHbN9sXeykJDDAXo/TNPO03DNmfClDfdjLmbg==
X-Received: by 2002:ae9:dd42:0:b0:6cc:ead5:14b4 with SMTP id r63-20020ae9dd42000000b006ccead514b4mr19120716qkf.94.1663176425608;
        Wed, 14 Sep 2022 10:27:05 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006ce1bfbd603sm2336461qkp.124.2022.09.14.10.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:27:05 -0700 (PDT)
Message-ID: <a3363a52-883b-dcd1-b77f-f2bb378d6f2d@gmail.com>
Date:   Wed, 14 Sep 2022 10:27:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
Content-Language: en-US
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
 <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
 <71D040CB-0E26-4CD3-9121-54D740F24594@nvidia.com>
 <6b465dd1-f5b1-cb6c-cee0-5461b66f6031@gmail.com>
 <819CB6CD-0112-4B07-BDFE-84611470070F@nvidia.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <819CB6CD-0112-4B07-BDFE-84611470070F@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 6:53 PM, Zi Yan wrote:
> On 13 Sep 2022, at 21:47, Doug Berger wrote:
> 
>> On 9/13/2022 6:09 PM, Zi Yan wrote:
>>> On 13 Sep 2022, at 20:59, Doug Berger wrote:
>>>
>>>> On 9/13/2022 5:02 PM, Zi Yan wrote:
>>>>> On 13 Sep 2022, at 15:54, Doug Berger wrote:
>>>>>
>>>>>> The function set_migratetype_isolate() has special handling for
>>>>>> pageblocks of MIGRATE_CMA type that protects them from being
>>>>>> isolated for MIGRATE_MOVABLE requests.
>>>>>>
>>>>>> Since isolate_single_pageblock() doesn't receive the migratetype
>>>>>> argument of start_isolate_page_range() it used the migratetype
>>>>>> of the pageblock instead of the requested migratetype which
>>>>>> defeats this MIGRATE_CMA check.
>>>>>>
>>>>>> This allows an attempt to create a gigantic page within a CMA
>>>>>> region to change the migratetype of the first and last pageblocks
>>>>>> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
>>>>>> failure, which corrupts the CMA region.
>>>>>>
>>>>>> The calls to (un)set_migratetype_isolate() for the first and last
>>>>>> pageblocks of the start_isolate_page_range() are moved back into
>>>>>> that function to allow access to its migratetype argument and make
>>>>>> it easier to see how all of the pageblocks in the range are
>>>>>> isolated.
>>>>>>
>>>>>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
>>>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>>>> ---
>>>>>>     mm/page_isolation.c | 75 +++++++++++++++++++++------------------------
>>>>>>     1 file changed, 35 insertions(+), 40 deletions(-)
>>>>>
>>>>> Thanks for the fix.
>>>> Thanks for the review.
>>>>
>>>>>
>>>>> Why not just pass migratetype into isolate_single_pageblock() and use
>>>>> it when set_migratetype_isolate() is used? That would have much
>>>>> fewer changes. What is the reason of pulling skip isolation logic out?
>>>> I found the skip_isolation logic confusing and thought that setting and restoring the migratetype within the same function and consolidating the error recovery paths also within that function was easier to understand and less prone to accidental breakage.
>>>>
>>>> In particular, setting MIGRATE_ISOLATE in isolate_single_pageblock() and having to remember to unset it in start_isolate_page_range() differently on different error paths was troublesome for me.
>>>
>>> Wouldn't this work as well?
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index c1307d1bea81..a312cabd0d95 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -288,6 +288,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>>     * @isolate_before:    isolate the pageblock before the boundary_pfn
>>>     * @skip_isolation:    the flag to skip the pageblock isolation in second
>>>     *                     isolate_single_pageblock()
>>> + * @migratetype:       Migrate type to set in error recovery.
>>>     *
>>>     * Free and in-use pages can be as big as MAX_ORDER and contain more than one
>>>     * pageblock. When not all pageblocks within a page are isolated at the same
>>> @@ -302,9 +303,9 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>>     * the in-use page then splitting the free page.
>>>     */
>>>    static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>> -                       gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>>> +                       gfp_t gfp_flags, bool isolate_before, bool skip_isolation,
>>> +                       int migratetype)
>>>    {
>>> -       unsigned char saved_mt;
>>>           unsigned long start_pfn;
>>>           unsigned long isolate_pageblock;
>>>           unsigned long pfn;
>>> @@ -328,12 +329,10 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>           start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
>>>                                         zone->zone_start_pfn);
>>>
>>> -       saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>>> -
>>>           if (skip_isolation)
>>> -               VM_BUG_ON(!is_migrate_isolate(saved_mt));
>>> +               VM_BUG_ON(!is_migrate_isolate(get_pageblock_migratetype(pfn_to_page(isolate_pageblock))));
>>>           else {
>>> -               ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
>>> +               ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype, flags,
>>>                                   isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>>>
>>>                   if (ret)
>>> @@ -475,7 +474,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>    failed:
>>>           /* restore the original migratetype */
>>>           if (!skip_isolation)
>>> -               unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>>> +               unset_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype);
>>>           return -EBUSY;
>>>    }
>>>
>>> @@ -537,7 +536,8 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>           bool skip_isolation = false;
>>>
>>>           /* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
>>> -       ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>>> +       ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false,
>>> +                               skip_isolation, migratetype);
>>>           if (ret)
>>>                   return ret;
>>>
>>> @@ -545,7 +545,8 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>                   skip_isolation = true;
>>>
>>>           /* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
>>> -       ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>>> +       ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
>>> +                               skip_isolation, migratetype);
>>>           if (ret) {
>>>                   unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>>>                   return ret;
>>>
>> I would expect this to work as well, but it is not my preference.
>>
>>>>
>>>> It could certainly be done differently, but this was my preference.
>>>
>>> A smaller patch can make review easier, right?
>> It certainly can. Especially when it is for code that you are familiar with ;).
>>
>> I am happy to have you submit a patch to fix this issue and submit it to stable for backporting. Fixing the issue is what's important to me.
>>
> 
> I can submit the above as a patch. Is there a visible userspace issue, so that we need to
> backport it? Thanks.
I did not observe symptoms of the issue, but I did observe the issue 
when allocating gigantic huge pages as part of the hugetlbfs on a system 
with CMA regions.

My best guess is that it probably does not create a "functional" problem 
since the error would likely be cancelled out by subsequent CMA 
allocations restoring the pageblock migratetype. However, in the 
meantime the page allocator would handle free pages in those pageblocks 
without the MIGRATE_CMA qualifications which might impact driver 
performance. There might be other problems of which I am unaware.

The issue currently only exists in the wild in v5.19, so it would be 
nice to get it backported there to nip it in the bud.

> 
>>>
>>>>>
>>>>> Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
>>>>> so that migratetype will not be overwritten during page isolation.
>>>>> Then, set_migratetype_isolate() and start_isolate_page_range()
>>>>> will not have migratetype to set in error recovery any more.
>>>>> That is on my TODO.
>>>>>
>>>>>>
>>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>>> index 9d73dc38e3d7..8e16aa22cb61 100644
>>>>>> --- a/mm/page_isolation.c
>>>>>> +++ b/mm/page_isolation.c
>>>>>> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>>>>>      * @flags:			isolation flags
>>>>>>      * @gfp_flags:			GFP flags used for migrating pages
>>>>>>      * @isolate_before:	isolate the pageblock before the boundary_pfn
>>>>>> - * @skip_isolation:	the flag to skip the pageblock isolation in second
>>>>>> - *			isolate_single_pageblock()
>>>>>>      *
>>>>>>      * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
>>>>>>      * pageblock. When not all pageblocks within a page are isolated at the same
>>>>>> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>>>>>>      * the in-use page then splitting the free page.
>>>>>>      */
>>>>>>     static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>>>> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>>>>>> +			gfp_t gfp_flags, bool isolate_before)
>>>>>>     {
>>>>>> -	unsigned char saved_mt;
>>>>>>     	unsigned long start_pfn;
>>>>>>     	unsigned long isolate_pageblock;
>>>>>>     	unsigned long pfn;
>>>>>> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>>>>     	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
>>>>>>     				      zone->zone_start_pfn);
>>>>>>
>>>>>> -	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
>>>>>> -
>>>>>> -	if (skip_isolation)
>>>>>> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
>>>>>> -	else {
>>>>>> -		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
>>>>>> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>>>>>> -
>>>>>> -		if (ret)
>>>>>> -			return ret;
>>>>>> -	}
>>>>>> -
>>>>>>     	/*
>>>>>>     	 * Bail out early when the to-be-isolated pageblock does not form
>>>>>>     	 * a free or in-use page across boundary_pfn:
>>>>>> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>>>>     					ret = set_migratetype_isolate(page, page_mt,
>>>>>>     						flags, head_pfn, head_pfn + nr_pages);
>>>>>>     					if (ret)
>>>>>> -						goto failed;
>>>>>> +						return ret;
>>>>>>     				}
>>>>>>
>>>>>>     				ret = __alloc_contig_migrate_range(&cc, head_pfn,
>>>>>> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>>>>     					unset_migratetype_isolate(page, page_mt);
>>>>>>
>>>>>>     				if (ret)
>>>>>> -					goto failed;
>>>>>> +					return -EBUSY;
>>>>>>     				/*
>>>>>>     				 * reset pfn to the head of the free page, so
>>>>>>     				 * that the free page handling code above can split
>>>>>> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>>>>>     				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>>>>>>     					/* stop if we cannot find the free page */
>>>>>>     					if (++order >= MAX_ORDER)
>>>>>> -						goto failed;
>>>>>> +						return -EBUSY;
>>>>>>     					outer_pfn &= ~0UL << order;
>>>>>>     				}
>>>>>>     				pfn = outer_pfn;
>>>>>>     				continue;
>>>>>>     			} else
>>>>>>     #endif
>>>>>> -				goto failed;
>>>>>> +				return -EBUSY;
>>>>>>     		}
>>>>>>
>>>>>>     		pfn++;
>>>>>>     	}
>>>>>>     	return 0;
>>>>>> -failed:
>>>>>> -	/* restore the original migratetype */
>>>>>> -	if (!skip_isolation)
>>>>>> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
>>>>>> -	return -EBUSY;
>>>>>>     }
>>>>>>
>>>>>>     /**
>>>>>> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>>>>     	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
>>>>>>     	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
>>>>>>     	int ret;
>>>>>> -	bool skip_isolation = false;
>>>>>>
>>>>>>     	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
>>>>>> -	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
>>>>>> +	ret = set_migratetype_isolate(pfn_to_page(isolate_start), migratetype,
>>>>>> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>>>>>>     	if (ret)
>>>>>>     		return ret;
>>>>>> -
>>>>>> -	if (isolate_start == isolate_end - pageblock_nr_pages)
>>>>>> -		skip_isolation = true;
>>>>>> +	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
>>>>>> +	if (ret)
>>>>>> +		goto unset_start_block;
>>>>>>
>>>>>>     	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
>>>>>> -	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
>>>>>> +	pfn = isolate_end - pageblock_nr_pages;
>>>>>> +	if (isolate_start != pfn) {
>>>>>> +		ret = set_migratetype_isolate(pfn_to_page(pfn), migratetype,
>>>>>> +				flags, pfn, pfn + pageblock_nr_pages);
>>>>>> +		if (ret)
>>>>>> +			goto unset_start_block;
>>>>>> +	}
>>>>>> +	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
>>>>>>     	if (ret) {
>>>>>> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>>>>>> -		return ret;
>>>>>> +		if (isolate_start != pfn)
>>>>>> +			goto unset_end_block;
>>>>>> +		else
>>>>>> +			goto unset_start_block;
>>>>>>     	}
>>>>>>
>>>>>>     	/* skip isolated pageblocks at the beginning and end */
>>>>>> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>>>>>>     	     pfn += pageblock_nr_pages) {
>>>>>>     		page = __first_valid_page(pfn, pageblock_nr_pages);
>>>>>>     		if (page && set_migratetype_isolate(page, migratetype, flags,
>>>>>> -					start_pfn, end_pfn)) {
>>>>>> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
>>>>>> -			unset_migratetype_isolate(
>>>>>> -				pfn_to_page(isolate_end - pageblock_nr_pages),
>>>>>> -				migratetype);
>>>>>> -			return -EBUSY;
>>>>>> -		}
>>>>>> +					start_pfn, end_pfn))
>>>>>> +			goto unset_isolated_blocks;
>>>>>>     	}
>>>>>>     	return 0;
>>>>>> +
>>>>>> +unset_isolated_blocks:
>>>>>> +	ret = -EBUSY;
>>>>>> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
>>>>>> +				migratetype);
>>>>>> +unset_end_block:
>>>>>> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pages),
>>>>>> +				  migratetype);
>>>>>> +unset_start_block:
>>>>>> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
>>>>>> +	return ret;
>>>>>>     }
>>>>>>
>>>>>>     /*
>>>>>> -- 
>>>>>> 2.25.1
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Yan, Zi
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>> Thanks for your efforts to get alloc_contig_range to work at pageblock granularity!
>> -Doug
> 
> 
> --
> Best Regards,
> Yan, Zi
Thanks,
-Doug
