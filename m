Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0B636FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKXBSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKXBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:18:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7951025D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669252627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LgKeLR3l+O3tHlukn5xyFc3fzOtotvhAO14T/Dt6X8=;
        b=dDzGFykb4NWBqlSCPjiv4qku1QvTrSlDuMpnH1PLCm8EL7oFyhRiKtFhZ2DYrB2nsxTrSn
        U+FHw61eI4Ev3TpxJM0cREnLfpxcO9KdWGLPHoCo6zmUBZhOz5ni0LmwD7vSN9bbpm5WgN
        92XSexgpE99KG18vE80G4MHZTRLMTOo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-294-izuNfV0tOmaPpvcE81yrew-1; Wed, 23 Nov 2022 20:17:06 -0500
X-MC-Unique: izuNfV0tOmaPpvcE81yrew-1
Received: by mail-vk1-f197.google.com with SMTP id b127-20020a1f3485000000b003b8a69e5b11so95317vka.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LgKeLR3l+O3tHlukn5xyFc3fzOtotvhAO14T/Dt6X8=;
        b=HCGgGCPiZAqc5hmzZiyemMQeLb+XhJ1NHU+nqyYwrMKL8ICM9z5rhMX6yq5xT75hOD
         /WlTJk7YkHtVsbjnbp6ioROtygmzoObiHeNXy/bPY0v5o0m7FnXx2xHP38OR0UQRBLZN
         Fj4Rpicj8mCwIz7Y3pQKjWRv7YfGeUcYxYSD3HWD4cLC0LWz0w0jdN15xiKp5P5plgA6
         toLZxSsac2v2tgq7KCBo8i8pdym+Z4Wi0/gHJfSDrx1bI9hjzvvCXkQC5prVtv3ILole
         jF9EcedHNPjQmPqFqtJF5Eaan1wYNOmccEE9zABj3VHxVWVMFBkTormnzOK2Fg1llAyt
         kPGw==
X-Gm-Message-State: ANoB5pnJxQ1k5Xxc2NKorK0yr9Gduv+7zbAoVbm/D6HnNl3lhhmjuCjI
        N4m33ZWYA+TZ2iyDn36+FSsFYkGdMYKSjMt+UcPGyNedD3q2vUE/AUm2p2sl769mGf8IvsTMvP5
        bdZDl3yQheVpVJ2WsrNC8GtQngpbaYbB3Xl+MahPw
X-Received: by 2002:ac5:c915:0:b0:3bc:2476:f74a with SMTP id t21-20020ac5c915000000b003bc2476f74amr18263296vkl.19.1669252625519;
        Wed, 23 Nov 2022 17:17:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7S6OMh4owQUkHVV6dj/x+6Lvwp9mc0zf8jF8waIlN3tuHt/t1kLF519/UU/Edk4i+2Oxdspva5ZVKyb5EYCmM=
X-Received: by 2002:ac5:c915:0:b0:3bc:2476:f74a with SMTP id
 t21-20020ac5c915000000b003bc2476f74amr18263286vkl.19.1669252625226; Wed, 23
 Nov 2022 17:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20221124003505.424617-1-mizhang@google.com>
In-Reply-To: <20221124003505.424617-1-mizhang@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 24 Nov 2022 02:16:54 +0100
Message-ID: <CABgObfYpn98X2NFhoWNAPuyu_NtmovKD5MHoon0gtVP08Su0eA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] KVM: x86/mmu: replace BUG() with KVM_BUG() in
 shadow mmu
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> v1 -> v2:
>  - compile test the code.
>  - fill KVM_BUG() with kvm_get_running_vcpu()->kvm

Nope, the zapping code paths will run often with no running vCPU, for
example drop_parent_pte <- kvm_mmu_unlink_parents <-
__kvm_mmu_prepare_zap_page <- kvm_zap_obsolete_pages <-
kvm_mmu_zap_all_fast <- kvm_mmu_invalidate_zap_pages_in_memslot <-
kvm_page_track_flush_slot <- kvm_arch_flush_shadow_memslot <-
kvm_invalidate_memslot <- ioctl(KVM_SET_USER_MEMORY_REGION).

Paolo

> v1:
> https://lore.kernel.org/all/20221123231206.274392-1-mizhang@google.com/
>
> Cc: Nagareddy Reddy <nspreddy@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4736d7849c60..f3b307c588ac 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -955,12 +955,12 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
>
>         if (!rmap_head->val) {
>                 pr_err("%s: %p 0->BUG\n", __func__, spte);
> -               BUG();
> +               KVM_BUG(true, kvm_get_running_vcpu()->kvm, "");
>         } else if (!(rmap_head->val & 1)) {
>                 rmap_printk("%p 1->0\n", spte);
>                 if ((u64 *)rmap_head->val != spte) {
>                         pr_err("%s:  %p 1->BUG\n", __func__, spte);
> -                       BUG();
> +                       KVM_BUG(true, kvm_get_running_vcpu()->kvm, "");
>                 }
>                 rmap_head->val = 0;
>         } else {
> @@ -979,7 +979,7 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
>                         desc = desc->more;
>                 }
>                 pr_err("%s: %p many->many\n", __func__, spte);
> -               BUG();
> +               KVM_BUG(true, kvm_get_running_vcpu()->kvm, "");
>         }
>  }
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

