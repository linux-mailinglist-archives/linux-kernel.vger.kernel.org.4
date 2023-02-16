Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7F699C49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBPSZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581150370
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676571802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWYf6uwDdJF4QIYs2/bu2gRGokZrLCh3CJpX4c4E6+Q=;
        b=BY8ybM/q17JVDFWkgK1QHyOICX6GNl6+GVtVa5E0MwUgHBvsoCJ+TRFOjd2SiPGauTK/ls
        BkAX81mV+g5HxgTDjQGloWAwUFn5lMjIShubqTMlkLltyNje9QZSFauOzhBW7yldeK800n
        FHDqeicF9U8NC54DGsC4eSBBl3d+q3c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-4cP96xC_NWWLDq3HUbTasA-1; Thu, 16 Feb 2023 13:23:20 -0500
X-MC-Unique: 4cP96xC_NWWLDq3HUbTasA-1
Received: by mail-wm1-f69.google.com with SMTP id iz20-20020a05600c555400b003dc53fcc88fso1529615wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWYf6uwDdJF4QIYs2/bu2gRGokZrLCh3CJpX4c4E6+Q=;
        b=wIYHfs0sQKeYCjS1nf2skIeq6RnCEm/ram3VedrmvNHHBpY/fALfk5hW0lQn4CxSf9
         rSwG9/Ad1WvG3BBQp8sxEmqqEW19ly1GQ5U+3QZIL2z5uf2a1mb5DdqsZR63XMIgDHYb
         mJmdLikrkMgugy5I67aegZS37vFbrnuViQfIWWQhclLEdoPOUMxxNtr8kJ9smK4VsEvK
         VhMmM3nGny6eWF6qOXmO7TvUR51XjjVAL5cBwhcAw798BSgDMRFyeeaj4e5ewnL1jD+5
         IjVEuc15WZkwqShvUEDA7QyY5SMKE1XvDMUdFiajaqZbv1BEV6bmtf4Zeuak3VVT8EoX
         QNzA==
X-Gm-Message-State: AO0yUKVpxDG5mF/G/DfAn7RSxRI2HSIQ76ZUVbKBtcYA+pZ0ZVxnLQIo
        yvW4L+wAbHQYuHayahJLj47A9mIcpbi9KHMJEsEVTSvX3lvxLSucYvTJH0LNE/slrp+vkY+F1yq
        KjfDQz62sON/U8HfERT8kxnfu
X-Received: by 2002:a05:600c:3297:b0:3e2:1368:e395 with SMTP id t23-20020a05600c329700b003e21368e395mr2230717wmp.33.1676571799796;
        Thu, 16 Feb 2023 10:23:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+0HsERJWKVi8AxVYbvDm4aBT9HxNyDel3mKEO0+G/vEM+VI6/gqvJysriUe0m7a86YfBWvRQ==
X-Received: by 2002:a05:600c:3297:b0:3e2:1368:e395 with SMTP id t23-20020a05600c329700b003e21368e395mr2230703wmp.33.1676571799432;
        Thu, 16 Feb 2023 10:23:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id d21-20020a05600c34d500b003daffc2ecdesm6253751wmq.13.2023.02.16.10.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 10:23:18 -0800 (PST)
Message-ID: <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com>
Date:   Thu, 16 Feb 2023 19:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com> <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y+5uIS5E9sTLi41T@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 18:55, Peter Xu wrote:
> On Thu, Feb 16, 2023 at 06:00:51PM +0100, David Hildenbrand wrote:
>>>>
>>>> There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
>>>> PTE markers, would be more benficial:
>>>>
>>>> 1) It would be applicable to anon hugetlb
>>>
>>> Anon hugetlb should already work with non ptes with the markers?
>>>
>>
>> ... really? I thought we'd do the whole pte marker handling only when
>> dealing with hugetlb/shmem. Interesting, thanks. (we could skip population
>> in QEMU in that case as well -- we always do it for now)
> 
> Hmm, you're talking about "anon hugetlb", so it's still hugetlb, right? :)

I mean especially MAP_PRIVATE|MAP_HUGETLB|MAP_ANONYMOUS, so "in theory" 
without any fd and thus pagecache. ... but anon hugetlb keeps confusing 
me with pagecache handling.

>>
>>>> 2) It would be applicable even when the zeropage is disallowed
>>>>      (mm_forbids_zeropage())
>>>
>>> Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
>>> doesn't support s390 yet, I'm not sure whether we over worried on this
>>> effect.
>>>
>>> Or is there any other projects / ideas that potentially can enlarge forbid
>>> zero pages to more contexts?
>>
>> I think it was shown that zeropages can be used to build covert channels
>> (similar to memory deduplciation, because it effectively is memory
>> deduplication). It's mentioned as a note in [1] under VII. A. ("Only
>> Deduplicate Zero Pages.")
>>
>>
>> [1] https://www.ndss-symposium.org/wp-content/uploads/2022-81-paper.pdf
> 
> Thanks for the link.  I'm slightly confused how dedup of zero pages is a
> concern here, though.
> 
> IIUC the security risk is when the dedup-ed pages contain valid information
> so the attacker can measure latency of requests when the attemped malicious
> page contains exactly the same content of the data page, by trying to
> detect the CoW from happening. >
> Here it's the zero page, even if there's CoW difference the data being
> exposed can only be all zeros?  Then what's the risk?

The focus of that paper is on CoW latency yes (and deduplication 
instantiating shared zeropages -- but building a covert channel using 
CoW latency might be rather tricky I think, because they will get 
deduplciated independently of a sender action ...).

However, in theory, one could build a covert channel between two VMs 
simply by using cache flushes and reading from the shared zeropage. 
Measuring access time can reveal if the sender read the page (L3 filled) 
or not (L3 not filled).

Having that said, I don't think that we are going to disable the shared 
zeropage because of that for some workloads, I assume in most cases it 
will simply be way too noisy to transmit any kind of data and we have 
more critical covert channels to sort out if we want to.

Just wanted to raise it because you asked :)

> 
> Another note for s390: when it comes we can consider moving to pte markers
> conditionally when !zeropage.  But we can leave that for later.

Sure, we could always have another feature flag.

> 
>>
>>>
>>>> 3) It would be possible to optimize even without the huge zeropage, by
>>>>      using a PMD marker.
>>>
>>> This patch doesn't need huge zeropage being exist.
>>
>> Yes, and for that reason I think it may perform worse than what we already
>> have in some cases. Instead of populating a single PMD you'll have to fill a
>> full PTE table.
> 
> Yes.  If you think that'll worth it, I can conditionally do pmd zero thp in
> a new version.  Maybe it will be a good intermediate step between
> introducing pte markers to pmd/pud/etc, so at least we don't need other
> changes to coordinate pte markers to higher levels.

[...]

>>>> Especially when uffd-wp'ing large ranges that are possibly all unpopulated
>>>> (thinking about the existing VM background snapshot use case either with
>>>> untouched memory or with things like free page reporting), we might neither
>>>> be reading or writing that memory any time soon.
>>>
>>> Right, I think that's a trade-off. But I still think large portion of
>>> totally unpopulated memory should be rare case rather than majority, or am
>>> I wrong?  Not to mention that requires a more involved changeset to the
>>> kernel.
>>>
>>> So what I proposed here is the (AFAIU) simplest solution towards providing
>>> such a feature in a complete form.  I think we have chance to implement it
>>> in other ways like pte markers, but that's something we can work upon, and
>>> so far I'm not sure how much benefit we can get out of it yet.
>>>
>>
>> What you propose here can already be achieved by user space fairly easily
>> (in fact, QEMU implementation could be further sped up using
>> MADV_POPULATE_READ). Usually, we only do that when there are very good
>> reasons to (performance).
> 
> Yes POPULATE_READ will be faster.  This patch should make it even faster,
> because it merges the two walks.
> 

Getting some performance numbers would be nice.

>>
>> Using PTE markers would provide a real advantage IMHO for some users (IMHO
>> background snapshots), where we might want to avoid populating
>> zeropages/page tables as best as we can completely if the VM memory is
>> mostly untouched.
>>
>> Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is there
>> is another good reason to combine the populate zeropage+wp that I am missing
>> (e.g., atomicity by doing both in one operation)?
> 
> It also makes the new WP_ASYNC and pagemap interface clean: we don't want
> to have user pre-fault it every time too as a common tactic..  It's hard to
> use, and the user doesn't need to know the internals of why it is needed,
> either.

I feel like we're building a lot of infrastructure on uffd-wp instead of 
having an alternative softdirty mode (using a world switch?) that works 
as expected and doesn't require that many uffd-wp extensions. ;)

Having that said, I have the feeling that you and Muhammad have a plan 
to make it work using uffd-wp and I won't interfere. It would be nicer 
to use softdirty infrastructure IMHO, though.

> 
> The other thing is it provides a way to make anon and !anon behave the same
> on empty ptes; it's a pity that it was not already like that.

In an ideal world, we'd simply be using PTE markers unconditionally I 
think and avoid this zeropage feature :/

Is there any particular reason to have UFFD_FEATURE_WP_ZEROPAGE and not 
simply always do that unconditionally? (sure, we have to indicate to 
user space that it now works as expected) Are we really expecting to 
break user space by protecting what was asked for to protect?

> 
> We can always optimize this behavior in the future with either
> PMD/PUD/.. pte markers as you said, but IMHO that just needs further
> justification on the complexity, and also on whether that's beneficial to
> the majority to become the default behavior.

As I said, usually any new features require good justification. Maybe 
there really is a measurable performance gain (less syscalls, less 
pgtable walks).

> 
> The worst case (if anyone would like that behavior) is we can have another
> feature bit making decision of that behavior, but that'll be something on
> top.

Right.

-- 
Thanks,

David / dhildenb

