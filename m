Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AE15E5F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIVKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:11:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFF5F12;
        Thu, 22 Sep 2022 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663841501; x=1695377501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qa3RLDa2tBvV/1AbLvKwOSQAPY5aFxSgOz7wVyLrl1o=;
  b=P3KKEXpwaCljRcskQ5+Ubv4YOCdFbToBygG47KBgyyke+ciydrWoo8YJ
   6cKoxqlRieFEwjZhaL6CbxKq6DKXiltiyCbnLWdghfTlDi7mo7aKXh2TY
   rD70NBrmqFteuByXaJekah8Rq0WMsjpl+OwhVNDGfTMB5UDCQHYLM5vMl
   YQLLPP0qJVj1jSpULqLpaNinQenvF5YjzmDJnhrY7+LPkRPu0j2bldhDj
   7x7nAXsX44+wpG04IFM3gcO8PNbd7B8kPJwf1jbAAalIV26j7zZceo/dF
   Gkz6NU/XVIYNCv8IHz5G8ncJh7XxBid47Vu1dF4RL0hBGGlspK42njv5z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297856692"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297856692"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="864799457"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 22 Sep 2022 03:11:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obJBB-005xLw-25;
        Thu, 22 Sep 2022 13:11:37 +0300
Date:   Thu, 22 Sep 2022 13:11:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        linux-serial@vger.kernel.org, ribalda@kernel.org, johan@kernel.org
Subject: Re: Cutiepi, serdevs, and right way to handle its power button
Message-ID: <Yyw02TpYzlVfg0op@smile.fi.intel.com>
References: <20220920205637.GA17170@duo.ucw.cz>
 <YysjjSXao4MERCwQ@smile.fi.intel.com>
 <20220921171707.GA8443@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921171707.GA8443@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 07:17:07PM +0200, Pavel Machek wrote:
> On Wed 2022-09-21 17:45:33, Andy Shevchenko wrote:
> > On Tue, Sep 20, 2022 at 10:56:37PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > Cutiepie is a small handheld tablet. It has embedded controller
> > > connected via serial to the main system, handling stuff such as power
> > > button and battery percentage. Currently they are using userland
> > > deamon for communication, but I believe that should eventually go into
> > > kernel.
> > > 
> > > For debugging, it would be really nice to be able to attach my module
> > > to given serdev. Is such thing possible? I see "[PATCH v2 00/19]
> > > Dynamically load/remove serdev devices via sysfs*" series
> > > (https://www.spinics.net/lists/linux-serial/msg30732.html) but I'm not
> > > sure if equivalent functionality exists in mainline kernel?
> > > 
> > > Is there some kind of similar hardware already supported by mainline?
> > > Using driver as a reference might be easier than starting from
> > > scratch.
> > 
> > Is it arm or x86 based tablet?
> 
> arm64, but CPU architecture really should not matter.

It makes sense on the usual practices done for the platform as a whole, e.g.
ACPI vs. DT. So, I believe this one is DT based.

-- 
With Best Regards,
Andy Shevchenko


