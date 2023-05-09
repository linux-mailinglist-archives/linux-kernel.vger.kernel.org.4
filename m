Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE566FC104
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjEIHzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjEIHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:54:05 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4620F423B;
        Tue,  9 May 2023 00:54:02 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8AxV+kV_FlkVuMGAA--.11352S3;
        Tue, 09 May 2023 15:53:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLUK_FlkIEhSAA--.16908S20;
        Tue, 09 May 2023 15:53:55 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PATCH v9 18/30] LoongArch: KVM: Implement vcpu timer operations
Date:   Tue,  9 May 2023 15:53:34 +0800
Message-Id: <20230509075346.1023386-19-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230509075346.1023386-1-zhaotianrui@loongson.cn>
References: <20230509075346.1023386-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLUK_FlkIEhSAA--.16908S20
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw18Kw4UAFyDXF1kZryrJFb_yoW3ZFWkpr
        WIkryIqr48X342gwn3AFs0vrn8W3yrKw17Gry7J3ySyrnxJ3s8XF40gryDJFZxGryxZF4S
        vryrAwn8Ar4kA3DanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b4AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6x
        kF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r12
        6r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7xRiTKZJUUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement LoongArch vcpu timer operations such as init kvm timer,
require kvm timer, save kvm timer and restore kvm timer. When
vcpu exit, we use kvm soft timer to emulate hardware timer. If
timeout happens, the vcpu timer interrupt will be set and it is
going to be handled at vcpu next entrance.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/timer.c | 266 +++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100644 arch/loongarch/kvm/timer.c

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
new file mode 100644
index 000000000000..1c81d0549888
--- /dev/null
+++ b/arch/loongarch/kvm/timer.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_csr.h>
+#include <asm/kvm_vcpu.h>
+
+/* low level hrtimer wake routine */
+enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = container_of(timer, struct kvm_vcpu, arch.swtimer);
+	_kvm_queue_irq(vcpu, INT_TI);
+	rcuwait_wake_up(&vcpu->wait);
+	return kvm_count_timeout(vcpu);
+}
+
+/*
+ * ktime_to_tick() - Scale ktime_t to a 64-bit stable timer.
+ *
+ * Caches the dynamic nanosecond bias in vcpu->arch.timer_dyn_bias.
+ */
+static unsigned long ktime_to_tick(struct kvm_vcpu *vcpu, ktime_t now)
+{
+	s64 now_ns, periods;
+	unsigned long delta;
+
+	now_ns = ktime_to_ns(now);
+	delta = now_ns + vcpu->arch.timer_dyn_bias;
+
+	if (delta >= vcpu->arch.timer_period_ns) {
+		/* If delta is out of safe range the bias needs adjusting */
+		periods = div64_s64(now_ns, vcpu->arch.timer_period_ns);
+		vcpu->arch.timer_dyn_bias = -periods * vcpu->arch.timer_period_ns;
+		/* Recalculate delta with new bias */
+		delta = now_ns + vcpu->arch.timer_dyn_bias;
+	}
+
+	/*
+	 * We've ensured that:
+	 *   delta < timer_period_ns
+	 */
+	return div_u64(delta * vcpu->arch.timer_mhz, MNSEC_PER_SEC);
+}
+
+/**
+ * kvm_resume_hrtimer() - Resume hrtimer, updating expiry.
+ * @vcpu:	Virtual CPU.
+ * @now:	ktime at point of resume.
+ * @val:	stable timer at point of resume.
+ *
+ * Resumes the timer and updates the timer expiry based on @now and @count.
+ */
+static void kvm_resume_hrtimer(struct kvm_vcpu *vcpu, ktime_t now,
+				unsigned long val)
+{
+	unsigned long delta;
+	ktime_t expire;
+
+	/* Stable timer decreased to zero or
+	 * initialize to zero, set 4 second timer
+	 */
+	delta = div_u64(val * MNSEC_PER_SEC, vcpu->arch.timer_mhz);
+	expire = ktime_add_ns(now, delta);
+
+	/* Update hrtimer to use new timeout */
+	hrtimer_cancel(&vcpu->arch.swtimer);
+	hrtimer_start(&vcpu->arch.swtimer, expire, HRTIMER_MODE_ABS_PINNED);
+}
+
+/**
+ * kvm_init_timer() - Initialise stable timer.
+ * @vcpu:	Virtual CPU.
+ * @timer_hz:	Frequency of timer.
+ *
+ * Initialise the timer to the specified frequency, zero it, and set it going if
+ * it's enabled.
+ */
+void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long timer_hz)
+{
+	ktime_t now;
+	unsigned long ticks;
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	ticks = (unsigned long)MNSEC_PER_SEC * CSR_TCFG_VAL;
+	vcpu->arch.timer_mhz = timer_hz >> 20;
+	vcpu->arch.timer_period_ns = div_u64(ticks, vcpu->arch.timer_mhz);
+	vcpu->arch.timer_dyn_bias = 0;
+
+	/* Starting at 0 */
+	ticks = 0;
+	now = ktime_get();
+	vcpu->arch.timer_bias = ticks - ktime_to_tick(vcpu, now);
+	vcpu->arch.timer_bias &= CSR_TCFG_VAL;
+	kvm_write_sw_gcsr(csr, LOONGARCH_CSR_TVAL, ticks);
+}
+
+/**
+ * kvm_count_timeout() - Push timer forward on timeout.
+ * @vcpu:	Virtual CPU.
+ *
+ * Handle an hrtimer event by push the hrtimer forward a period.
+ *
+ * Returns:	The hrtimer_restart value to return to the hrtimer subsystem.
+ */
+enum hrtimer_restart kvm_count_timeout(struct kvm_vcpu *vcpu)
+{
+	unsigned long cfg;
+
+	/* Add the Count period to the current expiry time */
+	cfg = kvm_read_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TCFG);
+	if (cfg & CSR_TCFG_PERIOD) {
+		hrtimer_add_expires_ns(&vcpu->arch.swtimer, cfg & CSR_TCFG_VAL);
+		return HRTIMER_RESTART;
+	} else
+		return HRTIMER_NORESTART;
+}
+
+/*
+ * kvm_restore_timer() - Restore timer state.
+ * @vcpu:       Virtual CPU.
+ *
+ * Restore soft timer state from saved context.
+ */
+void kvm_restore_timer(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	ktime_t saved_ktime, now;
+	unsigned long val, new, delta;
+	int expired = 0;
+	unsigned long cfg;
+
+	/*
+	 * Set guest stable timer cfg csr
+	 */
+	cfg = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+	if (!(cfg & CSR_TCFG_EN)) {
+		kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
+		kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
+		return;
+	}
+
+	now = ktime_get();
+	saved_ktime = vcpu->arch.stable_ktime_saved;
+	val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TVAL);
+
+	/*hrtimer not expire */
+	delta = ktime_to_tick(vcpu, ktime_sub(now, saved_ktime));
+	if (delta >= val) {
+		expired = 1;
+		if (cfg & CSR_TCFG_PERIOD)
+			new = (delta - val) % (cfg & CSR_TCFG_VAL);
+		else
+			new = 1;
+	} else
+		new = val - delta;
+
+	new &= CSR_TCFG_VAL;
+	write_gcsr_timercfg(cfg);
+	write_gcsr_timertick(new);
+	if (expired)
+		_kvm_queue_irq(vcpu, INT_TI);
+}
+
+/*
+ * kvm_acquire_timer() - Switch to hard timer state.
+ * @vcpu:       Virtual CPU.
+ *
+ * Restore hard timer state on top of existing soft timer state if possible.
+ *
+ * Since hard timer won't remain active over preemption, preemption should be
+ * disabled by the caller.
+ */
+void kvm_acquire_timer(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags, guestcfg;
+
+	guestcfg = read_csr_gcfg();
+	if (!(guestcfg & CSR_GCFG_TIT))
+		return;
+
+	/* enable guest access to hard timer */
+	write_csr_gcfg(guestcfg & ~CSR_GCFG_TIT);
+
+	/*
+	 * Freeze the soft-timer and sync the guest stable timer with it. We do
+	 * this with interrupts disabled to avoid latency.
+	 */
+	local_irq_save(flags);
+	hrtimer_cancel(&vcpu->arch.swtimer);
+	local_irq_restore(flags);
+}
+
+
+/*
+ * _kvm_save_timer() - Switch to software emulation of guest timer.
+ * @vcpu:       Virtual CPU.
+ *
+ * Save guest timer state and switch to software emulation of guest
+ * timer. The hard timer must already be in use, so preemption should be
+ * disabled.
+ */
+static ktime_t _kvm_save_timer(struct kvm_vcpu *vcpu, unsigned long *val)
+{
+	unsigned long end_time;
+	ktime_t before_time;
+
+	before_time = ktime_get();
+
+	/*
+	 * Record a final stable timer which we will transfer to the soft-timer.
+	 */
+	end_time = read_gcsr_timertick();
+	*val = end_time;
+
+	kvm_resume_hrtimer(vcpu, before_time, end_time);
+	return before_time;
+}
+
+/*
+ * kvm_save_timer() - Save guest timer state.
+ * @vcpu:       Virtual CPU.
+ *
+ * Save guest timer state and switch to soft guest timer if hard timer was in
+ * use.
+ */
+void kvm_save_timer(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	unsigned long guestcfg, val;
+	ktime_t save_ktime;
+
+	preempt_disable();
+	guestcfg = read_csr_gcfg();
+	if (!(guestcfg & CSR_GCFG_TIT)) {
+		/* disable guest use of hard timer */
+		write_csr_gcfg(guestcfg | CSR_GCFG_TIT);
+
+		/* save hard timer state */
+		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
+		if (kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG) & CSR_TCFG_EN) {
+			save_ktime = _kvm_save_timer(vcpu, &val);
+			kvm_write_sw_gcsr(csr, LOONGARCH_CSR_TVAL, val);
+			vcpu->arch.stable_ktime_saved = save_ktime;
+			if (val == CSR_TCFG_VAL)
+				_kvm_queue_irq(vcpu, INT_TI);
+		} else {
+			kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
+		}
+	}
+
+	/* save timer-related state to vCPU context */
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+	preempt_enable();
+}
+
+void kvm_reset_timer(struct kvm_vcpu *vcpu)
+{
+	write_gcsr_timercfg(0);
+	kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TCFG, 0);
+	hrtimer_cancel(&vcpu->arch.swtimer);
+}
-- 
2.31.1

