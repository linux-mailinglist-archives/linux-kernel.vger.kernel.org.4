Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61B640648
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiLBMBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiLBMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:01:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DCBA5558
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669982496; x=1701518496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d0Yy2s7G/W07LhjNCb4gfDoO61gYuew0wj8EcyOoRX0=;
  b=bQYDl6z2ai4XG0k/8LNZEDmwPoORexgnQY+lBYZ02k3TassZBUdS2veu
   53Bmde1jLzWXl7wgY90NGE//Leeh6RMWGhF5dtplo9X+Ov38+XRWIm7Dz
   HMvKSRfSqKqCCWELwLovkAm3i3zcgqd/EABUfLxgVVZZ6B72E5UrqdPof
   2XtWxGwI0E32y9fcV+g1zA9ka1jhweWEldJ14h5cABzva1jbHdCdHwzOk
   UI88rnRMC8XbJ56l+oLR2UpveuZd/uAmLYHCI4OPS52RDFfPpt1IV92Lf
   N1iMgpSEIyKoaD0PA0CGAFmFn2OwxnlnOFoEh2udo5vH2StnNVJn3PPc8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="378092424"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="378092424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 04:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733791614"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="733791614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2022 04:01:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p14jU-003Rzl-1S;
        Fri, 02 Dec 2022 14:01:32 +0200
Date:   Fri, 2 Dec 2022 14:01:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4npGz+qwqv3xtBi@smile.fi.intel.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <Y4k3DrPW1eG9WB7r@paasikivi.fi.intel.com>
 <Y4nXY05iM034z6Gi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4nXY05iM034z6Gi@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:45:55AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 01, 2022 at 11:21:50PM +0000, Sakari Ailus wrote:
> > On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> > > container_of does not preserve the const-ness of a pointer that is
> > > passed into it, which can cause C code that passes in a const pointer to
> > > get a pointer back that is not const and then scribble all over the data
> > > in it.  To prevent this, container_of_const() will preserve the const
> > > status of the pointer passed into it using the newly available _Generic()
> > > method.
> > 
> > "_const" in the name suggests that the macro would always take a const
> > argument.
> 
> I mean it here to be "this will preserve const" as yes, it can take a
> const.  Or not.
> 
> > Could this be called e.g. container_of_safe() (for type-safe, but
> > full type_safe would be a bit long)?
> 
> const is an attribute of type safety, container_of is also type-safe
> as-is, it's just the const portion here that is the difference between
> the two.

container_of_const_safe() :-)

> Naming is hard :(

True.

-- 
With Best Regards,
Andy Shevchenko


