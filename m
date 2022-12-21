Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02FE652D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiLUHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUHPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:15:22 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00252205CF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:15:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 87647604F1;
        Wed, 21 Dec 2022 08:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1671606918; bh=ZtlAaE33ZZV4SRhYl62x38s2P5dFAXk9MtedaQ1GwJQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=hWwX6B24XRPEiDD2g8Ml63SL7ENYpyECRW9YB50LlNx+drKGlbOuE7s5md1Th28cv
         +ccKC11cSq5YI7bDaP+9Z1qNvtZ8a57f57OHLvX7H5AUq/VPpOUD+ZgF5B1vCC9Q2E
         2zZRJCLduZ8KGaovktZl9J5qE4mL3cGIG5Ob5f03vCmiowQpJPqtNRh33Ax10qYUbC
         CgbwQx0bUXtcqT18MKxZnOUaOtY8jwfuzySMAw0oe+siQF6OqB0CSOBTqkcQ5IgGrJ
         j6S8o8oR3BLKFJOjWvIRO2b6iYCld6227Cu6JloummITDyb/3Q9HTH1lJCgbv78ldF
         MPyWM8ubaHVnA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R7N6VywRqYZj; Wed, 21 Dec 2022 08:15:16 +0100 (CET)
Received: from [10.0.1.53] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 6EE20604EE;
        Wed, 21 Dec 2022 08:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1671606915; bh=ZtlAaE33ZZV4SRhYl62x38s2P5dFAXk9MtedaQ1GwJQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ceVnQHDOpjRUL+PgA+ZT+1TNTr0uObNSZc8akBXH/X8eK6a89Sw81T5Dkwdy1twZJ
         b6ycWGWDkW4aezlJBNgWTYhpEyxbJb9J9sM7i1P62T3QGSr3YzdBPRYEnk0Arjhra9
         aweo8EoP82Fzi21UugOgZB0DGj5l85++xEts2XtI9QGYfqHYMFZ4TRW1xU22b95N/Y
         imradjcpUjYplRdJOHzclUYN0KUWpxmuJf9J1HmnwoxC5NaK7LeHdJ8Tqx6uZACwsC
         iCwhpkQor9c7bd4dBvROSCrfxgMMEMvooBQvKiwmt+mhTMw1x7B1nGNHowDVVkyChf
         DltNLxhfxnRoQ==
Message-ID: <24360ef5-a088-58be-d03e-e72ed63d0e13@alu.unizg.hr>
Date:   Wed, 21 Dec 2022 08:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Possible regression in drm/i915 driver: memleak
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx@lists.freedesktop.org
References: <f849cc70-b21f-6476-ba26-08989d1243c2@alu.unizg.hr>
 <05424a5351a847786377a548dba0759917d8046c.camel@linux.intel.com>
 <15ef1bb9-7312-5d98-8bf0-0af1a37cfd2a@linux.intel.com>
 <619bdecc-cf87-60a4-f50d-836f4c073ea7@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <619bdecc-cf87-60a4-f50d-836f4c073ea7@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2022. 20:34, Mirsad Todorovac wrote:
> On 12/20/22 16:52, Tvrtko Ursulin wrote:
>
>> On 20/12/2022 15:22, srinivas pandruvada wrote:
>>> +Added DRM mailing list and maintainers
>>>
>>> On Tue, 2022-12-20 at 15:33 +0100, Mirsad Todorovac wrote:
>>>> Hi all,
>>>>
>>>> I have been unsuccessful to find any particular Intel i915 maintainer
>>>> emails, so my best bet is to post here, as you will must assuredly
>>>> already know them.
>>
>> For future reference you can use 
>> ${kernel_dir}/scripts/get_maintainer.pl -f ...
>>
>>>> The problem is a kernel memory leak that is repeatedly occurring
>>>> triggered during the execution of Chrome browser under the latest
>>>> 6.1.0+
>>>> kernel of this morning and Almalinux 8.6 on a Lenovo desktop box
>>>> with Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz CPU.
>>>>
>>>> The build is with KMEMLEAK, KASAN and MGLRU turned on during the
>>>> build,
>>>> on a vanilla mainline kernel from Mr. Torvalds' tree.
>>>>
>>>> The leaks look like this one:
>>>>
>>>> unreferenced object 0xffff888131754880 (size 64):
>>>>     comm "chrome", pid 13058, jiffies 4298568878 (age 3708.084s)
>>>>     hex dump (first 32 bytes):
>>>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>> ................
>>>>       00 00 00 00 00 00 00 00 00 80 1e 3e 83 88 ff ff
>>>> ...........>....
>>>>     backtrace:
>>>>       [<ffffffff9e9b5542>] slab_post_alloc_hook+0xb2/0x340
>>>>       [<ffffffff9e9bbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>>>>       [<ffffffff9e8f767a>] kmalloc_trace+0x2a/0xb0
>>>>       [<ffffffffc08dfde5>] drm_vma_node_allow+0x45/0x150 [drm]
>>>>       [<ffffffffc0b33315>] __assign_mmap_offset_handle+0x615/0x820
>>>> [i915]
>>>>       [<ffffffffc0b34057>] i915_gem_mmap_offset_ioctl+0x77/0x110
>>>> [i915]
>>>>       [<ffffffffc08bc5e1>] drm_ioctl_kernel+0x181/0x280 [drm]
>>>>       [<ffffffffc08bc9cd>] drm_ioctl+0x2dd/0x6a0 [drm]
>>>>       [<ffffffff9ea54744>] __x64_sys_ioctl+0xc4/0x100
>>>>       [<ffffffff9fbc0178>] do_syscall_64+0x58/0x80
>>>>       [<ffffffff9fc000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>
>>>> The complete list of leaks in attachment, but they seem similar or
>>>> the same.
>>>>
>>>> Please find attached lshw and kernel build config file.
>>>>
>>>> I will probably check the same parms on my laptop at home, which is
>>>> also
>>>> Lenovo, but a different hw config and Ubuntu 22.10.
>>
>> Could you try the below patch?
>>
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c 
>> b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>> index c3ea243d414d..0b07534c203a 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>> @@ -679,9 +679,10 @@ mmap_offset_attach(struct drm_i915_gem_object *obj,
>>   insert:
>>          mmo = insert_mmo(obj, mmo);
>>          GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
>> -out:
>> +
>>          if (file)
>>                  drm_vma_node_allow(&mmo->vma_node, file);
>> +out:
>>          return mmo;
>>
>>   err:
>>
>> Maybe it is not the best fix but curious to know if it will make the 
>> leak go away.
>
> Hi,
>
> After 27 minutes uptime with the patched kernel it looks promising.
> It is much longer than it took for the buggy kernel to leak slabs.
>
> Here is the output:
>
> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
> [root@pc-mtodorov marvin]# cat !$
> cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888105028d80 (size 16):
>   comm "kworker/u12:5", pid 359, jiffies 4294902898 (age 1620.144s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>   backtrace:
>     [<ffffffffb6bb5542>] slab_post_alloc_hook+0xb2/0x340
>     [<ffffffffb6bbbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>     [<ffffffffb6af8175>] __kmalloc_node_track_caller+0x55/0x160
>     [<ffffffffb6ae34a6>] kstrdup+0x36/0x60
>     [<ffffffffb6ae3508>] kstrdup_const+0x28/0x30
>     [<ffffffffb70d0757>] kvasprintf_const+0x97/0xd0
>     [<ffffffffb7c9cdf4>] kobject_set_name_vargs+0x34/0xc0
>     [<ffffffffb750289b>] dev_set_name+0x9b/0xd0
>     [<ffffffffc12d9201>] memstick_check+0x181/0x639 [memstick]
>     [<ffffffffb676e1d6>] process_one_work+0x4e6/0x7e0
>     [<ffffffffb676e556>] worker_thread+0x76/0x770
>     [<ffffffffb677b468>] kthread+0x168/0x1a0
>     [<ffffffffb6604c99>] ret_from_fork+0x29/0x50
> [root@pc-mtodorov marvin]# w
>  20:27:35 up 27 min,  2 users,  load average: 0.83, 1.15, 1.19
> USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
> marvin   tty2     tty2             20:01   27:10  10:12   2.09s 
> /opt/google/chrome/chrome --type=utility --utility-sub-type=audio.m
> marvin   pts/1    -                20:01    0.00s  2:00   0.38s sudo bash
> [root@pc-mtodorov marvin]# uname -rms
> Linux 6.1.0-b6bb9676f216-mglru-kmemlk-kasan+ x86_64
> [root@pc-mtodorov marvin]#
>
> 2. On the Ubuntu 22.10 with Debian build I did not reproduce the error 
> thus far.
>
> This looks to me like fixed, but if it doesn't leak anything until 
> Thursday morning when I will see this desktop box next time, then 
> we'll know with more certainty. 

After an inspection in the morning local time and 12:10h uptime, it 
appears that the problem is fixed. No chrome-triggered 
i915_gem_mmap_offset_ioctl leaks.

By this uptime, there were about 30 instances of leaks in the unpatched 
kernel.

Congratulations!

Kind regards,
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

