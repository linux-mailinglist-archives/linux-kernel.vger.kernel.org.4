Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F84A71470A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjE2J01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2J0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C4AC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685352343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj2qXiEWFeMturc9uGJf6ztAEEy4dq2p+Uw4dRrFm4Q=;
        b=aDfooA5KPYd41knswQfrQMEHXpfWtOevXEJxDpnw/xGCaaEkyvCxRQcukkDXuDYq+rIuqT
        4Ipjwc8DP79Q0Qo+1WjctQ37zHEWJKENXTeOvnFKdy8dzdQ2CXeue3dGXnDfEhsYcoV4ly
        7bhxysC/GvG29f8evn2XD0n/iiwyZTM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-NXLBL4kSPQG9Le26x_OE3g-1; Mon, 29 May 2023 05:25:42 -0400
X-MC-Unique: NXLBL4kSPQG9Le26x_OE3g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6f58e269eso12196695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685352341; x=1687944341;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj2qXiEWFeMturc9uGJf6ztAEEy4dq2p+Uw4dRrFm4Q=;
        b=hVgz2pJ6otlfE9KALeDxTlRFkzFZExkzCY+zXNBGVUrF0SPX1VQl0QYf4gn3TSbwgV
         4PvWWJKzMmwtWITbJ05aNOb2ItvHhPbVuCLdMNi1rWYYeDtfxo0jWJnNNknIOgo7zHAU
         kF0TuHqbcMfjPt7RzXgwkpg8oHUUucb0gklsxcjZR0xm4RZV1WHCwOwXToPc+W9utzHt
         rIcB9QYNXNlSeFLf0RQamOSyfHducnU/z34VD9m3VoV7Oe01AJAeMm59J+LwTpRO1Tri
         WcAwycxjkkDAuGajO/11HXRuUryYdcG42fLj+yXj3MfXGy8Qk+kGTO6GQgcPyOrcRLaC
         Ko6A==
X-Gm-Message-State: AC+VfDw3wUP5b4ZMXLAVHRtxBIZlkvt81De+B3wHiZsrLmSQIso1y0Qk
        mqgabSGWPHjgUidd7GMKxAsvavYnK35YId/IjfjFGgf41FU1e47GhmIQcb9IlGXRKzdIQAOD6Y3
        LRxvTIuBin5tDKdkq3VcTKint
X-Received: by 2002:a1c:7211:0:b0:3f6:cfc7:8bd0 with SMTP id n17-20020a1c7211000000b003f6cfc78bd0mr9676805wmc.36.1685352341030;
        Mon, 29 May 2023 02:25:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yPlygRj+fmkALsPX+gGK9yhyCvUZvlYvF7gEiRn8SuazY42oBGYjGdb39uc+kffq2bG3MBw==
X-Received: by 2002:a1c:7211:0:b0:3f6:cfc7:8bd0 with SMTP id n17-20020a1c7211000000b003f6cfc78bd0mr9676786wmc.36.1685352340652;
        Mon, 29 May 2023 02:25:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id q1-20020a1ce901000000b003f423dfc686sm13416038wmc.45.2023.05.29.02.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 02:25:40 -0700 (PDT)
Message-ID: <4d035744-271d-1ca3-a440-f8b1573eec96@redhat.com>
Date:   Mon, 29 May 2023 11:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
 <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
 <ZHDh4Jeb/vKY+nGU@casper.infradead.org>
 <f5a37f8d-d888-9085-2f2b-1e350a267396@redhat.com>
 <ZHD+eOMpZpWXNAig@casper.infradead.org>
 <e31cd404-56ce-4cad-fcc3-3a6695f750fa@redhat.com>
 <846b770c-9f63-90a2-0435-ec82484e3f74@nvidia.com>
 <ZHF2byaRlaX3W6Md@casper.infradead.org>
 <9821bd9c-7c30-8f0c-68e4-6b1d312bc032@nvidia.com>
 <ZHPydXSAfRq8sh0u@casper.infradead.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
In-Reply-To: <ZHPydXSAfRq8sh0u@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.23 02:31, Matthew Wilcox wrote:
> On Sun, May 28, 2023 at 04:49:52PM -0700, John Hubbard wrote:
>> On 5/26/23 20:18, Matthew Wilcox wrote:
>>> On Fri, May 26, 2023 at 07:11:05PM -0700, John Hubbard wrote:
>>>>> So any user with 1024 processes can fragment physical memory? :/
>>>>>
>>>>> Sorry, I'd like to minimize the usage of folio_maybe_dma_pinned().
>>>>
>>>> I was actually thinking that we should minimize any more cases of
>>>> fragile mapcount and refcount comparison, which then leads to
>>>> Matthew's approach here!
>>>
>>> I was wondering if we shouldn't make folio_maybe_dma_pinned() a little
>>> more accurate.  eg:
>>>
>>>           if (folio_test_large(folio))
>>>                   return atomic_read(&folio->_pincount) > 0;
>>> 	return (unsigned)(folio_ref_count(folio) - folio_mapcount(folio)) >=
>>> 			GUP_PIN_COUNTING_BIAS;
>>
>> I'm trying to figure out what might be wrong with that, but it seems
>> OK. We must have talked about this earlier, but I recall vaguely that
>> there was not a lot of concern about the case of a page being mapped
>>> 1024 times. Because pinned or not, it's likely to be effectively
>> locked into memory due to LRU effects. As mentioned here, too.
> 
> That was my point of view, but David convinced me that a hostile process
> can effectively lock its own memory into place.
> 

1) My opinion on this optimization

Before I start going into detail, let me first phrase my opinion so we 
are on the same page:

"a tiny fraction of Linux installations makes heavy use of long-term 
pinning -- the *single* mechanism that completely *destroys* the whole 
purpose of memory compaction -- and the users complain about memory 
compaction overhead. So we are talking about optimizing for that by 
eventually harming *everybody else*."

Ehm ... I'm all for reasonable optimization, but not at any price.

We don't care about a handful of long-term pinned pages in the system, 
this is really about vfio long-term pinning a significant amount of 
system RAM, and we only care about shmem here.


*maybe* there is an issue with page migration when we have many page 
mappings, but (a) it's a separate issue and to be dealt with separately, 
not buried into such checks (b) it's unclear how many page mappings are 
too many, the magic number 1024 is just a random number (c) it needs 
much finer control (hostile processes).


2) mapcount vs. pagecount

Now, doing these mapcount vs. pagecount checks is perfectly reasonable 
(see mm/ksm.c) as long as know what we're doing. For example, we have to 
make sure that a possible compound page cannot get split concurrently 
(e.g., hold a reference). It's been used forever, I consider it stable.

I completely agree that we should be careful with such mapcount vs. 
pagecount checks, and if we can use something better, let's use 
something *better*.


3) page_maybe_dma_pinned()

Now, why do I dislike bringing up page_maybe_dma_pinned() [IOW, why is 
it not better]? Besides it ignoring FOLL_GET for now, that might be 
fixed at some point.

I think we agree that order-0 pages are the problem, because we get 
guaranteed false positives with many mappings (not just on speculative 
page pinnings). For these order-0 pages, it's perfectly reasonable to 
check page_maybe_dma_pinned() *as long as* we know the number of 
mappings is very small.

I don't consider anon pages the issue here, we barely get 1024 mappings 
(not even with KSM), and it's much harder to exploit because you cannot 
simply get new mappings via mmap(), only via fork().

In fact, we could optimize easily for order-0 anon pages if we'd need 
to: I have a patch lying around, it just wasn't really worth it for now, 
because there is only a single relevant page_maybe_dma_pinned() call in 
vmscan that could benefit:

https://github.com/davidhildenbrand/linux/commit/0575860d064694d4e2f307b2c20a880a6a7b59ab

We cannot do the same for pagecache pages, so we would possibly 
introduce harm by carelessly checking page_maybe_dma_pinned() on pages
with many mappings.


4) folio_maybe_dma_longterm_pinned() ?

I thought yesterday if we'd want something like 
folio_maybe_dma_longterm_pinned() here. Essentially using what we 
learned about long-term pinning of fs pages:

(1) ZONE_MOVABLE, MIGRATE_CMA -> "return false;"
(2) If !anon, !hugetlb, !shmem -> "return false;"
(3) "return folio_maybe_dma_pinned()"

Yes, above would easily create false-positives for short-term pinned 
pages (anon/hugetlb/shmem), but would never create false-positives for 
any other page (shared library ...).


We would use it in the following way:

bool skip_folio_in_isolation()
{
	/*
          * Avoid skipping pages that are short-term pinned, the pin
	 * might go away any moment and we'll succeed to migrate.
          *
          * We get false positives for short-term pinned anon, shmem and
          * hugetl pages for now, but such short-term pins are transient.
          */
	if (!folio_maybe_dma_longterm_pinned())
		return false;
         /*
          * order-0 pages with many mappings can easily be confused
          * for pinned pages and this could be exploited by
          * malicious user-space to cause fragmentation. This is only
          * an optimization, so if a page (especially shmem) is mapped
          * many times, we'll rather try migrating it instead of
          * accidentally skipping it all the time.
          */
	return folio_order(folio) != 0 || && total_mappings <= 32)
}

Someone long-term pins an shmem page with many mappings? Too bad, we 
don't optimize for that and still try migrating it.


BUT, I am still confused if we want to check here for "any additional 
references", which is what mapcount vs. refcount is, or 
folio_maybe_dma_longterm_pinned().

Of course, we could similarly write a variant of skip_folio_in_isolation:

bool skip_folio_in_isolation()
{
	/*
          * If a page is not pinned, try migrating it. Note that this
          * does not consider any FOLL_GET used for DMA yet.
          */
	if (!folio_maybe_dma_pinned())
		return false;
         /*
          * order-0 pages with many mappings can easily be confused
          * for pinned pages and this could be exploited by
          * malicious user-space to cause fragmentation. This is only
          * an optimization, so if a page is mapped
          * many times, we'll rather try migrating it instead of
          * accidentally skipping it all the time.
          */
	return folio_order(folio) != 0 || && total_mappings <= 32)
}


As long as FOLL_GET is still used for DMA, the mapcount vs. pagecount 
checks might be better ... but it depends on if we care about short-term 
or long-term pinned pages here.

>> Anyway, sure.
>>
>> A detail:
>>
>> The unsigned cast, I'm not sure that helps or solves anything, right?
>> That is, other than bugs, is it possible to get refcount < mapcount?

BUG IMHO.

>>
>> And if it's only due to bugs, then the casting, again, isn't likely to
>> going to mitigate the fallout from whatever mess the bug caused.
> 
> I wasn't thinking too hard about the cast.  If the caller has the folio
> lock, I don't think it's possible for refcount < mapcount.  This caller
> has a refcount, but doesn't hold the lock, so it is possible for them
> to read mapcount first, then have both mapcount and refcount decremented
> and see refcount < mapcount.
> 
> I don't think it matters too much.  We don't hold the folio lock, so
> it might transition from pinned to unpinned as much as a refcount might
> be decremented or a mapcount incremented.  What's important is that a
> hostile process can't prevent memory from being moved indefinitely.
> 
> David, have I missed something else?


What I learned from staring at the code in mm/ksm.c:write_protect_page() 
for too long a while ago is that:

(1) Mapping a page first increments the refcount, then the mapcount
(2) Unmapping a page first decrements the mapcount, then the refcount

So the mapcount is supposed to be always larger than the refcount. 
Especially, if you take a snapshot of both (read first the mapcount, 
then the mapcount).

A hostile process wouldn't be able to block compaction here forever, 
even if we accidentally would make the wrong call once when deciding 
whether to isolate a page. It would work on the next attempt.

That's the difference to page_maybe_dma_pinned(), which can be made to 
consistently block compaction.


[sorry for the lengthy mail]

-- 
Thanks,

David / dhildenb

