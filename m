Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5591A5B647E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIMASr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIMASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:18:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E774D152
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663028324; x=1694564324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vyxNfHiu1yBIsD+JdVqtDsM5kvNufgvLVlVtxdTjKnM=;
  b=Md/CJqNrZZU440j4Cv9Kda68ZErpte7+rs8ov0gk+jRkISX4KBfil+sF
   2aeuePpwGmboeQffvgigXzRt0QavJti8in+v/WubMyPtWDl3J2YvQQDTX
   wkBsaOK/lj6yToXv9e0e9WAkWJClxnd6LNNoG1kZNYJ86L23JsOqVjlbu
   PlFqkcinynoc6jiQFt9tdJPqERCJ6Dv/IU6jV1Xn5JOMio0fHUz3FgTuV
   07VIk8KWd65yKH5c/WMszQx4CTMolZBDAdE+tDfqf4kBfcfNVqMvFJk64
   SVFZ1e0NufVT82SUn70xWddtGmDeLUAeopZGHYuMGOfVUCRmMQt35cpL9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277734690"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="277734690"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:18:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="758584323"
Received: from aburgsta-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:18:40 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E298810455B; Tue, 13 Sep 2022 03:18:37 +0300 (+03)
Date:   Tue, 13 Sep 2022 03:18:37 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220913001837.uvsxevxhcqrkzjed@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220912170809.101fa976@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912170809.101fa976@jacob-builder>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 05:08:09PM -0700, Jacob Pan wrote:
> Hi Kirill,
> 
> On Tue, 13 Sep 2022 01:49:30 +0300, "Kirill A. Shutemov"
> <kirill.shutemov@linux.intel.com> wrote:
> 
> > On Sun, Sep 04, 2022 at 03:39:52AM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:  
> > > > Hi Kirill,
> > > > 
> > > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:  
> > > > > Linear Address Masking[1] (LAM) modifies the checking that is
> > > > > applied to 64-bit linear addresses, allowing software to use of the
> > > > > untranslated address bits for metadata.  
> > > > 
> > > > We discussed this internally, but didn't bubble up here.
> > > > 
> > > > Given that we are working on enabling Shared Virtual Addressing (SVA)
> > > > within the IOMMU. This permits user to share VA directly with the
> > > > device, and the device can participate even in fixing page-faults and
> > > > such.
> > > > 
> > > > IOMMU enforces canonical addressing, since we are hijacking the top
> > > > order bits for meta-data, it will fail sanity check and we would
> > > > return a failure back to device on any page-faults from device. 
> > > > 
> > > > It also complicates how device TLB and ATS work, and needs some major
> > > > improvements to detect device capability to accept tagged pointers,
> > > > adjust the devtlb to act accordingly. 
> > > > 
> > > > 
> > > > Both are orthogonal features, but there is an intersection of both
> > > > that are fundamentally incompatible.
> > > > 
> > > > Its even more important, since an application might be using SVA
> > > > under the cover provided by some library that's used without their
> > > > knowledge.
> > > > 
> > > > The path would be:
> > > > 
> > > > 1. Ensure both LAM and SVM are incompatible by design, without major
> > > >    changes.
> > > >    	- If LAM is enabled already and later SVM enabling is
> > > > requested by user, that should fail. and Vice versa.
> > > > 	- Provide an API to user to ask for opt-out. Now they know
> > > > they must sanitize the pointers before sending to device, or the
> > > > 	  working set is already isolated and needs no work.  
> > > 
> > > The patch below implements something like this. It is PoC, build-tested
> > > only.
> > > 
> > > To be honest, I hate it. It is clearly a layering violation. It feels
> > > dirty. But I don't see any better way as we tie orthogonal features
> > > together.
> > > 
> > > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > > What the API has to look like?  
> > 
> > Jacob, Ashok, any comment on this part?
> > 
> > I expect in many cases LAM will be enabled very early (like before malloc
> > is functinal) in process start and it makes PASID allocation always fail.
> > 
> Is there a generic flag LAM can set on the mm?

Hm. Not really.

I thought we can use untagged_addr(mm, -1UL) != -1UL as such check, but
-1UL is kernel address and untagged_addr() would not untag such address
for LAM.

I guess we can make add a helper for this.

But tagged address implementation is rather different across different
platforms and semantic can be hard to define. Like if the tagged addresses
support per-thread or per-process. Or maybe it is global.

Maybe just add arch hook there? arch_can_alloc_pasid(mm) or something.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
