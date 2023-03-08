Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF56B0C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCHPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjCHPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:20:45 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D48ED0098;
        Wed,  8 Mar 2023 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678288826; x=1709824826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1VFHeWFNXdovMcEIzgnzbEz66qM8GYohzZIfUvJoTo=;
  b=kpSPfvdqdIjFnVpM1K1WrngNFyz8E9o2W99/Bk1wrcvnIVGxD7ROu3OW
   0elniMsP25/ul4Ne40/IAmI2uUa33PaE9F0TZgf8UvWJtlHnr/62nKit4
   rVOh4n5sBojFW0hy/8WuwkJ/zZorT8SK27YM+sSaHllmbjt6CGqtlrJXv
   DXmGqMDLZxMMcyAbTHBs8QZ2ExDMryyRNBEcK/TnuTL/yL73/UFJeFluS
   RlLWok+EpPOIROImjw3pmIOZV69qSSvQWrqiyvmW5mRNWK7FMGcITQBQQ
   YI8BlwtV7AClkTTbr/3E35Gz2Ij/8/xtsisuJKcWylzmmmNIQBHKmQHsv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="398756956"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="398756956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="670366953"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="670366953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2023 07:20:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pZvaY-00HU3B-1N;
        Wed, 08 Mar 2023 17:20:22 +0200
Date:   Wed, 8 Mar 2023 17:20:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
Message-ID: <ZAintWngnEtKS9kN@smile.fi.intel.com>
References: <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
 <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
 <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
 <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
 <Y/j2ikfd/wvrDdws@smile.fi.intel.com>
 <2373a9ab-1c38-35fd-e961-9a172f8ce622@alu.unizg.hr>
 <Y/05Nizuc+VJ7GNU@smile.fi.intel.com>
 <93d606c4-fe48-757b-28fa-4786ed3302c3@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93d606c4-fe48-757b-28fa-4786ed3302c3@alu.unizg.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:11:39PM +0100, Mirsad Todorovac wrote:
> On 2/28/23 00:13, Andy Shevchenko wrote:

...

> > > The logs are extensive if you are willing to skim over them, but I believe the interesting
> > > part is this:
> > 
> > I'm not sure I understand where the problem is.
> > 
> > > [ 4830.764748] kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
> > > [ 4833.908238] kobject: 'gpio-sim' (000000005b8d0726): kobject_cleanup, parent 000000007425b13f
> > > [ 4833.908244] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup kobject_del
> > > [ 4833.908245] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup 'remove' event
> > > [ 4833.908247] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
> > > [ 4833.908273] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
> > > [ 4833.908311] kobject: 'gpio-sim' (000000005b8d0726): calling ktype release
> > > [ 4833.908315] kobject: 'gpio-sim': free name
> > > [ 4834.932303] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)
> > > [ 4835.952388] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_cleanup, parent 0000000093357d30
> > > [ 4835.952413] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup kobject_del
> > > [ 4835.952415] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup 'remove' event
> > > [ 4835.952416] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
> > > [ 4835.952424] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
> > > [ 4835.952445] kobject: 'gpio_sim' (0000000096ea0bb1): calling ktype release
> > > [ 4835.952448] kobject: 'gpio_sim': free name
> > > 
> > > Or, with CONFIG_DEBUG_DEVRES=y, it looks like this:
> > 
> > I don't see that been enabled (it requires to pass a command line option to the kernel).
> 
> I don't think I have found this command line option to LK.
> 
> So far it seems that the kobject_release() was called for both /bus/platform/drivers/gpio-sim
> and /module/gpio_sim . Is there soemthing I'm missing?

Have you read the code in drivers/base/devres.c?

https://elixir.bootlin.com/linux/v6.3-rc1/source/drivers/base/devres.c#L53

> However, I've found one relatively unrelated failure to call kobject_release().
> This happens during shutdown, after the syslog is shutdown, so I can only provide
> a screenshot as a proof and for diagnostics:
> 
> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123748.jpg
> 
> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123752.jpg
> 
> I failed to locate the driver and responsible maintainers to the present moment.
> It is happening on shutdown and it isn't that critical IMHO, except if it shows
> some other problem in the code :-/

Congrats, you found a real issue somewhere.  `git grep` usually helps
with this, like `git grep -n -w '"integrity"'` shows a few files, most
likely security/integrity/iint.c is the culprit.

> > > > > > > > Or maybe the chip->gc.parent should be changed to something else (actual GPIO
> > > > > > > > device, but then it's unclear how to provide the attributes in non-racy way
> > > > > > > Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
> > > > > > > 
> > > > > > > I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
> > > > > > > device expert nor would be appropriate to try the craft not earned ;-)
> > > 
> > > With all of these additional debugging, cat /sys/kernel/debug/kmemleak
> > > showed nothing new.
> > > 
> > > I believe this is reasonably safe.
> > > 
> > > However, I was unsuccessful in seeing gpio trace, even with
> > > echo 1 > /sys/kernel/tracing/events/gpio/enable ... :-/
> > 
> > It's available in the trace buffer (you need to read a documentation to
> > understand how it works).
> 
> Still working on that, had other tasks to do ... So far I got to this:
> 
>  1020  echo "1" > /sys/kernel/tracing/events/gpio/enable
>  1021  more /sys/kernel/tracing/trace
>  1022  cd ~marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio/
>  1023  ls
>  1024  ./gpio-sim.sh
>  1025  more /sys/kernel/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 9/9   #P:6
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>      gpio-sim.sh-21157   [000] .....  2705.538025: gpio_direction: 560  in (0)
>  gpio-mockup-cde-21471   [000] .....  2705.579730: gpio_direction: 564  in (0)
>  gpio-mockup-cde-21471   [000] .....  2705.579745: gpio_value: 564 get 1
>  gpio-mockup-cde-21478   [003] .....  2705.589475: gpio_direction: 565  in (0)
>  gpio-mockup-cde-21478   [003] .....  2705.589488: gpio_value: 565 get 0
>  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_value: 589 set 1
>  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_direction: 589 out (0)
>  gpio-mockup-cde-21595   [000] .....  2705.855861: gpio_direction: 597  in (0)
>  gpio-mockup-cde-21595   [000] .....  2705.855875: gpio_value: 597 get 1

> I hope I did this right. However, I have to play a bit with these results before
> I could make any interpretation.

Yes. Just be sure you have all data dumped.

> I just wanted to provide some feedback.

Thanks.

-- 
With Best Regards,
Andy Shevchenko


