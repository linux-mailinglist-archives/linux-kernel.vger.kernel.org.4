Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790136043A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiJSLpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiJSLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:45:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005521EAF8;
        Wed, 19 Oct 2022 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178699; x=1697714699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byhaK/IP5btEn4lSHeI7yfg5hfTKJgloqLB5svueUwQ=;
  b=TYo2dHLegCvbr4GBqXYSkev1GVevnghChmZJ0i9AH/vEB2RMvxs6kRQn
   p8q9XM//mt+KTCWfDxlHbiH0elWWV5kX3eay7ufPzZu0I1IvaNMIYUeNL
   kjUksS6ClaD5jAuXQQ1acabg+pyUajTLPEaT3IQ/Zy0fv0Zo/GVmvzAKx
   MfNH1WbnFX9cyreYC+LTcYEjaXpmvlSrBNeoqYIYRQ+aqpc8dm243VFt1
   /s0F/oCbbj1ysaOEGWMXAShTbCps/blZ5ITkkKt6cYngIVjSecrgFXhNo
   tDOCiSN8dJQYJjiC1e+SkisTpxXdlxe4aVIbZ01cvUvW+8v4c6d8F7BIW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293775825"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="293775825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="718435312"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="718435312"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Oct 2022 04:16:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol746-009pHc-10;
        Wed, 19 Oct 2022 14:16:50 +0300
Date:   Wed, 19 Oct 2022 14:16:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
Message-ID: <Y0/cot711ad/hG/o@smile.fi.intel.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
 <Y06cvrpcHn0jwZxU@smile.fi.intel.com>
 <CACRpkdZZZp5Li7OSybv8F7a8F5iik_gRumwR__BAwpWddfctxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZZZp5Li7OSybv8F7a8F5iik_gRumwR__BAwpWddfctxQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:56:31PM +0200, Linus Walleij wrote:
> On Tue, Oct 18, 2022 at 2:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Oct 17, 2022 at 10:41:01PM -0700, Dmitry Torokhov wrote:
> > > In preparation to converting several drivers to gpiod API, and to keep
> > > existing DTS working, this series adds additional quirks to locate
> > > gpio lines with legacy names.
> > >
> > > Additionally the quirk handling has been reworked (once again) to pull
> > > all simple renames (ones that do not involve change of indices or other
> > > complex manipulations) into a single quirk with a table containing
> > > transformations. This should make adding new quirks easier.
> > > When using legacy names gpiolib will emit a message to nudge users to
> > > update DTSes (when possible).
> > >
> > > Note that the last patch requires the following change from the OF tree:
> > >
> > >         88269151be67 ("of: base: make of_device_compatible_match() accept const device node")
> > >
> > > The change is also available in mainline - it has been merged in 6.1
> > > merge window.
> >
> > I was wondering if we can use the approach that ACPI chose for itself,
> > i.e.  the separate data that can be filled by the corresponding driver
> > and then GPIO OF common code may use it. In that case each driver knows
> > the exact list of compatible strings and associated quirks.
> 
> I actually deliverately chose the other way around, to centralize all quirks,
> so that drivers look nice and simple and the ugly historical errors of the
> device tree be hidden away in gpiolib-of.c.

This makes sense if and only if we may guarantee no quirks will appear in the
future. So, it may be true for DT, but I'm quite skeptical about ACPI...

-- 
With Best Regards,
Andy Shevchenko


