Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A556B166B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCHXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCHXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:17:49 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EAE13DDD;
        Wed,  8 Mar 2023 15:17:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 86B34604EF;
        Thu,  9 Mar 2023 00:17:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678317464; bh=jd225+LdObFK2imx8dGnAelenv+8h3wehU9S6tvqC8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mvbs1VrTHnXemnbywGzyXTd7i7ITxOTJtDs6X3y4RKL8VLTxrbQTiXuYI4nA21nAk
         nxftdJR65TNDMajSf/DFQ4x0Arl6w52fXx4wLnsVaXqyUA/HXycCVyNXJbNlqgy88l
         085KqLB69G10fV6C1xhQ7zSEMi9l21oMubBuXlz7X7Gdj/XsQRZkZ9JgvbaijIk0Pq
         QS4oc8f7MQmqowbD8ON5XJHYgpHwr3GsqbNikiomrHZ3uEBdmeqGhsW31+AYJo5Bo8
         Gy26JaJE0pfSvTMijbIX2gg4CfQGNLBUAmHu7z4lJJuaH7LOmsDefNb/3TzzK3og07
         Z45PE2yy2VEtw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HDyhDkkTKdYE; Thu,  9 Mar 2023 00:17:41 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 13C99604ED;
        Thu,  9 Mar 2023 00:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678317461; bh=jd225+LdObFK2imx8dGnAelenv+8h3wehU9S6tvqC8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T6bbujf6aJVzamuF/8BQ32Y01YuJvsTim998NogjMfyIiZyrKfVCGfV0bWA8k/xx2
         IP1JpwmiaQ1TWaXT2Vwolvx71aor3AM3uiKqaV9VBdKJqTJeH4Ou+HkYt4YodBtG2O
         D8tWgttRNBfYw/V5d+uVaTPAw4BPaLACPVyKWoPdzGnezqyD6JQCpeIFhkld87hbnx
         2BhkwnvRD7iYGHhU4qQQAQo1VhY4oby+J3u9R2/IVHAi75DjGwA3VOIpSQwrZdzJJA
         SOfFT9Ds0l5gAek3zD4KSpbVaPUbL32+5DRMNYsK+sQDLAd5jLuyCmSE3+CzEBgXhM
         9W5vJF/JlrhBA==
Message-ID: <185285b3-9428-5051-5d07-8a49d6ba75c1@alu.unizg.hr>
Date:   Thu, 9 Mar 2023 00:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
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
 <ZAintWngnEtKS9kN@smile.fi.intel.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAintWngnEtKS9kN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 03. 2023. 16:20, Andy Shevchenko wrote:
> On Wed, Mar 08, 2023 at 02:11:39PM +0100, Mirsad Todorovac wrote:
>> On 2/28/23 00:13, Andy Shevchenko wrote:
> 
> ...
> 
>>>> The logs are extensive if you are willing to skim over them, but I believe the interesting
>>>> part is this:
>>>
>>> I'm not sure I understand where the problem is.
>>>
>>>> [ 4830.764748] kobject: 'gpio-sim' (000000005b8d0726): kobject_release, parent 000000007425b13f (delayed 750)
>>>> [ 4833.908238] kobject: 'gpio-sim' (000000005b8d0726): kobject_cleanup, parent 000000007425b13f
>>>> [ 4833.908244] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup kobject_del
>>>> [ 4833.908245] kobject: 'gpio-sim' (000000005b8d0726): auto cleanup 'remove' event
>>>> [ 4833.908247] kobject: 'gpio-sim' (000000005b8d0726): kobject_uevent_env
>>>> [ 4833.908273] kobject: 'gpio-sim' (000000005b8d0726): fill_kobj_path: path = '/bus/platform/drivers/gpio-sim'
>>>> [ 4833.908311] kobject: 'gpio-sim' (000000005b8d0726): calling ktype release
>>>> [ 4833.908315] kobject: 'gpio-sim': free name
>>>> [ 4834.932303] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_release, parent 0000000093357d30 (delayed 250)
>>>> [ 4835.952388] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_cleanup, parent 0000000093357d30
>>>> [ 4835.952413] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup kobject_del
>>>> [ 4835.952415] kobject: 'gpio_sim' (0000000096ea0bb1): auto cleanup 'remove' event
>>>> [ 4835.952416] kobject: 'gpio_sim' (0000000096ea0bb1): kobject_uevent_env
>>>> [ 4835.952424] kobject: 'gpio_sim' (0000000096ea0bb1): fill_kobj_path: path = '/module/gpio_sim'
>>>> [ 4835.952445] kobject: 'gpio_sim' (0000000096ea0bb1): calling ktype release
>>>> [ 4835.952448] kobject: 'gpio_sim': free name
>>>>
>>>> Or, with CONFIG_DEBUG_DEVRES=y, it looks like this:
>>>
>>> I don't see that been enabled (it requires to pass a command line option to the kernel).
>>
>> I don't think I have found this command line option to LK.
>>
>> So far it seems that the kobject_release() was called for both /bus/platform/drivers/gpio-sim
>> and /module/gpio_sim . Is there soemthing I'm missing?
> 
> Have you read the code in drivers/base/devres.c?
> 
> https://elixir.bootlin.com/linux/v6.3-rc1/source/drivers/base/devres.c#L53

Actually, it was in the manual all the time, but I have missed it somehow:
https://cateee.net/lkddb/web-lkddb/DEBUG_DEVRES.html

Here is the log (DEVRES debug was not in dmesg output, so after rsyslog dies,
there is no output to debug deallocs past that point):

https://domac.alu.hr/~mtodorov/linux/bugreports/gpio/devres_trace.log

Note that last 5 lines occur after `rmmod gpio-sim`:

Mar  8 23:23:55 pc-mtodorov kernel: kobject: 'gpio-sim' (00000000f0ead702): kobject_release, parent 00000000bb6cefbb (delayed 500)
Mar  8 23:23:55 pc-mtodorov kernel: kobject: 'drivers' (000000004fba12b9): kobject_release, parent 000000002c2cc344 (delayed 750)
Mar  8 23:23:55 pc-mtodorov kernel: kobject: 'holders' (00000000bfd7f234): kobject_release, parent 000000002c2cc344 (delayed 750)
Mar  8 23:23:55 pc-mtodorov kernel: kobject: 'notes' (00000000f2d17f82): kobject_release, parent 000000002c2cc344 (delayed 250)
Mar  8 23:23:59 pc-mtodorov kernel: kobject: 'gpio_sim' (000000002c2cc344): kobject_release, parent 00000000061436c2 (delayed 250)

>> However, I've found one relatively unrelated failure to call kobject_release().
>> This happens during shutdown, after the syslog is shutdown, so I can only provide
>> a screenshot as a proof and for diagnostics:
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123748.jpg
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/integrity/20230308_123752.jpg
>>
>> I failed to locate the driver and responsible maintainers to the present moment.
>> It is happening on shutdown and it isn't that critical IMHO, except if it shows
>> some other problem in the code :-/
> 
> Congrats, you found a real issue somewhere.  `git grep` usually helps
> with this, like `git grep -n -w '"integrity"'` shows a few files, most
> likely security/integrity/iint.c is the culprit.

Looking more closely, this seems to be suspicious:

DEFINE_LSM(integrity) = {
	.name = "integrity",
	.init = integrity_iintcache_init,
};

.release member is missing.

However, struct lsm_info doesn't have the "release" member, so I wonder
what called release() in the first place?

https://elixir.bootlin.com/linux/v6.3-rc1/source/include/linux/lsm_hooks.h#L1733

struct lsm_info {
	const char *name;	/* Required. */
	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
	unsigned long flags;	/* Optional: flags describing LSM */
	int *enabled;		/* Optional: controlled by CONFIG_LSM */
	int (*init)(void);	/* Required. */
	struct lsm_blob_sizes *blobs; /* Optional: for blob sharing. */
};

extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];

#define DEFINE_LSM(lsm)							\
	static struct lsm_info __lsm_##lsm				\
		__used __section(".lsm_info.init")			\
		__aligned(sizeof(unsigned long))

But maybe the object is just deallocated and doesn't need kobject cleanup?
Actually it allocated "iint_cache".

Just a thought - if lsm_info had a release() member, it would be simple to
fix this:

 static int __init integrity_iintcache_init(void)
 { 
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
 	return 0;
 }
 
+static void integrity_iintcache_destroy(void)
+{
+	kmem_cache_destroy(iint_cache);
+}

 DEFINE_LSM(integrity) = {
	.name = "integrity",
 	.init = integrity_iintcache_init,
+	.release = integrity_iintcache_destroy,
 };

However, modifying include/linux/lsm_hooks.h is not for the faint of the heart,
I suppose.

But it seems too simple (too good to be true) that they just forgot to destroy
cache, maybe something is still alive when module is unloaded?

I still can't figure out what calls release() for "integrity" and where is the 
"integrity" kobject allocated?

>>>>>>>>> Or maybe the chip->gc.parent should be changed to something else (actual GPIO
>>>>>>>>> device, but then it's unclear how to provide the attributes in non-racy way
>>>>>>>> Really, dunno. I have to repeat that my learning curve cannot adapt so quickly.
>>>>>>>>
>>>>>>>> I merely gave the report of KMEMLEAK, otherwise I am not a Linux kernel
>>>>>>>> device expert nor would be appropriate to try the craft not earned ;-)
>>>>
>>>> With all of these additional debugging, cat /sys/kernel/debug/kmemleak
>>>> showed nothing new.
>>>>
>>>> I believe this is reasonably safe.
>>>>
>>>> However, I was unsuccessful in seeing gpio trace, even with
>>>> echo 1 > /sys/kernel/tracing/events/gpio/enable ... :-/
>>>
>>> It's available in the trace buffer (you need to read a documentation to
>>> understand how it works).
>>
>> Still working on that, had other tasks to do ... So far I got to this:
>>
>>  1020  echo "1" > /sys/kernel/tracing/events/gpio/enable
>>  1021  more /sys/kernel/tracing/trace
>>  1022  cd ~marvin/linux/kernel/linux_torvalds/tools/testing/selftests/gpio/
>>  1023  ls
>>  1024  ./gpio-sim.sh
>>  1025  more /sys/kernel/tracing/trace
>> # tracer: nop
>> #
>> # entries-in-buffer/entries-written: 9/9   #P:6
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>      gpio-sim.sh-21157   [000] .....  2705.538025: gpio_direction: 560  in (0)
>>  gpio-mockup-cde-21471   [000] .....  2705.579730: gpio_direction: 564  in (0)
>>  gpio-mockup-cde-21471   [000] .....  2705.579745: gpio_value: 564 get 1
>>  gpio-mockup-cde-21478   [003] .....  2705.589475: gpio_direction: 565  in (0)
>>  gpio-mockup-cde-21478   [003] .....  2705.589488: gpio_value: 565 get 0
>>  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_value: 589 set 1
>>  gpio-mockup-cde-21561   [003] .....  2705.721427: gpio_direction: 589 out (0)
>>  gpio-mockup-cde-21595   [000] .....  2705.855861: gpio_direction: 597  in (0)
>>  gpio-mockup-cde-21595   [000] .....  2705.855875: gpio_value: 597 get 1
> 
>> I hope I did this right. However, I have to play a bit with these results before
>> I could make any interpretation.
> 
> Yes. Just be sure you have all data dumped.

The trace from this run is:

[root@pc-mtodorov gpio]# more /sys/kernel/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 18/18   #P:6
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
     gpio-sim.sh-4199    [004] .....  1271.367102: gpio_direction: 560  in (0)
 gpio-mockup-cde-4514    [004] .....  1271.406523: gpio_direction: 564  in (0)
 gpio-mockup-cde-4514    [004] .....  1271.406537: gpio_value: 564 get 1
 gpio-mockup-cde-4521    [004] .....  1271.416032: gpio_direction: 565  in (0)
 gpio-mockup-cde-4521    [004] .....  1271.416045: gpio_value: 565 get 0
 gpio-mockup-cde-4601    [000] .....  1271.537872: gpio_value: 589 set 1
 gpio-mockup-cde-4601    [000] .....  1271.537873: gpio_direction: 589 out (0)
 gpio-mockup-cde-4626    [002] .....  1271.669199: gpio_direction: 597  in (0)
 gpio-mockup-cde-4626    [002] .....  1271.669212: gpio_value: 597 get 1
     gpio-sim.sh-4742    [001] .....  1472.168366: gpio_direction: 560  in (0)
 gpio-mockup-cde-5055    [003] .....  1472.207338: gpio_direction: 564  in (0)
 gpio-mockup-cde-5055    [003] .....  1472.207351: gpio_value: 564 get 1
 gpio-mockup-cde-5062    [003] .....  1472.216635: gpio_direction: 565  in (0)
 gpio-mockup-cde-5062    [003] .....  1472.216646: gpio_value: 565 get 0
 gpio-mockup-cde-5142    [002] .....  1472.338589: gpio_value: 589 set 1
 gpio-mockup-cde-5142    [002] .....  1472.338589: gpio_direction: 589 out (0)
 gpio-mockup-cde-5167    [000] .....  1472.469917: gpio_direction: 597  in (0)
 gpio-mockup-cde-5167    [000] .....  1472.469934: gpio_value: 597 get 1
[root@pc-mtodorov gpio]# 

>> I just wanted to provide some feedback.
> 
> Thanks.

Not at all, I am really having a great time while assisting your team. :-)

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
The European Union

