Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD89694543
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjBMMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBMMHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C381A6E87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676289921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWwnaVVkHZ3TxJmod/JcejUfCO6MlIwBZ7PTsYBSbh0=;
        b=Xi/TasoEo4x/Etc4Fw08cTAeAVYG+mQf5cDlttMBSloohd7QUeCDbpiknsTrCetQbeNin/
        hNFTAYYrM1yL9ycScFH599VtBnYxhaJWjYzfp7J2kFqohnFQhtz3wkfvrYKmtBUBj4et0k
        Nw/jQG56NHWRwRSv8QF4t10tuk9LTE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-J4S4PusjPG2SGKqX9AJJLg-1; Mon, 13 Feb 2023 07:05:19 -0500
X-MC-Unique: J4S4PusjPG2SGKqX9AJJLg-1
Received: by mail-wr1-f72.google.com with SMTP id l15-20020adff48f000000b002c55dbddb59so350824wro.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWwnaVVkHZ3TxJmod/JcejUfCO6MlIwBZ7PTsYBSbh0=;
        b=UXU73xEPIhmUpxVIZFqVOjsXmzBhogeKjPE8akNXW3EjGR48DKoLR1VzXVd2JmfJXp
         t/4Vr3crTU4LKofP0uKTXXmz3pfhAWaZA+PnkutalJqYp5uzdSFn4MohyQ4MmEoGv8dZ
         y8MErU7o2MFYaIiFseCFl51MNEKwPb8xli6MDJKzt8RnHlNuUFH3xoYZx0HFKlQQVTm5
         +DSDIdgucCk/HIOqtU8EkrnKU3mP9mMQu0Ln8Bf+TlZLl6bOgvJQMJkshXdtWat5MfU3
         hjlFvtR0XRuspfFVhL149YGAsb7a0xiDnysretdcvl+jkl61na9FPcGYyX3frbob7irO
         2nWg==
X-Gm-Message-State: AO0yUKV87LRaVjyVzm7EI7VEsfJbF0Ns8MjMadzgB2bJUNJGMvh3bsma
        Dh0gZzNZ/nzB7GcmHbBKO8f9qf7bVRPUCfaMAx+CcTPiO/mZbf4MswVZvcNEG6Pu7pein/C3AKX
        0ghUevPCSXyikj/i49wk/GjRF51C75g==
X-Received: by 2002:a05:600c:704:b0:3df:d8c5:ec18 with SMTP id i4-20020a05600c070400b003dfd8c5ec18mr19163997wmn.13.1676289918373;
        Mon, 13 Feb 2023 04:05:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/TvfuGOjSTFiefa5UXGSPN6E8+yK5KOhZR7JAxIR0Nqy6UHZc73gYlaZp/IBbv/pX2T70tdA==
X-Received: by 2002:a05:600c:704:b0:3df:d8c5:ec18 with SMTP id i4-20020a05600c070400b003dfd8c5ec18mr19163980wmn.13.1676289918082;
        Mon, 13 Feb 2023 04:05:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id y9-20020adfee09000000b002c550eb062fsm5407008wrn.14.2023.02.13.04.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:05:17 -0800 (PST)
Message-ID: <2d6eefb8-c7c5-7d32-9a75-ae716f828cd9@redhat.com>
Date:   Mon, 13 Feb 2023 13:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 RFC Zisslpcfi 11/20] mmu: maybe_mkwrite updated to
 manufacture shadow stack PTEs
Content-Language: en-US
To:     Deepak Gupta <debug@rivosinc.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-12-debug@rivosinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213045351.3945824-12-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 05:53, Deepak Gupta wrote:
> maybe_mkwrite creates PTEs with WRITE encodings for underlying arch if
> VM_WRITE is turned on in vma->vm_flags. Shadow stack memory is a write-
> able memory except it can only be written by certain specific
> instructions. This patch allows maybe_mkwrite to create shadow stack PTEs
> if vma is shadow stack VMA. Each arch can define which combination of VMA
> flags means a shadow stack.
> 
> Additionally pte_mkshdwstk must be provided by arch specific PTE
> construction headers to create shadow stack PTEs. (in arch specific
> pgtable.h).
> 
> This patch provides dummy/stub pte_mkshdwstk if CONFIG_USER_SHADOW_STACK
> is not selected.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   include/linux/mm.h      | 23 +++++++++++++++++++++--
>   include/linux/pgtable.h |  4 ++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..a7705bc49bfe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1093,6 +1093,21 @@ static inline unsigned long thp_size(struct page *page)
>   void free_compound_page(struct page *page);
>   
>   #ifdef CONFIG_MMU
> +
> +#ifdef CONFIG_USER_SHADOW_STACK
> +bool arch_is_shadow_stack_vma(struct vm_area_struct *vma);
> +#endif
> +
> +static inline bool
> +is_shadow_stack_vma(struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_USER_SHADOW_STACK
> +	return arch_is_shadow_stack_vma(vma);
> +#else
> +	return false;
> +#endif
> +}
> +
>   /*
>    * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
>    * servicing faults for write access.  In the normal case, do always want
> @@ -1101,8 +1116,12 @@ void free_compound_page(struct page *page);
>    */
>   static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>   {
> -	if (likely(vma->vm_flags & VM_WRITE))
> -		pte = pte_mkwrite(pte);
> +	if (likely(vma->vm_flags & VM_WRITE)) {
> +		if (unlikely(is_shadow_stack_vma(vma)))
> +			pte = pte_mkshdwstk(pte);
> +		else
> +			pte = pte_mkwrite(pte);
> +	}
>   	return pte;

Exactly what we are trying to avoid in the x86 approach right now. 
Please see the x86 series on details, we shouldn't try reinventing the 
wheel but finding a core-mm approach that fits multiple architectures.

https://lkml.kernel.org/r/20230119212317.8324-1-rick.p.edgecombe@intel.com

-- 
Thanks,

David / dhildenb

