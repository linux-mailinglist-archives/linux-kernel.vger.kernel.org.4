Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF065E7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjAEJf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjAEJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:35:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE54C72C;
        Thu,  5 Jan 2023 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672911352; x=1704447352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kkHuRRG9KBM8yFvsN3QAm76ykshPmwlBpfFrGtmd/04=;
  b=bo7iwZ4ZyWLRfRTL6P0bfdtvi44RDdrvVXQc5hdFQaI9/7zXNAtLswkg
   7jx55CwHZAN1ucdAxTuCl1VHkgkPGCm6pDr6FMCFL1aYBJi0l4exjQ2JO
   czoKJ23VHe3f7jP+rz+QOsa665e2uCGgC393qwro0Lbvv3LJZKG70vVLq
   sRjBdyP6SI7JU4SsDX1nHQKljGOcKIxWVO5kgBOy98tIZRP4cPUZQxfeP
   h3lk6tzXuMJ127132WiWRHewRxnJE6kR5gnO+PJsJCUkY+OrJE48ALwKN
   mo3+LAZAuHYayys5Hko5KGMX2/mW0ZJt5ZCGauMfj0tn1qdS/mWuvVfyi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349380928"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="349380928"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 01:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="724007263"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="724007263"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2023 01:35:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pDMf6-004i5u-39;
        Thu, 05 Jan 2023 11:35:48 +0200
Date:   Thu, 5 Jan 2023 11:35:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
Message-ID: <Y7aZ9Mmm16HVUnnu@smile.fi.intel.com>
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y6WX1Y9GZmvxqlCc@google.com>
 <20230102162227.523d2a73@md1za8fc.ad001.siemens.net>
 <20230103212059.5c80fecb@md1za8fc.ad001.siemens.net>
 <Y7WMHl1Mv1alXadG@google.com>
 <20230104153924.0b92c52c@md1za8fc.ad001.siemens.net>
 <Y7WghcaWPpCHh6Wz@smile.fi.intel.com>
 <20230104203005.5654f3bc@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104203005.5654f3bc@md1za8fc.ad001.siemens.net>
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

On Wed, Jan 04, 2023 at 08:30:05PM +0100, Henning Schild wrote:
> Am Wed, 4 Jan 2023 17:51:33 +0200
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> > On Wed, Jan 04, 2023 at 03:39:24PM +0100, Henning Schild wrote:
> > > Am Wed, 4 Jan 2023 14:24:30 +0000
> > > schrieb Lee Jones <lee@kernel.org>:  

...

> > > As we speak i already have the third box to eventually support,
> > > which will likely be similar but this time around with
> > > PINCTRL_ELKHARTLAKE  
> > 
> > A bit of offtopic here.
> > 
> > Are you able to get / fix / ... the firmware to work with the
> > upstreamed version of pin control driver for Intel Elkhart Lake?
> > 
> > (I'm asking this in terms of the
> > https://bugzilla.kernel.org/show_bug.cgi?id=213365)
> > 
> 
> I can not tell. At the moment i am in a Siemens internal review where i
> see code that is not even close to being ready for upstream. Somewhat
> open-coded again from what it looks like.
> 
> And i do not have the machine the code is for.
> 
> Let me say "it is complicated" but some point in time a device with
> LEDs attached to PINCTRL_ELKHARTLAKE will be proposed. Likely by me,
> when i hopefully have such a device on my desk.

Thanks for the information.

Consider above just as a point to be aware of when you come to
the productization, so we won't need another pin control driver for
the same chip.

-- 
With Best Regards,
Andy Shevchenko


