Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8206745990
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjGCKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjGCKBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:01:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B1E6C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:58:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qGGJz-0002ai-71; Mon, 03 Jul 2023 11:58:15 +0200
Message-ID: <c8e75773-b37e-903f-ff87-55279dcccd13@leemhuis.info>
Date:   Mon, 3 Jul 2023 11:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US, de-DE
To:     Jiri Slaby <jirislaby@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-30-surenb@google.com>
 <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688378315;c9d24e74;
X-HE-SMSGID: 1qGGJz-0002ai-71
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.23 16:40, Jiri Slaby wrote:
> On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
>> Attempt VMA lock-based page fault handling first, and fall back to the
>> existing mmap_lock-based handling if that fails.
>>
>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> ---
>>   arch/x86/Kconfig    |  1 +
>>   arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a825bf031f49..df21fba77db1 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -27,6 +27,7 @@ config X86_64
>>       # Options that are inherently 64-bit kernel only:
>>       select ARCH_HAS_GIGANTIC_PAGE
>>       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>> +    select ARCH_SUPPORTS_PER_VMA_LOCK
>>       select ARCH_USE_CMPXCHG_LOCKREF
>>       select HAVE_ARCH_SOFT_DIRTY
>>       select MODULES_USE_ELF_RELA
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index a498ae1fbe66..e4399983c50c 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/uaccess.h>        /* faulthandler_disabled()    */
>>   #include <linux/efi.h>            /*
>> efi_crash_gracefully_on_page_fault()*/
>>   #include <linux/mm_types.h>
>> +#include <linux/mm.h>            /* find_and_lock_vma() */
>>     #include <asm/cpufeature.h>        /* boot_cpu_has, ...        */
>>   #include <asm/traps.h>            /* dotraplinkage, ...        */
>> @@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>>       }
>>   #endif
>>   +#ifdef CONFIG_PER_VMA_LOCK
>> +    if (!(flags & FAULT_FLAG_USER))
>> +        goto lock_mmap;
>> +
>> +    vma = lock_vma_under_rcu(mm, address);
>> +    if (!vma)
>> +        goto lock_mmap;
>> +
>> +    if (unlikely(access_error(error_code, vma))) {
>> +        vma_end_read(vma);
>> +        goto lock_mmap;
>> +    }
>> +    fault = handle_mm_fault(vma, address, flags |
>> FAULT_FLAG_VMA_LOCK, regs);
>> +    vma_end_read(vma);
>> +
>> +    if (!(fault & VM_FAULT_RETRY)) {
>> +        count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>> +        goto done;
>> +    }
>> +    count_vm_vma_lock_event(VMA_LOCK_RETRY);
> 
> This is apparently not strong enough as it causes go build failures like:

TWIMC & for the record: there is another report about trouble caused by
this change; for details see

https://bugzilla.kernel.org/show_bug.cgi?id=217624

And a "forward to devs and lists" thread about that report:

https://lore.kernel.org/all/facbfec3-837a-51ed-85fa-31021c17d6ef@gmail.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> [  409s] strconv
> [  409s] releasep: m=0x579e2000 m->p=0x5781c600 p->m=0x0 p->status=2
> [  409s] fatal error: releasep: invalid p state
> [  409s]
> 
> [  325s] hash/adler32
> [  325s] hash/crc32
> [  325s] cmd/internal/codesign
> [  336s] fatal error: runtime: out of memory
> 
> There are many kinds of similar errors. It happens in 1-3 out of 20
> builds only.
> 
> If I revert the commit on top of 6.4, they all dismiss. Any idea?
> 
> The downstream report:
> https://bugzilla.suse.com/show_bug.cgi?id=1212775
> 
>> +
>> +    /* Quick path to respond to signals */
>> +    if (fault_signal_pending(fault, regs)) {
>> +        if (!user_mode(regs))
>> +            kernelmode_fixup_or_oops(regs, error_code, address,
>> +                         SIGBUS, BUS_ADRERR,
>> +                         ARCH_DEFAULT_PKEY);
>> +        return;
>> +    }
>> +lock_mmap:
>> +#endif /* CONFIG_PER_VMA_LOCK */
>> +
>>       /*
>>        * Kernel-mode access to the user address space should only occur
>>        * on well-defined single instructions listed in the exception
>> @@ -1433,6 +1466,9 @@ void do_user_addr_fault(struct pt_regs *regs,
>>       }
>>         mmap_read_unlock(mm);
>> +#ifdef CONFIG_PER_VMA_LOCK
>> +done:
>> +#endif
>>       if (likely(!(fault & VM_FAULT_ERROR)))
>>           return;
>>   
> 
> thanks,
