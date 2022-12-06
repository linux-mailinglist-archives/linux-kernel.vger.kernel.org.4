Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873E643AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiLFB0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLFB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:26:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A91EC66
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670289991; x=1701825991;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=BFItqSQgBNwkiz5qIVf4U+3jo0eccZ9fEgmZMieuN6A=;
  b=Ze/NqJ4V2kA5j0+OW7W8W0d3+E0W506xLXDe3vMxUgFqKPLWbkAx+ISn
   6HvhWdjI32dJHdamktjD3S+/6OPyq+r0MbzU1z23ZSj8VcSrOLoMcmfay
   tJCVHp4WrWp54fKdH8GVZWRFtvP9zAF+kbQbRBH3F800BWd4eWDltXbqO
   bMoVMsGgMXLtRBnHd1bW9NZJpXI/D476+DuGUtIbLyhWWYy9/ZJZtnUEt
   5jqONBT6UJfWxdwSIPBtVgyviUiuhrg6RKA1FpscinNX7P323gLaz6GkI
   mwEEXLkBRrN6O8O8xsmbR3lhg8IRoR7MX/glEl77Ijl8lTbZtwayDgLuC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318368782"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318368782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:26:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="639696317"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="639696317"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 17:26:26 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
References: <20221203011120.2361610-1-almasrymina@google.com>
        <87lenm1soh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHS8izMm4NDhwX-pqEu1RbKoUgi8jFJH5a9LTetdQpQPu6ZsGw@mail.gmail.com>
Date:   Tue, 06 Dec 2022 09:25:36 +0800
In-Reply-To: <CAHS8izMm4NDhwX-pqEu1RbKoUgi8jFJH5a9LTetdQpQPu6ZsGw@mail.gmail.com>
        (Mina Almasry's message of "Mon, 5 Dec 2022 16:04:07 -0800")
Message-ID: <87k035l3vz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> On Sun, Dec 4, 2022 at 6:39 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
>> > reclaim"") enabled demotion in memcg reclaim, which is the right thing
>> > to do, however, I suspect it introduced a regression in the behavior of
>> > try_to_free_mem_cgroup_pages().
>> >
>> > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
>> > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
>> > of the cgroup should reduce by nr_pages. The callers expect
>> > try_to_free_mem_cgroup_pages() to also return the number of pages
>> > reclaimed, not demoted.
>> >
>> > However, what try_to_free_mem_cgroup_pages() actually does is it
>> > unconditionally counts demoted pages as reclaimed pages. So in practice
>> > when it is called it will often demote nr_pages and return the number of
>> > demoted pages to the caller. Demoted pages don't lower the memcg usage,
>> > and so I think try_to_free_mem_cgroup_pages() is not actually doing what
>> > the callers want it to do.
>> >
>> > I suspect various things work suboptimally on memory systems or don't
>> > work at all due to this:
>> >
>> > - memory.high enforcement likely doesn't work (it just demotes nr_pages
>> >   instead of lowering the memcg usage by nr_pages).
>> > - try_charge_memcg() will keep retrying the charge while
>> >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>> >   making any room for the charge.
>> > - memory.reclaim has a wonky interface. It advertises to the user it
>> >   reclaims the provided amount but it will actually demote that amount.
>> >
>> > There may be more effects to this issue.
>> >
>> > To fix these issues I propose shrink_folio_list() to only count pages
>> > demoted from inside of sc->nodemask to outside of sc->nodemask as
>> > 'reclaimed'.
>> >
>> > For callers such as reclaim_high() or try_charge_memcg() that set
>> > sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
>> > actually reclaim nr_pages and return the number of pages reclaimed. No
>> > demoted pages would count towards the nr_pages requirement.
>> >
>> > For callers such as memory_reclaim() that set sc->nodemask,
>> > try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
>> > with either reclaim or demotion.
>>
>> Have you checked all callers?  For example, IIUC, in
>> reclaim_clean_pages_from_list(), although sc.nodemask == NULL, the
>> demoted pages should be counted as reclaimed.
>
> I checked all call stacks leading to shrink_folio_list() now (at least
> I hope). Here is what I think they do and how I propose to handle
> them:
>
> - reclaim_clean_pages_from_list() & __node_reclaim() & balance_pgdat()
> These try to free memory from a specific node, and both demotion and
> reclaim from that node should be counted. I propose these calls set
> sc>nodemask = pgdat.node_id to signal to shrink_folio_list() that both
> demotion and reclaim from this node should be counted.
>
> - try_to_free_pages()
> Tries to free pages from a specific nodemask. It sets sc->nodemask to
> ac->nodemask. In this case pages demoted within the nodemask should
> not count. Pages demoted outside of the nodemask should count, which
> this patch already tries to do.
>
> - mem_cgroup_shrink_node()
> This is memcg soft limit reclaim. AFAIU only reclaim should be
> counted. It already sets sc->nodemask=NULL to indicate that it
> requires reclaim from all nodes and that only reclaimed memory should
> be counted, which this patch already tries to do.
>
> - try_to_free_mem_cgroup_pages()
> This is covered in the commit message. Many callers set nodemask=NULL
> indicating they want reclaim and demotion should not count.
> memory.reclaim sets nodemask depending on the 'nodes=' arg and wants
> demotion and reclaim from that nodemask.
>
> - reclaim_folio_list()
> Sets no_demotion = 1. No ambiguity here, only reclaims and counts
> reclaimed pages.
>
> If agreeable I can fix reclaim_clean_pages_from_list() &
> __node_reclaim() & balance_pgdat() call sites in v3.

Looks good to me, Thanks!

>> How about count both
>> "demoted" and "reclaimed" in struct scan_control, and let callers to
>> determine how to use the number?
>>
>
> I don't think this is by itself enough. Pages demoted between 2 nodes
> that are both in sc->nodemask should not count, I think. So 'demoted'
> needs to be specifically pages demoted outside of the nodemask.

Yes.  Maybe we can do that when we need it.  I suggest to change the
return value description in the comments of shrink_folio_list().

> We can do 2 things:
>
> 1. Only allow the kernel to demote outside the nodemask (which you
> don't prefer).
> 2. Allow the kernel to demote inside the nodemask but not count them.
>
> I will see if I can implement #2.

Thanks!

>> > Tested this change using memory.reclaim interface. With this change,
>> >
>> >       echo "1m" > memory.reclaim
>> >
>> > Will cause freeing of 1m of memory from the cgroup regardless of the
>> > demotions happening inside.
>> >
>> >       echo "1m nodes=0" > memory.reclaim
>>
>> Have you tested these tests in the original kernel?  If so, whether does
>> the issue you suspected above occurs during testing?
>>
>
> Yes. I set up a test case where I allocate 500m in a cgroup, and then do:
>
>     echo "50m" > memory.reclaim
>
> Without my fix, my kernel demotes 70mb and reclaims 4 mb.
>
> With my v1 fix, my kernel demotes all memory possible and reclaims 60mb.
>
> I will add this to the commit message in the next version.

Good!  Thanks!

Best Regards,
Huang, Ying

>>
>> > Will cause freeing of 1m of node 0 by demotion if a demotion target is
>> > available, and by reclaim if no demotion target is available.
>> >
>> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>> >
>> > ---
>> >
>> > This is developed on top of mm-unstable largely because I need the
>> > memory.reclaim nodes= arg to test it properly.
>> > ---
>> >  mm/vmscan.c | 13 ++++++++++++-
>> >  1 file changed, 12 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index 2b42ac9ad755..8f6e993b870d 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>> >       LIST_HEAD(free_folios);
>> >       LIST_HEAD(demote_folios);
>> >       unsigned int nr_reclaimed = 0;
>> > +     unsigned int nr_demoted = 0;
>> >       unsigned int pgactivate = 0;
>> >       bool do_demote_pass;
>> >       struct swap_iocb *plug = NULL;
>> > @@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>> >       /* 'folio_list' is always empty here */
>> >
>> >       /* Migrate folios selected for demotion */
>> > -     nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
>> > +     nr_demoted = demote_folio_list(&demote_folios, pgdat);
>> > +
>> > +     /*
>> > +      * Only count demoted folios as reclaimed if we demoted them from
>> > +      * inside of the nodemask to outside of the nodemask, hence reclaiming
>> > +      * pages in the nodemask.
>> > +      */
>> > +     if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
>> > +         !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))
>> > +             nr_reclaimed += nr_demoted;
>> > +
>> >       /* Folios that could not be demoted are still in @demote_folios */
>> >       if (!list_empty(&demote_folios)) {
>> >               /* Folios which weren't demoted go back on @folio_list */
>> > --
>> > 2.39.0.rc0.267.gcb52ba06e7-goog
>>
