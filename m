Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C752D74D205
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGJJnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjGJJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:43:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 758EB2708
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:40:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 187FE2B;
        Mon, 10 Jul 2023 02:40:44 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08C693F740;
        Mon, 10 Jul 2023 02:39:59 -0700 (PDT)
Message-ID: <e1ee2a95-aff1-461b-7e9b-9dd2fd0e70d3@arm.com>
Date:   Mon, 10 Jul 2023 10:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] mm: Allow deferred splitting of arbitrary large
 anon folios
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-3-ryan.roberts@arm.com>
 <877crcgmj1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <6379dd13-551e-3c73-422a-56ce40b27deb@arm.com>
 <87ttucfht7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a60af4b1-13c2-2d05-d112-e3dce94bccb0@arm.com>
 <878rbof8cs.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <878rbof8cs.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 10:01, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 10/07/2023 06:37, Huang, Ying wrote:
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> Somehow I managed to reply only to the linux-arm-kernel list on first attempt so
>>>> resending:
>>>>
>>>> On 07/07/2023 09:21, Huang, Ying wrote:
>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>>
>>>>>> With the introduction of large folios for anonymous memory, we would
>>>>>> like to be able to split them when they have unmapped subpages, in order
>>>>>> to free those unused pages under memory pressure. So remove the
>>>>>> artificial requirement that the large folio needed to be at least
>>>>>> PMD-sized.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>> ---
>>>>>>  mm/rmap.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 82ef5ba363d1..bbcb2308a1c5 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1474,7 +1474,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>  		 * page of the folio is unmapped and at least one page
>>>>>>  		 * is still mapped.
>>>>>>  		 */
>>>>>> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>>>>> +		if (folio_test_large(folio) && folio_test_anon(folio))
>>>>>>  			if (!compound || nr < nr_pmdmapped)
>>>>>>  				deferred_split_folio(folio);
>>>>>>  	}
>>>>>
>>>>> One possible issue is that even for large folios mapped only in one
>>>>> process, in zap_pte_range(), we will always call deferred_split_folio()
>>>>> unnecessarily before freeing a large folio.
>>>>
>>>> Hi Huang, thanks for reviewing!
>>>>
>>>> I have a patch that solves this problem by determining a range of ptes covered
>>>> by a single folio and doing a "batch zap". This prevents the need to add the
>>>> folio to the deferred split queue, only to remove it again shortly afterwards.
>>>> This reduces lock contention and I can measure a performance improvement for the
>>>> kernel compilation benchmark. See [1].
>>>>
>>>> However, I decided to remove it from this patch set on Yu Zhao's advice. We are
>>>> aiming for the minimal patch set to start with and wanted to focus people on
>>>> that. I intend to submit it separately later on.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/20230626171430.3167004-8-ryan.roberts@arm.com/
>>>
>>> Thanks for your information!  "batch zap" can solve the problem.
>>>
>>> And, I agree with Matthew's comments to fix the large folios interaction
>>> issues before merging the patches to allocate large folios as in the
>>> following email.
>>>
>>> https://lore.kernel.org/linux-mm/ZKVdUDuwNWDUCWc5@casper.infradead.org/
>>>
>>> If so, we don't need to introduce the above problem or a large patchset.
>>
>> I appreciate Matthew's and others position about not wanting to merge a minimal
>> implementation while there are some fundamental features (e.g. compaction) it
>> doesn't play well with - I'm working to create a definitive list so these items
>> can be tracked and tackled.
> 
> Good to know this, Thanks!
> 
>> That said, I don't see this "batch zap" patch as an example of this. It's just a
>> performance enhancement that improves things even further than large anon folios
>> on their own. I'd rather concentrate on the core changes first then deal with
>> this type of thing later. Does that work for you?
> 
> IIUC, allocating large folios upon page fault depends on splitting large
> folios in page_remove_rmap() to avoid memory wastage.  Splitting large
> folios in page_remove_rmap() depends on "batch zap" to avoid performance
> regression in zap_pte_range().  So we need them to be done earlier.  Or
> I miss something?

My point was just that large anon folios improves performance significantly
overall, despite a small perf regression in zap_pte_range(). That regression is
reduced further by a patch from Yin Fengwei to reduce the lock contention [1].
So it doesn't seem urgent to me to get the "batch zap" change in.

I'll add it to my list, then prioritize it against the other stuff.

[1] https://lore.kernel.org/linux-mm/20230429082759.1600796-1-fengwei.yin@intel.com/

> 
> Best Regards,
> Huang, Ying

