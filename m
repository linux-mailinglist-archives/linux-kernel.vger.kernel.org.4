Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921DB6793A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjAXJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:05:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20A3F292;
        Tue, 24 Jan 2023 01:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674551136; x=1706087136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dfjo3zaZbVl8vyIEZKN8E3xoubV49NEBMowOxUxaKU4=;
  b=n1cMCmwzNJsQVTZJ/wmDoAoUGpDg3ZC+TIsH/hPMQfF59G4z45ELjHFX
   70VNRuJjexIQvxphz2m2iAXPHeh8U/0JsOVkvOxZeAuqWgvF9dfjKNZav
   GCbHwxUJ0uuRxjlkpACU0Z0WgkL6LoZmopRI7HE1eaPtlakVv1zFfxc6U
   oaEi2V9JUIj5R9VbJAlLDDTkmWz+smMUZ0DUqyjY10JTFK6YJnNhQkvjN
   SPXJEeJTf1fQVkOoAYJ0E0I1kEbU3BtQqMNmU5FfWH3ofXXKYo7ge0snt
   I/u2h9kZt+rG9y2WC7k80uwQHH77I7vEexfxN/VX3edwgK0rOJ1JMp29a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388599976"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="388599976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 01:05:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="664003493"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="664003493"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2023 01:05:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKFFD-00EFjI-2Y;
        Tue, 24 Jan 2023 11:05:31 +0200
Date:   Tue, 24 Jan 2023 11:05:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in
 apple_gmux_backlight_present()
Message-ID: <Y8+fWzQP87kGBuJP@smile.fi.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
 <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
 <ea836a1e-a4ab-1c72-dd1f-b1e61fa9595e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea836a1e-a4ab-1c72-dd1f-b1e61fa9595e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:10:26PM +0100, Hans de Goede wrote:
> On 1/23/23 19:18, Andy Shevchenko wrote:
> > On Mon, Jan 23, 2023 at 06:46:44PM +0100, Hans de Goede wrote:
> >> On 1/23/23 18:10, Andy Shevchenko wrote:
> >>> acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> >>> refcount. The caller must drop it when it's done.
> >>>
> >>> Fix ACPI device refcounting in apple_gmux_backlight_present().

...

> >> Thank you for your work on this, much appreciated and I like
> >> the new acpi_get_first_match_physical_node().
> >>
> >> But I don't think this patch is a good idea. There is a
> >> regression related to apple_gmux_backlight_present()
> >> with a patch-set fixing it pending.
> >>
> >> And that patch-set actually removes this function. Adding
> >> a fix for this real, but not really important leak now,
> >> will just make backporting the actual fix harder.
> >>
> >> So I would prefer for this patch to not go in and to
> >> go for (a to be submitted v2) of the patch-set fixing
> >> the regression right away instead.
> > 
> > Maybe I missed something, but I noticed that you actually moved (not killed)
> > the code which is currently in this function. If it's the case, I prefer my
> > fix to be imported first.
> 
> The code is not really moved, patch 2/3 of my patch-set factors out
> the detection code from drivers/platform/x86/apple-gmux.c's probe
> function. The new factored out code uses a similar construct as
> the apple_gmux_backlight_present() code (including the same leak).
> 
> Then patch 3/3 drops apple_gmux_backlight_present() and calls
> the new factored out probe code.
> 
> I'll fix the leak in v2 and then add the 3 patches to pdx86/fixes
> for the next pull-req to Linus (thus also fixing the leak).

As agreed with Rafael, thanks!

-- 
With Best Regards,
Andy Shevchenko


