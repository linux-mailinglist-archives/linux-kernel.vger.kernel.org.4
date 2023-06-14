Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5BF7304C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFNQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjFNQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:18:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84953E43;
        Wed, 14 Jun 2023 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686759519; x=1718295519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IssY0UkBJsN+vwkFfyARVIK95wmR4sN/a0XQGURwmHE=;
  b=Lq/Ch6s9mTyM06nzWJWz8WSUtmvfZS8c/m56mKlY8lbWbwFFDQDJ7UaR
   BTSr9xh6o0j9YmeJdKKvzD63mK+/wBU3Trt0i4JsBCHtFIZdvzNXcrCvC
   o4MfG2XIYwJi5sHiSeRLnLYiBJOa00CFFhEZ5EaF80ycAB6eOOwGeqj9a
   d1C+iY8gxB5bniuvV/EE8MbvXn/01UQwW7owK+sS+fGgm+rYtcpD01naz
   F6mqLRSpjFZtQwG5iORaqAZ1r+YISDHgJcBXP7TVKCObzK85BLGpDvg5x
   QmVF74cKLRYPNzsC2C9o4iL5pNfTVKSw2eMHTenPkh7HLpoFUYA3r/Gv6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424547881"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="424547881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="824873760"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="824873760"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.191])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:17:36 -0700
Date:   Wed, 14 Jun 2023 09:17:36 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <ZInoILTLfop6P8wt@aschofie-mobl2>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
 <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:35:22AM +0200, Wilczynski, Michal wrote:
> 
> 
> On 6/14/2023 6:35 AM, alison.schofield@intel.com wrote:
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
> > ---
> >  arch/x86/include/asm/sparsemem.h |  2 +
> >  arch/x86/mm/numa.c               | 87 ++++++++++++++++++++++++++++++++
> >  include/linux/numa.h             |  7 +++
> >  3 files changed, 96 insertions(+)
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
> >  #endif
> >  #endif /* __ASSEMBLY__ */
> >  
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..fa82141d1a04 100644
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
> > @@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
> >  	return nid;
> >  }
> >  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > +
> > +static int __init cmp_memblk(const void *a, const void *b)
> > +{
> > +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> 
> Is this casting necessary  ?

Thanks for the review Michael,

I found the cast to be necessary.
Sort passes pointers to the array elements to compare, even if they
are already pointers, so cmp_ gets a double pointer. 

> 
> > +
> > +	if (ma->start != mb->start)
> > +		return (ma->start < mb->start) ? -1 : 1;
> > +
> > +	/* Caller handles duplicate start addresses */
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
> 
> Same error code as NUMA_NO_NODE ?
> 

Yes. It's a define for convenience/clarity, rather than just using
(-1).  I could have just used NUMA_NO_NODE, since no memblk also
means no node, but in a function whose job is to fill memblks, that
seemed wrong.

> >  
> >  /* optionally keep NUMA memory info available post init */
> >  #ifdef CONFIG_NUMA_KEEP_MEMINFO
> > @@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
> >  	return 0;
> >  }
> >  #endif
> > +#ifndef numa_fill_memblks
> 
> Why not just #ifndef CONFIG_NUMA_KEEP_MEMINFO ?

Dan responded to this, nothing to add to that:
This is due to the fact that multiple archs use
CONFIG_NUMA_KEEP_MEMINFO (x86, ARM64, LOONGARCH), but only one supplies
a numa_fill_memblks() implementation (x86).

> 
> > +static inline int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	return NUMA_NO_MEMBLK;
> > +}
> > +#endif
> >  #else /* !CONFIG_NUMA */
> >  static inline int numa_map_to_online_node(int node)
> >  {
> 
