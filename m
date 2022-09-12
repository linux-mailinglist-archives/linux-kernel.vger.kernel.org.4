Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8E5B6241
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiILUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiILUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:36:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8777491EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663014972; x=1694550972;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYohu4G+JWcFUsq5o/u1kDMJywbtXpKuspQG8T5G+PQ=;
  b=ORfmZ5/+8ygMyOCZcBDhWmKS/j1VtOdb0nynjVKs4P6XHy3kHZNtvTcn
   QgFhIqpkNUDDHl3d6rOX0GpWFnKSWf6TzCyrxcCjuVlZln0biE7j8eBXI
   sVHNP/9QFKUKmlhRSRZ/Tajii8hkGqEScGxK75Rp0r7VgYjRW4TdVuYlm
   /TLLldftqUn4WlqpFwb1l6Hzy9HadJUTgivLmXTaHOYjDbyXi5wwxuX87
   LNme7VkhLfp08KufkDAI5RnTa3GOzGGL5phoZZ1FBKu0v5WGvdGta/bVO
   qj1cu8U8Im5ijqeLeWiO8doq9b/JjBO5x/Zm+e8pQuQnyit/OlUqqKc1H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359688879"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="359688879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 13:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="616196357"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 13:36:12 -0700
Date:   Mon, 12 Sep 2022 13:39:35 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@intel.com
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220912133935.3bb3e247@jacob-builder>
In-Reply-To: <Yxtk4gMbcVgTKzKg@araj-dh-work>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
        <YxDvpLb77lwb8zaT@araj-dh-work>
        <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
        <Yxtk4gMbcVgTKzKg@araj-dh-work>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On Fri, 9 Sep 2022 16:08:02 +0000, Ashok Raj <ashok_raj@linux.intel.com>
wrote:

> > diff --git a/arch/x86/include/uapi/asm/prctl.h
> > b/arch/x86/include/uapi/asm/prctl.h index a31e27b95b19..e5c04ced36c9
> > 100644 --- a/arch/x86/include/uapi/asm/prctl.h
> > +++ b/arch/x86/include/uapi/asm/prctl.h
> > @@ -23,5 +23,6 @@
> >  #define ARCH_GET_UNTAG_MASK		0x4001
> >  #define ARCH_ENABLE_TAGGED_ADDR		0x4002
> >  #define ARCH_GET_MAX_TAG_BITS		0x4003
> > +#define ARCH_ENABLE_TAGGED_ADDR_FORCED	0x4004
> >  
> >  #endif /* _ASM_X86_PRCTL_H */
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 337f80a0862f..7d89a2fd1a55 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -774,7 +774,8 @@ static bool lam_u48_allowed(void)
> >  #define LAM_U48_BITS 15
> >  #define LAM_U57_BITS 6
> >  
> > -static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned
> > long nr_bits) +static int prctl_enable_tagged_addr(struct mm_struct
> > *mm, unsigned long nr_bits,
> > +				    bool forced)
> >  {
> >  	int ret = 0;
> >  
> > @@ -793,6 +794,11 @@ static int prctl_enable_tagged_addr(struct
> > mm_struct *mm, unsigned long nr_bits) goto out;
> >  	}
> >  
> > +	if (pasid_valid(mm->pasid) && !forced) {
I don't think this works since we have lazy pasid free.  for example,
after all the devices did sva_unbind, mm->pasid  we'll remain valid until
mmdrop(). LAM  should be supported in this case.

Perhaps, we could introduce another prctl flag for SVA, PR_GET_SVA?
Both iommu driver and LAM can set/query the flag. LAM applications may not
be the only ones want to know if share virtual addressing is  on.

> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +

Thanks,

Jacob
