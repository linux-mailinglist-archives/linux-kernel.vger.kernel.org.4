Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090863FBED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLAX1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLAX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:27:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4080C9366
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:27:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b6-20020a170902d50600b00189a5536820so3998905plg.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyxe+CH68uktfq8bo3UKcka5hykVJJAZQsYOM6ktq0o=;
        b=Q3F4gYmym6wu8L/n5pG70G2uPlY3k5GV2dHZZi2F6Dl/QSYExe906lNU4sOkp2i4dt
         xU/dFVgD9qZuQ0tuq1kydTBc523iXaVTuzcxNZbql3kVpQSLuwXf2MOSXasp27vyki6n
         Fzo5wodl4RxrxuZyHuRvnskQ3uCYyPh508tLmMi+0JXQE72KE3nijrf54u/Gb4yhCNwz
         AUQmEnJEWjpvXk3oZaBXX0ntIJenkdyeVeelf8jn3S46O8E7g2S2hMzcrBKuORknMv+r
         6QEY1MIVaqStW8ISClRqfOLPZihuRvwZU+wpKwdZ/NanyYdexcdqYDcwqsToa89IrK4m
         QLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyxe+CH68uktfq8bo3UKcka5hykVJJAZQsYOM6ktq0o=;
        b=yzAxNUiIhmL2O9TAgL6Kuo1fTglQ/DoJw8bMXdYrPiVq7Z/Qu0UALRRKpGbzuC0W1q
         v7jGpW0bsNylQ3l0jY7pf2N70pAisZ5IW1tAiDIBAz4y38Rgq2kGbEy2YTa3mbvLUZa5
         7VI9sd+Bmq9HgfiqQs1X8Q9GzvGz53Gjj97dhTee39RlnbX4mP4L+fF8ZVcqx5NDreOM
         V5O6QAKCvzeGeeucjtESgKM35dIZqVn4FRNPrP8RzGUXEkn6g120srBKeo9Xf7opVzEZ
         T8bw//l/43njjUzcRNm9GwSPLPWUBkiTv5IzO5p741FlzNUONsOVz2HVyW5NESBh+5Nc
         5L1Q==
X-Gm-Message-State: ANoB5plT4bngJcworRAoYWwGAaW7qJ75l0uOgb+CcnvH3rG0cimu2gP8
        YS07cnkp6LaAz8+5CRB+Rk6Eies05o0=
X-Google-Smtp-Source: AA0mqf7MsDYPPzLZWslULJKtoj26wOqK1prDHurU1XL3jYTlD4850oEv2GWogL5hRYCyWZlhWkvjqdVgQXo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce90:b0:186:b46d:da5e with SMTP id
 f16-20020a170902ce9000b00186b46dda5emr50515043plg.92.1669937222334; Thu, 01
 Dec 2022 15:27:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Dec 2022 23:26:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201232655.290720-1-seanjc@google.com>
Subject: [PATCH 00/16] x86/reboot: KVM: Clean up "emergency" virt code
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Andrew Cooper <Andrew.Cooper3@citrix.com>
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

This applies on 

  git://git.kernel.org/pub/scm/virt/kvm/kvm.git kvm/queue

plus two series (order shouldn't matter)

 1. https://lore.kernel.org/all/20221130233650.1404148-1-seanjc@google.com
 2. https://lore.kernel.org/all/20221130230934.1014142-1-seanjc@google.com

#1 is a cleanup of the related NMI shootdown logic.  #2 is a large overhaul
of code surrouding KVM's hardware enabling/disabling.  If/when folks are
happy with this series, my preference is to take it through the KVM tree as
I'm hoping #1 will get merged sooner than later (bug fixes), and there are
non-trivial conflicts with #2.

Sean Christopherson (16):
  x86/reboot: VMCLEAR active VMCSes before emergency reboot
  x86/reboot: Expose VMCS crash hooks if and only if KVM_INTEL is
    enabled
  x86/reboot: Harden virtualization hooks for emergency reboot
  x86/reboot: Assert that IRQs are disabled when turning off
    virtualization
  x86/reboot: KVM: Handle VMXOFF in KVM's reboot callback
  x86/reboot: KVM: Disable SVM during reboot via virt/KVM reboot
    callback
  x86/reboot: Hoist "disable virt" helpers above "emergency reboot" path
  x86/reboot: Disable virtualization during reboot iff callback is
    registered
  x86/virt: KVM: Open code cpu_has_vmx() in KVM VMX
  x86/virt: KVM: Move VMXOFF helpers into KVM VMX
  KVM: SVM: Make KVM_AMD depend on CPU_SUP_AMD or CPU_SUP_HYGON
  x86/virt: Drop unnecessary check on extended CPUID level in
    cpu_has_svm()
  x86/virt: KVM: Open code cpu_has_svm() into kvm_is_svm_supported()
  x86/virt: KVM: Move "disable SVM" helper into KVM SVM
  KVM: x86: Force kvm_rebooting=true during emergency reboot/crash
  KVM: SVM: Use "standard" stgi() helper when disabling SVM

 arch/x86/include/asm/kexec.h   |   2 -
 arch/x86/include/asm/reboot.h  |   7 ++
 arch/x86/include/asm/virtext.h | 151 ---------------------------------
 arch/x86/kernel/crash.c        |  31 -------
 arch/x86/kernel/reboot.c       |  59 ++++++++++---
 arch/x86/kvm/Kconfig           |   2 +-
 arch/x86/kvm/svm/svm.c         |  51 +++++++++--
 arch/x86/kvm/vmx/vmx.c         |  51 +++++++----
 8 files changed, 133 insertions(+), 221 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h


base-commit: 02f831ac0dcd7593f8dbb5495135406ffd55952c
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

