Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34496DC2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjDJCYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDJCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:24:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43735AD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:24:10 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pvt452G3jz17RqJ;
        Mon, 10 Apr 2023 10:20:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 10:24:08 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <chenzhongjin@huawei.com>, <akpm@linux-foudation.org>,
        <ben-linux@fluff.org>, <wuchi.zero@gmail.com>
Subject: [PATCH 1/2] x86: profiling: remove lock functions hack for !FRAME_POINTER
Date:   Mon, 10 Apr 2023 10:22:25 +0800
Message-ID: <20230410022226.181812-2-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410022226.181812-1-chenzhongjin@huawei.com>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
is not work with ORC. It makes profile_pc read illeagal address, return
wrong result, and frequently triggers KASAN.

Since lock profiling can be handled with much better other tools, It's
reasonable to remove lock functions hack for !FRAME_POINTER kernel.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/x86/kernel/time.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..e08fac7bb71e 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -29,22 +29,10 @@ unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (!user_mode(regs) && in_lock_functions(pc)) {
 #ifdef CONFIG_FRAME_POINTER
+	if (!user_mode(regs) && in_lock_functions(pc))
 		return *(unsigned long *)(regs->bp + sizeof(long));
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
 #endif
-	}
 	return pc;
 }
 EXPORT_SYMBOL(profile_pc);
-- 
2.17.1

