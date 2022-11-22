Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C766340AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiKVP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKVP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:58:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DC56546
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669132659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uradUrKuspg0cWVOfa2k3bpwm2ashg8rFjMZx3tZWqw=;
        b=ehy6od/eCfsiHtKPlFEG4d6jRPxXcb4spMsn7cDG9DmQfo5pQIfYoP08N+pU3EpcVHifHx
        rsoJciTnH8/spLj6/kUlZbffySj/lTc7Cv/Hub1U+CbARtdjkpn2nrZtVglAd41UfyxDXw
        WBGGgqj9sQZPoIOozY3J5bg8ZrK0L7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-qscXaNlpM8yhTRKk-ukYJw-1; Tue, 22 Nov 2022 10:57:38 -0500
X-MC-Unique: qscXaNlpM8yhTRKk-ukYJw-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a056402349200b004622e273bbbso9004991edc.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uradUrKuspg0cWVOfa2k3bpwm2ashg8rFjMZx3tZWqw=;
        b=7VfakNxduLzqGraRi3txZdFIoN/EMhbth5GaHsBKwPI6BSzX7OhmUfZdrce+F69d0w
         hZ6dje9DXRv3hotY78YFG1mZU2xotVn/eiC6vpl9MxpX6HEGITAoYo3OnigvksAa7uqi
         sXps5EUQc1hQFx3qbVdUkAd3vSqGNeqAV9F0rBYg7BYkTycCWri+5/M7Zzjx0dwPmOvl
         teoGEOJGUaJRwFpqDyibBkq3lOsJ/KXJQUzyPKWWQszvHhA4qA7CGcamVhFaIX5pXXOi
         hpJFZhTy0lYhY7uL/lSux8vcxHKUDiTzUb/J9GPAj2RX3xsvZS6zfZyDLxKyI4tdLTe+
         pPRA==
X-Gm-Message-State: ANoB5pmf9gnQFjG8YZ5tiNnntDIOT1rnD9aRSAhg2BaKaYq4r7zu63Y6
        tYqbbxZhvCrIOYSYgLf2WCEO/brMF4RwqvYoVd8Z9dD8QJ7YytztPB/xEO8fQTa4qIwrsZKgIFV
        +H5V4Fr2hLiDFsywjVYb572Ej
X-Received: by 2002:aa7:d88c:0:b0:468:ffca:6982 with SMTP id u12-20020aa7d88c000000b00468ffca6982mr19114806edq.282.1669132657258;
        Tue, 22 Nov 2022 07:57:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lHplTl3lbLqv1X1Qu2J0jphF8sbpltZ60QXNuafl8iQVx3RVjwPfOymubayhdPGEqZL1eAA==
X-Received: by 2002:aa7:d88c:0:b0:468:ffca:6982 with SMTP id u12-20020aa7d88c000000b00468ffca6982mr19114792edq.282.1669132657030;
        Tue, 22 Nov 2022 07:57:37 -0800 (PST)
Received: from ovpn-194-185.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm6530944edb.60.2022.11.22.07.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:57:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Subject: Re: [PATCH v2 6/6] KVM: selftests: Test Hyper-V extended hypercall
 exit to userspace
In-Reply-To: <20221121234026.3037083-7-vipinsh@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-7-vipinsh@google.com>
Date:   Tue, 22 Nov 2022 16:57:35 +0100
Message-ID: <87mt8jouc0.fsf@ovpn-194-185.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vipin Sharma <vipinsh@google.com> writes:

> Hyper-V extended hypercalls by default exit to userspace. Verify
> userspace gets the call, update the result and then verify in guest
> correct result is received.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |  1 +
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/include/x86_64/processor.h  |  3 +
>  .../kvm/x86_64/hyperv_extended_hypercalls.c   | 94 +++++++++++++++++++
>  4 files changed, 99 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 082855d94c72..b17874697d74 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -24,6 +24,7 @@
>  /x86_64/hyperv_clock
>  /x86_64/hyperv_cpuid
>  /x86_64/hyperv_evmcs
> +/x86_64/hyperv_extended_hypercalls

My personal preference would be to shorten the name to something like
"hyperv_ext_hcalls", doesn't seem to be ambiguos. No strong preference
though, feel free to keep the long version.

>  /x86_64/hyperv_features
>  /x86_64/hyperv_ipi
>  /x86_64/hyperv_svm_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 2275ba861e0e..a0e12f5d9835 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -87,6 +87,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/fix_hypercall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_evmcs
> +TEST_GEN_PROGS_x86_64 += x86_64/hyperv_extended_hypercalls
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_ipi
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 5d310abe6c3f..f167396b887b 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -168,6 +168,9 @@ struct kvm_x86_cpu_feature {
>  #define X86_FEATURE_KVM_HC_MAP_GPA_RANGE	KVM_X86_CPU_FEATURE(0x40000001, 0, EAX, 16)
>  #define X86_FEATURE_KVM_MIGRATION_CONTROL	KVM_X86_CPU_FEATURE(0x40000001, 0, EAX, 17)
>  
> +/* Hyper-V defined paravirt features */
> +#define X86_FEATURE_HYPERV_EXTENDED_HYPERCALLS	KVM_X86_CPU_FEATURE(0x40000003, 0, EBX, 20)
> +

I completely forgot about my other series where I've converted the whole
hyperv_features test to using KVM_X86_CPU_FEATURE():
https://lore.kernel.org/kvm/20221013095849.705943-6-vkuznets@redhat.com/

but your define reminded me of it, thanks! Hope the whole thing will get
queued soon.

As for your change, I think it is better suited for
include/x86_64/hyperv.h instead of include/x86_64/processor.h anyway,
I'm trying to keep all Hyper-V related stuff separate as Hyper-V CPUID
leaves intersect with KVM's, e.g. 0x40000001.

>  /*
>   * Same idea as X86_FEATURE_XXX, but X86_PROPERTY_XXX retrieves a multi-bit
>   * value/property as opposed to a single-bit feature.  Again, pack the info
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> new file mode 100644
> index 000000000000..13c1b03294a4
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test Hyper-V extended hypercall, HV_EXT_CALL_QUERY_CAPABILITIES (0x8001),
> + * exit to userspace and receive result in guest.
> + *
> + * Negative tests are present in hyperv_features.c
> + *
> + * Copyright 2022 Google LLC
> + * Author: Vipin Sharma <vipinsh@google.com>
> + */
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "hyperv.h"
> +
> +/* Any value is fine */
> +#define EXT_CAPABILITIES 0xbull
> +
> +static void guest_code(vm_vaddr_t in_pg_gpa, vm_vaddr_t out_pg_gpa,
> +		       vm_vaddr_t out_pg_gva)
> +{
> +	uint64_t *output_gva;
> +
> +	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
> +	wrmsr(HV_X64_MSR_HYPERCALL, in_pg_gpa);
> +
> +	output_gva = (uint64_t *)out_pg_gva;
> +
> +	hyperv_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, in_pg_gpa, out_pg_gpa);
> +
> +	/* TLFS states output will be a uint64_t value */
> +	GUEST_ASSERT_EQ(*output_gva, EXT_CAPABILITIES);
> +
> +	GUEST_DONE();
> +}
> +
> +int main(void)
> +{
> +	vm_vaddr_t hcall_out_page;
> +	vm_vaddr_t hcall_in_page;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_run *run;
> +	struct kvm_vm *vm;
> +	uint64_t *outval;
> +	struct ucall uc;
> +
> +	/* Verify if extended hypercalls are supported */
> +	if (!kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
> +			   X86_FEATURE_HYPERV_EXTENDED_HYPERCALLS)) {
> +		print_skip("Extended calls not supported by the kernel");
> +		exit(KSFT_SKIP);
> +	}
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	run = vcpu->run;
> +	vcpu_enable_cap(vcpu, KVM_CAP_HYPERV_ENFORCE_CPUID, 1);

Do we need this enforcement assuming we have no plans to add 'negative'
tests here (hyperv_features does it just fine)? vcpu_set_hv_cpuid()
enables everything anyway...

> +	vcpu_set_hv_cpuid(vcpu);
> +
> +	/* Hypercall input */
> +	hcall_in_page = vm_vaddr_alloc_pages(vm, 1);
> +	memset(addr_gva2hva(vm, hcall_in_page), 0x0, vm->page_size);
> +
> +	/* Hypercall output */
> +	hcall_out_page = vm_vaddr_alloc_pages(vm, 1);
> +	memset(addr_gva2hva(vm, hcall_out_page), 0x0, vm->page_size);
> +
> +	vcpu_args_set(vcpu, 3, addr_gva2gpa(vm, hcall_in_page),
> +		      addr_gva2gpa(vm, hcall_out_page), hcall_out_page);
> +
> +	vcpu_run(vcpu);
> +
> +	ASSERT_EXIT_REASON(vcpu, KVM_EXIT_HYPERV);
> +
> +	outval = addr_gpa2hva(vm, run->hyperv.u.hcall.params[1]);
> +	*outval = EXT_CAPABILITIES;
> +	run->hyperv.u.hcall.result = HV_STATUS_SUCCESS;
> +
> +	vcpu_run(vcpu);
> +
> +	ASSERT_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT_2(uc, "arg1 = %ld, arg2 = %ld");
> +		break;
> +	case UCALL_DONE:
> +		break;
> +	default:
> +		TEST_FAIL("Unhandled ucall: %ld", uc.cmd);
> +	}
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

-- 
Vitaly

