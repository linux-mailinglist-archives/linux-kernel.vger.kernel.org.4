Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777216AEF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjCGSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjCGSYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:24:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364EF9CBCF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:19:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso17376735pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678213188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN/vMdmMuel9+OZruvoDa72uOsL24FJWbkXfA9+AfI=;
        b=GqpeI90KXa5CkpafsWHQ+VKf5PeMEb6xnOG2cUh1Ut2HPiTXSnjHsaoLAihOsyjyDn
         +uxGKfuzoPBOPjEJKN4MdJyNxDqWFDnfj4xIkqMHfrWEZAMOEdkS9VbSl6Ys7nPxJNbP
         dCimnGNrNhMhvmn4ajzOSYfrNeieUFBqiZpe+p9KhqjnpGbXUltH9RsbjMlevFxrf4LP
         GOWmMw7iELzAdPFvvSCYdKlfQaq+fKvX9rY5A81XrR5B538kF2ddN8OR4wy/Mj40SCca
         W1TjTquSB+iy47TeeZKsMHZgWCRqMqXNaySzg/6VkvndFnIbXWnLxruM8blg7Ix5LAxE
         wPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678213188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGN/vMdmMuel9+OZruvoDa72uOsL24FJWbkXfA9+AfI=;
        b=Sm8L25LA3cUJx0pWdngq3ihxLt9nu+f2Ww8v0fYF+B++qhwYc7qazCNxis2WdaosN1
         FQ9BtnhJwZzle551q040xvsxkrQkJV+B9til0AV92fLsJIp26Y9HHYYf8Ek16jqMTErw
         PUtkUKFO0U0BXdmWfc74kdq22Nd4BSu1hSEdlcprsvvKilKKE0L0fLE/9FZMls0PnVTF
         lRHF0ZwVpWA2pixYZtfhfIrfhximiP6zCBATGUpRzYqg6BxZWHhiACAv08H4eAEjfuhc
         VfS/P0XsdFhZnBf0bhlzPZVKHnxnMzSyI59P8ZY+ePhG81b3L0aSK98BkziemqP7hACW
         WQ+w==
X-Gm-Message-State: AO0yUKWSq7UIG9VMKx00U4DfExg0Sva8CqyPPUGs2dbST2UwbSLAZc6N
        SvotB7ihcqrY4wkSJIjG2fBuyy2Z4L42+j5jd2XmYQ==
X-Google-Smtp-Source: AK7set+eM2J9KpBq0ly/lTe2wGh7iDP/5DU4bikCHEzr77I24SaHgoagtV3kBqteKlCi8rs57Wrerw==
X-Received: by 2002:a17:903:22c1:b0:19e:ba2c:27ec with SMTP id y1-20020a17090322c100b0019eba2c27ecmr11958787plg.11.1678213188426;
        Tue, 07 Mar 2023 10:19:48 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id kw12-20020a170902f90c00b0019edcc30d9bsm1801666plb.155.2023.03.07.10.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:19:47 -0800 (PST)
Date:   Tue, 7 Mar 2023 18:19:44 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 00/18] NUMA aware page table allocation
Message-ID: <ZAeAQEaJW9kwjBA2@google.com>
References: <20230306224127.1689967-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023, Vipin Sharma wrote:
> Hi,
> 
> This series build up based on the feedback on v3.
> 
> Biggest change in features is to enable NUMA aware page table per VM
> basis instead of using a module parameter for all VMs on a host. This
> was decided based on an internal discussion to avoid forcing all VMs to
> be NUMA aware on a host. We need to collect more data to see how much
> performance degradation a VM can get in negative testing, where vCPUs in
> VM are always accessing remote NUMA nodes memory instead of staying
> local compared to a VM which is not NUMA aware.
> 
> There are other changes which are mentioned in the change log below for
> v4.
> 
> Thanks
> Vipin
> 
> v4:
> - Removed module parameter for enabling NUMA aware page table.

Could you have a space before the dash? I think the mutt mistakenly
treats it as a 'diff' where you removes a line.
> - Added new capability KVM_CAP_NUMA_AWARE_PAGE_TABLE to enable this
>   feature per VM.
> - Added documentation for the new capability.
> - Holding mutex just before the top up and releasing it after the
>   fault/split is addressed. Previous version were using spinlocks two
>   times, first time for topup and second time fetching the page from
>   cache.
> - Using the existing slots_lock for split_shadow_page_cache operations.
> - KVM MMU shrinker will also shrink mm_shadow_info_cache besides
>   split_shadow_page_cache and mmu_shadow_page_cache.
> - Reduced cache default size to 4.
> - Split patches into smaller ones.
> 
> v3: https://lore.kernel.org/lkml/20221222023457.1764-1-vipinsh@google.com/
> - Split patches into smaller ones.
> - Repurposed KVM MMU shrinker to free cache pages instead of oldest page table
>   pages
> - Reduced cache size from 40 to 5
> - Removed __weak function and initializing node value in all architectures.
> - Some name changes.
> 
> v2: https://lore.kernel.org/lkml/20221201195718.1409782-1-vipinsh@google.com/
> - All page table pages will be allocated on underlying physical page's
>   NUMA node.
> - Introduced module parameter, numa_aware_pagetable, to disable this
>   feature.
> - Using kvm_pfn_to_refcounted_page to get page from a pfn.
> 
> v1: https://lore.kernel.org/all/20220801151928.270380-1-vipinsh@google.com/
> 
> Vipin Sharma (18):
>   KVM: x86/mmu: Change KVM mmu shrinker to no-op
>   KVM: x86/mmu: Remove zapped_obsolete_pages from struct kvm_arch{}
>   KVM: x86/mmu: Track count of pages in KVM MMU page caches globally
>   KVM: x86/mmu: Shrink shadow page caches via MMU shrinker
>   KVM: x86/mmu: Add split_shadow_page_cache pages to global count of MMU
>     cache pages
>   KVM: x86/mmu: Shrink split_shadow_page_cache via MMU shrinker
>   KVM: x86/mmu: Unconditionally count allocations from MMU page caches
>   KVM: x86/mmu: Track unused mmu_shadowed_info_cache pages count via
>     global counter
>   KVM: x86/mmu: Shrink mmu_shadowed_info_cache via MMU shrinker
>   KVM: x86/mmu: Add per VM NUMA aware page table capability
>   KVM: x86/mmu: Add documentation of NUMA aware page table capability
>   KVM: x86/mmu: Allocate NUMA aware page tables on TDP huge page splits
>   KVM: mmu: Add common initialization logic for struct
>     kvm_mmu_memory_cache{}
>   KVM: mmu: Initialize kvm_mmu_memory_cache.gfp_zero to __GFP_ZERO by
>     default
>   KVM: mmu: Add NUMA node support in struct kvm_mmu_memory_cache{}
>   KVM: x86/mmu: Allocate numa aware page tables during page fault
>   KVM: x86/mmu: Allocate shadow mmu page table on huge page split on the
>     same NUMA node
>   KVM: x86/mmu: Reduce default mmu memory cache size
> 
>  Documentation/virt/kvm/api.rst   |  29 +++
>  arch/arm64/kvm/arm.c             |   2 +-
>  arch/arm64/kvm/mmu.c             |   2 +-
>  arch/mips/kvm/mips.c             |   3 +
>  arch/riscv/kvm/mmu.c             |   8 +-
>  arch/riscv/kvm/vcpu.c            |   2 +-
>  arch/x86/include/asm/kvm_host.h  |  17 +-
>  arch/x86/include/asm/kvm_types.h |   6 +-
>  arch/x86/kvm/mmu/mmu.c           | 319 +++++++++++++++++++------------
>  arch/x86/kvm/mmu/mmu_internal.h  |  38 ++++
>  arch/x86/kvm/mmu/paging_tmpl.h   |  29 +--
>  arch/x86/kvm/mmu/tdp_mmu.c       |  23 ++-
>  arch/x86/kvm/x86.c               |  18 +-
>  include/linux/kvm_host.h         |   2 +
>  include/linux/kvm_types.h        |  21 ++
>  include/uapi/linux/kvm.h         |   1 +
>  virt/kvm/kvm_main.c              |  24 ++-
>  17 files changed, 386 insertions(+), 158 deletions(-)
> 
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 

May I know your base? It seems I cannot apply the series to kvm/master
or kvm/queue without manual manipulation.
