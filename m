Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2D724DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjFFUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjFFUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:03:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1810F3;
        Tue,  6 Jun 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686081815; x=1717617815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/P4uBMum54OsguSow/2pgghi0WtoiS74sGhM9dzFnU=;
  b=h2dBE1tOcPaxyu8H5iqJh8fW0IHbMMChv2BovRVakuo7J2U+lWHBqwro
   Rsyevmukw4LtKAjk/8lRo/+tpjHdjB8nt7XhKMJ1KeSYDHvr6cK5kmH/m
   PWwmW7IpI90ihny4AH+LGR9O9RnFgpWMVPbslOY0esLYrs9lSWILXM7Y6
   PEsRX9HndGaf9sRc2pIiyoEEsuWi4tel0gtBLnS4gqooTh9ISmHfIVy2r
   TSNdNYa1lVvzt8Fb79uQnqh8kyaIntCcYy6qsDYKyWBMc9EHZpaIxqbqF
   QYGh8bC8DqzCirtUUpEkOLRlrrylSQFrag9P5rqKuP6aPLeG4+yt94U4A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355641837"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="355641837"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="709201251"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="709201251"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.25.226])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:03:33 -0700
Date:   Tue, 6 Jun 2023 13:03:32 -0700
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
        Dave Jiang <dave.jiang@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <ZH+RFGZqAoSEIHqT@aschofie-mobl2>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <647bd26937a11_142af829499@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647bd26937a11_142af829499@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 04:53:13PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > over an HPA address range.
> > 
> > The initial use case is the ACPI driver that needs to extend
> > SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> 
> I feel like this demands more explanation because the "need" is not
> apparent. In fact its a Linux policy choice not a requirement. The next
> patch has some of this, but this story is needed earlier for someone
> that reads this patch first. Something like:
> 

Hi Dan,

Thanks for the review :)

Sure, I can add the story below to make the 'need' for this function
more apparent, as well as s/needs/want so as not to conflate need with
requirement.

> ---
> 
> The CFWMS is an ACPI data structure that indicates *potential* locations
> where CXL memory can be placed. It is the playground where the CXL
> driver has free reign to establish regions.  That space can be populated
> by BIOS created regions, or driver created regions, after hotplug or
> other reconfiguration.
> 
> When the BIOS creates a region in a CXL Window it additionally describes
> that subset of the Window range in the other typical ACPI tables SRAT,
> SLIT, and HMAT. The rationale for the BIOS not pre-describing the entire
> CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> future. I.e. there is nothing stopping higher or lower performance
> devices being placed in the same Window. Compare that to ACPI memory
> hotplug that just onlines additional capacity in the proximity domain
> with little freedom for dynamic performance differentiation.
> 
> That leaves the OS with a choice, should unpopulated window capacity
> match the proximity domain of an existing region, or should it allocate
> a new one? This patch takes the simple position of minimizing proximity
> domain proliferation and reuse any proximity domain intersection for the
> entire Window. If the Window has no intersections then allocate a new
> proximity domain. Note that SRAT, SLIT and HMAT information can be
> enumerated dynamically in a standard way from device provided data.
> Think of CXL as the end of ACPI needing to describe memory attributes,
> CXL offers a standard discovery model for performance attributes, but
> Linux still needs to interoperate with the old regime.
> 
> ---
> 
> > 
> > The APCI driver expects to use numa_fill_memblks() while parsing
> 
> s/APCI/ACPI/
> 
> Again, the ACPI code does not have any expectation, this is pure OS
> policy decision about how to handle undescribed memory.
> 

The intent was to show the pending use case, perhaps 'wants to' use
this function to enact a purely OS policy decision!


> > the CFMWS. Extending the memblks created during SRAT parsing, to
> > cover the entire CFMWS Window, is desirable because everything in
> > a CFMWS Window is expected to be of a similar performance class.
> > 
> > Requires CONFIG_NUMA_KEEP_MEMINFO.
> 
> Not sure this adds anything to the description.
> 
> > 
> > [1] A CXL CFMWS Window represents a contiguous CXL memory resource,
> > aka an HPA range. The CFMWS (CXL Fixed Memory Window Structure) is
> > part of the ACPI CEDT (CXL Early Discovery Table).
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  arch/x86/include/asm/sparsemem.h |  2 +
> >  arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
> >  include/linux/numa.h             |  7 +++
> >  3 files changed, 91 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> > index 64df897c0ee3..1be13b2dfe8b 100644
> > --- a/arch/x86/include/asm/sparsemem.h
> > +++ b/arch/x86/include/asm/sparsemem.h
> > @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
> >  #define phys_to_target_node phys_to_target_node
> >  extern int memory_add_physaddr_to_nid(u64 start);
> >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > +extern int numa_fill_memblks(u64 start, u64 end);
> > +#define numa_fill_memblks numa_fill_memblks
> 
> What is this for? The other defines are due to being an arch-specific
> API and the #define is how the arch declares that it has a local version
> to replace the generic one.

That define, along with the numa.h change below, are to support builds of
CONFIG_ARM64 and CONFIG_LOONGARCH, both include the caller acpi_parse_cfmws(),
of numa_fill_memblks().

> 
> >  #endif
> >  #endif /* __ASSEMBLY__ */
> >  
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..6c8f9cff71da 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/sched.h>
> >  #include <linux/topology.h>
> > +#include <linux/sort.h>
> >  
> >  #include <asm/e820/api.h>
> >  #include <asm/proto.h>
> > @@ -961,4 +962,85 @@ int memory_add_physaddr_to_nid(u64 start)
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
> > +	if (ma->end != mb->end)
> > +		return (ma->end < mb->end) ? -1 : 1;
> 
> Why is this sorting by start and end? I can maybe guess, but a comment
> would help a future intrepid reader.

Sure, can add comment. It compares ends only if starts are the same.
It's putting the list in order for numa_fill_memblks() to walk and
fill.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> > +
> > +/**
> > + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> > + * @start: address to begin fill
> > + * @end: address to end fill
> > + *
> > + * Find and extend numa_meminfo memblks to cover the @start/@end
> > + * HPA address range, following these rules:
> > + * 1. The first memblk must start at @start
> > + * 2. The last memblk must end at @end
> 
> Why these requirements? I worry this is too strict because of the
> existence of numa_cleanup_meminfo() which indicates that Linux has seen
> quite messy firmware tables, or otherwise needs to cleanup after the
> "numa=fake=" command line option. Is it not enough to just check for any
> intersection?

Yes, it would be enough to just check for intersection, and not
force the alignment. Will change code to reflect.

> 
> > + * 3. Fill the gaps between memblks by extending numa_memblk.end
> > + * Result: All addresses in start/end range are included in
> > + *	   numa_meminfo.
> > + *
> > + * RETURNS:
> > + * 0		  : Success. numa_meminfo fully describes start/end
> > + * NUMA_NO_MEMBLK : No memblk exists in start/end range
> 
> This probably wants to clarify whether @end is inclusive or exclusive.

It's exclusive and I'll add comment.

> 
> > + */
> > +
> > +int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	struct numa_meminfo *mi = &numa_meminfo;
> > +	struct numa_memblk **blk = &numa_memblk_list[0];
> > +	int count = 0;
> > +
> > +	for (int i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		if (start <= bi->start && end >= bi->end) {
> 
> Maybe a comment about what this is doing? This is looking for to see if
> any CXL window completely overlaps any SRAT entry?

Based on your first comment about messy tables, I can see the need to
expand the search to include any intersection. Will do.

>    
> > +			blk[count] = &mi->blk[i];
> > +			count++;
> > +		}
> > +	}
> > +	if (!count)
> > +		return NUMA_NO_MEMBLK;
> > +
> > +	if (count == 1) {
> > +		blk[0]->start = start;
> > +		blk[0]->end = end;
> > +		return 0;
> 
> So this is updating numa_meminfo in place?

Yes.

> 
> > +	}
> > +
> > +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> > +	blk[0]->start = start;
> > +	blk[count - 1]->end = end;
> > +
> > +	for (int i = 0, j = 1; j < count; i++, j++) {
> > +		/* Overlaps OK. sort() put the lesser end first */
> > +		if (blk[i]->start == blk[j]->start)
> > +			continue;
> > +
> > +		/* No gap */
> > +		if (blk[i]->end == blk[j]->start)
> > +			continue;
> > +
> > +		/* Fill the gap */
> > +		if (blk[i]->end < blk[j]->start) {
> > +			blk[i]->end = blk[j]->start;
> > +			continue;
> > +		}
> 
> This looks clever to sort an array of pointers into the existing
> numa_meminfo, I think it needs some comments to explain the cleverness,
> but I am not seeing anything glaringly wrong about the approach.
> 

I'll add comments on all the above.


> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> > +
> >  #endif
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 59df211d051f..0f512c0aba54 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -12,6 +12,7 @@
> >  #define MAX_NUMNODES    (1 << NODES_SHIFT)
> >  
> >  #define	NUMA_NO_NODE	(-1)
> > +#define	NUMA_NO_MEMBLK	(-1)
> >  
> >  /* optionally keep NUMA memory info available post init */
> >  #ifdef CONFIG_NUMA_KEEP_MEMINFO
> > @@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
> >  	return 0;
> >  }
> >  #endif
> > +#ifndef numa_fill_memblks
> > +static inline int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	return NUMA_NO_MEMBLK;
> > +}
> > +#endif
> 
> Why does linux/numa.h need to care about this x86-specific init routine?
> 

This is how I got ARM64 and LOONGARCH to build.


> >  #else /* !CONFIG_NUMA */
> >  static inline int numa_map_to_online_node(int node)
> >  {
> > -- 
> > 2.37.3
> > 
> 
> 
