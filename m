Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E3629CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKOO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKOO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7084BE27
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668524163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9HIxue0KMKbjnBL2oQWw8AB6rmAvAfXGoZztesxy7o=;
        b=Bk0N+FjlYjBEgP8HZkwudxFx9GmiMAgIn/1idU1OZQUmuUk6m77EDZ6pj2myvcDVFdgPX4
        FTEKIkIZk/KnfPi26KXa+MFffkyWMepO+Im9f/abjTWgkCDDsmocb4mhykBOKh4WzU+tXQ
        Wxet16R+KyEntE4M5Y+tsuFQz+V170g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-245-2UzlsqHVOB-8PHRvPYo6Dw-1; Tue, 15 Nov 2022 09:55:54 -0500
X-MC-Unique: 2UzlsqHVOB-8PHRvPYo6Dw-1
Received: by mail-wm1-f71.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so3827716wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9HIxue0KMKbjnBL2oQWw8AB6rmAvAfXGoZztesxy7o=;
        b=XUYMfACXMvuS46vtMNRENAwi0kf3jp/BuoYbV2YPZYaswUdYLz+pm6w+2An4yoOUBl
         6fAoargztZOnN0Bk3eh087Ini3Y/82EnCNqr6fj0Wyw35BxEVM8tIrT5HLJiwNOls1Tc
         DoKFR5osvp4Nn3IlxF9UJIgUFAg//ksoPki0yAppSUOTM+dZE2AqdPaEpAPx0FTI+EKG
         3fT7vmEGLYODV8ey8XB0Sy3OqlrJE6doyXLaDmvfM8WvbjUmn8InX7zyP9hTaZzJwE6w
         PflEJp31HqrV4BNONUZsyO3ZnFann72TlaaeS6HOelPcWJRMyW7k4LZpAqLMdCxfFSAc
         eQzw==
X-Gm-Message-State: ANoB5pkKwS0P+3BfXor9tb0K1PrvbU1nYCLIV+ScTsjlXQIs+GxAHqeJ
        o/fe8bPCnH7S9YpP/FLdCZCyFukOq5G4pNxEbaRM4D6wRbq6R+iTBqds+/wD40Dk9NGCJL0RbPl
        sFxduBkIiGvokqgzyeEAQJfds
X-Received: by 2002:a5d:48d1:0:b0:236:55dc:b86b with SMTP id p17-20020a5d48d1000000b0023655dcb86bmr10572748wrs.708.1668524153106;
        Tue, 15 Nov 2022 06:55:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jXzMKLlY7ZGpsnwG1JIhAgG5kUd18FUfxgZ0bakWxcbhfs8wp+SL/jF/OKC68SpSe97FIQw==
X-Received: by 2002:a5d:48d1:0:b0:236:55dc:b86b with SMTP id p17-20020a5d48d1000000b0023655dcb86bmr10572739wrs.708.1668524152888;
        Tue, 15 Nov 2022 06:55:52 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d404b000000b0022ae0965a8asm12643129wrp.24.2022.11.15.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:55:52 -0800 (PST)
Message-ID: <830bdd664f7b307cc407c93974ef4906c4c9cc3f.camel@redhat.com>
Subject: Re: [PATCH v2 0/9] nSVM: Security and correctness fixes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colton Lewis <coltonlewis@google.com>,
        Borislav Petkov <bp@alien8.de>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>
Date:   Tue, 15 Nov 2022 16:55:50 +0200
In-Reply-To: <20221103141351.50662-1-mlevitsk@redhat.com>
References: <20221103141351.50662-1-mlevitsk@redhat.com>
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

On Thu, 2022-11-03 at 16:13 +0200, Maxim Levitsky wrote:
> Recently while trying to fix some unit tests I found a CVE in SVM nested code.
> 
> In 'shutdown_interception' vmexit handler we call kvm_vcpu_reset.
> 
> However if running nested and L1 doesn't intercept shutdown, we will still end
> up running this function and trigger a bug in it.
> 
> The bug is that this function resets the 'vcpu->arch.hflags' without properly
> leaving the nested state, which leaves the vCPU in inconsistent state, which
> later triggers a kernel panic in SVM code.
> 
> The same bug can likely be triggered by sending INIT via local apic to a vCPU
> which runs a nested guest.
> 
> On VMX we are lucky that the issue can't happen because VMX always intercepts
> triple faults, thus triple fault in L2 will always be redirected to L1.
> Plus the 'handle_triple_fault' of VMX doesn't reset the vCPU.
> 
> INIT IPI can't happen on VMX either because INIT events are masked while in
> VMX mode.
> 
> First 4 patches in this series address the above issue, and are
> already posted on the list with title,
> ('nSVM: fix L0 crash if L2 has shutdown condtion which L1 doesn't intercept')
> I addressed the review feedback and also added a unit test to hit this issue.
> 
> In addition to these patches I noticed that KVM doesn't honour SHUTDOWN intercept bit
> of L1 on SVM, and I included a fix to do so - its only for correctness
> as a normal hypervisor should always intercept SHUTDOWN.
> A unit test on the other hand might want to not do so.
> I also extendted the triple_fault_test selftest to hit this issue.
> 
> Finaly I found another security issue, I found a way to
> trigger a kernel non rate limited printk on SVM from the guest, and
> last patch in the series fixes that.
> 
> A unit test I posted to kvm-unit-tests project hits this issue, so
> no selftest was added.
> 
> Best regards,
>         Maxim Levitsky
> 
> Maxim Levitsky (9):
>   KVM: x86: nSVM: leave nested mode on vCPU free
>   KVM: x86: nSVM: harden svm_free_nested against freeing vmcb02 while
>     still in use
>   KVM: x86: add kvm_leave_nested
>   KVM: x86: forcibly leave nested mode on vCPU reset
>   KVM: selftests: move idt_entry to header
>   kvm: selftests: add svm nested shutdown test
>   KVM: x86: allow L1 to not intercept triple fault
>   KVM: selftests: add svm part to triple_fault_test
>   KVM: x86: remove exit_int_info warning in svm_handle_exit
> 
>  arch/x86/kvm/svm/nested.c                     | 12 ++-
>  arch/x86/kvm/svm/svm.c                        | 10 +--
>  arch/x86/kvm/vmx/nested.c                     |  4 +-
>  arch/x86/kvm/x86.c                            | 29 ++++++--
>  tools/testing/selftests/kvm/.gitignore        |  1 +
>  tools/testing/selftests/kvm/Makefile          |  1 +
>  .../selftests/kvm/include/x86_64/processor.h  | 13 ++++
>  .../selftests/kvm/lib/x86_64/processor.c      | 13 ----
>  .../kvm/x86_64/svm_nested_shutdown_test.c     | 67 +++++++++++++++++
>  .../kvm/x86_64/triple_fault_event_test.c      | 73 ++++++++++++++-----
>  10 files changed, 172 insertions(+), 51 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
> 
> -- 

Kind ping on the patch series.


Best regards,
	Maxim Levitsky

> 2.34.3
> 
> 


