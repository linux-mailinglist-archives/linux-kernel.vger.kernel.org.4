Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBF7304A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjFNQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFNQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:12:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7821F1FE5;
        Wed, 14 Jun 2023 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686759142; x=1718295142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fn79wtGk84t697GEvQm3SSYhtO2iiDoAWw2Q8A4P0zw=;
  b=I+1Sqd1XUUsqkdg03ANHY585Gmx8TGM8e8S4HCzZ88EFpryG/WkWyz+R
   3/05sSNj2O566mXuRCTnGMt2qNryakTeWZ1TOzChoy1LQ3P/Xb3QJKj7S
   ytCzXYgtyoatha/AO/4d/Rh8Gyvc2rEHprriUV4iYazi9yrNt+BoK59A2
   m9sZdFlcK/5EcWcsOoiBhB+GqMdiRmtwHj2kadBazm9awyErQZ3CQ2XMl
   aeJN+kuff5hhVMM69m+2+j1lqOHOSQzmq8SoqKLnzDYQPQcM4fy1BmDfi
   xFVzhmTKHdDBYPXG5pzcBw5PCsT/Ovp6sJ4iKAEqEYRl7/OhJ+Cd5Om0b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361135194"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361135194"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="958843848"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="958843848"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.191])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:09:27 -0700
Date:   Wed, 14 Jun 2023 09:09:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <ZInmNaUM4HYnCCya@aschofie-mobl2>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
 <6489b6234a03e_142af829454@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6489b6234a03e_142af829454@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:44:19AM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > over an HPA address range.
> > 
> > The ACPI driver will use numa_fill_memblks() to implement a new Linux
> > policy that prescribes extending proximity domains in a portion of a
> > CFMWS window to the entire window.
> > 
> > Dan Williams offered this explanation of the policy:
> > A CFWMS is an ACPI data structure that indicates *potential* locations
> > where CXL memory can be placed. It is the playground where the CXL
> > driver has free reign to establish regions. That space can be populated
> > by BIOS created regions, or driver created regions, after hotplug or
> > other reconfiguration.
> > 
> > When BIOS creates a region in a CXL Window it additionally describes
> > that subset of the Window range in the other typical ACPI tables SRAT,
> > SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
> > CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> > future. I.e. there is nothing stopping higher or lower performance
> > devices being placed in the same Window. Compare that to ACPI memory
> > hotplug that just onlines additional capacity in the proximity domain
> > with little freedom for dynamic performance differentiation.
> > 
> > That leaves the OS with a choice, should unpopulated window capacity
> > match the proximity domain of an existing region, or should it allocate
> > a new one? This patch takes the simple position of minimizing proximity
> > domain proliferation by reusing any proximity domain intersection for
> > the entire Window. If the Window has no intersections then allocate a
> > new proximity domain. Note that SRAT, SLIT and HMAT information can be
> > enumerated dynamically in a standard way from device provided data.
> > Think of CXL as the end of ACPI needing to describe memory attributes,
> > CXL offers a standard discovery model for performance attributes, but
> > Linux still needs to interoperate with the old regime.
> > 
> > Reported-by: Derick Marks <derick.w.marks@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Tested-by: Derick Marks <derick.w.marks@intel.com>
> [..]
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..fa82141d1a04 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> [..]
> > @@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
> >  	return nid;
> >  }
> >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > +
> > +static int __init cmp_memblk(const void *a, const void *b)
> > +{
> > +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> > +
> > +	if (ma->start != mb->start)
> > +		return (ma->start < mb->start) ? -1 : 1;
> > +
> > +	/* Caller handles duplicate start addresses */
> > +	return 0;
> 
> This can be simplified to:
> 
> static int __init cmp_memblk(const void *a, const void *b)
> {
> 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> 	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> 
> 	return ma->start - mb->start;
> }

Got it.

> 
> > +}
> > +
> > +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> > +
> > +/**
> > + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> > + * @start: address to begin fill
> > + * @end: address to end fill
> > + *
> > + * Find and extend numa_meminfo memblks to cover the @start-@end
> > + * HPA address range, such that the first memblk includes @start,
> > + * the last memblk includes @end, and any gaps in between are
> > + * filled.
> > + *
> > + * RETURNS:
> > + * 0		  : Success
> > + * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> > + */
> > +
> > +int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	struct numa_memblk **blk = &numa_memblk_list[0];
> > +	struct numa_meminfo *mi = &numa_meminfo;
> > +	int count = 0;
> > +	u64 prev_end;
> > +
> > +	/*
> > +	 * Create a list of pointers to numa_meminfo memblks that
> > +	 * overlap start, end. Exclude (start == bi->end) since
> > +	 * end addresses in both a CFMWS range and a memblk range
> > +	 * are exclusive.
> > +	 *
> > +	 * This list of pointers is used to make in-place changes
> > +	 * that fill out the numa_meminfo memblks.
> > +	 */
> 
> Thanks for this comment, looks good.
> 
> > +	for (int i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		if (start < bi->end && end >= bi->start) {
> > +			blk[count] = &mi->blk[i];
> > +			count++;
> > +		}
> > +	}
> > +	if (!count)
> > +		return NUMA_NO_MEMBLK;
> > +
> > +	/* Sort the list of pointers in memblk->start order */
> > +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> > +
> > +	/* Make sure the first/last memblks include start/end */
> > +	blk[0]->start = min(blk[0]->start, start);
> > +	blk[count - 1]->end = max(blk[count - 1]->end, end);
> > +
> > +	/*
> > +	 * Fill any gaps by tracking the previous memblks end address,
> > +	 * prev_end, and backfilling to it if needed. Avoid filling
> > +	 * overlapping memblks by making prev_end monotonically non-
> > +	 * decreasing.
> 
> I am not immediately understanding the use of the term monotonically
> non-decreasing here? I think the first sentence of this comment is
> enough, or am I missing a nuance?

Not sure it's a nuance, but if we advanced prev_end to be curr_end
at each iteration, gaps get needlessly filled, when curr is wholly
contained in prev. So the 'monotonically non-decreasing' comment is
emphasizing that prev-end will either stay the same or increase
at each iteration.

> 
> > +	 */
> > +	prev_end = blk[0]->end;
> > +	for (int i = 1; i < count; i++) {
> > +		struct numa_memblk *curr = blk[i];
> > +
> > +		if (prev_end >= curr->start) {
> > +			if (prev_end < curr->end)
> > +				prev_end = curr->end;
> > +		} else {
> > +			curr->start = prev_end;
> > +			prev_end = curr->end;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> 
> This export is not needed. The only caller of this is
> drivers/acpi/numa/srat.c which is only ever built-in, not a module.

Got it.
Thanks for the review Dan and for helping address other reviewer
comments.

Alison


