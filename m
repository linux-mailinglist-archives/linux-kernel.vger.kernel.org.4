Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F95747D56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGEGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjGEGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:47:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C11703;
        Tue,  4 Jul 2023 23:47:45 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QwqsG2MhhztR6Q;
        Wed,  5 Jul 2023 14:44:50 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:47:41 +0800
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
Subject: [PATCH 5.10 3/9] x86/kprobes: Retrieve correct opcode for group instruction
Date:   Wed, 5 Jul 2023 14:46:47 +0800
Message-ID: <20230705064653.226811-4-lihuafei1@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit d60ad3d46f1d04a282c56159f1deb675c12733fd ]

Since the opcodes start from 0xff are group5 instruction group which is
not 2 bytes opcode but the extended opcode determined by the MOD/RM byte.

The commit abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
used insn->opcode.bytes[1], but that is not correct. We have to refer
the insn->modrm.bytes[1] instead.

Fixes: abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469872400.49483.18214724458034233166.stgit@devnote2
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 19ca5164be4d..40d5c603ce8e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -464,7 +464,11 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 		break;
 #endif
 	case 0xff:
-		opcode = insn->opcode.bytes[1];
+		/*
+		 * Since the 0xff is an extended group opcode, the instruction
+		 * is determined by the MOD/RM byte.
+		 */
+		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
 			/*
 			 * call absolute, indirect
-- 
2.17.1

