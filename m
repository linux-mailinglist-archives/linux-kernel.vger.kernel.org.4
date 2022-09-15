Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A25B96DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIOJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIOJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:01:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25757240A8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663232503; x=1694768503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXSem49F4lIICp1fQTxA40fFD7UcgAWqfAetQ90xX8M=;
  b=OQ7KVouhsdcQNVy5veqWzSxXeknMd+tz4va3J6r4tsH5JiItn1ZqL4R6
   To7rtHP1A6ZHmnPTYzCnM3JGXg/TYot6o6syZ+ccNAYoqfAxgZ2wn7Ppe
   uCGpjqTsYWbVTKJi1y3BdtTIabeUP3y7OKjahruiVHP/k2sqfIKPKoSTu
   j4HvhyTu+j5rKgB9P9fkf2DaK+srk6u/LZnL4Vz5L5JdXsfT81Sa9kOAt
   k6GkaoVi3sp18dy4uCWc/nb/CI9hRzLfHflmXnPgpbIHnu6ec/05/1eJR
   g74ym5jJsTVOu5buWNT9GGrLOF0opaHJkTogIoxKRKnExEZPFlqIcdpe8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="279043664"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="279043664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:01:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="679423455"
Received: from gnogale1-mobl2.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.209.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 02:01:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D76AB10466F; Thu, 15 Sep 2022 12:01:35 +0300 (+03)
Date:   Thu, 15 Sep 2022 12:01:35 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914165116.24f82d74@jacob-builder>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:51:16PM -0700, Jacob Pan wrote:
> Hi Kirill,
> 
> On Wed, 14 Sep 2022 18:45:32 +0300, "Kirill A. Shutemov"
> <kirill.shutemov@linux.intel.com> wrote:
> 
> > On Wed, Sep 14, 2022 at 08:31:56AM -0700, Ashok Raj wrote:
> > > On Wed, Sep 14, 2022 at 06:18:18PM +0300, Kirill A. Shutemov wrote:  
> > > > > > > > 
> > > > > > > > The patch below implements something like this. It is PoC,
> > > > > > > > build-tested only.
> > > > > > > > 
> > > > > > > > To be honest, I hate it. It is clearly a layering violation.
> > > > > > > > It feels dirty. But I don't see any better way as we tie
> > > > > > > > orthogonal features together.
> > > > > > > > 
> > > > > > > > Also I have no idea how to make forced PASID allocation if
> > > > > > > > LAM enabled. What the API has to look like?  
> > > > > > > 
> > > > > > > Jacob, Ashok, any comment on this part?
> > > > > > > 
> > > > > > > I expect in many cases LAM will be enabled very early (like
> > > > > > > before malloc is functinal) in process start and it makes PASID
> > > > > > > allocation always fail.
> > > > > > > 
> > > > > > > Any way out?  
> > > > > > 
> > > > > > We need closure on this to proceed. Any clue?  
> > > > > 
> > > > > Failing PASID allocation seems like the right thing to do here. If
> > > > > the application is explicitly allocating PASID's it can opt-out
> > > > > using the similar mechanism you have for LAM enabling. So user takes
> > > > > responsibility for sanitizing pointers. 
> > > > > 
> > > > > If some library is using an accelerator without application
> > > > > knowledge, that would use the failure as a mechanism to use an
> > > > > alternate path if one exists.
> > > > > 
> > > > > I don't know if both LAM and SVM need a separate forced opt-in (or i
> > > > > don't have an opinion rather). Is this what you were asking? 
> > > > > 
> > > > > + Joerg, JasonG in case they have an opinion.  
> > > > 
> > > > My point is that the patch provides a way to override LAM vs. PASID
> > > > mutual exclusion, but only if PASID allocated first. If we enabled
> > > > LAM before PASID is allcoated there's no way to forcefully allocate
> > > > PASID, bypassing LAM check. I think there should be one, no?  
> > > 
> > > Yes, we should have one for force enabling SVM too if the application
> > > asks for forgiveness.   
> > 
> > What is the right API here?
> > 
> It seems very difficult to implement a UAPI for the applications to
> override  at a runtime.  Currently, SVM bind  is under the control of
> individual drivers. It could be at the time of open or some ioctl.
> 
> Perhaps,  this can be a platform policy via some commandline option. e.g.
> intel_iommu=sva_lam_coexist.

I think it has to be per-process, not a system-wide handle.

Maybe a separate arch_prctl() to allow to enable LAM/SVM coexisting?
It would cover both sides of the API, relaxing check for both.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
