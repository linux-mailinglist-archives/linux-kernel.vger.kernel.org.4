Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA1737379
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjFTSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjFTSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF919A8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687284168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRm4yc4qMtunLBzXmR/1ejUxdVZnW/vHIX1yfFUZTks=;
        b=TXgSO/RdmWPf5qw3KVWvs1h00MmKKnxLV7GThSFpHtqo2yT3vpQJCknUp/065oawqlARtA
        BylydCLwrP0F8oKCZO878rKmYq4s8ojFXM8uG/mB7hpCLu4xPbCeaWszFL0sf7XqugtxoB
        yXB21LnGkTEw7lXQeAQebqcjXOXTVyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-704YdHKzOiSyckwxL6ZcQQ-1; Tue, 20 Jun 2023 14:02:45 -0400
X-MC-Unique: 704YdHKzOiSyckwxL6ZcQQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so19768765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284163; x=1689876163;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRm4yc4qMtunLBzXmR/1ejUxdVZnW/vHIX1yfFUZTks=;
        b=NFVO7xYERtrnby+RqMTeAZZQXuKol6I7fAu2IjYQs+WtZ8TtTGF7MpgF4dlFACkhvi
         tj+w0IFRHvTgCwZnSJjvFT2A5riFUUoycw7MRpToE3CPw94zsIhYXjzcnhDqWX0Cl7iI
         Tms1FtOG3FyMz66vpoDypqL/3BbkTdaEIA919VG00nCw7GcNtrm8Ua87vi1eL38uC8SK
         gEyklm97Z/o8eGD44w1nTSZUnLPTSEnr2Tegr1vFq9NQOkGLI+4m1tsBlbraluIrcqUw
         q8SZNPtK0r38iT/7MipMSdvv7m/m+ttjwsM5b5Pc7Ss0BxOMD7syGBjHHnFwvX+lnj8U
         5y6w==
X-Gm-Message-State: AC+VfDzQH5TAgWP2v99rQr+1wWjHh9RZAP1728tvOcQO7CfsuzXDPe9b
        vKT4eKbxL8DrENc4bZ7U2lQ7P9vlzim57NjmI3nDyve6+1BGA+UF7UyoUT95D4SWgAM4BR4yT1i
        WuyOR0whsJlIr5pmZSjyjcIA+
X-Received: by 2002:a05:600c:ad4:b0:3f9:b8b8:20df with SMTP id c20-20020a05600c0ad400b003f9b8b820dfmr1677422wmr.33.1687284162968;
        Tue, 20 Jun 2023 11:02:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61L1i5+eB0b2iW8qyt23nne+c+R+ficSGQ1kzLD8tgpFdbtBQFblzWO68kvfr8ugu5ddb5eg==
X-Received: by 2002:a05:600c:ad4:b0:3f9:b8b8:20df with SMTP id c20-20020a05600c0ad400b003f9b8b820dfmr1677403wmr.33.1687284162551;
        Tue, 20 Jun 2023 11:02:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:d200:8745:c520:8bf6:b587? (p200300cbc739d2008745c5208bf6b587.dip0.t-ipconnect.de. [2003:cb:c739:d200:8745:c520:8bf6:b587])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0031134bcdacdsm2487036wrw.42.2023.06.20.11.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 11:02:42 -0700 (PDT)
Message-ID: <a73ed9f3-97f7-5822-f894-fce57ac02dc7@redhat.com>
Date:   Tue, 20 Jun 2023 20:02:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20230619231044.112894-1-peterx@redhat.com>
 <20230619231044.112894-6-peterx@redhat.com>
 <02a057a3-3d9e-4013-8762-25ceb1beec86@redhat.com> <ZJHSm/UbEy3JndZ4@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 5/8] mm/gup: Accelerate thp gup even for "pages !=
 NULL"
In-Reply-To: <ZJHSm/UbEy3JndZ4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.23 18:23, Peter Xu wrote:
> On Tue, Jun 20, 2023 at 05:43:35PM +0200, David Hildenbrand wrote:
>> On 20.06.23 01:10, Peter Xu wrote:
>>> The acceleration of THP was done with ctx.page_mask, however it'll be
>>> ignored if **pages is non-NULL.
>>>
>>> The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
>>> accelerate mm_populate() treatment of THP pages").  It didn't explain why
>>> we can't optimize the **pages non-NULL case.  It's possible that at that
>>> time the major goal was for mm_populate() which should be enough back then.
>>
>> In the past we had these sub-page refcounts for THP. My best guess (and I
>> didn't check if that was still the case in 2013) would be that it was
>> simpler regarding refcount handling to to do it one-subpage at a time.
>>
>> But I might be just wrong.
>>
>>>
>>> Optimize thp for all cases, by properly looping over each subpage, doing
>>> cache flushes, and boost refcounts / pincounts where needed in one go.
>>>
>>> This can be verified using gup_test below:
>>>
>>>     # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10
>>>
>>> Before:    13992.50 ( +-8.75%)
>>> After:       378.50 (+-69.62%)
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
>>>    1 file changed, 44 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 4a00d609033e..b50272012e49 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
>>>    			goto out;
>>>    		}
>>>    next_page:
>>> -		if (pages) {
>>> -			pages[i] = page;
>>> -			flush_anon_page(vma, page, start);
>>> -			flush_dcache_page(page);
>>> -			ctx.page_mask = 0;
>>> -		}
>>> -
>>>    		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>>>    		if (page_increm > nr_pages)
>>>    			page_increm = nr_pages;
>>> +
>>> +		if (pages) {
>>> +			struct page *subpage;
>>> +			unsigned int j;
>>> +
>>> +			/*
>>> +			 * This must be a large folio (and doesn't need to
>>> +			 * be the whole folio; it can be part of it), do
>>> +			 * the refcount work for all the subpages too.
>>> +			 *
>>> +			 * NOTE: here the page may not be the head page
>>> +			 * e.g. when start addr is not thp-size aligned.
>>> +			 * try_grab_folio() should have taken care of tail
>>> +			 * pages.
>>> +			 */
>>> +			if (page_increm > 1) {
>>> +				struct folio *folio;
>>> +
>>> +				/*
>>> +				 * Since we already hold refcount on the
>>> +				 * large folio, this should never fail.
>>> +				 */
>>> +				folio = try_grab_folio(page, page_increm - 1,
>>> +						       foll_flags);
>>> +				if (WARN_ON_ONCE(!folio)) {
>>> +					/*
>>> +					 * Release the 1st page ref if the
>>> +					 * folio is problematic, fail hard.
>>> +					 */
>>> +					gup_put_folio(page_folio(page), 1,
>>> +						      foll_flags);
>>> +					ret = -EFAULT;
>>> +					goto out;
>>> +				}
>>> +			}
>>> +
>>> +			for (j = 0; j < page_increm; j++) {
>>> +				subpage = nth_page(page, j);
>>> +				pages[i+j] = subpage;
>>
>> Doe checkpatch like pages[i+j]? I'd have used spaces around the +.
> 
> Can do.
> 
>>
>>> +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
>>> +				flush_dcache_page(subpage);
>>> +			}
>>> +		}
>>> +
>>>    		i += page_increm;
>>>    		start += page_increm * PAGE_SIZE;
>>>    		nr_pages -= page_increm;
>>
>>
>> So, we did the first try_grab_folio() while our page was PMD-mapped udner
>> the PT lock and we had sufficient permissions (e.g., mapped writable, no
>> unsharing required). With FOLL_PIN, we incremented the pincount.
>>
>>
>> I was wondering if something could have happened ever since we unlocked the
>> PT table lock and possibly PTE-mapped the THP. ... but as it's already
>> pinned, it cannot get shared during fork() [will stay exclusive].
>>
>> So we can just take additional pins on that folio.
>>
>>
>> LGTM, although I do like the GUP-fast way of recording+ref'ing it at a
>> central place (see gup_huge_pmd() with record_subpages() and friends), not
>> after the effects.
> 
> My read on this is follow_page_mask() is also used in follow page, which
> does not need page*.

Right ... maybe one day we can do that "better".

> 
> No strong opinion here. Maybe we leave this as a follow up even if it can
> be justified?  This patch is probably still the smallest (and still clean)
> change to speed this whole thing up over either thp or hugetlb.

Sure, we can leave that as a follow-up.


Thinking about why we have the flush_anon_page/flush_dcache_page stuff 
here and not in GUP-fast ... I suspect that all GUP-fast archs don't 
need that stuff.

I was wondering if there are some possible races with the 
flush_anon_page() / flush_dcache_page() on a page that might have been 
unmapped in the meantime (as we dropped the PT lock ...).

Some flush_dcache_page() implementations do some IMHO confusing 
page_mapcount() things (like in arch/arc/mm/cache.c). But maybe the 
unmap code handles that as well ... and most likely these archs don't 
support THP.

Anyhow, just a note that the flush_anon_page/flush_dcache_page left me 
confused.

-- 
Cheers,

David / dhildenb

