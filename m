Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE276616CF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjAHQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjAHQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822CC655E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673196100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4s/QZKVUjJInw3dpc/keTZ8lxnmM7v0FokGT4KsySWM=;
        b=E+kRyzLUDCLOZlZti18FA/sbIRMwp0RWfxz9Vu/FzMsomS8oRA7uVgfKOtKG4Kwtolulwm
        xuKM5n6CuRc6c38EZf2QLNV0hRw3ncNmByGGE4I+/fEmjlNOVSwrH3heTEfPyW6nHQSS+7
        nVE4EjJkifCeYfbZGcPtqVcxAmYLXX0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-kQNZyyk1PKyMOUevb8l6QA-1; Sun, 08 Jan 2023 11:41:39 -0500
X-MC-Unique: kQNZyyk1PKyMOUevb8l6QA-1
Received: by mail-ej1-f69.google.com with SMTP id sc9-20020a1709078a0900b0084c4e8dc14eso3977741ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 08:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4s/QZKVUjJInw3dpc/keTZ8lxnmM7v0FokGT4KsySWM=;
        b=4qThWzFcUdlmCeMGNWmtGs0lQkrRQgw+k+iFv9RxNtD8ZBnIxAa9sH0EKgyI4TkuEE
         s953Lu9DtyvemTfh0i+lMF4nxllNZE+eBDQctblOu4UJrmPhwrMSxFG7Vm2VLrXDkCuX
         ph6+DQ0qSCFxdiYPup1KQhWqRcf9A/hbcKH6Q2rQ54qPw3+zyVT7eLAeY+Q7voQoycFm
         kyY6JOW7dGbWq2PuiFr05kdHGSFNRaJIPOWmpOr61zhzQo5McVJiLqPdMviljiKfPsAE
         NZcaGnpadaV/DneO9cKXjEEclFRTgyr+qNwVhRafw0Set/3EtyAH4dbEl7XYODxQ3DlP
         Qmug==
X-Gm-Message-State: AFqh2kp/1O4/wUH/NI7ssqqzGlPcrtgQ1061HJJloXUQWWxcvKA4iXfL
        pbOexr+BBsaMWNyi2bb7JyOafF6Sl1j1cRtys9c+jKWyF4n3ntWdSoGMEI/ylzOHtQDyEMwj8pX
        /x0PgaWc3Ro+LgdVKVVCum9bC
X-Received: by 2002:a17:906:92c4:b0:82d:e2a6:4b1e with SMTP id d4-20020a17090692c400b0082de2a64b1emr62874109ejx.47.1673196098421;
        Sun, 08 Jan 2023 08:41:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQ/bAa3HUi/l5qV9b+adt9SPqwBY82YCtGPImcLOPPIbwX5OYijW/0pkUMWru9iPtkLQTQ5g==
X-Received: by 2002:a17:906:92c4:b0:82d:e2a6:4b1e with SMTP id d4-20020a17090692c400b0082de2a64b1emr62874102ejx.47.1673196098243;
        Sun, 08 Jan 2023 08:41:38 -0800 (PST)
Received: from starship ([89.237.103.62])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007ad69e9d34dsm2682045ejc.54.2023.01.08.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:41:37 -0800 (PST)
Message-ID: <d1dd4636735912700198cfade57670a968ce433f.camel@redhat.com>
Subject: Re: [PATCH 2/6] KVM: x86: Inject #GP on x2APIC WRMSR that sets
 reserved bits 63:32
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Orr <marcorr@google.com>, Ben Gardon <bgardon@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Date:   Sun, 08 Jan 2023 18:41:36 +0200
In-Reply-To: <20230107011025.565472-3-seanjc@google.com>
References: <20230107011025.565472-1-seanjc@google.com>
         <20230107011025.565472-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-01-07 at 01:10 +0000, Sean Christopherson wrote:
> Reject attempts to set bits 63:32 for 32-bit x2APIC registers, i.e. all
> x2APIC registers except ICR.  Per Intel's SDM:
> 
>   Non-zero writes (by WRMSR instruction) to reserved bits to these
>   registers will raise a general protection fault exception
> 
> Opportunistically fix a typo in a nearby comment.
> 
> Reported-by: Marc Orr <marcorr@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index f77da92c6ea6..bf53e4752f30 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -3108,13 +3108,17 @@ static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data)
>  static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data)
>  {
>  	/*
> -	 * ICR is a 64-bit register in x2APIC mode (and Hyper'v PV vAPIC) and
> +	 * ICR is a 64-bit register in x2APIC mode (and Hyper-V PV vAPIC) and
>  	 * can be written as such, all other registers remain accessible only
>  	 * through 32-bit reads/writes.
>  	 */
>  	if (reg == APIC_ICR)
>  		return kvm_x2apic_icr_write(apic, data);
>  
> +	/* Bits 63:32 are reserved in all other registers. */
> +	if (data >> 32)
> +		return 1;
> +
>  	return kvm_lapic_reg_write(apic, reg, (u32)data);
>  }
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

