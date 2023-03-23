Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875176C730A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCWWXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCWWXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:23:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8AD1E1E0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:23:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso3394495pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679610215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JYdmyURWshL9XosKox/2DLDOtTApVxTqFZZFZ7i3vQ=;
        b=ex7BuE6Dma4DufCehO0zJ6WOVIuSziK39jd8uIlbyiy5GEpaxyfHKT9sBGohdH2xdJ
         DEE8VyY7SHoKo+AJxltOmIJpecI1bx8MXJnLr4TVI+TCO7NwfwukgrGlk26WQ4HPaIG8
         qAV4HPqWeGck+tkmCp8iVj4ZC8aCRlgwXOGK/ojss0rNMYpsUjH+ikmIWuYrgEBhNM8H
         /cOViW9nnFVWEVxdVpriFd71z7eoeuppozOPsivnErATOlPBV6xnmIDqY3BtgCS8NSU8
         /Z/Xgr+odPygbi9QpaOlCfhCFUCi+baDQHd+wb0YD8gwihz4wGPsdg0/AQOhWjTZXQqO
         QSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679610215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JYdmyURWshL9XosKox/2DLDOtTApVxTqFZZFZ7i3vQ=;
        b=tm7aP3i2FrWNbRZeCBSGNYVXMyK38xd3XxST91Bg/P+hxcwvb8+ckHi7izOrVughmK
         ZP2I3BU5kX1+zc5xglDEtRe8YKn6HCLS/nig4xIcMXv5TwTUWmd0QOTm6CNa5vP5c6Rb
         UtfUzZpRbRkYrqonm2UmGgRk+kc+YKVsSBNf09te0iykfkZTFt9sm8hjRwdSl3+fwK6n
         oQ6Srvly8OdnJT4P6AQfaHl5L1JRC/cX1FNPt4hWHXAo2gFPOWbKZAyMDKDPFEepXLv+
         baWQ8DPBfZwyFP3bARkqV0ohLBgah9FHhCeP33LfPb/ipdtrWHjtNQUikw+/K2ABdqsv
         VOlA==
X-Gm-Message-State: AAQBX9f+4jyC+757N1v4YAxIYAbuSbS72RDemYMh7RHJDEetHpdEXuNQ
        wGj+Ch6rgOWuNv8h7vkWW7VqSw==
X-Google-Smtp-Source: AKy350ZoXnMUk299U1UqatalEA4L8GMxmg9bcyFz+K7sVrUKSkTt8v4tfU4rdt1flwXAQZYMln4mvw==
X-Received: by 2002:a17:902:c702:b0:1a0:ae98:9b4 with SMTP id p2-20020a170902c70200b001a0ae9809b4mr362251plp.23.1679610214658;
        Thu, 23 Mar 2023 15:23:34 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709028ec100b0019f0ef910f7sm12745243plo.123.2023.03.23.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:23:34 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:23:30 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 13/18] KVM: mmu: Add common initialization logic for
 struct kvm_mmu_memory_cache{}
Message-ID: <ZBzRYgC0IWiZy7PI@google.com>
References: <20230306224127.1689967-1-vipinsh@google.com>
 <20230306224127.1689967-14-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306224127.1689967-14-vipinsh@google.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:41:22PM -0800, Vipin Sharma wrote:
> Add macros and function to make common logic for struct
> kvm_mmu_memory_cache{} declaration and initialization.
> 
> Any user which wants different values in struct kvm_mmu_memory_cache{}
> will overwrite the default values explicitly after the initialization.
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/arm64/kvm/arm.c      |  1 +
>  arch/arm64/kvm/mmu.c      |  3 ++-
>  arch/riscv/kvm/mmu.c      |  9 +++++----
>  arch/riscv/kvm/vcpu.c     |  1 +

MIPS also has cache (git grep "struct kvm_mmu_memory_cache").

>  arch/x86/kvm/mmu/mmu.c    |  8 ++++++++
>  include/linux/kvm_types.h | 10 ++++++++++
>  6 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 3bd732eaf087..2b3d88e4ace8 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -330,6 +330,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	vcpu->arch.target = -1;
>  	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_page_cache);
>  	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
>  
>  	/*
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7113587222ff..8a56f071ca66 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -895,7 +895,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  {
>  	phys_addr_t addr;
>  	int ret = 0;
> -	struct kvm_mmu_memory_cache cache = { .gfp_zero = __GFP_ZERO };
> +	KVM_MMU_MEMORY_CACHE(cache);

nit: DEFINE_KVM_MMU_MEMORY_CACHE()

(Based on similar existing macros in the kernel, e.g. DEFINE_MUTEX(),
DEFINE_TIMER().)

>  	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
>  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_DEVICE |
>  				     KVM_PGTABLE_PROT_R |
> @@ -904,6 +904,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  	if (is_protected_kvm_enabled())
>  		return -EPERM;
>  
> +	cache.gfp_zero = __GFP_ZERO;
>  	size += offset_in_page(guest_ipa);
>  	guest_ipa &= PAGE_MASK;
>  
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 78211aed36fa..bdd8c17958dd 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -351,10 +351,11 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
>  	int ret = 0;
>  	unsigned long pfn;
>  	phys_addr_t addr, end;
> -	struct kvm_mmu_memory_cache pcache = {
> -		.gfp_custom = (in_atomic) ? GFP_ATOMIC | __GFP_ACCOUNT : 0,
> -		.gfp_zero = __GFP_ZERO,
> -	};
> +	KVM_MMU_MEMORY_CACHE(pcache);
> +
> +	pcache.gfp_zero = __GFP_ZERO;
> +	if (in_atomic)
> +		pcache.gfp_custom = GFP_ATOMIC | __GFP_ACCOUNT;
>  
>  	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
>  	pfn = __phys_to_pfn(hpa);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 7d010b0be54e..bc743e9122d1 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -163,6 +163,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  
>  	/* Mark this VCPU never ran */
>  	vcpu->arch.ran_atleast_once = false;
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_page_cache);
>  	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
>  	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
>  
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a4bf2e433030..b706087ef74e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5961,15 +5961,20 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>  {
>  	int ret;
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_pte_list_desc_cache);
>  	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
>  	vcpu->arch.mmu_pte_list_desc_cache.gfp_zero = __GFP_ZERO;
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_page_header_cache);
>  	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
>  	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadow_page_cache);
>  	vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
>  	mutex_init(&vcpu->arch.mmu_shadow_page_cache_lock);
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadowed_info_cache);
> +
>  	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  
> @@ -6131,11 +6136,14 @@ int kvm_mmu_init_vm(struct kvm *kvm)
>  	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
>  	kvm_page_track_register_notifier(kvm, node);
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_page_header_cache);
>  	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
>  	kvm->arch.split_page_header_cache.gfp_zero = __GFP_ZERO;
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_shadow_page_cache);
>  	kvm->arch.split_shadow_page_cache.gfp_zero = __GFP_ZERO;
>  
> +	INIT_KVM_MMU_MEMORY_CACHE(&kvm->arch.split_desc_cache);
>  	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
>  	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
>  
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 2728d49bbdf6..192516eeccac 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -98,6 +98,16 @@ struct kvm_mmu_memory_cache {
>  	int capacity;
>  	void **objects;
>  };
> +
> +#define KVM_MMU_MEMORY_CACHE_INIT() { }
> +
> +#define KVM_MMU_MEMORY_CACHE(_name) \
> +		struct kvm_mmu_memory_cache _name = KVM_MMU_MEMORY_CACHE_INIT()

nit: There's an extra tab here.

> +
> +static inline void INIT_KVM_MMU_MEMORY_CACHE(struct kvm_mmu_memory_cache *cache)
> +{
> +	*cache = (struct kvm_mmu_memory_cache)KVM_MMU_MEMORY_CACHE_INIT();
> +}
>  #endif
>  
>  #define HALT_POLL_HIST_COUNT			32
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 
