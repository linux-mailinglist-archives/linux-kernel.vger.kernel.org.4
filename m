Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8224697D35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjBON1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjBON05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:26:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0654438EB2;
        Wed, 15 Feb 2023 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676467601; x=1708003601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D2b09vJQ7yhdBo6iThANpyqutldlkAD4sQwHEbLeBMI=;
  b=lbq+caz4+dqSpOdNhPFoJ/g7Sn1OIsfjSLchthbLLYGvxJ9lWvZaVwvv
   ooVOX2qohxYS6vn/ImwbZp2i4Qy+u1hN6DTt3cWXedPmZVrwHhfROjt2c
   rGzlH5Migw0TbAuKfeRjgZbl/m8qmsGjjoMUMFOVcdV4eBVCsbULIA+2L
   unXnYxMquHMgYl2IpZ2Z9cST1EY0g/EOP3v7agReSUGT/ts7rLVXz/vtO
   0kycikK950br3RIV4i1oWyl6G23ExFy7KKPBgLfKQWIsFQeQKYLRHqgdP
   XBm46Oz8seLMi6A4SmemILybaVsjufBpPO3No0zoai8EzwSDaRNrqnCMT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="330055695"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="330055695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:26:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="702032824"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="702032824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2023 05:26:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pSHnw-007Gom-0G;
        Wed, 15 Feb 2023 15:26:36 +0200
Date:   Wed, 15 Feb 2023 15:26:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, alexander.deucher@amd.com
Subject: Re: [PATCH v3] gpiolib: acpi: Add a ignore wakeup quirk for Clevo
 NH5xAx
Message-ID: <Y+zdi5GTO6Mdhldn@smile.fi.intel.com>
References: <20230214125810.10715-1-wse@tuxedocomputers.com>
 <Y+y4ycHtPkABr/Ia@smile.fi.intel.com>
 <d08e2305-92ba-15e2-398b-b495ed294f1c@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d08e2305-92ba-15e2-398b-b495ed294f1c@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:59:46PM +0100, Werner Sembach wrote:
> Am 15.02.23 um 11:49 schrieb Andy Shevchenko:
> > On Tue, Feb 14, 2023 at 01:58:10PM +0100, Werner Sembach wrote:
> > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> > > changed the policy such that I2C touchpads may be able to wake up the
> > > system by default if the system is configured as such.
> > > 
> > > However for some devices there is a bug, that is causing the touchpad to
> > > instantly wake up the device again once it gets deactivated. The root cause
> > > is still under investigation:
> > > https://lore.kernel.org/linux-acpi/2d983050-f844-6c5e-8ae9-9f87ac68dfdd@tuxedocomputers.com/T/#mb2e738787f6b6208d17b92aa6e72d4de846d4e4d
> > Bart, I'm fine if it goes directly via your tree, or I can send it in usual
> > bundle of fixes after rc1 (however it seems this deserves to make v6.2).
> Just realized i did not add cc stable:
> 
> It is required for 6.1 also.

We have at least the following options:
- you can send specific request for stable after it becomes a part of upstream
- you can send a v4 with it

> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > > To workaround this problem for the time being, introduce a quirk for this
> > > model that will prevent the wakeup capability for being set for GPIO 16.

-- 
With Best Regards,
Andy Shevchenko


