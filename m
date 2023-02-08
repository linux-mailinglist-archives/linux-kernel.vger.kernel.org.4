Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193AC68F899
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBHUKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjBHUJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:09:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB79E38C;
        Wed,  8 Feb 2023 12:09:57 -0800 (PST)
Date:   Wed, 08 Feb 2023 20:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675886995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nkBggcmalQyIVcJVJzEc/6t0NOZc5Dw4snR/EDYZs4=;
        b=hvFfBHd5EGXj4RmObTGq3wkVU80wsJ57K0ukEaUITpb8STANTBvc++agklzwo/kP9no47e
        KOV7jIOnLzG04Heyi8BZmkISGkXAulnhSULvDp9rLwlYsY0xa+OlTr4Y7p9XEYdFTWGGKI
        CvvD/GU1tybLyG7ENTM/0/ggID0h1cfc7N6x0/X5pOV9N045vMXWI7y/dh3tUV5sPu2sju
        kIssKYn18qFVoA+3fXjlkICKqetRjYk3xH/BsM2ytCC7j6Nl5nt43m+swELZq1cDg+DvQY
        hvnSznkMQbWKHGtXtJwj6Nus9aWRqR46yWl5Kr3uSs8DA1x9EjcR/r8Cme5HmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675886995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nkBggcmalQyIVcJVJzEc/6t0NOZc5Dw4snR/EDYZs4=;
        b=anc3FzAGinGbu5ik5FBLe/mSpbNIm12otmtZkAPPy/JriWjh8cg1LAyUY1huMxR7zYXZHJ
        9ZTkbwkO1K0DEOCA==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kprobes: Fix 1 byte conditional jump target
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167588699468.4906.8001929680008508448.tip-bot2@tip-bot2>
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

Commit-ID:     ae052e3ae09572194d7e574906db7272041577d3
Gitweb:        https://git.kernel.org/tip/ae052e3ae09572194d7e574906db7272041577d3
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Wed, 08 Feb 2023 07:17:08 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Feb 2023 12:03:27 -08:00

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
