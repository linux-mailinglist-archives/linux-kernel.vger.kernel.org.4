Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467768F702
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBHSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjBHSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:35:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343956498;
        Wed,  8 Feb 2023 10:35:11 -0800 (PST)
Date:   Wed, 08 Feb 2023 18:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675881310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pcFjdWbs2XTopyqPClTl+dUkRc1UPDvqjqiKoje/Vj0=;
        b=0k14qGeZfdPHaKnLiQkIzZywhiJOcfCacHEP3/Ouw2a0/nMtiOv2nKM7C6uHNHaOeEpS9N
        heSuWH01fuNJWwJsvrfiWE/4MBk39yBB8GXJYtNELLjU0k1DwTFZ8ctwvEaO25h0+zDG5t
        SW1a0PLaBQkGJLXwWOSBjOMc1pNrgNhWV4GkC3cmzWokGh7nKXOJ5IWkXWvVQvt4lAvO5p
        Aj2e3r0iE3vvGeO/LqxiXzkvAlOOgvRi9QXgTQqUMLG+xjTUlaQLyY+9GJ8KQEwMZFHBI2
        x9QlDkBP2PLJhVJtK23+z3F09wGPgSOVReoQL3sEmzMPSfgLDe/AyWTcAgOGQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675881310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pcFjdWbs2XTopyqPClTl+dUkRc1UPDvqjqiKoje/Vj0=;
        b=y0koWMrDq72sbcPZGIHF4ZqwVgbr8UQ5eAzfJz1dHj/xkirFyUQD+EGq5izg3AOSNFzfBn
        F1RtiXBK+wvY7DDw==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kprobes: Fix 1 byte conditional jump target
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167588130939.4906.8140947496160437703.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bd467ddd80ab3ecdd846ac148274603e1214ae73
Gitweb:        https://git.kernel.org/tip/bd467ddd80ab3ecdd846ac148274603e1214ae73
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Wed, 08 Feb 2023 07:17:08 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Feb 2023 08:26:21 -08:00

x86/kprobes: Fix 1 byte conditional jump target

Commit 3bc753c06dd0 ("kbuild: treat char as always unsigned") broke
kprobes.  Setting a probe-point on 1 byte conditional jump can cause the
kernel to crash when the (signed) relative jump offset gets treated as
unsigned.

Fix by replacing the unsigned 'immediate.bytes' (plus a cast) with the
signed 'immediate.value' when assigning to the relative jump offset.

[ dhansen: clarified changelog ]

Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230208071708.4048-1-namit%40vmware.com
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b36f3c3..695873c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -625,7 +625,7 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
 		/* 1 byte conditional jump */
 		p->ainsn.emulate_op = kprobe_emulate_jcc;
 		p->ainsn.jcc.type = opcode & 0xf;
-		p->ainsn.rel32 = *(char *)insn->immediate.bytes;
+		p->ainsn.rel32 = insn->immediate.value;
 		break;
 	case 0x0f:
 		opcode = insn->opcode.bytes[1];
