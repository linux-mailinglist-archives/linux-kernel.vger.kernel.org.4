Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D56200F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiKGVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiKGVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:21:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B752CC96;
        Mon,  7 Nov 2022 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667856011; x=1699392011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XX1vVahvgx8jLWiHYJaLveSZ/nWM8jWynggYohP/c3M=;
  b=nYF2FtZhkL2QNiRznA6ba6DRswpgNNeAlFhSBaf4bFj0yGI9J5faoAEY
   XU4fBEVgqe7DRzS4kIAh8g2eP91vIrYUlr1ZQu6ACE4P1bulDvCsT00Wx
   2rpgku2NlNt9bdSx2vtX+PgtQJ68ytZ7L5H+aVmdIg9WLRI2Lzj2XxDuZ
   UKMq+qfVMxGyKLTQPfzBqbL52aKyPJSuG+ViEsVLJwaTmM9uVaNnpQyw9
   yk3g5zHtE8rvnuzLPOSNL1zP89yJWjPhlM9aJ+1Qa2t547/mTcVtylNRV
   2GBPWC24aQgkE4JMzu7enHw4gYnOIiCdodRlMcCjmSq6n81+YvM/Lt10y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337248782"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337248782"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 13:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741663132"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="741663132"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2022 13:20:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os9XK-008q2Q-1o;
        Mon, 07 Nov 2022 23:20:06 +0200
Date:   Mon, 7 Nov 2022 23:20:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v1 5/5] rtc: rtc-cmos: Disable ACPI RTC event on removal
Message-ID: <Y2l2hid1SSAzpKhS@smile.fi.intel.com>
References: <2276401.ElGaqSPkdT@kreacher>
 <2219830.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2219830.iZASKD2KPV@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:03:06PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make cmos_do_remove() drop the ACPI RTC fixed event handler so as to
> prevent it from operating on stale data in case the event triggers
> after driver removal.
> 
> While at it, make cmos_do_remove() also clear the driver data pointer
> of the device and make cmos_acpi_wake_setup() do that in the error path
> too.

...

> +	dev_set_drvdata(dev, NULL);

> +	dev_set_drvdata(dev, NULL);

Maybe I'm missing something, but the cmos_do_remove() is called by ->remove()
callback of the real drivers (pnp and platform) and device core is already
doing this. So, don't know why you need these calls to be explicit.

-- 
With Best Regards,
Andy Shevchenko


