Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249EE5E7765
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiIWJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiIWJit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:38:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E45BF1877
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663925914; x=1695461914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r/i0i0SbliPYGtD9iHbXgqL0bdCmXHR1pywmanT4gGo=;
  b=iVL5izESYRmSO4CNoOmQZaUwVroTpNRc4eRLdJ6+9tQiOd0MNLu93GgI
   Lc8SLAFRYcCG+eGxnIOLrMB5RYbW8s6+LzyOeBPV3O/wq0SbWlRNq5JnN
   coD/itrCrDPdAf0zr74jzduDxRBajQ7pJuFxXntlBieaKnbEMtO3Kqr/j
   r6/B9M4LGb4ob9ZP1E0ln0brUrYkRO3nZPrbA9UtozhTuNs+X30f+LXt0
   f0dzU04i5CvzmnJ2Xx/3BSzu9x1yP0dONoW1rqXdE/AVyxMj2bldKsdHZ
   u7fmWPFXHkq/VWKpBDMehtZB2U/6aHwpbiuFxiy9itZSRbfu0P0TsSipp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287671019"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287671019"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:38:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="709242525"
Received: from pameiner-mobl2.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.58.236])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 02:38:29 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 83761104B0F; Fri, 23 Sep 2022 12:38:26 +0300 (+03)
Date:   Fri, 23 Sep 2022 12:38:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
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
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
References: <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
 <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
 <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:27:45PM -0700, Ashok Raj wrote:
> On Fri, Sep 23, 2022 at 03:42:39AM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 21, 2022 at 03:11:34PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 21, 2022 at 10:11:46AM -0700, Dave Hansen wrote:
> > > 
> > > > Are you saying that any device compatibility with an mm is solely
> > > > determined by the IOMMU in play, so the IOMMU code should host the mm
> > > > compatibility checks?
> > > 
> > > Yes, exactly. Only the HW entity that walks the page tables needs to
> > > understand their parsing rules and in this case that is only the IOMMU
> > > block.
> > 
> > But device has to know what bits of the virtual address are significant to
> > handle device TLB lookup/store correctly, no?
> 
> For a device that also cares about tagging, yes. But in the current
> world we don't have such devices. IOMMU only knows about the shared cr3
> we placed in the PASID table entries to walk page-tables. I hope the
> page-tables don't factor the meta-data bits correct?

Correct. Page tables contain only physical addresses, so they have no
exposure to tags in the virtual addresses.

> So I would assume an untagged pointer should just be fine for the IOMMU
> to walk. IOMMU currently wants canonical addresses for VA.

Right. But it means that LAM compatibility can be block on two layers:
IOMMU and device. IOMMU is not the only HW entity that has to be aware of
tagged pointers.

So where to put compatibility check that can cover both device and IOMMU,
considering that in the future they can get aware about tagged pointers?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
