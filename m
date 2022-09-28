Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09105EDF14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiI1Opn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiI1Opa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:45:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F338B2;
        Wed, 28 Sep 2022 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664376327; x=1695912327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJoaWQV+GfSnfR3aK+SXucd83SNX/yJoQ2eac0XfQGw=;
  b=A9tUEcqvXAkHMJwsgTLAH9KCFd95KCeAhxjB364MA7jHThYbkMbRYOyR
   9RtDylMl9HCHl0TqFJwStFJqxJjCvyTXBJPuhWvgb+JmxwLJH8df0eSvW
   W0YQ2cAdPZn88nbvVJUgU08jvJ70bxv1cuD6N7V7/V2asttjrjP0KGq/q
   W3EpWFAWH05WLZTZNywAsgsFvyhKv5dHPrSv2kaTPlL25CummUzSRFsad
   U2mDAAS5dmCDxRQwwHSwT1Qz0GvrIAcfrgwcxB3Mi9BWr6AACHcYqQ3FT
   G0Qc37U8rx91Y6+/X2qhqcJV5CJUAlMyhOEHaDMrVs1oemRlCwyodABQ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="327986207"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="327986207"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684432167"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="684432167"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2022 07:45:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odYJM-008yFB-1t;
        Wed, 28 Sep 2022 17:45:20 +0300
Date:   Wed, 28 Sep 2022 17:45:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] pwm: lpss: Clean up and convert to a pure library
Message-ID: <YzReAPJpyL66XDON@smile.fi.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
 <YzRYmtcsdW6iSC0L@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRYmtcsdW6iSC0L@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:22:18PM +0200, Thierry Reding wrote:
> On Tue, Sep 27, 2022 at 07:24:14PM +0300, Andy Shevchenko wrote:
> > First of all, a set of cleanups and code deduplications (for better
> > maintenance) to the PWM LPSS driver.
> > 
> > Second, we may (re-)use the core part as a library in the future in
> > the devices that combine the same PWM IP in their address space. So
> > convert the core file to be a pure library which doesn't require any
> > special resource handling or alike.

> Series applied, thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


