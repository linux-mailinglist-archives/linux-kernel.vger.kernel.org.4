Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD8678358
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAWRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjAWRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:35:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D191728F;
        Mon, 23 Jan 2023 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495272; x=1706031272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvPh3dJY06YUKjJ7aZ8eKgwxiGrcXa9T/9Jejm0c1FY=;
  b=Ae+EuqPfHjQhkxGuApcqKshS/Zj1DFOuBDFwD0bycpzkPbyTwQG0EbQI
   IpWbIVyPt1xliOWuJqxIvgfrKHYpUfr9POpSPUHU9u430JrIUMIwKm+2x
   4J2/6Fu9daE1KeeAaHZ1Gvk9p6NooHhE6tFYjPMTHw4KIpPkeAqVKRqdw
   sOD2shVVNB4TUDWVWDOiQ2VJQ+LKT30D/igLfZy4FicaqOBCHstUZZldY
   S19Y8HKYrR1X4aUcEpDj7yD82nFjMeoEcch+KK1SJ1KcrO/csHNqfCxQk
   DAm/my4R25feeIkuqHYieh/bcE8ALIV+2FwypAIOkSUASS2ksRwSQtjig
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323792869"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323792869"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655089009"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="655089009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 09:33:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK0hD-00DqwP-10;
        Mon, 23 Jan 2023 19:33:27 +0200
Date:   Mon, 23 Jan 2023 19:33:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Hasemeyer <markhas@chromium.org>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Message-ID: <Y87E50x6cjTi2eDV@smile.fi.intel.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com>
 <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
 <MN0PR12MB61017872AB3769624CE2A49CE2C89@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61017872AB3769624CE2A49CE2C89@MN0PR12MB6101.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:06:59PM +0000, Limonciello, Mario wrote:
> > From: Raul Rangel <rrangel@chromium.org>
> > Sent: Monday, January 23, 2023 09:55
> > On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl>
> > wrote:
> > > On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:

...

> > > > +                       /* avoid suspend issues with GPIOs when systems are using
> > S3 */
> > > > +                       if (wake_capable && acpi_gbl_FADT.flags &
> > ACPI_FADT_LOW_POWER_S0)
> > > >                                 *wake_capable = info.wake_capable;
> > > >
> > > >                         return irq;

...

> > We still need to figure out a proper fix for this. If you read my post
> > here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
> > I think we misinterpreted what the SharedAndWake bit is used for. To
> > me it sounds like it's only valid for HW Reduced ACPI platforms, and
> > S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
> > Wake bit is set. Does anyone have any additional context on the Wake
> > bit? I think we either need to make `dev_pm_set_wake_irq` (or a
> > variant) only enable the wake on S0i3, or we can teach the ACPI
> > subsystem to manage arming the IRQ's wake bit. Kind of like we already
> > manage the GPE events for the device.
> 
> There is an FADT flag for HW reduced (ACPI_FADT_HW_REDUCED).  So
> maybe something on top of my change to look at that too?
> 
> IE:
> if (wake_capable && (acpi_gbl_FADT.flags & (ACPI_FADT_LOW_POWER_S0 | ACPI_FADT_HW_REDUCED)

I'm not sure why we are talking about HW reduced case?
In HP reduced case IIRC the GPE are absent as a class.

-- 
With Best Regards,
Andy Shevchenko


