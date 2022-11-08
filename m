Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29194621D70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKHUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:14:22 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5095D6A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:14:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d20so22740100ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vec2jCz+Quh9+mCqYjMdMcKulUWOBt0A1f942dQxTI4=;
        b=dygAqBZwdRkgp+TAJzdEzq2RWd3TQMu/75atbJEETb/zLNRBKK/IwylVi5MKbmY8+I
         +zoKd8AdBzmlTa/IMP/AyEueVaEfHWVPWavkdtGXYV+JY8Zwws/rmoGf7+bGDHDlRsYz
         fHr4R8uDeLhsnJ5sWQ5P6BmKQdPWkGS65tI8HxSsyUUr44nKABp3iMd3M2HPlAqgA46q
         TqwWz+a4G0/z3BLKIf4bfpPf1hc4OmiROrjQVd2xylM2lwuqnpIB++n9OL2Hxm6Ghmhn
         xIz74mH9v4JqMlPNixgvgJjmwk9LwR4wQtsojTYSD3rVaP6ggGQjX+rqitn8DzdfsPSF
         wJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vec2jCz+Quh9+mCqYjMdMcKulUWOBt0A1f942dQxTI4=;
        b=l4Wgv01uLXVHIgcCyPpYpm4on/871VmbANQ51k2hf7vh3aCNLBX7UZ8lYDHguO08jl
         e1j0aW7Qzw1NOlblYvaqdICbAoczwDURTOWrRLzQWS9iR6Eai6z3AVQyKeMdX/8+bn4E
         3g+yzu6Z5n+UsHEWTCSKcErFHo+go7E/MAMuIhjk3SjOGSnqZkbwo9jGeUKoDSmu2eTa
         Wm3XKMcSpSxBpL+QbC0FOnn409eFr9r1qvDxsV0ziqGVMeEDufl2LdSRar3CrlIplhaE
         3qv4fS9aIPEsyY4QHJxEgdUoDpd0tJQug5Fk9xZXDc6qqic9jvJmUq33Sw3iZ9ofL9bC
         UvYg==
X-Gm-Message-State: ACrzQf3Lwc8w7ogHX5UF5dTlarFoBzOqyjLT5SDq0RA/3PGjK0gDcova
        v6dUndKjvRcDubi6CrsGrBc=
X-Google-Smtp-Source: AMsMyM7Yh5Pm9lg2eQli0QNfT2+JXCTNcV7vUcbbpE7aRrtZeLj5JKLN274MySepPs6y69VlhBzddA==
X-Received: by 2002:a2e:b163:0:b0:277:6bc:2ab0 with SMTP id a3-20020a2eb163000000b0027706bc2ab0mr6783632ljm.142.1667938458542;
        Tue, 08 Nov 2022 12:14:18 -0800 (PST)
Received: from [192.168.31.203] ([5.19.98.133])
        by smtp.gmail.com with ESMTPSA id v6-20020a05651203a600b004b40c1f1c70sm392981lfp.212.2022.11.08.12.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:14:18 -0800 (PST)
Message-ID: <b5e31093-ac80-595b-1127-2a3e35913d86@gmail.com>
Date:   Tue, 8 Nov 2022 23:14:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] x86/mm: Populate KASAN shadow for per-CPU GDT mapping in
 CPU entry area
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
References: <20221104212433.1339826-1-seanjc@google.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221104212433.1339826-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/22 00:24, Sean Christopherson wrote:
> Bounce through cea_map_percpu_pages() when setting protections for the
> per-CPU GDT mapping so that KASAN populates a shadow for said mapping.
> Failure to populate the shadow will result in a not-present #PF during
> KASAN validation if the kernel performs a software lookup into the GDT.
> 
> The bug is most easily reproduced by doing a sigreturn with a garbage
> CS in the sigcontext, e.g.
> 
>   int main(void)
>   {
>     struct sigcontext regs;
> 
>     syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
>     syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
>     syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
>     memset(&regs, 0, sizeof(regs));
>     regs.cs = 0x1d0;
>     syscall(__NR_rt_sigreturn);
>     return 0;
>   }
> 
> to coerce the kernel into doing a GDT lookup to compute CS.base when
> reading the instruction bytes on the subsequent #GP to determine whether
> or not the #GP is something the kernel should handle, e.g. to fixup UMIP
> violations or to emulate CLI/STI for IOPL=3 applications.
> 
>   BUG: unable to handle page fault for address: fffffbc8379ace00
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 16c03a067 P4D 16c03a067 PUD 15b990067 PMD 15b98f067 PTE 0
>   Oops: 0000 [#1] PREEMPT SMP KASAN
>   CPU: 3 PID: 851 Comm: r2 Not tainted 6.1.0-rc3-next-20221103+ #432
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:kasan_check_range+0xdf/0x190
>   Call Trace:
>    <TASK>
>    get_desc+0xb0/0x1d0
>    insn_get_seg_base+0x104/0x270
>    insn_fetch_from_user+0x66/0x80
>    fixup_umip_exception+0xb1/0x530
>    exc_general_protection+0x181/0x210
>    asm_exc_general_protection+0x22/0x30
>   RIP: 0003:0x0
>   Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>   RSP: 0003:0000000000000000 EFLAGS: 00000202
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000001d0
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
> Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/cpu_entry_area.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index dff9001e5e12..4a6440461c10 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -195,7 +195,7 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
>  	pgprot_t tss_prot = PAGE_KERNEL;
>  #endif
>  
> -	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
> +	cea_map_percpu_pages(&cea->gdt, get_cpu_gdt_rw(cpu), 1, gdt_prot);


I'm thinking using kasan_populate_shadow_for_vaddr() in cea_map_percpu_page() wasn't the right idea.
We should just map shadow for entire 'cea' from setup_cpu_entry_area() instead of fixing it up in random places.
I mean like this:

---
 arch/x86/mm/cpu_entry_area.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index dff9001e5e12..b122fa5e805b 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -195,6 +195,9 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
+	kasan_populate_shadow_for_vaddr(cea, CPU_ENTRY_AREA_SIZE,
+					early_cpu_to_node(cpu));
+
 	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
 
 	cea_map_percpu_pages(&cea->entry_stack_page,
-- 
2.37.4

