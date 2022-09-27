Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEC5EB7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiI0C2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiI0C2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:28:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02166AB19A;
        Mon, 26 Sep 2022 19:28:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc3Pg1x01zpVN2;
        Tue, 27 Sep 2022 10:25:27 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 10:28:21 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <liaochang1@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching single-step slot
Date:   Tue, 27 Sep 2022 10:24:35 +0800
Message-ID: <20220927022435.129965-4-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927022435.129965-1-liaochang1@huawei.com>
References: <20220927022435.129965-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single-step slot would not be used until kprobe is enabled, that means
no race condition occurs on it under SMP, hence it is safe to pacth ss
slot without stopping machine.

Since I and D caches are coherent within single-step slot from
aarch64_insn_patch_text_nosync(), hence no need to do it again via
flush_icache_range().

Acked-by: Will Deacon <will@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1d182320245..c9e4d0720285 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -44,13 +44,28 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.api.insn;
-	void *addrs[] = {addr, addr + 1};
-	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
 
-	/* prepare insn slot */
-	aarch64_insn_patch_text(addrs, insns, 2);
-
-	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
+	/*
+	 * Prepare insn slot, Mark Rutland points out it depends on a coupe of
+	 * subtleties:
+	 *
+	 * - That the I-cache maintenance for these instructions is complete
+	 *   *before* the kprobe BRK is written (and aarch64_insn_patch_text_nosync()
+	 *   ensures this, but just omits causing a Context-Synchronization-Event
+	 *   on all CPUS).
+	 *
+	 * - That the kprobe BRK results in an exception (and consequently a
+	 *   Context-Synchronoization-Event), which ensures that the CPU will
+	 *   fetch thesingle-step slot instructions *after* this, ensuring that
+	 *   the new instructions are used
+	 *
+	 * It supposes to place ISB after patching to guarantee I-cache maintenance
+	 * is observed on all CPUS, however, single-step slot is installed in
+	 * the BRK exception handler, so it is unnecessary to generate
+	 * Contex-Synchronization-Event via ISB again.
+	 */
+	aarch64_insn_patch_text_nosync(addr, p->opcode);
+	aarch64_insn_patch_text_nosync(addr + 1, BRK64_OPCODE_KPROBES_SS);
 
 	/*
 	 * Needs restoring of return address after stepping xol.
-- 
2.17.1

