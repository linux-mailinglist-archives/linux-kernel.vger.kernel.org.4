Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF77465C481
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbjACRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbjACRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:13 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C513D00
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:06 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 6EE36349896
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=8Dq9fCIb191loq5TcL6Z1DnQkdWisKkldvRiZGy7tJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pJPxLA3fM56WG4jDk7E1oLAGSLu9P8CFtA0sNiW1cEXWmnp9mMC0BpYEQIHn7a1So
         Wovz7Sqe8KoqR0LuPusXjDcqLQDmBszj1q0K5HpcHTUtRkD7p3AC3E9nlNDFzQOD1P
         xa6cFDSO+57Q5c0baInUgFEc/mzcyRj5y/Qt2pCY=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 547483498BE; Tue,  3 Jan
 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 9B40834989B; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 6EDEC27E0402; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 4A19027E03FE; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 WktLtvcDHRf3; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 0D88E27E0402; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <436b.63b45b71.99905.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 4A19027E03FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=kyynoyCXVrgI1RVIOYOEcIIB8J/4uvzZLXgkFOo6ftM=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=N9W8Z0brjAqY8XmtqLIPQmWzyJHMZoWVaX/jLwpvEV0MLJNFFkPY1swABD6sF3eaT
 vRq8anLByKAy/T82xmvP+9STV9+3Z0XW4bOM1iWFG5DgYULkwrUhGCQoMNQJmoNAb3
 KPxm/6HiRSt2ldLShLiVtR1bgf09rGVrZ7ZvxZRU=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>
Subject: [RFC PATCH 22/25] kvx: Add support for jump labels
Date:   Tue,  3 Jan 2023 17:43:56 +0100
Message-ID: <20230103164359.24347-23-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for jump labels to kvx arch.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Jason Baron <jbaron@akamai.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ard Biesheuvel <ardb@kernel.org>
CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/jump_label.h | 59 +++++++++++++++++++++++++++++++
 arch/kvx/kernel/jump_label.c      | 34 ++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 arch/kvx/include/asm/jump_label.h
 create mode 100644 arch/kvx/kernel/jump_label.c

diff --git a/arch/kvx/include/asm/jump_label.h b/arch/kvx/include/asm/jump_label.h
new file mode 100644
index 000000000000..5becccaad20c
--- /dev/null
+++ b/arch/kvx/include/asm/jump_label.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_JUMP_LABEL_H
+#define _ASM_KVX_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#include <asm/insns_defs.h>
+
+#define JUMP_LABEL_NOP_SIZE (KVX_INSN_NOP_SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
+{
+	asm_volatile_goto("1:\n\t"
+			  "nop\n\t"
+			  ";;\n\t"
+			  ".pushsection __jump_table, \"aw\"\n\t"
+			  ".dword 1b, %l[l_yes], %c0\n\t"
+			  ".popsection\n\t"
+			  : :  "i" (&((char *)key)[branch]) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
+{
+	asm_volatile_goto("1:\n\t"
+			  "goto %l[l_yes]\n\t"
+			  ";;\n\t"
+			  ".pushsection __jump_table, \"aw\"\n\t"
+			  ".dword 1b, %l[l_yes], %c0\n\t"
+			  ".popsection\n\t"
+			  : :  "i" (&((char *)key)[branch]) :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
+typedef u64 jump_label_t;
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
+#endif  /* __ASSEMBLY__ */
+#endif
diff --git a/arch/kvx/kernel/jump_label.c b/arch/kvx/kernel/jump_label.c
new file mode 100644
index 000000000000..5a602dbdede0
--- /dev/null
+++ b/arch/kvx/kernel/jump_label.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/cpu.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <linux/stop_machine.h>
+#include <linux/types.h>
+
+#include <asm/cacheflush.h>
+#include <asm/insns.h>
+#include <asm/insns_defs.h>
+
+void arch_jump_label_transform(struct jump_entry *e,
+			       enum jump_label_type type)
+{
+	s32 off = (jump_entry_target(e) - jump_entry_code(e));
+	u32 insn_code;
+	u32 *insn_addr = (u32 *) jump_entry_code(e);
+
+	if (type == JUMP_LABEL_JMP) {
+		BUG_ON(KVX_INSN_GOTO_PCREL27_CHECK(off));
+
+		KVX_INSN_GOTO(&insn_code, KVX_INSN_PARALLEL_EOB, off);
+	} else {
+		KVX_INSN_NOP(&insn_code, KVX_INSN_PARALLEL_EOB);
+	}
+
+	kvx_insns_write(&insn_code, JUMP_LABEL_NOP_SIZE, insn_addr);
+}
-- 
2.37.2





