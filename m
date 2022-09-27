Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BDE5EC29E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiI0MZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiI0MZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:25:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCD13F5C;
        Tue, 27 Sep 2022 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664281517; x=1695817517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uHlwyyAfGs6sijiQoaAvC3RoNVuCCCsZ0iDXsiuLQCk=;
  b=WcsD2wHzpRp2Xk8oVpRw3aJNlkrg5+JJLf+ANeqBFUmdcK/JTPrOVYyT
   W/qVwyrJKhUleikH2AgB54erkYtnJXZCORXVYqys8rE+c3SqhiV0FFzH8
   DpwJG40w3RgAzhoAK3XEuxBU0JeamqlKqkAA+e5xUTrSShiRbmHBvco50
   HOC38uCLTrY19LaSV7moGju3RX+KeFSxIOxnVxeWADYO39GrG/BWU6PQl
   k7A+aRaHjqvKBo5NR3VNRlZovb+OcjD65A9sZarwwvDDjdl6e9iK5BY+7
   uzt45yZHfh8pkhsB/BeTgrWQfayZxlnaOlV1HLVWGPQHkP7bGNNNXSbP7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="300022732"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="300022732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:25:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725493383"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="725493383"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2022 05:25:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1od9eD-008RQy-0W;
        Tue, 27 Sep 2022 15:25:13 +0300
Date:   Tue, 27 Sep 2022 15:25:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: twl4030-irq: add missing device.h include
Message-ID: <YzLrqADfXO3x38h7@smile.fi.intel.com>
References: <20220927052217.2784593-1-dmitry.torokhov@gmail.com>
 <20220927052217.2784593-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927052217.2784593-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:22:15PM -0700, Dmitry Torokhov wrote:
> The driver is using "struct device" and therefore needs to include
> device.h header. We used to get this definition indirectly via inclusion
> of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
> from unnecessary includes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/twl4030-irq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
> index 4f576f0160a9..87496c1cb8bc 100644
> --- a/drivers/mfd/twl4030-irq.c
> +++ b/drivers/mfd/twl4030-irq.c
> @@ -14,6 +14,7 @@
>   * by syed khasim <x0khasim@ti.com>
>   */
>  
> +#include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 

-- 
With Best Regards,
Andy Shevchenko


