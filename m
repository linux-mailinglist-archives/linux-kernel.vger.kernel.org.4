Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF20620020
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiKGVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiKGVDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:03:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA085CD;
        Mon,  7 Nov 2022 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667854993; x=1699390993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/t0kKZtuMzaxfWyNmxPnh3ha4ScceX6epiC/hXzz3NE=;
  b=GWIxLPQTjzks2IMqhdSniKkCnE8B3sGrnIIkzf75kYZvk93o3tZMjqjJ
   Td3foib+gTtc4gS+b8P9dyEP5NKk0a8/JDQuL9Y0FwCNQuZQ9HZTskxLr
   oEHt7AHYQODzQi76lVgffAUmU3lZXh5SwfwI7+ODgJowfkRaBfSdGwOSk
   WY3H7BRU7LJd1MN/NozoVtL18+EnAyW2nhpJtZRKrV06dv5ZSvS6D/cWV
   /TnbQLpuAk6krVu1zrufGOt1SxMTDeOFtQgCs8SyEmMxpFhXf3algvmNF
   FjpK0wnmQSFGEdR76+VuuZDmjaiwppMDX6PiqjNH8zjjHGbFHJwGoBiYH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337245632"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337245632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669290605"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="669290605"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 07 Nov 2022 13:02:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9GY-008pkE-3A;
        Mon, 07 Nov 2022 23:02:46 +0200
Date:   Mon, 7 Nov 2022 23:02:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2lydj42MtbfY3vm@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
 <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
 <Y2XrL0noH4HqsAU7@google.com>
 <Y2jnGVKDmGvK94AV@smile.fi.intel.com>
 <Y2kucGtw/t9v0245@google.com>
 <Y2lxuyvdD3EEbfeE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lxuyvdD3EEbfeE@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:59:39PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 07, 2022 at 08:12:32AM -0800, Dmitry Torokhov wrote:

...

> > Swnodes are controlled by the kernel and thus we can potentially allow
> > users tweak them from usersoace. There is a desire to allow easier
> > access to various driver's parameters - see for example Hans patches to
> > Goodix and Silead where he adds code that intercepts reading of device
> > properties and instead gets data form module parameter - I would like to
> > have such facility in more general way.
> > 
> > https://lore.kernel.org/all/20221025122930.421377-3-hdegoede@redhat.com/
> 
> How can you guarantee that flip-flopping priority of reading properties doesn't
> break things?
> 
> Moreover, what problem we are trying to hack up? The DT should be fixed in DT.
> ACPI? In ACPI properties are not that common, and even that, we shouldn't unleash
> vendors to make all possible abuse-like mistakes in ACPI, that's why I do not think
> that allowing property quirks is a good idea at all.

To clarify. In the context when we consider the reversed priority of their
importance. That said, that the "quirk first, firmware later" is NAK by me,
while "firmware first, quirk latter" is pretty much fine.

-- 
With Best Regards,
Andy Shevchenko


