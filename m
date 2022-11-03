Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B895461729D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKBX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKBXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:25:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D86439
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:20:46 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s82-20020a632c55000000b0046b2491aa95so94473pgs.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LaNeYxCMK/0HkG90K8r+zFwgVfimGLm91QPHwbaIpUg=;
        b=GS9ZjitRS3MgBey/6Gsgnoq2TONIjUD3b6x+Qo9VWBk4QgVEjGz27nqFsQsHit2TJi
         vD3EZREXHyZDYXYkIaYw23EJCulJtKHTZGn272/fXLoHSPdRKLlAjVBdf81Iw48Vn3IC
         05yzNtyxmh1tgwEByicnbP79WzVgeTcsKoNHLjoiizD1qOwUUC1Tu8C1pqtdcOiRefn8
         gWxIPUHv/TBdXXDaw/YnRhI+flEnjxqVdLjjz3Pf3vz+/i7ALiFEbLZZThj4ZQT5I5eH
         VGr8/x6gu6sMk9iTGyyFXf1/gW9mhk/DGzwnwrE6pOvFmRedO4vWQhwOOVeSHTcabmyr
         8dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LaNeYxCMK/0HkG90K8r+zFwgVfimGLm91QPHwbaIpUg=;
        b=EAfuIwXRlDSZj21tn0JNPZpD1syiP6a/VZ4sJS0pcID7UpBE8PPvHDepiAUhiWjNC5
         pM1pzKPIQRkWrvG9S3Kz+9Yn7Za1KFo+Bg/k2s3WQmHDpba7C8zHI4d/iIZXBXmRwCYV
         XnK5qzyVGHKToa79hw4X/Db5aZlq2rgvi7DQwrQEFUkn+sOariHtQ5RwnP67RYxm7rTx
         Gh913rxWMOjaQvbSmJsCAd65dEE0v7s9fTVLS99mWk9pC8tifPvNDuCsvcXpQsK0iUbV
         ADvxgWmLfXZfSCtjS1f6/XSY5kFXV0UxbnVecrXq3q5Q0XFXwsAriScaRxBjuUlzHrGh
         8WXg==
X-Gm-Message-State: ACrzQf1V8ffVsXw2vfTM91Z9Oo/IB0sakpKeeQoLH2/BkOVzFld3sGoD
        0HOAzfyAuXdxD1IL/hT78TIEUvKS+I4=
X-Google-Smtp-Source: AMsMyM6BcOmNf3NoXJ9k0LbSmLVgaxyU1NHnfLkf3krcoPPzAcNfRbjvVlhtF4UBH97poEqzcuaAjhPzixE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a94:b0:56d:5c36:7eb8 with SMTP id
 b20-20020a056a000a9400b0056d5c367eb8mr19861116pfl.38.1667431230154; Wed, 02
 Nov 2022 16:20:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Nov 2022 23:19:11 +0000
In-Reply-To: <20221102231911.3107438-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221102231911.3107438-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221102231911.3107438-45-seanjc@google.com>
Subject: [PATCH 44/44] KVM: Opt out of generic hardware enabling on s390 and PPC
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

Allow architectures to opt out of the generic hardware enabling logic,
and opt out on both s390 and PPC, which don't need to manually enable
virtualization as it's always on (when available).

In addition to letting s390 and PPC drop a bit of dead code, this will
hopefully also allow ARM to clean up its related code, e.g. ARM has its
own per-CPU flag to track which CPUs have enable hardware due to the
need to keep hardware enabled indefinitely when pKVM is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/Kconfig              |  1 +
 arch/mips/kvm/Kconfig               |  1 +
 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/powerpc.c          |  5 -----
 arch/riscv/kvm/Kconfig              |  1 +
 arch/s390/include/asm/kvm_host.h    |  1 -
 arch/s390/kvm/kvm-s390.c            |  6 ------
 arch/x86/kvm/Kconfig                |  1 +
 include/linux/kvm_host.h            |  4 ++++
 virt/kvm/Kconfig                    |  3 +++
 virt/kvm/kvm_main.c                 | 30 +++++++++++++++++++++++------
 11 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 815cc118c675..0a7d2116b27b 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -21,6 +21,7 @@ if VIRTUALIZATION
 menuconfig KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
+	select KVM_GENERIC_HARDWARE_ENABLING
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 91d197bee9c0..29e51649203b 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -28,6 +28,7 @@ config KVM
 	select MMU_NOTIFIER
 	select SRCU
 	select INTERVAL_TREE
+	select KVM_GENERIC_HARDWARE_ENABLING
 	help
 	  Support for hosting Guest kernels.
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0a80e80c7b9e..959f566a455c 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -876,7 +876,6 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 51268be60dac..ed426c9ee0e9 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -436,11 +436,6 @@ int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr,
 }
 EXPORT_SYMBOL_GPL(kvmppc_ld);
 
-int kvm_arch_hardware_enable(void)
-{
-	return 0;
-}
-
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	struct kvmppc_ops *kvm_ops = NULL;
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index f36a737d5f96..d5a658a047a7 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,6 +20,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
+	select KVM_GENERIC_HARDWARE_ENABLING
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select KVM_MMIO
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index b1e98a9ed152..d3e4b5d7013a 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -1023,7 +1023,6 @@ extern char sie_exit;
 extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
 extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
-static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 949231f1393e..129c159ab5ee 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -248,12 +248,6 @@ debug_info_t *kvm_s390_dbf;
 debug_info_t *kvm_s390_dbf_uv;
 
 /* Section: not file related */
-int kvm_arch_hardware_enable(void)
-{
-	/* every s390 is virtualization enabled ;-) */
-	return 0;
-}
-
 /* forward declarations */
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fbeaa9ddef59..8e578311ca9d 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -49,6 +49,7 @@ config KVM
 	select SRCU
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
+	select KVM_GENERIC_HARDWARE_ENABLING
 	help
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0b96d836a051..23c89c1e7788 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1441,8 +1441,10 @@ void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_
 static inline void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
 #endif
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
+#endif
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
@@ -2074,7 +2076,9 @@ static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
 	}
 }
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 extern bool kvm_rebooting;
+#endif
 
 extern unsigned int halt_poll_ns;
 extern unsigned int halt_poll_ns_grow;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 800f9470e36b..d28df77345e1 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -86,3 +86,6 @@ config KVM_XFER_TO_GUEST_WORK
 
 config HAVE_KVM_PM_NOTIFIER
        bool
+
+config KVM_GENERIC_HARDWARE_ENABLING
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 859bc27091cd..6736b36cf469 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -102,9 +102,6 @@ EXPORT_SYMBOL_GPL(halt_poll_ns_shrink);
 DEFINE_MUTEX(kvm_lock);
 LIST_HEAD(vm_list);
 
-static DEFINE_PER_CPU(bool, hardware_enabled);
-static int kvm_usage_count;
-
 static struct kmem_cache *kvm_vcpu_cache;
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
@@ -146,9 +143,6 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-__visible bool kvm_rebooting;
-EXPORT_SYMBOL_GPL(kvm_rebooting);
-
 #define KVM_EVENT_CREATE_VM 0
 #define KVM_EVENT_DESTROY_VM 1
 static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
@@ -5005,6 +4999,13 @@ static struct miscdevice kvm_dev = {
 	&kvm_chardev_ops,
 };
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
+__visible bool kvm_rebooting;
+EXPORT_SYMBOL_GPL(kvm_rebooting);
+
+static DEFINE_PER_CPU(bool, hardware_enabled);
+static int kvm_usage_count;
+
 static int __hardware_enable_nolock(void)
 {
 	if (__this_cpu_read(hardware_enabled))
@@ -5171,6 +5172,17 @@ static struct syscore_ops kvm_syscore_ops = {
 	.suspend = kvm_suspend,
 	.resume = kvm_resume,
 };
+#else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
+static int hardware_enable_all(void)
+{
+	return 0;
+}
+
+static void hardware_disable_all(void)
+{
+
+}
+#endif /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus)
 {
@@ -5859,6 +5871,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	int r;
 	int cpu;
 
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	r = cpuhp_setup_state_nocalls(CPUHP_AP_KVM_ONLINE, "kvm/cpu:online",
 				      kvm_online_cpu, kvm_offline_cpu);
 	if (r)
@@ -5866,6 +5879,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 
 	register_reboot_notifier(&kvm_reboot_notifier);
 	register_syscore_ops(&kvm_syscore_ops);
+#endif
 
 	/* A kmem cache lets us meet the alignment requirements of fx_save. */
 	if (!vcpu_align)
@@ -5933,9 +5947,11 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
 out_free_3:
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
+#endif
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -5957,9 +5973,11 @@ void kvm_exit(void)
 	kmem_cache_destroy(kvm_vcpu_cache);
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
+#ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
 	unregister_syscore_ops(&kvm_syscore_ops);
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_ONLINE);
+#endif
 	kvm_irqfd_exit();
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
-- 
2.38.1.431.g37b22c650d-goog

