Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF3661611
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjAHPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjAHPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 10:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DFFC777
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673190866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KrNzL9H0g0To9mb4Yi3WrwmErBqjyBobKqupLVMbqzk=;
        b=KrZPtTfvFBIi9Oo2FfTT8JVKcn+QDbk2R5doWylxh0SkzbFzDptJJT+MUWbh989ZvohG//
        DKVM/Rm+bnyU7FlaC5f9skdAfO8L2Zapg3bePwj54rdN2zs6o5u0B76QwfZ/TZrrMTsy5c
        BNaUDrPYEurlHgdTtEmBvgLn6xVJQxk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-xFMIqZQHPU-fxp8wdTlXug-1; Sun, 08 Jan 2023 10:14:23 -0500
X-MC-Unique: xFMIqZQHPU-fxp8wdTlXug-1
Received: by mail-ed1-f71.google.com with SMTP id i8-20020a05640242c800b004852914ce42so3851144edc.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 07:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrNzL9H0g0To9mb4Yi3WrwmErBqjyBobKqupLVMbqzk=;
        b=C8X3uxkBQhVCJxVJzEHHqUezWaN3m4JuRhKOHD0OJRsFhpgCpkNqBnGBzWUGeToDoO
         TnTO84jIgYImHX396SNSIm4K6t65qWRCHQybRDA8EbQl2cdLkMyYwmTykL3qUSzWgooK
         gz8tt5Mk7OcQoyUhid7Cu/Fs+a7TruBCzqe61CKDvbAFoyli15yDmUW1sMoRcJlpOxSg
         hhHRBPWFLTzkUBoWp+cfIOaVNiUWF8P4K+wB7IA7QzhXrJJ+M0AkCBrkcAd7b7VyPBUI
         Y7sUfTJ7pWtCljo/muuJuXFD7/j/Os8rA5OgdAQLRhBdfqJMACm5WDe69lZT7D+A3t0K
         7K8w==
X-Gm-Message-State: AFqh2koIrx4f7/3Y1SYj0pdVf0naMp3rxUW/2DzXoRxTddDTTYA5Z/ZN
        MxXBpAEF51kLmgf3kgSyWLJBf4uRFjn9xMgM1ZSY3+bXM+WVKnoH4E+x9oq5DVOkcyDtVBo87wx
        l7uL3PzCIzA8JOQkiRvg7L5kZ
X-Received: by 2002:a17:907:8c81:b0:7c0:d0ba:e81f with SMTP id td1-20020a1709078c8100b007c0d0bae81fmr53863834ejc.1.1673190862026;
        Sun, 08 Jan 2023 07:14:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9iaEJPvVwmfapV0HLjb73fKtadS4wUOlymKcJXMLyxWWx8abIXcqGv7iMRtlcfKokkJx3jw==
X-Received: by 2002:a17:907:8c81:b0:7c0:d0ba:e81f with SMTP id td1-20020a1709078c8100b007c0d0bae81fmr53863819ejc.1.1673190861834;
        Sun, 08 Jan 2023 07:14:21 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0084767d40f0dsm2587338ejf.115.2023.01.08.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 07:14:21 -0800 (PST)
Message-ID: <b7f42f539bbaf7cc03b748d60a796078bb01c3f8.camel@redhat.com>
Subject: Re: [PATCH v5 18/33] KVM: x86: Explicitly track all possibilities
 for APIC map's logical modes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>,
        Greg Edwards <gedwards@ddn.com>
Date:   Sun, 08 Jan 2023 17:14:19 +0200
In-Reply-To: <20230106011306.85230-19-seanjc@google.com>
References: <20230106011306.85230-1-seanjc@google.com>
         <20230106011306.85230-19-seanjc@google.com>
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

On Fri, 2023-01-06 at 01:12 +0000, Sean Christopherson wrote:
> Track all possibilities for the optimized APIC map's logical modes
> instead of overloading the pseudo-bitmap and treating any "unknown" value
> as "invalid".
> 
> As documented by the now-stale comment above the mode values, the values
> did have meaning when the optimized map was originally added.  That
> dependent logical was removed by commit e45115b62f9a ("KVM: x86: use
> physical LAPIC array for logical x2APIC"), but the obfuscated behavior
> and its comment were left behind.
> 
> Opportunistically rename "mode" to "logical_mode", partly to make it
> clear that the "disabled" case applies only to the logical map, but also
> to prove that there is no lurking code that expects "mode" to be a bitmap.
> 
> Functionally, this is a glorified nop.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 29 ++++++++++++++++--------
>  arch/x86/kvm/lapic.c            | 40 ++++++++++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1d92c148e799..732421a0ad02 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1022,19 +1022,30 @@ struct kvm_arch_memory_slot {
>  };
>  
>  /*
> - * We use as the mode the number of bits allocated in the LDR for the
> - * logical processor ID.  It happens that these are all powers of two.
> - * This makes it is very easy to detect cases where the APICs are
> - * configured for multiple modes; in that case, we cannot use the map and
> - * hence cannot use kvm_irq_delivery_to_apic_fast either.
> + * Track the mode of the optimized logical map, as the rules for decoding the
> + * destination vary per mode.  Enabling the optimized logical map requires all
> + * software-enabled local APIs to be in the same mode, each addressable APIC to
> + * be mapped to only one MDA, and each MDA to map to at most one APIC.
>   */
> -#define KVM_APIC_MODE_XAPIC_CLUSTER          4
> -#define KVM_APIC_MODE_XAPIC_FLAT             8
> -#define KVM_APIC_MODE_X2APIC                16
> +enum kvm_apic_logical_mode {
> +	/* All local APICs are software disabled. */
> +	KVM_APIC_MODE_SW_DISABLED,
> +	/* All software enabled local APICs in xAPIC cluster addressing mode. */
> +	KVM_APIC_MODE_XAPIC_CLUSTER,
> +	/* All software enabled local APICs in xAPIC flat addressing mode. */
> +	KVM_APIC_MODE_XAPIC_FLAT,
> +	/* All software enabled local APICs in x2APIC mode. */
> +	KVM_APIC_MODE_X2APIC,
> +	/*
> +	 * Optimized map disabled, e.g. not all local APICs in the same logical
> +	 * mode, same logical ID assigned to multiple APICs, etc.
> +	 */
> +	KVM_APIC_MODE_MAP_DISABLED,
> +};
>  
>  struct kvm_apic_map {
>  	struct rcu_head rcu;
> -	u8 mode;
> +	enum kvm_apic_logical_mode logical_mode;
>  	u32 max_apic_id;
>  	union {
>  		struct kvm_lapic *xapic_flat_map[8];
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 2aee712e42bb..2567998b692c 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -168,7 +168,12 @@ static bool kvm_use_posted_timer_interrupt(struct kvm_vcpu *vcpu)
>  
>  static inline bool kvm_apic_map_get_logical_dest(struct kvm_apic_map *map,
>  		u32 dest_id, struct kvm_lapic ***cluster, u16 *mask) {
> -	switch (map->mode) {
> +	switch (map->logical_mode) {
> +	case KVM_APIC_MODE_SW_DISABLED:
> +		/* Arbitrarily use the flat map so that @cluster isn't NULL. */
> +		*cluster = map->xapic_flat_map;
> +		*mask = 0;
> +		return true;
>  	case KVM_APIC_MODE_X2APIC: {
>  		u32 offset = (dest_id >> 16) * 16;
>  		u32 max_apic_id = map->max_apic_id;
> @@ -193,8 +198,10 @@ static inline bool kvm_apic_map_get_logical_dest(struct kvm_apic_map *map,
>  		*cluster = map->xapic_cluster_map[(dest_id >> 4) & 0xf];
>  		*mask = dest_id & 0xf;
>  		return true;
> +	case KVM_APIC_MODE_MAP_DISABLED:
> +		return false;
>  	default:
> -		/* Not optimized. */
> +		WARN_ON_ONCE(1);
>  		return false;
>  	}
>  }
> @@ -256,10 +263,12 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  		goto out;
>  
>  	new->max_apic_id = max_id;
> +	new->logical_mode = KVM_APIC_MODE_SW_DISABLED;
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct kvm_lapic *apic = vcpu->arch.apic;
>  		struct kvm_lapic **cluster;
> +		enum kvm_apic_logical_mode logical_mode;
>  		u16 mask;
>  		u32 ldr;
>  		u8 xapic_id;
> @@ -282,7 +291,8 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
>  			new->phys_map[xapic_id] = apic;
>  
> -		if (!kvm_apic_sw_enabled(apic))
> +		if (new->logical_mode == KVM_APIC_MODE_MAP_DISABLED ||
> +		    !kvm_apic_sw_enabled(apic))
>  			continue;
>  
>  		ldr = kvm_lapic_get_reg(apic, APIC_LDR);
> @@ -290,17 +300,31 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  			continue;
>  
>  		if (apic_x2apic_mode(apic)) {
> -			new->mode |= KVM_APIC_MODE_X2APIC;
> +			logical_mode = KVM_APIC_MODE_X2APIC;
>  		} else {
>  			ldr = GET_APIC_LOGICAL_ID(ldr);
>  			if (kvm_lapic_get_reg(apic, APIC_DFR) == APIC_DFR_FLAT)
> -				new->mode |= KVM_APIC_MODE_XAPIC_FLAT;
> +				logical_mode = KVM_APIC_MODE_XAPIC_FLAT;
>  			else
> -				new->mode |= KVM_APIC_MODE_XAPIC_CLUSTER;
> +				logical_mode = KVM_APIC_MODE_XAPIC_CLUSTER;
>  		}
>  
> -		if (!kvm_apic_map_get_logical_dest(new, ldr, &cluster, &mask))
> +		/*
> +		 * To optimize logical mode delivery, all software-enabled APICs must
> +		 * be configured for the same mode.
> +		 */
> +		if (new->logical_mode == KVM_APIC_MODE_SW_DISABLED) {
> +			new->logical_mode = logical_mode;
> +		} else if (new->logical_mode != logical_mode) {
> +			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
>  			continue;
> +		}
> +
> +		if (WARN_ON_ONCE(!kvm_apic_map_get_logical_dest(new, ldr,
> +								&cluster, &mask))) {
> +			new->logical_mode = KVM_APIC_MODE_MAP_DISABLED;
> +			continue;
> +		}
>  
>  		if (mask)
>  			cluster[ffs(mask) - 1] = apic;
> @@ -953,7 +977,7 @@ static bool kvm_apic_is_broadcast_dest(struct kvm *kvm, struct kvm_lapic **src,
>  {
>  	if (kvm->arch.x2apic_broadcast_quirk_disabled) {
>  		if ((irq->dest_id == APIC_BROADCAST &&
> -				map->mode != KVM_APIC_MODE_X2APIC))
> +		     map->logical_mode != KVM_APIC_MODE_X2APIC))
>  			return true;
>  		if (irq->dest_id == X2APIC_BROADCAST)
>  			return true;


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

