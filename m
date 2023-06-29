Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C474219E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjF2H7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjF2H5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:57:15 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A17403C18;
        Thu, 29 Jun 2023 00:55:55 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8CxLMcCOZ1kIsUDAA--.6061S3;
        Thu, 29 Jun 2023 15:55:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyP6OJ1kYGYQAA--.18424S15;
        Thu, 29 Jun 2023 15:55:45 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn,
        tangyouling@loongson.cn, hejinyang@loongson.cn
Subject: [PATCH v16 13/30] LoongArch: KVM: Implement misc vcpu related interfaces
Date:   Thu, 29 Jun 2023 15:55:21 +0800
Message-Id: <20230629075538.4063701-14-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
References: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyP6OJ1kYGYQAA--.18424S15
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement some misc vcpu relaterd interfaces, such as vcpu runnable,
vcpu should kick, vcpu dump regs, etc.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 105 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index be4a6a2aeb44..634836ead8bd 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -12,6 +12,111 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
+int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
+{
+	return !!(vcpu->arch.irq_pending) &&
+		vcpu->arch.mp_state.mp_state == KVM_MP_STATE_RUNNABLE;
+}
+
+int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
+{
+	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
+}
+
+bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
+				  struct kvm_translation *tr)
+{
+	return -EINVAL;
+}
+
+int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	return _kvm_pending_timer(vcpu) ||
+		kvm_read_hw_gcsr(LOONGARCH_CSR_ESTAT) &
+			(1 << INT_TI);
+}
+
+int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	kvm_debug("vCPU Register Dump:\n");
+	kvm_debug("\tpc = 0x%08lx\n", vcpu->arch.pc);
+	kvm_debug("\texceptions: %08lx\n", vcpu->arch.irq_pending);
+
+	for (i = 0; i < 32; i += 4) {
+		kvm_debug("\tgpr%02d: %08lx %08lx %08lx %08lx\n", i,
+		       vcpu->arch.gprs[i],
+		       vcpu->arch.gprs[i + 1],
+		       vcpu->arch.gprs[i + 2], vcpu->arch.gprs[i + 3]);
+	}
+
+	kvm_debug("\tCRMOD: 0x%08lx, exst: 0x%08lx\n",
+		  kvm_read_hw_gcsr(LOONGARCH_CSR_CRMD),
+		  kvm_read_hw_gcsr(LOONGARCH_CSR_ESTAT));
+
+	kvm_debug("\tERA: 0x%08lx\n", kvm_read_hw_gcsr(LOONGARCH_CSR_ERA));
+
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
+				struct kvm_mp_state *mp_state)
+{
+	*mp_state = vcpu->arch.mp_state;
+
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
+				struct kvm_mp_state *mp_state)
+{
+	int ret = 0;
+
+	switch (mp_state->mp_state) {
+	case KVM_MP_STATE_RUNNABLE:
+		vcpu->arch.mp_state = *mp_state;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
+					struct kvm_guest_debug *dbg)
+{
+	return -EINVAL;
+}
+
+/**
+ * kvm_migrate_count() - Migrate timer.
+ * @vcpu:       Virtual CPU.
+ *
+ * Migrate hrtimer to the current CPU by cancelling and restarting it
+ * if it was running prior to being cancelled.
+ *
+ * Must be called when the vCPU is migrated to a different CPU to ensure that
+ * timer expiry during guest execution interrupts the guest and causes the
+ * interrupt to be delivered in a timely manner.
+ */
+static void kvm_migrate_count(struct kvm_vcpu *vcpu)
+{
+	if (hrtimer_cancel(&vcpu->arch.swtimer))
+		hrtimer_restart(&vcpu->arch.swtimer);
+}
+
 int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *v)
 {
 	unsigned long val;
-- 
2.39.1

