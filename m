Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BD707B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjERIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjERIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:07:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143797
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684397271; x=1715933271;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=laOsXnWXv9Xaa6VQNpSpFGCPLJxDY76YKOU3FxnvFqA=;
  b=f477dzIZwpbqcXuF0woj8uiT3tp34X8sCRPDMr+3/8uzOuAJq9+KD5mS
   Eo6rw/cj7m6voEBzKkDmXwx0J8lyflyd56/zUSm9N1aEmOgiedR4YhFQJ
   P7qeyBXbcFaz439AAIyhko97BlPwSgHtntR+PGFRI4dzSsHv5wDpP+d0J
   VLVEfv8JPXC74Ek5E5zJngnkesrkYGfMJw7XpNX6EV32yltVPgMnbUWgI
   2i8mReZS0+JWvkFwtZDORTtzzaUgVnlGKhg6gPG24Z7oshJldWAUoKh77
   yhMRjs36ShQpJeaxwi9H0gnFKWDqer632mbcVp4+YRHukOmoTUv06s3aN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415426093"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="415426093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 01:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734987869"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="734987869"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 01:07:47 -0700
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
        <87bkij7ncn.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <eae68813-4240-4de1-6177-0a44e00bd04d@redhat.com>
Date:   Thu, 18 May 2023 16:06:43 +0800
In-Reply-To: <eae68813-4240-4de1-6177-0a44e00bd04d@redhat.com> (David
        Hildenbrand's message of "Wed, 17 May 2023 10:09:31 +0200")
Message-ID: <875y8q83n0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

>>> If we could avoid instantiating more zones and rather improve existing
>>> mechanisms (PCP), that would be much more preferred IMHO. I'm sure
>>> it's not easy, but that shouldn't stop us from trying ;)
>> I do think improving PCP or adding another level of cache will help
>> performance and scalability.
>> And, I think that it has value too to improve the performance of
>> zone
>> itself.  Because there will be always some cases that the zone lock
>> itself is contended.
>> That is, PCP and zone works at different level, and both deserve to
>> be
>> improved.  Do you agree?
>
> Spoiler: my humble opinion
>
>
> Well, the zone is kind-of your "global" memory provider, and PCPs
> cache a fraction of that to avoid exactly having to mess with that
> global datastructure and lock contention.
>
> One benefit I can see of such a "global" memory provider with caches
> on top is is that it is nicely integrated: for example, the concept of 
> memory pressure exists for the zone as a whole. All memory is of the
> same kind and managed in a single entity, but free memory is cached
> for performance.
>
> As soon as you manage the memory in multiple zones of the same kind,
> you lose that "global" view of your memory that is of the same kind,
> but managed in different bucks. You might end up with a lot of memory 
> pressure in a single such zone, but still have plenty in another zone.
>
> As one example, hot(un)plug of memory is easy: there is only a single
> zone. No need to make smart decisions or deal with having memory we're 
> hotunplugging be stranded in multiple zones.

I understand that there are some unresolved issues for splitting zone.
I will think more about them and the possible solutions.

>> 
>>> I did not look into the details of this proposal, but seeing the
>>> change in include/linux/page-flags-layout.h scares me.
>> It's possible for us to use 1 more bit in page->flags.  Do you think
>> that will cause severe issue?  Or you think some other stuff isn't
>> acceptable?
>
> The issue is, everybody wants to consume more bits in page->flags, so
> if we can get away without it that would be much better :)

Yes.

> The more bits you want to consume, the more people will ask for making
> this a compile-time option and eventually compile it out on distro 
> kernels (e.g., with many NUMA nodes). So we end up with more code and
> complexity and eventually not get the benefits where we really want
> them.

That's possible.  Although I think we will still use more page flags
when necessary.

>> 
>>> Further, I'm not so sure how that change really interacts with
>>> hot(un)plug of memory ... on a quick glimpse I feel like this series
>>> hacks the code such that such that the split works based on the boot
>>> memory size ...
>> Em..., the zone stuff is kind of static now.  It's hard to add a
>> zone at
>> run-time.  So, in this series, we determine the number of zones per zone
>> type based on boot memory size.  This may be improved in the future via
>> pre-allocate some empty zone instances during boot and hot-add some
>> memory to these zones.
>
> Just to give you some idea: with virtio-mem, hyper-v, daxctl, and
> upcoming cxl dynamic memory pooling (some day I'm sure ;) ) you might 
> see quite a small boot memory (e.g., 4 GiB) but a significant amount
> of memory getting hotplugged incrementally (e.g., up to 1 TiB) --
> well, and hotunplugged. With multiple zone instances you really have
> to be careful and might have to re-balance between the multiple zones
> to keep the scalability, to not create imbalances between the zones
> ...

Thanks for your information!

> Something like PCP auto-tuning would be able to handle that mostly
> automatically, as there is only a single memory pool.

I agree that optimizing PCP will help performance regardless of
splitting zone or not.

>> 
>>> I agree with Michal that looking into auto-tuning PCP would be
>>> preferred. If that can't be done, adding another layer might end up
>>> cleaner and eventually cover more use cases.
>> I do agree that it's valuable to make PCP etc. cover more use cases.
>> I
>> just think that this should not prevent us from optimizing zone itself
>> to cover remaining use cases.
>
> I really don't like the concept of replicating zones of the same kind
> for the same NUMA node. But that's just my personal opinion
> maintaining some memory hot(un)plug code :)
>
> Having that said, some kind of a sub-zone concept (additional layer)
> as outlined by Michal IIUC, for example, indexed by core
> id/has/whatsoever could eventually be worth exploring. Yes, such a
> design raises various questions ... :)

Yes.  That's another possible solution for the page allocation
scalability problem.

Best Regards,
Huang, Ying
