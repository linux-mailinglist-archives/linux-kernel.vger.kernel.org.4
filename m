Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892967421AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjF2ICg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjF2H4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:56:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4354C3A87;
        Thu, 29 Jun 2023 00:55:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8DxvscAOZ1k3sQDAA--.6033S3;
        Thu, 29 Jun 2023 15:55:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyP6OJ1kYGYQAA--.18424S8;
        Thu, 29 Jun 2023 15:55:43 +0800 (CST)
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
Subject: [PATCH v16 06/30] LoongArch: KVM: Implement vcpu create and destroy interface
Date:   Thu, 29 Jun 2023 15:55:14 +0800
Message-Id: <20230629075538.4063701-7-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
References: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyP6OJ1kYGYQAA--.18424S8
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

Implement vcpu create and destroy interface, saving some info
into vcpu arch structure such as vcpu exception entrance, vcpu
enter guest pointer, etc. Init vcpu timer and set address
translation mode when vcpu create.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 88 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 arch/loongarch/kvm/vcpu.c

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
new file mode 100644
index 000000000000..24b5b00266a1
--- /dev/null
+++ b/arch/loongarch/kvm/vcpu.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/fpu.h>
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+#include <asm/time.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
+{
+	return 0;
+}
+
+int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
+{
+	unsigned long timer_hz;
+	struct loongarch_csrs *csr;
+
+	vcpu->arch.vpid = 0;
+
+	hrtimer_init(&vcpu->arch.swtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	vcpu->arch.swtimer.function = kvm_swtimer_wakeup;
+	vcpu->kvm->arch.online_vcpus = vcpu->vcpu_id + 1;
+
+	vcpu->arch.guest_eentry = (unsigned long)kvm_loongarch_ops->guest_eentry;
+	vcpu->arch.handle_exit = _kvm_handle_exit;
+	vcpu->arch.csr = kzalloc(sizeof(struct loongarch_csrs), GFP_KERNEL);
+	if (!vcpu->arch.csr)
+		return -ENOMEM;
+
+	/*
+	 * kvm all exceptions share one exception entry, and host <-> guest switch
+	 * also switch excfg.VS field, keep host excfg.VS info here
+	 */
+	vcpu->arch.host_ecfg = (read_csr_ecfg() & CSR_ECFG_VS);
+
+	/* Init */
+	vcpu->arch.last_sched_cpu = -1;
+	vcpu->arch.last_exec_cpu = -1;
+
+	/*
+	 * Initialize guest register state to valid architectural reset state.
+	 */
+	timer_hz = calc_const_freq();
+	kvm_init_timer(vcpu, timer_hz);
+
+	/* Set Initialize mode for GUEST */
+	csr = vcpu->arch.csr;
+	kvm_write_sw_gcsr(csr, LOONGARCH_CSR_CRMD, CSR_CRMD_DA);
+
+	/* Set cpuid */
+	kvm_write_sw_gcsr(csr, LOONGARCH_CSR_TMID, vcpu->vcpu_id);
+
+	/* start with no pending virtual guest interrupts */
+	csr->csrs[LOONGARCH_CSR_GINTC] = 0;
+
+	return 0;
+}
+
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
+{
+	int cpu;
+	struct kvm_context *context;
+
+	hrtimer_cancel(&vcpu->arch.swtimer);
+	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+	kfree(vcpu->arch.csr);
+
+	/*
+	 * If the vCPU is freed and reused as another vCPU, we don't want the
+	 * matching pointer wrongly hanging around in last_vcpu.
+	 */
+	for_each_possible_cpu(cpu) {
+		context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+		if (context->last_vcpu == vcpu)
+			context->last_vcpu = NULL;
+	}
+}
-- 
2.39.1

