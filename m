Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C46035FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJRWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRWft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:35:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6669CBFE5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666132545; x=1697668545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qH3n/SenWLQ3oGvpoCfUDd6WBE2EAQyaCFEJgfz9kh4=;
  b=Hd2f2V6RjYS7VMyC4Qg0e7+aPOkh/CoArr5SU4QNsrB4ZLNey5ZbY2eS
   aeE28+ZUhoD/t74Q86fZXM8hIi6x2Kl4ieEurFGfx9lRLVsrDJEbDmPgD
   QzvdD9MGUoaYOf9hogB3f0+e9J//tHFmm7hb02e9rimSZ40VJ4hkdpCoW
   c4kS9VnDc7ig8Q0BqPqqfDsongvKWDGWWNAbdz7yobtKLD/MXkj8qCReo
   aEraRCgW4x+zQnDZuTW+gOxOhOAgQtJHU88nm93KXLJUqywn3M4WYqXpg
   zIJxWOHkwzoqfMKhOA7nSA9Z9fLcKZKBCg6J5TKYWDiI+kXpZn/XfDByE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370471388"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="370471388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:35:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="662140048"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="662140048"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:35:40 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D1359104BA9; Wed, 19 Oct 2022 01:35:37 +0300 (+03)
Date:   Wed, 19 Oct 2022 01:35:37 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Message-ID: <20221018223537.7bmhuknclkboqgnk@box.shutemov.name>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
 <Y08HgXqvNSpTUgWe@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y08HgXqvNSpTUgWe@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:07:29PM -0700, Ashok Raj wrote:
> On Tue, Oct 18, 2022 at 02:33:53PM +0300, Kirill A. Shutemov wrote:
> > IOMMU and SVM-capable devices know nothing about LAM and only expect
> > canonical addresses. Attempt to pass down tagged pointer will lead to
> > address translation failure.
> > 
> > By default do not allow to enable both LAM and use SVM in the same
> > process.
> > 
> > The new ARCH_FORCE_TAGGED_SVM arch_prctl() overrides the limitation.
> > By using the arch_prctl() userspace takes responsibility to never pass
> > tagged address to the device.
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Thanks!

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mmu.h         |  6 ++++--
> >  arch/x86/include/asm/mmu_context.h |  2 ++
> >  arch/x86/include/uapi/asm/prctl.h  |  1 +
> >  arch/x86/kernel/process_64.c       | 13 +++++++++++++
> >  drivers/iommu/iommu-sva-lib.c      | 12 ++++++++++++
> >  include/linux/mmu_context.h        |  4 ++++
> >  6 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> > index 2fdb390040b5..cce9b32b0d6d 100644
> > --- a/arch/x86/include/asm/mmu.h
> > +++ b/arch/x86/include/asm/mmu.h
> > @@ -9,9 +9,11 @@
> >  #include <linux/bits.h>
> >  
> >  /* Uprobes on this MM assume 32-bit code */
> > -#define MM_CONTEXT_UPROBE_IA32	BIT(0)
> > +#define MM_CONTEXT_UPROBE_IA32		BIT(0)
> >  /* vsyscall page is accessible on this MM */
> > -#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
> > +#define MM_CONTEXT_HAS_VSYSCALL		BIT(1)
> 
> Nit: Looks like the two above format changes got in here :-)

That's side effect of keeping the new longer flag aligned to the rest.

A separate patch looks like an overkill, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
