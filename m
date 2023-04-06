Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAB6D9C73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjDFPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDFPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:32:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BD271E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680795170; x=1712331170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ruqew8xBk5gM/kBHIUBFERD+y/y6oG1MmbVU4HLVKms=;
  b=N9dH4UgPR/7S2oAwxN2jiCwpRtG70jk0Pcfe/EX8WJSdxzMt9LT0EW/j
   ZhZKWYh8PGdOLqC20/j2rKbXRuGmGj4gwntT3wpX0w/xGyZJYH4PdhZnR
   3vIN0u+PEChrz/Mu7AnlrmT0DZR9dDDrOPJ3vvcbitDt2QC3KGkKVTkCW
   pRP7uli75y3P5+aEjn49ATfEgQOnz4WUK+dI0Ux4meT+gRASOZoUGLYha
   uDH5hgxXIjxL2li8ZKHbVByAtp5Jh32p9nuEyLH18jAU1JIiMn6ZTl98t
   PbofPxYYO7+XW/+MonggTepdxwaRDnbspvyRgBpjgvGxL50IFZ8pdF9js
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="370596770"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="370596770"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 08:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756397773"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="756397773"
Received: from mariowei-mobl1.amr.corp.intel.com (HELO [10.209.123.94]) ([10.209.123.94])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 08:31:40 -0700
Message-ID: <24661bc4-cc95-5c1b-b88d-94d4ce335d0b@intel.com>
Date:   Thu, 6 Apr 2023 08:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] x86/mm/iommu/sva: Fix error code for LAM enabling
 failure due to SVA
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
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
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com>
 <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 04:10, Kirill A. Shutemov wrote:
> Normally, LAM and SVA are mutually exclusive. LAM enabling will fail if
> SVA is already in use.
> 
> Correct error code for the failure. EINTR is nonsensical there.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>

Hi Kirill,

These look fine. But in the future, Link:'s for Reported-by's would be
very appreciated if the discussion happened in public.
