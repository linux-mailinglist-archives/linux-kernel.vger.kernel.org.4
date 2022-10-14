Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40EA5FE6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJNCAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJNCAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:00:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634337CE2A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:00:45 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpTxy5jV0zmVF0;
        Fri, 14 Oct 2022 09:56:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:00:43 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:00:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/3] ARM: Fix some check warnings of tool sparse
Date:   Fri, 14 Oct 2022 09:59:54 +0800
Message-ID: <20221014015956.2006-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221014015956.2006-1-thunder.leizhen@huawei.com>
References: <20221014015956.2006-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings:
 warning: incorrect type in initializer (different address spaces)
    expected unsigned short [noderef] __user *register __p
    got unsigned short [usertype] *
 warning: cast removes address space '__user' of expression

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 20b2db6dcd1ced7..d455c97237e2079 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -188,9 +188,9 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 			}
 		} else {
 			if (thumb)
-				bad = get_user(val, &((u16 *)addr)[i]);
+				bad = get_user(val, &((u16 __user *)addr)[i]);
 			else
-				bad = get_user(val, &((u32 *)addr)[i]);
+				bad = get_user(val, &((u32 __user *)addr)[i]);
 		}
 
 		if (!bad)
@@ -448,9 +448,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 asmlinkage void do_undefinstr(struct pt_regs *regs)
 {
 	unsigned int instr;
-	void __user *pc;
+	void *pc;
 
-	pc = (void __user *)instruction_pointer(regs);
+	pc = (void *)instruction_pointer(regs);
 
 	if (processor_mode(regs) == SVC_MODE) {
 #ifdef CONFIG_THUMB2_KERNEL
@@ -494,7 +494,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 	}
 #endif
 	arm_notify_die("Oops - undefined instruction", regs,
-		       SIGILL, ILL_ILLOPC, pc, 0, 6);
+		       SIGILL, ILL_ILLOPC, (void __user *)pc, 0, 6);
 }
 NOKPROBE_SYMBOL(do_undefinstr)
 
-- 
2.25.1

