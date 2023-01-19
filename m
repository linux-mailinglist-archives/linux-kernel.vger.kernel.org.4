Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31E673D63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjASPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjASPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:22:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68A8298E;
        Thu, 19 Jan 2023 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674141728; x=1705677728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZ6dDBlxfYjG2mjgktlle084t9dNgfWEgUeF8ouwFD0=;
  b=E9ORJmYJ3RkH8V+Qx9dl/kc+intFzBg+QcQBR+I7MLw5d/DkSvozxne0
   DGnXUMIjdaB+zvt6zN/vuCurqy/KrslqA/Mws5ZsdHcOjgGHO2+3GfxDh
   s2mb5OQCQW20oC53yMhOShAQtxLwGB3Z3S/9c2HrJChLAgjtXuqM+Vi6P
   xGyvoINdPV/Byx1Roh1+E2uOncAd9Bb5AELXIa5eh5F8aL+0kWVYZ+y6p
   sazFRZ5vmG1s5SsSsZXllB3y33EDYkO/O7io2zBy1+oUtxpGCYUKNwAdm
   1t+SnSWTsxYS3zDcRdMChYy8oGRr8BTl7ZQoc9KykHIjvDtAhJmv9Iutc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313203978"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="313203978"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:17:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="748959531"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="748959531"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 07:17:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIWf3-00Bj14-1N;
        Thu, 19 Jan 2023 17:17:05 +0200
Date:   Thu, 19 Jan 2023 17:17:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <Y8le8bEpwlVHenDb@smile.fi.intel.com>
References: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
 <Y8lBczJAXR4Hjl93@kroah.com>
 <Y8lVmOL5T2EUVkgr@smile.fi.intel.com>
 <Y8leT6LXyy20eyyh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8leT6LXyy20eyyh@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:14:23PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 19, 2023 at 04:37:12PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 19, 2023 at 02:11:15PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 18, 2023 at 10:04:19AM +0200, Andy Shevchenko wrote:

...

> > > Fails to apply to my tree :(
> > 
> > It seems it's against usb-linus as Mathias' original patch is there.
> 
> Ah, then that can wait until it merges into my usb-next branch.  Can you
> resend it in a week or so when that happens?

Sure, thanks!

-- 
With Best Regards,
Andy Shevchenko


