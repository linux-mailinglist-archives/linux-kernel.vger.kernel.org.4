Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B76D301E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDAL0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDAL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:26:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB926247;
        Sat,  1 Apr 2023 04:25:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A5AA3604FD;
        Sat,  1 Apr 2023 13:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680348325; bh=UZm5uKtMx1HNZ4BPYNaPacR8YvooJaw+d3LERu3YTp0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xxTaUUnTq4utbRzKP20rICHNG4e9c763VNyOGH5PIDLmnWw8wndQOoJ2LODEU9dvP
         y5mSgi/M9736LpJNV1TzR547ASPtx7N7Adoz28hBVfP9YVuldmwxzyvOb9czYP96fc
         U9ObGHhyA73YU1Zu03UIWkGp9KIlwjStOEz5k4RXHVwvIryOInS/Wca/zWqdZpR665
         jmXYl8S9xRPfhVtDhl4VtfrJ6AoN3ws6EXPgsVACE98sHHKf7t2xBjVuE+HAZFo32Z
         ZMadR+SROHTATUsZBBb6dtjoab33hJ2Z8xxp+SRyChSk9B7+NP/ImqAaczkt/H8TSB
         sYal3CDgasYeA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9zk0hpqHjIrh; Sat,  1 Apr 2023 13:25:23 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 523AF604F0;
        Sat,  1 Apr 2023 13:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680348323; bh=UZm5uKtMx1HNZ4BPYNaPacR8YvooJaw+d3LERu3YTp0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mmTdfISqjZICivuAZLMwSzAIMqHZwCfjQ4lJ/IAUcDiL1rYQ67sV4XRxF72+TkKP8
         93huHdrfsNjzyWgfSzcElyEz/owX3mTPMAKxjRfi5HASd1lbTRmeyZMZI2SiwoydGx
         8rUkeosQjSOjxeZa91kLA/LtlvZnKgGIIMrj2b6es93bY21LCP76DfXitaMZdAn5Pg
         7MbGfKZwFnSvu6iK1HbBb5DWNsOXobVTQP5LVsBnMYJZDt+VjjSaJAPp0fc/uhqF1n
         PNHnOqtNrSMq+CRyOP+dnxIRYxl/fqBGcT3xqyQy3fZ2qsYHiAAKE6yhTJ6k9U6l8y
         Wkmgck1kzlBMw==
Message-ID: <112c4552-2c32-1be4-89a9-90ea9b45e988@alu.unizg.hr>
Date:   Sat, 1 Apr 2023 13:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: BUG FIX: [PATCH RFC v3] [TESTED OK] memstick_check() memleak in
 kernel 6.1.0+ introduced pre 4.17
Content-Language: en-US, hr
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
 <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
 <df560535-2a8e-de21-d45d-805159d70954@alu.unizg.hr>
 <2023033124-causing-cassette-4d96@gregkh>
 <4d80549f-e59d-6319-07fd-1fbed75d7a1c@alu.unizg.hr>
 <ZCfO90WwyS6JwaHi@kroah.com> <ZCfQQDkw3D_BXJaZ@kroah.com>
 <2023040127-untrue-obtrusive-1ea4@gregkh>
 <2023040112-immovably-cytoplasm-44ee@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023040112-immovably-cytoplasm-44ee@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 04. 2023. 11:23, Greg KH wrote:
> On Sat, Apr 01, 2023 at 11:18:19AM +0200, Greg KH wrote:
>> On Sat, Apr 01, 2023 at 08:33:36AM +0200, Greg KH wrote:
>>> On Sat, Apr 01, 2023 at 08:28:07AM +0200, Greg KH wrote:
>>>> On Sat, Apr 01, 2023 at 08:23:26AM +0200, Mirsad Goran Todorovac wrote:
>>>>>> This patch is implying that anyone who calls "dev_set_name()" also has
>>>>>> to do this hack, which shouldn't be the case at all.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> This is my best guess. Unless there is dev_free_name() or kobject_free_name(), I don't
>>>>> see a more sensible way to patch this up.
>>>>
>>>> In sleeping on this, I think this has to move to the driver core.  I
>>>> don't understand why we haven't seen this before, except maybe no one
>>>> has really noticed before (i.e. we haven't had good leak detection tools
>>>> that run with removable devices?)
>>>>
>>>> Anyway, let me see if I can come up with something this weekend, give me
>>>> a chance...
>>>
>>> Wait, no, this already should be handled by the kobject core, look at
>>> kobject_cleanup(), at the bottom.  So your change should be merely
>>> duplicating the logic there that already runs when the struct device is
>>> freed, right?
>>>
>>> So I don't understand why your change works, odd.  I need more coffee...
>>
>> I think you got half of the change correctly.  This init code is a maze
>> of twisty passages, let me take your patch and tweak it a bit into
>> something that I think should work.  This looks to be only a memstick
>> issue, not a driver core issue (which makes me feel better.)
> 
> Oops, forgot the patch.  Can you try this change here and let me know if
> that solves the problem or not?  I have compile-tested it only, so I
> have no idea if it works.
> 
> If this does work, I'll make up a "real" function to replace the
> horrible dev.kobj.name mess that a driver would have to do here as it
> shouldn't be required that a driver author knows the internals of the
> driver core that well...
> 
> thanks,
> 
> greg k-h
> 
> --------------------
> 
> 
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index bf7667845459..bbfaf6536903 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -410,6 +410,7 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
>  	return card;
>  err_out:
>  	host->card = old_card;
> +	kfree_const(card->dev.kobj.name);
>  	kfree(card);
>  	return NULL;
>  }
> @@ -468,8 +469,10 @@ static void memstick_check(struct work_struct *work)
>  				put_device(&card->dev);
>  				host->card = NULL;
>  			}
> -		} else
> +		} else {
> +			kfree_const(card->dev.kobj.name);
>  			kfree(card);
> +		}
>  	}
>  
>  out_power_off:

RESULTS:

w/o patch:

[root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# cat !$
cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffa09a93249590 (size 16):
  comm "kworker/u12:4", pid 371, jiffies 4294896466 (age 52.748s)
  hex dump (first 16 bytes):
    6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
  backtrace:
    [<ffffffff936fb25c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffff93702b39>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffff936773b9>] __kmalloc_node_track_caller+0x59/0x180
    [<ffffffff93666a0a>] kstrdup+0x3a/0x70
    [<ffffffff93666a7c>] kstrdup_const+0x2c/0x40
    [<ffffffff93aa99dc>] kvasprintf_const+0x7c/0xb0
    [<ffffffff9443b427>] kobject_set_name_vargs+0x27/0xa0
    [<ffffffff93d8ee37>] dev_set_name+0x57/0x80
    [<ffffffffc0aeff0f>] memstick_check+0x10f/0x3b0 [memstick]
    [<ffffffff933cb4c0>] process_one_work+0x250/0x530
    [<ffffffff933cb7f8>] worker_thread+0x48/0x3a0
    [<ffffffff933d6dff>] kthread+0x10f/0x140
    [<ffffffff93202fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffffa09a97205990 (size 16):
  comm "kworker/u12:4", pid 371, jiffies 4294896471 (age 52.728s)
  hex dump (first 16 bytes):
    6d 65 6d 73 74 69 63 6b 30 00 cc cc cc cc cc cc  memstick0.......
  backtrace:
    [<ffffffff936fb25c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffff93702b39>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffff936773b9>] __kmalloc_node_track_caller+0x59/0x180
    [<ffffffff93666a0a>] kstrdup+0x3a/0x70
    [<ffffffff93666a7c>] kstrdup_const+0x2c/0x40
    [<ffffffff93aa99dc>] kvasprintf_const+0x7c/0xb0
    [<ffffffff9443b427>] kobject_set_name_vargs+0x27/0xa0
    [<ffffffff93d8ee37>] dev_set_name+0x57/0x80
    [<ffffffffc0aeff0f>] memstick_check+0x10f/0x3b0 [memstick]
    [<ffffffff933cb4c0>] process_one_work+0x250/0x530
    [<ffffffff933cb7f8>] worker_thread+0x48/0x3a0
    [<ffffffff933d6dff>] kthread+0x10f/0x140
    [<ffffffff93202fa9>] ret_from_fork+0x29/0x50
[root@pc-mtodorov marvin]# uname -rms
Linux 6.3.0-rc4-mt-20230401-00199-g7b50567bdcad-dirty x86_64
[root@pc-mtodorov marvin]# 

After the patch:

[root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
[root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak

So, congratulations, this did it!

This bug I detected on 2022-11-04, but it took me four months to find the leak,
before I was "blessed by the Source". You have asked me whether I would
help the memstick developers find a solution, and I like to keep promises. :-)

At your convenience, you might add in the patch:

Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

It's been an honour serving with the memstick community with you and it was a real
brainstorming session for me.

Kind regards,
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

"I see something approaching fast ... Will it be friends with me?"

