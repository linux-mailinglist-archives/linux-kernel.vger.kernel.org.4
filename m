Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D026B52F7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCJVmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:42:38 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D3E1308DB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:37 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id h14-20020aa786ce000000b005a89856900eso3459343pfo.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484557;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gq6OHSYM/e+kopXFfk8orrDhq2+l5faiz/sXA8Gb8nI=;
        b=Qmv8fm/o2rZjwJOQ+CDTX5yN6AdUDgAgJiGtlBgRNvSRH/WU3OWCwB9InzOstwNjN9
         6ci+FgngRcI0rvsM5pqBZcT2nCH5cJnq8PagLbtbE3ieBzFWIQbchGIV4SQU6MnggT61
         w/tBZYs97iB1ZZbiXpwe7lHLmR6mOKzPIVU1bnClV4ooxlzijyMBXFs3xoqaJAdp9CCO
         4ZM7IoeEHIyKOLlblaV7h1mp32uaAWOz7iAumC4MLMniYVbiyVBP7OieQmXvcPGDeNEC
         KdYrY9CtE5bMxanJrRcFpyDK6Hf/bhBGaxqYOBmBZEVwO42hjeIQsJqQq/Xy6QsMmMs1
         8//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484557;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq6OHSYM/e+kopXFfk8orrDhq2+l5faiz/sXA8Gb8nI=;
        b=gE6CUsOkagPgg3rAJNemSMoffqQ8uWNgdt39fflyAQuwMctZTw+5F7yi0YMM8SK9xy
         iCWWSDGB7ApaEaiC9QRS5sirJZWwI3mkO+3TT4+X3r3oYNaK/VXybU7DoqG/SDCrHjni
         ZE9yHYAYNvbzAVyb6gOpEsZlb5jIIm5xF5HWoZTcHzIYG3xYEUVQm4ECraXK58eDQcPk
         WSEMWc4YrqiH21ojpP0hMkuVKZ7ESNlRN80Af4CSWhz9ewxI63tZccPz8gdmAXrhg6Nc
         i/rzOo8Pb8i1zsGCRQinc68Ir5z0GaCQ9wkLwW4/BjnUH2Zb0RRxxHnSxuhjmRp0tPl1
         s74A==
X-Gm-Message-State: AO0yUKWj/anGOghvvznwx7JjVo4Rli3erbepSr9+90FK0SbfsYiypLuH
        SXZcLFTPiaIYOvom0zliqMKBpAvk6UE=
X-Google-Smtp-Source: AK7set/YfujcZa9UmiYtHJmEvDFVFlF/ah2rWK4SpQCrBGRKskz0Ih2Lssy7DWDxI836lsHYwxT3vF/q3pY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6845:b0:19c:a3be:a9d4 with SMTP id
 f5-20020a170902684500b0019ca3bea9d4mr9916833pln.7.1678484556960; Fri, 10 Mar
 2023 13:42:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:14 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-1-seanjc@google.com>
Subject: [PATCH v2 00/18] x86/reboot: KVM: Clean up "emergency" virt code
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having the reboot code blindly try to disable virtualization
during an emergency, use the existing callback into KVM to disable virt
as "needed".  In quotes because KVM still somewhat blindly attempts to
disable virt, e.g. if KVM is loaded but doesn't have active VMs and thus
hasn't enabled hardware.  That could theoretically be "fixed", but due to
the callback being invoked from NMI context, I'm not convinced it would
be worth the complexity.  E.g. false positives would still be possible,
and KVM would have to play games with the per-CPU hardware_enabled flag
to ensure there are no false negatives.

The callback is currently used only to VMCLEAR the per-CPU list of VMCSes,
but not using the callback to disable virt isn't intentional.  Arguably, a
callback should have been used in the initial "disable virt" code added by
commit d176720d34c7 ("x86: disable VMX on all CPUs on reboot").  And the
kexec logic added (much later) by commit f23d1f4a1160 ("x86/kexec: VMCLEAR
VMCSs loaded on all cpus if necessary") simply missed the opportunity to
use the callback for all virtualization needs.

Once KVM handles disabling virt, move all of the helpers provided by
virtext.h into KVM proper.

There's one outlier patch, "Make KVM_AMD depend on CPU_SUP_AMD or
CPU_SUP_HYGON", that I included here because it felt weird to pull in the
"must be AMD or Hygon" check without KVM demanding that at build time.

Note, there have been conversations at various times about supporting
additional in-tree users of virtualization.  Somewhat counter-intuitively,
giving KVM full ownership of virt actually make it _easier_ to support
additional virt users as having all of the code in one place makes it
easier to extract the bits that need to be shared.

v2:
 - Disable task migration when probing basic SVM and VMX support to avoid
   logging misleading info (wrong CPU) if probing fails.

v1: https://lore.kernel.org/all/20221201232655.290720-1-seanjc@google.com

Sean Christopherson (18):
  x86/reboot: VMCLEAR active VMCSes before emergency reboot
  x86/reboot: Expose VMCS crash hooks if and only if KVM_INTEL is
    enabled
  x86/reboot: Harden virtualization hooks for emergency reboot
  x86/reboot: KVM: Handle VMXOFF in KVM's reboot callback
  x86/reboot: KVM: Disable SVM during reboot via virt/KVM reboot
    callback
  x86/reboot: Hoist "disable virt" helpers above "emergency reboot" path
  x86/reboot: Disable virtualization during reboot iff callback is
    registered
  x86/reboot: Assert that IRQs are disabled when turning off
    virtualization
  x86/virt: KVM: Open code cpu_has_vmx() in KVM VMX
  x86/virt: KVM: Move VMXOFF helpers into KVM VMX
  KVM: SVM: Make KVM_AMD depend on CPU_SUP_AMD or CPU_SUP_HYGON
  x86/virt: Drop unnecessary check on extended CPUID level in
    cpu_has_svm()
  x86/virt: KVM: Open code cpu_has_svm() into kvm_is_svm_supported()
  KVM: SVM: Check that the current CPU supports SVM in
    kvm_is_svm_supported()
  KVM: VMX: Ensure CPU is stable when probing basic VMX support
  x86/virt: KVM: Move "disable SVM" helper into KVM SVM
  KVM: x86: Force kvm_rebooting=true during emergency reboot/crash
  KVM: SVM: Use "standard" stgi() helper when disabling SVM

 arch/x86/include/asm/kexec.h   |   2 -
 arch/x86/include/asm/reboot.h  |   7 ++
 arch/x86/include/asm/virtext.h | 154 ---------------------------------
 arch/x86/kernel/crash.c        |  31 -------
 arch/x86/kernel/reboot.c       |  65 ++++++++++----
 arch/x86/kvm/Kconfig           |   2 +-
 arch/x86/kvm/svm/svm.c         |  70 ++++++++++++---
 arch/x86/kvm/vmx/vmx.c         |  68 +++++++++++----
 8 files changed, 168 insertions(+), 231 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h


base-commit: 45dd9bc75d9adc9483f0c7d662ba6e73ed698a0b
-- 
2.40.0.rc1.284.g88254d51c5-goog

