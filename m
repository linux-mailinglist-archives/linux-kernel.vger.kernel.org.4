Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9F66DFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjAQN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjAQN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:57:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3913C29D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 05:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673963837; x=1705499837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4ci5njmq6NGUXQ2uAOHjFrB6MTLa2x7EivsU39sALs=;
  b=MoNRwLc02kZv5JgIxwm8RSVmd2hcsILeckF1Wk0GqJL/4WcH7Q/nw2r5
   tFSsHeTz0W8kJs34Daif4d2n+ITmMT5Tpvk4Y9mK36D69ME75mO2mMDdV
   iBv2hWDFQSQZJRykifyGbnPD61ns1yLzfZubg7KlrRkztXrLpX3gKRraF
   Dxinu2NDoOgwn2K5bEInKmDUWxY0spjNM8BINWfJG8mgKAWXcoOSN65Rb
   VMa2VJNIgeSzxCFALw5y25xDcz04G7xXZ3/xINA+LR/4jzI2IRL4tlgcL
   GX5WgqiHIpM8uh2yFViTNDaG+kNnertQtsKth6AoNAyKEKXsrjccZ5sSN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325973000"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="325973000"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 05:57:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783246688"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783246688"
Received: from btaubert-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 05:57:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CFEA11070EC; Tue, 17 Jan 2023 16:57:03 +0300 (+03)
Date:   Tue, 17 Jan 2023 16:57:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
Message-ID: <20230117135703.voaumisreld7crfb@box>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com>
 <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:05:22PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 11, 2023 at 03:37:27PM +0300, Kirill A. Shutemov wrote:
> 
> >  #define __untagged_addr(untag_mask, addr)
> >  	u64 __addr = (__force u64)(addr);				\
> > -	s64 sign = (s64)__addr >> 63;					\
> > -	__addr &= untag_mask | sign;					\
> > +	if (static_branch_likely(&tagged_addr_key)) {			\
> > +		s64 sign = (s64)__addr >> 63;				\
> > +		__addr &= untag_mask | sign;				\
> > +	}								\
> >  	(__force __typeof__(addr))__addr;				\
> >  })
> >  
> > #define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
> 
> Is the compiler clever enough to put the memop inside the branch?

Hm. You mean current_untag_mask() inside static_branch_likely()?

But it is preprocessor who does this, not compiler. So, yes, the memop is
inside the branch.

Or I didn't understand your question.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
