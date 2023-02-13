Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF6694613
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBMMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjBMMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:41:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C010C5;
        Mon, 13 Feb 2023 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676292116; x=1707828116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DG7Ke2sciLVu9YsJ/QYtVHzYsvTpCMR4WXEcGmnErso=;
  b=S6VAexWkM/2uEJfMbmD1LOmPoghTvpTWt/AmOxu9A42pBSPznzPEsOt0
   uYCn+S2id5hYQW562wp3t3MO+n/qDdpPcOoDfkIpMViobPeIKOOPmvXff
   25IuhJFg0qRTQpfmPlzsRTgBI5W/xaNjGp5U5NGQKLKeSHT9yjroi9BiE
   lt58qiHAe1gt3ErZQUnCL7GUhgHjzT2ilCnPJ02JQ3qr/noma2F3dxAFe
   NCIVuJkmzBFsbTEWVpg6Xwm4Lt00hYOgZppFB6MOtDpttCzcsYROJcM7h
   9IRzijAeiz21xQip9OHUY4SOf4xZslp47Zxg6SYoOSE1InyNMKV09rFic
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="318903728"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="318903728"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 04:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="811585538"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="811585538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2023 04:41:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRY9X-006Kc5-0W;
        Mon, 13 Feb 2023 14:41:51 +0200
Date:   Mon, 13 Feb 2023 14:41:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Raul E Rangel <rrangel@chromium.org>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+owDqifuU9nf+1i@smile.fi.intel.com>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
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

On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
> Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
> > On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
> > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > changed the policy such that I2C touchpads may be able to wake up the
> > > system by default if the system is configured as such.
> > > 
> > > However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> > > tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> > > ActiveLow and level triggered but connected to a pull up.
> > I'm not sure I understand the issue here. From what you say here it seems
> > correct ACPI description.
> TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
> which is for a different device having the exact same problem.

Yeah, and I reviewed that and seems paid no attention to this detail.

So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
The problem seems somewhere else.

Mario, can we have an access to the schematics of the affected pin to
understand better what's going on?

Or is that description missing some crucial detail?

> > > As soon as the
> > > system suspends the touchpad loses power and then the system wakes up.
> > > 
> > > To avoid this problem, introduce a quirk for this model that will prevent
> > > the wakeup capability for being set for GPIO 10.
> > I'm not against fixing this, but wouldn't be better to actually target the root
> > cause and have a different quirk? Or is it me who didn't get what is the root
> > cause?
> > 
> I missed to reference the original discussion while copying the description:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
> it's a somewhat convoluted issue spanning multiple bugs when you scroll up
> from that particular linked comment, which are however irrelevant for this
> patch)
> 
> I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
> summing it up, as I might have misunderstood parts of it ^^

The GpioIo() and GpioInt() resources have gaps in them, due to this some
additional information is required or some heuristics is used to deduct
the settings.

All this is described in
https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html

> I added the other ones from there to the cc.

Thank you.

-- 
With Best Regards,
Andy Shevchenko


