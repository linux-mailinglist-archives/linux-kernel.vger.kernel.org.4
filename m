Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB56FC0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjEIHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjEIHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:53:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D05368A41;
        Tue,  9 May 2023 00:53:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8AxmOkT_FlkM+MGAA--.11406S3;
        Tue, 09 May 2023 15:53:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLUK_FlkIEhSAA--.16908S18;
        Tue, 09 May 2023 15:53:54 +0800 (CST)
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
Subject: [PATCH v9 16/30] LoongArch: KVM: Implement update VM id function
Date:   Tue,  9 May 2023 15:53:32 +0800
Message-Id: <20230509075346.1023386-17-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230509075346.1023386-1-zhaotianrui@loongson.cn>
References: <20230509075346.1023386-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLUK_FlkIEhSAA--.16908S18
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Aw1kJrW5GFWrWry3CF4rZrb_yoW8tr1rpr
        WxCrn5Wr4rXwnxu3sIqw10qrn09395JF13Xa47Ja4Yyr17t34qkrWvkrWDAFyxXr1rAryx
        XF15tF4jkF18A37anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

Implement kvm check vmid and update vmid, the vmid should be checked before
vcpu enter guest.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vmid.c | 64 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 arch/loongarch/kvm/vmid.c

diff --git a/arch/loongarch/kvm/vmid.c b/arch/loongarch/kvm/vmid.c
new file mode 100644
index 000000000000..6fef81b28a48
--- /dev/null
+++ b/arch/loongarch/kvm/vmid.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/kvm_host.h>
+#include "trace.h"
+
+static void _kvm_update_vpid(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct kvm_context *context;
+	unsigned long vpid;
+
+	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+	vpid = context->vpid_cache + 1;
+	if (!(vpid & vpid_mask)) {
+		/* finish round of 64 bit loop */
+		if (unlikely(!vpid))
+			vpid = vpid_mask + 1;
+
+		/* vpid 0 reserved for root */
+		++vpid;
+
+		/* start new vpid cycle */
+		kvm_flush_tlb_all();
+	}
+
+	context->vpid_cache = vpid;
+	vcpu->arch.vpid = vpid;
+}
+
+void _kvm_check_vmid(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct kvm_context *context;
+	bool migrated;
+	unsigned long ver, old, vpid;
+
+	/*
+	 * Are we entering guest context on a different CPU to last time?
+	 * If so, the vCPU's guest TLB state on this CPU may be stale.
+	 */
+	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
+	migrated = (vcpu->arch.last_exec_cpu != cpu);
+	vcpu->arch.last_exec_cpu = cpu;
+
+	/*
+	 * Check if our vpid is of an older version
+	 *
+	 * We also discard the stored vpid if we've executed on
+	 * another CPU, as the guest mappings may have changed without
+	 * hypervisor knowledge.
+	 */
+	ver = vcpu->arch.vpid & ~vpid_mask;
+	old = context->vpid_cache  & ~vpid_mask;
+	if (migrated || (ver != old)) {
+		_kvm_update_vpid(vcpu, cpu);
+		trace_kvm_vpid_change(vcpu, vcpu->arch.vpid);
+	}
+
+	/* Restore GSTAT(0x50).vpid */
+	vpid = (vcpu->arch.vpid & vpid_mask)
+		<< CSR_GSTAT_GID_SHIFT;
+	change_csr_gstat(vpid_mask << CSR_GSTAT_GID_SHIFT, vpid);
+}
-- 
2.31.1

