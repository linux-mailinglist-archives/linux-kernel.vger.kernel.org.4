Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E858621D52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKHTzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKHTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:55:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CCB1C11A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:55:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z24so22701777ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sX3Ra3mwa6x/tHIBVR3+s7O4i1MGo+YxctILWccf32I=;
        b=Bkc+KKqSe1ql382HfRkf8l+mwrxqmytpI07CtNfof0IsWz+V2VMDFTw/AWAoHfcjX8
         nEwrT39CKwom2GHXSNUnQiTwwgrSvBQSMJT63NGjg+llVSfRtACHzNmoZoHDBYYHsk5k
         ldBeRw6pGYHbVRSkEK6c0MknDcinT+Gwa3UaYSyebaeXLvZ3KDStpQK4ZIPP6dI+H57d
         yUxpRuzSAbN2qvc7XdYiB54bCXbajqWaNHwo1FOWxovyKtWFgrk+jx64GSAfLNW60xA4
         +KxxtfZqRXJpzuu3x0h0vvjujB4VbWNRM4mrI95fZ4tBouFlt/vtwD3EAKRt6U3Rwhr+
         B+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX3Ra3mwa6x/tHIBVR3+s7O4i1MGo+YxctILWccf32I=;
        b=t1eYYmbpy8g/9mOF3T1rZpAHCkOPvHth4mG9y7fwKuPwQUjNw6qP05ZHaYnHz5VfcT
         1mx5x4/aktRahEpC5Ew3WU+fEvuOZwEL5Kbdgew52r7npRdA4XyoeLMu3dP4oEC6mhn4
         nZd0Q/bMMPis4kYmq7ILGs1vm9VDRhU62F1/P6BoiyVv3rTQKIFc5cnzYPne4nJZOWNa
         zdRBMPQoR0Hcnys3VWTINVGYuDGKby9iT4SlZV/zBsRirJA7aBEjafcUFyJ3h9n50ApP
         HI9zBOxQVkuDZ7QZyuJpp+U02Nd6gnTPCbfHRTufGJpNzR4LFjVVXqi5UUw1AS9LSl6O
         dRLg==
X-Gm-Message-State: ACrzQf3xG+PyyZNotSLP4dMJMvu8hoBBHdHO+sgBenDcz3v3xHbbZnQC
        XHfbYi85Ac03/lZESJjDtn8=
X-Google-Smtp-Source: AMsMyM5OXxZhr/ZB0LxwtVZdtMEGlCGjK6B3TfcQzI9Zh6MdpA4r4JptKwLG6hQtkJ2Ba7XKxf5evg==
X-Received: by 2002:a2e:b88a:0:b0:277:7364:cbcf with SMTP id r10-20020a2eb88a000000b002777364cbcfmr12306536ljp.50.1667937308549;
        Tue, 08 Nov 2022 11:55:08 -0800 (PST)
Received: from [192.168.31.203] ([5.19.98.133])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b0048aee825e2esm1902708lfc.282.2022.11.08.11.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 11:55:08 -0800 (PST)
Message-ID: <06debc96-ea5d-df61-3d2e-0d1d723e55b7@gmail.com>
Date:   Tue, 8 Nov 2022 22:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] x86/kasan: Populate shadow for shared chunk of the
 CPU entry area
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
References: <20221104183247.834988-1-seanjc@google.com>
 <20221104183247.834988-4-seanjc@google.com>
Content-Language: en-US
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20221104183247.834988-4-seanjc@google.com>
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



On 11/4/22 21:32, Sean Christopherson wrote:
> Popuplate the shadow for the shared portion of the CPU entry area, i.e.
> the read-only IDT mapping, during KASAN initialization.  A recent change
> modified KASAN to map the per-CPU areas on-demand, but forgot to keep a
> shadow for the common area that is shared amongst all CPUs.
> 
> Map the common area in KASAN init instead of letting idt_map_in_cea() do
> the dirty work so that it Just Works in the unlikely event more shared
> data is shoved into the CPU entry area.
> 
> The bug manifests as a not-present #PF when software attempts to lookup
> an IDT entry, e.g. when KVM is handling IRQs on Intel CPUs (KVM performs
> direct CALL to the IRQ handler to avoid the overhead of INTn):
> 
>  BUG: unable to handle page fault for address: fffffbc0000001d8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 16c03a067 P4D 16c03a067 PUD 0
>  Oops: 0000 [#1] PREEMPT SMP KASAN
>  CPU: 5 PID: 901 Comm: repro Tainted: G        W          6.1.0-rc3+ #410
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>  RIP: 0010:kasan_check_range+0xdf/0x190
>   vmx_handle_exit_irqoff+0x152/0x290 [kvm_intel]
>   vcpu_run+0x1d89/0x2bd0 [kvm]
>   kvm_arch_vcpu_ioctl_run+0x3ce/0xa70 [kvm]
>   kvm_vcpu_ioctl+0x349/0x900 [kvm]
>   __x64_sys_ioctl+0xb8/0xf0
>   do_syscall_64+0x2b/0x50
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
> Reported-by: syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/kasan_init_64.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index afc5e129ca7b..0302491d799d 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -341,7 +341,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
>  
>  void __init kasan_init(void)
>  {
> -	unsigned long shadow_cea_begin, shadow_cea_end;
> +	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
>  	int i;
>  
>  	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
> @@ -384,6 +384,7 @@ void __init kasan_init(void)
>  	}
>  
>  	shadow_cea_begin = kasan_mem_to_shadow_align_down(CPU_ENTRY_AREA_BASE);
> +	shadow_cea_per_cpu_begin = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_PER_CPU);
>  	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
>  						      CPU_ENTRY_AREA_MAP_SIZE);
>  
> @@ -409,6 +410,15 @@ void __init kasan_init(void)
>  		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
>  		(void *)shadow_cea_begin);
>  
> +	/*
> +	 * Populate the shadow for the shared portion of the CPU entry area.
> +	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
> +	 * area is randomly placed somewhere in the 512GiB range and mapping
> +	 * the entire 512GiB range is prohibitively expensive.
> +	 */
> +	kasan_populate_shadow(shadow_cea_begin,
> +			      shadow_cea_per_cpu_begin, 0);
> +

I think we can extend the kasan_populate_early_shadow() call above up to
shadow_cea_per_cpu_begin point, instead of this.
populate_early_shadow() maps single RO zeroed page. No one should write to the shadow for IDT.
KASAN only needs writable shadow for linear mapping/stacks/vmalloc/global variables.

>  	kasan_populate_early_shadow((void *)shadow_cea_end,
>  			kasan_mem_to_shadow((void *)__START_KERNEL_map));
>  
