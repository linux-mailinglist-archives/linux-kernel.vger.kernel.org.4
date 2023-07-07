Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC69774B080
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGGMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGGMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA30212B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688731753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gORiq5GodS7ZyZ8uTXDDTjpB1bJALeNv6hXNnjMKMlE=;
        b=bfE/adARTIqWU7lSTcubqJjaGdCRkCgihWc3YPuqS7Zty0uzFhD5Q03RYPCBslM1R/ZupI
        Yz+xqhI7RWrEmYHZIl1FZtdO35MGjvGbYBoqi5HHVwvCJyplrqugRZ2r7SvX57eq+ICgh0
        kGWAAE/FA3W1eqvBj2YleP4gsQINBUE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-k_tO0PkeOFqH1KR6qnlQuA-1; Fri, 07 Jul 2023 08:09:10 -0400
X-MC-Unique: k_tO0PkeOFqH1KR6qnlQuA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbb18e9bd9so10052975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688731749; x=1691323749;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gORiq5GodS7ZyZ8uTXDDTjpB1bJALeNv6hXNnjMKMlE=;
        b=ifjjocHZtXgoJb+GxC3isZ9ALiG6LmcWvlCE/TpO7QukGnuyAZ5wLOX3btwbnYbXfd
         9WVCGq1XCLX/4wz37aEtQI0yoYo3hA7ZxdCa5HYcGyL8t5hb5hfI+2oWJqGQcVchJX1v
         jc6kZUSy12epfG6Y68qz/TPXxScVHMrqHAJMLPzAqrWBME/HzSdxK7YmKpygbO2dzZnX
         Phu0BVzzS435ccyZxTy2nVi3wJ4OCKRU3BGWH1c7ZNLkDDlsf26w56SDx7xSFLhmBkIA
         Jgx2UwzUQSNWrwH8YiSlzFZLLLrhCDEUKo5r8AbUjMv+6UQN2KGv5pIXMfH2EhqHd7NO
         +iBA==
X-Gm-Message-State: ABy/qLaajZLKhkM4d7Twq8fghuDcpP20AsmcUSiDIO7mBn+BFN7dHaV5
        DATamUzEt6mEM9PtZvwyETXE8K+h5ayp4BNfSbQeOuYEYBR2g4DAlOpzHu9F3heqL0OOHOrBNxf
        bF6R4MouFdEVEW7EfQznYd2xQtpkBUiSM
X-Received: by 2002:a7b:cd1a:0:b0:3fb:c075:b308 with SMTP id f26-20020a7bcd1a000000b003fbc075b308mr4996098wmj.12.1688731749308;
        Fri, 07 Jul 2023 05:09:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFfKiKrAhyycHkgU5qil5GH1DqpfQJ20sg3fOGI5gZ6Cq9A4H9d55aCtQPRZY9qqIDQHOJH+A==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:c075:b308 with SMTP id f26-20020a7bcd1a000000b003fbc075b308mr4996081wmj.12.1688731749005;
        Fri, 07 Jul 2023 05:09:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7? (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de. [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d4742000000b0031434936f0dsm4305585wrs.68.2023.07.07.05.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 05:09:08 -0700 (PDT)
Message-ID: <0d035a57-b502-32b3-0010-d029f62d7757@redhat.com>
Date:   Fri, 7 Jul 2023 14:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
 <20230707053331.510041-2-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 1/4] arm64/mm: Add SW and HW dirty state helpers
In-Reply-To: <20230707053331.510041-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.23 07:33, Anshuman Khandual wrote:
> This factors out low level SW and HW state changes i.e make and clear into
> separate helpers making them explicit improving readability. This also adds
> pte_rdonly() helper as well. No functional change is intended.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 52 ++++++++++++++++++++++++++------
>   1 file changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..fb03be697819 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -103,6 +103,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>   #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>   #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> +#define pte_rdonly(pte)		(!!(pte_val(pte) & PTE_RDONLY))
>   #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
>   #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>   #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
> @@ -120,7 +121,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>   	(__boundary - 1 < (end) - 1) ? __boundary : (end);			\
>   })
>   
> -#define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
> +#define pte_hw_dirty(pte)	(pte_write(pte) && !pte_rdonly(pte))
>   #define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
>   #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>   
> @@ -174,6 +175,39 @@ static inline pmd_t clear_pmd_bit(pmd_t pmd, pgprot_t prot)
>   	return pmd;
>   }
>   
> +static inline pte_t pte_hw_mkdirty(pte_t pte)

I'd have called this "pte_mkhw_dirty", similar to "pte_mksoft_dirty".

> +{
> +	if (pte_write(pte))
> +		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
> +
> +	return pte;
> +}
> +
> +static inline pte_t pte_sw_mkdirty(pte_t pte)

pte_mksw_dirty

> +{
> +	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
> +}
> +
> +static inline __always_unused pte_t pte_hw_clr_dirty(pte_t pte)

pte_clear_hw_dirty (again, similar to pte_clear_soft_dirty )

> +{
> +	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
> +}
> +
> +static inline pte_t pte_sw_clr_dirty(pte_t pte)

pte_clear_sw_dirty

> +{
> +	pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> +
> +	/*
> +	 * Clearing the software dirty state requires clearing
> +	 * the PTE_DIRTY bit along with setting the PTE_RDONLY
> +	 * ensuring a page fault on subsequent write access.
> +	 *
> +	 * NOTE: Setting the PTE_RDONLY (as a coincident) also
> +	 * implies clearing the HW dirty state.
> +	 */
> +	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
> +}
> +
>   static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
>   {
>   	pmd_val(pmd) |= pgprot_val(prot);
> @@ -189,19 +223,17 @@ static inline pte_t pte_mkwrite(pte_t pte)
>   
>   static inline pte_t pte_mkclean(pte_t pte)
>   {
> -	pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
> -	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
> -
> -	return pte;
> +	/*
> +	 * Subsequent call to pte_hw_clr_dirty() is not required
> +	 * because pte_sw_clr_dirty() in turn does that as well.
> +	 */
> +	return pte_sw_clr_dirty(pte);

Hm, I'm not sure if that simplifies things.

You call pte_sw_clr_dirty() and suddenly your hw dirty bit is clear?

In that case I think the current implementation is clearer: it doesn't 
provide primitives that don't make any sense.

>   }
>   
>   static inline pte_t pte_mkdirty(pte_t pte)
>   {
> -	pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
> -
> -	if (pte_write(pte))
> -		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
> -
> +	pte = pte_sw_mkdirty(pte);
> +	pte = pte_hw_mkdirty(pte);

That looks weird. Especially, pte_hw_mkdirty() only does something if 
pte_write().

Shouldn't pte_hw_mkdirty() bail out if it cannot do anything reasonable 
(IOW, !writable)?

>   	return pte;
>   }
>   

-- 
Cheers,

David / dhildenb

