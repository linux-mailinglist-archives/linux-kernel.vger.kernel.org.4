Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA964098A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiLBPpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiLBPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:45:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E15D5876;
        Fri,  2 Dec 2022 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669995926; x=1701531926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GcRX7WmZAbCTPDq8gE+aA0ZUaodFBclsrxsx/rt7bwU=;
  b=Tl7GV7kOIgEtV57qw381xD9na7npvREq5W5hgaT3fKT88LXa3cB9C1AQ
   7VawILLZyGU6D4gov7fdEa9yD8KsmrNIFT+LzsFvUOktexTZvKJgUOA6U
   iHb8oakWllAvmlqqNaP6DmOnTYwgN4vxV4uUvXYvWjgInBCUWE6D2p/Rx
   ZTkGiHigwP/8pLoNS3nuOUjCPiLvctBEABXtplq6rbpzsd5f49wmL54MY
   K3JjB7RyvNb3uJ3WTTlY/xBiII5RLQjDHpm1PPY45U4NXMcKZnlWDw/Ly
   tJS2GRxKoDLgOWLvCVZmHNiJirE0CxgcWMZ8Yd5i+u1X3YeGQ+NfMz14b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314679304"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="314679304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 07:45:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="751306221"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="751306221"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 07:45:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p18Dj-003XZC-0E;
        Fri, 02 Dec 2022 17:44:59 +0200
Date:   Fri, 2 Dec 2022 17:44:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 2/2] gpiolib: protect the GPIO device against being
 dropped while in use by user-space
Message-ID: <Y4odem+9MTsm3VPh@smile.fi.intel.com>
References: <20221202150444.244313-1-brgl@bgdev.pl>
 <20221202150444.244313-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202150444.244313-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:04:44PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> While any of the GPIO cdev syscalls is in progress, the kernel can call
> gpiochip_remove() (for instance, when a USB GPIO expander is disconnected)
> which will set gdev->chip to NULL after which any subsequent access will
> cause a crash.
> 
> To avoid that: use an RW-semaphore in which the syscalls take it for
> reading (so that we don't needlessly prohibit the user-space from calling
> syscalls simultaneously) while gpiochip_remove() takes it for writing so
> that it can only happen once all syscalls return.
> 
> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL")
> Fixes: 7b8e00d98168 ("gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> [Nick: fixed a build failure with CDEV_V1 disabled]

> Co-authored-by: Nick Hainke <vincent@systemli.org>

In Linux kernel there is no such tag. And in case you want to use
Co-developed-by, you also need to add the respective SoB one.

> Reviewed-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

-- 
With Best Regards,
Andy Shevchenko


