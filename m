Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D732E5F9C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJJJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJJJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:55:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204172980B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:55:02 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmDg839QCzmV6c;
        Mon, 10 Oct 2022 17:50:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:55:00 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:55:00 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] ARM: Fix some check warnings of tool sparse
Date:   Mon, 10 Oct 2022 17:53:45 +0800
Message-ID: <20221010095346.1957-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20221010095346.1957-1-thunder.leizhen@huawei.com>
References: <20221010095346.1957-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
index 20b2db6dcd1ced7..34aa80c09c508c1 100644
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
@@ -455,15 +455,15 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 	if (processor_mode(regs) == SVC_MODE) {
 #ifdef CONFIG_THUMB2_KERNEL
 		if (thumb_mode(regs)) {
-			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
+			instr = __mem_to_opcode_thumb16(((__force u16 *)pc)[0]);
 			if (is_wide_instruction(instr)) {
 				u16 inst2;
-				inst2 = __mem_to_opcode_thumb16(((u16 *)pc)[1]);
+				inst2 = __mem_to_opcode_thumb16(((__force u16 *)pc)[1]);
 				instr = __opcode_thumb32_compose(instr, inst2);
 			}
 		} else
 #endif
-			instr = __mem_to_opcode_arm(*(u32 *) pc);
+			instr = __mem_to_opcode_arm(*(__force u32 *) pc);
 	} else if (thumb_mode(regs)) {
 		if (get_user(instr, (u16 __user *)pc))
 			goto die_sig;
-- 
2.25.1

