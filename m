Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2D745CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGCNPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:15:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF50DD;
        Mon,  3 Jul 2023 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688390118; x=1719926118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8GrbQ9RA64erjYeBtLXVBNh/OeM1HDqe39pSdWb3L4U=;
  b=krpm+KvVzEm6Rh8gfY28bVyqVfi0ue/zbRYBb187e/qxf89fmVeWI3A6
   WGakH/6ysdaxAKk0s5uY7bg8lq7tTiMCQKCLDhaDxydWHM+lrLItG6EhQ
   zmXeC5siBtdvVx31xN0xOrjwngSZnySqAEK20U3B6Adtt12M+rPq1FWzq
   DxBH9ORYkR4kTZsIqsDwhrWTQ9wc+UYewikAC00NnfBwo1+n5p9yo+1zr
   PeOpCHF1gmEcC+7TR86c8opWTTql803wYNC7IRzHlXq11m81jAVRpUmAP
   br1lukIz3S3yTaxYFinfdA4oMQWTrt1CQl2kJsGemWGYESdzvtZhpyAqk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="365450030"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="365450030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 06:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863085347"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863085347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 06:15:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qGJOb-001rz3-1f;
        Mon, 03 Jul 2023 16:15:13 +0300
Date:   Mon, 3 Jul 2023 16:15:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 2/3] gpiolib: acpi: Don't use GPIO chip fwnode in
 acpi_gpiochip_find()
Message-ID: <ZKLJ4TxK5t2TWjUW@smile.fi.intel.com>
References: <20230703121838.70898-1-andriy.shevchenko@linux.intel.com>
 <20230703121838.70898-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703121838.70898-3-andriy.shevchenko@linux.intel.com>
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

On Mon, Jul 03, 2023 at 03:18:37PM +0300, Andy Shevchenko wrote:

...

>  static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
>  {
> -	return ACPI_HANDLE_FWNODE(gc->fwnode) == data;
> +	return ACPI_HANDLE(&gc->gpiodev->dev) == data;
>  }

And after all this may be changed to device_match_acpi_handle().
I'll update it locally, but still wait for the Benjamin to test
this before sending a v2.

-- 
With Best Regards,
Andy Shevchenko


