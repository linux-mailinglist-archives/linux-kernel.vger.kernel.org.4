Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715C76B4DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCJREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCJRD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:03:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53436125AE7;
        Fri, 10 Mar 2023 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467700; x=1710003700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfE6m0dgwBfOovIxcvghhSewvFpr0K0Gj4HRwLCoAO8=;
  b=iP/V8UsCwG53g4p+rHAYZ58Yt69ufRHlneNLHD6Yv//VP7E/LMN6/uVQ
   KddUxCb/3kOJTj8ccAD0pCPVi+sv3Divwk0NDBYnbYy2Fn53eBvh5jciu
   oh/Li7tUmTGhT3cRSE9ezEMWWqsqLeXr9DDJz9eL5STCPKjbTgp5IXpcE
   MeXfPaz0xAzTIdtjepsaVs5lgy8y1J7+U8Ym+ndn+tkk7lmseMc/wgNx1
   H//TyXigG919WFDVvxUHn0dEAZzOnAFYeAEM0KdtFVO6yPst5eSNcsuLG
   ys2zcjRfUh2w/2fuzNR0Rfx3NUyCxNZCrrG2tec3WjnYjatwBDj/infbR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="316426285"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="316426285"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:01:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="680265476"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="680265476"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2023 09:01:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pag7T-0012Zi-0y;
        Fri, 10 Mar 2023 19:01:27 +0200
Date:   Fri, 10 Mar 2023 19:01:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 3/3] gpiolib: Move gpiodevice_*() to gpiodev namespace
Message-ID: <ZAtiZn+rIaNmYoZs@smile.fi.intel.com>
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
 <20230307182557.42215-4-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdW7JjWvJUtvwJDwWLB5ygPiCRWLNM8E0iyRoD=HbzfVw@mail.gmail.com>
 <ZAoq+yAyPnI4zgto@smile.fi.intel.com>
 <CAMRc=McQKK2e86m1w7q4ysGCJcSSgDjV-tkAkFa626ko+eTeUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McQKK2e86m1w7q4ysGCJcSSgDjV-tkAkFa626ko+eTeUA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:48:39PM +0100, Bartosz Golaszewski wrote:
> On Thu, Mar 9, 2023 at 7:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 08, 2023 at 11:49:53AM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Mar 7, 2023 at 7:25 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The functions that operates on the same device object would
> > > > have the same namespace for better code understanding and
> > > > maintenance.

...

> > > > -static void gpiodevice_release(struct device *dev)
> > > > +static void gpiodev_release(struct device *dev)
> > > >  {
> > > >         struct gpio_device *gdev = to_gpio_device(dev);
> > > >         unsigned long flags;
> > > > @@ -617,7 +617,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
> > > >                 return ret;
> > > >
> > > >         /* From this point, the .release() function cleans up gpio_device */
> > > > -       gdev->dev.release = gpiodevice_release;
> > > > +       gdev->dev.release = gpiodev_release;
> > > >
> > > >         ret = gpiochip_sysfs_register(gdev);
> > > >         if (ret)
> >
> > > But the only other function that's in the gpiodev_ namespace operates
> > > on struct gpio_device so that change doesn't make much sense to me.
> >
> > I'm not sure I understood the comment.
> > After this change we will have
> >
> > static int gpiodev_add_to_list(struct gpio_device *gdev)
> > static void gpiodev_release(struct device *dev)
> >
> 
> Do you want to use the same prefix for both because struct device in
> the latter is embedded in struct gpio_device in the former?

Yes, the logic to have logically grouped namespace for these APIs.
Meaning on what they are taking as an effective object to proceed
with.

> > There are also gpio_device_*() I have noticed, so may be these should be
> > actually in that namespace?
> >
> > And we have
> >
> > static int gpiochip_setup_dev(struct gpio_device *gdev)
> > static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
> >
> > That said, what do you think is the best to make this more consistent?

-- 
With Best Regards,
Andy Shevchenko


