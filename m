Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDF69E2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjBUOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjBUOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:51:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6B1C5A8;
        Tue, 21 Feb 2023 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676991107; x=1708527107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6qrcknQv2/gUANwLSC3+1QAOD90qlbVKAdAHdiLC4Q=;
  b=MbAzumJHtzC/O70+e51VtbZJtzx/D3nvEVtbUA9j7t/kb6dHeSrB76aS
   IElxEbZR6ehBQcoAiiSqyb75xBRmX5ua+rHOQ9OrPzJg0r8PQuxcu1gSe
   raSp8173e3rOnQd0FAsgqxd1w6VSwooJAUnINQQ4lL7e9CgrwEKLSahUG
   h5Hox+bIJ3GZncwAmdGJB9BoqYUsiKO6Jol15getDstqYFd+8aW74MV05
   TIHUZzohHiK/aSEwOTudX+VyJxyHUygTkgjBI2TqNehFr4HScjYgxpzbu
   jD5MllBr7OMLVe5sgklYwEsHbceItyHSK6ddalaaBJn+40ZGb7IJWyZ/4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="395129122"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="395129122"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 06:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="781030102"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="781030102"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 21 Feb 2023 06:51:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUTza-00A0Rn-1d;
        Tue, 21 Feb 2023 16:51:42 +0200
Date:   Tue, 21 Feb 2023 16:51:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <Y/TaftuNMABevCWV@smile.fi.intel.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-3-henning.schild@siemens.com>
 <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
 <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 03:43:54PM +0100, Henning Schild wrote:
> Am Tue, 21 Feb 2023 15:51:03 +0200
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:
> > > In order to clearly describe the dependencies between the gpio  

...

> > > +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
> > > +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO  
> > 
> > > +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */  
> > 
> > This header doesn't look right.
> > 
> > Have you run `make W=1 ...` against your patches?
> 
> No reports.
> 
> > Even if it doesn't show defined but unused errors
> > the idea is that this should be a C-file, called,
> > let's say, ...-core.c.
> 
> When i started i kind of had a -common.c in mind as well. But then the
> header idea came and i gave it a try, expecting questions in the review.
> 
> It might be a bit unconventional but it seems to do the trick pretty
> well. Do you see a concrete problem or a violation of a rule?

Exactly as described above. The header approach means that *all* static
definitions must be used by each user of that file. Otherwise you will
get "defined but not used" compiler warning.

And approach itself is considered (at least by me) as a hackish way to
achieve what usually should be done via C-file.

So, if maintainers are okay, I wouldn't have objections, but again
I do not think it's a correct approach.

-- 
With Best Regards,
Andy Shevchenko


