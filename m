Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7805BB574
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIQB7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIQB7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:59:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FFE24;
        Fri, 16 Sep 2022 18:59:31 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MTvCh2PtNzlVkl;
        Sat, 17 Sep 2022 09:55:28 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 09:59:29 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 09:59:29 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <mhiramat@kernel.org>,
        <namit@vmware.com>, <catalin.marinas@arm.com>,
        <peterz@infradead.org>, <mark.rutland@arm.com>
CC:     <liaochang1@huawei.com>, <chris.zjh@huawei.com>,
        <zouyipeng@huawei.com>
Subject: [PATCH 2/2] uprobes: make arch_uprobe_exception_notify as weak
Date:   Sat, 17 Sep 2022 09:55:22 +0800
Message-ID: <20220917015522.44583-3-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220917015522.44583-1-zouyipeng@huawei.com>
References: <20220917015522.44583-1-zouyipeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function implementation under some arch does nothing.
We can mark it with weak attributes to improve.

Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 arch/arm/probes/uprobes/core.c     | 6 ------
 arch/arm64/kernel/probes/uprobes.c | 6 ------
 arch/csky/kernel/probes/uprobes.c  | 6 ------
 arch/riscv/kernel/probes/uprobes.c | 6 ------
 kernel/events/uprobes.c            | 6 ++++++
 5 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c6e5f8..535ea1b355ed 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -175,12 +175,6 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	instruction_pointer_set(regs, utask->vaddr);
 }
 
-int arch_uprobe_exception_notify(struct notifier_block *self,
-				 unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
 {
 	unsigned long flags;
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..687ede3375a6 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -159,12 +159,6 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 	return orig_ret_vaddr;
 }
 
-int arch_uprobe_exception_notify(struct notifier_block *self,
-				 unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 static int uprobe_breakpoint_handler(struct pt_regs *regs,
 				     unsigned long esr)
 {
diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
index 2d31a12e46cf..67ff13d960e8 100644
--- a/arch/csky/kernel/probes/uprobes.c
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -132,12 +132,6 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 	return ra;
 }
 
-int arch_uprobe_exception_notify(struct notifier_block *self,
-				 unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 int uprobe_breakpoint_handler(struct pt_regs *regs)
 {
 	if (uprobe_pre_sstep_notifier(regs))
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index c976a21cd4bd..770f16c6e00f 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -131,12 +131,6 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 	return ra;
 }
 
-int arch_uprobe_exception_notify(struct notifier_block *self,
-				 unsigned long val, void *data)
-{
-	return NOTIFY_DONE;
-}
-
 bool uprobe_breakpoint_handler(struct pt_regs *regs)
 {
 	if (uprobe_pre_sstep_notifier(regs))
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..33e637f7a202 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2343,6 +2343,12 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
 	return 1;
 }
 
+int __weak arch_uprobe_exception_notify(struct notifier_block *self,
+				 unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
 static struct notifier_block uprobe_exception_nb = {
 	.notifier_call		= arch_uprobe_exception_notify,
 	.priority		= INT_MAX-1,	/* notified after kprobes, kgdb */
-- 
2.17.1

