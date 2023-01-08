Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6366162D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjAHP0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjAHP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFEDF84
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673191521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGRGERS1pM1Gi3AfdWwFptRcpogrHSdydnux2SdNHG8=;
        b=MOkhqDctrWFaAr/LCSz6msjXXog2Kuo73SRnlEFfqn3XrRBhQchuhmCdaAULiM2DWRXCY8
        t54e0ifbtYcnr8HwD+2g9d6llDr5Uudn2K5B/hdELSeXaFYVdq7nlD0oCbwaRSKG4VS2XQ
        eDcxNqOxoAW8OoTBDfvvN7ml4FfWoK0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-R-yZx6DpNdasc5cyqtHNRA-1; Sun, 08 Jan 2023 10:25:20 -0500
X-MC-Unique: R-yZx6DpNdasc5cyqtHNRA-1
Received: by mail-ed1-f70.google.com with SMTP id q10-20020a056402518a00b0048e5bc8cb74so3906550edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGRGERS1pM1Gi3AfdWwFptRcpogrHSdydnux2SdNHG8=;
        b=HWzVn0US+4peKqKPHPVZOk+45+Wfs9QMlez6w4+tvs+boHdyK0nTPm8sLogcCitmnm
         ze1OkMzDwXIPyq6W7iRACL91oYxcAO1OmiyojmJOMHqc4iW3GeuKzJx6NaU+lTdWX7Ev
         AgAdS8rEmUTEg9G+kFsVEUgR9AyeOZS7hdZHovM2RllEjLKVfRGXuEnFhXktQgXnY9M/
         w4cTCfhPpE+5fBlUz8HjcgLLZqPcx6+IEzE++0sziCZZZIqp/YY0SvRoXSUFS04xDdrg
         xX493eqbykf22LTY81x1rCw4t3M4EBXjoQQ0jz2U7DuXpzOkORVch/KuOFijd0Gu+rFX
         2XvA==
X-Gm-Message-State: AFqh2kqCD0qb7wpFMDf19pbM2ELQtitmID5EYqHjTqdOIYipVqNsX1lx
        Wx4SZI3VvdVRpPdK84T6Zq4keW+th2CFlIMwEgP0WVjHNjU+jJQGGzUmF0loO9ur1Z1IpeXmdu7
        S2bKB2x7UGqLwmgwhuYPPuCh5
X-Received: by 2002:a05:6402:4503:b0:472:d867:4c3d with SMTP id ez3-20020a056402450300b00472d8674c3dmr58810916edb.40.1673191514291;
        Sun, 08 Jan 2023 07:25:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt9YYtWaiBfe0XlKU9peNOP3IJc+PMlawAQRGoYQ59AJ4l+xQbDd386XEKXu+q3oqpYdx3kiA==
X-Received: by 2002:a05:6402:4503:b0:472:d867:4c3d with SMTP id ez3-20020a056402450300b00472d8674c3dmr58810904edb.40.1673191514085;
        Sun, 08 Jan 2023 07:25:14 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id c39-20020a509faa000000b00483cccdfeaesm2685044edf.38.2023.01.08.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:25:13 -0800 (PST)
Message-ID: <f417ca6883f3549350a9b379d993f1fd589ab503.camel@redhat.com>
Subject: Re: [PATCH v5 32/33] KVM: x86: Allow APICv APIC ID inhibit to be
 cleared
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
Date:   Sun, 08 Jan 2023 17:25:11 +0200
In-Reply-To: <20230106011306.85230-33-seanjc@google.com>
References: <20230106011306.85230-1-seanjc@google.com>
         <20230106011306.85230-33-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-06 at 01:13 +0000, Sean Christopherson wrote:
> From: Greg Edwards <gedwards@ddn.com>
> 
> Legacy kernels prior to commit 4399c03c6780 ("x86/apic: Remove
> verify_local_APIC()") write the APIC ID of the boot CPU twice to verify
> a functioning local APIC.  This results in APIC acceleration inhibited
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
> Link: https://lore.kernel.org/r/20221117183247.94314-1-gedwards@ddn.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0faf80cdc1be..856e81a2dc64 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -236,6 +236,7 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  	struct kvm_vcpu *vcpu;
>  	unsigned long i;
>  	u32 max_id = 255; /* enough space for any xAPIC ID */
> +	bool xapic_id_mismatch = false;
>  
>  	/* Read kvm->arch.apic_map_dirty before kvm->arch.apic_map.  */
>  	if (atomic_read_acquire(&kvm->arch.apic_map_dirty) == CLEAN)
> @@ -285,6 +286,15 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  		xapic_id = kvm_xapic_id(apic);
>  		x2apic_id = kvm_x2apic_id(apic);
>  
> +		/*
> +		 * Deliberately truncate the vCPU ID when detecting a mismatched
> +		 * APIC ID to avoid false positives if the vCPU ID, i.e. x2APIC
> +		 * ID, is a 32-bit value.  Any unwanted aliasing due to
> +		 * truncation results will be detected below.
> +		 */
> +		if (!apic_x2apic_mode(apic) && xapic_id != (u8)vcpu->vcpu_id)
> +			xapic_id_mismatch = true;
> +
>  		/*
>  		 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC
>  		 * IDs.  Allow sending events to vCPUs by their x2APIC ID even
> @@ -401,6 +411,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  	else
>  		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
>  
> +	if (xapic_id_mismatch)
> +		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> +	else
> +		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> +
>  	old = rcu_dereference_protected(kvm->arch.apic_map,
>  			lockdep_is_held(&kvm->arch.apic_map_lock));
>  	rcu_assign_pointer(kvm->arch.apic_map, new);
> @@ -2160,28 +2175,6 @@ static void apic_manage_nmi_watchdog(struct kvm_lapic *apic, u32 lvt0_val)
>  	}
>  }
>  
> -static void kvm_lapic_xapic_id_updated(struct kvm_lapic *apic)
> -{
> -	struct kvm *kvm = apic->vcpu->kvm;
> -
> -	if (!kvm_apic_hw_enabled(apic))
> -		return;
> -
> -	if (KVM_BUG_ON(apic_x2apic_mode(apic), kvm))
> -		return;
> -
> -	/*
> -	 * Deliberately truncate the vCPU ID when detecting a modified APIC ID
> -	 * to avoid false positives if the vCPU ID, i.e. x2APIC ID, is a 32-bit
> -	 * value.  If the wrap/truncation results in unwanted aliasing, APICv
> -	 * will be inhibited as part of updating KVM's optimized APIC maps.
> -	 */
> -	if (kvm_xapic_id(apic) == (u8)apic->vcpu->vcpu_id)
> -		return;
> -
> -	kvm_set_apicv_inhibit(apic->vcpu->kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> -}
> -
>  static int get_lvt_index(u32 reg)
>  {
>  	if (reg == APIC_LVTCMCI)
> @@ -2202,7 +2195,6 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>  	case APIC_ID:		/* Local APIC ID */
>  		if (!apic_x2apic_mode(apic)) {
>  			kvm_apic_set_xapic_id(apic, val >> 24);
> -			kvm_lapic_xapic_id_updated(apic);
>  		} else {
>  			ret = 1;
>  		}
> @@ -2923,9 +2915,6 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>  	}
>  	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
>  
> -	if (!apic_x2apic_mode(apic))
> -		kvm_lapic_xapic_id_updated(apic);
> -
>  	atomic_set_release(&apic->vcpu->kvm->arch.apic_map_dirty, DIRTY);
>  	kvm_recalculate_apic_map(vcpu->kvm);
>  	kvm_apic_set_version(vcpu);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


