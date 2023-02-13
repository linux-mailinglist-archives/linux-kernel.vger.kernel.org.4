Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF23694BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjBMPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBMPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:55:30 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0981C32B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:55:10 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id CD4EE40002;
        Mon, 13 Feb 2023 15:55:06 +0000 (UTC)
Message-ID: <707cd2b6-4350-4171-1e0c-f63ea5db7ece@ghiti.fr>
Date:   Mon, 13 Feb 2023 16:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use
 folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230114001556.43795-1-vishal.moola@gmail.com>
 <20230114001556.43795-2-vishal.moola@gmail.com>
 <CGME20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507@eucas1p2.samsung.com>
 <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com>
 <3a3457b1-60bc-a97b-0042-432790d3bbbe@ghiti.fr>
 <Y+pcK41bagzzhgj+@casper.infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Y+pcK41bagzzhgj+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2/13/23 16:50, Matthew Wilcox wrote:
> On Mon, Feb 13, 2023 at 04:28:05PM +0100, Alexandre Ghiti wrote:
>> The issue lies here: before using pteval in pfn_folio(), we should test it.
>> The following patch fixes the issue for me:
> Thanks for debugging it.  I'd rather see this written as ...
>
> 		pte_t pteval = *_pte;
> +		unsigned long pfn;
>
> +		if (pte_none(pteval))
> +			continue;
> +		pfn = pte_pfn(pteval);
> +		if (is_zero_pfn(pfn))
> +			continue;
> +		folio = pfn_folio(pfn);
> +		if (folio_test_large(folio))
> +			continue;
> 		release_pte_folio(folio);
>
> makes sense?


Sure, that's fine by me, I can send that or I'll add my tested-by on 
what you send, whatever suits you.

Alex


>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index eb38bd1b1b2f..fef3414b481b 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -514,10 +514,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
>>          while (--_pte >= pte) {
>>                  pte_t pteval = *_pte;
>>
>> -               folio = pfn_folio(pte_pfn(pteval));
>> -               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
>> -                               !folio_test_large(folio))
>> -                       release_pte_folio(folio);
>> +               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval))) {
>> +                       folio = pfn_folio(pte_pfn(pteval));
>> +
>> +                       if (!folio_test_large(folio))
>> +                               release_pte_folio(folio);
>> +               }
>>          }
>>
>>          list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
>>
>>
>> @Marek: could you give it a try?
>>
>> I can send a separate patch if needed, let me know.
>>
>> Thanks,
>>
>> Alex
>>
>>
>>>>     		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
>>>> -				!PageCompound(page))
>>>> -			release_pte_page(page);
>>>> +				!folio_test_large(folio))
>>>> +			release_pte_folio(folio);
>>>>     	}
>>>> -	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
>>>> -		list_del(&page->lru);
>>>> -		release_pte_page(page);
>>>> +	list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
>>>> +		list_del(&folio->lru);
>>>> +		release_pte_folio(folio);
>>>>     	}
>>>>     }
>>> Best regards
