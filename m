Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB004607628
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJULbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJULb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:31:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF660686;
        Fri, 21 Oct 2022 04:31:19 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mv2N716f1zHv7t;
        Fri, 21 Oct 2022 19:31:03 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 19:31:11 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 19:31:10 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Guo Ren <guoren@kernel.org>
CC:     <linux-csky@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next] csky: add arch support current_stack_pointer
Date:   Fri, 21 Oct 2022 11:56:54 +0000
Message-ID: <20221021115654.5278-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow the existing per-arch conventions, using "current_stack_pointer"
to set sp.

This will let it be used in non-arch places(like HARDENED_USERCOPY).

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/csky/Kconfig                 | 1 +
 arch/csky/include/asm/processor.h | 2 ++
 arch/csky/kernel/stacktrace.c     | 6 ++----
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index adee6ab36862..2236b5c0c213 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,6 +9,7 @@ config CSKY
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index 63ad71fab30d..ea75d72dea86 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -84,4 +84,6 @@ unsigned long __get_wchan(struct task_struct *p);
 
 #define cpu_relax() barrier()
 
+register unsigned long current_stack_pointer __asm__("sp");
+
 #endif /* __ASM_CSKY_PROCESSOR_H */
diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
index 9f78f5d21511..27ecd63e321b 100644
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -23,10 +23,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		sp = user_stack_pointer(regs);
 		pc = instruction_pointer(regs);
 	} else if (task == NULL || task == current) {
-		const register unsigned long current_sp __asm__ ("sp");
 		const register unsigned long current_fp __asm__ ("r8");
 		fp = current_fp;
-		sp = current_sp;
+		sp = current_stack_pointer;
 		pc = (unsigned long)walk_stackframe;
 	} else {
 		/* task blocked in __switch_to */
@@ -68,8 +67,7 @@ static void notrace walk_stackframe(struct task_struct *task,
 		sp = user_stack_pointer(regs);
 		pc = instruction_pointer(regs);
 	} else if (task == NULL || task == current) {
-		const register unsigned long current_sp __asm__ ("sp");
-		sp = current_sp;
+		sp = current_stack_pointer;
 		pc = (unsigned long)walk_stackframe;
 	} else {
 		/* task blocked in __switch_to */
-- 
2.25.1

