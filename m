Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C66D6A14DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBXCVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXCVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:21:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DAE5EEC8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:21:08 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PND8C4f1WzRsGr;
        Fri, 24 Feb 2023 10:18:19 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Feb 2023 10:21:05 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <chenzhongjin@huawei.com>, <ak@linux.intel.com>
Subject: [PATCH] x86: profiling: Using generic unwinding in profile_pc
Date:   Fri, 24 Feb 2023 10:18:58 +0800
Message-ID: <20230224021858.120078-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has been reporting the problem of stack-out-of-bounds in
profile_pc for a long time:
https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3

profile_pc tries to get pc if current regs is inside lock function. For
!CONFIG_FRAME_POINTER it used a hack way to get the pc from stack, which
is not work with ORC. It makes profile_pc returns wrong result, and
frequently triggers KASAN.

This can be fixed by using the unwind_start, it will skip the first
regs frame and get the caller of lock function directly, or 0 if
unwind_get_return_address finds the unwinding failed. For all of FP, ORC
and guess unwinders it works.

Fixes: 0cb91a229364 ("[PATCH] i386: Account spinlocks to the caller during profiling for !FP kernels")
Reported-by: syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/x86/kernel/time.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..5e0446f49906 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -24,26 +24,18 @@
 #include <asm/timer.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
+#include <asm/unwind.h>
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
 	if (!user_mode(regs) && in_lock_functions(pc)) {
-#ifdef CONFIG_FRAME_POINTER
-		return *(unsigned long *)(regs->bp + sizeof(long));
-#else
-		unsigned long *sp = (unsigned long *)regs->sp;
-		/*
-		 * Return address is either directly at stack pointer
-		 * or above a saved flags. Eflags has bits 22-31 zero,
-		 * kernel addresses don't.
-		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
-#endif
+		struct unwind_state state;
+
+		/* unwind_start will skip the first regs frame */
+		unwind_start(&state, current, regs, NULL);
+		pc = unwind_get_return_address(&state);
 	}
 	return pc;
 }
-- 
2.17.1

