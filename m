Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8764747ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGEAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E7EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688517111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2tbEzCQLL4wAVGNQCcCaWeGf9IDqYi1dQ3iAXttaRxQ=;
        b=J0mmyVAkzVPft89PlCCgACxlvhle9JC5rwZOuZhd9uzNUvX/itPZ4xygzBFwFTSsGKwDLu
        5pEs86aYXPgKIOFmQLK31m32g6BImBmjoj/Kv/AnPlRdo3C3juMhOku/pOSCQ+yQo5YeIr
        gvuYESIdUMN6jXwIMuskXDWVk2ilFiY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-OOIIX_qmO3SfdOoCn3VYjQ-1; Tue, 04 Jul 2023 20:31:49 -0400
X-MC-Unique: OOIIX_qmO3SfdOoCn3VYjQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-666ecb21fb8so8105110b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688517109; x=1691109109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tbEzCQLL4wAVGNQCcCaWeGf9IDqYi1dQ3iAXttaRxQ=;
        b=O3owDVHLtm+ssN3GZv5JnLZ+sUXP5SWbAE7cluapwlObYml+IDD2KgaEVWaDHYlTf2
         X0XtMTEMzL1XsTXFPwwxmuUfwsOA053OZnxIobY4yzAR9rl6YYIuSl404aTe0nKlicku
         2LwrW+DeanmqPHmSnclp+tMLgRiFRVdhb58YjgbhfzbRvtYTJKWnk0sNFtkvVbq1JDUJ
         UqDpXoFuoYZ/TI1VpIfMM0/XjWCF7el6KbK3Y72fb8o5LJU0M1/N3fLoO7FnufhOY77Y
         R2Iqc2JALCDU0dNs8oPrg1Qj0aK1PJEVk+X5tAV0i3SkNGLEzw3+2ge6yx71mypUvIml
         YrXw==
X-Gm-Message-State: ABy/qLZwNhX/lSF+7FyCLTNdb0iV6gAcu6awTqwIeRcSMQ6bUUZv3JAd
        pUoCK3p4B77WdZWuaYco2AqzqEI1+SfGz0noKw+iXp5E4R/4aNSO03PkvlfuaB4dPACH4EhqN2e
        WMYUIMclMkAXqUba5UWd9e05w
X-Received: by 2002:a05:6a00:190d:b0:66c:9faa:bb12 with SMTP id y13-20020a056a00190d00b0066c9faabb12mr16704407pfi.9.1688517108921;
        Tue, 04 Jul 2023 17:31:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmfNfMPx/IrkAMqhqCvq3CBwACnFQn2OpL7OQ5Txr79ZB/+akox9sOla+QB1fZL69N2wqqhQ==
X-Received: by 2002:a05:6a00:190d:b0:66c:9faa:bb12 with SMTP id y13-20020a056a00190d00b0066c9faabb12mr16704398pfi.9.1688517108632;
        Tue, 04 Jul 2023 17:31:48 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id c184-20020a624ec1000000b00658670ebe7dsm6105353pfb.119.2023.07.04.17.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 17:31:47 -0700 (PDT)
Message-ID: <1fe280a7-0f10-e124-00aa-b137df722c33@redhat.com>
Date:   Wed, 5 Jul 2023 10:31:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v5 07/11] KVM: arm64: Define
 kvm_tlb_flush_vmid_range()
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
        kvm@vger.kernel.org
References: <20230621175002.2832640-1-rananta@google.com>
 <20230621175002.2832640-8-rananta@google.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230621175002.2832640-8-rananta@google.com>
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
> Implement the helper kvm_tlb_flush_vmid_range() that acts
> as a wrapper for range-based TLB invalidations. For the
> given VMID, use the range-based TLBI instructions to do
> the job or fallback to invalidating all the TLB entries.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>   arch/arm64/include/asm/kvm_pgtable.h | 10 ++++++++++
>   arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 

It may be reasonable to fold this to PATCH[08/11] since kvm_tlb_flush_vmid_range() is
only called by ARM64's kvm_arch_flush_remote_tlbs_range(), which is added by PATCH[08/11].
In either way, the changes look good to me:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 4cd6762bda805..1b12295a83595 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -682,4 +682,14 @@ enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
>    *	   kvm_pgtable_prot format.
>    */
>   enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
> +
> +/**
> + * kvm_tlb_flush_vmid_range() - Invalidate/flush a range of TLB entries
> + *
> + * @mmu:	Stage-2 KVM MMU struct
> + * @addr:	The base Intermediate physical address from which to invalidate
> + * @size:	Size of the range from the base to invalidate
> + */
> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> +				phys_addr_t addr, size_t size);
>   #endif	/* __ARM64_KVM_PGTABLE_H__ */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 3d61bd3e591d2..df8ac14d9d3d4 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -631,6 +631,26 @@ static bool stage2_has_fwb(struct kvm_pgtable *pgt)
>   	return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
>   }
>   
> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
> +				phys_addr_t addr, size_t size)
> +{
> +	unsigned long pages, inval_pages;
> +
> +	if (!system_supports_tlb_range()) {
> +		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
> +		return;
> +	}
> +
> +	pages = size >> PAGE_SHIFT;
> +	while (pages > 0) {
> +		inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
> +		kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, addr, inval_pages);
> +
> +		addr += inval_pages << PAGE_SHIFT;
> +		pages -= inval_pages;
> +	}
> +}
> +
>   #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))
>   
>   static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,

Thanks,
Gavin

