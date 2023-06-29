Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF974289F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF2Okw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjF2Oku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:40:50 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB4BC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:40:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d9890f368so926023a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049648; x=1690641648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acfeDV6ig1DAYnhU+FrQZ3QnlBZlpv5iySwPYFbbjOg=;
        b=Yat7jBUESNhoX5nDFB4j+dGQlpcUHZ3VQvLdNwamdJiykssdJbPC8Bzi+6d1MGJdn0
         N7o7Lwt3rMZNd892opuqu/L9dnT/F1dheMUHoRBgE0vhWJLH21D/U/qtkplS8eKonhXC
         Wf1t8y7jIw1V0fwds85eLXkEbc7IzcJyIkaQL0YZrP+x2rKsaV88sDZcvGKntBoPXO11
         MOrxkwl7jt0kyLxsINOhio/kIWvl+mqFFv7U+/PEuHFqLMF+xfDCo14SlE1rk3tQWCq0
         MDz06fMpbIN66Dn0PcaRBek2w8jsYU/xLD+gfxlMAuazhEEDnS5aTUR+agd7VFNLwCRD
         vNmw==
X-Gm-Message-State: AC+VfDyP3xQfu5GcokHquFw3EfAgW8uid0uYXeCDPYZCOyzHJkSmn7XV
        I3HGA6cNw27slnttulhbtzQ=
X-Google-Smtp-Source: ACHHUZ6sA34LKMurP3cV/MCxdjN3zx/QJkMADdp5Xd/K65ilFwG180EmkQLV3tq+R4tttPbzem8Bmw==
X-Received: by 2002:a17:907:2cce:b0:991:de8e:4f99 with SMTP id hg14-20020a1709072cce00b00991de8e4f99mr8222804ejc.70.1688049647620;
        Thu, 29 Jun 2023 07:40:47 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id lh8-20020a170906f8c800b009923998c8acsm2760768ejb.20.2023.06.29.07.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 07:40:47 -0700 (PDT)
Message-ID: <dbdef34c-3a07-5951-e1ae-e9c6e3cdf51b@kernel.org>
Date:   Thu, 29 Jun 2023 16:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 29/33] x86/mm: try VMA lock-based page fault handling
 first
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230227173632.3292573-30-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27. 02. 23, 18:36, Suren Baghdasaryan wrote:
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   arch/x86/Kconfig    |  1 +
>   arch/x86/mm/fault.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a825bf031f49..df21fba77db1 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -27,6 +27,7 @@ config X86_64
>   	# Options that are inherently 64-bit kernel only:
>   	select ARCH_HAS_GIGANTIC_PAGE
>   	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> +	select ARCH_SUPPORTS_PER_VMA_LOCK
>   	select ARCH_USE_CMPXCHG_LOCKREF
>   	select HAVE_ARCH_SOFT_DIRTY
>   	select MODULES_USE_ELF_RELA
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index a498ae1fbe66..e4399983c50c 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -19,6 +19,7 @@
>   #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
>   #include <linux/efi.h>			/* efi_crash_gracefully_on_page_fault()*/
>   #include <linux/mm_types.h>
> +#include <linux/mm.h>			/* find_and_lock_vma() */
>   
>   #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
>   #include <asm/traps.h>			/* dotraplinkage, ...		*/
> @@ -1333,6 +1334,38 @@ void do_user_addr_fault(struct pt_regs *regs,
>   	}
>   #endif
>   
> +#ifdef CONFIG_PER_VMA_LOCK
> +	if (!(flags & FAULT_FLAG_USER))
> +		goto lock_mmap;
> +
> +	vma = lock_vma_under_rcu(mm, address);
> +	if (!vma)
> +		goto lock_mmap;
> +
> +	if (unlikely(access_error(error_code, vma))) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> +	vma_end_read(vma);
> +
> +	if (!(fault & VM_FAULT_RETRY)) {
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		goto done;
> +	}
> +	count_vm_vma_lock_event(VMA_LOCK_RETRY);

This is apparently not strong enough as it causes go build failures like:

[  409s] strconv
[  409s] releasep: m=0x579e2000 m->p=0x5781c600 p->m=0x0 p->status=2
[  409s] fatal error: releasep: invalid p state
[  409s]

[  325s] hash/adler32
[  325s] hash/crc32
[  325s] cmd/internal/codesign
[  336s] fatal error: runtime: out of memory

There are many kinds of similar errors. It happens in 1-3 out of 20 
builds only.

If I revert the commit on top of 6.4, they all dismiss. Any idea?

The downstream report:
https://bugzilla.suse.com/show_bug.cgi?id=1212775

> +
> +	/* Quick path to respond to signals */
> +	if (fault_signal_pending(fault, regs)) {
> +		if (!user_mode(regs))
> +			kernelmode_fixup_or_oops(regs, error_code, address,
> +						 SIGBUS, BUS_ADRERR,
> +						 ARCH_DEFAULT_PKEY);
> +		return;
> +	}
> +lock_mmap:
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>   	/*
>   	 * Kernel-mode access to the user address space should only occur
>   	 * on well-defined single instructions listed in the exception
> @@ -1433,6 +1466,9 @@ void do_user_addr_fault(struct pt_regs *regs,
>   	}
>   
>   	mmap_read_unlock(mm);
> +#ifdef CONFIG_PER_VMA_LOCK
> +done:
> +#endif
>   	if (likely(!(fault & VM_FAULT_ERROR)))
>   		return;
>   

thanks,
-- 
js
suse labs

