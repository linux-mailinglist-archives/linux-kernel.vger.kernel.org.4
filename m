Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38C2617244
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKBXYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKBXWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:22:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A7B4A9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:20:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nl16-20020a17090b385000b002138288fd51so2483031pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rSa4y9kps1FwZ8rvDofblpLG3n0hs9E0e/lXRBoTFSo=;
        b=XtqDOfUxdGXVB5CJPVM/S0NQFC5ha4DlW973RpZTGYauGhNLnnIT+D+vb6xdIHo5U8
         kdaGwcOEI5bMjUseRBDq86ZN00kL8tGXi34VwxB9E01LBNN3hvCcP1P+3FXLUXHtMhof
         hQBXGuJh9l1tz+2R1fqA4d9idD95/Bg9fabpo4/GkLTxItTbUeY4X4v42/3g/u3IHhVQ
         NDIksalVevkz5FZUZsCqkQXrdpqz7EI94CNbCk8OHMOJ6j5zZwWWXd6z1gDjZ9VkR2ll
         Z2O7sbeVk41qeiVV3up9kHhoH2RiJDi46VATGbyfAU0pSL2QNT2E6fHEvOZw6fTHcFbN
         UGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSa4y9kps1FwZ8rvDofblpLG3n0hs9E0e/lXRBoTFSo=;
        b=DGoessCb79/Fk01769zjvLAQPbDHLReCBzF3+1jgOdIQUgq/LtB9o4DVR8+PRu0ek/
         uAukErPG5UacdVP6R5/YPMaw60O8/UX7vraaoGjFPJRvWLxlwRWz51K4X/835ZBywU2Q
         CMJGQFNsRYLCL602h0UhhC3kWXV0Fh6CmeaP0L6GR9fytP3WZxHd7WmJgE/NmZG1HSCb
         ADZ9rLNFbrBbq+xU6hF6WFyKCKnkVi2fcW9eMrJODcufEMaP74PZygk2/KMLTUF13q+X
         jJCHY4MB4plJ1nQ4eh3pUVYdqdcYchLQZ2qHagAquEJcDvzj+p5vy9xVK6vQgJ1dfnCy
         AVPw==
X-Gm-Message-State: ACrzQf3/MfNCfxmN3V7Jqugj3K1Z8XXTa2jmhJzyKDoxl2lThpuCXFYn
        ECWZ4forLnxfianUJtw5TB+nwqw7/Ss=
X-Google-Smtp-Source: AMsMyM7EuOua3GoPnBrMaaE+24Y6jEpfd+Yf8+7hAW36N3q7lg2WtSLEetXGYDlkyprsEZ0WR5guOQzDseg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f291:b0:20a:eab5:cf39 with SMTP id
 fs17-20020a17090af29100b0020aeab5cf39mr150613pjb.1.1667431208796; Wed, 02 Nov
 2022 16:20:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:18:59 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-33-seanjc@google.com>
Subject: [PATCH 32/44] KVM: x86: Unify pr_fmt to use module name for all KVM modules
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pr_fmt using KBUILD_MODNAME for all KVM x86 code so that printks
use consistent formatting across common x86, Intel, and AMD code.  In
addition to providing consistent print formatting, using KBUILD_MODNAME,
e.g. kvm_amd and kvm_intel, allows referencing SVM and VMX (and SEV and
SGX and ...) as technologies without generating weird messages, and
without causing naming conflicts with other kernel code, e.g. "SEV: ",
"tdx: ", "sgx: " etc.. are all used by the kernel for non-KVM subsystems.

Opportunistically move away from printk() for prints that need to be
modified anyways, e.g. to drop a manual "kvm: " prefix.

Opportunistically convert a few SGX WARNs that are similarly modified to
WARN_ONCE; in the very unlikely event that the WARNs fire, odds are good
that they would fire repeatedly and spam the kernel log without providing
unique information in each print.

Note, defining pr_fmt yields undesirable results for code that uses KVM's
printk wrappers, e.g. vcpu_unimpl().  But, that's a pre-existing problem
as SVM/kvm_amd already defines a pr_fmt, and thankfully use of KVM's
wrappers is relatively limited in KVM x86 code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c            |  1 +
 arch/x86/kvm/debugfs.c          |  2 ++
 arch/x86/kvm/emulate.c          |  1 +
 arch/x86/kvm/hyperv.c           |  1 +
 arch/x86/kvm/i8254.c            |  4 ++--
 arch/x86/kvm/i8259.c            |  4 +++-
 arch/x86/kvm/ioapic.c           |  1 +
 arch/x86/kvm/irq.c              |  1 +
 arch/x86/kvm/irq_comm.c         |  7 +++---
 arch/x86/kvm/kvm_onhyperv.c     |  1 +
 arch/x86/kvm/lapic.c            |  8 +++----
 arch/x86/kvm/mmu/mmu.c          |  6 ++---
 arch/x86/kvm/mmu/page_track.c   |  1 +
 arch/x86/kvm/mmu/spte.c         |  4 ++--
 arch/x86/kvm/mmu/spte.h         |  4 ++--
 arch/x86/kvm/mmu/tdp_iter.c     |  1 +
 arch/x86/kvm/mmu/tdp_mmu.c      |  1 +
 arch/x86/kvm/mtrr.c             |  1 +
 arch/x86/kvm/pmu.c              |  1 +
 arch/x86/kvm/smm.c              |  1 +
 arch/x86/kvm/svm/avic.c         |  2 +-
 arch/x86/kvm/svm/nested.c       |  2 +-
 arch/x86/kvm/svm/pmu.c          |  2 ++
 arch/x86/kvm/svm/sev.c          |  1 +
 arch/x86/kvm/svm/svm.c          | 10 ++++-----
 arch/x86/kvm/svm/svm_onhyperv.c |  1 +
 arch/x86/kvm/svm/svm_onhyperv.h |  4 ++--
 arch/x86/kvm/vmx/evmcs.c        |  1 +
 arch/x86/kvm/vmx/evmcs.h        |  4 +---
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 arch/x86/kvm/vmx/pmu_intel.c    |  5 +++--
 arch/x86/kvm/vmx/posted_intr.c  |  2 ++
 arch/x86/kvm/vmx/sgx.c          |  5 +++--
 arch/x86/kvm/vmx/vmcs12.c       |  1 +
 arch/x86/kvm/vmx/vmx.c          | 40 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx_ops.h      |  4 ++--
 arch/x86/kvm/x86.c              | 28 ++++++++++++-----------
 arch/x86/kvm/xen.c              |  1 +
 38 files changed, 97 insertions(+), 70 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fb9b139023af..e2d02f655e96 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -8,6 +8,7 @@
  * Copyright 2011 Red Hat, Inc. and/or its affiliates.
  * Copyright IBM Corporation, 2008
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/export.h>
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index c1390357126a..ee8c4c3496ed 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -4,6 +4,8 @@
  *
  * Copyright 2016 Red Hat, Inc. and/or its affiliates.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kvm_host.h>
 #include <linux/debugfs.h>
 #include "lapic.h"
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5cc3efa0e21c..c3443045cd93 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -17,6 +17,7 @@
  *
  * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include "kvm_cache_regs.h"
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0adf4a437e85..5a5f0d882df3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -17,6 +17,7 @@
  *   Ben-Ami Yassour <benami@il.ibm.com>
  *   Andrey Smetanin <asmetanin@virtuozzo.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "x86.h"
 #include "lapic.h"
diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index e0a7a0e7a73c..cd57a517d04a 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -30,7 +30,7 @@
  *   Based on QEMU and Xen.
  */
 
-#define pr_fmt(fmt) "pit: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/slab.h>
@@ -351,7 +351,7 @@ static void create_pit_timer(struct kvm_pit *pit, u32 val, int is_period)
 
 		if (ps->period < min_period) {
 			pr_info_ratelimited(
-			    "kvm: requested %lld ns "
+			    "requested %lld ns "
 			    "i8254 timer period limited to %lld ns\n",
 			    ps->period, min_period);
 			ps->period = min_period;
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index e1bb6218bb96..4756bcb5724f 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -26,6 +26,8 @@
  *   Yaozu (Eddie) Dong <Eddie.dong@intel.com>
  *   Port from Qemu.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
@@ -35,7 +37,7 @@
 #include "trace.h"
 
 #define pr_pic_unimpl(fmt, ...)	\
-	pr_err_ratelimited("kvm: pic: " fmt, ## __VA_ARGS__)
+	pr_err_ratelimited("pic: " fmt, ## __VA_ARGS__)
 
 static void pic_irq_request(struct kvm *kvm, int level);
 
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 765943d7cfa5..042dee556125 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -26,6 +26,7 @@
  *  Yaozu (Eddie) Dong <eddie.dong@intel.com>
  *  Based on Xen 3.1 code.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index f371f1292ca3..4e6c06632c8f 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -7,6 +7,7 @@
  * Authors:
  *   Yaozu (Eddie) Dong <Eddie.dong@intel.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/export.h>
 #include <linux/kvm_host.h>
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 0687162c4f22..d48eaeacf803 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -8,6 +8,7 @@
  *
  * Copyright 2010 Red Hat, Inc. and/or its affiliates.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/slab.h>
@@ -56,7 +57,7 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 
 	if (irq->dest_mode == APIC_DEST_PHYSICAL &&
 	    irq->dest_id == 0xff && kvm_lowest_prio_delivery(irq)) {
-		printk(KERN_INFO "kvm: apic: phys broadcast and lowest prio\n");
+		pr_info("apic: phys broadcast and lowest prio\n");
 		irq->delivery_mode = APIC_DM_FIXED;
 	}
 
@@ -199,7 +200,7 @@ int kvm_request_irq_source_id(struct kvm *kvm)
 	irq_source_id = find_first_zero_bit(bitmap, BITS_PER_LONG);
 
 	if (irq_source_id >= BITS_PER_LONG) {
-		printk(KERN_WARNING "kvm: exhaust allocatable IRQ sources!\n");
+		pr_warn("exhausted allocatable IRQ sources!\n");
 		irq_source_id = -EFAULT;
 		goto unlock;
 	}
@@ -221,7 +222,7 @@ void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id)
 	mutex_lock(&kvm->irq_lock);
 	if (irq_source_id < 0 ||
 	    irq_source_id >= BITS_PER_LONG) {
-		printk(KERN_ERR "kvm: IRQ source ID out of range!\n");
+		pr_err("IRQ source ID out of range!\n");
 		goto unlock;
 	}
 	clear_bit(irq_source_id, &kvm->arch.irq_sources_bitmap);
diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
index ee4f696a0782..482d6639ef88 100644
--- a/arch/x86/kvm/kvm_onhyperv.c
+++ b/arch/x86/kvm/kvm_onhyperv.c
@@ -2,6 +2,7 @@
 /*
  * KVM L1 hypervisor optimizations on Hyper-V.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <asm/mshyperv.h>
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 1bb63746e991..9335c4b05760 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -15,6 +15,7 @@
  *
  * Based on Xen 3.1 code, Copyright (c) 2004, Intel Corporation.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
@@ -942,8 +943,7 @@ static void kvm_apic_disabled_lapic_found(struct kvm *kvm)
 {
 	if (!kvm->arch.disabled_lapic_found) {
 		kvm->arch.disabled_lapic_found = true;
-		printk(KERN_INFO
-		       "Disabled LAPIC found during irq injection\n");
+		pr_info("Disabled LAPIC found during irq injection\n");
 	}
 }
 
@@ -1561,7 +1561,7 @@ static void limit_periodic_timer_frequency(struct kvm_lapic *apic)
 
 		if (apic->lapic_timer.period < min_period) {
 			pr_info_ratelimited(
-			    "kvm: vcpu %i: requested %lld ns "
+			    "vcpu %i: requested %lld ns "
 			    "lapic timer period limited to %lld ns\n",
 			    apic->vcpu->vcpu_id,
 			    apic->lapic_timer.period, min_period);
@@ -1846,7 +1846,7 @@ static bool set_target_expiration(struct kvm_lapic *apic, u32 count_reg)
 				deadline = apic->lapic_timer.period;
 			else if (unlikely(deadline > apic->lapic_timer.period)) {
 				pr_info_ratelimited(
-				    "kvm: vcpu %i: requested lapic timer restore with "
+				    "vcpu %i: requested lapic timer restore with "
 				    "starting count register %#x=%u (%lld ns) > initial count (%lld ns). "
 				    "Using initial count to start timer.\n",
 				    apic->vcpu->vcpu_id,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f8c92a4a35fa..e5a0252fa6ac 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -14,6 +14,7 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  *   Avi Kivity   <avi@qumranet.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "irq.h"
 #include "ioapic.h"
@@ -3399,8 +3400,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 
 		if (++retry_count > 4) {
-			printk_once(KERN_WARNING
-				"kvm: Fast #PF retrying more than 4 times.\n");
+			pr_warn_once("Fast #PF retrying more than 4 times.\n");
 			break;
 		}
 
@@ -6537,7 +6537,7 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 	 * zap all shadow pages.
 	 */
 	if (unlikely(gen == 0)) {
-		kvm_debug_ratelimited("kvm: zapping shadow pages for mmio generation wraparound\n");
+		kvm_debug_ratelimited("zapping shadow pages for mmio generation wraparound\n");
 		kvm_mmu_zap_all_fast(kvm);
 	}
 }
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 2e09d1b6249f..0a2ac438d647 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -10,6 +10,7 @@
  * Author:
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <linux/rculist.h>
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 2e08b2a45361..f00fbfdea706 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2006 Qumranet, Inc.
  * Copyright 2020 Red Hat, Inc. and/or its affiliates.
  */
-
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include "mmu.h"
@@ -340,7 +340,7 @@ u64 mark_spte_for_access_track(u64 spte)
 
 	WARN_ONCE(spte & (SHADOW_ACC_TRACK_SAVED_BITS_MASK <<
 			  SHADOW_ACC_TRACK_SAVED_BITS_SHIFT),
-		  "kvm: Access Tracking saved bit locations are not zero\n");
+		  "Access Tracking saved bit locations are not zero\n");
 
 	spte |= (spte & SHADOW_ACC_TRACK_SAVED_BITS_MASK) <<
 		SHADOW_ACC_TRACK_SAVED_BITS_SHIFT;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 79560d77aa4c..922c838ff9a6 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -418,11 +418,11 @@ static inline void check_spte_writable_invariants(u64 spte)
 {
 	if (spte & shadow_mmu_writable_mask)
 		WARN_ONCE(!(spte & shadow_host_writable_mask),
-			  "kvm: MMU-writable SPTE is not Host-writable: %llx",
+			  KBUILD_MODNAME ": MMU-writable SPTE is not Host-writable: %llx",
 			  spte);
 	else
 		WARN_ONCE(is_writable_pte(spte),
-			  "kvm: Writable SPTE is not MMU-writable: %llx", spte);
+			  KBUILD_MODNAME ": Writable SPTE is not MMU-writable: %llx", spte);
 }
 
 static inline bool is_mmu_writable_spte(u64 spte)
diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 39b48e7d7d1a..e26e744df1d1 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "mmu_internal.h"
 #include "tdp_iter.h"
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 672f0432d777..42bb031f33b9 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "mmu.h"
 #include "mmu_internal.h"
diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index a8502e02f479..9fac1ec03463 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -13,6 +13,7 @@
  *   Paolo Bonzini <pbonzini@redhat.com>
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include <asm/mtrr.h>
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d9b9a0f0db17..db37fcb8f112 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -9,6 +9,7 @@
  *   Gleb Natapov <gleb@redhat.com>
  *   Wei Huang    <wei@redhat.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/types.h>
 #include <linux/kvm_host.h>
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 39e5e2c3498b..137575ff3074 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include "x86.h"
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6919dee69f18..f52f5e0dd465 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -12,7 +12,7 @@
  *   Avi Kivity   <avi@qumranet.com>
  */
 
-#define pr_fmt(fmt) "SVM: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_types.h>
 #include <linux/hashtable.h>
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b258d6988f5d..b79fe8612747 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -12,7 +12,7 @@
  *   Avi Kivity   <avi@qumranet.com>
  */
 
-#define pr_fmt(fmt) "SVM: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index b68956299fa8..13f0eeaebd55 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -9,6 +9,8 @@
  *
  * Implementation is based on pmu_intel.c file
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/kvm_host.h>
 #include <linux/perf_event.h>
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c0c9ed5e279c..ac78ca3e87da 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -6,6 +6,7 @@
  *
  * Copyright 2010 Red Hat, Inc. and/or its affiliates.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 13457aa68112..3c48fb837302 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1,4 +1,4 @@
-#define pr_fmt(fmt) "SVM: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 
@@ -2082,7 +2082,7 @@ static void svm_handle_mce(struct kvm_vcpu *vcpu)
 		 * Erratum 383 triggered. Guest state is corrupt so kill the
 		 * guest.
 		 */
-		pr_err("KVM: Guest triggered AMD Erratum 383\n");
+		pr_err("Guest triggered AMD Erratum 383\n");
 
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
@@ -4665,7 +4665,7 @@ static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	smap = cr4 & X86_CR4_SMAP;
 	is_user = svm_get_cpl(vcpu) == 3;
 	if (smap && (!smep || is_user)) {
-		pr_err_ratelimited("KVM: SEV Guest triggered AMD Erratum 1096\n");
+		pr_err_ratelimited("SEV Guest triggered AMD Erratum 1096\n");
 
 		/*
 		 * If the fault occurred in userspace, arbitrarily inject #GP
@@ -5013,7 +5013,7 @@ static __init int svm_hardware_setup(void)
 	}
 
 	if (nested) {
-		printk(KERN_INFO "kvm: Nested Virtualization enabled\n");
+		pr_info("Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
 
@@ -5031,7 +5031,7 @@ static __init int svm_hardware_setup(void)
 	/* Force VM NPT level equal to the host's paging level */
 	kvm_configure_mmu(npt_enabled, get_npt_level(),
 			  get_npt_level(), PG_LEVEL_1G);
-	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
+	pr_info("Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
 
 	/* Setup shadow_me_value and shadow_me_mask */
 	kvm_mmu_set_me_spte_mask(sme_me_mask, sme_me_mask);
diff --git a/arch/x86/kvm/svm/svm_onhyperv.c b/arch/x86/kvm/svm/svm_onhyperv.c
index 8cdc62c74a96..34be6026101d 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.c
+++ b/arch/x86/kvm/svm/svm_onhyperv.c
@@ -2,6 +2,7 @@
 /*
  * KVM L1 hypervisor optimizations on Hyper-V for SVM.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index e2fc59380465..28fb6706804a 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -32,7 +32,7 @@ static inline void svm_hv_hardware_setup(void)
 {
 	if (npt_enabled &&
 	    ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB) {
-		pr_info("kvm: Hyper-V enlightened NPT TLB flush enabled\n");
+		pr_info(KBUILD_MODNAME ": Hyper-V enlightened NPT TLB flush enabled\n");
 		svm_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
 		svm_x86_ops.tlb_remote_flush_with_range =
 				hv_remote_flush_tlb_with_range;
@@ -41,7 +41,7 @@ static inline void svm_hv_hardware_setup(void)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH) {
 		int cpu;
 
-		pr_info("kvm: Hyper-V Direct TLB Flush enabled\n");
+		pr_info(KBUILD_MODNAME ": Hyper-V Direct TLB Flush enabled\n");
 		for_each_online_cpu(cpu) {
 			struct hv_vp_assist_page *vp_ap =
 				hv_get_vp_assist_page(cpu);
diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index d8b23c96d627..96b705f1cfdf 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
 #include <linux/smp.h>
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 6f746ef3c038..8f8bb262e07c 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -115,9 +115,7 @@ static __always_inline int get_evmcs_offset(unsigned long field,
 {
 	int offset = evmcs_field_offset(field, clean_field);
 
-	WARN_ONCE(offset < 0, "KVM: accessing unsupported EVMCS field %lx\n",
-		  field);
-
+	WARN_ONCE(offset < 0, "accessing unsupported EVMCS field %lx\n", field);
 	return offset;
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 61a2e551640a..1ff1fc6e9107 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/objtool.h>
 #include <linux/percpu.h>
@@ -204,7 +205,7 @@ static void nested_vmx_abort(struct kvm_vcpu *vcpu, u32 indicator)
 {
 	/* TODO: not to reset guest simply here. */
 	kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
-	pr_debug_ratelimited("kvm: nested vmx abort, indicator %d\n", indicator);
+	pr_debug_ratelimited("nested vmx abort, indicator %d\n", indicator);
 }
 
 static inline bool vmx_control_verify(u32 control, u32 low, u32 high)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 25b70a85bef5..968f9762081f 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -8,6 +8,8 @@
  *   Avi Kivity   <avi@redhat.com>
  *   Gleb Natapov <gleb@redhat.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/types.h>
 #include <linux/kvm_host.h>
 #include <linux/perf_event.h>
@@ -763,8 +765,7 @@ void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu)
 	return;
 
 warn:
-	pr_warn_ratelimited("kvm: vcpu-%d: fail to passthrough LBR.\n",
-		vcpu->vcpu_id);
+	pr_warn_ratelimited("vcpu-%d: fail to passthrough LBR.\n", vcpu->vcpu_id);
 }
 
 static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 1b56c5e5c9fb..94c38bea60e7 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kvm_host.h>
 
 #include <asm/irq_remapping.h>
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 8f95c7c01433..a6ac83d4b6ad 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2021 Intel Corporation. */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/sgx.h>
 
@@ -164,7 +165,7 @@ static int __handle_encls_ecreate(struct kvm_vcpu *vcpu,
 	if (!vcpu->kvm->arch.sgx_provisioning_allowed &&
 	    (attributes & SGX_ATTR_PROVISIONKEY)) {
 		if (sgx_12_1->eax & SGX_ATTR_PROVISIONKEY)
-			pr_warn_once("KVM: SGX PROVISIONKEY advertised but not allowed\n");
+			pr_warn_once("SGX PROVISIONKEY advertised but not allowed\n");
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -379,7 +380,7 @@ int handle_encls(struct kvm_vcpu *vcpu)
 			return handle_encls_ecreate(vcpu);
 		if (leaf == EINIT)
 			return handle_encls_einit(vcpu);
-		WARN(1, "KVM: unexpected exit on ENCLS[%u]", leaf);
+		WARN_ONCE(1, "unexpected exit on ENCLS[%u]", leaf);
 		vcpu->run->exit_reason = KVM_EXIT_UNKNOWN;
 		vcpu->run->hw.hardware_exit_reason = EXIT_REASON_ENCLS;
 		return 0;
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 2251b60920f8..106a72c923ca 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "vmcs12.h"
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a563c9756e36..1b645f52cd8d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -12,6 +12,7 @@
  *   Avi Kivity   <avi@qumranet.com>
  *   Yaniv Kamay  <yaniv@qumranet.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/highmem.h>
 #include <linux/hrtimer.h>
@@ -445,36 +446,36 @@ void vmread_error(unsigned long field, bool fault)
 	if (fault)
 		kvm_spurious_fault();
 	else
-		vmx_insn_failed("kvm: vmread failed: field=%lx\n", field);
+		vmx_insn_failed("vmread failed: field=%lx\n", field);
 }
 
 noinline void vmwrite_error(unsigned long field, unsigned long value)
 {
-	vmx_insn_failed("kvm: vmwrite failed: field=%lx val=%lx err=%u\n",
+	vmx_insn_failed("vmwrite failed: field=%lx val=%lx err=%u\n",
 			field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
 }
 
 noinline void vmclear_error(struct vmcs *vmcs, u64 phys_addr)
 {
-	vmx_insn_failed("kvm: vmclear failed: %p/%llx err=%u\n",
+	vmx_insn_failed("vmclear failed: %p/%llx err=%u\n",
 			vmcs, phys_addr, vmcs_read32(VM_INSTRUCTION_ERROR));
 }
 
 noinline void vmptrld_error(struct vmcs *vmcs, u64 phys_addr)
 {
-	vmx_insn_failed("kvm: vmptrld failed: %p/%llx err=%u\n",
+	vmx_insn_failed("vmptrld failed: %p/%llx err=%u\n",
 			vmcs, phys_addr, vmcs_read32(VM_INSTRUCTION_ERROR));
 }
 
 noinline void invvpid_error(unsigned long ext, u16 vpid, gva_t gva)
 {
-	vmx_insn_failed("kvm: invvpid failed: ext=0x%lx vpid=%u gva=0x%lx\n",
+	vmx_insn_failed("invvpid failed: ext=0x%lx vpid=%u gva=0x%lx\n",
 			ext, vpid, gva);
 }
 
 noinline void invept_error(unsigned long ext, u64 eptp, gpa_t gpa)
 {
-	vmx_insn_failed("kvm: invept failed: ext=0x%lx eptp=%llx gpa=0x%llx\n",
+	vmx_insn_failed("invept failed: ext=0x%lx eptp=%llx gpa=0x%llx\n",
 			ext, eptp, gpa);
 }
 
@@ -578,7 +579,7 @@ static __init void hv_setup_evmcs(void)
 		}
 
 		if (enlightened_vmcs) {
-			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS\n");
+			pr_info("Using Hyper-V Enlightened VMCS\n");
 			static_branch_enable(&enable_evmcs);
 		}
 
@@ -1679,8 +1680,8 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 		if (!instr_len)
 			goto rip_updated;
 
-		WARN(exit_reason.enclave_mode,
-		     "KVM: skipping instruction after SGX enclave VM-Exit");
+		WARN_ONCE(exit_reason.enclave_mode,
+			  "skipping instruction after SGX enclave VM-Exit");
 
 		orig_rip = kvm_rip_read(vcpu);
 		rip = orig_rip + instr_len;
@@ -2986,9 +2987,8 @@ static void fix_rmode_seg(int seg, struct kvm_segment *save)
 		var.type = 0x3;
 		var.avl = 0;
 		if (save->base & 0xf)
-			printk_once(KERN_WARNING "kvm: segment base is not "
-					"paragraph aligned when entering "
-					"protected mode (seg=%d)", seg);
+			pr_warn_once("segment base is not paragraph aligned "
+				     "when entering protected mode (seg=%d)", seg);
 	}
 
 	vmcs_write16(sf->selector, var.selector);
@@ -3018,8 +3018,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
 	 * vcpu. Warn the user that an update is overdue.
 	 */
 	if (!kvm_vmx->tss_addr)
-		printk_once(KERN_WARNING "kvm: KVM_SET_TSS_ADDR need to be "
-			     "called before entering vcpu\n");
+		pr_warn_once("KVM_SET_TSS_ADDR needs to be called before running vCPU\n");
 
 	vmx_segment_cache_clear(vmx);
 
@@ -6880,7 +6879,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 	gate_desc *desc = (gate_desc *)host_idt_base + vector;
 
 	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
-	    "KVM: unexpected VM-Exit interrupt info: 0x%x", intr_info))
+	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
 
 	handle_interrupt_nmi_irqoff(vcpu, gate_offset(desc));
@@ -7485,7 +7484,7 @@ static int __init vmx_check_processor_compat(void)
 
 	if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
 	    !this_cpu_has(X86_FEATURE_VMX)) {
-		pr_err("kvm: VMX is disabled on CPU %d\n", smp_processor_id());
+		pr_err("VMX is disabled on CPU %d\n", smp_processor_id());
 		return -EIO;
 	}
 
@@ -7494,8 +7493,7 @@ static int __init vmx_check_processor_compat(void)
 	if (nested)
 		nested_vmx_setup_ctls_msrs(&vmcs_conf, vmx_cap.ept);
 	if (memcmp(&vmcs_config, &vmcs_conf, sizeof(struct vmcs_config)) != 0) {
-		printk(KERN_ERR "kvm: CPU %d feature inconsistency!\n",
-				smp_processor_id());
+		pr_err("CPU %d feature inconsistency!\n", smp_processor_id());
 		return -EIO;
 	}
 	return 0;
@@ -8294,7 +8292,7 @@ static __init int hardware_setup(void)
 		return -EIO;
 
 	if (cpu_has_perf_global_ctrl_bug())
-		pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
+		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
 			     "does not work properly. Using workaround\n");
 
 	if (boot_cpu_has(X86_FEATURE_NX))
@@ -8302,7 +8300,7 @@ static __init int hardware_setup(void)
 
 	if (boot_cpu_has(X86_FEATURE_MPX)) {
 		rdmsrl(MSR_IA32_BNDCFGS, host_bndcfgs);
-		WARN_ONCE(host_bndcfgs, "KVM: BNDCFGS in host will be lost");
+		WARN_ONCE(host_bndcfgs, "BNDCFGS in host will be lost");
 	}
 
 	if (!cpu_has_vmx_mpx())
@@ -8321,7 +8319,7 @@ static __init int hardware_setup(void)
 
 	/* NX support is required for shadow paging. */
 	if (!enable_ept && !boot_cpu_has(X86_FEATURE_NX)) {
-		pr_err_ratelimited("kvm: NX (Execute Disable) not supported\n");
+		pr_err_ratelimited("NX (Execute Disable) not supported\n");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index ec268df83ed6..ac52ef9ca561 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -86,8 +86,8 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 	return value;
 
 do_fail:
-	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
-	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);
+	WARN_ONCE(1, KBUILD_MODNAME ": vmread failed: field=%lx\n", field);
+	pr_warn_ratelimited(KBUILD_MODNAME ": vmread failed: field=%lx\n", field);
 	return 0;
 
 do_exception:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5b7b551ae44b..39675b9662d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -15,6 +15,7 @@
  *   Amit Shah    <amit.shah@qumranet.com>
  *   Ben-Ami Yassour <benami@il.ibm.com>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
 #include "irq.h"
@@ -2089,7 +2090,7 @@ static int kvm_emulate_monitor_mwait(struct kvm_vcpu *vcpu, const char *insn)
 	    !guest_cpuid_has(vcpu, X86_FEATURE_MWAIT))
 		return kvm_handle_invalid_op(vcpu);
 
-	pr_warn_once("kvm: %s instruction emulated as NOP!\n", insn);
+	pr_warn_once("%s instruction emulated as NOP!\n", insn);
 	return kvm_emulate_as_nop(vcpu);
 }
 int kvm_emulate_mwait(struct kvm_vcpu *vcpu)
@@ -2438,7 +2439,8 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
 	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
 	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
 	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
-		pr_debug("kvm: requested TSC rate %u falls outside tolerance [%u,%u]\n", user_tsc_khz, thresh_lo, thresh_hi);
+		pr_debug("requested TSC rate %u falls outside tolerance [%u,%u]\n",
+			 user_tsc_khz, thresh_lo, thresh_hi);
 		use_scaling = 1;
 	}
 	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
@@ -7687,7 +7689,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	return X86EMUL_CONTINUE;
 
 emul_write:
-	printk_once(KERN_WARNING "kvm: emulating exchange as write\n");
+	pr_warn_once("emulating exchange as write\n");
 
 	return emulator_write_emulated(ctxt, addr, new, bytes, exception);
 }
@@ -8248,7 +8250,7 @@ static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
 
 	ctxt = kmem_cache_zalloc(x86_emulator_cache, GFP_KERNEL_ACCOUNT);
 	if (!ctxt) {
-		pr_err("kvm: failed to allocate vcpu's emulator\n");
+		pr_err("failed to allocate vcpu's emulator\n");
 		return NULL;
 	}
 
@@ -9303,17 +9305,17 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	int r, cpu;
 
 	if (kvm_x86_ops.hardware_enable) {
-		pr_err("kvm: already loaded vendor module '%s'\n", kvm_x86_ops.name);
+		pr_err("already loaded vendor module '%s'\n", kvm_x86_ops.name);
 		return -EEXIST;
 	}
 
 	if (!ops->cpu_has_kvm_support()) {
-		pr_err_ratelimited("kvm: no hardware support for '%s'\n",
+		pr_err_ratelimited("no hardware support for '%s'\n",
 				   ops->runtime_ops->name);
 		return -EOPNOTSUPP;
 	}
 	if (ops->disabled_by_bios()) {
-		pr_err_ratelimited("kvm: support for '%s' disabled by bios\n",
+		pr_err_ratelimited("support for '%s' disabled by bios\n",
 				   ops->runtime_ops->name);
 		return -EOPNOTSUPP;
 	}
@@ -9324,7 +9326,7 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	 * vCPU's FPU state as a fxregs_state struct.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_FPU) || !boot_cpu_has(X86_FEATURE_FXSR)) {
-		printk(KERN_ERR "kvm: inadequate fpu\n");
+		pr_err("inadequate fpu\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -9342,19 +9344,19 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	 */
 	if (rdmsrl_safe(MSR_IA32_CR_PAT, &host_pat) ||
 	    (host_pat & GENMASK(2, 0)) != 6) {
-		pr_err("kvm: host PAT[0] is not WB\n");
+		pr_err("host PAT[0] is not WB\n");
 		return -EIO;
 	}
 
 	x86_emulator_cache = kvm_alloc_emulator_cache();
 	if (!x86_emulator_cache) {
-		pr_err("kvm: failed to allocate cache for x86 emulator\n");
+		pr_err("failed to allocate cache for x86 emulator\n");
 		return -ENOMEM;
 	}
 
 	user_return_msrs = alloc_percpu(struct kvm_user_return_msrs);
 	if (!user_return_msrs) {
-		printk(KERN_ERR "kvm: failed to allocate percpu kvm_user_return_msrs\n");
+		pr_err("failed to allocate percpu kvm_user_return_msrs\n");
 		r = -ENOMEM;
 		goto out_free_x86_emulator_cache;
 	}
@@ -11611,7 +11613,7 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
 	if (kvm_check_tsc_unstable() && kvm->created_vcpus)
-		pr_warn_once("kvm: SMP vm created on host with unstable TSC; "
+		pr_warn_once("SMP vm created on host with unstable TSC; "
 			     "guest TSC will not be reliable\n");
 
 	if (!kvm->arch.max_vcpu_ids)
@@ -11688,7 +11690,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		goto free_wbinvd_dirty_mask;
 
 	if (!fpu_alloc_guest_fpstate(&vcpu->arch.guest_fpu)) {
-		pr_err("kvm: failed to allocate vcpu's fpu\n");
+		pr_err("failed to allocate vcpu's fpu\n");
 		goto free_emulate_ctxt;
 	}
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 2dae413bd62a..74eb3c47a340 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -5,6 +5,7 @@
  *
  * KVM Xen emulation
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "x86.h"
 #include "xen.h"
-- 
2.38.1.431.g37b22c650d-goog

