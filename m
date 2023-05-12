Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C22E7012A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbjELXue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbjELXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:50:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30831737
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5309b380b41so697481a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935430; x=1686527430;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOnJ9xJztukkbWobx7LZ+dJafNK2aLEAFwkDyM5Z4k0=;
        b=WdGoaQYf0ZC3fzYn/JkCyBl1g/pzBQtXwu9n+LoP1TM9nXmjn5uc5mhUyFoDlT5axW
         loY5DFgEcsI2mkhpKf89E9LM3feQpb80Qt3mSfR2nOscBqzn6L7vsJ1oU4qBWc8KjUMl
         n8ONEfPm1WPua2qNw3NANlS3Qmzapacc1MJMXTfIULIM1RWPuf8afL8fHppbNK/dOUBx
         1S8YemTBUz+gNyoeHQNNweEKGsvvL5Y2KF+k4Usz56ErgqLIgtH8wMzdFR8701ZtPf4r
         I7upAX9/AwQzBI813KcnU3fBl1iXCKoIXH+vyyrUKevgM42CzQcyDDL0fO3qP5wVo2qF
         wAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935430; x=1686527430;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOnJ9xJztukkbWobx7LZ+dJafNK2aLEAFwkDyM5Z4k0=;
        b=KQ8fzftt72TE2T2ZmS4+tY6GVMIYiC45RQox4pbdTFZZvIR//ukZbvBz7V5Q/4Ky4V
         K71BKA86KnGc6wKjAUSlJHD+NZKQMYPNY1ciKbirsYxJ+LVyLplM60j/FnGtWDaScIhf
         qN11e6IaSgBhgFXADUxCD7NyRCNxmj6qSRzsynyHOmOA2IahaAw5c7hAVD8r1EJhgYXg
         s50kgtk3y+XRDu3DlVsEu5DaEL/d2brjv7TZwdHPPwwuZaJf75UZyhoq+qmGPJ09Ktg2
         uhWplpdpN8xV5IDqElTAdg0zyQ9A/lFPjZouYJXLqwxfaCKYHJYINqxnfllxfPOaBu39
         18Qg==
X-Gm-Message-State: AC+VfDze2XNgLFHSVRkyDgC4cBHliP7wis28pdp7pTQwgpV2ecZTMblv
        AWxFQ9cA6Tlf2Es1uAuvRBgowiEVhVo=
X-Google-Smtp-Source: ACHHUZ7UTFBfbHDaJpR2CZa/9ilNO1ZdYpnEuBI8MEQ0z9u/B2TnTgW6/zNhg5IQ+BCrdTrpWUu6TwrjtAg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:115:0:b0:520:e728:8894 with SMTP id
 21-20020a630115000000b00520e7288894mr7203655pgb.5.1683935430245; Fri, 12 May
 2023 16:50:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-1-seanjc@google.com>
Subject: [PATCH v3 00/18] x86/reboot: KVM: Clean up "emergency" virt code
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

v3:
 - Massage changelogs to avoid talking about out-of-tree hypervisors. [Kai]
 - Move #ifdef "KVM" addition later. [Kai]

v2:
 - https://lore.kernel.org/all/20230310214232.806108-1-seanjc@google.com
 - Disable task migration when probing basic SVM and VMX support to avoid
   logging misleading info (wrong CPU) if probing fails.

v1: https://lore.kernel.org/all/20221201232655.290720-1-seanjc@google.com

Sean Christopherson (18):
  x86/reboot: VMCLEAR active VMCSes before emergency reboot
  x86/reboot: Harden virtualization hooks for emergency reboot
  x86/reboot: KVM: Handle VMXOFF in KVM's reboot callback
  x86/reboot: KVM: Disable SVM during reboot via virt/KVM reboot
    callback
  x86/reboot: Disable virtualization during reboot iff callback is
    registered
  x86/reboot: Assert that IRQs are disabled when turning off
    virtualization
  x86/reboot: Hoist "disable virt" helpers above "emergency reboot" path
  x86/reboot: Expose VMCS crash hooks if and only if KVM_{INTEL,AMD} is
    enabled
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
 arch/x86/kernel/reboot.c       |  66 ++++++++++----
 arch/x86/kvm/Kconfig           |   2 +-
 arch/x86/kvm/svm/svm.c         |  70 ++++++++++++---
 arch/x86/kvm/vmx/vmx.c         |  68 +++++++++++----
 8 files changed, 168 insertions(+), 232 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h


base-commit: b3c98052d46948a8d65d2778c7f306ff38366aac
-- 
2.40.1.606.ga4b1b128d6-goog

