Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D09725BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjFGKpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjFGKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465ED192;
        Wed,  7 Jun 2023 03:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70A061934;
        Wed,  7 Jun 2023 10:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B5BC433EF;
        Wed,  7 Jun 2023 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686134718;
        bh=ZAgihkjz7ucMavs74jDS5YgrVm8n9bUQbtdTPGw7n/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKHpBKYIy1uafQ78GqwnkfYAix6QAKnaEs/KbN0JEVo4FpMumdn2LkbSRpC/XDoH5
         eu9C4QMijX4tskiULdUR5AAABi2VfG6tkzLuo2OZDBmM+QlASDHabaBvS5xC8PkqVW
         Goz+5fjfZnB+XObDUz6A0lU6l0R2+6EfpQ5iQG7AQUA5VJ3I5QROG7uX+K4EP6en5+
         TmGUQmy8zcijKy4p7S4AnbrLZWS+qugCiVX74u9PMahdg1gA4sYsLcgV6zV3TlvKmD
         5H3WOsGczUWQQGuHopCfmAUtRWlhBLEEz6VhFyeNvRmrwZhn5u8NZPU03av1OWkpW/
         1Z5ljeK470EOQ==
Date:   Wed, 7 Jun 2023 13:44:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <20230607104450.GE52412@kernel.org>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <647bd26937a11_142af829499@dwillia2-xfh.jf.intel.com.notmuch>
 <ZH+RFGZqAoSEIHqT@aschofie-mobl2>
 <647f9aef8928d_1433ac294ee@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647f9aef8928d_1433ac294ee@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:45:35PM -0700, Dan Williams wrote:
> [ add Mike, see "[Mike]" note below... ]
> 
> Alison Schofield wrote:
> > On Sat, Jun 03, 2023 at 04:53:13PM -0700, Dan Williams wrote:
> > > alison.schofield@ wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > > > over an HPA address range.
> > > > 
> > > > The initial use case is the ACPI driver that needs to extend
> > > > SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> > > 
> > > I feel like this demands more explanation because the "need" is not
> > > apparent. In fact its a Linux policy choice not a requirement. The next
> > > patch has some of this, but this story is needed earlier for someone
> > > that reads this patch first. Something like:
> > > 
> > 
> > Hi Dan,
> > 
> > Thanks for the review :)
> > 
> > Sure, I can add the story below to make the 'need' for this function
> > more apparent, as well as s/needs/want so as not to conflate need with
> > requirement.
> > 
> > > ---
> > > 
> > > The CFWMS is an ACPI data structure that indicates *potential* locations
> > > where CXL memory can be placed. It is the playground where the CXL
> > > driver has free reign to establish regions.  That space can be populated
> > > by BIOS created regions, or driver created regions, after hotplug or
> > > other reconfiguration.
> > > 
> > > When the BIOS creates a region in a CXL Window it additionally describes
> > > that subset of the Window range in the other typical ACPI tables SRAT,
> > > SLIT, and HMAT. The rationale for the BIOS not pre-describing the entire
> > > CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> > > future. I.e. there is nothing stopping higher or lower performance
> > > devices being placed in the same Window. Compare that to ACPI memory
> > > hotplug that just onlines additional capacity in the proximity domain
> > > with little freedom for dynamic performance differentiation.
> > > 
> > > That leaves the OS with a choice, should unpopulated window capacity
> > > match the proximity domain of an existing region, or should it allocate
> > > a new one? This patch takes the simple position of minimizing proximity
> > > domain proliferation and reuse any proximity domain intersection for the
> > > entire Window. If the Window has no intersections then allocate a new
> > > proximity domain. Note that SRAT, SLIT and HMAT information can be
> > > enumerated dynamically in a standard way from device provided data.
> > > Think of CXL as the end of ACPI needing to describe memory attributes,
> > > CXL offers a standard discovery model for performance attributes, but
> > > Linux still needs to interoperate with the old regime.
> > > 
> > > ---
> > > 
> > > > 
> > > > The APCI driver expects to use numa_fill_memblks() while parsing
> > > 
> > > s/APCI/ACPI/
> > > 
> > > Again, the ACPI code does not have any expectation, this is pure OS
> > > policy decision about how to handle undescribed memory.
> > > 
> > 
> > The intent was to show the pending use case, perhaps 'wants to' use
> > this function to enact a purely OS policy decision!
> 
> Sounds good, yeah I tend to read "need" as a requirement and assume that
> Linux is out of spec or something breaks if it does not do the needed
> thing.
> 
> > 
> > 
> > > > the CFMWS. Extending the memblks created during SRAT parsing, to
> > > > cover the entire CFMWS Window, is desirable because everything in
> > > > a CFMWS Window is expected to be of a similar performance class.
> > > > 
> > > > Requires CONFIG_NUMA_KEEP_MEMINFO.
> > > 
> > > Not sure this adds anything to the description.
> > > 
> > > > 
> > > > [1] A CXL CFMWS Window represents a contiguous CXL memory resource,
> > > > aka an HPA range. The CFMWS (CXL Fixed Memory Window Structure) is
> > > > part of the ACPI CEDT (CXL Early Discovery Table).
> > > > 
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > ---
> > > >  arch/x86/include/asm/sparsemem.h |  2 +
> > > >  arch/x86/mm/numa.c               | 82 ++++++++++++++++++++++++++++++++
> > > >  include/linux/numa.h             |  7 +++
> > > >  3 files changed, 91 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> > > > index 64df897c0ee3..1be13b2dfe8b 100644
> > > > --- a/arch/x86/include/asm/sparsemem.h
> > > > +++ b/arch/x86/include/asm/sparsemem.h
> > > > @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
> > > >  #define phys_to_target_node phys_to_target_node
> > > >  extern int memory_add_physaddr_to_nid(u64 start);
> > > >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > > > +extern int numa_fill_memblks(u64 start, u64 end);
> > > > +#define numa_fill_memblks numa_fill_memblks
> > > 
> > > What is this for? The other defines are due to being an arch-specific
> > > API and the #define is how the arch declares that it has a local version
> > > to replace the generic one.
> > 
> > That define, along with the numa.h change below, are to support builds of
> > CONFIG_ARM64 and CONFIG_LOONGARCH, both include the caller acpi_parse_cfmws(),
> > of numa_fill_memblks().
> 
> [Mike]
> 
> Hmm, ok, but this is piling onto the maintenance burden of x86 not
> getting onboard with memblock for numa info yet. At a minimum that
> avoidance of touching the ARM64 and LOONGARCH cases needs to be called
> out, but it would be useful to have a discussion about the options here
> with questions like:
> 
> - What's blocking x86 from switching to memblock?

To start with, someone need to work on it :)

There are some differences in how drivers/base/arch_numa.c and
arch/x86/mm/numa.c handle SRAT ranges. E.g. x86 checks that SRAT covers all
the memory reported by e820 and have this peculiar dance around hotplugable
memory for the sake of movable_node.
Another x86 specific thing that is build around numa_meminfo is the
numa_emulation.

I don't see a conceptual reason why arch_numa.c cannot handle x86, but
that's quite some work needed to make that happen.
 
> - Or, does the memblock API support what numa_fill_memblks() wants to
>   do? I.e. add a real numa_fill_memblks() implementation to
>   drivers/base/arch_numa.c rather than skip SRAT based fixups for the
>   generic case.
 
memblock does not have a notion of empty physical ranges, so it will
require a new set of regions to support what numa_fill_memblks() wants to
do.

With this patch numa_meminfo essentially becomes a superset of
memblock.memory and to have a generic implementation in
drivers/base/arch_numa.c this set should be kept somewhere.

> Last I remember it was the conceptual disconnect of x86 not marking Reserved
> ranges as memory like other architectures:
> 
> https://lore.kernel.org/all/20200708091520.GE128651@kernel.org/

This was more about e820 vs memblock, I don't think it's relevant here.
 
> ...but its been a while since this last came up and I have not been
> following memblock developments. Maybe the anwser is the same in the
> end, add x86-specific numa_fill_memblks, but this is as good a time as
> any to revisit carrying that burden.

I've been thinking about how to make arch_numa to support x86 and (sigh)
loongarch, and the simplest way looks like shoving numa_meminfo there and
then optimizing redundant pieces.

For CXL on arm64/riscv we'd need a new data structure for empty physical
ranges anyway at some point and numa_meminfo quite fits the requirements.
We can later reconsider numa_meminfo vs memblock relationship.

That said, add x86-specific numa_fill_memblks and revisit this later is a
option as well :)

-- 
Sincerely yours,
Mike.
