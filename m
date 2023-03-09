Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA706B2D30
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCISxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjCISw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:52:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF192FA8FC;
        Thu,  9 Mar 2023 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678387967; x=1709923967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Nfve8Lce1zqiun7hFxXQB5VXtzhusgUqDvAevZjwCms=;
  b=QL4yPECllz8fiezQzXMucNJiDxvD2fihn58bCTow4F09ZL+a/MeEVMOh
   i4HaUAk93UhHht/AwTl0+fHhgYmRc6eTjUem1aBWRc/dj829z/kl0GaML
   0PBWg7AEn19xCG0PTSAj9B8sm/ZWaqXcA+ZjljbXTjz+2+6O77xxOcISu
   jxFTh87FTRlZEQ/lqVU8fTnFNRUvOTL7OlCuOxTUUrwhzg1GtwKRSMxPl
   0s/YW74VO9aHBVoKuqx21HpwtxGUjEF6hQ2QbGY+omY5c5u+m5Bl3PwaS
   PEghUk3A6Ehf2An/le9tXUHXG9c1E6Szqp+hliSXl2PRFfhHMI4Ld74Fs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="334014492"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="334014492"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801275762"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="801275762"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 10:52:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paLNc-000UVC-0S;
        Thu, 09 Mar 2023 20:52:44 +0200
Date:   Thu, 9 Mar 2023 20:52:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/3] gpiolib: Move gpiodevice_*() to gpiodev namespace
Message-ID: <ZAoq+yAyPnI4zgto@smile.fi.intel.com>
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
 <20230307182557.42215-4-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdW7JjWvJUtvwJDwWLB5ygPiCRWLNM8E0iyRoD=HbzfVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdW7JjWvJUtvwJDwWLB5ygPiCRWLNM8E0iyRoD=HbzfVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:49:53AM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 7, 2023 at 7:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The functions that operates on the same device object would
> > have the same namespace for better code understanding and
> > maintenance.

...

> > -static void gpiodevice_release(struct device *dev)
> > +static void gpiodev_release(struct device *dev)
> >  {
> >         struct gpio_device *gdev = to_gpio_device(dev);
> >         unsigned long flags;
> > @@ -617,7 +617,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
> >                 return ret;
> >
> >         /* From this point, the .release() function cleans up gpio_device */
> > -       gdev->dev.release = gpiodevice_release;
> > +       gdev->dev.release = gpiodev_release;
> >
> >         ret = gpiochip_sysfs_register(gdev);
> >         if (ret)

> But the only other function that's in the gpiodev_ namespace operates
> on struct gpio_device so that change doesn't make much sense to me.

I'm not sure I understood the comment.
After this change we will have

static int gpiodev_add_to_list(struct gpio_device *gdev)
static void gpiodev_release(struct device *dev)

There are also gpio_device_*() I have noticed, so may be these should be
actually in that namespace?

And we have

static int gpiochip_setup_dev(struct gpio_device *gdev)
static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)

That said, what do you think is the best to make this more consistent?

-- 
With Best Regards,
Andy Shevchenko


