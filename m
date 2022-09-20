Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA265BEEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiITUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiITUlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:41:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACF760CA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663706462; x=1695242462;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5B8c5MXp1hEObMkypCXkrbZfgzUq4/NSpYQJZ8KGBQ=;
  b=O/26Bjp8VmSEvNLvqxIlnEoHLAAm8MWjdz6GKvF6O4xdMwUDzG6375zM
   zTbgo6Lj/kNfZdkFkAIEq5SIwPra5x64thl8EEWRCzTbTxE7uYceHfyF+
   kFhOA9oYeYM27DuMnYUSZebjgdV/eWiYlE/pwF6XLSDA0xcZ6FRAYjdBe
   zIdvZzdSL8A1+i8wdd7zQyOI6bKnoHxOsAkrkDwx7Gei6Pt28SAPvva9R
   XBTHjrF+NfX2YNc0UHi4ETDDcvwSNe4bW8PlbYUk3E8uoZbyE4kCSJ925
   xpSsCNYgFyqDMrmUv7W1S+5kxl7PcZ9S3FUCDqhmRyPMP2GHfp/FLoYg7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363790336"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="363790336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 13:41:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="614535902"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 13:41:02 -0700
Date:   Tue, 20 Sep 2022 13:44:30 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
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
        Joerg Roedel <joro@8bytes.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220920134430.20111b7f@jacob-builder>
In-Reply-To: <YyoLedkOx59KUjSw@nvidia.com>
References: <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
        <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
        <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
        <20220914165116.24f82d74@jacob-builder>
        <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
        <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
        <Yym8zsuXbYaW3alU@nvidia.com>
        <15741fdf-68b6-bd32-b0c2-63fde3bb0db2@intel.com>
        <Yynp77km4SaHpe/3@nvidia.com>
        <20220920113742.277ac497@jacob-builder>
        <YyoLedkOx59KUjSw@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 20 Sep 2022 15:50:33 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 20, 2022 at 11:41:04AM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 20 Sep 2022 13:27:27 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Tue, Sep 20, 2022 at 09:06:32AM -0700, Dave Hansen wrote:  
> > > > On 9/20/22 06:14, Jason Gunthorpe wrote:    
> > > > > For this I would rather have a function that queries the format
> > > > > of the page table under the mm_struct and we have enum values like
> > > > > INTEL_NORMAL and INTEL_LAM as possible values.
> > > > > 
> > > > > The iommu driver will block incompatible page table formats, and
> > > > > when it starts up it should assert something that blocks changing
> > > > > the format.    
> > > > 
> > > > That doesn't sound too bad.  Except, please don't call it a "page
> > > > table format".  The format of the page tables does not change with
> > > > LAM.  It's entirely how the CPU interprets addresses that changes.
> > > >   
> > > 
> > > Sure it does. The rules for how the page table is walked change. The
> > > actual bits stored in memory might not be different, but that doesn't
> > > mean the format didn't change. If it didn't change we wouldn't have an
> > > incompatibility with the IOMMU HW walker.  
> > 
> > There are many CPU-IOMMU compatibility checks before we do for SVA,e.g.
> > we check paging mode in sva_bind. We are delegating these checks in
> > arch/platform code. So why can't we let arch code decide how to convey
> > mm-IOMMU SVA compatibility? let it be a flag ( as in this patch) or some
> > callback.  
> 
> In general I'm not so keen on arch unique code for general ideas like
> this (ARM probably has the same issue), but sure it could work.
> 
Creating an abstraction seems to belong to a separate endeavor when we
have more than one user. For now, are you ok with  the current approach?

> > Perhaps a more descriptive name
> > s/arch_can_alloc_pasid(mm)/arch_can_support_sva(mm)/ is all we
> > disagreeing :)  
> 
> Except that still isn't what it is doing. "sva" can mean lots of
> things.
True, but sharing page table is the root cause of the incompatibility.
IMHO, SVA means sharing page table  at the highest level.

> You need to assert that the page table format is one of the
> formats that the iommu understands and configure the iommu to match
> it. It is a very simple question about what ruleset and memory layout
> govern the page table memory used by the CPU.
the problem is more relevant to  things like  canonical address
requirement  than  page table format.

> And I think every CPU should be able to define a couple of their
> configurations in some enum, most of the PTE handling code is all
> hardwired, so I don't think we really support that many combinations
> anyhow?
sounds like a nice but separate effort,  I don't know enough here.


Thanks,

Jacob
