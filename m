Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778E5747AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGEALl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEALk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7AE4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688515858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+0+bseS4yp1wmND5ghILByl8+eIfcVb0vgT3gSxBqg=;
        b=OeRAKtG7eRAGagRg4Veknb2cd3I28iwsmJP9AAat7pe60Njr+BrUOAzCYHgZ0dr+OMiG14
        bZsNentzPLStQEU9VyeGsa0EJHrjWU06VK6s24zg0Pa0UWUWlwZSMqbwXtNK7bD+u9snXm
        81MSToTUR5WuAIief/D9cGjxnaaF6ro=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-XNi90hk-M3CrW1NTJRttqQ-1; Tue, 04 Jul 2023 20:10:57 -0400
X-MC-Unique: XNi90hk-M3CrW1NTJRttqQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6686e4499b1so6081174b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688515856; x=1691107856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+0+bseS4yp1wmND5ghILByl8+eIfcVb0vgT3gSxBqg=;
        b=ZnxN15rQvhdN/Lwm0iQXE5hYfiMSCTre8D931M6MbakmtYGFAPn4KdNtlQ5jyJO5Bf
         NvMA83d5uNISjKanqvJgedvWfBdX5cL/tt+WGS+4/pSFWyjIJ461UwCf38clRAr+YL3A
         y3GdIk82d6dQC2WOm7m+2RgLyk/lSzVx1nOjnF86hwv+rY6xqSODj+jWfu0Un3J1Ajir
         50QMfg+XmP2UfsuhRnbaNvqnVs9Y7/y8q2N/h/ATln16+TnQ3beTcMzuMu7Dnzn7/Cew
         E6xoy97FYVm8cpaHCh4q6kibz8alL6grU7Ku2smauLK7aliqUT4QzzicZXitzHTpt/Yk
         6WwQ==
X-Gm-Message-State: AC+VfDyMucxvNfbdRjlkPMlT5c0p6YQBIPbDFzJAR69V2nQqr+oD1qnJ
        6bJV8YIZk3HhQ5K+1uvtCBW8KAv5WXqzKxmR5E8lcDjQFdORV9zd3zHBtGCvPL3VSWtgwnT2JUI
        TQOlwXuUOLROXww5Pd31fDk26
X-Received: by 2002:a05:6a20:4d0:b0:123:c3dc:2052 with SMTP id 16-20020a056a2004d000b00123c3dc2052mr10529471pzd.35.1688515856528;
        Tue, 04 Jul 2023 17:10:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47QQ3YBvlJAo/rEA2BTL1eagO5kw3RmCxHff4EV0Qs6KlMV0jU3r6pGotpKrKiUIop4cWREg==
X-Received: by 2002:a05:6a20:4d0:b0:123:c3dc:2052 with SMTP id 16-20020a056a2004d000b00123c3dc2052mr10529444pzd.35.1688515856198;
        Tue, 04 Jul 2023 17:10:56 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902820500b001a183ade911sm17678801pln.56.2023.07.04.17.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 17:10:55 -0700 (PDT)
Message-ID: <9f9906b5-cdae-273c-06a3-5e100fe2ccd8@redhat.com>
Date:   Wed, 5 Jul 2023 10:10:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v5 05/11] arm64: tlb: Refactor the core flush
 algorithm of __flush_tlb_range
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
References: <20230621175002.2832640-1-rananta@google.com>
 <20230621175002.2832640-6-rananta@google.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230621175002.2832640-6-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 03:49, Raghavendra Rao Ananta wrote:
> Currently, the core TLB flush functionality of __flush_tlb_range()
> hardcodes vae1is (and variants) for the flush operation. In the
> upcoming patches, the KVM code reuses this core algorithm with
> ipas2e1is for range based TLB invalidations based on the IPA.
> Hence, extract the core flush functionality of __flush_tlb_range()
> into its own macro that accepts an 'op' argument to pass any
> TLBI operation, such that other callers (KVM) can benefit.
> 
> No functional changes intended.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/include/asm/tlbflush.h | 108 +++++++++++++++---------------
>   1 file changed, 55 insertions(+), 53 deletions(-)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 412a3b9a3c25d..4775378b6da1b 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -278,14 +278,61 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>    */
>   #define MAX_TLBI_OPS	PTRS_PER_PTE
>   
> +/* When the CPU does not support TLB range operations, flush the TLB
> + * entries one by one at the granularity of 'stride'. If the TLB
> + * range ops are supported, then:
> + *
> + * 1. If 'pages' is odd, flush the first page through non-range
> + *    operations;
> + *
> + * 2. For remaining pages: the minimum range granularity is decided
> + *    by 'scale', so multiple range TLBI operations may be required.
> + *    Start from scale = 0, flush the corresponding number of pages
> + *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> + *    until no pages left.
> + *
> + * Note that certain ranges can be represented by either num = 31 and
> + * scale or num = 0 and scale + 1. The loop below favours the latter
> + * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> + */
> +#define __flush_tlb_range_op(op, start, pages, stride,			\
> +				asid, tlb_level, tlbi_user) do {	\
> +	int num = 0;							\
> +	int scale = 0;							\
> +	unsigned long addr;						\
> +									\
> +	while (pages > 0) {						\
> +		if (!system_supports_tlb_range() ||			\
> +		    pages % 2 == 1) {					\
> +			addr = __TLBI_VADDR(start, asid);		\
> +			__tlbi_level(op, addr, tlb_level);		\
> +			if (tlbi_user)					\
> +				__tlbi_user_level(op, addr, tlb_level);	\
> +			start += stride;				\
> +			pages -= stride >> PAGE_SHIFT;			\
> +			continue;					\
> +		}							\
> +									\
> +		num = __TLBI_RANGE_NUM(pages, scale);			\
> +		if (num >= 0) {						\
> +			addr = __TLBI_VADDR_RANGE(start, asid, scale,	\
> +						  num, tlb_level);	\
> +			__tlbi(r##op, addr);				\
> +			if (tlbi_user)					\
> +				__tlbi_user(r##op, addr);		\
> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> +			pages -= __TLBI_RANGE_PAGES(num, scale);	\
> +		}							\
> +		scale++;						\
> +	}								\
> +} while (0)
> +

There is a warning reported from 'checkpatch.pl'.

     WARNING: suspect code indent for conditional statements (32, 8)
     #52: FILE: arch/arm64/include/asm/tlbflush.h:299:
     +				asid, tlb_level, tlbi_user) do {	\
     [...]
     +	unsigned long addr;						\

     total: 0 errors, 1 warnings, 125 lines checked

You probably need to tweak it as below, to avoid the warning.

     #define __flush_tlb_range_op(op, start, pages, stride,                \
                                  asid, tlb_level, tlbi_user)              \
     do {                                                                  \


>   static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   				     unsigned long start, unsigned long end,
>   				     unsigned long stride, bool last_level,
>   				     int tlb_level)
>   {
> -	int num = 0;
> -	int scale = 0;
> -	unsigned long asid, addr, pages;
> +	unsigned long asid, pages;
>   
>   	start = round_down(start, stride);
>   	end = round_up(end, stride);
> @@ -307,56 +354,11 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   	dsb(ishst);
>   	asid = ASID(vma->vm_mm);
>   
> -	/*
> -	 * When the CPU does not support TLB range operations, flush the TLB
> -	 * entries one by one at the granularity of 'stride'. If the TLB
> -	 * range ops are supported, then:
> -	 *
> -	 * 1. If 'pages' is odd, flush the first page through non-range
> -	 *    operations;
> -	 *
> -	 * 2. For remaining pages: the minimum range granularity is decided
> -	 *    by 'scale', so multiple range TLBI operations may be required.
> -	 *    Start from scale = 0, flush the corresponding number of pages
> -	 *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> -	 *    until no pages left.
> -	 *
> -	 * Note that certain ranges can be represented by either num = 31 and
> -	 * scale or num = 0 and scale + 1. The loop below favours the latter
> -	 * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> -	 */
> -	while (pages > 0) {
> -		if (!system_supports_tlb_range() ||
> -		    pages % 2 == 1) {
> -			addr = __TLBI_VADDR(start, asid);
> -			if (last_level) {
> -				__tlbi_level(vale1is, addr, tlb_level);
> -				__tlbi_user_level(vale1is, addr, tlb_level);
> -			} else {
> -				__tlbi_level(vae1is, addr, tlb_level);
> -				__tlbi_user_level(vae1is, addr, tlb_level);
> -			}
> -			start += stride;
> -			pages -= stride >> PAGE_SHIFT;
> -			continue;
> -		}
> -
> -		num = __TLBI_RANGE_NUM(pages, scale);
> -		if (num >= 0) {
> -			addr = __TLBI_VADDR_RANGE(start, asid, scale,
> -						  num, tlb_level);
> -			if (last_level) {
> -				__tlbi(rvale1is, addr);
> -				__tlbi_user(rvale1is, addr);
> -			} else {
> -				__tlbi(rvae1is, addr);
> -				__tlbi_user(rvae1is, addr);
> -			}
> -			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> -			pages -= __TLBI_RANGE_PAGES(num, scale);
> -		}
> -		scale++;
> -	}
> +	if (last_level)
> +		__flush_tlb_range_op(vale1is, start, pages, stride, asid, tlb_level, true);
> +	else
> +		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
> +
>   	dsb(ish);
>   }
>   

Thanks,
Gavin

