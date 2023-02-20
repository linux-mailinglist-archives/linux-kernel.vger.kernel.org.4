Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FA569CCD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBTNnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjBTNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:43:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F791CF65;
        Mon, 20 Feb 2023 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676900626; x=1708436626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5Fzs0PuYxqzAHUd7WjCollPuEeFNcBcwHoxSVkIjbQ=;
  b=B2VAaFC+xOEObTKYGGLXAzgxMo7Qqru3cgTYq8b2KE3ccWZ8Uz5gnggk
   IRFpLnz/0GgD0rSnIkYh98uhdjSulo94uh6uUNWJRpVx++lIYmjKsSWWm
   ho2B8MHKgmf1ENBzej1a6bGHt2mKJomKqJURv1liEjtZ8832ePBl/V0Zf
   twR0UdImbfAZ/yBGhPJqhMJ625ngZ+ccAv7iQm99JoK8NtV31jxuceRuL
   K6lu/YJYm3Gr7kC9RuKeuY0NiRX2hHNWvC73zsTsd8jDxR0XlES2UZBXO
   iUBhnVNl4YFktexZEd5ncnPbnIBYX1/1p56CbVcHMHrK8X+tgS9b19PI9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332406164"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="332406164"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 05:43:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="814142224"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="814142224"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2023 05:43:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pU6SE-009R9G-2p;
        Mon, 20 Feb 2023 15:43:42 +0200
Date:   Mon, 20 Feb 2023 15:43:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Message-ID: <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
 <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
 <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
 <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
 <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
> On 2/16/23 15:16, Bartosz Golaszewski wrote:

...

> As Mr. McKenney once said, a bunch of monkeys with keyboard could
> have done it in a considerable number of trials and errors ;-)
> 
> But here I have something that could potentially leak as well. I could not devise a
> reproducer due to the leak being lightly triggered only in extreme memory contention.
> 
> See it for yourself:
> 
> drivers/gpio/gpio-sim.c:
>  301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>  302 {
>  303         struct device_attribute *val_dev_attr, *pull_dev_attr;
>  304         struct gpio_sim_attribute *val_attr, *pull_attr;
>  305         unsigned int num_lines = chip->gc.ngpio;
>  306         struct device *dev = chip->gc.parent;
>  307         struct attribute_group *attr_group;
>  308         struct attribute **attrs;
>  309         int i, ret;
>  310
>  311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
>  312                                          num_lines + 1, GFP_KERNEL);
>  313         if (!chip->attr_groups)
>  314                 return -ENOMEM;
>  315
>  316         for (i = 0; i < num_lines; i++) {
>  317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
>  318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
>  319                                      GFP_KERNEL);
>  320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>  321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>  322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
>  323                         return -ENOMEM;
>  324
>  325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
>  326                                                   "sim_gpio%u", i);
>  327                 if (!attr_group->name)
>  328                         return -ENOMEM;
> 
> Apparently, if the memory allocation only partially succeeds, in the theoretical case
> that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
> free the partially succeeded allocs, would it?
> 
> To explain it better, I tried a version that is not yet full doing "all or nothing"
> memory allocation for the gpio-sim driver, because I am not that familiar with the
> driver internals.

devm_*() mean that the resource allocation is made in a managed manner, so when
it's done, it will be freed automatically.

The question is: is the lifetime of the attr_groups should be lesser or the
same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?

Or maybe the chip->gc.parent should be changed to something else (actual GPIO
device, but then it's unclear how to provide the attributes in non-racy way.

-- 
With Best Regards,
Andy Shevchenko


