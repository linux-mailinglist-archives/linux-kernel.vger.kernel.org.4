Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794B5715322
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjE3Bwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjE3Bwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:52:32 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6794F0;
        Mon, 29 May 2023 18:52:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Bx2fHbVnVkKWoCAA--.5591S3;
        Tue, 30 May 2023 09:52:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQbTYVnVkQNZ_AA--.12077S10;
        Tue, 30 May 2023 09:52:27 +0800 (CST)
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
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PATCH v12 08/31] LoongArch: KVM: Implement vcpu handle exit interface
Date:   Tue, 30 May 2023 09:52:00 +0800
Message-Id: <20230530015223.147755-9-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230530015223.147755-1-zhaotianrui@loongson.cn>
References: <20230530015223.147755-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxQbTYVnVkQNZ_AA--.12077S10
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF17ArykWw17ZF48KFyxAFb_yoW8Cry7pr
        4xCryY9w4rG34xJ39ayrs0qr4Yq3s7Kr17Zry3Xay2yFsFva45Zr48KrZrtFy5Ww1FqF1f
        Xr1rG3WY9F4jywUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b4kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1s
        IEY20_WwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_
        JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCjc4
        AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj4RKpBTUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement vcpu handle exit interface, getting the exit code by ESTAT
register and using kvm exception vector to handle it.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index eca8b96a3e6e..ddea480fa5b0 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -55,6 +55,52 @@ static void kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 	vcpu->arch.aux_inuse &= ~KVM_LARCH_CSR;
 }
 
+/*
+ * Return 1 for resume guest and "<= 0" for resume host.
+ */
+static int _kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	unsigned long exst = vcpu->arch.host_estat;
+	u32 intr = exst & 0x1fff; /* ignore NMI */
+	u32 exccode = (exst & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
+	int ret = RESUME_GUEST;
+
+	vcpu->mode = OUTSIDE_GUEST_MODE;
+
+	/* Set a default exit reason */
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	run->ready_for_interrupt_injection = 1;
+
+	local_irq_enable();
+	guest_state_exit_irqoff();
+
+	trace_kvm_exit(vcpu, exccode);
+	if (exccode) {
+		ret = _kvm_handle_fault(vcpu, exccode);
+	} else {
+		WARN(!intr, "suspicious vm exiting");
+		++vcpu->stat.int_exits;
+	}
+
+	cond_resched();
+	local_irq_disable();
+
+	if (ret == RESUME_HOST)
+		return ret;
+
+	/* Only check for signals if not already exiting to userspace */
+	if (signal_pending(current)) {
+		vcpu->run->exit_reason = KVM_EXIT_INTR;
+		++vcpu->stat.signal_exits;
+		return -EINTR;
+	}
+
+	kvm_pre_enter_guest(vcpu);
+	trace_kvm_reenter(vcpu);
+	guest_state_enter_irqoff();
+	return RESUME_GUEST;
+}
+
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	unsigned long timer_hz;
-- 
2.39.1

