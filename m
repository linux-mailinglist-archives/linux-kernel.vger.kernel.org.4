Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BFF6A2091
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBXRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBXRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:40:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAB6ADD0;
        Fri, 24 Feb 2023 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677260430; x=1708796430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3EXCROmbAWje/m/hEXKjA+6CDwxFrm7Z1h1UtWhvxI=;
  b=U7DrLR+4kyrzbJG1KDmtHXYUFGZqoMlZrsyQ7cJOesyDyfBx1lzwOo5e
   u1VdSFqqm1GKDzmXhzGI0WBUAhKe/p82ext5WB1sopmCwWDbLt/Oa5HYv
   /FgeyOx6fWCDGnLz64ytIg9onEX/yxldVU/kD2zgjn5QSvJ4yjOqv7UZB
   M+bkLZecjmrCbqO2ZcadrffLUOHWvV44+fSa/oJaUQXb9/FoZLuyAb5+W
   fhRNzs+K38f/AQ7ds9huR4lZIB5BAGXe0bb70E0iSgVLqWpntLOMwYXtz
   LlWXd480nc6m8k0Qz0XXIWI1RYM7Z5FhiKLqM/4B+cxDfW990pHx+I19I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317293337"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="317293337"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 09:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="918500680"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="918500680"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2023 09:40:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pVc3W-00BZaL-1Y;
        Fri, 24 Feb 2023 19:40:26 +0200
Date:   Fri, 24 Feb 2023 19:40:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Message-ID: <Y/j2ikfd/wvrDdws@smile.fi.intel.com>
References: <Y+j1dbZ0A1mndwXp@smile.fi.intel.com>
 <36d8e761-58e2-2515-fd1a-65a11731d1b1@alu.unizg.hr>
 <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
 <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
 <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
 <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
 <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:12:31PM +0100, Mirsad Todorovac wrote:
> On 2/21/23 16:39, Andy Shevchenko wrote:
> > On Tue, Feb 21, 2023 at 02:52:38PM +0100, Mirsad Goran Todorovac wrote:
> > > On 20. 02. 2023. 14:43, Andy Shevchenko wrote:
> > > > On Mon, Feb 20, 2023 at 02:10:00PM +0100, Mirsad Todorovac wrote:
> > > > > On 2/16/23 15:16, Bartosz Golaszewski wrote:

...

> > > > > As Mr. McKenney once said, a bunch of monkeys with keyboard could
> > > > > have done it in a considerable number of trials and errors ;-)
> > > > > 
> > > > > But here I have something that could potentially leak as well. I could not devise a
> > > > > reproducer due to the leak being lightly triggered only in extreme memory contention.
> > > > > 
> > > > > See it for yourself:
> > > > > 
> > > > > drivers/gpio/gpio-sim.c:
> > > > >   301 static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
> > > > >   302 {
> > > > >   303         struct device_attribute *val_dev_attr, *pull_dev_attr;
> > > > >   304         struct gpio_sim_attribute *val_attr, *pull_attr;
> > > > >   305         unsigned int num_lines = chip->gc.ngpio;
> > > > >   306         struct device *dev = chip->gc.parent;
> > > > >   307         struct attribute_group *attr_group;
> > > > >   308         struct attribute **attrs;
> > > > >   309         int i, ret;
> > > > >   310
> > > > >   311         chip->attr_groups = devm_kcalloc(dev, sizeof(*chip->attr_groups),
> > > > >   312                                          num_lines + 1, GFP_KERNEL);
> > > > >   313         if (!chip->attr_groups)
> > > > >   314                 return -ENOMEM;
> > > > >   315
> > > > >   316         for (i = 0; i < num_lines; i++) {
> > > > >   317                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
> > > > >   318                 attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
> > > > >   319                                      GFP_KERNEL);
> > > > >   320                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
> > > > >   321                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
> > > > >   322                 if (!attr_group || !attrs || !val_attr || !pull_attr)
> > > > >   323                         return -ENOMEM;
> > > > >   324
> > > > >   325                 attr_group->name = devm_kasprintf(dev, GFP_KERNEL,
> > > > >   326                                                   "sim_gpio%u", i);
> > > > >   327                 if (!attr_group->name)
> > > > >   328                         return -ENOMEM;
> > > > > 
> > > > > Apparently, if the memory allocation only partially succeeds, in the theoretical case
> > > > > that the system is close to its kernel memory exhaustion, `return -ENOMEM` would not
> > > > > free the partially succeeded allocs, would it?
> > > > > 
> > > > > To explain it better, I tried a version that is not yet full doing "all or nothing"
> > > > > memory allocation for the gpio-sim driver, because I am not that familiar with the
> > > > > driver internals.
> > > > 
> > > > devm_*() mean that the resource allocation is made in a managed manner, so when
> > > > it's done, it will be freed automatically.
> > > 
> > > Didn't see that one coming ... :-/ "buzzing though the bush ..."
> > > 
> > > > The question is: is the lifetime of the attr_groups should be lesser or the
> > > > same as chip->gc.parent? Maybe it's incorrect to call devm_*() in the first place?
> > > 
> > > Bona fide said, I hope that automatic deallocation does things in the right order.
> > > I've realised that devm_kzalloc() calls devm_kmalloc() that registers allocations on
> > > a per driver list. But I am not sure how chip->gc was allocated?
> > > 
> > > Here is said it is allocated in drivers/gpio/gpio-sim.c:386 in gpio_sim_add_bank(),
> > > as a part of
> > > 
> > > 	struct gpio_sim_chip *chip;
> > > 	struct gpio_chip *gc;
> > > 
> > > 	gc = &chip->gc;
> > > 
> > > and gc->parent is set to
> > > 
> > > 	gc->parent = dev;
> > > 
> > > in line 420, which appears called before gpio_sim_setup_sysfs() and the lines above.
> > > 
> > > If I understood well, automatic deallocation on unloading the driver goes
> > > in the reverse order, so lifetime of chip appears to be longer than attr_groups,
> > > but I am really not that good at this ...
> > 
> > So, the device is instantiated by platform_device_register_full().
> > 
> > It should gone with the platform_device_unregister().
> > 
> > In case of CONFIG_DEBUG_KOBJECT_RELEASE=y the ->release() can be called
> > asynchronously.
> > 
> > So, there are following questions:
> > - is the put_device() is actually called?
> > - is the above mentioned option is set to Y?
> > - if it's in Y, does kmemleak take it into account?
> > - if no, do you get anything new in `dmesg` when enable it?
> 
> Hi, Andy,
> 
> Having set CONFIG_DEBUG_KOBJECT=y.
> CONFIG_DEBUG_KOBJECT_RELEASE=y and CONFIG_DEBUG_OBJECTS_TIMERS=y disappear after "make olddefconfig"
> 
> So, I cannot tell about whether release() was called asynchronously, all I get is (after driver unload):
> 
> [  810.989742] kobject: 'gpio-sim' (00000000251afa19): kobject_cleanup, parent 00000000447da7a7
> [  810.990216] kobject: 'gpio-sim' (00000000251afa19): auto cleanup kobject_del
> [  810.990674] kobject: 'gpio-sim' (00000000251afa19): auto cleanup 'remove' event
> [  810.991175] kobject: 'gpio-sim' (00000000251afa19): kobject_uevent_env
> [  810.991674] kobject: 'gpio-sim' (00000000251afa19): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
> [  810.992154] kobject: 'gpio-sim' (00000000251afa19): calling ktype release
> [  810.992644] kobject: 'gpio-sim': free name
> 
> I am still trying to convince "make olddefconfig" to accept the above values he did not like :-/

Btw, since devm_*() is in use, you may enable trace events (I have added them a
few releases back) and see how objects allocated with devm are getting
released.

Before that there is a possibility to enable debug for devm.
CONFIG_DEBUG_DEVRES for that (you may see how it's used in the
drivers/base/devres.c).

> > > > Or maybe the chip->gc.parent should be changed to something else (actual GPIO
> > > > device, but then it's unclear how to provide the attributes in non-racy way
> > > Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
> > > 
> > > I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
> > > device expert nor would be appropriate to try the craft not earned ;-)

-- 
With Best Regards,
Andy Shevchenko


