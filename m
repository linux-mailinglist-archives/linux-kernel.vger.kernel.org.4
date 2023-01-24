Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968E467939B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjAXJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjAXJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:04:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504723D0BC;
        Tue, 24 Jan 2023 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674551092; x=1706087092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vAWLkQQtGh1QvXHIm+N+kend/e1ltxLlDjhIkUmDNzg=;
  b=dSNH8il9TukaiykYsr/a0zjloDbH/K09nrOM5wfv7MO2k6WytQwbhe7u
   a+nO8zs+xs/YYhK+R5Gigq71/UNdC7BaAso8sEDySqKaB2vkVJfcbX1FR
   tU+aY2v8NGiuLI03YMuhnw7QiGK1HUlXRpnFramYDJr7gGbAyhYzzf+gz
   pKoY4vbNibdZOSA1gjkQy40CUtJCErrQRxqEwnu0FznZO1qRtVAAF7ylg
   OocqXWrP69TvMNu7HXxk6O28tPr+gj/lsEKBuJZmSKH6c2vVRiAZ8Sb49
   i1H6uXAcZP3dpx9OxSPv5197Mgv3+HgotgQu11muSdNyC4in1rlxZuh/s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412484606"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="412484606"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 01:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750758003"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="750758003"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2023 01:04:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKFEW-00EFi1-0k;
        Tue, 24 Jan 2023 11:04:48 +0200
Date:   Tue, 24 Jan 2023 11:04:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in
 apple_gmux_backlight_present()
Message-ID: <Y8+fL3S36gDPydo0@smile.fi.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com>
 <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
 <CAJZ5v0g_WmbCwcqvy_VwZZNDbX48c84vmkqUdGvjX3-w24GCwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_WmbCwcqvy_VwZZNDbX48c84vmkqUdGvjX3-w24GCwg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 08:24:27PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2023 at 7:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jan 23, 2023 at 06:46:44PM +0100, Hans de Goede wrote:
> > > On 1/23/23 18:10, Andy Shevchenko wrote:
> > > > acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> > > > refcount. The caller must drop it when it's done.
> > > >
> > > > Fix ACPI device refcounting in apple_gmux_backlight_present().

...

> > > Thank you for your work on this, much appreciated and I like
> > > the new acpi_get_first_match_physical_node().
> > >
> > > But I don't think this patch is a good idea. There is a
> > > regression related to apple_gmux_backlight_present()
> > > with a patch-set fixing it pending.
> > >
> > > And that patch-set actually removes this function. Adding
> > > a fix for this real, but not really important leak now,
> > > will just make backporting the actual fix harder.
> > >
> > > So I would prefer for this patch to not go in and to
> > > go for (a to be submitted v2) of the patch-set fixing
> > > the regression right away instead.
> >
> > Maybe I missed something, but I noticed that you actually moved (not killed)
> > the code which is currently in this function. If it's the case, I prefer my
> > fix to be imported first.
> 
> Well, what about making the new code not leak?
> 
> That way the separate fix won't be necessary any more, will it?

Yes, it will.

-- 
With Best Regards,
Andy Shevchenko


