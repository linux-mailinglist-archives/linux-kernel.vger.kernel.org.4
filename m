Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C76640871
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiLBOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLBOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:30:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74CBBDB;
        Fri,  2 Dec 2022 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669991441; x=1701527441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nTnEijI8Fb2UVr0W+JyDLaLc4bx6bhIBKTbFLfhAcuI=;
  b=l+nqzCxzUcqfCXJz8IPC1hml78Eexak2zIFD0UJIoNgtqEqeLmDNLxKN
   +84EAHaJ/3NGFf6hTm/NYRoxmq/XlwP/EdubM3wICBbraVhHrLFg8og9D
   ySVigk0sv45rhwnY6zaqSj8NOC6MfdqetOEyHaQwkIGAIR6EMuH+IABFu
   OvNA0viKFiw8Z+f/OqSKw4r3f7j1v/iXaeFTaO6VgJ9UVCCZZ+z0EN/xy
   mwU1PdZ2ED8Es/c+Tav1MH6WFrAonstJSes4c6n0WU+1IYWpT+L7IjXOV
   tOkVC4rHtKQq0ZcjL5VHWPkAEdbFidgpFRu/M7ONkXmwxoKDHMdf++BYx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342900903"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342900903"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819449631"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="819449631"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 06:30:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p173h-003Vm8-2J;
        Fri, 02 Dec 2022 16:30:33 +0200
Date:   Fri, 2 Dec 2022 16:30:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nick Hainke <vincent@systemli.org>
Cc:     linux-next@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: fix compiling when CONFIG_GPIO_CDEV_V1 is not
 defined
Message-ID: <Y4oMCYksMaQ6KYwU@smile.fi.intel.com>
References: <20221202140454.273333-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202140454.273333-1-vincent@systemli.org>
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

On Fri, Dec 02, 2022 at 03:04:54PM +0100, Nick Hainke wrote:

Thank you for the report!

I believe Bart needs to fold it into his patch / PR, because
it's not good to send a broken PR to Linus.

> If CONFIG_GPIO_CDEV_V1 is not defined compiling will fail with:
> 
> drivers/gpio/gpiolib-cdev.c: In function 'linereq_ioctl':
> drivers/gpio/gpiolib-cdev.c:1468:16: error: implicit declaration of
>  function 'call_ioctl_locked' [-Werror=implicit-function-declaration]
>  1468 |         return call_ioctl_locked(file, cmd, arg, lr->gdev,
>       |                ^~~~~~~~~~~~~~~~~
> drivers/gpio/gpiolib-cdev.c: In function 'linereq_poll':
> drivers/gpio/gpiolib-cdev.c:1503:16: error: implicit declaration of
>  function 'call_poll_locked'; did you mean 'wake_up_all_locked'?
>  [-Werror=implicit-function-declaration]
>  1503 |         return call_poll_locked(file, wait, lr->gdev,
>                                       linereq_poll_unlocked);
>       |                ^~~~~~~~~~~~~~~~
>       |                wake_up_all_locked
> drivers/gpio/gpiolib-cdev.c: In function 'linereq_read':
> drivers/gpio/gpiolib-cdev.c:1566:16: error: implicit declaration of
>  function 'call_read_locked'; did you mean 'xa_head_locked'?
>  [-Werror=implicit-function-declaration]
>  1566 |         return call_read_locked(file, buf, count, f_ps, lr->gdev,
>       |                ^~~~~~~~~~~~~~~~
>       |                xa_head_locked

Above is a bit too noisy for the commit message. It can be trimmed 3x times.

> Move "call_poll_locked", "call_ioctl_locked", "call_read_locked" and
> the necessary typedefs "poll_fn", "ioctl_fn", "read_fn" in front of the
> ifdef-statement checking CONFIG_GPIO_CDEV_V1.

> Fixes: 98d8b93c6171 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")
> 
> Signed-off-by: Nick Hainke <vincent@systemli.org>

Mustn't be blank line(s) in the tag block.

-- 
With Best Regards,
Andy Shevchenko


