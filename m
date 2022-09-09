Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D55B3CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIIQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIIQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:08:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98E412B35D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662739680; x=1694275680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLOCowi08irFEhmbasnUIkWwZGfyH3C0HY33bJ60MTk=;
  b=RlcZfVp9b+iaZlQHTGhwIcryNrHA0EV9lFd99ppCHtqiInGJoGI4o5h1
   KxP5dDfAAhvWgqeacM9wmOo8tB0PdqOnLJXewCtY8ptJiSCEgtYrUqMwU
   uHX/O56qjIiR9TE/lZ+EXxFYCwF7HQ9hmalWh01/QzkplunSRDBGI0Mg7
   DMaFV5R8vChv9xMnu2vbejngxAi2xHs14l9wUeR2XZljdA2N+0txFFez8
   NopsHx+Uphc0uv+s9zoY2PW+Q6QlE/nftroHGCbEZMoOqvOcs4ETsMz88
   1O6aXeirMP3Vk/jn05WoQlesuXVi7FOdH9lAtLjtMvAHHShQV0Fy010Zu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="383804133"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="383804133"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:07:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="683686842"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:07:56 -0700
Date:   Fri, 9 Sep 2022 16:08:02 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yxtk4gMbcVgTKzKg@araj-dh-work>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:39:52AM +0300, Kirill A. Shutemov wrote:
> On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:
> > Hi Kirill,
> > 
> > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > 64-bit linear addresses, allowing software to use of the untranslated
> > > address bits for metadata.
> > 
> > We discussed this internally, but didn't bubble up here.
> > 
> > Given that we are working on enabling Shared Virtual Addressing (SVA)
> > within the IOMMU. This permits user to share VA directly with the device,
> > and the device can participate even in fixing page-faults and such.
> > 
> > IOMMU enforces canonical addressing, since we are hijacking the top order
> > bits for meta-data, it will fail sanity check and we would return a failure
> > back to device on any page-faults from device. 
> > 
> > It also complicates how device TLB and ATS work, and needs some major
> > improvements to detect device capability to accept tagged pointers, adjust
> > the devtlb to act accordingly. 
> > 
> > 
> > Both are orthogonal features, but there is an intersection of both
> > that are fundamentally incompatible.
> > 
> > Its even more important, since an application might be using SVA under the
> > cover provided by some library that's used without their knowledge.
> > 
> > The path would be:
> > 
> > 1. Ensure both LAM and SVM are incompatible by design, without major
> >    changes.
> >    	- If LAM is enabled already and later SVM enabling is requested by
> > 	  user, that should fail. and Vice versa.
> > 	- Provide an API to user to ask for opt-out. Now they know they
> > 	  must sanitize the pointers before sending to device, or the
> > 	  working set is already isolated and needs no work.
> 
> The patch below implements something like this. It is PoC, build-tested only.
> 
> To be honest, I hate it. It is clearly a layering violation. It feels
> dirty. But I don't see any better way as we tie orthogonal features
> together.
> 
> Also I have no idea how to make forced PASID allocation if LAM enabled.
> What the API has to look like?
> 
> Any comments?

Looking through it, it seems to be sane enough.. I feel dirty too :-) but
don't see a better way.

I'm Ccing JasonG since we are reworking the IOMMU interfaces right now, and
Jacob who is in the middle of some refactoring. 

> 
> > 2. I suppose for any syscalls that take tagged pointers you would maybe
> >    relax checks for how many bits to ignore for canonicallity. This is
> >    required so user don't need to do the same for everything sanitization
> >    before every syscall. 
> 
> I'm not quite follow this. For syscalls that allow tagged pointers, we do
> untagged_addr() now. Not sure what else needed.
> 
> > If you have it fail, the library might choose a less optimal path if one is
> > available.
> > 
> > Cheers,
> > Ashok
> 
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index a31e27b95b19..e5c04ced36c9 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -23,5 +23,6 @@
>  #define ARCH_GET_UNTAG_MASK		0x4001
>  #define ARCH_ENABLE_TAGGED_ADDR		0x4002
>  #define ARCH_GET_MAX_TAG_BITS		0x4003
> +#define ARCH_ENABLE_TAGGED_ADDR_FORCED	0x4004
>  
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 337f80a0862f..7d89a2fd1a55 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -774,7 +774,8 @@ static bool lam_u48_allowed(void)
>  #define LAM_U48_BITS 15
>  #define LAM_U57_BITS 6
>  
> -static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits,
> +				    bool forced)
>  {
>  	int ret = 0;
>  
> @@ -793,6 +794,11 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>  		goto out;
>  	}
>  
> +	if (pasid_valid(mm->pasid) && !forced) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	if (!nr_bits) {
>  		ret = -EINVAL;
>  		goto out;
> @@ -910,7 +916,9 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>  		return put_user(task->mm->context.untag_mask,
>  				(unsigned long __user *)arg2);
>  	case ARCH_ENABLE_TAGGED_ADDR:
> -		return prctl_enable_tagged_addr(task->mm, arg2);
> +		return prctl_enable_tagged_addr(task->mm, arg2, false);
> +	case ARCH_ENABLE_TAGGED_ADDR_FORCED:
> +		return prctl_enable_tagged_addr(task->mm, arg2, true);
>  	case ARCH_GET_MAX_TAG_BITS: {
>  		int nr_bits;
>  
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..a6ec17de1937 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/mutex.h>
>  #include <linux/sched/mm.h>
> +#include <asm/mmu_context.h>
>  
>  #include "iommu-sva-lib.h"
>  
> @@ -32,6 +33,15 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  		return -EINVAL;
>  
>  	mutex_lock(&iommu_sva_lock);
> +
> +	/* Serialize against LAM enabling */
> +	mutex_lock(&mm->context.lock);
> +
> +	if (mm_lam_cr3_mask(mm)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
>  	/* Is a PASID already associated with this mm? */
>  	if (pasid_valid(mm->pasid)) {
>  		if (mm->pasid < min || mm->pasid >= max)
> @@ -45,6 +55,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	else
>  		mm_pasid_set(mm, pasid);
>  out:
> +	mutex_unlock(&mm->context.lock);
>  	mutex_unlock(&iommu_sva_lock);
>  	return ret;
>  }
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
