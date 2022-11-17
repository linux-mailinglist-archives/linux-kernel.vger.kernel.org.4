Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CA662DFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiKQPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:34:53 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75415FF4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:34:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 695B8604F5;
        Thu, 17 Nov 2022 16:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668699289; bh=OzZ3e0q+8Q3gk97BCSnxrfpEF9cLcEA1xakdNiYCsC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yj04Of7GnsTzvBTa/XCwKmeSbF5FC2s9O9/hGlgQCdh+MYBN58NaFp+juzhFO/FGZ
         2/7MJATDTcBCKtMieoO1jWrFohRQVusCtRE7CQDEnv//DsY7JOolkIixUfm0ybaATW
         qEI6+hNh/CEC550if53v7MPjh1FQrsQo7hV/LPD8n6G+xFt9Dga1P453hoVRYFQ3rm
         ZWZgmageQmWnbTEbr/nelScgMEs97SlM4NPItHHYAA9wNiwSere+cytXoVOAxwEt9U
         ++bgxirROmIv0ew5tZVmHtqWEE3nSUOU28U4ZDH6kr/k1v3eHvP0qtz+tDI2rx7vu3
         g29z/9K7YTtjA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E85dYaBrOm6a; Thu, 17 Nov 2022 16:34:47 +0100 (CET)
Received: from [10.0.1.10] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 6FE3E604F4;
        Thu, 17 Nov 2022 16:34:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668699287; bh=OzZ3e0q+8Q3gk97BCSnxrfpEF9cLcEA1xakdNiYCsC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N32gJitdPzw0I1VXFjkYRyKoWJXRW4geC9AsrMXZchyzTgt4slX52GPkrbfghvMtw
         MgSJz0bonWoRKIIO782NgBMuHpwMeOUVdEi2MAl7FNJR/MinSHBjvnXI9c/njGoCpj
         FSNzULdLWnVyyxOm7PKE+Op7E1o/ANwHpnmf/Omkdzn+YbHgAAcHot0tzP4QD0ByJ3
         voKoR286mkWsNpB9HqgDgl1DOnLAV120p/MhlXJx2R68G9oPodY6jdhWcekfjhyB0x
         oqGcaYQ+EtL4MGAfZpU6yX29TVPdndkqsTAtEwBLGxrzY7/g5JwT/3JL4pxksVeeCU
         sURNhjI6rNLaQ==
Message-ID: <2234838f-1213-09be-d887-1ad398d29c01@alu.unizg.hr>
Date:   Thu, 17 Nov 2022 16:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        systemd-devel@lists.freedesktop.org
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
 <Y2zCYwNNvQWppLWZ@kroah.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y2zCYwNNvQWppLWZ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.11.2022. 10:20, Greg KH wrote:
> On Thu, Nov 10, 2022 at 05:57:57AM +0100, Mirsad Goran Todorovac wrote:
>> On 04. 11. 2022. 11:40, Mirsad Goran Todorovac wrote:
>>
>>> Dear Sirs,
>>>
>>> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled
>>> CONFIG_DEBUG_KMEMLEAK=y
>>> and the result showed an unreferenced object in kworker process:
>>>
>>> # cat /sys/kernel/debug/kmemleak
>>> unreferenced object 0xffffa01dabff6100 (size 16):
>>>    comm "kworker/u12:4", pid 400, jiffies 4294894771 (age 5284.956s)
>>>    hex dump (first 16 bytes):
>>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>>>    backtrace:
>>>      [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>>>      [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>>>      [<0000000005472512>] kstrdup+0x36/0x70
>>>      [<000000002f797ac4>] kstrdup_const+0x28/0x30
>>>      [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>>>      [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>>>      [<000000004158a6c0>] dev_set_name+0x53/0x70
>>>      [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>>>      [<00000000122bb894>] process_one_work+0x214/0x3f0
>>>      [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>>>      [<0000000002409855>] kthread+0xed/0x120
>>>      [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
>>> unreferenced object 0xffffa01dabff6ec0 (size 16):
>>>    comm "kworker/u12:4", pid 400, jiffies 4294894774 (age 5284.944s)
>>>    hex dump (first 16 bytes):
>>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>>>    backtrace:
>>>      [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>>>      [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>>>      [<0000000005472512>] kstrdup+0x36/0x70
>>>      [<000000002f797ac4>] kstrdup_const+0x28/0x30
>>>      [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>>>      [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>>>      [<000000004158a6c0>] dev_set_name+0x53/0x70
>>>      [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>>>      [<00000000122bb894>] process_one_work+0x214/0x3f0
>>>      [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>>>      [<0000000002409855>] kthread+0xed/0x120
>>>      [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
>>> #
>>>
>>> Please fing the build config and lshw output attached.
>>>
>>> dmesg is useless, as it is filled with events like:
>>>
>>> [ 6068.996120] evbug: Event. Dev: input4, Type: 1, Code: 31, Value: 0
>>> [ 6068.996121] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>> [ 6069.124145] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
>>> [ 6069.124149] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 1
>>> [ 6069.124150] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>> [ 6069.196003] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
>>> [ 6069.196007] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 0
>>> [ 6069.196009] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>> [ 6069.788129] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458792
>>> [ 6069.788133] evbug: Event. Dev: input4, Type: 1, Code: 28, Value: 1
>>> [ 6069.788135] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
>>
>> This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev"
>> kernel memory leaks, potentially exposing race conditions or other more
>> serious bug.
> 
> How is a memory leak a race condition?
Probably I connected it with spurious memleak in thermald that occurs 
only under the torture tests.

>> The bug is now also confirmed and now manifested also in the Ubuntu 22.04
>> LTS jammy 6.1-rc4 build.
>>
>> Here is the kmemleak output:
>>
>> unreferenced object 0xffff9242b13b3980 (size 64):
>>    comm "kworker/5:3", pid 43106, jiffies 4305052439 (age 71828.792s)
>>    hex dump (first 32 bytes):
>>      80 8b a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ....B...........
>>      20 86 a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ...B...........
>>    backtrace:
>>      [<00000000c5dea4db>] __kmem_cache_alloc_node+0x380/0x4e0
>>      [<000000002b17af47>] kmalloc_node_trace+0x27/0xa0
>>      [<000000004c09eee5>] xhci_alloc_command+0x6e/0x180
> 
> This is a totally different backtrace from above, how are they related?
> 
> This looks like a potential xhci issue.  Can you use 'git bisect' to
> track down the offending change that caused this?
> 
> thanks,
> 
> greg k-h

Hi, Greg, I saw this email only now. I will try to bisect the bug.
I was trying to bisect the first instance that occurs only on AlmaLinux 
and it is introduced before 4.17. Here is the progress of the bisect on 
AlmaLinux 8.6 (a.k.a. Centos 8):

mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
git bisect start
# bad: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
git bisect bad f0c4d9fc9cc9462659728d168387191387e903cc
# bad: [fbd56ddcecab5a3623a89c8e941fdbcc55b41045] Linux 6.0.1
git bisect bad fbd56ddcecab5a3623a89c8e941fdbcc55b41045
# bad: [7e18e42e4b280c85b76967a9106a13ca61c16179] Linux 6.0-rc4
git bisect bad 7e18e42e4b280c85b76967a9106a13ca61c16179
# bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
# bad: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
git bisect bad 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
# bad: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
git bisect bad 94710cac0ef4ee177a63b5227664b38c95bbf703
# bad: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
git bisect bad 29dcea88779c856c7dc92040a0c01233263101d4
mtodorov@domac:~/linux/kernel/linux_stable$

I failed to notice the different nature of the second memory leak.
Of course, if it is reproducible always in the same way, I'd agree that 
it doesn't look like a race condition, but from one occurrence it is 
hard to tell (I generalised from thermald/acpi bug bisect).

Please give me some grace period for I am only 2 1/2 months in the 
kernel bisecting ...

Cheers,
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
