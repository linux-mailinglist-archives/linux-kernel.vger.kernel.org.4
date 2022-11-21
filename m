Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56B46327C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiKUPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKUPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:21:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBA9DBA3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669043892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWzLboUVaaSQBKudGWmScz/emJJTGhEhKaSsizNUtHA=;
        b=JCzhrYckysBgYTmxhkes0awgEv3wAtWirHgqctp1N8qxL0yVBVh8jU+80PAyvCCkh8aMiV
        vRVFEDp8Tb1h70vzBdfPGk2z4AEj5voTc6TT3pzZM5d+3GaxbWvuHASMBYzehP3eRWVLyG
        9sSGseZoa1PpB07mznCV2QcTr/Q31HM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-466-MErn0cdCOWqYUJUR4NFRjg-1; Mon, 21 Nov 2022 10:18:09 -0500
X-MC-Unique: MErn0cdCOWqYUJUR4NFRjg-1
Received: by mail-wr1-f71.google.com with SMTP id e21-20020adfa455000000b00241daf5b9b2so836658wra.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWzLboUVaaSQBKudGWmScz/emJJTGhEhKaSsizNUtHA=;
        b=Zm6t/B+ZZmZ1Cw0L6/S37z6HrsgelW+RFR4nCVa1vOpIiy4Tn3jHViKdmvjfe9pL1l
         bwdcHSRvrjOGzoIu+cds7sHotu7oQK6MGYmnPSIQoXQlbmEGYR/Z7AunwKC6wBTQROqj
         hx+/H2ewEmDi/X0O4ZAI/1QyhgwJ2qgjrcs74SNvc89Sx2wJdvk7ctQpT8z/fkxyRSnA
         7cDj/sLWWi5gRmCjV3ub8K6I1hdi0qoEK0kKKQShfrOcljsXNNhv1V26Ykm8Git/y7uB
         41iYGyFzvVU3P/Pte6m7NQjrUImlEq3eTQyEDvm4lTHGWKJMOx6FUk1qyo9fcvXLrmQL
         ankA==
X-Gm-Message-State: ANoB5pljn235W2LUVEzRiqutDlBvbB83yiu1hFH236pGh4WlAiQVi0Dv
        +wCu3R2yug5dM48WCEnPdp/x8SQ0nDmJstbeEnpGbdhzsKXMeWIXtU6YXeEWgGeuZAfu3zjeR7r
        rXC899uj3q6YKuUH4HkZYw0xZ
X-Received: by 2002:a5d:4d8b:0:b0:241:bf7b:db5b with SMTP id b11-20020a5d4d8b000000b00241bf7bdb5bmr9361002wru.267.1669043887447;
        Mon, 21 Nov 2022 07:18:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7W7hS2PAbvhVoDxfYm/gMb2yAVzOuUX6eEt4DhS4ID1WqyLI65K8a6qYqLBb7rTEfgcLWUEA==
X-Received: by 2002:a5d:4d8b:0:b0:241:bf7b:db5b with SMTP id b11-20020a5d4d8b000000b00241bf7bdb5bmr9360983wru.267.1669043887169;
        Mon, 21 Nov 2022 07:18:07 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b002366f9bd717sm13805064wrx.45.2022.11.21.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:18:06 -0800 (PST)
Message-ID: <984a2c3f4ace0c2f48ee8d19f20d52d9f2fba8ba.camel@redhat.com>
Subject: Re: [PATCH v3] KVM: x86: Allow APICv APIC ID inhibit to be cleared
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Greg Edwards <gedwards@ddn.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Mon, 21 Nov 2022 17:18:05 +0200
In-Reply-To: <20221117183247.94314-1-gedwards@ddn.com>
References: <20221114202037.254176-1-gedwards@ddn.com>
         <20221117183247.94314-1-gedwards@ddn.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-17 at 11:33 -0700, Greg Edwards wrote:
> Legacy kernels prior to commit 4399c03c6780 ("x86/apic: Remove
> verify_local_APIC()") write the APIC ID of the boot CPU twice to verify
> a functioning local APIC.  This results in APIC acceleration inhibited
> on these kernels for reason APICV_INHIBIT_REASON_APIC_ID_MODIFIED.
> 
> Allow the APICV_INHIBIT_REASON_APIC_ID_MODIFIED inhibit reason to be
> cleared if/when all APICs in xAPIC mode set their APIC ID back to the
> expected vcpu_id value.
> 
> Fold the functionality previously in kvm_lapic_xapic_id_updated() into
> kvm_recalculate_apic_map(), as this allows examining all APICs in one
> pass.
> 
> Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
> Changes from v2:
>   * Comment and variable name tweaks.  [Sean]
> 
> Changes from v1:
>   * Fold kvm_lapic_xapic_id_updated() into kvm_recalculate_apic_map() and
>     verify no APICs in xAPIC mode have a modified APIC ID before clearing
>     APICV_INHIBIT_REASON_APIC_ID_MODIFIED.  [Sean]
>   * Rebase on top of Sean's APIC fixes+cleanups series.  [Sean]
>     https://lore.kernel.org/all/20221001005915.2041642-1-seanjc@google.com/
> 
>  arch/x86/kvm/lapic.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 9b3af49d2524..5224d73cd84a 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -236,6 +236,7 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>         struct kvm_vcpu *vcpu;
>         unsigned long i;
>         u32 max_id = 255; /* enough space for any xAPIC ID */
> +       bool xapic_id_mismatch = false;
>  
>         /* Read kvm->arch.apic_map_dirty before kvm->arch.apic_map.  */
>         if (atomic_read_acquire(&kvm->arch.apic_map_dirty) == CLEAN)
> @@ -285,6 +286,15 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>                 xapic_id = kvm_xapic_id(apic);
>                 x2apic_id = kvm_x2apic_id(apic);
>  
> +               /*
> +                * Deliberately truncate the vCPU ID when detecting a mismatched
> +                * APIC ID to avoid false positives if the vCPU ID, i.e. x2APIC
> +                * ID, is a 32-bit value.  Any unwanted aliasing due to
> +                * truncation results will be detected below.
> +                */
> +               if (!apic_x2apic_mode(apic) && xapic_id != (u8)vcpu->vcpu_id)
> +                       xapic_id_mismatch = true;
> +
>                 /*
>                  * Apply KVM's hotplug hack if userspace has enable 32-bit APIC
>                  * IDs.  Allow sending events to vCPUs by their x2APIC ID even
> @@ -396,6 +406,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>         else
>                 kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
>  
> +       if (xapic_id_mismatch)
> +               kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> +       else
> +               kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> +
>         old = rcu_dereference_protected(kvm->arch.apic_map,
>                         lockdep_is_held(&kvm->arch.apic_map_lock));
>         rcu_assign_pointer(kvm->arch.apic_map, new);
> @@ -2155,28 +2170,6 @@ static void apic_manage_nmi_watchdog(struct kvm_lapic *apic, u32 lvt0_val)
>         }
>  }
>  
> -static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
> -{
> -       struct kvm *kvm = apic->vcpu->kvm;
> -
> -       if (!kvm_apic_hw_enabled(apic))
> -               return;
> -
> -       if (KVM_BUG_ON(apic_x2apic_mode(apic), kvm))
> -               return;
> -
> -       /*
> -        * Deliberately truncate the vCPU ID when detecting a modified APIC ID
> -        * to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a 32-bit
> -        * value.  If the wrap/truncation results in unwatned aliasing, APICv
> -        * will be inhibited as part of updating KVM's optimized APIC maps.
> -        */
> -       if (kvm_xapic_id(apic) == (u8)apic->vcpu->vcpu_id)
> -               return;
> -
> -       kvm_set_apicv_inhibit(apic->vcpu->kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> -}
> -
>  static int get_lvt_index(u32 reg)
>  {
>         if (reg == APIC_LVTCMCI)
> @@ -2197,7 +2190,6 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>         case APIC_ID:           /* Local APIC ID */
>                 if (!apic_x2apic_mode(apic)) {
>                         kvm_apic_set_xapic_id(apic, val >> 24);
> -                       kvm_lapic_xapic_id_updated(apic);
>                 } else {
>                         ret = 1;
>                 }
> @@ -2919,9 +2911,6 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>         }
>         memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
>  
> -       if (!apic_x2apic_mode(vcpu->arch.apic))
> -               kvm_lapic_xapic_id_updated(vcpu->arch.apic);
> -
>         atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
>         kvm_recalculate_apic_map(vcpu->kvm);
>         kvm_apic_set_version(vcpu);


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

