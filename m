Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0422653CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiLVIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 03:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiLVIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 03:04:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE5B2229D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 00:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671696273; x=1703232273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ck/D9rGQcSeNbPG4CJDv/aTqzZ9AYTxRboxtnRgB2Uk=;
  b=nFHtnNqPDVRZMZuKMv+ZfAdF+szL+mz2bQXzsO2SBa+hoStwA44i9xa0
   L83FZJKeiFc/NVuJn+rwoV2Ws38xw3P7KGNDcPYZ3TN+OeS6ott/6h46e
   cQAp2+zKZOV07WtCBgT817ZvnUxsiN4TRdXobmT9yEchrXGb+HjgFtSn9
   01TCZ2i9RchA7qn9yQZWdBUzQ1HKSQz2V6/EEbOlWa2S3xsBdVuS1+xE8
   Kc0NjO2AvIqUX3VAlPSP6N08wYYicXF4SFeWIr7Y+tAY+iZzh/ntAOc4H
   nJqRtMCVKJVD0Kpl6UEOsGboM7Z3zNXoFrmzqQK3lcaKgvLZUUgiLyXUx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="303502487"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="303502487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 00:04:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="645121170"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="645121170"
Received: from cprice2-mobl.ger.corp.intel.com (HELO [10.213.220.27]) ([10.213.220.27])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 00:04:30 -0800
Message-ID: <96661293-32d7-0bb4-fb0e-28086eaaecc3@linux.intel.com>
Date:   Thu, 22 Dec 2022 08:04:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: LOOKS GOOD: Possible regression in drm/i915 driver: memleak
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
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
 <8e080674-36ab-9260-046e-f4e3c931a3b9@alu.unizg.hr>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <8e080674-36ab-9260-046e-f4e3c931a3b9@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/12/2022 00:12, Mirsad Goran Todorovac wrote:
> On 20. 12. 2022. 20:34, Mirsad Todorovac wrote:
>> On 12/20/22 16:52, Tvrtko Ursulin wrote:
>>
>>> On 20/12/2022 15:22, srinivas pandruvada wrote:
>>>> +Added DRM mailing list and maintainers
>>>>
>>>> On Tue, 2022-12-20 at 15:33 +0100, Mirsad Todorovac wrote:
>>>>> Hi all,
>>>>>
>>>>> I have been unsuccessful to find any particular Intel i915 maintainer
>>>>> emails, so my best bet is to post here, as you will must assuredly
>>>>> already know them.
>>>
>>> For future reference you can use 
>>> ${kernel_dir}/scripts/get_maintainer.pl -f ...
>>>
>>>>> The problem is a kernel memory leak that is repeatedly occurring
>>>>> triggered during the execution of Chrome browser under the latest
>>>>> 6.1.0+
>>>>> kernel of this morning and Almalinux 8.6 on a Lenovo desktop box
>>>>> with Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz CPU.
>>>>>
>>>>> The build is with KMEMLEAK, KASAN and MGLRU turned on during the
>>>>> build,
>>>>> on a vanilla mainline kernel from Mr. Torvalds' tree.
>>>>>
>>>>> The leaks look like this one:
>>>>>
>>>>> unreferenced object 0xffff888131754880 (size 64):
>>>>>     comm "chrome", pid 13058, jiffies 4298568878 (age 3708.084s)
>>>>>     hex dump (first 32 bytes):
>>>>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>>> ................
>>>>>       00 00 00 00 00 00 00 00 00 80 1e 3e 83 88 ff ff
>>>>> ...........>....
>>>>>     backtrace:
>>>>>       [<ffffffff9e9b5542>] slab_post_alloc_hook+0xb2/0x340
>>>>>       [<ffffffff9e9bbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>>>>>       [<ffffffff9e8f767a>] kmalloc_trace+0x2a/0xb0
>>>>>       [<ffffffffc08dfde5>] drm_vma_node_allow+0x45/0x150 [drm]
>>>>>       [<ffffffffc0b33315>] __assign_mmap_offset_handle+0x615/0x820
>>>>> [i915]
>>>>>       [<ffffffffc0b34057>] i915_gem_mmap_offset_ioctl+0x77/0x110
>>>>> [i915]
>>>>>       [<ffffffffc08bc5e1>] drm_ioctl_kernel+0x181/0x280 [drm]
>>>>>       [<ffffffffc08bc9cd>] drm_ioctl+0x2dd/0x6a0 [drm]
>>>>>       [<ffffffff9ea54744>] __x64_sys_ioctl+0xc4/0x100
>>>>>       [<ffffffff9fbc0178>] do_syscall_64+0x58/0x80
>>>>>       [<ffffffff9fc000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>
>>>>> The complete list of leaks in attachment, but they seem similar or
>>>>> the same.
>>>>>
>>>>> Please find attached lshw and kernel build config file.
>>>>>
>>>>> I will probably check the same parms on my laptop at home, which is
>>>>> also
>>>>> Lenovo, but a different hw config and Ubuntu 22.10.
>>>
>>> Could you try the below patch?
>>>
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c 
>>> b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>>> index c3ea243d414d..0b07534c203a 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
>>> @@ -679,9 +679,10 @@ mmap_offset_attach(struct drm_i915_gem_object *obj,
>>>   insert:
>>>          mmo = insert_mmo(obj, mmo);
>>>          GEM_BUG_ON(lookup_mmo(obj, mmap_type) != mmo);
>>> -out:
>>> +
>>>          if (file)
>>>                  drm_vma_node_allow(&mmo->vma_node, file);
>>> +out:
>>>          return mmo;
>>>
>>>   err:
>>>
>>> Maybe it is not the best fix but curious to know if it will make the 
>>> leak go away.
>>
>> Hi,
>>
>> After 27 minutes uptime with the patched kernel it looks promising.
>> It is much longer than it took for the buggy kernel to leak slabs.
>>
>> Here is the output:
>>
>> [root@pc-mtodorov marvin]# echo scan > /sys/kernel/debug/kmemleak
>> [root@pc-mtodorov marvin]# cat !$
>> cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff888105028d80 (size 16):
>>    comm "kworker/u12:5", pid 359, jiffies 4294902898 (age 1620.144s)
>>    hex dump (first 16 bytes):
>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>>    backtrace:
>>      [<ffffffffb6bb5542>] slab_post_alloc_hook+0xb2/0x340
>>      [<ffffffffb6bbbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>>      [<ffffffffb6af8175>] __kmalloc_node_track_caller+0x55/0x160
>>      [<ffffffffb6ae34a6>] kstrdup+0x36/0x60
>>      [<ffffffffb6ae3508>] kstrdup_const+0x28/0x30
>>      [<ffffffffb70d0757>] kvasprintf_const+0x97/0xd0
>>      [<ffffffffb7c9cdf4>] kobject_set_name_vargs+0x34/0xc0
>>      [<ffffffffb750289b>] dev_set_name+0x9b/0xd0
>>      [<ffffffffc12d9201>] memstick_check+0x181/0x639 [memstick]
>>      [<ffffffffb676e1d6>] process_one_work+0x4e6/0x7e0
>>      [<ffffffffb676e556>] worker_thread+0x76/0x770
>>      [<ffffffffb677b468>] kthread+0x168/0x1a0
>>      [<ffffffffb6604c99>] ret_from_fork+0x29/0x50
>> [root@pc-mtodorov marvin]# w
>>   20:27:35 up 27 min,  2 users,  load average: 0.83, 1.15, 1.19
>> USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
>> marvin   tty2     tty2             20:01   27:10  10:12   2.09s 
>> /opt/google/chrome/chrome --type=utility --utility-sub-type=audio.m
>> marvin   pts/1    -                20:01    0.00s  2:00   0.38s sudo bash
>> [root@pc-mtodorov marvin]# uname -rms
>> Linux 6.1.0-b6bb9676f216-mglru-kmemlk-kasan+ x86_64
>> [root@pc-mtodorov marvin]#
> 
> As I hear no reply from Tvrtko, and there is already 1d5h uptime with no 
> leaks (but
> the kworker with memstick_check nag I couldn't bisect on the only box 
> that reproduced it,
> because something in hw was not supported in pre 4.16 kernels on the 
> Lenovo V530S-07ICB.
> Or I am doing something wrong.)
> 
> However, now I can find the memstick maintainers thanks to Tvrtko's hint.
> 
> If you no longer require my service, I would close this on my behalf.
> 
> I hope I did not cause too much trouble. The knowledgeable knew that 
> this was not a security
> risk, but only a bug. (30 leaks of 64 bytes each were hardly to exhaust 
> memory in any realistic
> time.)
> 
> However, having some experience with software development, I always 
> preferred bugs reported
> and fixed rather than concealed and lying in wait (or worse, found first 
> by a motivated
> adversary.) Forgive me this rant, I do not live from writing kernel 
> drivers, this is just a
> pet project as of time being ...

It is not forgotten - I was trying to reach out to the original author 
of the fixlet which worked for you. If that fails I will take it up on 
myself, but need to set aside some time to get into the exact problem 
space before I can vouch for the fix and send it on my own.

In the meantime definitely thanks a lot for testing this quickly and 
reporting back!

What will happen next is, that when either the original author or myself 
are ready to send out the fix as a proper patch, you will be copied on 
it via the "Reported-by" and possibly "Tested-by" tags. Latter is if the 
patch remains identical. If it changes we might kindly ask you to 
re-test if possible.

Regards,

Tvrtko
