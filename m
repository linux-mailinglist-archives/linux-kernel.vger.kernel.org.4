Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13F742198
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjF2IAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjF2H5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:57:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50E383C26;
        Thu, 29 Jun 2023 00:55:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.5.185])
        by gateway (Coremail) with SMTP id _____8Bx38cDOZ1kScUDAA--.6081S3;
        Thu, 29 Jun 2023 15:55:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzyP6OJ1kYGYQAA--.18424S18;
        Thu, 29 Jun 2023 15:55:46 +0800 (CST)
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
Subject: [PATCH v16 16/30] LoongArch: KVM: Implement update VM id function
Date:   Thu, 29 Jun 2023 15:55:24 +0800
Message-Id: <20230629075538.4063701-17-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
References: <20230629075538.4063701-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyP6OJ1kYGYQAA--.18424S18
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

Implement kvm check vmid and update vmid, the vmid should be checked before
vcpu enter guest.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
---
 arch/loongarch/kvm/vmid.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 arch/loongarch/kvm/vmid.c

diff --git a/arch/loongarch/kvm/vmid.c b/arch/loongarch/kvm/vmid.c
new file mode 100644
index 000000000000..380c25c5d12b
--- /dev/null
+++ b/arch/loongarch/kvm/vmid.c
@@ -0,0 +1,66 @@
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
+void _kvm_check_vmid(struct kvm_vcpu *vcpu)
+{
+	struct kvm_context *context;
+	bool migrated;
+	unsigned long ver, old, vpid;
+	int cpu;
+
+	cpu = smp_processor_id();
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
2.39.1

