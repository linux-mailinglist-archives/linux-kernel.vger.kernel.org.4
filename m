Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB960F5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiJ0LOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiJ0LOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0060EF593
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666869254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+J2JKSSbsp2Y5PdXI1/Wc1EOZybiPyV+bq2IR/thafc=;
        b=ih6makvbfmQZk/sUkT5idJA+647dQ/lJVbAOIk7TIhTy/B8jAoj/OQasdLRUHLCNT8n35E
        NlYQUv/DmiHvhMBFxLluUCgUNrHvCwGub6vveA0Mq14L3rOUzmcUGObqDuv8WR8nWUI0/j
        U+OFSbJ3t5XVlKJleWckIFZE8s506i0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-XTi1JC8GMZiF1Ebd5fTxAw-1; Thu, 27 Oct 2022 07:14:12 -0400
X-MC-Unique: XTi1JC8GMZiF1Ebd5fTxAw-1
Received: by mail-ed1-f72.google.com with SMTP id dz9-20020a0564021d4900b0045d9a3aded4so877161edb.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J2JKSSbsp2Y5PdXI1/Wc1EOZybiPyV+bq2IR/thafc=;
        b=uIL1vRO2gwudBoD9Q/ba5qqGBjxU9ZhNkKOpHTUzh8cgtft619GITjRtW0WrKiFFIg
         2vPUEon3hlZPU4kQnafx8wcq7cIXFlNu6QHhICjv/chr2S50wPEV9pFMiImvjIwL0Pg2
         Nc1mtqJPu6tlzhOHig+aX7ShaL+If4nlHclYLQuzFJRu86OUFHVp+i3wiGNhf2SaAc27
         eQt/WFsNJ7q1uJ7FKTIl107MbGQzY5w+CqW8SNYLD+a4Q3FfQVO7VOktXVC3qOrogRRZ
         AHp/QiMvV7RPkNhZDQ1yWPYon8rJpGS2vQh5rqj25LHC54L3Hgy6BRAaylgPDdF7D9E0
         oBLg==
X-Gm-Message-State: ACrzQf1zOY/7d3MoBouyW6r0i2QnbgwEFqsntZxERfMNylQO9AzcbuZq
        DdiMCZLZj5XpQ5c5wdd5llC48pjOJAEL7LJ09V4SuiKDI5DFeJL2hNEsZV8TJciaH3pw527M0NX
        Iipf31yPTihrdyU0wUg+r8sXxIiY4d72AqRPg6Hg9RlTm+SwdNXjp/3TS49olNhpMlqouq7rR7N
        RS
X-Received: by 2002:a17:907:80a:b0:783:2585:5d73 with SMTP id wv10-20020a170907080a00b0078325855d73mr41732114ejb.642.1666869251664;
        Thu, 27 Oct 2022 04:14:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6SBob/dK/EpqbPmW9bPW3nOamc21txLJdX5E4Wn8WMCA2c4f7Ln1edRcomuEZvXdXVaVNZZA==
X-Received: by 2002:a17:907:80a:b0:783:2585:5d73 with SMTP id wv10-20020a170907080a00b0078325855d73mr41732092ejb.642.1666869251404;
        Thu, 27 Oct 2022 04:14:11 -0700 (PDT)
Received: from ovpn-194-52.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id lu7-20020a170906fac700b0078d9b967962sm649866ejb.65.2022.10.27.04.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 04:14:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: nVMX: Invert 'unsupported by eVMCSv1' check
In-Reply-To: <Y1nAThjeMlMFFrAi@google.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
 <20221018101000.934413-3-vkuznets@redhat.com>
 <Y1nAThjeMlMFFrAi@google.com>
Date:   Thu, 27 Oct 2022 13:14:09 +0200
Message-ID: <87a65htt6m.fsf@ovpn-194-52.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Oct 18, 2022, Vitaly Kuznetsov wrote:
>> When a new feature gets implemented in KVM, EVMCS1_UNSUPPORTED_* defines
>> need to be adjusted to avoid the situation when the feature is exposed
>> to the guest but there's no corresponding eVMCS field[s] for it. This
>> is not obvious and fragile.
>
> Eh, either way is fragile, the only difference is what goes wrong when it breaks.
>
> At the risk of making this overly verbose, what about requiring developers to
> explicitly define whether or not a new control is support?  E.g. keep the
> EVMCS1_UNSUPPORTED_* and then add compile-time assertions to verify that every
> feature that is REQUIRED | OPTIONAL is SUPPORTED | UNSUPPORTED.
>
> That way the eVMCS "supported" controls don't need to include the ALWAYSON
> controls, and anytime someone adds a new control, they'll have to stop and think
> about eVMCS.

Is this a good thing or a bad one? :-) I'm not against being extra
verbose but adding a new feature to EVMCS1_SUPPORTED_* (even when there
is a corresponding field) requires testing or a
evmcs_has_perf_global_ctrl()-like story may happen and such testing
would require access to Windows/Hyper-V images. This sounds like an
extra burden for contributors. IMO it's OK if new features are
mechanically added to EVMCS1_UNSUPPORTED_* on the grounds that it
wasn't tested but then it's not much different from "unsupported by
default" (my approach). So I'm on the fence here.

>
> I think we'll still want (need?) the runtime sanitization, but this might allow
> catching at least some cases without needing to wait until a control actually gets
> exposed.
>
> E.g. possibly with more macro magic to reduce the boilerplate
>
> diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
> index d8b23c96d627..190932edcc02 100644
> --- a/arch/x86/kvm/vmx/evmcs.c
> +++ b/arch/x86/kvm/vmx/evmcs.c
> @@ -422,6 +422,10 @@ void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *
>         u32 ctl_high = (u32)(*pdata >> 32);
>         u32 unsupported_ctrls;
>  
> +       BUILD_BUG_ON((EVMCS1_SUPPORTED_PINCTRL | EVMCS1_UNSUPPORTED_PINCTRL) !=
> +                    (KVM_REQUIRED_VMX_PIN_BASED_VM_EXEC_CONTROL |
> +                     KVM_OPTIONAL_VMX_PIN_BASED_VM_EXEC_CONTROL));
> +
>         /*
>          * Hyper-V 2016 and 2019 try using these features even when eVMCS
>          * is enabled but there are no corresponding fields.
> diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
> index 6f746ef3c038..58d77afe9d57 100644
> --- a/arch/x86/kvm/vmx/evmcs.h
> +++ b/arch/x86/kvm/vmx/evmcs.h
> @@ -48,6 +48,11 @@ DECLARE_STATIC_KEY_FALSE(enable_evmcs);
>   */
>  #define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
>                                     PIN_BASED_VMX_PREEMPTION_TIMER)
> +#define EVMCS1_SUPPORTED_PINCTRL                                       \
> +       (PIN_BASED_EXT_INTR_MASK |                                      \
> +        PIN_BASED_NMI_EXITING |                                        \
> +        PIN_BASED_VIRTUAL_NMIS)
> +
>  #define EVMCS1_UNSUPPORTED_EXEC_CTRL (CPU_BASED_ACTIVATE_TERTIARY_CONTROLS)
>  #define EVMCS1_UNSUPPORTED_2NDEXEC                                     \
>         (SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |                         \
>

-- 
Vitaly

