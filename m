Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2C705C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjEQBfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEQBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:35:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0363C00
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684287306; x=1715823306;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ImR7ZnaQnpW+4Q+UfaZGHlylZoHSYNv3hrclv8er6LE=;
  b=MMC+CbEtdWHm/l2a1qhAXEhXNJi6ymCt7Gozj3ZjMt1GmRbdxBm7OysQ
   NsJlZ+Grak3Busdkv4yxD0omKwlVXowP+POfRZZMBMVVXYAgqGXInXVfT
   dqIVPUP8JlOdFV6RlaAjTJ4w0G6IXXslMeo3LflJtV6iFTa75g26zYGto
   lGhtQazfEAzDEIlNy+wIgUe2gYcHjC7RtieldutzJgSyy7oDuDHAIE6Cd
   2+OHqiEe833qEh4K6LazHdcUkh8XZYU7AxV2l+ajU7b/T2XJs4iR4bqex
   JPiWyZqhbdNtn3Csaqj+YOOOapMe70NZ7Xd3Lp7xcYwL8y1MF2qvrL95l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415044329"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="415044329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="845893594"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="845893594"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:35:03 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] mm: improve page allocator scalability via splitting
 zones
References: <20230511065607.37407-1-ying.huang@intel.com>
        <ZF0ET82ajDbFrIw/@dhcp22.suse.cz>
        <87r0rm8die.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZGIUEqhSydAdvRFN@dhcp22.suse.cz>
        <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com>
Date:   Wed, 17 May 2023 09:34:00 +0800
In-Reply-To: <3d77ca46-6256-7996-b0f5-67c414d2a8dc@redhat.com> (David
        Hildenbrand's message of "Tue, 16 May 2023 12:30:21 +0200")
Message-ID: <87bkij7ncn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 16.05.23 11:38, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>>> On Fri 12-05-23 10:55:21, Huang, Ying wrote:
>>>> Hi, Michal,
>>>>
>>>> Thanks for comments!
>>>>
>>>> Michal Hocko <mhocko@suse.com> writes:
>>>>
>>>>> On Thu 11-05-23 14:56:01, Huang Ying wrote:
>>>>>> The patchset is based on upstream v6.3.
>>>>>>
>>>>>> More and more cores are put in one physical CPU (usually one NUMA node
>>>>>> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
>>>>>> Even more cores per physical CPU are planned for future CPUs.  While
>>>>>> all cores in one physical CPU will contend for the page allocation on
>>>>>> one zone in most cases.  This causes heavy zone lock contention in
>>>>>> some workloads.  And the situation will become worse and worse in the
>>>>>> future.
>>>>>>
>>>>>> For example, on an 2-socket Intel server machine with 224 logical
>>>>>> CPUs, if the kernel is built with `make -j224`, the zone lock
>>>>>> contention cycles% can reach up to about 12.7%.
>>>>>>
>>>>>> To improve the scalability of the page allocation, in this series, we
>>>>>> will create one zone instance for each about 256 GB memory of a zone
>>>>>> type generally.  That is, one large zone type will be split into
>>>>>> multiple zone instances.  Then, different logical CPUs will prefer
>>>>>> different zone instances based on the logical CPU No.  So the total
>>>>>> number of logical CPUs contend on one zone will be reduced.  Thus the
>>>>>> scalability is improved.
>>>>>
>>>>> It is not really clear to me why you need a new zone for all this rather
>>>>> than partition free lists internally within the zone? Essentially to
>>>>> increase the current two level system to 3: per cpu caches, per cpu
>>>>> arenas and global fallback.
>>>>
>>>> Sorry, I didn't get your idea here.  What is per cpu arenas?  What's the
>>>> difference between it and per cpu caches (PCP)?
>>>
>>> Sorry, I didn't give this much thought than the above. Essentially, we
>>> have 2 level system right now. Pcp caches should reduce the contention
>>> on the per cpu level and that should work reasonably well, if you manage
>>> to align batch sizes to the workload AFAIK. If this is not sufficient
>>> then why to add the full zone rather than to add another level that
>>> caches across a larger than a cpu unit. Maybe a core?
>>>
>>> This might be a wrong way around going for this but there is not much
>>> performance analysis about the source of the lock contention so I am
>>> mostly guessing.
>> I guess that the page allocation scalability will be improved if we
>> put
>> more pages in the per CPU caches, or add another level of cache for
>> multiple logical CPUs.  Because more page allocation requirements can be
>> satisfied without acquiring zone lock.
>> As other caching system, there are always cases that the caches are
>> drained and too many requirements goes to underlying slow layer (zone
>> here).  For example, if a workload needs to allocate a huge number of
>> pages (larger than cache size) in parallel, it will run into zone lock
>> contention finally.  The situation will became worse and worse if we
>> share one zone with more and more logical CPUs.  Which is the trend in
>> industry now.  Per my understanding, we can observe the high zone lock
>> contention cycles in kbuild test because of that.
>> So, per my understanding, to improve the page allocation scalability
>> in
>> bad situations (that is, caching doesn't work well enough), we need to
>> restrict the number of logical CPUs that share one zone.  This series is
>> an attempt for that.  Better caching can increase the good situations
>> and reduce the bad situations.  But it seems hard to eliminate all bad
>> situations.
>>  From another perspective, we don't install more and more memory for
>> each
>> logical CPU.  This makes it hard to enlarge the default per-CPU cache
>> size.
>> 
>>>>> I am also missing some information why pcp caches tunning is not
>>>>> sufficient.
>>>>
>>>> PCP does improve the page allocation scalability greatly!  But it
>>>> doesn't help much for workloads that allocating pages on one CPU and
>>>> free them in different CPUs.  PCP tuning can improve the page allocation
>>>> scalability for a workload greatly.  But it's not trivial to find the
>>>> best tuning parameters for various workloads and workload run time
>>>> statuses (workloads may have different loads and memory requirements at
>>>> different time).  And we may run different workloads on different
>>>> logical CPUs of the system.  This also makes it hard to find the best
>>>> PCP tuning globally.
>>>
>>> Yes this makes sense. Does that mean that the global pcp tuning is not
>>> keeping up and we need to be able to do more auto-tuning on local bases
>>> rather than global?
>> Similar as above, I think that PCP helps the good situations
>> performance
>> greatly, and splitting zone can help the bad situations scalability.
>> They are working at the different levels.
>> As for PCP auto-tuning, I think that it's hard to implement it to
>> resolve all problems (that is, makes PCP never be drained).
>> And auto-tuning doesn't sound easy.  Do you have some idea of how to
>> do
>> that?
>
> If we could avoid instantiating more zones and rather improve existing
> mechanisms (PCP), that would be much more preferred IMHO. I'm sure
> it's not easy, but that shouldn't stop us from trying ;)

I do think improving PCP or adding another level of cache will help
performance and scalability.

And, I think that it has value too to improve the performance of zone
itself.  Because there will be always some cases that the zone lock
itself is contended.

That is, PCP and zone works at different level, and both deserve to be
improved.  Do you agree?

> I did not look into the details of this proposal, but seeing the
> change in include/linux/page-flags-layout.h scares me.

It's possible for us to use 1 more bit in page->flags.  Do you think
that will cause severe issue?  Or you think some other stuff isn't
acceptable?

> Further, I'm not so sure how that change really interacts with
> hot(un)plug of memory ... on a quick glimpse I feel like this series
> hacks the code such that such that the split works based on the boot
> memory size ...

Em..., the zone stuff is kind of static now.  It's hard to add a zone at
run-time.  So, in this series, we determine the number of zones per zone
type based on boot memory size.  This may be improved in the future via
pre-allocate some empty zone instances during boot and hot-add some
memory to these zones.

> I agree with Michal that looking into auto-tuning PCP would be
> preferred. If that can't be done, adding another layer might end up 
> cleaner and eventually cover more use cases.

I do agree that it's valuable to make PCP etc. cover more use cases.  I
just think that this should not prevent us from optimizing zone itself
to cover remaining use cases.

> [I recall there was once a proposal to add a 3rd layer to limit
> fragmenation to individual memory blocks; but the granularity was
> rather small and there were also some concerns that I don't recall
> anymore]

Best Regards,
Huang, Ying
