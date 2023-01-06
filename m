Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2B660760
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjAFTte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjAFTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:49:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED70F81C10
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:49:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b12so1833956pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpLhyQZgzATzGstIxP/yvcKxq7IWDPng7YIobZxZsWE=;
        b=NaTj72ToNSnGDtsnSbfXRC0MrcjYoQaX9kpyZ5vVjg6OZiwmy8NTNCDMMPZGmM14kJ
         M12Pnc/QtqB8iXrvhUV9TqiRY4oEkVcekZBgEkwsFw/Ey6vDwdagoeOgLxoTz393l7Jq
         ZvUTync74JnlDdbgoaAIOK998mrb8TmOXII/cvwWw+POIMYFJA6IOMpOmIgC4xPvoift
         UYgLQguf9nKzRUwIOkrsMssEGp/TGoHjZBDMj7mTulKxmmffh7goodfUr3ZI0FZt78Nu
         0SFG9BwzcT6LIA3qgIaqYInrITpAgIzjMfJxwLCJPGEj3kcWjkWSwvzTfT11bNatanDq
         bsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpLhyQZgzATzGstIxP/yvcKxq7IWDPng7YIobZxZsWE=;
        b=vioU8JUh2gdJnw+gWnMtyr9IRxH3VW2K7rgF7ZqAaJZCU4mOe/vrdw226ObQcjIFtf
         b2XTs01yXga8YPh/y2pWbu2fh7mhqrFaAVqEzOk8uAVOatYHuYKjdCCMWJm6PbrhWceK
         02Sgxy9BdkHTq8E0azCSeSpaKJPdRlfeZOfxXstN5YZ/IVjsTsoYjro8X4O4DG5H8KWf
         NGiAzk4g6r6vei/L5fetwcQ0scLOayMC9bOQ3FOnnVhVjPhq3YKiXzKL9mguNSRO4elr
         m4B3/trtRVNA2b7KU8jfMwbzIqFv8yAvUHNJxE8BkREk87BLV6yB2ECsiyoes2aM1tTE
         A9NQ==
X-Gm-Message-State: AFqh2kqkeOyzL+WCZJMcnvcPWUFMNEggWWEDH/wxB+f8KcxzRGGWawTZ
        HeHp68cyvpNxMYrVcbdXE2iGXw==
X-Google-Smtp-Source: AMrXdXu1uBgFKprnO9cuXoFH7oVu848CIFtxVfPHnSfhiyB8agF+UnmRjSKK7IcTtkaLqFUFkCGMtQ==
X-Received: by 2002:a05:6a00:4c82:b0:582:8d34:7253 with SMTP id eb2-20020a056a004c8200b005828d347253mr18444500pfb.20.1673034565298;
        Fri, 06 Jan 2023 11:49:25 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b00581a156b920sm1460447pfr.132.2023.01.06.11.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 11:49:24 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:49:20 -0800
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Subject: Re: [RFC 04/14] KVM: x86/MMU: Expose functions for paging_tmpl.h
Message-ID: <Y7h7QPI5YcJ/FO02@google.com>
References: <20221221222418.3307832-1-bgardon@google.com>
 <20221221222418.3307832-5-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221222418.3307832-5-bgardon@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:24:08PM +0000, Ben Gardon wrote:
> In preparation for moving paging_tmpl.h to shadow_mmu.c, expose various
> functions it needs through mmu_internal.h. This includes modifying the
> BUILD_MMU_ROLE_ACCESSOR macro so that it does not automatically include
> the static label, since some but not all of the accessors are needed by
> paging_tmpl.h.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 32 ++++++++++++++++----------------
>  arch/x86/kvm/mmu/mmu_internal.h | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index bf14e181eb12..a17e8a79e4df 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -153,18 +153,18 @@ BUILD_MMU_ROLE_REGS_ACCESSOR(efer, lma, EFER_LMA);
>   * and the vCPU may be incorrect/irrelevant.
>   */
>  #define BUILD_MMU_ROLE_ACCESSOR(base_or_ext, reg, name)		\
> -static inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
> +inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
>  {								\
>  	return !!(mmu->cpu_role. base_or_ext . reg##_##name);	\
>  }
>  BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
> +static BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
>  BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smep);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smap);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
> +static BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, smap);
> +static BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
> +static BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
>  BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
> -BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
> +static BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);

Suggest moving all the BUILD_MMU_ROLE*() macros to mmu_internal.h, since
they are already static inline. That would be a cleaner patch and reduce
future churn if shadow_mmu.c ever needs to use a different role accessor
at some point.

>  
>  static inline bool is_cr0_pg(struct kvm_mmu *mmu)
>  {
> @@ -210,7 +210,7 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
>  	kvm_flush_remote_tlbs_with_range(kvm, &range);
>  }
>  
> -static gfn_t get_mmio_spte_gfn(u64 spte)
> +gfn_t get_mmio_spte_gfn(u64 spte)
>  {
>  	u64 gpa = spte & shadow_nonpresent_or_rsvd_lower_gfn_mask;
>  
> @@ -240,7 +240,7 @@ static bool check_mmio_spte(struct kvm_vcpu *vcpu, u64 spte)
>  	return likely(kvm_gen == spte_gen);
>  }
>  
> -static int is_cpuid_PSE36(void)
> +int is_cpuid_PSE36(void)
>  {
>  	return 1;
>  }

Can we just drop is_cpuid_PSE36(), e.g. as a precursor patch? It just
returns 1...
