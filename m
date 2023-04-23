Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47946EBC46
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDWB3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:29:43 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FA52735
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:29:17 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q3rHm0DnXzKtZm;
        Sun, 23 Apr 2023 09:28:20 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 09:29:15 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <chenzhongjin@huawei.com>, <ak@linux.intel.com>,
        <David.Laight@ACULAB.COM>, <jpoimboe@kernel.org>
Subject: [PATCH v3] x86: profiling: remove lock functions profiling in profile_pc
Date:   Sun, 23 Apr 2023 09:27:44 +0800
Message-ID: <20230423012744.24320-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has been reporting the problem of stack-out-of-bounds in
profile_pc for a long time:
https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3

profile_pc will get return address for caller if current function
is lock function. For !CONFIG_FRAME_POINTER it uses a hack way to get
the caller by directly reading sp[0] or sp [1].
It not works when KASAN is enabled because KASAN pushes data on stack
which makes sp[0/1] become KASAN red zone. Then profile_pc reads wrong
memory and triggers KASAN warning frequently.

This hack might be ok when first added at 2006 but now it's different:

1. There are some lock functions which have frame longer than two stack
slots. For these functions sp[0/1] is not a legal return address even
KASAN is not enabled.
2. !CONFIG_FRAME_POINTER is more used today because UNWINDER_ORC.
3. Lock function caller information can be prfiled by perf better.

Since profile as a low level facility it's not proper to depend on
complex generic unwinder to get the next frame. As lock profiling is
no longer useful, it's fine to remove it.

Fixes: 0cb91a229364 ("[PATCH] i386: Account spinlocks to the caller during profiling for !FP kernels")
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
v1->v2:
Make a more detailed commit log.

v2->v3:
Also remove if for FRAME_POINTER case; slightly fix the commit log.
---
arch/x86/kernel/time.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..52e1f3f0b361 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -27,25 +27,7 @@
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	unsigned long pc = instruction_pointer(regs);
-
-	if (!user_mode(regs) && in_lock_functions(pc)) {
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
-	}
-	return pc;
+	return instruction_pointer(regs);
 }
 EXPORT_SYMBOL(profile_pc);
 
-- 
2.17.1

