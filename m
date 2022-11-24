Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5C637FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKXTcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKXTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:32:08 -0500
Received: from p3plwbeout21-03.prod.phx3.secureserver.net (p3plsmtp21-03-2.prod.phx3.secureserver.net [68.178.252.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB16F820
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:32:06 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id yHx7o2xcyyM1MyHx7oqbyz; Thu, 24 Nov 2022 12:32:06 -0700
X-CMAE-Analysis: v=2.4 cv=cZUXElPM c=1 sm=1 tr=0 ts=637fc6b6
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=9xFQ1JgjjksA:10 a=danhDmx_AAAA:8
 a=BYxImy5eEYJ47mzel6EA:9 a=QEXdDO2ut3YA:10 a=P4VdviVPEcjfz_PVVggX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  yHx7o2xcyyM1M
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oyHx6-00075e-G8; Thu, 24 Nov 2022 19:32:04 +0000
Message-ID: <d8513908-3348-2c81-9f82-a6314a34bb74@squashfs.org.uk>
Date:   Thu, 24 Nov 2022 19:32:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        paulmck@kernel.org
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
 <20221122020734.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <e8f5b9b3-383a-c267-9ee3-f1e0da5466fc@alu.unizg.hr>
 <20221123144415.GX4001@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842135518BD1D119E26EDCDAB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221123190932.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <d2c392d9-4415-da33-ace7-d73cf64a023c@alu.unizg.hr>
 <20221124171933.GU4001@paulmck-ThinkPad-P17-Gen-1>
 <9486bc0a-345e-a93c-581f-50e2a06a3314@alu.unizg.hr>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <9486bc0a-345e-a93c-581f-50e2a06a3314@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfLNyZJDt5UbxBVoEljgRw+eMP0l2dKkJBKTxmHUTqS+YffRvmYJQuPpEpsr5J0/zbH2GGufCs8G96alEpeSM0Lk6PLk2yH1AhhkiSTBkudi/U4aJ3I5N
 9E43Lo8qsVAl7ZrIhgHdo3ntWkQxJFdxDaiMkLo2+IG9qs+q/00obn/X5yiQSLEJgvFZpzPygRzOdCSvvAk4RiAWq22SWT7JFmM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 18:04, Mirsad Goran Todorovac wrote:
> On 24. 11. 2022. 18:19, Paul E. McKenney wrote:
>> On Thu, Nov 24, 2022 at 06:06:13PM +0100, Mirsad Goran Todorovac wrote:
>>> On 23. 11. 2022. 20:09, Paul E. McKenney wrote:
>>>
>>>>>> If you build with (say) CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200, does
>>>>>> this still happen?
>>>>>
>>>>> BTW, you don't need to rebuild the kernel to change those 
>>>>> parameters; they're
>>>>> module parameters, so can be modified on the kernel command line 
>>>>> (if needed
>>>>> during boot) and sysfs (if only needed after boot).
>>>>>
>>>>> For sysfs the syntax is:
>>>>> #!/bin/bash
>>>>> # set rcu timeouts to specified values
>>>>> echo 60 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
>>>>> echo 21000 > /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
>>>>> echo 600000 > /sys/module/rcupdate/parameters/rcu_task_stall_timeout
>>>>> grep -Hs . /sys/module/rcupdate/parameters/rcu_*_timeout
>>>>
>>>> Excellent point, thank you!
>>>>
>>>> I hope that this makes Mirsad's life easier, perhaps featuring less 
>>>> time
>>>> waiting for kernel builds and reboots.  ;-)
>>>
>>> Unfortunately, the first stall and NMI occurs before any system 
>>> script or setting a /sys/module/rcupdate/parameters/*
>>> could be executed, as second 14 of the boot process:
>>>
>>> [   14.320045] rcu: INFO: rcu_preempt detected expedited stalls on 
>>> CPUs/tasks: { 7-.... } 6 jiffies s: 105 root: 0x80/.
>>> [   14.320064] rcu: blocking rcu_node structures (internal RCU debug):
> 
> ...
> 
>>> Probably something sensible should be set in the case of KASAN build. 
>>> This example of stall
>>> apparently has nothing to do with squashfs_readahead().
>>
>> Can't have everything, I guess!
>>
>> How about building your kernel with CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200?
>> Again, mainline defaults to 21000.
> 
> Did just that, and so far there is no modprobe stall in second 14 of 
> boot at least. Looks good.
> Probably it is too early to say anything in general before more uptime 
> and stress load.
> 
> BTW, the 20 for CONFIG_RCU_EXP_STALL_TIMEOUT wasn't my invention, but it 
> comes from generic
> Ubuntu stock kernel (but without KASAN or KMEMLEAK config options):
> 
> # grep STALL /boot/config-5.19.5-051905-generic
> CONFIG_RCU_STALL_COMMON=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20 > #

That has been raised as a bug, and a fix has been committed.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1991951


> 
> Thanks,
> Mirsad
> 
> -- 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu

