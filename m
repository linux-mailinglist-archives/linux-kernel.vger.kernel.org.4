Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962DB6E4465
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjDQJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDQJr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:47:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC68A61BA;
        Mon, 17 Apr 2023 02:47:20 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8BxEJWNFT1kLeMdAA--.46398S3;
        Mon, 17 Apr 2023 17:46:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxtryKFT1kyagqAA--.47974S10;
        Mon, 17 Apr 2023 17:46:53 +0800 (CST)
From:   Tianrui Zhao <zhaotianrui@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Upton <oliver.upton@linux.dev>, maobibo@loongson.cn,
        Xi Ruoyao <xry111@xry111.site>, zhaotianrui@loongson.cn
Subject: [PATCH v7 08/30] LoongArch: KVM: Implement vcpu handle exit interface
Date:   Mon, 17 Apr 2023 17:46:27 +0800
Message-Id: <20230417094649.874671-9-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230417094649.874671-1-zhaotianrui@loongson.cn>
References: <20230417094649.874671-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxtryKFT1kyagqAA--.47974S10
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF17AryDJFyxCFW8GFW7Arb_yoW8Cry7pr
        WxCrn0gw4rG34xJasayrs0qr4Yg3s7Kr17ZrZxX3y2yFsFvas0vr48KrZFyFy5W34FqF1f
        Xr1rG3WY9F4jywUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b48Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6x
        kF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6c
        x26rWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r12
        6r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7xRiTKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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
index bc9e3889fee1..651ae5ca0691 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -56,6 +56,52 @@ static void kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
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
2.31.1

