Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03011694E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBMR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBMR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:58:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC515CB6;
        Mon, 13 Feb 2023 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676311080; x=1707847080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAlp0VvcVQMFABiiGymze8BcAiZb2vA73KxpVI85N+w=;
  b=TLytttvvrrFB6L1XASpRrIGqCKR6Blc/ofSjCBrSEEBoyDjWJa3uyNoJ
   woawi1USvNNKXcyEiOaAF1cPLbt8eK0DsZeWQf+4HZ2W/JAKi3AZHPZii
   6p/ykiI9E9V0dM1SgPN53wVPEDp1+h9ZPe5wn1JppjlojzAlWkftGf4qk
   rR17BqbT1s6Z+NKfhXoWveLno1KkCBE+nsetMgtoZSE2f3pfBhkGu33ji
   JwvTF7jWyx/gTUwf5xzilEgwL9WSAGEfBaFbE8x4+TlwkPai21GlqVfQ+
   uidiTKngrZrMqXArfk45OYui4NDKUt2RI/DyL2UVGi2qbyOwanBu4rGzH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="328657666"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="328657666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 09:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="777943843"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="777943843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 09:57:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pRd5P-006TjW-2Y;
        Mon, 13 Feb 2023 19:57:55 +0200
Date:   Mon, 13 Feb 2023 19:57:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+p6I379g+V4vpIc@smile.fi.intel.com>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com>
 <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
 <Y+pLLzLDotZQLpdA@smile.fi.intel.com>
 <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
 <CAHQZ30Cs+kp82coR10Wat7q3S_8+pFf=5=44kMEMcjBOjmn=6A@mail.gmail.com>
 <Y+p4Sq/WnZ4jAp+F@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+p4Sq/WnZ4jAp+F@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 07:50:02PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 13, 2023 at 10:20:41AM -0700, Raul Rangel wrote:
> > On Mon, Feb 13, 2023 at 7:47 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
> > > Am 13.02.23 um 15:37 schrieb Andy Shevchenko:
> > > > On Mon, Feb 13, 2023 at 07:20:48AM -0600, Mario Limonciello wrote:
> > > >> On 2/13/23 06:41, Andy Shevchenko wrote:
> > > >>> On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
> > > >>>> Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
> > > >>>>> On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
> > > >>>>>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > >>>>>> changed the policy such that I2C touchpads may be able to wake up the
> > > >>>>>> system by default if the system is configured as such.
> > > >>>>>>
> > > >>>>>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> > > >>>>>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> > > >>>>>> ActiveLow and level triggered but connected to a pull up.
> > > >>>>> I'm not sure I understand the issue here. From what you say here it seems
> > > >>>>> correct ACPI description.
> > > >>>> TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
> > > >>>> which is for a different device having the exact same problem.
> > > >>> Yeah, and I reviewed that and seems paid no attention to this detail.
> > > >>>
> > > >>> So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
> > > >>> The problem seems somewhere else.
> > > >>>
> > > >>> Mario, can we have an access to the schematics of the affected pin to
> > > >>> understand better what's going on?
> > > >>>
> > > >>> Or is that description missing some crucial detail?
> > >
> > > Schematics for the NH5xAx can also be found on this unofficial clevo mirror
> > > (service manuals, scroll to end for schematics):
> > >
> > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
> > >
> > > http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AF1.zip
> > >
> > > User: repo
> > >
> > > PW: repo
> > >
> > > >> The schematics were shared by the reporter for the original issue which is
> > > >> how we reached the conclusion there was a mistake.
> > > >>
> > > >> As they're both Clevo designs it's certainly possible they have the same
> > > >> mistake in two systems.
> > 
> > > > Thank you!
> > > > I have looked at the schematics and read discussion.
> > > >
> > > > So, the conclusion that this is a BIOS bug is incorrect in my opinion.
> > > > The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
> > > > signal for a while or on the PCB level, so that pull up should be connected
> > > > to another power source that stays on.
> > > >
> > > > This means the description on the initial patch with the same issue is
> > > > incorrect.
> > > >
> > > > Do we know the power sequence on the suspend to see which and how on the
> > > > time line the power sources are off/on?
> > 
> > If you look at the load switch for 3.3VS, its EN2 pin is connected to
> > SUSB#_EN which is connected to SUSB# which is connected to
> > AND(SUSB#_PCH -> SLP_S3_L, PM_SLP_S0 -> S0A3_GPIO). So there is no
> > PMIC/EC firmware that is incharge of this. I guess I'm not quite sure
> > how they have S0A3_GPIO configured, so maybe I have an invert wrong.
> > 
> > The EC does control DD_ON which controls the 3.3V and 5V rails.
> 
> On page 6 of the schematics I see the U7 that forms SUSB# from SUSB#_APU
> (which corresponds to what you said) _and_ EC_EN, which is GPIO from IT5570,
> which is EC.
> 
> Are you using different schematics? I'm using the one from FDO bug report.

Just checked this one:
http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip

Also uses EC (SUSB_EC#).

> > > >>>>>> As soon as the
> > > >>>>>> system suspends the touchpad loses power and then the system wakes up.
> > > >>>>>>
> > > >>>>>> To avoid this problem, introduce a quirk for this model that will prevent
> > > >>>>>> the wakeup capability for being set for GPIO 10.
> > > >>>>> I'm not against fixing this, but wouldn't be better to actually target the root
> > > >>>>> cause and have a different quirk? Or is it me who didn't get what is the root
> > > >>>>> cause?
> > > >>>>>
> > > >>>> I missed to reference the original discussion while copying the description:
> > > >>>> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
> > > >>>> it's a somewhat convoluted issue spanning multiple bugs when you scroll up
> > > >>>> from that particular linked comment, which are however irrelevant for this
> > > >>>> patch)
> > > >>>>
> > > >>>> I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
> > > >>>> summing it up, as I might have misunderstood parts of it ^^
> > > >>> The GpioIo() and GpioInt() resources have gaps in them, due to this some
> > > >>> additional information is required or some heuristics is used to deduct
> > > >>> the settings.
> > > >>>
> > > >>> All this is described in
> > > >>> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html
> > > >>>
> > > >>>> I added the other ones from there to the cc.
> > > >>> Thank you.

-- 
With Best Regards,
Andy Shevchenko


