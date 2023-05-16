Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9D704A93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEPKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjEPKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BC3A81
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684233027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iq39sUXrSgr2l8obnEcZ090uazUsP990dyTB+oV4fEk=;
        b=TiAGIkzEqBQa17wHEb9y06DPeNRNNH/wPjZiRd6LMe1TEWpQxleoimZw58iHbgwuo05nL8
        x1Io7Iliy8lhTDYacgZIkMmGnU7H67p+nSdDr/xECraOv3N5jDd6EL8BJL7DIo++l+wr77
        hc5BfWeErNqZl+NCEsarIMGFrPFv5vs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-ZKHYKTKuN1GDVe0Rjq8YzQ-1; Tue, 16 May 2023 06:30:24 -0400
X-MC-Unique: ZKHYKTKuN1GDVe0Rjq8YzQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3078df8ae31so6716477f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684233023; x=1686825023;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq39sUXrSgr2l8obnEcZ090uazUsP990dyTB+oV4fEk=;
        b=IiPHq7yv+0ILi7dBFCJW6TtuOx1nz0TVxYGG1GYrv35zWOhZ0ZFvqjP4B2PDzj74EY
         //yUgIHqMZRgCiOMyRpKUSKwNLr0jChUlwVSAeoD4KXWBl7ShZ7u8dZXtoXrh73iy+Rq
         yGS5Xb0YL12EwY9z5fOQf2HXo/bWjk1n5YFXkzI0jBbj8mUImjKGJficLEGStBnJM/E7
         UKUlJiGfykG8cj2Yi4k3AJlRLxFtpGVbDKa5oMfI3kE2JUPl1hUS9xxvQUP8L85N7RHA
         3+M01bspx39MSWUCswDU8qRnnsJz7fW1NP7nWgads1Q84JyL0ahUTYnOH6T5GvKUoany
         bNbA==
X-Gm-Message-State: AC+VfDzPGlSi0U0PidjzDUtxaYYLhzDt+ZvjxyLECkgOOQvPFrrGEkBr
        ePjopTJ07m+ZGCjWy5X3w1mS77y3bHWzwiQqR6JzTBv3epOLQCtpSa741VXN+vEkv0fyv9GVQkB
        ontFT32Ojh0wn1QtzwgKRGukk
X-Received: by 2002:adf:fe51:0:b0:306:42e2:5ec3 with SMTP id m17-20020adffe51000000b0030642e25ec3mr26763780wrs.6.1684233023531;
        Tue, 16 May 2023 03:30:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Hm1rCXma6b8CJBSSLmrti/ly1HQMw8e7ZRDf4rG9SNwDTOKQzq42xlHil4f+OEQJ7pQ60CQ==
X-Received: by 2002:adf:fe51:0:b0:306:42e2:5ec3 with SMTP id m17-20020adffe51000000b0030642e25ec3mr26763756wrs.6.1684233023118;
        Tue, 16 May 2023 03:30:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d6a05000000b0030631dcbea6sm2158557wru.77.2023.05.16.03.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:30:22 -0700 (PDT)
Message-ID: <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
Date:   Tue, 16 May 2023 12:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230511065607.37407-1-ying.huang@intel.com>
 <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
 <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
 <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
In-Reply-To: <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 11:38, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
>> On Fri 12-05-23 10:55:21, Huang, Ying wrote:
>>> Hi, Michal,
>>>
>>> Thanks for comments!
>>>
>>> Michal Hocko <mhocko@suse.com> writes:
>>>
>>>> On Thu 11-05-23 14:56:01, Huang Ying wrote:
>>>>> The patchset is based on upstream v6.3.
>>>>>
>>>>> More and more cores are put in one physical CPU (usually one NUMA node
>>>>> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
>>>>> Even more cores per physical CPU are planned for future CPUs.  While
>>>>> all cores in one physical CPU will contend for the page allocation on
>>>>> one zone in most cases.  This causes heavy zone lock contention in
>>>>> some workloads.  And the situation will become worse and worse in the
>>>>> future.
>>>>>
>>>>> For example, on an 2-socket Intel server machine with 224 logical
>>>>> CPUs, if the kernel is built with `make -j224`, the zone lock
>>>>> contention cycles% can reach up to about 12.7%.
>>>>>
>>>>> To improve the scalability of the page allocation, in this series, we
>>>>> will create one zone instance for each about 256 GB memory of a zone
>>>>> type generally.  That is, one large zone type will be split into
>>>>> multiple zone instances.  Then, different logical CPUs will prefer
>>>>> different zone instances based on the logical CPU No.  So the total
>>>>> number of logical CPUs contend on one zone will be reduced.  Thus the
>>>>> scalability is improved.
>>>>
>>>> It is not really clear to me why you need a new zone for all this rather
>>>> than partition free lists internally within the zone? Essentially to
>>>> increase the current two level system to 3: per cpu caches, per cpu
>>>> arenas and global fallback.
>>>
>>> Sorry, I didn't get your idea here.  What is per cpu arenas?  What's the
>>> difference between it and per cpu caches (PCP)?
>>
>> Sorry, I didn't give this much thought than the above. Essentially, we
>> have 2 level system right now. Pcp caches should reduce the contention
>> on the per cpu level and that should work reasonably well, if you manage
>> to align batch sizes to the workload AFAIK. If this is not sufficient
>> then why to add the full zone rather than to add another level that
>> caches across a larger than a cpu unit. Maybe a core?
>>
>> This might be a wrong way around going for this but there is not much
>> performance analysis about the source of the lock contention so I am
>> mostly guessing.
> 
> I guess that the page allocation scalability will be improved if we put
> more pages in the per CPU caches, or add another level of cache for
> multiple logical CPUs.  Because more page allocation requirements can be
> satisfied without acquiring zone lock.
> 
> As other caching system, there are always cases that the caches are
> drained and too many requirements goes to underlying slow layer (zone
> here).  For example, if a workload needs to allocate a huge number of
> pages (larger than cache size) in parallel, it will run into zone lock
> contention finally.  The situation will became worse and worse if we
> share one zone with more and more logical CPUs.  Which is the trend in
> industry now.  Per my understanding, we can observe the high zone lock
> contention cycles in kbuild test because of that.
> 
> So, per my understanding, to improve the page allocation scalability in
> bad situations (that is, caching doesn't work well enough), we need to
> restrict the number of logical CPUs that share one zone.  This series is
> an attempt for that.  Better caching can increase the good situations
> and reduce the bad situations.  But it seems hard to eliminate all bad
> situations.
> 
>  From another perspective, we don't install more and more memory for each
> logical CPU.  This makes it hard to enlarge the default per-CPU cache
> size.
> 
>>>> I am also missing some information why pcp caches tunning is not
>>>> sufficient.
>>>
>>> PCP does improve the page allocation scalability greatly!  But it
>>> doesn't help much for workloads that allocating pages on one CPU and
>>> free them in different CPUs.  PCP tuning can improve the page allocation
>>> scalability for a workload greatly.  But it's not trivial to find the
>>> best tuning parameters for various workloads and workload run time
>>> statuses (workloads may have different loads and memory requirements at
>>> different time).  And we may run different workloads on different
>>> logical CPUs of the system.  This also makes it hard to find the best
>>> PCP tuning globally.
>>
>> Yes this makes sense. Does that mean that the global pcp tuning is not
>> keeping up and we need to be able to do more auto-tuning on local bases
>> rather than global?
> 
> Similar as above, I think that PCP helps the good situations performance
> greatly, and splitting zone can help the bad situations scalability.
> They are working at the different levels.
> 
> As for PCP auto-tuning, I think that it's hard to implement it to
> resolve all problems (that is, makes PCP never be drained).
> 
> And auto-tuning doesn't sound easy.  Do you have some idea of how to do
> that?

If we could avoid instantiating more zones and rather improve existing 
mechanisms (PCP), that would be much more preferred IMHO. I'm sure it's 
not easy, but that shouldn't stop us from trying ;)

I did not look into the details of this proposal, but seeing the change 
in include/linux/page-flags-layout.h scares me. Further, I'm not so sure 
how that change really interacts with hot(un)plug of memory ... on a 
quick glimpse I feel like this series hacks the code such that such that 
the split works based on the boot memory size ...

I agree with Michal that looking into auto-tuning PCP would be 
preferred. If that can't be done, adding another layer might end up 
cleaner and eventually cover more use cases.

[I recall there was once a proposal to add a 3rd layer to limit 
fragmenation to individual memory blocks; but the granularity was rather 
small and there were also some concerns that I don't recall anymore]

-- 
Thanks,

David / dhildenb

