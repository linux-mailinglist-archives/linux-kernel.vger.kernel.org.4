Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92F6642D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjAJOIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjAJOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2404B491
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673359641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osQGl6WdeMNERrK4mmhBqzkrB96DwCjWqn8ZMWvtmjo=;
        b=i68d56G0hiz3JZ7iig0pV2Th5TNslquEtUmajxA9zHbWz7tuaKIv6eXloihKhLNAH5K5RX
        hsvqNHyBXPBdkFmBbnrMgXgbAV61yAvvJsnjhUHpR5K6h1+36UsdnNw7cXCPqsPaMRspJc
        pbNv/VDN4GvdAGBciBPactM2B9xTKv4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-wuTefuHiN02wNLtvUCVORg-1; Tue, 10 Jan 2023 09:07:18 -0500
X-MC-Unique: wuTefuHiN02wNLtvUCVORg-1
Received: by mail-wm1-f71.google.com with SMTP id m7-20020a05600c4f4700b003d971a5e770so6354185wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osQGl6WdeMNERrK4mmhBqzkrB96DwCjWqn8ZMWvtmjo=;
        b=mKiTabj3puuCE4tCqeOQ7S99C+FWbKLiKrlT29S0AUVhOCCixBfyphleRs/yiJO7Zr
         R4g/kTwTyfF13a+7wgec7bnIFa7l+jauiuFZTwk7OTzaM67gthnK6EiN+xHpJ6pc33wo
         jRo+gSvFaK63TleFnjXpGdoLbIvvcMS3AE+9bB0f00OCPQKek0tc6PD3lMDbAPa6lRhX
         n1FS2OseEJVPEJmG7Ta8xw8qMReej47cEn/ERUjCocsIQ+A5N2u8cCWUl5P0tFJMAgN9
         jlM9FxWR8vjUJMYUloStHE3MxcA6orELO8UfyXQlaQ+QOQosdzFnehuoVIAP2NgacMIa
         3oGQ==
X-Gm-Message-State: AFqh2kpXRWZV5uwOqHuq2PurZoTw1vbZpVagzCLeX0tur3LxOwsTP4Ot
        8zrIV9i2lnP6hDDugiFcOMvDvRP1MsBmbJvcXWlwC7KrQNCwUzu7aUVoqgVb67beeYpx77sleL/
        a3Zh2K2IhCznojSMhZmH8h0Gg
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr48604147wmb.7.1673359637366;
        Tue, 10 Jan 2023 06:07:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtq26GfZVm03WMwtx5KiMTHAU1t+qysGYw90grsxTVbY0STkNPBhngXA6sfEIYm6mKB+sxdVw==
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr48604113wmb.7.1673359637069;
        Tue, 10 Jan 2023 06:07:17 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm21192545wmo.39.2023.01.10.06.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 06:07:16 -0800 (PST)
Message-ID: <fa0758f5-abd1-ad09-3878-adf296c7aac5@redhat.com>
Date:   Tue, 10 Jan 2023 15:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230109130605.2013555-1-eesposit@redhat.com>
 <20230109130605.2013555-2-eesposit@redhat.com>
 <c61ce1a6393a108c76e53cb99249aba5ab318e07.camel@redhat.com>
 <Y7w/bYP4VGqoVcjH@google.com>
 <5664d006-9452-2033-5605-48aa0ee77ca8@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 1/2] KVM: x86: update APIC_ID also when disabling
 x2APIC in kvm_lapic_set_base
In-Reply-To: <5664d006-9452-2033-5605-48aa0ee77ca8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 13:16, Emanuele Giuseppe Esposito wrote:
> I think the test in patch 2 I wrote gives a better idea on what I am
> trying to fix: if we are transitioning from x2APIC to xAPIC (RESET I
> would say, even though I am not sure if userspace really does it in the
> way I do it in the test, ie through KVM_SET_MSRS), the APIC_ID is not
> updated back in the right bits, and we can see that by querying the ID
> with KVM_GET_LAPIC after disabling x2APIC.
> 
> Now, if the way I reproduce this issue is correct, it is indeed a bug
> and needs to be fixed with the fix in patch 1 or something similar.
> I think it won't really make any difference if instead following what
> the doc says (x2APIC -> disabled -> xAPIC) we directly do x2APIC -> xAPIC.

Yes, the default value at reset is xAPIC mode, so a reset will do a
KVM_SET_MSRS that clears X2APIC_ENABLE but leaves
MSR_IA32_APICBASE_ENABLE set.

So, if I understand correctly...

> The test in patch 2 started being developed to test ef40757743b47 ("KVM:
> x86: fix APICv/x2AVIC disabled when vm reboot by itself") even though I
> honestly didn't really understand how to replicate that bug (see cover
> letter) and instead I found this other possibility that still manages to
> screw APIC_ID.

... what you're saying is that there were two different bugs, but one
fixing any one of them was enough to prevent the symptoms shown by
commit ef40757743b47?  That is:

- the APICv inhibit was set by KVM_GET_LAPIC because it called
kvm_lapic_xapic_id_updated(), and the call was unnecessary as fixed in
commit ef40757743b47;

- however, there is no reason for the vCPU ID to be mismatched.  It
happened because the code didn't handle the host-initiated x2APIC->xAPIC
case and thus lacked a call to kvm_apic_set_xapic_id().

If so, I think the idea of the patch is fine.

Just one thing: your patch also changes the APIC_ID on the
x2APIC->disabled transition, not just the "forbidden" (i.e. host-
initiated only) x2APIC->xAPIC transition.  I think  this is okay too: the
manual says:

    10.4.3 Enabling or Disabling the Local APIC

    When IA32_APIC_BASE[11] is set to 0, prior initialization to the APIC
    may be lost and the APIC may return to the state described in Section
    10.4.7.1, “Local APIC State After Power-Up or Reset.”

    10.4.7.1 Local APIC State After Power-Up or Reset

    ... The local APIC ID register is set to a unique APIC ID. ...

(which must be an xAPIC ID) and this is what your patch does.

In fact perhaps you can change the code further to invoke
kvm_lapic_reset() after static_branch_inc(&apic_hw_disabled.key)?  It's
just a bit messy that you have a call back to kvm_lapic_set_base() in
there, so perhaps something like this can help:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4efdb4a4d72c..24e5df23a4d9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2433,9 +2436,7 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
  
  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
  {
-	struct kvm_lapic *apic = vcpu->arch.apic;
  	u64 msr_val;
-	int i;
  
  	if (!init_event) {
  		msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
@@ -2444,8 +2445,14 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
  		kvm_lapic_set_base(vcpu, msr_val);
  	}
  
-	if (!apic)
-		return;
+	if (vcpu->arch.apic)
+		__kvm_lapic_reset(vcpu, init_event);
+}
+
+static void __kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
+{
+	struct kvm_lapic *apic = vcpu->arch.apic;
+	int i;
  
  	/* Stop the timer in case it's a reset to an active apic */
  	hrtimer_cancel(&apic->lapic_timer.timer);


(just a sketch to show the idea, of course __kvm_lapic_reset would have to
go first).

Paolo

