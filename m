Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10E63BD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiK2J7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2J7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:59:36 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C7BEA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:59:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3D612604EC;
        Tue, 29 Nov 2022 10:59:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669715972; bh=xaPsjAF2CY9Q2ItNcYNkw53bmGEKZZqnjZA1bjqbjow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hya0/G+eP6Qpt6Pc0icst8ghpLhpbuKzqltX1oe0C3vaEoVafuAZrye+dNiKiuDKF
         xF6KT2so3LWi6aIJD40uNV1iZ86MeGMx2k1/y1mFSeuOa8zRgVmsxMZBvN8YgPFTED
         nHXgwmqJCS6xNWfgPjY80ADaY4L9OVkahFLQcCyUW4VwJSN00tEt4G/MW1uaz3c7mt
         +j8MEBx6veo0UNGqQhGY5KsYSt5yh7rwnfY9jI8LTN06kSB8Wq5f94VpVSGNifpaqP
         +US17349HkKTtrUpFzQ4FzSszFlMqSAFueAcXjVh7tRZkjZlXn2wcrYewlBoOORX3a
         mhinei46kLX1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 25Vo8IAEzJKp; Tue, 29 Nov 2022 10:59:29 +0100 (CET)
Received: from [10.0.1.128] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 3ABBE604E7;
        Tue, 29 Nov 2022 10:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669715969; bh=xaPsjAF2CY9Q2ItNcYNkw53bmGEKZZqnjZA1bjqbjow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eBarWx18kpmei1MCl2DEZnZRaKDPOWw7RnXZY7IQ4oBHuuzE+fjiU8yhjECD/VMWi
         U9l1PcMZp7SQbpSJFo0Q8pNK8M/M/72q2d6QaWWifsGVlvYMm+tFfUGVY+gFqLU3ej
         9dGu+Fnm143EoEgRyRQLxZAuDmjvLYdlGlORTJcR0XwtWzvqpzq6OrhOAGKlTyxDOr
         9gNYVLdvWTb83GPHmfhr2w8h+Gh/EdGwz/va+it+pu7NgEeUs1NU2S549IpFEO0v0L
         CQDfD5tDgMIhtx5gfvqyZAhupCreDUz15QiZ0tbuU8knCI5PZTRP9aLuKck7xD66XI
         XBW5Ndgk91o9w==
Message-ID: <2fb2453f-2d82-5fe9-bc4e-7ec5150441ac@alu.unizg.hr>
Date:   Tue, 29 Nov 2022 10:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Jiri Slaby <jirislaby@gmail.com>,
        Joey Pabalan <jpabalanb@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Vasiliy Kulikov <segooon@gmail.com>,
        Wang Hai <wanghai26@huawei.com>,
        Wolfram Sang <wsa@the-dreams.de>
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
 <Y2zCYwNNvQWppLWZ@kroah.com>
 <df01bde2-65ab-3892-ec9d-848d94e5b8e7@alu.unizg.hr>
 <Y4XEiqn91WhfJoFH@kroah.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y4XEiqn91WhfJoFH@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.2022. 9:36, Greg KH wrote:
> On Tue, Nov 29, 2022 at 04:35:10AM +0100, Mirsad Goran Todorovac wrote:
>> On 10. 11. 2022. 10:20, Greg KH wrote:
>>> On Thu, Nov 10, 2022 at 05:57:57AM +0100, Mirsad Goran Todorovac wrote:
>>>> On 04. 11. 2022. 11:40, Mirsad Goran Todorovac wrote:
>>>>
>>>>> Dear Sirs,
>>>>>
>>>>> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled
>>>>> CONFIG_DEBUG_KMEMLEAK=y
>>>>> and the result showed an unreferenced object in kworker process:
>>>>>
>>>>> # cat /sys/kernel/debug/kmemleak
>>>>> unreferenced object 0xffffa01dabff6100 (size 16):
>>>>>     comm "kworker/u12:4", pid 400, jiffies 4294894771 (age 5284.956s)
>>>>>     hex dump (first 16 bytes):
>>>>>       6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>>>>>     backtrace:
>>>>>       [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>>>>>       [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>>>>>       [<0000000005472512>] kstrdup+0x36/0x70
>>>>>       [<000000002f797ac4>] kstrdup_const+0x28/0x30
>>>>>       [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>>>>>       [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>>>>>       [<000000004158a6c0>] dev_set_name+0x53/0x70
>>>>>       [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>>>>>       [<00000000122bb894>] process_one_work+0x214/0x3f0
>>>>>       [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>>>>>       [<0000000002409855>] kthread+0xed/0x120
>>>>>       [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
>>>>> unreferenced object 0xffffa01dabff6ec0 (size 16):
>>>>>     comm "kworker/u12:4", pid 400, jiffies 4294894774 (age 5284.944s)
>>>>>     hex dump (first 16 bytes):
>>>>>       6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>>>>>     backtrace:
>>>>>       [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>>>>>       [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>>>>>       [<0000000005472512>] kstrdup+0x36/0x70
>>>>>       [<000000002f797ac4>] kstrdup_const+0x28/0x30
>>>>>       [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>>>>>       [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>>>>>       [<000000004158a6c0>] dev_set_name+0x53/0x70
>>>>>       [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>>>>>       [<00000000122bb894>] process_one_work+0x214/0x3f0
>>>>>       [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>>>>>       [<0000000002409855>] kthread+0xed/0x120
>>>>>       [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
>>>>> #
>>>>>
>>>>> Please fing the build config and lshw output attached.
>>>>>
>>>>> dmesg is useless, as it is filled with events like:
>>>>>
>>>>> [ 6068.996120] evbug: Event. Dev: input4, Type: 1, Code: 31, Value: 0
>>>>> [ 6068.996121] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>>>> [ 6069.124145] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
>>>>> [ 6069.124149] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 1
>>>>> [ 6069.124150] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>>>> [ 6069.196003] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
>>>>> [ 6069.196007] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 0
>>>>> [ 6069.196009] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>>>> [ 6069.788129] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458792
>>>>> [ 6069.788133] evbug: Event. Dev: input4, Type: 1, Code: 28, Value: 1
>>>>> [ 6069.788135] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>>>
>>>> This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev"
>>>> kernel memory leaks, potentially exposing race conditions or other more
>>>> serious bug.
>>>
>>> How is a memory leak a race condition?
>>>
>>>> The bug is now also confirmed and now manifested also in the Ubuntu 22.04
>>>> LTS jammy 6.1-rc4 build.
>>>>
>>>> Here is the kmemleak output:
>>>>
>>>> unreferenced object 0xffff9242b13b3980 (size 64):
>>>>     comm "kworker/5:3", pid 43106, jiffies 4305052439 (age 71828.792s)
>>>>     hex dump (first 32 bytes):
>>>>       80 8b a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ....B...........
>>>>       20 86 a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ...B...........
>>>>     backtrace:
>>>>       [<00000000c5dea4db>] __kmem_cache_alloc_node+0x380/0x4e0
>>>>       [<000000002b17af47>] kmalloc_node_trace+0x27/0xa0
>>>>       [<000000004c09eee5>] xhci_alloc_command+0x6e/0x180
>>>
>>> This is a totally different backtrace from above, how are they related?
>>>
>>> This looks like a potential xhci issue.  Can you use 'git bisect' to
>>> track down the offending change that caused this?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Hello, Greg, Thorsten!
>>
>> After multiple attempts, my box's UEFI refuses to run pre-4.17 kernels.
>> The bisect shows the problem appeared before 4.17, so unless I find what is
>> causing black screen when booting pre-4.17 kernels, it's a no-go ... :(
> 
> Ok, so I guess this has always been an issue, and is not a regression,
> which is good.  Can you work with the memstick developers to find a
> solution?

Hi, Greg,

Of course, I will gladly cooperate with the memstick team.
I will CC: everyone with commits to the memstick driver, I hope that's 
not too awkward.

So far, the Code of Conduct says to inform the maintainers about the bug.

BTW, the bug is confirmed as unfixed in 6.1-rc7:

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff93e548ab1e90 (size 16):
   comm "kworker/u12:5", pid 405, jiffies 4294894087 (age 65919.068s)
   hex dump (first 16 bytes):
     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
   backtrace:
     [<00000000942f1553>] __kmem_cache_alloc_node+0x380/0x4e0
     [<00000000555b3e8a>] __kmalloc_node_track_caller+0x55/0x140
     [<000000000b60a98a>] kstrdup+0x36/0x70
     [<00000000f9a4a52a>] kstrdup_const+0x28/0x30
     [<000000005c5ca378>] kvasprintf_const+0x78/0xa0
     [<00000000b8f94e41>] kobject_set_name_vargs+0x23/0xa0
     [<00000000b7a2c8ea>] dev_set_name+0x53/0x70
     [<00000000291af717>] memstick_check+0xff/0x384 [memstick]
     [<000000007b776e48>] process_one_work+0x214/0x3f0
     [<000000005791f9b2>] worker_thread+0x34/0x3d0
     [<00000000df696ef8>] kthread+0xed/0x120
     [<0000000016f05dd5>] ret_from_fork+0x1f/0x30
#

Thanks,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
