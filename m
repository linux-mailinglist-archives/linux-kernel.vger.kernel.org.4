Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9890C5B63D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiILWtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiILWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:49:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA9F62CD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663022979; x=1694558979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NsiOox7nfIPNPbqeXi04s08cExYxbUI6A8GPKqPLH8c=;
  b=Uf/SR0VCmoWZxvio96+oGGz9Ukdd7lOVch8uJBZXx+a5YwMp4PKBLSQY
   RoFWbroa8iEGKWBTO2RGrnA909IiR+gc/yxeLChdcEoswzl+kSzXpJGZE
   bn+KQDI02gQbn+V4AurzukrKUs8NmgXuNMrPIsMolfgl3dkGI6FVQXbbP
   fzk6RveJ4cpuVLMScy0LOPJ/NioI3E9rYlzww5md2W+qBowpkDn/SaTfI
   hSfdTs0z/FB8deXorEEWlsXnZiON62tkAOB+4OlHDK2bxVFAd0uoIX61/
   jIpk7COyAQMHyER11ZO4wF6jqcgmkoTuacZdvnfQc1jKN7Ta5Lt8+JMd+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285008273"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="285008273"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:49:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="616234521"
Received: from aburgsta-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.142])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:49:33 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E30D610455B; Tue, 13 Sep 2022 01:49:30 +0300 (+03)
Date:   Tue, 13 Sep 2022 01:49:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>,
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
Message-ID: <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Jacob, Ashok, any comment on this part?

I expect in many cases LAM will be enabled very early (like before malloc
is functinal) in process start and it makes PASID allocation always fail.

Any way out?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
