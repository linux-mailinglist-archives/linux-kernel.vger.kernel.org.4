Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62B606239
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJTNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJTNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:51:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F72181D81;
        Thu, 20 Oct 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666273865; x=1697809865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLLFKLdR8QHeqJ8ykIP9osVfd7AvWCqdb2p3WTU8Lqs=;
  b=hQ9zEkIZVCwNiaPW37LG0NLo1nLXql1raxN1PgsjoYwxbH4dH3SB0D3h
   QPT+MCnoh7u9ZZ/V50+JyyaNCqwIq4eo3oa2CsXHPO3FVw6BDzoufPj82
   all6Gjk/0dRfmex9Yhjda1mlms9IWhgsSJEQDU2bU+CGg3gEF9SceUcxx
   pO7Luh5V7//V4cIT5LgAsMYMLDUMkb9UAWBB/nlXuLJBCUoCDIwsjbbsV
   4pS+LLGRMZaO5eJrgoCS6eS9Nh69bh/gpKR+tdayuIkfgfi9u3Bc2GXyh
   cs/RxkLAvJLCbMPd33mQcVqWvAHG1eu4OEJ1Lm5KVsPcAEMIWMZFXPnRZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290017264"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="290017264"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719070007"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="719070007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 06:51:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olVwq-00AZVW-2M;
        Thu, 20 Oct 2022 16:51:00 +0300
Date:   Thu, 20 Oct 2022 16:51:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Xiang Yang <xiangyang3@huawei.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] gpiolib: acpi: Use METHOD_NAME__AEI macro for
 acpi_walk_resources
Message-ID: <Y1FSRJC9s+7cvJI3@smile.fi.intel.com>
References: <20221020014426.188667-1-xiangyang3@huawei.com>
 <CAMRc=Md6nseghBwfiRCL0KQ1BJ0WE7MH9QENf=HdJdnC1Xz1Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Md6nseghBwfiRCL0KQ1BJ0WE7MH9QENf=HdJdnC1Xz1Fg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:23:27PM +0200, Bartosz Golaszewski wrote:
> On Thu, Oct 20, 2022 at 3:48 AM Xiang Yang <xiangyang3@huawei.com> wrote:
> >
> > Using the METHOD_NAME__AEI macro instead of using "_AEI" directly.
> >
> > Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
> > ---
> >  drivers/gpio/gpiolib-acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index a7d2358736fe..064ba5150fd4 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -512,7 +512,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
> >         if (ACPI_FAILURE(status))
> >                 return;
> >
> > -       acpi_walk_resources(handle, "_AEI",
> > +       acpi_walk_resources(handle, METHOD_NAME__AEI,
> >                             acpi_gpiochip_alloc_event, acpi_gpio);
> 
> This line dates back to 2018 so why -next in your PATCH tag?

This means "for Linux next cycle". It has roots in the net subsystem where
it's a requirement to mark each patch either net or net-next, because they
have a huge traffic of patches.

> That being said - patch applied (unless Andy wants to take it directly).

I think I will take it. Care to provide your tag?

-- 
With Best Regards,
Andy Shevchenko


