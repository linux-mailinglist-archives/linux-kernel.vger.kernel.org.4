Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5528674B00E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjGGLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BE170F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688730057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B42AZOQjOcVF/Y0j7fMumdgD1JfYw1Jno81BLnsFXtE=;
        b=E5S7DvcdtJXwUCsX5ztKp6kcht8lnHs3AiRtY/GAoc7w1haYg0ByzOkMtJpv8vzhp7CR4h
        ndljfaVxPY7m9kN8xNSmv1JeeAztIyJZt9zqa372/P7kRFUhekIdJ4PSJFbP8n5r1Gx4M1
        TNCGXCoKyi+SWT4DAkFYkW9RFRWmwpU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-xPOV0Ir4PoSDZaQSrMjiqg-1; Fri, 07 Jul 2023 07:40:56 -0400
X-MC-Unique: xPOV0Ir4PoSDZaQSrMjiqg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so10715725e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688730055; x=1691322055;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B42AZOQjOcVF/Y0j7fMumdgD1JfYw1Jno81BLnsFXtE=;
        b=JuIfO3LUwWowqpOiD9Dqngkikg0ZE6hjuZvSh5hsir+rNXlWnckmRwPfSZVJedDO+6
         AE19ns4uXrlUP5mHca7ghkXg1a6InCZmc1W30WT5rTpmVCDGpBAQI3yrz0eElT5tAyF9
         S6qugQ7MnFCPWO3BW/HVe2O9RFLHNQ4i095UgWDuiB7ZpPaOWkkUn+eEnpa63r3e4g4g
         H2UWSmo6qZ1cCZjZXIletrKD/nW/r3pRh/uHr4oPSVVFKJhgNxsxLK931fpgRrkKUBgQ
         33UuWCUmiqaCtRtdQwk4C3V5RWHdbyxQ2FzWdagjJT9gNQsy5NUNQa8XjSXDkr02nUjr
         7FmQ==
X-Gm-Message-State: ABy/qLacsS8stK7C9z+8teDrzlMGyoNqKPRMZOAPzqK12pUb0FlJ023t
        r2T16+RR84Bz/zHfnc996cbf8pXorh051eOrL/z7g2/R43OJ6QH/GfhUaz99IutV1lrf8+5O94d
        FSpTIa2j1Ia8DXwto+YSMO9tB
X-Received: by 2002:a05:600c:2901:b0:3fb:e189:3532 with SMTP id i1-20020a05600c290100b003fbe1893532mr3613106wmd.20.1688730055295;
        Fri, 07 Jul 2023 04:40:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2u5GKvVIRg71UDKdc/YaTynxzfOeVJPhDExv67pRdggkX9UXBnpHZW0fkzXhIX/EU8tjPNA==
X-Received: by 2002:a05:600c:2901:b0:3fb:e189:3532 with SMTP id i1-20020a05600c290100b003fbe1893532mr3613084wmd.20.1688730054926;
        Fri, 07 Jul 2023 04:40:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003fbe791a0e8sm2299013wmj.0.2023.07.07.04.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 04:40:54 -0700 (PDT)
Message-ID: <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
Date:   Fri, 7 Jul 2023 13:40:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
In-Reply-To: <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.23 10:02, Ryan Roberts wrote:
> On 05/07/2023 20:38, David Hildenbrand wrote:
>> On 03.07.23 15:53, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> This is v2 of a series to implement variable order, large folios for anonymous
>>> memory. The objective of this is to improve performance by allocating larger
>>> chunks of memory during anonymous page faults. See [1] for background.
>>>
> 
> [...]
> 
>>> Thanks,
>>> Ryan
>>
>> Hi Ryan,
>>
>> is page migration already working as expected (what about page compaction?), and
>> do we handle migration -ENOMEM when allocating a target page: do we split an
>> fallback to 4k page migration?
>>
> 
> Hi David, All,

Hi Ryan,

thanks a lot for the list.

But can you comment on the page migration part (IOW did you try it already)?

For example, memory hotunplug, CMA, MCE handling, compaction all rely on 
page migration of something that was allocated using GFP_MOVABLE to 
actually work.

Compaction seems to skip any higher-order folios, but the question is if 
the udnerlying migration itself works.

If it already works: great! If not, this really has to be tackled early, 
because otherwise we'll be breaking the GFP_MOVABLE semantics.

> 
> This series aims to be the bare minimum to demonstrate allocation of large anon
> folios. As such, there is a laundry list of things that need to be done for this
> feature to play nicely with other features. My preferred route is to merge this
> with it's Kconfig defaulted to disabled, and its Kconfig description clearly
> shouting that it's EXPERIMENTAL with an explanation of why (similar to
> READ_ONLY_THP_FOR_FS).
As long as we are not sure about the user space control and as long as 
basic functionality is not working (example, page migration), I would 
tend to not merge this early just for the sake of it.

But yes, something like mlock can eventually be tackled later: as long 
as there is a runtime interface to disable it ;)

> 
> That said, I've put together a table of the items that I'm aware of that need
> attention. It would be great if people can review and add any missing items.
> Then we can hopefully parallelize the implementation work. David, I don't think
> the items you raised are covered - would you mind providing a bit more detail so
> I can add them to the list? (or just add them to the list yourself, if you prefer).
> 
> ---
> 
> - item:
>      mlock
> 
>    description: >-
>      Large, pte-mapped folios are ignored when mlock is requested. Code comment
>      for mlock_vma_folio() says "...filter out pte mappings of THPs, which
>      cannot be consistently counted: a pte mapping of the THP head cannot be
>      distinguished by the page alone."
> 
>    location:
>      - mlock_pte_range()
>      - mlock_vma_folio()
> 
>    assignee:
>      Yin, Fengwei
> 
> 
> - item:
>      numa balancing
> 
>    description: >-
>      Large, pte-mapped folios are ignored by numa-balancing code. Commit
>      comment (e81c480): "We're going to have THP mapped with PTEs. It will
>      confuse numabalancing. Let's skip them for now."
> 
>    location:
>      - do_numa_page()
> 
>    assignee:
>      <none>
> 
> 
> - item:
>      madvise
> 
>    description: >-
>      MADV_COLD, MADV_PAGEOUT, MADV_FREE: For large folios, code assumes
>      exclusive only if mapcount==1, else skips remainder of operation. For
>      large, pte-mapped folios, exclusive folios can have mapcount upto nr_pages
>      and still be exclusive. Even better; don't split the folio if it fits
>      entirely within the range? Discussion at
> 
> https://lore.kernel.org/linux-mm/6cec6f68-248e-63b4-5615-9e0f3f819a0a@redhat.com/
>      talks about changing folio mapcounting - may help determine if exclusive
>      without pgtable scan?
> 
>    location:
>      - madvise_cold_or_pageout_pte_range()
>      - madvise_free_pte_range()
> 
>    assignee:
>      <none>
> 
> 
> - item:
>      shrink_folio_list
> 
>    description: >-
>      Raised by Yu Zhao; I can't see the problem in the code - need
>      clarification
> 
>    location:
>      - shrink_folio_list()
> 
>    assignee:
>      <none>
> 
> 
> - item:
>      compaction
> 
>    description: >-
>      Raised at LSFMM: Compaction skips non-order-0 pages. Already problem for
>      page-cache pages today. Is my understand correct?
> 
>    location:
>      - <where?>
> 
>    assignee:
>      <none>

I'm still thinking about the whole mapcount thingy (and I burned way too 
much time on that yesterday), which is a big item for such a list and 
affects some of these items.

A pagetable scan is pretty much irrelevant for order-2 pages. But once 
we're talking about higher orders we really don't want to do that.

I'm preparing a writeup with users and challenges.


Is swapping working as expected? zswap?

-- 
Cheers,

David / dhildenb

