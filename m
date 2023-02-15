Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A79697D53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjBON26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBON2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:28:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C322C656;
        Wed, 15 Feb 2023 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676467707; x=1708003707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=moSZQdEQZ6hCarDyzPdJHtA3yV8rQlVIp/WW4VUxY8g=;
  b=IEBJP4kvvJ8OrtUMn18C0Zqu14bFuxiCQzQq61vUjwLvrsP2h8zsLYwJ
   VWw3vYols8Z5Ooblas4LXVQk3LWn6X7b03SYbSrssMZy+4FpG6XDUkQt5
   rKWdQNMqqx7xsWbfHFQFed80JeWLR37rIeyqgcRNp7rIRYyzv3HkTvWRo
   Hl+XrbjErdbwS9lFsTBY7WgqIcYK9TLN+43vh1jaCeoAMBhHaeM5XYngH
   nR/2YxnNYjctEZYU8G7oZyFqz6GiD1Dko22OA28ii9bUfo18J7wI9pFoB
   FyENBIi0nWOMInxpVggm2nGu01q18wZ9YAStEqRCcY/01ZBj1lw/diMvw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="330056027"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="330056027"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:28:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="998490150"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="998490150"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2023 05:28:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSHpe-007GrL-1U;
        Wed, 15 Feb 2023 15:28:22 +0200
Date:   Wed, 15 Feb 2023 15:28:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH v3] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NH5xAx
Message-ID: <Y+zd9kCob1i7zq11@smile.fi.intel.com>
References: <20230214125810.10715-1-wse@tuxedocomputers.com>
 <Y+y4ycHtPkABr/Ia@smile.fi.intel.com>
 <d08e2305-92ba-15e2-398b-b495ed294f1c@tuxedocomputers.com>
 <Y+zdi5GTO6Mdhldn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+zdi5GTO6Mdhldn@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 03:26:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 15, 2023 at 12:59:46PM +0100, Werner Sembach wrote:
> > Am 15.02.23 um 11:49 schrieb Andy Shevchenko:
> > > On Tue, Feb 14, 2023 at 01:58:10PM +0100, Werner Sembach wrote:
> > > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > > changed the policy such that I2C touchpads may be able to wake up the
> > > > system by default if the system is configured as such.
> > > > 
> > > > However for some devices there is a bug, that is causing the touchpad to
> > > > instantly wake up the device again once it gets deactivated. The root cause
> > > > is still under investigation:
> > > > https://lore.kernel.org/linux-acpi/2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com/T/#mb2e738787f6b6208d17b92aa6e72d4de846d4e4d
> > > Bart, I'm fine if it goes directly via your tree, or I can send it in usual
> > > bundle of fixes after rc1 (however it seems this deserves to make v6.2).

Actually we have yet another little fix. So maybe I can create a tagged bundle.
Perhaps v4 will be the best option here.

> > Just realized i did not add cc stable:
> > 
> > It is required for 6.1 also.
> 
> We have at least the following options:
> - you can send specific request for stable after it becomes a part of upstream
> - you can send a v4 with it
> 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > > To workaround this problem for the time being, introduce a quirk for this
> > > > model that will prevent the wakeup capability for being set for GPIO 16.

-- 
With Best Regards,
Andy Shevchenko


