Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9358B63E509
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiK3XO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiK3XOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:14:02 -0500
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3789FEC5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:10:56 -0800 (PST)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-13cce313cd3so93055fac.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKa4qX4aDdx6gvF0cYN6nETCrhJ4tNYpG1mvb7syK3o=;
        b=hHwMew+JSB9FkzxQMaX/4lXjqBXrsR2HJcdv2uakADxR3kWcZRlQ7C2hYI2R6wh2j+
         soQ37LpW03hcFXp8lJe1iL1E9NkgwaBOnfMN9lm4y4oXg28LND1TqJT1wRbBYqaPal/k
         tCOOIhtq66PSMoAtSgQhsAQ3pRw7PI30nJWGUPRypWo66CD+Gfn2yExb5G/kSSTH+qsi
         vDk8o1GMNBG21DRimYUtdxku+SkaYSkrVg0OW+HosZG84kC5BNrvHX1FxdetpLCfaQGl
         ngY1QSkOkzNCayJ5MpPvpJWGgQ3ZJsUwWjrB9/naUfSCBSqc4tz9oYHVPQdICLf6YKOj
         UOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKa4qX4aDdx6gvF0cYN6nETCrhJ4tNYpG1mvb7syK3o=;
        b=1YasBNHxm/RlzrMmHHb3iWunE4w8uKyDgbdEd8x5WOukbwpvX1txb6a2SxUqHEW00C
         vgfrpoDvgK47O7CNO35cuXYRF0AZ6qObUIEZba/hHnzXYwlSpx2EdPm7j2eAGJTzbDAH
         KzoaP4svhb8uixPaAsPBWo0SaQdI9nJ9cAFNRXmVGdBk8lZmo2uMwJKQTl5CRJIOZVcL
         zIprrJnvInSEh35biRx1hgKuznhRaH4CiKTb8lxFGp2O4J4K+lN+0QwBxUq51HcCemDv
         xBGEYwoKiDg+z0un0rPqq6tL66uBZtBTScTVt+3ll0NoWx409xKk52E0+JK5G/Cflfc8
         VhVQ==
X-Gm-Message-State: ANoB5pnzODNTBC/hCEVmBfrLJBKLAwn9BsDdQ1e0qtfDXHrLbEDRhsRF
        w+XUM+4/xuAjEhj2nt1n4RFD74wC4R4=
X-Google-Smtp-Source: AA0mqf51u5a2rRyiNdjg5YBoKgU3OlNqfaadebl2G6/Q2GTnKp0Tsp1t65U5NTGk3wy62Y7NHB25PAFR6bU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6870:a78a:b0:13b:c612:b5ae with SMTP id
 x10-20020a056870a78a00b0013bc612b5aemr26861133oao.203.1669849833136; Wed, 30
 Nov 2022 15:10:33 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 30 Nov 2022 23:09:16 +0000
In-Reply-To: <20221130230934.1014142-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130230934.1014142-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130230934.1014142-33-seanjc@google.com>
Subject: [PATCH v2 32/50] KVM: Drop kvm_arch_check_processor_compat() hook
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
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>
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
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop kvm_arch_check_processor_compat() and its support code now that all
architecture implementations are nops.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>	# s390
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/arm64/kvm/arm.c       |  7 +------
 arch/mips/kvm/mips.c       |  7 +------
 arch/powerpc/kvm/book3s.c  |  2 +-
 arch/powerpc/kvm/e500.c    |  2 +-
 arch/powerpc/kvm/e500mc.c  |  2 +-
 arch/powerpc/kvm/powerpc.c |  5 -----
 arch/riscv/kvm/main.c      |  7 +------
 arch/s390/kvm/kvm-s390.c   |  7 +------
 arch/x86/kvm/svm/svm.c     |  4 ++--
 arch/x86/kvm/vmx/vmx.c     |  4 ++--
 arch/x86/kvm/x86.c         |  5 -----
 include/linux/kvm_host.h   |  4 +---
 virt/kvm/kvm_main.c        | 24 +-----------------------
 13 files changed, 13 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 936ef7d1ea94..e915b1d9f2cd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -63,11 +63,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) =3D=3D IN_GUEST_MODE;
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -2273,7 +2268,7 @@ static __init int kvm_arm_init(void)
 	 * FIXME: Do something reasonable if kvm_init() fails after pKVM
 	 * hypervisor protection is finalized.
 	 */
-	err =3D kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	err =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (err)
 		goto out_subs;
=20
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 3cade648827a..36c8991b5d39 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -135,11 +135,6 @@ void kvm_arch_hardware_disable(void)
 	kvm_mips_callbacks->hardware_disable();
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 extern void kvm_init_loongson_ipi(struct kvm *kvm);
=20
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
@@ -1636,7 +1631,7 @@ static int __init kvm_mips_init(void)
=20
 	register_die_notifier(&kvm_mips_csr_die_notifier);
=20
-	ret =3D kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	ret =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (ret) {
 		unregister_die_notifier(&kvm_mips_csr_die_notifier);
 		return ret;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 87283a0e33d8..57f4e7896d67 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1052,7 +1052,7 @@ static int kvmppc_book3s_init(void)
 {
 	int r;
=20
-	r =3D kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (r)
 		return r;
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 0ea61190ec04..b0f695428733 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -531,7 +531,7 @@ static int __init kvmppc_e500_init(void)
 	flush_icache_range(kvmppc_booke_handlers, kvmppc_booke_handlers +
 			   ivor[max_ivor] + handler_len);
=20
-	r =3D kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r =3D kvm_init(sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
 	if (r)
 		goto err_out;
 	kvm_ops_e500.owner =3D THIS_MODULE;
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 795667f7ebf0..611532a0dedc 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -404,7 +404,7 @@ static int __init kvmppc_e500mc_init(void)
 	 */
 	kvmppc_init_lpid(KVMPPC_NR_LPIDS/threads_per_core);
=20
-	r =3D kvm_init(NULL, sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
+	r =3D kvm_init(sizeof(struct kvmppc_vcpu_e500), 0, THIS_MODULE);
 	if (r)
 		goto err_out;
 	kvm_ops_e500mc.owner =3D THIS_MODULE;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 01d0f9935e6c..f5b4ff6bfc89 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -440,11 +440,6 @@ int kvm_arch_hardware_enable(void)
 	return 0;
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	struct kvmppc_ops *kvm_ops =3D NULL;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 4710a6751687..34c3dece6990 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -20,11 +20,6 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 int kvm_arch_hardware_enable(void)
 {
 	unsigned long hideleg, hedeleg;
@@ -110,6 +105,6 @@ static int __init riscv_kvm_init(void)
=20
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
=20
-	return kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 module_init(riscv_kvm_init);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 25b08b956888..7ad8252e92c2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -262,11 +262,6 @@ int kvm_arch_hardware_enable(void)
 	return 0;
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 /* forward declarations */
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
@@ -5716,7 +5711,7 @@ static int __init kvm_s390_init(void)
 	if (r)
 		return r;
=20
-	r =3D kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	r =3D kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (r) {
 		__kvm_s390_exit();
 		return r;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d7ea1c1175c2..d9a54590591d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5103,8 +5103,8 @@ static int __init svm_init(void)
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
 	 */
-	r =3D kvm_init(NULL, sizeof(struct vcpu_svm),
-		     __alignof__(struct vcpu_svm), THIS_MODULE);
+	r =3D kvm_init(sizeof(struct vcpu_svm), __alignof__(struct vcpu_svm),
+		     THIS_MODULE);
 	if (r)
 		goto err_kvm_init;
=20
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8deb1bd60c10..b6f08a0a1435 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8592,8 +8592,8 @@ static int __init vmx_init(void)
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
 	 */
-	r =3D kvm_init(NULL, sizeof(struct vcpu_vmx),
-		     __alignof__(struct vcpu_vmx), THIS_MODULE);
+	r =3D kvm_init(sizeof(struct vcpu_vmx), __alignof__(struct vcpu_vmx),
+		     THIS_MODULE);
 	if (r)
 		goto err_kvm_init;
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3571bc968cf8..566156b34314 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12071,11 +12071,6 @@ void kvm_arch_hardware_disable(void)
 	drop_user_return_notifiers();
 }
=20
-int kvm_arch_check_processor_compat(void *opaque)
-{
-	return 0;
-}
-
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
 {
 	return vcpu->kvm->arch.bsp_vcpu_id =3D=3D vcpu->vcpu_id;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7dde28333e7c..616e8e90558b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -953,8 +953,7 @@ static inline void kvm_irqfd_exit(void)
 {
 }
 #endif
-int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
-		  struct module *module);
+int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *modul=
e);
 void kvm_exit(void);
=20
 void kvm_get_kvm(struct kvm *kvm);
@@ -1460,7 +1459,6 @@ static inline void kvm_create_vcpu_debugfs(struct kvm=
_vcpu *vcpu) {}
=20
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
-int kvm_arch_check_processor_compat(void *opaque);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a4a10a0b322f..3900bd3d75cb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5833,36 +5833,14 @@ void kvm_unregister_perf_callbacks(void)
 }
 #endif
=20
-struct kvm_cpu_compat_check {
-	void *opaque;
-	int *ret;
-};
-
-static void check_processor_compat(void *data)
+int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *modul=
e)
 {
-	struct kvm_cpu_compat_check *c =3D data;
-
-	*c->ret =3D kvm_arch_check_processor_compat(c->opaque);
-}
-
-int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
-		  struct module *module)
-{
-	struct kvm_cpu_compat_check c;
 	int r;
 	int cpu;
=20
 	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL))
 		return -ENOMEM;
=20
-	c.ret =3D &r;
-	c.opaque =3D opaque;
-	for_each_online_cpu(cpu) {
-		smp_call_function_single(cpu, check_processor_compat, &c, 1);
-		if (r < 0)
-			goto out_free_2;
-	}
-
 	r =3D cpuhp_setup_state_nocalls(CPUHP_AP_KVM_STARTING, "kvm/cpu:starting"=
,
 				      kvm_starting_cpu, kvm_dying_cpu);
 	if (r)
--=20
2.38.1.584.g0f3c55d4c2-goog

