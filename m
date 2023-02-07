Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550F68E396
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBGWuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBGWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:49:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F901B574;
        Tue,  7 Feb 2023 14:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675810197; x=1707346197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r/v2d6ahiLeHME7Uo8KMcQBJwkAVFRLwEvDOoG0o7bw=;
  b=YQb8lLtj4x44zFLtzv3bHEeLFl8fVw5B4PhdZGm7rjm0GGA7+evWv5kq
   ChhzsfHNz0muLP4BkAY8AE6iZbsSkHuyacteTkrdu3BjRDMkVwi0awery
   +l1ZMmdUqLmGEtgphYHgdZaBAYSb1/7yw8K6gq/5wGIS7BRRnqCabJVef
   5I1PtEZ0Pr1Q7VwsvnojYdUSvRpAkI0+Yoi+jgnAMeMphcFaU9h9mMLcs
   7JuR7aIFTKpuz9eczYG5q1K/9SrZtyCNrOAO1qRvzaRNu8DtAVaJkXER2
   KtdKKoJ5+7QIEQyJKEMW1XJO458gAuDS3CRKI5FTXUWmH3eH/RprWl3mK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309990634"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="309990634"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:49:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730627416"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="730627416"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2023 14:49:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPWmg-003ogf-0F;
        Wed, 08 Feb 2023 00:49:54 +0200
Date:   Wed, 8 Feb 2023 00:49:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/7] xhci: mem: Use __GFP_ZERO instead of explicit
 memset() call
Message-ID: <Y+LVkVvqknr/z3D5@smile.fi.intel.com>
References: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
 <20230206161049.13972-3-andriy.shevchenko@linux.intel.com>
 <31a4cfbe-2c23-cda2-2d92-9d15a5d4bcb3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a4cfbe-2c23-cda2-2d92-9d15a5d4bcb3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:11:23PM +0200, Mathias Nyman wrote:
> On 6.2.2023 18.10, Andy Shevchenko wrote:
> > Use __GFP_ZERO instead of explicit memset() call in
> > xhci_alloc_stream_ctx().

...

> > +	mem_flags |= __GFP_ZERO;
> 
> How about calling dma_pool_zalloc() instead of setting __GFP_ZERO flag?
> Memory returned by dma_alloc_coherent() should already be zeroed if I remember correctly

That will work too.

-- 
With Best Regards,
Andy Shevchenko


