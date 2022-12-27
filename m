Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591C0656E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiL0Twm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiL0Twk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:52:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BA101E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:52:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so33985490ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MqHaR9sjfvD/myYgTCGg8KetMxcHxaTjMlGqG5MAO9k=;
        b=XgnfCcvzBuSiJzDiv7aDolyIPTPWFRvNbzy4Ek6y5tWZ3l29g6hywBSS4horRwif36
         OYAzH01aL7EYhASMi2GptFgKiMIGLNbPVArxcmQW51DS3JhaYKQe7jjU5SDaoiVSb9Yf
         tkmrscmvnv5CDQdxEypaNxOZapoqzdnkoQXr0V7lueUUsBgDG5vKwWcYOCmffZ9c+z22
         9Es2pr2McwlTd35rHhn8pFynHTqIyVFMRt7XhTHQ4emwKRs1u7WHQy4nSoPOP3k9/3TJ
         yaoHYhk3kG0Rw8+if3RReiYQP097rH+Za2Jx9WRmB5dPaTsnFhEY2kwKpzZ1VGTZO6vE
         ZFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqHaR9sjfvD/myYgTCGg8KetMxcHxaTjMlGqG5MAO9k=;
        b=kpS2n/klez1zd0onXFSk7TOogXjbqIwgmDqVdKuLVLVm7NKOw2DYZx29mA90dJgQwj
         VpMYRyEN/wwZWl6N/I769TRFuAAu4UBwkFFY0st7mi7geRhbFOWnnRnsjleK/aKwsBYu
         H53H5COgPz13OyOOAxlGbGYlF66I8yDxLcwh8oNvo8UOtzxb+/r5VUEuVdDB4SOedZe6
         ko7yiuNEpZH5Hh4qmbgSO82HJWMWC0TiWNo4u/VN99ryAQIHYKZCaaov/M4rEdw0v0yy
         CmMKS4VZeAwWlxsWRd50So4PsXJi1nzsk6IESHaIN1KFIYFHiCADwtMQGcyDMbK2pz7z
         pGmw==
X-Gm-Message-State: AFqh2kqwPSKVmQ0seMC/n6jsFINuhFIgyznxEuIBAckMuKWFo3CuYJ8y
        c1iZcLxNcC8O5tma8IrOm/rrWPEhFZJFb78F1Scepulz8EVJCA==
X-Google-Smtp-Source: AMrXdXs/pk0YCljtxtK78Y3Xive93hSL4gDgPHkNPnnjTEs8+Q8lSEOQTg4n6iQUcm4UvjSjlfByjnxvRbFKFa+FqTs=
X-Received: by 2002:a17:906:1cc2:b0:7ad:9ad7:e882 with SMTP id
 i2-20020a1709061cc200b007ad9ad7e882mr2168940ejh.520.1672170757022; Tue, 27
 Dec 2022 11:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com> <20221222023457.1764-10-vipinsh@google.com>
In-Reply-To: <20221222023457.1764-10-vipinsh@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 27 Dec 2022 11:52:25 -0800
Message-ID: <CANgfPd9xu5yw+k4WfCQKVsouM5mKtMNG_Kd7_tokkJm=ha4JTA@mail.gmail.com>
Subject: Re: [Patch v3 9/9] KVM: x86/mmu: Reduce default cache size in KVM
 from 40 to PT64_ROOT_MAX_LEVEL
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 21, 2022 at 6:35 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE is set to 40 without any specific
> reason. Reduce default size to PT64_ROOT_MAX_LEVEL, which is currently
> 5.
>
> Change mmu_pte_list_desc_cache size to what is needed as it is more than
> 5 but way less than 40.

Why do you say more than 5? At least to resolve a page fault we'll
never need more than 4 pages on a system with 5 level paging since the
root is already allocated.

>
> Tested by running dirty_log_perf_test on both tdp and shadow MMU with 48
> vcpu and 2GB/vcpu size on a 2 NUMA node machine. No impact on
> performance noticed.
>
> Ran perf on dirty_log_perf_test and found kvm_mmu_get_free_page() calls
> reduced by ~3300 which is near to 48 (vcpus) * 2 (nodes) * 35 (cache
> size).
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/x86/include/asm/kvm_types.h | 2 +-
>  arch/x86/kvm/mmu/mmu.c           | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
> index 08f1b57d3b62..752dab218a62 100644
> --- a/arch/x86/include/asm/kvm_types.h
> +++ b/arch/x86/include/asm/kvm_types.h
> @@ -2,6 +2,6 @@
>  #ifndef _ASM_X86_KVM_TYPES_H
>  #define _ASM_X86_KVM_TYPES_H
>
> -#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
> +#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE PT64_ROOT_MAX_LEVEL

Please add a comment explaining why this value was chosen.

>
>  #endif /* _ASM_X86_KVM_TYPES_H */
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7454bfc49a51..f89d933ff380 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -677,11 +677,12 @@ static int mmu_topup_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
>
>  static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
>  {
> -       int r, nid;
> +       int r, nid, desc_capacity;
>
>         /* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
> -       r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> -                                      1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
> +       desc_capacity = 1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM;
> +       r = __kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> +                                        desc_capacity, desc_capacity);
>         if (r)
>                 return r;
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
