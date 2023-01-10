Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8B663FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjAJMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjAJMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:03:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876D59323;
        Tue, 10 Jan 2023 04:03:31 -0800 (PST)
Date:   Tue, 10 Jan 2023 12:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673352208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9bzLMVcjlWE78ty3QzPuBu9rTI6kERleI5I9S4IWjs=;
        b=SW21dXGE5Z2bDw/1ZClLqIa2kd9WMWmVthDvxWB4Awm42IVEi2RWS9jQPgyD8SjYvgG0sq
        MaePPSJgOvcTmZTiRu5Tt113dE91T4lLvRxYwu0SK7svWCERAw3hsT9+E8SLGkSyIAz+tF
        R6R4OvTB7Cg3D749MKu46O8KJQalm54wfNLPASVoGU0h6MgDFEyNulj4CuL7Qtn8oXbenr
        RRc0LmVSit22gGizpqyGCzP1oz/fr29fpDPAfygcEKoWwdmevJrv5xaIDrlPn3+YY8Lggx
        oZmxLxZGmhcJtUwxoyME5hua/vtWVl6uAZ9BhEdxV3zpiefTEoda9L3J0yqddA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673352208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9bzLMVcjlWE78ty3QzPuBu9rTI6kERleI5I9S4IWjs=;
        b=0KNuPmwo3VsuqIQTFKb/8z94ZzknCaRYKgzKwQjzXnBbXC9StK++eQifo+Ay8cKUE0Nnru
        8TXB88NNtDzj9wCQ==
From:   "tip-bot2 for Chuang Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/kprobes: Use switch-case for 0xFF opcodes in
 prepare_emulation
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221129084022.718355-1-nashuiliang@gmail.com>
References: <20221129084022.718355-1-nashuiliang@gmail.com>
MIME-Version: 1.0
Message-ID: <167335220802.4906.8026759221140873503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9fcad995c6c52cc9791f7ee9f1386a5684055f9c
Gitweb:        https://git.kernel.org/tip/9fcad995c6c52cc9791f7ee9f1386a5684055f9c
Author:        Chuang Wang <nashuiliang@gmail.com>
AuthorDate:    Tue, 29 Nov 2022 16:39:51 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Jan 2023 12:37:14 +01:00

x86/kprobes: Use switch-case for 0xFF opcodes in prepare_emulation

For the `FF /digit` opcodes in prepare_emulation, use switch-case
instead of hand-written code to make the logic easier to understand.

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20221129084022.718355-1-nashuiliang@gmail.com
---
 arch/x86/kernel/kprobes/core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 33390ed..fd0420a 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -655,17 +655,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		 * is determined by the MOD/RM byte.
 		 */
 		opcode = insn->modrm.bytes[0];
-		if ((opcode & 0x30) == 0x10) {
-			if ((opcode & 0x8) == 0x8)
-				return -EOPNOTSUPP;	/* far call */
-			/* call absolute, indirect */
+		switch (X86_MODRM_REG(opcode)) {
+		case 0b010:	/* FF /2, call near, absolute indirect */
 			p->ainsn.emulate_op = kprobe_emulate_call_indirect;
-		} else if ((opcode & 0x30) == 0x20) {
-			if ((opcode & 0x8) == 0x8)
-				return -EOPNOTSUPP;	/* far jmp */
-			/* jmp near absolute indirect */
+			break;
+		case 0b100:	/* FF /4, jmp near, absolute indirect */
 			p->ainsn.emulate_op = kprobe_emulate_jmp_indirect;
-		} else
+			break;
+		case 0b011:	/* FF /3, call far, absolute indirect */
+		case 0b101:	/* FF /5, jmp far, absolute indirect */
+			return -EOPNOTSUPP;
+		}
+
+		if (!p->ainsn.emulate_op)
 			break;
 
 		if (insn->addr_bytes != sizeof(unsigned long))
