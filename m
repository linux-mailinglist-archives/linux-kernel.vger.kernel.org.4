Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0296E634188
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiKVQaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiKVQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17AE59FE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669134552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwdtA1PmkbyrWPv/XQHsML3IHO6+jEzCfmDUOfk9OE4=;
        b=OXNDHdznhutsW4j7z+wmK8rxZqQKAHXnTNa1bx3LIlVHmPz/fbgCFZbdKPQCXaaBGK6XdW
        dlIiYW72InAvUieDgkl4gFSMUSlRQdL/z38JkcnpJQq41lVAoLC5QlsG4sOhmAXHZ3NkHF
        ymI6cKW94VaV0Zqt3yQWbCglKEJLNjw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-euzusoQ7P1Cl1v_QuVZN3w-1; Tue, 22 Nov 2022 11:29:10 -0500
X-MC-Unique: euzusoQ7P1Cl1v_QuVZN3w-1
Received: by mail-ej1-f71.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso8578112ejc.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwdtA1PmkbyrWPv/XQHsML3IHO6+jEzCfmDUOfk9OE4=;
        b=rjJA7kBqCxicbyja1VGYizZi1Vp+UKiqm7WtCGIEndgBlYg7GI+Qbcwm3DXm1GHzMS
         +ZZJhx0QczYvYdHp9jFlS2i6VmMTvh0UgJOmEcI/NwQ2QORTG5hEMFutg3hdBJnRrAbs
         41qq+vLwiCwPQEDttVQWE+vD4MvQNCD8b8pqjMD4XTgX2poG2WfXx3KlKPk8MxD9txiW
         AZ+gqi1ZoEvcq5jerJEFzIBBQgsqM6iDm6lDUfnuDmQSdUNBV8FKlRE6JTMJr1LAPIee
         f4QUGkkP69jBbEjACiJLenwbzVbAWFhy1d9gBrJQXpY8bSD5PypsPotbPWkniK6ilDru
         UpCQ==
X-Gm-Message-State: ANoB5pnXDIu9pROhPaALBSnCqp4RxqVPPAI9eE78zg7YCMMtTcfJUiz+
        d/G5iu64moUmRIz7nReQIZBgnUCqP94SdBLeNWOJHO+CRKLLhP1DuZ0CnvCod53Us9CYZhStZpT
        TIIs3v4cYkldpyBq67slf2xbZ
X-Received: by 2002:a05:6402:530c:b0:462:df63:5ec5 with SMTP id eo12-20020a056402530c00b00462df635ec5mr21841237edb.147.1669134549305;
        Tue, 22 Nov 2022 08:29:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6DhNXIJEzGUQ6AzqU6LNTuQ8anzitncMbY+mVQLlez5XJW7coOYbHoy0je1vgcf6eBXxZuWA==
X-Received: by 2002:a05:6402:530c:b0:462:df63:5ec5 with SMTP id eo12-20020a056402530c00b00462df635ec5mr21841219edb.147.1669134549055;
        Tue, 22 Nov 2022 08:29:09 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090653d100b007ae9c7b3c45sm6273617ejo.99.2022.11.22.08.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:29:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 2/6] KVM: x86: hyper-v: Add extended hypercall
 support in Hyper-v
In-Reply-To: <20221121234026.3037083-3-vipinsh@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-3-vipinsh@google.com>
Date:   Tue, 22 Nov 2022 17:29:06 +0100
Message-ID: <87bkozosvh.fsf@ovpn-194-185.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin Sharma <vipinsh@google.com> writes:

> Add support for extended hypercall in Hyper-v. Hyper-v TLFS 6.0b
> describes hypercalls above call code 0x8000 as extended hypercalls.
>
> A Hyper-v hypervisor's guest VM finds availability of extended
> hypercalls via CPUID.0x40000003.EBX BIT(20). If the bit is set then the
> guest can call extended hypercalls.
>
> All extended hypercalls will exit to userspace by default. This allows
> for easy support of future hypercalls without being dependent on KVM
> releases.
>
> If there will be need to process the hypercall in KVM instead of
> userspace then KVM can create a capability which userspace can query to
> know which hypercalls can be handled by the KVM and enable handling
> of those hypercalls.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/x86/kvm/hyperv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 0b6964ed2e66..8551ef495cc9 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -43,6 +43,12 @@
>  
>  #define KVM_HV_MAX_SPARSE_VCPU_SET_BITS DIV_ROUND_UP(KVM_MAX_VCPUS, HV_VCPUS_PER_SPARSE_BANK)
>  
> +/*
> + * The TLFS carves out 64 possible extended hypercalls, numbered sequentially
> + * after the base capabilities extended hypercall.
> + */
> +#define HV_EXT_CALL_MAX (HV_EXT_CALL_QUERY_CAPABILITIES + 64)
> +

First, I thought there's an off-by-one here (and should be '63') but
then I checked with TLFS and figured out that the limit comes from
HvExtCallQueryCapabilities's response which doesn't include itself
(0x8001) in the mask, this means it can encode

0x8002 == bit0
0x8003 == bit1
..
0x8041 == bit63

so indeed, the last one supported is 0x8041 == 0x8001 + 64

maybe it's worth extending the commont on where '64' comes from.

>  static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
>  				bool vcpu_kick);
>  
> @@ -2411,6 +2417,9 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
>  	case HVCALL_SEND_IPI:
>  		return hv_vcpu->cpuid_cache.enlightenments_eax &
>  			HV_X64_CLUSTER_IPI_RECOMMENDED;
> +	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
> +		return hv_vcpu->cpuid_cache.features_ebx &
> +				HV_ENABLE_EXTENDED_HYPERCALLS;
>  	default:
>  		break;
>  	}
> @@ -2564,6 +2573,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
>  		}
>  		goto hypercall_userspace_exit;
>  	}
> +	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
> +		if (unlikely(hc.fast)) {
> +			ret = HV_STATUS_INVALID_PARAMETER;

I wasn't able to find any statement in TLFS stating whether extended
hypercalls can be 'fast', I can imagine e.g. MemoryHeatHintAsync using
it. Unfortunatelly, our userspace exit will have to be modified to
handle such stuff. This can stay for the time being I guess..

> +			break;
> +		}
> +		goto hypercall_userspace_exit;
>  	default:
>  		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
>  		break;
> @@ -2722,6 +2737,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  			ent->ebx |= HV_POST_MESSAGES;
>  			ent->ebx |= HV_SIGNAL_EVENTS;
> +			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
>  
>  			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

