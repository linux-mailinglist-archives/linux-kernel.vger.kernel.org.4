Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35A747D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjGEGrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGEGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:47:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE791700;
        Tue,  4 Jul 2023 23:47:45 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwqrr5468zMqB8;
        Wed,  5 Jul 2023 14:44:28 +0800 (CST)
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
Subject: [PATCH 5.10 4/9] x86/kprobes: Identify far indirect JMP correctly
Date:   Wed, 5 Jul 2023 14:46:48 +0800
Message-ID: <20230705064653.226811-5-lihuafei1@huawei.com>
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

[ Upstream commit a194acd316f93f3435a64de3b37dca2b5a77b338 ]

Since Grp5 far indirect JMP is FF "mod 101 r/m", it should be
(modrm & 0x38) == 0x28, and near indirect JMP is also 0x38 == 0x20.
So we can mask modrm with 0x30 and check 0x20.
This is actually what the original code does, it also doesn't care
the last bit. So the result code is same.

Thus, I think this is just a cosmetic cleanup.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469873475.49483.13257083019966335137.stgit@devnote2
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/kernel/kprobes/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 40d5c603ce8e..d03baf1f4024 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -478,8 +478,7 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 			p->ainsn.is_call = 1;
 			p->ainsn.is_abs_ip = 1;
 			break;
-		} else if (((opcode & 0x31) == 0x20) ||
-			   ((opcode & 0x31) == 0x21)) {
+		} else if ((opcode & 0x30) == 0x20) {
 			/*
 			 * jmp near and far, absolute indirect
 			 * ip is correct.
-- 
2.17.1

