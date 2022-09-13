Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89C15B6634
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiIMDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIMDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:38:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298C54656;
        Mon, 12 Sep 2022 20:38:29 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRTc36KtyzmV5w;
        Tue, 13 Sep 2022 11:34:43 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 11:38:26 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <liaochang1@huawei.com>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH V2 3/3] arm64/kprobe: Optimize the performance of patching single-step slot
Date:   Tue, 13 Sep 2022 11:34:54 +0800
Message-ID: <20220913033454.104519-4-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913033454.104519-1-liaochang1@huawei.com>
References: <20220913033454.104519-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single-step slot would not be used until kprobe is enabled, that means
no race condition occurs on it under SMP, hence it is safe to pacth ss
slot without stopping machine.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/probes/kprobes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1d182320245..5902e33fd3b6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -44,11 +44,10 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.api.insn;
-	void *addrs[] = {addr, addr + 1};
-	u32 insns[] = {p->opcode, BRK64_OPCODE_KPROBES_SS};
 
 	/* prepare insn slot */
-	aarch64_insn_patch_text(addrs, insns, 2);
+	aarch64_insn_write(addr, p->opcode);
+	aarch64_insn_write(addr + 1, BRK64_OPCODE_KPROBES_SS);
 
 	flush_icache_range((uintptr_t)addr, (uintptr_t)(addr + MAX_INSN_SIZE));
 
-- 
2.17.1

