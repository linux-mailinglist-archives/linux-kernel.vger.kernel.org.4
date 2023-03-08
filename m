Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B36B0838
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCHNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCHNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:15:08 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07C6D162D;
        Wed,  8 Mar 2023 05:11:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1D117604F3;
        Wed,  8 Mar 2023 14:11:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678281107; bh=9YOSH9fsyQWwKgc7rYyqDCSYLUM86K9yyDYVc5F0/Vc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U7VOEF/wK5DEXiApc/3iVem4s5vxgIyWW+BNudaqs37JsDK/w/MCLj7mGBPK/LNEp
         HGcoUchtNEX5SHW/EN1hGIHKjfyitbGR72Sq+/7Ah20s8VYBOVOY1zlz9kfPTmctO1
         twQlKkSfiUoME6+17LxQBjEJNS7WCmBYjo+HnHJelUtU/PmSOAg+6X7WjpY/HFwGhq
         00ETNKpDPjLlz60DnmetHlsDeKZwCxEOWIBQAaJ8Cd37rPhCqXdHN4+rZN3sEMdPFl
         kl8jkU3bzj3x3w6khSNzeFQbwuzIYu+6qqiaz/qVbrV3o6NKMRjQ66UQTbtjiIy3O4
         eC8dW3U/zaOQA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SeE9Gx7tn6T1; Wed,  8 Mar 2023 14:11:44 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id C6F4D604F5;
        Wed,  8 Mar 2023 14:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678281104; bh=9YOSH9fsyQWwKgc7rYyqDCSYLUM86K9yyDYVc5F0/Vc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g3TkGpUQlkwUumtS5q6MmMBvvm9Qy4TdoDMIkg67yvd+dYj79RKFVWM5G1+jPMShW
         f+ZgKBWBiXj2gtnAjacN5r8VD4EWoxxRHzeNGkJuYWhyae5OWHAbbT3HGEULRADsnW
         HFe7OnpIZ0S3gNfEf1TTwfQnie7wq/wTq3GTnHHpBZ7f1Ff1BiXjw+Tf4UJMX+s5yS
         lWwY423Gw0iqjrk3dlPiWHT9KfxDce/xKcP7z3cKv45KzZK2XzN4OK2VvmlIx1HXqU
         HjyqeOmwa48wWFE686RY9gHpJD04ZqVZwQ9R/J5HgCdC7kwr1qOD9zuksaYasNXu7c
         R1lELc85gDnlA==
Message-ID: <93d606c4-fe48-757b-28fa-4786ed3302c3@alu.unizg.hr>
Date:   Wed, 8 Mar 2023 14:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <Y+y5nZJwZ6ykf0Fz@smile.fi.intel.com>
 <3d96e50b-ed17-9bf5-149b-8a50c7b4cca2@alu.unizg.hr>
 <CAMRc=Mcx=Ko5H_c1YGzA5Jfu3KJqx1pfL3RZuMrV6oTObnUrhQ@mail.gmail.com>
 <4b001ce6-b35d-3ad1-b757-f5f6baca7b51@alu.unizg.hr>
 <Y/N5Dt6G397rkfBd@smile.fi.intel.com>
 <d7762f6f-5b58-cf71-3400-557799de43c0@alu.unizg.hr>
 <Y/Tlq9aY3btfoVUN@smile.fi.intel.com>
 <7856e5a8-d84e-4f41-721b-80b6fc413919@alu.unizg.hr>
 <Y/j2ikfd/wvrDdws@smile.fi.intel.com>
 <2373a9ab-1c38-35fd-e961-9a172f8ce622@alu.unizg.hr>
 <Y/05Nizuc+VJ7GNU@smile.fi.intel.com>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y/05Nizuc+VJ7GNU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 00:13, Andy Shevchenko wrote:

Hi, Andy!

>> The logs are extensive if you are willing to skim over them, but I believe the interesting
>> part is this:
> 
> I'm not sure I understand where the problem is.
> 
>> [ 4830.764748] kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
>> [ 4833.908238] kobject: 'gpio-sim' (000000005b8d0726): kobject_cleanup, parent 000000007425b13f
>> [ 4833.908244] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup kobject_del
>> [ 4833.908245] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup 'remove' event
>> [ 4833.908247] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
>> [ 4833.908273] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
>> [ 4833.908311] kobject: 'gpio-sim' (000000005b8d0726): calling ktype release
>> [ 4833.908315] kobject: 'gpio-sim': free name
>> [ 4834.932303] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)
>> [ 4835.952388] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_cleanup, parent 0000000093357d30
>> [ 4835.952413] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup kobject_del
>> [ 4835.952415] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup 'remove' event
>> [ 4835.952416] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
>> [ 4835.952424] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
>> [ 4835.952445] kobject: 'gpio_sim' (0000000096ea0bb1): calling ktype release
>> [ 4835.952448] kobject: 'gpio_sim': free name
>>
>> Or, with CONFIG_DEBUG_DEVRES=y, it looks like this:
> 
> I don't see that been enabled (it requires to pass a command line option to the kernel).

I don't think I have found this command line option to LK.

So far it seems that the kobject_release() was called for both /bus/platform/drivers/gpio-sim
and /module/gpio_sim . Is there soemthing I'm missing?

However, I've found one relatively unrelated failure to call kobject_release().
This happens during shutdown, after the syslog is shutdown, so I can only provide
a screenshot as a proof and for diagnostics:

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123748.jpg

https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123752.jpg

I failed to locate the driver and responsible maintainers to the present moment.
It is happening on shutdown and it isn't that critical IMHO, except if it shows
some other problem in the code :-/

>>>>>>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>>>>>>> device, but then it's unclear how to provide the attributes in non-racy way
>>>>>> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>>>>>>
>>>>>> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
>>>>>> device expert nor would be appropriate to try the craft not earned ;-)
>>
>> With all of these additional debugging, cat /sys/kernel/debug/kmemleak
>> showed nothing new.
>>
>> I believe this is reasonably safe.
>>
>> However, I was unsuccessful in seeing gpio trace, even with
>> echo 1 > /sys/kernel/tracing/events/gpio/enable ... :-/
> 
> It's available in the trace buffer (you need to read a documentation to
> understand how it works).

Still working on that, had other tasks to do ... So far I got to this:

  1020  echo "1" > /sys/kernel/tracing/events/gpio/enable
  1021  more /sys/kernel/tracing/trace
  1022  cd ~marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio/
  1023  ls
  1024  ./gpio-sim.sh
  1025  more /sys/kernel/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 9/9   #P:6
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
      gpio-sim.sh-21157   [000] .....  2705.538025: gpio_direction: 560  in (0)
  gpio-mockup-cde-21471   [000] .....  2705.579730: gpio_direction: 564  in (0)
  gpio-mockup-cde-21471   [000] .....  2705.579745: gpio_value: 564 get 1
  gpio-mockup-cde-21478   [003] .....  2705.589475: gpio_direction: 565  in (0)
  gpio-mockup-cde-21478   [003] .....  2705.589488: gpio_value: 565 get 0
  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_value: 589 set 1
  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_direction: 589 out (0)
  gpio-mockup-cde-21595   [000] .....  2705.855861: gpio_direction: 597  in (0)
  gpio-mockup-cde-21595   [000] .....  2705.855875: gpio_value: 597 get 1
[root@pc-mtodorov gpio]#

I hope I did this right. However, I have to play a bit with these results before
I could make any interpretation.

I just wanted to provide some feedback.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
