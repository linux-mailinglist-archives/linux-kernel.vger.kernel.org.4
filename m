Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964685B8BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiINPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiINPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:18:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132F80485
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663168706; x=1694704706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTQ3Q+JplMOJK966x5fjnamI5N8tHqH9BVxtx4/dwew=;
  b=hF7WUaBMq0zb/m6WHtsLJV3m+xqe1qVMt9//lH5+A3dbi5Kzddmb0vFM
   nIusP+GAGIyBzdoa1+tUarpqZ4kU/mK2TpLDS8nBHfvu5GsziQzLxd/I0
   lTdZoiGwIY24g6QQ/9dITMJqQAXCBWBpguD1oqQDZcfgVqhS9IF+7gEsA
   oKjQcPpdgEj2tiiVHLhi+cKJVrfKTfdtAB4Z4Q/eCOKJmH39y6WzVfEfC
   xGv2tybt71EcV+9AgmESCYns+uUOjrGhrpXtEtz8DHY/yOwfLkpdr7r/n
   ceNnaWInYkwgG/CriwYQz4iQo2MWFVjaEAxaFctwZ8KAmFXt4wtf5LZQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298453965"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="298453965"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:18:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="679089978"
Received: from gcapodan-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.179])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 08:18:21 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 76E0010466D; Wed, 14 Sep 2022 18:18:18 +0300 (+03)
Date:   Wed, 14 Sep 2022 18:18:18 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ashok Raj <ashok.raj@intel.com>
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
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:11:19AM -0700, Ashok Raj wrote:
> On Wed, Sep 14, 2022 at 05:45:18PM +0300, Kirill A. Shutemov wrote:
> > On Tue, Sep 13, 2022 at 01:49:30AM +0300, Kirill A. Shutemov wrote:
> > > On Sun, Sep 04, 2022 at 03:39:52AM +0300, Kirill A. Shutemov wrote:
> > > > On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:
> > > > > Hi Kirill,
> > > > > 
> > > > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > > > > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > > > > 64-bit linear addresses, allowing software to use of the untranslated
> > > > > > address bits for metadata.
> > > > > 
> > > > > We discussed this internally, but didn't bubble up here.
> > > > > 
> > > > > Given that we are working on enabling Shared Virtual Addressing (SVA)
> > > > > within the IOMMU. This permits user to share VA directly with the device,
> > > > > and the device can participate even in fixing page-faults and such.
> > > > > 
> > > > > IOMMU enforces canonical addressing, since we are hijacking the top order
> > > > > bits for meta-data, it will fail sanity check and we would return a failure
> > > > > back to device on any page-faults from device. 
> > > > > 
> > > > > It also complicates how device TLB and ATS work, and needs some major
> > > > > improvements to detect device capability to accept tagged pointers, adjust
> > > > > the devtlb to act accordingly. 
> > > > > 
> > > > > 
> > > > > Both are orthogonal features, but there is an intersection of both
> > > > > that are fundamentally incompatible.
> > > > > 
> > > > > Its even more important, since an application might be using SVA under the
> > > > > cover provided by some library that's used without their knowledge.
> > > > > 
> > > > > The path would be:
> > > > > 
> > > > > 1. Ensure both LAM and SVM are incompatible by design, without major
> > > > >    changes.
> > > > >    	- If LAM is enabled already and later SVM enabling is requested by
> > > > > 	  user, that should fail. and Vice versa.
> > > > > 	- Provide an API to user to ask for opt-out. Now they know they
> > > > > 	  must sanitize the pointers before sending to device, or the
> > > > > 	  working set is already isolated and needs no work.
> > > > 
> > > > The patch below implements something like this. It is PoC, build-tested only.
> > > > 
> > > > To be honest, I hate it. It is clearly a layering violation. It feels
> > > > dirty. But I don't see any better way as we tie orthogonal features
> > > > together.
> > > > 
> > > > Also I have no idea how to make forced PASID allocation if LAM enabled.
> > > > What the API has to look like?
> > > 
> > > Jacob, Ashok, any comment on this part?
> > > 
> > > I expect in many cases LAM will be enabled very early (like before malloc
> > > is functinal) in process start and it makes PASID allocation always fail.
> > > 
> > > Any way out?
> > 
> > We need closure on this to proceed. Any clue?
> 
> Failing PASID allocation seems like the right thing to do here. If the
> application is explicitly allocating PASID's it can opt-out using the
> similar mechanism you have for LAM enabling. So user takes
> responsibility for sanitizing pointers. 
> 
> If some library is using an accelerator without application knowledge,
> that would use the failure as a mechanism to use an alternate path if
> one exists.
> 
> I don't know if both LAM and SVM need a separate forced opt-in (or i
> don't have an opinion rather). Is this what you were asking? 
> 
> + Joerg, JasonG in case they have an opinion.

My point is that the patch provides a way to override LAM vs. PASID mutual
exclusion, but only if PASID allocated first. If we enabled LAM before
PASID is allcoated there's no way to forcefully allocate PASID, bypassing
LAM check. I think there should be one, no?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
