Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9669483D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBMOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjBMOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:38:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464631BAFD;
        Mon, 13 Feb 2023 06:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676299105; x=1707835105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XoZrHzVwE2zyKzwKNugTFygMtiMpXySNVGRuWXd27Q=;
  b=mSql/uNftaZLdzx86j3eAlK26k5xf04N8Xk1SPFHIXfBEZLHf84M2yjC
   O+9Y8OA+Muz5tbv1dO7rtdeuHjZfJW8eNYr8MqcCh03hoTxlVrkg4IGaA
   R8jpvZ4pAKm6h6VwohwkOVUt1J4jWJYdJqLp3kbKkRn8TzcWXfCS9tTiq
   kwDAg7M9r6EBtNFcYdac6C+VnN+JtIX3KHYHceGSSsKnGUobPTCbPQMJ9
   CzJZdsvEdsySAbqBMc1eVXZw9EeY1PUQj4pzUb0jAqGL1JUUqHg4d8ABO
   GGImxIXsSpiRlJhm7JgDoVCSPSY/w3ZLXKgs7F1yi0DD20DTKuB5yryaY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310533978"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310533978"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 06:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="777866154"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="777866154"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 06:37:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRZxY-006PMl-15;
        Mon, 13 Feb 2023 16:37:36 +0200
Date:   Mon, 13 Feb 2023 16:37:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Raul E Rangel <rrangel@chromium.org>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+pLLzLDotZQLpdA@smile.fi.intel.com>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com>
 <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 07:20:48AM -0600, Mario Limonciello wrote:
> On 2/13/23 06:41, Andy Shevchenko wrote:
> > On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
> > > Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
> > > > On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
> > > > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > > > changed the policy such that I2C touchpads may be able to wake up the
> > > > > system by default if the system is configured as such.
> > > > > 
> > > > > However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> > > > > tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> > > > > ActiveLow and level triggered but connected to a pull up.
> > > > I'm not sure I understand the issue here. From what you say here it seems
> > > > correct ACPI description.
> > > TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
> > > which is for a different device having the exact same problem.
> > Yeah, and I reviewed that and seems paid no attention to this detail.
> > 
> > So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
> > The problem seems somewhere else.
> > 
> > Mario, can we have an access to the schematics of the affected pin to
> > understand better what's going on?
> > 
> > Or is that description missing some crucial detail?
> 
> The schematics were shared by the reporter for the original issue which is
> how we reached the conclusion there was a mistake.
> 
> As they're both Clevo designs it's certainly possible they have the same
> mistake in two systems.

Thank you!
I have looked at the schematics and read discussion.

So, the conclusion that this is a BIOS bug is incorrect in my opinion.
The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
signal for a while or on the PCB level, so that pull up should be connected
to another power source that stays on.

This means the description on the initial patch with the same issue is
incorrect.

Do we know the power sequence on the suspend to see which and how on the
time line the power sources are off/on?

> > > > > As soon as the
> > > > > system suspends the touchpad loses power and then the system wakes up.
> > > > > 
> > > > > To avoid this problem, introduce a quirk for this model that will prevent
> > > > > the wakeup capability for being set for GPIO 10.
> > > > I'm not against fixing this, but wouldn't be better to actually target the root
> > > > cause and have a different quirk? Or is it me who didn't get what is the root
> > > > cause?
> > > > 
> > > I missed to reference the original discussion while copying the description:
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
> > > it's a somewhat convoluted issue spanning multiple bugs when you scroll up
> > > from that particular linked comment, which are however irrelevant for this
> > > patch)
> > > 
> > > I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
> > > summing it up, as I might have misunderstood parts of it ^^
> > The GpioIo() and GpioInt() resources have gaps in them, due to this some
> > additional information is required or some heuristics is used to deduct
> > the settings.
> > 
> > All this is described in
> > https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html
> > 
> > > I added the other ones from there to the cc.
> > Thank you.

-- 
With Best Regards,
Andy Shevchenko


