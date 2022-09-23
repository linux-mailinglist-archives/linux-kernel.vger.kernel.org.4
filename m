Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41AD5E7633
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIWIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIWIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:50:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CF8126B7E;
        Fri, 23 Sep 2022 01:50:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYm4j0QwHzpT3m;
        Fri, 23 Sep 2022 16:47:49 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:50:39 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <guoren@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <mark.rutland@arm.com>, <maz@kernel.org>,
        <liaochang1@huawei.com>, <alexandru.elisei@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 1/3] riscv/kprobe: Optimize the performance of patching single-step slot
Date:   Fri, 23 Sep 2022 16:46:56 +0800
Message-ID: <20220923084658.99304-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220923084658.99304-1-liaochang1@huawei.com>
References: <20220923084658.99304-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/kernel/probes/kprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..bc1f39b96e41 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	unsigned long offset = GET_INSN_LENGTH(p->opcode);
+	kprobe_opcode_t slot[MAX_INSN_SIZE];
 
 	p->ainsn.api.restore = (unsigned long)p->addr + offset;
 
-	patch_text(p->ainsn.api.insn, p->opcode);
-	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
-		   __BUG_INSN_32);
+	memcpy(slot, &p->opcode, offset);
+	*(kprobe_opcode_t *)((unsigned long)slot + offset) = __BUG_INSN_32;
+	patch_text_nosync(p->ainsn.api.insn, slot,
+			  offset + GET_INSN_LENGTH(__BUG_INSN_32));
 }
 
 static void __kprobes arch_prepare_simulate(struct kprobe *p)
-- 
2.17.1

