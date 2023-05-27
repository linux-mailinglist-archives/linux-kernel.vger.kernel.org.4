Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1B71338C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjE0I6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjE0I6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:58:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA2E3;
        Sat, 27 May 2023 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685177890; x=1716713890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gf5TMgt0bAt/QkheoJ/9bYtBlW8oMT6dV0D08HIpbKo=;
  b=CF7qYxvLrseBoLef4SXhZ3LXhw0OFafammubut8gfEp265Yps7zdmVZV
   cYELbQkxLYeI1gAZLgf56ZeqwyosS0hqzkzgqJgS3HDj1uPrkChcEx3vC
   mp053MKLQNURCLWRRhZSgdINwbuKmhSEafog6ISQI3BTOIxxk79f71z8Y
   UNDnqUXwaHkeHIyjEOgCBYTEJxi50el97da0P9yo/rNkSBxmIDsOHvFo5
   D12nkG6iezVU+j5dTiE1NiRGAz0xsrrnhZLSVtQYHgY9vvh8HC2fkJCc4
   dbI1mhbey01Q5glnbsWZLjo1+Lqc6egSdSO3c7EKasW2M9AGdYNNvpmd8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="382629754"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="382629754"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 01:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="736263444"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="736263444"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 May 2023 01:58:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q2pkS-000Is8-1e;
        Sat, 27 May 2023 11:58:04 +0300
Date:   Sat, 27 May 2023 11:58:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 0/4] leds: simatic-ipc-leds-gpio: split up
Message-ID: <ZHHGHEL4OqSvox70@smile.fi.intel.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524124628.32295-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 02:46:24PM +0200, Henning Schild wrote:
> changes since v3:
>  - add terminator entries to all gpio lookup tables as new p1
> 
> changes since v2:
>  - some more style changes from review
> 
> changes since v1:
>  - move from header- to -core.c-based implementation
>  - style changes from review
> 
> This series mainly splits the one GPIO driver into two. The split allows
> to clearly model runtime and compile time dependencies on the GPIO chip
> drivers.
> 
> p2 is kind of not too related to that split but also prepares for more
> GPIO based drivers to come.
> 
> p3 takes the driver we had and puts some of its content into a -core,
> to be used by the two drivers.
> 
> p4 deals with more fine-grained configuration posibilities and compile
> time dependencies.

For non-commented patches

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Henning Schild (4):
>   leds: simatic-ipc-leds-gpio: add terminating entries to gpio tables
>   leds: simatic-ipc-leds-gpio: move two extra gpio pins into another
>     table
>   leds: simatic-ipc-leds-gpio: split up into multiple drivers
>   leds: simatic-ipc-leds-gpio: introduce more Kconfig switches
> 
>  drivers/leds/simple/Kconfig                   |  31 +++-
>  drivers/leds/simple/Makefile                  |   5 +-
>  .../simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++++++++
>  .../leds/simple/simatic-ipc-leds-gpio-core.c  | 104 +++++++++++++
>  .../simple/simatic-ipc-leds-gpio-f7188x.c     |  66 +++++++++
>  drivers/leds/simple/simatic-ipc-leds-gpio.c   | 139 ------------------
>  drivers/leds/simple/simatic-ipc-leds-gpio.h   |  22 +++
>  drivers/leds/simple/simatic-ipc-leds.c        |   1 -
>  drivers/platform/x86/simatic-ipc.c            |   7 +-
>  9 files changed, 293 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
>  delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
>  create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h
> 
> -- 
> 2.39.3
> 

-- 
With Best Regards,
Andy Shevchenko


