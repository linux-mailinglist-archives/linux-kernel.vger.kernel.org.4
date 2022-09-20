Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB15BE96F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiITO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiITO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:57:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0961EAC9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663685844; x=1695221844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvCoWXC5l0s95QFD5U8TCexD257nOCbyPLfqtS7D3tA=;
  b=HOElLBQJNgKO7FK091pFxrUT4PyaPwP4y4iuHX07qsSgnFtdEvLLhR3x
   v9QWq3AZQP0CefH9dg0wcj1xHrmC8FzRd0CcwVdHKw66k89J2xQO9TvHo
   RKWub0r0NVPkkgsfwGIUHbQvEkDr3lzY+Ing5E6h/2OeO181FhSHvxgVk
   N764ie3PgtzUXuEdIZZ34FtQRfiVEhCMNOVrEpY2tXHapHu+9I4cMf7JL
   1h/90UT3ipBmkmBqACfNTXqa5b4HUxqI6FeH0C0rsxw64zGUl6Z3+qOrp
   J7SDLjhRnqcMEiqhFVXejKG/LZdLOSrVbKa+uO03x3zaWArhOGdGszdX+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301095915"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301095915"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:57:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="687441949"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:57:01 -0700
Date:   Tue, 20 Sep 2022 14:57:04 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YynUwJ30QywipsxO@araj-dh-work>
References: <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <Yym8zsuXbYaW3alU@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yym8zsuXbYaW3alU@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:14:54AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 15, 2022 at 08:28:58PM +0300, Kirill A. Shutemov wrote:
> 
> > @@ -31,7 +33,17 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> >  	    min == 0 || max < min)
> >  		return -EINVAL;
> >  
> > +	/* Serialize against address tagging enabling */
> > +	if (mmap_write_lock_killable(mm))
> > +		return -EINTR;
> > +
> > +	if (!arch_can_alloc_pasid(mm)) {
> > +		mmap_write_unlock(mm);
> > +		return -EBUSY;
> > +	}
> 
> This has nothing to do with "allocating pasid"
> 
> Rather should be: "is the CPU page table compatible with the IOMMU HW
> page table walker"

Thanks Jason, this certainly looks like a more logical way to look at it
rather than the functional association of allocating pasids. 

> 
> For this I would rather have a function that queries the format of the
> page table under the mm_struct and we have enum values like
> INTEL_NORMAL and INTEL_LAM as possible values.
> 
> The iommu driver will block incompatible page table formats, and when
> it starts up it should assert something that blocks changing the
> format.
> 
> Jason
> 
