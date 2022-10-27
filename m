Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196760F210
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiJ0ISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiJ0ISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B411F7093
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666858699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+zjgwfHgHFBXNtS1dcXbFjT5C6bNkpnBbMlxremMWY=;
        b=MUD+cnXr1io+bYdM9O2s0fJAlr36/AHyR4VkbQzkAMj8CRI77Dsllkjy95KbPbEkq4kA4Z
        hB+Mscw/e5p/FCu/E+9aiF/KvpWAIODSR4641AIm18G4rMcayBloBQa3QcTaJFxnLms7KA
        ckb0yr5e9Zi5otQ+HC2ocajC5P2b7XY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-B_t6IKkFMoezjuISql9Rjg-1; Thu, 27 Oct 2022 04:18:17 -0400
X-MC-Unique: B_t6IKkFMoezjuISql9Rjg-1
Received: by mail-wm1-f70.google.com with SMTP id f1-20020a1cc901000000b003cf475763b6so263282wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+zjgwfHgHFBXNtS1dcXbFjT5C6bNkpnBbMlxremMWY=;
        b=Q4venSBYC+q0cX8bG0TyLF+Yj53ovq9Pj6/2hMCD9p49qyLUpP9PxfuB93DlfsiRj2
         wOA5IRTJTqx6VPUa+271ZMqq/veuWLMV1Cir/rl18MRjgdxf5HdMtajMYZY9CuHMolX7
         gXyaDsPkOlvL4YOLM4q73AhXCW95oWa+3GcBxoaLUl/9O0widtEPMIYYvEKsd1sklZcF
         LaH2GyZr6PCJShGSs9ka4kh9nN6vpz0wbp3rgerh1BFraBqxFjUEsMR5JDWTUPvklSmo
         iQTprxADDQ/BcthK8Ba+eEj0gvxic85o+W+qgk85yWiJit1wX/Ol9Nsk7Z5wxQFmmShU
         dBMw==
X-Gm-Message-State: ACrzQf2d5LA7Eu1Y5oD1io7QLzAmlY1h+bhR91aHtyGhoybVeUMaqR9m
        6O2Yh/irSxN3UP4y5GreHae1/Cj2K4R5K8jjCHteFBZrf5/5OZ5u5UKnKaIVrLdl/Vhltx1u9SL
        6VXI13sPEOUI75WgXYEMm3kawCUduQ51oDgs/Ho6ihyTBEYGAcpOo8Zx/fI1pvEFG9JyVD4jmNf
        M7
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr31409136wrn.251.1666858696623;
        Thu, 27 Oct 2022 01:18:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CgeyUAU3EZlndfaRTAGP3JWCxEXgwxeBo73X8Vdko0Rf33SSC2AqFidTXI1tyqPqoddOuig==
X-Received: by 2002:adf:ebcf:0:b0:22c:9eb4:d6f6 with SMTP id v15-20020adfebcf000000b0022c9eb4d6f6mr31409114wrn.251.1666858696314;
        Thu, 27 Oct 2022 01:18:16 -0700 (PDT)
Received: from ovpn-194-52.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c1c8100b003b4fe03c881sm4208779wms.48.2022.10.27.01.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:18:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 13/46] KVM: x86: Prepare kvm_hv_flush_tlb() to
 handle L2's GPAs
In-Reply-To: <Y1m0HCMgwJen/NnU@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <20221021153521.1216911-14-vkuznets@redhat.com>
 <Y1m0HCMgwJen/NnU@google.com>
Date:   Thu, 27 Oct 2022 10:18:14 +0200
Message-ID: <87ilk5u1bt.fsf@ovpn-194-52.brq.redhat.com>
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

> On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
>> To handle L2 TLB flush requests, KVM needs to translate the specified
>> L2 GPA to L1 GPA to read hypercall arguments from there.
>> 
>> No functional change as KVM doesn't handle VMCALL/VMMCALL from L2 yet.
>> 
>> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/hyperv.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index fca9c51891f5..df1efb821eb0 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -23,6 +23,7 @@
>>  #include "ioapic.h"
>>  #include "cpuid.h"
>>  #include "hyperv.h"
>> +#include "mmu.h"
>>  #include "xen.h"
>>  
>>  #include <linux/cpu.h>
>> @@ -1908,6 +1909,12 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>>  	 */
>>  	BUILD_BUG_ON(KVM_HV_MAX_SPARSE_VCPU_SET_BITS > 64);
>>  
>> +	if (!hc->fast && is_guest_mode(vcpu)) {
>
> Please add a comment explaining why only "slow" hypercalls need to translate the
> GPA from L2=>L1.
>
> With a comment (and assuming this isn't a bug),

This is intended,

For "slow" hypercalls 'hc->ingpa' is the GPA (or an 'nGPA' -- thus the
patch) in guest memory where hypercall parameters are placed, kvm reads
them with kvm_read_guest() later. For "fast" hypercalls 'ingpa' is a
misnomer as it is not an address but the first parameter (in the 'tlb
flush' case it's 'address space id' which we currently don't
analyze). We may want to add a union in 'struct kvm_hv_hcall' to make
this explicit.

The comment I'm thinking of would be:

"
/*
 * 'Slow' hypercall's first parameter is the address in guest's memory where
 * hypercall parameters are placed. This is either a GPA or a nested GPA when
 * KVM is handling the call from L2 ('direct' TLB flush), translate the address
 * here so the memory can be uniformly read with kvm_read_guest().
 */
"

>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>

-- 
Vitaly

