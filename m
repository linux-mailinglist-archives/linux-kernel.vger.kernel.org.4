Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF2637ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKXSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKXSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:04:20 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5470832AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:04:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2A4DD604F6;
        Thu, 24 Nov 2022 19:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669313057; bh=2mrmrx/ol/n+W0wsa62wEuHlQwzw5KLEYMW2CgS4dHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=USWos8CIZEoBfBs9c0SifpeAAIXx1ZswPPHNnCnzbtsHqHYv08dhGJEttbKq4ndDi
         lu5jKVZQTgioFM6hS2RS2klXWXI2k/BiZJn/noRqf4H3zwkdBeNcvERN8DT6/w1p+L
         B6Dv4XonqC8agKNInm2GwrkVjyDDE/n9pf5TfUTeyjkibXP75lv5Lccuv4+uTokD2H
         RLHDrv3Z8n3KHIvmopwRCcKjPeD8GGmxioVdGc4ctLCWjWv1qHIeCVjddV2ruZMfRM
         1354kgZqERRJrxNqtM846d8z8IQWzRE2MGp2Hi1Xa7k8hsg19/0AKquxMZdgRrsNQb
         CYwdZ+UXxKZNg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FAJBotsxYo8B; Thu, 24 Nov 2022 19:04:14 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.243])
        by domac.alu.hr (Postfix) with ESMTPSA id A5D0E604F5;
        Thu, 24 Nov 2022 19:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669313054; bh=2mrmrx/ol/n+W0wsa62wEuHlQwzw5KLEYMW2CgS4dHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hl43D+hzyZNNRv9Zg03vfNRKGEhuhhW9dm722r1j1nwgwI+QFlkYjGgydmHPMxxI1
         0BlbmvSyL2fvjFL+vXiWr357rOsYrfnsVhtrjgdoqcxvx0JdOkt5B7G2GVrCi+JBRZ
         3HTvwXMDVj29lCw+0iHVSHBse+Q0qAlU6iGjKs7UbA7vP0CF+z5EPK8LX4rZkfhZwP
         V1yF+rz2fID5tbEdX5y8ku6Ugd5e/jJ4BQXj347S5bWXwArnz52XpcESBnqOnP+KaR
         tVApnUG//iSOG3jmqDHoznABsrtaXgOAtfJJYp9Ws/lOsyyrbH0f8y9yIs/qf3+6i3
         IzEbxe8F1nknw==
Message-ID: <9486bc0a-345e-a93c-581f-50e2a06a3314@alu.unizg.hr>
Date:   Thu, 24 Nov 2022 19:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
To:     paulmck@kernel.org
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
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
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20221124171933.GU4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 11. 2022. 18:19, Paul E. McKenney wrote:
> On Thu, Nov 24, 2022 at 06:06:13PM +0100, Mirsad Goran Todorovac wrote:
>> On 23. 11. 2022. 20:09, Paul E. McKenney wrote:
>>
>>>>> If you build with (say) CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200, does
>>>>> this still happen?
>>>>
>>>> BTW, you don't need to rebuild the kernel to change those parameters; they're
>>>> module parameters, so can be modified on the kernel command line (if needed
>>>> during boot) and sysfs (if only needed after boot).
>>>>
>>>> For sysfs the syntax is:
>>>> #!/bin/bash
>>>> # set rcu timeouts to specified values
>>>> echo 60 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
>>>> echo 21000 > /sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout
>>>> echo 600000 > /sys/module/rcupdate/parameters/rcu_task_stall_timeout
>>>> grep -Hs . /sys/module/rcupdate/parameters/rcu_*_timeout
>>>
>>> Excellent point, thank you!
>>>
>>> I hope that this makes Mirsad's life easier, perhaps featuring less time
>>> waiting for kernel builds and reboots.  ;-)
>>
>> Unfortunately, the first stall and NMI occurs before any system script or setting a /sys/module/rcupdate/parameters/*
>> could be executed, as second 14 of the boot process:
>>
>> [   14.320045] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 7-.... } 6 jiffies s: 105 root: 0x80/.
>> [   14.320064] rcu: blocking rcu_node structures (internal RCU debug):

...

>> Probably something sensible should be set in the case of KASAN build. This example of stall
>> apparently has nothing to do with squashfs_readahead().
> 
> Can't have everything, I guess!
> 
> How about building your kernel with CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=200?
> Again, mainline defaults to 21000.

Did just that, and so far there is no modprobe stall in second 14 of boot at least. Looks good.
Probably it is too early to say anything in general before more uptime and stress load.

BTW, the 20 for CONFIG_RCU_EXP_STALL_TIMEOUT wasn't my invention, but it comes from generic
Ubuntu stock kernel (but without KASAN or KMEMLEAK config options):

# grep STALL /boot/config-5.19.5-051905-generic
CONFIG_RCU_STALL_COMMON=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
#

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

