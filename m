Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDFA67844D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjAWSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjAWSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:18:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5B83CA;
        Mon, 23 Jan 2023 10:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674497886; x=1706033886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oB3FmPyCBPbmcm/SDWIRHTSS2uz2g7vBEzSlCTwjPDc=;
  b=VlD+9ZkQPMIS9rElK9RCq4gIubAOOwZp+muU5apom1mYz6kpBbOaV+1R
   Ev0xbJGugch8KzbXAbax6jwMSYydggzdTMu/KCGqAwfFOF4rnB5rlu08+
   nCOh8YwDaXu7fzcP96RIRh4rqk3UjBEvXi42kmfV8H8Knpulq3lGLR6un
   tU+yImcdfl5SH67DcMVs63/C9wN9v2y+k0J0bOuC5v4DZAo8DZ/kEmznx
   ZlaOhqOlpfhqluzXBrp4cSAOZ8ZF6crKXFkeSCYgcN6obUGfJIAk63Xyw
   7xAQgbnNFEXYid5pyX9WmAs78JVIZOdk7G6oO/YqdtjUCuA41SR4Cq5Zo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388461976"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="388461976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="663764330"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="663764330"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jan 2023 10:18:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pK1OL-00Drwz-1E;
        Mon, 23 Jan 2023 20:18:01 +0200
Date:   Mon, 23 Jan 2023 20:18:01 +0200
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
Message-ID: <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 06:46:44PM +0100, Hans de Goede wrote:
> On 1/23/23 18:10, Andy Shevchenko wrote:
> > acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> > refcount. The caller must drop it when it's done.
> > 
> > Fix ACPI device refcounting in apple_gmux_backlight_present().

...

> Thank you for your work on this, much appreciated and I like
> the new acpi_get_first_match_physical_node().
> 
> But I don't think this patch is a good idea. There is a
> regression related to apple_gmux_backlight_present()
> with a patch-set fixing it pending.
> 
> And that patch-set actually removes this function. Adding
> a fix for this real, but not really important leak now,
> will just make backporting the actual fix harder.
> 
> So I would prefer for this patch to not go in and to
> go for (a to be submitted v2) of the patch-set fixing
> the regression right away instead.

Maybe I missed something, but I noticed that you actually moved (not killed)
the code which is currently in this function. If it's the case, I prefer my
fix to be imported first.

-- 
With Best Regards,
Andy Shevchenko


