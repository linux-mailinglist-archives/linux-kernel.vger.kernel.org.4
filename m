Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A535743523
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF3Gfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjF3Gfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:35:32 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7895199E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:35:30 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98df3dea907so177952666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106929; x=1690698929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20rBaj2Y5A8WawnZ5IpIpG7vFTWBtQPIoAz1oe/gFqA=;
        b=XLYIqbaxrkjvzv3x5tYG6bmSSxJwzelLWkhGu6hk0y4qvh5yUQWu6yehIOmCY3IiDx
         QnRKkD9EG8nlnpQWGio26vSs29BBg8aZATSQSptc3ApxGg5JSpvLSO3J03VoRtIWCeoe
         FcNIikmm73KLHwRZKLTL/XcCUoF5UcKiC+8COVcozKJcj6OSe9kIIfHljkBUbpmYHxJG
         Afpj0deGvx4v2xLkciyehi9vVKdfAvkEOZVypXqRpcpgAduwsH2r5Sx/OR3cO53pu5P7
         SvJUyMCSXWGNY7izx7Uq2xF5gg64gAr2N+4DMe3su/36Eg/uNGGnVFbomM3rbN8dh46L
         GENA==
X-Gm-Message-State: ABy/qLb5gKsWAPjT0dqBbV1qgtLpBcnWbDICRTgJZD94FgvlQc+ho+IF
        XVBbkOznfp00wxNn1XMjIYA=
X-Google-Smtp-Source: APBJJlFfYhTxC8ahwzU+JKDiJhjiAHDdaDYcw6muBSFSxnAn39XJR+dtpGgU7WNpRhVqsWEErFSBog==
X-Received: by 2002:a17:906:5593:b0:982:6bba:79c9 with SMTP id y19-20020a170906559300b009826bba79c9mr1180362ejp.20.1688106928988;
        Thu, 29 Jun 2023 23:35:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906414800b0098e2969ed44sm6614566ejk.45.2023.06.29.23.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:35:28 -0700 (PDT)
Message-ID: <9a8d788c-b8ba-1b8a-fd79-0e25b1b60bed@kernel.org>
Date:   Fri, 30 Jun 2023 08:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAJuCfpF7LweMwpvXavjJZhAciK7wK-bdLz2aFhOZGSHeK5tA9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 06. 23, 17:30, Suren Baghdasaryan wrote:
> On Thu, Jun 29, 2023 at 7:40 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> Hi,
>>
>> On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
>>> Attempt VMA lock-based page fault handling first, and fall back to the
>>> existing mmap_lock-based handling if that fails.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    arch/x86/Kconfig    |  1 +
>>>    arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 37 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index a825bf031f49..df21fba77db1 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -27,6 +27,7 @@ config X86_64
>>>        # Options that are inherently 64-bit kernel only:
>>>        select ARCH_HAS_GIGANTIC_PAGE
>>>        select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>> +     select ARCH_SUPPORTS_PER_VMA_LOCK
>>>        select ARCH_USE_CMPXCHG_LOCKREF
>>>        select HAVE_ARCH_SOFT_DIRTY
>>>        select MODULES_USE_ELF_RELA
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index a498ae1fbe66..e4399983c50c 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -19,6 +19,7 @@
>>>    #include <linux/uaccess.h>          /* faulthandler_disabled()      */
>>>    #include <linux/efi.h>                      /* efi_crash_gracefully_on_page_fault()*/
>>>    #include <linux/mm_types.h>
>>> +#include <linux/mm.h>                        /* find_and_lock_vma() */
>>>
>>>    #include <asm/cpufeature.h>         /* boot_cpu_has, ...            */
>>>    #include <asm/traps.h>                      /* dotraplinkage, ...           */
>>> @@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>        }
>>>    #endif
>>>
>>> +#ifdef CONFIG_PER_VMA_LOCK
>>> +     if (!(flags & FAULT_FLAG_USER))
>>> +             goto lock_mmap;
>>> +
>>> +     vma = lock_vma_under_rcu(mm, address);
>>> +     if (!vma)
>>> +             goto lock_mmap;
>>> +
>>> +     if (unlikely(access_error(error_code, vma))) {
>>> +             vma_end_read(vma);
>>> +             goto lock_mmap;
>>> +     }
>>> +     fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
>>> +     vma_end_read(vma);
>>> +
>>> +     if (!(fault & VM_FAULT_RETRY)) {
>>> +             count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>>> +             goto done;
>>> +     }
>>> +     count_vm_vma_lock_event(VMA_LOCK_RETRY);
>>
>> This is apparently not strong enough as it causes go build failures like:
>>
>> [  409s] strconv
>> [  409s] releasep: m=0x579e2000 m->p=0x5781c600 p->m=0x0 p->status=2
>> [  409s] fatal error: releasep: invalid p state
>> [  409s]
>>
>> [  325s] hash/adler32
>> [  325s] hash/crc32
>> [  325s] cmd/internal/codesign
>> [  336s] fatal error: runtime: out of memory
> 
> Hi Jiri,
> Thanks for reporting! I'm not familiar with go builds. Could you
> please explain the error to me or point me to some documentation to
> decipher that error?

Sorry, we are on the same boat -- me neither. It only popped up in our 
(openSUSE) build system and I only tracked it down by bisection. Let me 
know if I can try something (like a patch or gathering some debug info).

thanks,
-- 
js
suse labs

