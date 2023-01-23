Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67839678330
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjAWRcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjAWRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E12ED5D;
        Mon, 23 Jan 2023 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495053; x=1706031053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Py4HBSb0OG2l84VkPyw+LO7NmchSRU9bJFYRdaNTeVg=;
  b=crjJN+vUAFaZVxehDbm+H0r4nxKcTqn6YsJ0HsIP+LOLPIhJKNfw+k9p
   DJ8grG4yTOEKkclIi52WZ/RDpGDS2aFzuUPxOAorZahKD39x4Hpr9byws
   2GTs7/7VBayJZxVblnkjasizDOtdbcq6GB2uNSdHIohRgRMNCXadh40LI
   FRcsn4PWJAr05Qnek+RDhhRtFFJU53Q2P4ZCGpXzDxt3mISxa550nsQNj
   k0EtrKF/0l4Yrf0y0VNJaGSJnOKWIeq9DRG1OW8+SKf6YIA+Wvx59Qxfp
   V2jwB55WT+6nvRrnoAilGWf+JENJmJ9v8GImNTiSZamwhFiPkeUH6sRlF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412327624"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="412327624"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750517089"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750517089"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2023 09:30:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK0ec-00Dqt0-0k;
        Mon, 23 Jan 2023 19:30:46 +0200
Date:   Mon, 23 Jan 2023 19:30:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Message-ID: <Y87ERbaTEhKIK1nq@smile.fi.intel.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com>
 <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:55:02AM -0700, Raul Rangel wrote:
> On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > adjusted the policy to enable wakeup by default if the ACPI tables
> > > indicated that a device was wake capable.
> > >
> > > It was reported however that this broke suspend on at least two System76
> > > systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> > > When the machines are set to s2idle, wakeup behaves properly.
> > >
> > > Configuring the GPIOs for wakeup with S3 doesn't work properly, so only
> > > set it when the system supports low power idle.
> > >
> > > Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to set wake_irq")
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2162013
> > > Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > Suggested-by: Raul Rangel <rrangel@chromium.org>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >  drivers/gpio/gpiolib-acpi.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > > index 9ef0f5641b521..17c53f484280f 100644
> > > --- a/drivers/gpio/gpiolib-acpi.c
> > > +++ b/drivers/gpio/gpiolib-acpi.c
> > > @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
> > >                                 dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
> > >                         }
> > >
> > > -                       if (wake_capable)
> > > +                       /* avoid suspend issues with GPIOs when systems are using S3 */
> > > +                       if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
> > >                                 *wake_capable = info.wake_capable;
> > >
> > >                         return irq;
> > > --
> > > 2.34.1
> > >
> >
> > Applied, thanks!
> >
> > Bart
> 
> 
> We still need to figure out a proper fix for this. If you read my post
> here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
> I think we misinterpreted what the SharedAndWake bit is used for. To
> me it sounds like it's only valid for HW Reduced ACPI platforms, and
> S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
> Wake bit is set. Does anyone have any additional context on the Wake
> bit? I think we either need to make `dev_pm_set_wake_irq` (or a
> variant) only enable the wake on S0i3, or we can teach the ACPI
> subsystem to manage arming the IRQ's wake bit. Kind of like we already
> manage the GPE events for the device.

From the spec:

Shared is an optional argument and can be one of Shared, Exclusive,
SharedAndWake or ExclusiveAndWake. If not specified, Exclusive is assumed.
The “Wake” designation indicates that the interrupt is capable of waking
the system from a low-power idle state or a system sleep state. The bit
field name _SHR is automatically created to refer to this portion of
the resource descriptor.


Note: "...a low-power idle state or a system sleep state.". I believe it
applies to both.

-- 
With Best Regards,
Andy Shevchenko


