Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C35E6399
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiIVN3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIVN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:29:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE7D4DC0;
        Thu, 22 Sep 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853357; x=1695389357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVGkqZN8/I2ZkWPaWKkB3VtQaTi/1qyFWSRkCXAmu1g=;
  b=ehaBS3kmhZKjZuQ+Wzi5KSCZS7bVF+mxQ8NICanJOeVdhZdqiaBLpBin
   YPo1h1zaGirM0Gi+pumBO8zWJ9IOXjLqfLYKykhAgMpkIVuMCey2sH2G4
   OIyjcitqvnaMBqpnVUH4MN21iyulH/OrqP9j0pC4QIPkx17VJADCnI2EL
   LKFOq7R+m2Z6vEwIaHhsi0dyb12M+/5oxL+7FOQoL0kmfkzZE8QCMsTXt
   6UBaiy7AcMnLRUhU9RyFCXjlX3dQYS88dtRtAeefCkOlBjcE1q7oDv9Tg
   zy6qSVnHqWSG4H6tXuP4owVJBIELaWOf6VaEGyu2ufgJmKMZCinfn0bzy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280014094"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="280014094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762182614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2022 06:29:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obMGO-006198-0F;
        Thu, 22 Sep 2022 16:29:12 +0300
Date:   Thu, 22 Sep 2022 16:29:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YyxjJxnbhroflkH6@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:23:04PM +0200, Ferry Toth wrote:
> On 22-09-2022 12:08, Andy Shevchenko wrote:
> > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> > > If the extcon device exists, get the mode from the extcon device. If
> > > the controller is DRD and the driver is unable to determine the mode,
> > > only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> > According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
> > share bisect log?
> 
> I can but not right now. But what I did was bisect between 5.18.0 (good) and
> 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the
> commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3:
> Don't switch OTG -> peripheral if extcon is present" (bad) and commit before
> that (good).
> 
> The effect of the patch is that on Merrifield (I tested with Intel Edison
> Arduino board which has a HW switch to select between host and device mode)
> device mode works but in host mode USB is completely not working.
> 
> Currently on host mode - when working - superfluous error messages from
> tusb1210 appear. When host mode is not working there are no tusb1210
> messages in the logs / on the console at all. Seemingly tusb1210 is not
> probed, which points in the direction of a relation to extcon.
> 
> > Taking into account the late cycle, I would like to revert the change. And
> > Ferry and I would help to test any other (non-regressive) approach).

> I have not yet tested if a simple revert fixes the problem but will tonight.

For clean revert you might need to revert the merge conflict fixes first:
8bd6b8c4b100 ("USB: fixup for merge issue with "usb: dwc3: Don't switch
OTG -> peripheral if extcon is present"").

> I would be happy to test other approaches too.

-- 
With Best Regards,
Andy Shevchenko


