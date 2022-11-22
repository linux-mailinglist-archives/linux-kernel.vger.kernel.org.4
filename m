Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBD633963
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiKVKKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiKVKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344251326
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111845; x=1700647845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5YfMCZGtbIuv3f07XMWHQcbDPvM3htvz+fo05zaqDE=;
  b=b7SF6zWzmDgDOk6J8LWHckcY3BDUfbOVu9SwanFpHSY4btErbw/bf+vS
   altbrRJ/8gLxt7z1d70YRtCoiV8eVtfteLDMluGLJ/Mlb41XCkN/WE2/z
   6OaQdSojECm/fDqOyTjw3GGlJW8z/RT2d7STvQb70FNolerQQmzOOdDZZ
   OOnOlesiy67Sen6zuqSebG5H8X6ySpEUppvmfkGhYu3GvLxGMMrNYBVmx
   NEOZRL31QnLVmOvk97XbBmFc8pqOOmvh2tquAo1WccqqCR9GkY4xaIEG/
   2ORr7h/u+LI2QC5/swDs7IvxPdDID3HW/DO1YuztM37/kXEAQFsNHP4bO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315601040"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="315601040"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="710143501"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="710143501"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2022 02:10:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxQEi-00Fhpz-0S;
        Tue, 22 Nov 2022 12:10:40 +0200
Date:   Tue, 22 Nov 2022 12:10:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>
Subject: Re: [PATCH v3 4/4] x86/of: Add support for boot time interrupt
 delivery mode configuration
Message-ID: <Y3ygH0Oe8K0saF+S@smile.fi.intel.com>
References: <cover.1669100394.git.rtanwar@maxlinear.com>
 <c62b81d5b91514e905d97e37feff6920f598e0ac.1669100394.git.rtanwar@maxlinear.com>
 <Y3yS6fCIl+0nsbOj@smile.fi.intel.com>
 <e5028335-97f9-dd88-09e9-9036b55e7642@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5028335-97f9-dd88-09e9-9036b55e7642@maxlinear.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:45:29AM +0000, Rahul Tanwar wrote:
> On 22/11/2022 5:14 pm, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 03:39:10PM +0800, Rahul Tanwar wrote:

...

> >> Fixes: 3879a6f32948 ("x86: dtb: Add early parsing of IO_APIC")
> > 
> > If it was never working, there is nothing to fix.
> > OTOH, without Cc: stable@ this is up to stable maintainers to
> > backport.
> 
> Agree, will remove fixes tag..

Don't forget to update cover letter and messages accordingly.

-- 
With Best Regards,
Andy Shevchenko


