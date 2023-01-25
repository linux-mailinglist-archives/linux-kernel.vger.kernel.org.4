Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82EE67BF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjAYVta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjAYVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6061D74
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674683202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLCQgOuNAMLOsGwRlp0t3XHDmNl5xofkTJb6esBr2zs=;
        b=jCNmJoH/Lk/n58i9RUT9jTh8Et8e+donPUpBi+jR4NG2hh9rvAYA3w+9Pz2KPB/3BDVTii
        /67/fcJ13jq5DAIklCgLJZET5qhezIeoUWsuulM/+EGIDIK0IWrLdUs+TOqSX7lTTDyzhj
        +VzuOK6qbV7pYMkzSUVWK6hl1RfO3ho=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287-CO6arb63NAKHgT_6olSy3w-1; Wed, 25 Jan 2023 16:46:40 -0500
X-MC-Unique: CO6arb63NAKHgT_6olSy3w-1
Received: by mail-ed1-f71.google.com with SMTP id c12-20020a05640227cc00b0049e2c079aabso127957ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLCQgOuNAMLOsGwRlp0t3XHDmNl5xofkTJb6esBr2zs=;
        b=rpaoOrltHckg2j12FSuBCUe1M1NASH4+vZIPB4EanVnXcuRTDrOUwkrGY992BoYrYC
         gIPp1iav+FhtVhDMuBeq/UkpwQCaK142AcTsasjbsHM9MXWXhH5Rp8VACOrW3HOGjRlK
         7WR+4O5H/RTCXnbDLLCbIGHJmR8Ul7nUYx+wvgW9veq5EtcOdWpvW26jj5aK3JloRkRf
         PUzBLEIwXqWIdMpjCLmPINeTP+PCIYQV54BlrwiAaSwU+h4bL3Ea+zQERNDeei2tLZBi
         JR/mYFCBtNtsCuQAyBFLV8ySe6ERJHDXf4bGclgm9AdsARCXgWoz+eDxO7dop0QDi7VM
         pebw==
X-Gm-Message-State: AFqh2krFO7cSJuABOUxokKgYZdbqfngjnLN0ne77bsBWRAZDIr+gJ/aA
        OR7Q7NmFnUpxWVUDJ5qYEHbcnkVoaYJ9MPVyko98xl6AUS+I3fXep8T3+Olgqaaf+z+ICb4RI0n
        LxjltI5Y0JZyaBcXZwc5Z2SuP
X-Received: by 2002:a05:6402:3220:b0:49e:1d59:794f with SMTP id g32-20020a056402322000b0049e1d59794fmr42338662eda.22.1674683198341;
        Wed, 25 Jan 2023 13:46:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuaYorcRAqvlHkC2q/xU+XLFWtAsQn5eyQjkeLaZlqhHL+7YF+wyeezO9kOjzNPzfxS7pMrUw==
X-Received: by 2002:a05:6402:3220:b0:49e:1d59:794f with SMTP id g32-20020a056402322000b0049e1d59794fmr42338646eda.22.1674683198074;
        Wed, 25 Jan 2023 13:46:38 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id r9-20020a056402018900b0049e09105705sm2826937edv.62.2023.01.25.13.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 13:46:32 -0800 (PST)
Message-ID: <8bdf22c8-9ef1-e526-df36-9073a150669d@redhat.com>
Date:   Wed, 25 Jan 2023 22:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, stable@vger.kernel.org
References: <20221027092036.2698180-1-pbonzini@redhat.com>
 <CALMp9eQihPhjpoodw6ojgVh_KtvPqQ9qJ3wKWZQyVtArpGkfHA@mail.gmail.com>
 <3a23db58-3ae1-7457-ed09-bc2e3f6e8dc9@redhat.com>
 <CALMp9eQ3wZ4dkq_8ErcUdQAs2F96Gvr-g=7-iBteJeuN5aX00A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] KVM: x86: Do not return host topology information from
 KVM_GET_SUPPORTED_CPUID
In-Reply-To: <CALMp9eQ3wZ4dkq_8ErcUdQAs2F96Gvr-g=7-iBteJeuN5aX00A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 17:47, Jim Mattson wrote:
>> Part of the definition of the API is that you can take
>> KVM_GET_SUPPORTED_CPUID and pass it to KVM_SET_CPUID2 for all vCPUs.
>> Returning host topology information for a random host vCPU definitely
>> violates the contract.
> 
> You are attempting to rewrite history.  Leaf 0xB was added to > KVM_GET_SUPPORTED_CPUID in commit 0771671749b5 ("KVM: Enhance guest
> cpuid management"), and the only documentation of the
> KVM_GET_SUPPORTED_CPUID ioctl at that time was in the commit message:
> 
>       - KVM_GET_SUPPORTED_CPUID: get all cpuid entries the host (and kvm)
>         supports
>
> [...] the intention was to return the
> host topology information for the current logical processor.

The handling of unknown features is so naive in that commit, that I 
don't think it is possible to read anything from the implementation; and 
it certainly should not be a paragon for a future-proof implementation 
of KVM_GET_SUPPORTED_CPUID.

For example, it only hid _known_ CPUID leaves or features and passed the 
unknown ones through, which you'll agree is completely broken.  It also 
didn't try to handle all leaves for which ECX might turn out to be 
significant---which happened for EAX=7 so the commit returns a wrong 
output for CPUID[EAX=7,ECX=0].EAX.

In other words, the only reason it handles 0xB is because it was known 
to have subleaves.

We can get more information about how userspace was intended to use it 
from the qemu-kvm fork, which at the time was practically the only KVM 
userspace.  As of 2009 it was only checking a handful of leaves:

https://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git/tree/target-i386/kvm.c?h=kvm-88#n133

so shall we say that userspace is supposed to build each CPUID leaf one 
by one and use KVM_GET_SUPPORTED_CPUID2 for validation only?  I think 
the first committed documentation agrees: "Userspace can use the 
information returned by this ioctl to construct cpuid information (for 
KVM_SET_CPUID2) that is consistent with hardware, kernel, and userspace 
capabilities, and with user requirements".

However, that's the theory.  "Do not break userspace" also involves 
looking at how userspace *really* uses the API, and make compromises to 
cater to those uses; which is different from rewriting history.

And in practice, people basically stopped reading after "(for 
KVM_SET_CPUID2)".

For example in kvmtool:

	kvm_cpuid->nent = MAX_KVM_CPUID_ENTRIES;
	if (ioctl(vcpu->kvm->sys_fd, KVM_GET_SUPPORTED_CPUID, kvm_cpuid) < 0)
		die_perror("KVM_GET_SUPPORTED_CPUID failed");

	filter_cpuid(kvm_cpuid, vcpu->cpu_id);

	if (ioctl(vcpu->vcpu_fd, KVM_SET_CPUID2, kvm_cpuid) < 0)
		die_perror("KVM_SET_CPUID2 failed");

where filter_cpuid only does minor adjustments that do not include 0xB, 
0x1F and 0x8000001E.  The result is a topology that makes no sense if 
host #vCPUs != guest #vCPUs, and which doesn't include the correct APIC 
id in EDX.

https://github.com/kvmtool/kvmtool/blob/5657dd3e48b41bc6db38fa657994bc0e030fd31f/x86/cpuid.c


crosvm does optionally attempt to pass through leaves 0xB and 0x1F, but 
it fails to adjust the APIC id in EDX.  On the other hand it also passes 
through 0x8000001E if ctx.cpu_config.host_cpu_topology is false, 
incorrectly.  So on one hand this patch breaks host_cpu_topology == 
true, on the other hand it fixes host_cpu_topology == false on AMD 
processors.

https://github.com/google/crosvm/blob/cc79897fc0813ee8412e6395648593898962ec82/x86_64/src/cpuid.rs#L121


The rust-vmm reference hypervisor adjusts the APIC id in EDX for 0xB but 
not for 0x1F.  Apart from that it passes through the host topology 
leaves, again resulting in nonsensical topology for host #vCPUs != guest 
#vCPUs.

https://github.com/rust-vmm/vmm-reference/blob/5cde58bc955afca8a180585a9f01c82d6277a755/src/vm-vcpu-ref/src/x86_64/cpuid.rs


Firecracker, finally, ignores KVM_GET_SUPPORTED_CPUID's output for 0xb 
and 0x8000001E (good!) but fails to do the same for 0x1F, so this patch 
is again a fix of sorts---having all zeroes in 0x1F is better than 
having a value that is valid but inconsistent with 0xB.

https://github.com/firecracker-microvm/firecracker/blob/cdf4fef3011c51206f178bdf21ececb87caa16c1/src/cpuid/src/transformer/intel.rs#L120
https://github.com/firecracker-microvm/firecracker/blob/cdf4fef3011c51206f178bdf21ececb87caa16c1/src/cpuid/src/transformer/amd.rs#L88


So basically the only open source userspace that is penalized (but not 
broken, and also partly fixed) by the patch is crosvm.  QEMU doesn't 
care, while firecracker/kvmtool/vmm-reference are a net positive.

Paolo

> Any future changes to either the operational behavior or the
> documented behavior of the ABI surely demand a version bump.
> 

