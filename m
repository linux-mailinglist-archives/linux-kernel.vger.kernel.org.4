Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DDB64E4F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLPAHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLPAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:07:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8D5C0CA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671149225; x=1702685225;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/z5HDHhx0SlHXpvN/Z4yVFIrDq7f8gnnwyIizEhhHPI=;
  b=Jv9vQTVwSNZYdv7yZwxQ1fuCIkoz8gLHK3vIj6Y/Km3OOyJgvUbx+Nyi
   wg/oDq4Z+tsa6wwx00ikPaTm7W7c0S6pB8LP4tLFq1SPswHyIwkEgEIbm
   Ex3vA9BtdJAYS/DMZacFCiOWJivzHmFnlBuhp1DiZQSMX/4ioFKudDbzP
   uudZx8eFw+TubD5TVLa/zTwmL3eiKgZlHru4Ek/rQ2jRRibPeI/iT2n3+
   cX7fj/NsFGIuFudxTzb142OmRmANgZi8VqrUSXa9CE260p+Syoa6OWOEI
   5Z+oH/VwYgRmSM8kERsNhNbPgr46yoA8HMqaUwOY7d90pU8bICn109bvH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299179135"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299179135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 16:07:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="599755703"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="599755703"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 16:07:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
In-Reply-To: <Y5spqIz3vAlqYIHK@x1n> (Peter Xu's message of "Thu, 15 Dec 2022
        09:05:28 -0500")
References: <20221214200453.1772655-1-peterx@redhat.com>
        <20221214200453.1772655-3-peterx@redhat.com>
        <87bko5cf8y.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y5spqIz3vAlqYIHK@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 16 Dec 2022 08:06:13 +0800
Message-ID: <87v8mc9pqi.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Dec 15, 2022 at 03:12:13PM +0800, Huang, Ying wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
>> > errors") on using pte markers for swapin errors on a few corner cases.
>> >
>> > 1. Propagate swapin errors across fork()s: if there're swapin errors in
>> >    the parent mm, after fork()s the child should sigbus too when an error
>> >    page is accessed.
>> >
>> > 2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
>> >    marker can be quickly switched to a swapin error.
>> >
>> > 3. Explicitly ignore swapin error pte markers in change_protection().
>> >
>> > I mostly don't worry on (2) or (3) at all, but we should still have them.
>> > Case (1) is special because it can potentially cause silent data corrupt on
>> > child when parent has swapin error triggered with swapoff, but since swapin
>> > error is rare itself already it's probably not easy to trigger either.
>> >
>> > Currently there is a priority difference between the uffd-wp bit and the
>> > swapin error entry, in which the swapin error always has higher
>> > priority (e.g. we don't need to wr-protect a swapin error pte marker).
>> >
>> > If there will be a 3rd bit introduced, we'll probably need to consider a
>> > more involved approach so we may need to start operate on the bits.  Let's
>> > leave that for later.
>> >
>> > This patch is tested with case (1) explicitly where we'll get corrupted
>> > data before in the child if there's existing swapin error pte markers, and
>> > after patch applied the child can be rightfully killed.
>> >
>> > We don't need to copy stable for this one since 15520a3f0469 just landed as
>> > part of v6.2-rc1, only "Fixes" applied.
>> >
>> > Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  mm/hugetlb.c  | 3 +++
>> >  mm/memory.c   | 8 ++++++--
>> >  mm/mprotect.c | 8 +++++++-
>> >  3 files changed, 16 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> > index f5f445c39dbc..1e8e4eb10328 100644
>> > --- a/mm/hugetlb.c
>> > +++ b/mm/hugetlb.c
>> > @@ -4884,6 +4884,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>> >  				entry = huge_pte_clear_uffd_wp(entry);
>> >  			set_huge_pte_at(dst, addr, dst_pte, entry);
>> >  		} else if (unlikely(is_pte_marker(entry))) {
>> > +			/* No swap on hugetlb */
>> > +			WARN_ON_ONCE(
>> > +			    is_swapin_error_entry(pte_to_swp_entry(entry)));
>> >  			/*
>> >  			 * We copy the pte marker only if the dst vma has
>> >  			 * uffd-wp enabled.
>> > diff --git a/mm/memory.c b/mm/memory.c
>> > index 032ef700c3e8..3e836fecd035 100644
>> > --- a/mm/memory.c
>> > +++ b/mm/memory.c
>> > @@ -828,7 +828,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>> >  			return -EBUSY;
>> >  		return -ENOENT;
>> >  	} else if (is_pte_marker_entry(entry)) {
>> > -		if (userfaultfd_wp(dst_vma))
>> > +		if (is_swapin_error_entry(entry) || userfaultfd_wp(dst_vma))
>> 
>> Should we do this in [1/2]?  It appears that we introduce an issue in
>> [1/2] and fix it in [2/2]?
>
> Patch 1 copied stable with 5.19+, this one is not.
>
> So if we want to squash, we may want to squash both patches into one, then
> we'll need an explicit follow up on stable branch with something like patch
> 1.  The current way works easier for stable, but I can also do the other.

Got it.  Thanks for explanation.  It's OK for me to keep them in current
way.

Best Regards,
Huang, Ying
