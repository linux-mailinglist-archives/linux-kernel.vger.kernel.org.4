Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E8747D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGEGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjGEGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:47:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477761709;
        Tue,  4 Jul 2023 23:47:47 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qwqt32qHvzLnn5;
        Wed,  5 Jul 2023 14:45:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:47:43 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <stable@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mhiramat@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <sashal@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <xukuohai@huawei.com>, <natechancellor@gmail.com>,
        <ndesaulniers@google.com>, <rostedt@goodmis.org>,
        <weiyongjun1@huawei.com>, <gustavoars@kernel.org>,
        <namit@vmware.com>, <laijs@linux.alibaba.com>,
        <clang-built-linux@googlegroups.com>, <lihuafei1@huawei.com>
Subject: [PATCH 5.10 6/9] x86/kprobes: Fix to identify indirect jmp and others using range case
Date:   Wed, 5 Jul 2023 14:46:50 +0800
Message-ID: <20230705064653.226811-7-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705064653.226811-1-lihuafei1@huawei.com>
References: <20230705064653.226811-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 2f706e0e5e263c0d204e37ea496cbb0e98aac2d2 ]

Fix can_boost() to identify indirect jmp and others using range case
correctly.

Since the condition in switch statement is opcode & 0xf0, it can not
evaluate to 0xff case. This should be under the 0xf0 case. However,
there is no reason to use the conbinations of the bit-masked condition
and lower bit checking.

Use range case to clean up the switch statement too.

Fixes: 6256e668b7 ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/161666692308.1120877.4675552834049546493.stgit@devnote2
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 44 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7778b3791bee..109221af5d49 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -165,32 +165,28 @@ int can_boost(struct insn *insn, void *addr)
 
 	opcode = insn->opcode.bytes[0];
 
-	switch (opcode & 0xf0) {
-	case 0x60:
-		/* can't boost "bound" */
-		return (opcode != 0x62);
-	case 0x70:
-		return 0; /* can't boost conditional jump */
-	case 0x90:
-		return opcode != 0x9a;	/* can't boost call far */
-	case 0xc0:
-		/* can't boost software-interruptions */
-		return (0xc1 < opcode && opcode < 0xcc) || opcode == 0xcf;
-	case 0xd0:
-		/* can boost AA* and XLAT */
-		return (opcode == 0xd4 || opcode == 0xd5 || opcode == 0xd7);
-	case 0xe0:
-		/* can boost in/out and absolute jmps */
-		return ((opcode & 0x04) || opcode == 0xea);
-	case 0xf0:
-		/* clear and set flags are boostable */
-		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
-	case 0xff:
-		/* indirect jmp is boostable */
+	switch (opcode) {
+	case 0x62:		/* bound */
+	case 0x70 ... 0x7f:	/* Conditional jumps */
+	case 0x9a:		/* Call far */
+	case 0xc0 ... 0xc1:	/* Grp2 */
+	case 0xcc ... 0xce:	/* software exceptions */
+	case 0xd0 ... 0xd3:	/* Grp2 */
+	case 0xd6:		/* (UD) */
+	case 0xd8 ... 0xdf:	/* ESC */
+	case 0xe0 ... 0xe3:	/* LOOP*, JCXZ */
+	case 0xe8 ... 0xe9:	/* near Call, JMP */
+	case 0xeb:		/* Short JMP */
+	case 0xf0 ... 0xf4:	/* LOCK/REP, HLT */
+	case 0xf6 ... 0xf7:	/* Grp3 */
+	case 0xfe:		/* Grp4 */
+		/* ... are not boostable */
+		return 0;
+	case 0xff:		/* Grp5 */
+		/* Only indirect jmp is boostable */
 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		/* call is not boostable */
-		return opcode != 0x9a;
+		return 1;
 	}
 }
 
-- 
2.17.1

