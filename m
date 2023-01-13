Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2D66A157
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjAMR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjAMR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:59:25 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490AC8D386
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:52:20 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t15so23278852ybq.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uBw89FU9UBpNOcN/n5tNPwSFMn3YhdoihkTziL0Dvbo=;
        b=BfzyxH4VporMuNHWhb+dZbaHSPEl9xGOc/rSIBcSg9i67lbPstTJZ0rj227naupP8p
         L8Re3drnraxXM+CItCIfqMXDtjqbRGCHbOX0KZhdLlqVWkt9qvMkHb1p/FNLkJOO8dT3
         TgUYA9GgCOTcV0f6aX9vLB5r2+NITMf9/f/tGELhefImj/oNcP15cO5htpnS1fFPw25U
         /2DWNbt6Ja5CEPOPwwCF5ueywByUjjRQ9WXqdMCLAa/IgOuuogm5nRfBrmmDdXBGGVta
         wqdUqC+mNtY+q1/SrKbMh/kLKrVUU7Gl30hZDEnHQCCfiYrUsrwpred4sNp/B8B6Wbc0
         BMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBw89FU9UBpNOcN/n5tNPwSFMn3YhdoihkTziL0Dvbo=;
        b=iZwtx6l+ugzBd3qdBRfmAj+pAZNdisD8tMNyOhmAXTSQJzw+xJrSh3DxKGj1NglIpL
         0fI/B7wxJA6Ffb2+lUU+okCSpG4A0zKdPfLBkfLBuzG/Jmc8c1i7c22UEoxCmtCugSYN
         37pzI8AKbfYEJnwLXj3dWd5lvRgDzOycL0xjY5S2QE2v4ATjfFj0ZO6uX+/53nF+ED5Y
         FmxaXAqHLcEOD+l5vdyDK2aFKsaV5cHV9T6oGftOWw3SM+o2XUQYP5l6zxy3FMkquS4H
         rTcjCzC/50KongkhwrTX5x3lWb4iErpohyOp9a3h1iw6V6KbA4NQmpWnSi5Vw4TFbOFY
         5+Ow==
X-Gm-Message-State: AFqh2krM7pzhSsDrNIZn7+A6yaKARybroeSE8EIr3MnwyLCT61rRj6do
        BGj5UZRz9U72toUoksfOWkM3swg8KV3F3ZpYFDp1cg==
X-Google-Smtp-Source: AMrXdXvYN+uQtXM83ZOVJrgdDH7vZrt250uxujTe5BRq5UwAUrIE5JvOi/LNvWsGH+A96modUUeNRZFLOxJNXZ6z9aM=
X-Received: by 2002:a25:7355:0:b0:7d2:a7e9:ece5 with SMTP id
 o82-20020a257355000000b007d2a7e9ece5mr71427ybc.132.1673632339085; Fri, 13 Jan
 2023 09:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com> <20221221222418.3307832-8-bgardon@google.com>
In-Reply-To: <20221221222418.3307832-8-bgardon@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 13 Jan 2023 09:51:43 -0800
Message-ID: <CAHVum0dP8PaKGVsg9=9xawj2dOtBnq0YX-SSQ6kkmEjvk4yKKA@mail.gmail.com>
Subject: Re: [RFC 07/14] KVM: x86/MMU: Cleanup shrinker interface with Shadow MMU
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Nagareddy Reddy <nspreddy@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 21, 2022 at 2:24 PM Ben Gardon <bgardon@google.com> wrote:
>
> The MMU shrinker currently only operates on the Shadow MMU, but having
> the entire implemenatation in shadow_mmu.c is awkward since much of the
> function isn't Shadow MMU specific. There has also been talk of changing the
> target of the shrinker to the MMU caches rather than already allocated page
> tables. As a result, it makes sense to move some of the implementation back
> to mmu.c.
>
> No functional change intended.
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c        | 43 ++++++++++++++++++++++++
>  arch/x86/kvm/mmu/shadow_mmu.c | 62 ++++++++---------------------------
>  arch/x86/kvm/mmu/shadow_mmu.h |  3 +-
>  3 files changed, 58 insertions(+), 50 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index dd97e346c786..4c45a5b63356 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3147,6 +3147,49 @@ static unsigned long mmu_shrink_count(struct shrinker *shrink,
>         return percpu_counter_read_positive(&kvm_total_used_mmu_pages);
>  }
>
> +unsigned long mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> +{
> +       struct kvm *kvm;
> +       int nr_to_scan = sc->nr_to_scan;
> +       unsigned long freed = 0;
> +
> +       mutex_lock(&kvm_lock);
> +
> +       list_for_each_entry(kvm, &vm_list, vm_list) {
> +               /*
> +                * Never scan more than sc->nr_to_scan VM instances.
> +                * Will not hit this condition practically since we do not try
> +                * to shrink more than one VM and it is very unlikely to see
> +                * !n_used_mmu_pages so many times.
> +                */
> +               if (!nr_to_scan--)
> +                       break;
> +
> +               /*
> +                * n_used_mmu_pages is accessed without holding kvm->mmu_lock
> +                * here. We may skip a VM instance errorneosly, but we do not
> +                * want to shrink a VM that only started to populate its MMU
> +                * anyway.
> +                */
> +               if (!kvm->arch.n_used_mmu_pages &&
> +                   !kvm_shadow_mmu_has_zapped_obsolete_pages(kvm))
> +                       continue;
> +
> +               freed = kvm_shadow_mmu_shrink_scan(kvm, sc->nr_to_scan);
> +
> +               /*
> +                * unfair on small ones
> +                * per-vm shrinkers cry out
> +                * sadness comes quickly
> +                */
> +               list_move_tail(&kvm->vm_list, &vm_list);
> +               break;
> +       }
> +
> +       mutex_unlock(&kvm_lock);
> +       return freed;
> +}
> +
>  static struct shrinker mmu_shrinker = {
>         .count_objects = mmu_shrink_count,
>         .scan_objects = mmu_shrink_scan,
> diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
> index 090b4788f7de..1259c4a3b140 100644
> --- a/arch/x86/kvm/mmu/shadow_mmu.c
> +++ b/arch/x86/kvm/mmu/shadow_mmu.c
> @@ -3147,7 +3147,7 @@ void kvm_zap_obsolete_pages(struct kvm *kvm)
>         kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
>  }
>
> -static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
> +bool kvm_shadow_mmu_has_zapped_obsolete_pages(struct kvm *kvm)

Function renaming and removing static should be two separate commits.

>  {
>         return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
>  }
> @@ -3416,60 +3416,24 @@ void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
>                 kvm_arch_flush_remote_tlbs_memslot(kvm, slot);
>  }
>
> -unsigned long mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> +unsigned long kvm_shadow_mmu_shrink_scan(struct kvm *kvm, int pages_to_free)
>  {
> -       struct kvm *kvm;
> -       int nr_to_scan = sc->nr_to_scan;
>         unsigned long freed = 0;
> +       int idx;
>
> -       mutex_lock(&kvm_lock);
> -
> -       list_for_each_entry(kvm, &vm_list, vm_list) {
> -               int idx;
> -               LIST_HEAD(invalid_list);
> -
> -               /*
> -                * Never scan more than sc->nr_to_scan VM instances.
> -                * Will not hit this condition practically since we do not try
> -                * to shrink more than one VM and it is very unlikely to see
> -                * !n_used_mmu_pages so many times.
> -                */
> -               if (!nr_to_scan--)
> -                       break;
> -               /*
> -                * n_used_mmu_pages is accessed without holding kvm->mmu_lock
> -                * here. We may skip a VM instance errorneosly, but we do not
> -                * want to shrink a VM that only started to populate its MMU
> -                * anyway.
> -                */
> -               if (!kvm->arch.n_used_mmu_pages &&
> -                   !kvm_has_zapped_obsolete_pages(kvm))
> -                       continue;
> -
> -               idx = srcu_read_lock(&kvm->srcu);
> -               write_lock(&kvm->mmu_lock);
> -
> -               if (kvm_has_zapped_obsolete_pages(kvm)) {
> -                       kvm_mmu_commit_zap_page(kvm,
> -                             &kvm->arch.zapped_obsolete_pages);
> -                       goto unlock;
> -               }
> +       idx = srcu_read_lock(&kvm->srcu);
> +       write_lock(&kvm->mmu_lock);
>
> -               freed = kvm_mmu_zap_oldest_mmu_pages(kvm, sc->nr_to_scan);
> +       if (kvm_shadow_mmu_has_zapped_obsolete_pages(kvm)) {
> +               kvm_mmu_commit_zap_page(kvm, &kvm->arch.zapped_obsolete_pages);
> +               goto out;
> +       }
>
> -unlock:
> -               write_unlock(&kvm->mmu_lock);
> -               srcu_read_unlock(&kvm->srcu, idx);
> +       freed = kvm_mmu_zap_oldest_mmu_pages(kvm, pages_to_free);
>
> -               /*
> -                * unfair on small ones
> -                * per-vm shrinkers cry out
> -                * sadness comes quickly
> -                */
> -               list_move_tail(&kvm->vm_list, &vm_list);
> -               break;
> -       }
> +out:
> +       write_unlock(&kvm->mmu_lock);
> +       srcu_read_unlock(&kvm->srcu, idx);
>
> -       mutex_unlock(&kvm_lock);
>         return freed;
>  }
> diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
> index 20c65a0ea52c..9952aa1e86cf 100644
> --- a/arch/x86/kvm/mmu/shadow_mmu.h
> +++ b/arch/x86/kvm/mmu/shadow_mmu.h
> @@ -99,7 +99,8 @@ void kvm_shadow_mmu_try_split_huge_pages(struct kvm *kvm,
>  void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
>                                     const struct kvm_memory_slot *slot);
>
> -unsigned long mmu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc);
> +bool kvm_shadow_mmu_has_zapped_obsolete_pages(struct kvm *kvm);
> +unsigned long kvm_shadow_mmu_shrink_scan(struct kvm *kvm, int pages_to_free);
>
>  /* Exports from paging_tmpl.h */
>  gpa_t paging32_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> --
> 2.39.0.314.g84b9a713c41-goog
>
