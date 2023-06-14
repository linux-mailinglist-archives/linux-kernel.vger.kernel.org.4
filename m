Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F7730422
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbjFNPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFNPsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8CEA1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686757657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bW8qcFrRQFmvEEYodNH2D88CTYW+Ip8JaHIZ5ITPGk=;
        b=YoFdcT3V/b22PTkv2A/iIfZG8KTNDUvcYGvf96ha850RhE48EetMmFRvjcoWrXTPG768GQ
        HnG57uNudyuvGdiJC+lhkZIBBnaS7fBnc3sAaPpzveUt7moyrgGC7Ly1LcAEMkTcVKpAfg
        sLaM4I4HlYZVE/ZE6Lmt7kZML4HaV6g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-4hTVIxJMOguQKXTLCZV6IA-1; Wed, 14 Jun 2023 11:47:35 -0400
X-MC-Unique: 4hTVIxJMOguQKXTLCZV6IA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7ef2456dfso3683435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757654; x=1689349654;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bW8qcFrRQFmvEEYodNH2D88CTYW+Ip8JaHIZ5ITPGk=;
        b=NC3PZVhLpNGkSTRVCkj34hS2yWcDnn6Uk6IfWb29qDGoXYjdtyEGD2HI53VSdRWCC+
         eSSgVIGqsmgTB8QlrjmBJChBghzfkS6r9kRYg0xHBj8yPOrYZTgTKQgyZEzhq4XTlHv3
         GMrBQYnXnEf84KWKWLWe72Ke5r2V3p11KTeuSOFGH0Ydq5JWHpvFSGRjlzHavzV/G8TM
         4+hAcO5FW0T0ydtvJBl5X6rifmkGXcmuy1BqpD3EgNn73HWiGewlK/P6NfFET6IHSiq0
         0rsxQsZIvJGrIZp+Nwa5wfTruG/pF6CeF5ZecUMS8H222JPh7/qNhB597zdVvP3Awt+T
         lT+w==
X-Gm-Message-State: AC+VfDzdUiMd+J9i6Cnqfj3czvPx6CxAsj9NDI/mosoycdt4q6okrT1X
        QqLoI+KrPTapqsSdv66obETLDezG80I4iZVif4MD9IbAQP9PK69BIFE3NHmAB9TuvAJxylup3AZ
        G/qHrhg8HVwGZnp7wku6Ee1ne
X-Received: by 2002:a1c:f70a:0:b0:3f5:1728:bde9 with SMTP id v10-20020a1cf70a000000b003f51728bde9mr10045596wmh.2.1686757653912;
        Wed, 14 Jun 2023 08:47:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vMyBEpvendEjmQQmDpIA7ahOUPL61Q5ZmleywrLEPvlNH9zFyI/8J+qQq+DFBveSCxMebSA==
X-Received: by 2002:a1c:f70a:0:b0:3f5:1728:bde9 with SMTP id v10-20020a1cf70a000000b003f51728bde9mr10045570wmh.2.1686757653365;
        Wed, 14 Jun 2023 08:47:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c22d100b003f8044b3436sm17453217wmg.23.2023.06.14.08.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:47:32 -0700 (PDT)
Message-ID: <38574ed3-ea96-a72e-00dd-4e6204413a86@redhat.com>
Date:   Wed, 14 Jun 2023 17:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com> <ZInYh3cVUil9R/cf@x1n>
 <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com> <ZIndN9isc4pTp2zK@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZIndN9isc4pTp2zK@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 17:31, Peter Xu wrote:
> On Wed, Jun 14, 2023 at 05:17:13PM +0200, David Hildenbrand wrote:
>> On 14.06.23 17:11, Peter Xu wrote:
>>> On Wed, Jun 14, 2023 at 04:57:37PM +0200, David Hildenbrand wrote:
>>>> On 13.06.23 23:53, Peter Xu wrote:
>>>>> It's coming, not yet, but soon.  Loose the restriction.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>     mm/hugetlb.c | 7 -------
>>>>>     1 file changed, 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index f037eaf9d819..31d8f18bc2e4 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -6467,13 +6467,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>>>>>     	spinlock_t *ptl;
>>>>>     	pte_t *pte, entry;
>>>>> -	/*
>>>>> -	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
>>>>> -	 * follow_hugetlb_page().
>>>>> -	 */
>>>>> -	if (WARN_ON_ONCE(flags & FOLL_PIN))
>>>>> -		return NULL;
>>>>> -
>>>>>     	hugetlb_vma_lock_read(vma);
>>>>>     	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
>>>>>     	if (!pte)
>>>> Did you fix why the warning was placed there in the first place? (IIRC, at
>>>> least unsharing support needs to be added, maybe more)
>>>
>>> Feel free to have a look at patch 2 - it should be done there, hopefully in
>>> the right way.  And IIUC it could be a bug to not do that before (besides
>>> CoR there was also the pgtable permission checks that was missing).  More
>>> details in patch 2's commit message.  Thanks,
>>
>> Oh, that slipped my eyes (unsharing is not really a permission check) -- and
> 
> I think it is still a "permission check"?  It means, we forbid anyone R/O
> taking the page if it's not exclusively owned, just like we forbid anyone
> RW taking the page if it's not writable?

Agreed, just not in the traditional PTE-protection case.

> 
> It's just that the permission check only applies to PIN which follow_page()
> doesn't yet care, so it won't ever trigger.
> 
>> the patch description could have been more explicit about why we can now
>> lift the restrictions.
>>
>> For the records: we don't use CoR terminology upstream. As suggested by
>> John, we use "GUP-triggered unsharing".
> 
> Sure.
> 
>>
>> As unsharing only applies to FOLL_PIN, it doesn't quite fit into patch #2.
>> Either move that to this patch or squash both.
> 
> Sure, no strong opinions here.
> 
> The plan is _if_ someone wants to backport patch 2, this patch should not
> be part of it.  But then maybe it makes more sense to move the CoR change
> there into this one, not because "it's not permission check", but because
> CoR is not relevant in follow_page(), so not relevant to a backport.

Right. Then just call patch #2 "Add missing write-permission check" and 
this patch "Support FOLL_PIN in hugetlb_follow_page_mask()" or sth. like 
that.

Regarding the backport, I really wonder if patch #2 is required at all, 
because I didn't sport any applicable FOLL_WRITE users. Maybe there were 
some? Hm. If it's not applicable, a single "Support FOLL_PIN in 
hugetlb_follow_page_mask()" patch might be cleanest.

-- 
Cheers,

David / dhildenb

