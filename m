Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC506035EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRWdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJRWdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:33:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9DAB2DB1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132429; x=1697668429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKAjNebD3x+hLBGIM8BspEWuV37YHAG5FIG0wLgK6Bk=;
  b=a3P/aLYL/D1eAREYDbVp5OVQf5walDzhHO/dt37LXv5K5k52/OKrp5RF
   zCLN0nF923JxEcEVSb98IF7ynaVmgBJ8qFkCV9MXrV5BRLIPjBubbVAix
   gp8fR/1jcgtVBbzHYzX5D18nj9k5hK4xVKwAbtyZk+PJECPmtmvqZ24Qh
   +tvl+bpVEwcfTh806kM5SgXEUAudLABos+v4p7FppCzexwflbh0v3TI9+
   VmN6JLgF+EOxs8DvO155xQOGd65JwAHAj/a421yjVjuKP41NKby5r8qNs
   mzXX2d9sIpHVTQpX7kRiui5xUei6BerLtricnljdez34qrJtdXm8UT709
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370471167"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="370471167"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:33:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="628946034"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="628946034"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:33:44 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7DA88104BA9; Wed, 19 Oct 2022 01:33:41 +0300 (+03)
Date:   Wed, 19 Oct 2022 01:33:41 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Message-ID: <20221018223341.tiyypudh6k63mnnb@box.shutemov.name>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
 <eb590d2c-581a-03e0-863c-0a33a20ae772@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb590d2c-581a-03e0-863c-0a33a20ae772@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:00:38PM -0700, Dave Hansen wrote:
> > diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> > index b0e9ea23758b..6b9ac2c60cec 100644
> > --- a/arch/x86/include/asm/mmu_context.h
> > +++ b/arch/x86/include/asm/mmu_context.h
> > @@ -113,6 +113,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
> >  	mm->context.untag_mask = -1UL;
> >  }
> >  
> > +#define arch_pgtable_dma_compat(mm)	\
> > +	(!mm_lam_cr3_mask(mm) || (mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVM))
> >  #else
> 
> This needs to be a 'static inline' unless there's a compelling and
> documented reason that it can't be.

Seems work fine.

> >  static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> > diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> > index a31e27b95b19..7bd22defb558 100644
> > --- a/arch/x86/include/uapi/asm/prctl.h
> > +++ b/arch/x86/include/uapi/asm/prctl.h
> > @@ -23,5 +23,6 @@
> >  #define ARCH_GET_UNTAG_MASK		0x4001
> >  #define ARCH_ENABLE_TAGGED_ADDR		0x4002
> >  #define ARCH_GET_MAX_TAG_BITS		0x4003
> > +#define ARCH_FORCE_TAGGED_SVM		0x4004
> >  
> >  #endif /* _ASM_X86_PRCTL_H */
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 9952e9f517ec..8faa8774bb93 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -783,6 +783,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_IOMMU_SVA
> > +	if (pasid_valid(mm->pasid) &&
> > +	    !(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVM)) {
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +#endif
> 
> Is this #ifdef really necessary?  CONFIG_IOMMU_SVA selects IOASID,
> without which pasid_valid() is just stubbed out to 0.

mm->pasid is only defined for CONFIG_IOMMU_SVA=y.

Do you want me to add mm_has_valid_pasid()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
