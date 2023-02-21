Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5969E67C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjBURzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjBURzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:55:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6B2FCC7;
        Tue, 21 Feb 2023 09:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677002108; x=1708538108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HiP3irDvDIb8+Nk+q8Jh1Kdv24MWvC/xc8UlcNsgutU=;
  b=OvWFFxtG45+c9NrJb4hpU4nHG0XiztLxiUku6caugEbCZmYFR74raCz/
   5TEm5JiFNRdQG9h7mQTlX0zr8CHFmv5F5CXCfFanBJp25xSuCe8axAVoY
   UX+6SAIUYmly++xzfoKKWCdoP8qZOnzqFI+TvBt2Ws/XbQ+8r2n/hsWf5
   28KUKBXgaeveDW3TEKcWM/Z3Sefft1idloE31QkY05xUsH3uEcppPFbQ1
   pbKMjYB1idfWcJGRzRFwBxsNv36RRHJ1pc563X1yCQQWhk0m1rOFImJPj
   OE9pNMLAYO+LvjeyDlfRc4hWsNNH//h04A/k4NXPJiahq6Ra4h0ExQSuG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="316429043"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="316429043"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 09:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="665057592"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="665057592"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2023 09:54:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUWqW-00A3o0-0H;
        Tue, 21 Feb 2023 19:54:32 +0200
Date:   Tue, 21 Feb 2023 19:54:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Ferry Toth <fntoth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, warthog618@gmail.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: arm64: libgpiod: refcount_t: underflow; use-after-free.
Message-ID: <Y/UFV2bgSyBI37vi@smile.fi.intel.com>
References: <CA+G9fYs4JsmNxX4+W=wijfSPdDsOy=SWLBSitZper5ncPpdxqA@mail.gmail.com>
 <Y/T7unUf10Wis59a@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/T7unUf10Wis59a@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 07:13:31PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 20, 2023 at 08:29:27PM +0530, Naresh Kamboju wrote:
> > Following kernel warning notices on qemu-arm64, qemu-arm and also on devices
> > running Linux version v6.2.0 while running libgpiod tests.

...

> -		ACPI_COMPANION_SET(&pdev->dev, NULL);

This line should stay otherwise it will remove the device that may share
the fwnode with this newly created platform device.

-- 
With Best Regards,
Andy Shevchenko


