Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C2743720
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjF3I2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjF3I2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:28:12 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A09130
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:28:10 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc244d386so10538685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113689; x=1690705689;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRYyHPJ0l3JptHpg3mFpGfjchjllb0zu8LBlb7XT5hw=;
        b=YYSZBPBPXocoJkB+iGgFMsY7QZQCsmg0rw7EIm1Nhl9uPPmli4mcNlrkS56IT9M8yN
         s/URALz1dz6U4ZRuKK2cb/IQHIZlAed/1SG3FklezcCMoQ07WCYGZ2JpUb/oIU0dirk1
         TCEhO9X6ZC/SfrohLHn4z8MCkfT7dZdutqbAbD31ZHV1vw0M/SkKyeYNq4iF/4+YGUUA
         sTQdgKCpCoUtIzdNLNE5kVtBTxGHEeFwLisGfVyDQNf2J5GdzJo3OQmPOeyXLt9LHAz7
         QhjFbSUnlipjpFBNAi2IRJ8uk+hV/tLj4OcFAoTv3HzSjo9GCmp+yjeHv/x5IFhZ/Atz
         kvXA==
X-Gm-Message-State: AC+VfDwbEgMvNIa5AY+hARMRVJ4nYRcDoqEK7kE/HyLIe7XO1x7isxSb
        nK+oZRo2kF55/aeFq+QWBM0=
X-Google-Smtp-Source: ACHHUZ4ThngeqilmApKJMZhIhCcwEYSoxdwUR+ukZaaoc8YnAj64SIh0BEAZ3duaqDYdxup994pnqw==
X-Received: by 2002:a7b:cb88:0:b0:3fb:b890:128e with SMTP id m8-20020a7bcb88000000b003fbb890128emr1255564wmi.33.1688113688346;
        Fri, 30 Jun 2023 01:28:08 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c379700b003fae92e7a8dsm12201517wmr.27.2023.06.30.01.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 01:28:07 -0700 (PDT)
Message-ID: <f7ad7a42-13c8-a486-d0b7-01d5acf01e13@kernel.org>
Date:   Fri, 30 Jun 2023 10:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
 <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
 <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org>
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
In-Reply-To: <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 06. 23, 8:35, Jiri Slaby wrote:
> On 29. 06. 23, 17:30, Suren Baghdasaryan wrote:
>> On Thu, Jun 29, 2023 at 7:40 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>>
>>> Hi,
>>>
>>> On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
>>>> Attempt VMA lock-based page fault handling first, and fall back to the
>>>> existing mmap_lock-based handling if that fails.
>>>>
>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>> ---
>>>>    arch/x86/Kconfig    |  1 +
>>>>    arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index a825bf031f49..df21fba77db1 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -27,6 +27,7 @@ config X86_64
>>>>        # Options that are inherently 64-bit kernel only:
>>>>        select ARCH_HAS_GIGANTIC_PAGE
>>>>        select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>>> +     select ARCH_SUPPORTS_PER_VMA_LOCK
>>>>        select ARCH_USE_CMPXCHG_LOCKREF
>>>>        select HAVE_ARCH_SOFT_DIRTY
>>>>        select MODULES_USE_ELF_RELA
>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>> index a498ae1fbe66..e4399983c50c 100644
>>>> --- a/arch/x86/mm/fault.c
>>>> +++ b/arch/x86/mm/fault.c
>>>> @@ -19,6 +19,7 @@
>>>>    #include <linux/uaccess.h>          /* 
>>>> faulthandler_disabled()      */
>>>>    #include <linux/efi.h>                      /* 
>>>> efi_crash_gracefully_on_page_fault()*/
>>>>    #include <linux/mm_types.h>
>>>> +#include <linux/mm.h>                        /* find_and_lock_vma() */
>>>>
>>>>    #include <asm/cpufeature.h>         /* boot_cpu_has, 
>>>> ...            */
>>>>    #include <asm/traps.h>                      /* dotraplinkage, 
>>>> ...           */
>>>> @@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>        }
>>>>    #endif
>>>>
>>>> +#ifdef CONFIG_PER_VMA_LOCK
>>>> +     if (!(flags & FAULT_FLAG_USER))
>>>> +             goto lock_mmap;
>>>> +
>>>> +     vma = lock_vma_under_rcu(mm, address);
>>>> +     if (!vma)
>>>> +             goto lock_mmap;
>>>> +
>>>> +     if (unlikely(access_error(error_code, vma))) {
>>>> +             vma_end_read(vma);
>>>> +             goto lock_mmap;
>>>> +     }
>>>> +     fault = handle_mm_fault(vma, address, flags | 
>>>> FAULT_FLAG_VMA_LOCK, regs);
>>>> +     vma_end_read(vma);
>>>> +
>>>> +     if (!(fault & VM_FAULT_RETRY)) {
>>>> +             count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>>>> +             goto done;
>>>> +     }
>>>> +     count_vm_vma_lock_event(VMA_LOCK_RETRY);
>>>
>>> This is apparently not strong enough as it causes go build failures 
>>> like:
>>>
>>> [  409s] strconv
>>> [  409s] releasep: m=0x579e2000 m->p=0x5781c600 p->m=0x0 p->status=2
>>> [  409s] fatal error: releasep: invalid p state
>>> [  409s]
>>>
>>> [  325s] hash/adler32
>>> [  325s] hash/crc32
>>> [  325s] cmd/internal/codesign
>>> [  336s] fatal error: runtime: out of memory
>>
>> Hi Jiri,
>> Thanks for reporting! I'm not familiar with go builds. Could you
>> please explain the error to me or point me to some documentation to
>> decipher that error?
> 
> Sorry, we are on the same boat -- me neither. It only popped up in our 
> (openSUSE) build system and I only tracked it down by bisection. Let me 
> know if I can try something (like a patch or gathering some debug info).

FWIW, a failed build log:
https://decibel.fi.muni.cz/~xslaby/n/vma/log.txt

and a strace for it:
https://decibel.fi.muni.cz/~xslaby/n/vma/strace.txt

An excerpt from the log:

[   55s] runtime: marked free object in span 0x7fca6824bec8, 
elemsize=192 freeindex=0 (bad use of unsafe.Pointer? try -d=checkptr)
[   55s] 0xc0002f2000 alloc marked
[   55s] 0xc0002f20c0 alloc marked
[   55s] 0xc0002f2180 alloc marked
[   55s] 0xc0002f2240 free  unmarked
[   55s] 0xc0002f2300 alloc marked
[   55s] 0xc0002f23c0 alloc marked
[   55s] 0xc0002f2480 alloc marked
[   55s] 0xc0002f2540 alloc marked
[   55s] 0xc0002f2600 alloc marked
[   55s] 0xc0002f26c0 alloc marked
[   55s] 0xc0002f2780 alloc marked
[   55s] 0xc0002f2840 alloc marked
[   55s] 0xc0002f2900 alloc marked
[   55s] 0xc0002f29c0 free  unmarked
[   55s] 0xc0002f2a80 alloc marked
[   55s] 0xc0002f2b40 alloc marked
[   55s] 0xc0002f2c00 alloc marked
[   55s] 0xc0002f2cc0 alloc marked
[   55s] 0xc0002f2d80 alloc marked
[   55s] 0xc0002f2e40 alloc marked
[   55s] 0xc0002f2f00 alloc marked
[   55s] 0xc0002f2fc0 alloc marked
[   55s] 0xc0002f3080 alloc marked
[   55s] 0xc0002f3140 alloc marked
[   55s] 0xc0002f3200 alloc marked
[   55s] 0xc0002f32c0 alloc marked
[   55s] 0xc0002f3380 free  unmarked
[   55s] 0xc0002f3440 free  marked   zombie


An excerpt from strace:
 > 2348 
clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, 
child_tid=0x7fcaa6a1b990, parent_tid=0x7fcaa6a1b990, exit_signal=0, 
stack=0x7fcaa621b000, stack_size=0x7ffe00, tls=0x7fcaa6a1b6c0} => 
{parent_tid=[2350]}, 88) = 2350

 > 2348 
clone3({flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, 
child_tid=0x7fcaa5882990, parent_tid=0x7fcaa5882990, exit_signal=0, 
stack=0x7fcaa5082000, stack_size=0x7ffe00, tls=0x7fcaa58826c0} => 
{parent_tid=[2351]}, 88) = 2351
 > 2350  <... clone3 resumed> => {parent_tid=[2372]}, 88) = 2372
 > 2351  <... clone3 resumed> => {parent_tid=[2354]}, 88) = 2354
 > 2351  <... clone3 resumed> => {parent_tid=[2357]}, 88) = 2357
 > 2354  <... clone3 resumed> => {parent_tid=[2355]}, 88) = 2355
 > 2355  <... clone3 resumed> => {parent_tid=[2370]}, 88) = 2370
 > 2370  mmap(NULL, 262144, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
 > 2370  <... mmap resumed>)               = 0x7fca68249000
 > 2372  <... clone3 resumed> => {parent_tid=[2384]}, 88) = 2384
 > 2384  <... clone3 resumed> => {parent_tid=[2388]}, 88) = 2388
 > 2388  <... clone3 resumed> => {parent_tid=[2392]}, 88) = 2392
 > 2392  <... clone3 resumed> => {parent_tid=[2395]}, 88) = 2395
 > 2395  write(2, "runtime: marked free object in s"..., 36 <unfinished ...>

I.e. IIUC, all are threads (CLONE_VM) and thread 2370 mapped ANON 
0x7fca68249000 - 0x7fca6827ffff and go in thread 2395 thinks for some 
reason 0x7fca6824bec8 in that region is "bad".

> thanks,-- 
-- 
js
suse labs

