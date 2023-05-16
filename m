Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1B70497A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEPJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjEPJjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:39:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232326B1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684229962; x=1715765962;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=a+1CyWspy7I4EDdP6KfbpZ/3Tq3hn9rZKAuCfoYYGB4=;
  b=Y8Ok/K6YflkRpBZzTubIJj8Hls9NIvUidPEVbSK11vz607pzi9dpvY3D
   a80lmFqMnvuBhDEju7zAZFBWbqGt+LO3Srmf68aYQNJcPzRNDzVJsCUFR
   qUO4yKH/C98mtv2khFk+hUlxJwBXt13TbW5IDXnuqMpxmpRQONj++4AZD
   BH5LU1qwWKBcZEFcU7MIjIpU+i01M5oAyZXWKBLb6hPCA/heoRKHAxDk7
   cCYJZJirVEddKnZDKx0R07Urv4EykLD07jc3GkatEhpouYZdrtt8Lk3UP
   QQvK5snrCR90p7RhAwLMlQpecC1c4FgGsASTX89SHIzg83TEeQPSrXR7W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="354597997"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="354597997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 02:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731928090"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731928090"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 02:39:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
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
Date:   Tue, 16 May 2023 17:38:06 +0800
In-Reply-To: <ZGIUEqhSydAdvRFN@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 15 May 2023 13:14:26 +0200")
Message-ID: <87jzx87h1d.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Michal Hocko <mhocko@suse.com> writes:

> On Fri 12-05-23 10:55:21, Huang, Ying wrote:
>> Hi, Michal,
>> 
>> Thanks for comments!
>> 
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 11-05-23 14:56:01, Huang Ying wrote:
>> >> The patchset is based on upstream v6.3.
>> >> 
>> >> More and more cores are put in one physical CPU (usually one NUMA node
>> >> too).  In 2023, one high-end server CPU has 56, 64, or more cores.
>> >> Even more cores per physical CPU are planned for future CPUs.  While
>> >> all cores in one physical CPU will contend for the page allocation on
>> >> one zone in most cases.  This causes heavy zone lock contention in
>> >> some workloads.  And the situation will become worse and worse in the
>> >> future.
>> >> 
>> >> For example, on an 2-socket Intel server machine with 224 logical
>> >> CPUs, if the kernel is built with `make -j224`, the zone lock
>> >> contention cycles% can reach up to about 12.7%.
>> >> 
>> >> To improve the scalability of the page allocation, in this series, we
>> >> will create one zone instance for each about 256 GB memory of a zone
>> >> type generally.  That is, one large zone type will be split into
>> >> multiple zone instances.  Then, different logical CPUs will prefer
>> >> different zone instances based on the logical CPU No.  So the total
>> >> number of logical CPUs contend on one zone will be reduced.  Thus the
>> >> scalability is improved.
>> >
>> > It is not really clear to me why you need a new zone for all this rather
>> > than partition free lists internally within the zone? Essentially to
>> > increase the current two level system to 3: per cpu caches, per cpu
>> > arenas and global fallback.
>> 
>> Sorry, I didn't get your idea here.  What is per cpu arenas?  What's the
>> difference between it and per cpu caches (PCP)?
>
> Sorry, I didn't give this much thought than the above. Essentially, we
> have 2 level system right now. Pcp caches should reduce the contention
> on the per cpu level and that should work reasonably well, if you manage
> to align batch sizes to the workload AFAIK. If this is not sufficient
> then why to add the full zone rather than to add another level that
> caches across a larger than a cpu unit. Maybe a core?
>
> This might be a wrong way around going for this but there is not much
> performance analysis about the source of the lock contention so I am
> mostly guessing.

I guess that the page allocation scalability will be improved if we put
more pages in the per CPU caches, or add another level of cache for
multiple logical CPUs.  Because more page allocation requirements can be
satisfied without acquiring zone lock.

As other caching system, there are always cases that the caches are
drained and too many requirements goes to underlying slow layer (zone
here).  For example, if a workload needs to allocate a huge number of
pages (larger than cache size) in parallel, it will run into zone lock
contention finally.  The situation will became worse and worse if we
share one zone with more and more logical CPUs.  Which is the trend in
industry now.  Per my understanding, we can observe the high zone lock
contention cycles in kbuild test because of that.

So, per my understanding, to improve the page allocation scalability in
bad situations (that is, caching doesn't work well enough), we need to
restrict the number of logical CPUs that share one zone.  This series is
an attempt for that.  Better caching can increase the good situations
and reduce the bad situations.  But it seems hard to eliminate all bad
situations.

From another perspective, we don't install more and more memory for each
logical CPU.  This makes it hard to enlarge the default per-CPU cache
size.

>> > I am also missing some information why pcp caches tunning is not
>> > sufficient.
>> 
>> PCP does improve the page allocation scalability greatly!  But it
>> doesn't help much for workloads that allocating pages on one CPU and
>> free them in different CPUs.  PCP tuning can improve the page allocation
>> scalability for a workload greatly.  But it's not trivial to find the
>> best tuning parameters for various workloads and workload run time
>> statuses (workloads may have different loads and memory requirements at
>> different time).  And we may run different workloads on different
>> logical CPUs of the system.  This also makes it hard to find the best
>> PCP tuning globally.
>
> Yes this makes sense. Does that mean that the global pcp tuning is not
> keeping up and we need to be able to do more auto-tuning on local bases
> rather than global?

Similar as above, I think that PCP helps the good situations performance
greatly, and splitting zone can help the bad situations scalability.
They are working at the different levels.

As for PCP auto-tuning, I think that it's hard to implement it to
resolve all problems (that is, makes PCP never be drained).

And auto-tuning doesn't sound easy.  Do you have some idea of how to do
that?

>> It would be better to find a solution to improve
>> the page allocation scalability out of box or automatically.  Do you
>> agree?
>
> Yes. 

Best Regards,
Huang, Ying
