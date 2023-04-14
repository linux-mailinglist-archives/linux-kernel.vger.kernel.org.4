Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30B6E261A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjDNOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjDNOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501FD7DB6;
        Fri, 14 Apr 2023 07:47:56 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx2tQ9V501hMgE+B9bKTly7ITMMu1r81FFJ9D0d/AY4=;
        b=rXfoSBAh+9zOO0O7ORnXvFEHPbqdso/LrrBW7cPQkPvoNGmcUlU4kh7yUOUJTcrmsyua8o
        PcsrX8xAhe3fVn1xbJMTNDt4Flz6Jg5QN5ra7c895tj2nvE/OZcmn223nNUa4n+Sqc6dc6
        rX3Ru5dAEH+xVw4Ou8Ifi7rJrr8YWNRTtoMOep4QCxyM2vxN2byaFKQnLxzEcin5tgoa4r
        IWCu4hzMwlFgq1ChaPX8YETt24tAkOUlSyWoa8yV79oFWjgpAibDo2zlqpQIMmu2TEJqj7
        J8oGN2tk+JHCDgrXDpqBX+pb7COjMB+B4D5pvWAEIbrP2DUamz2gvMJYOgkpQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vx2tQ9V501hMgE+B9bKTly7ITMMu1r81FFJ9D0d/AY4=;
        b=hhyocZy1ce+CkY7npJa9xl4C45iTO0tbA+bkeTxA99vc4gHZA+0KoafuPjW+3+GLCw18E6
        c/dkIwJnzd3HxyAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Generate ORC data for __pfx code
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
References: <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367374.404.8240503217919092997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5743654f5e2ebd56df99f56fca5ba4b23fe3c815
Gitweb:        https://git.kernel.org/tip/5743654f5e2ebd56df99f56fca5ba4b23fe3c815
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 13:26:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:30 +02:00

objtool: Generate ORC data for __pfx code

Allow unwinding from prefix code by copying the CFI from the starting
instruction of the corresponding function.  Even when the NOPs are
replaced, they're still stack-invariant instructions so the same ORC
entry can be reused everywhere.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8ee4d51..df634da 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4117,6 +4117,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
 {
 	struct instruction *insn, *prev;
+	struct cfi_state *cfi;
 
 	insn = find_insn(file, func->sec, func->offset);
 	if (!insn)
@@ -4145,6 +4146,19 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
 	if (!prev)
 		return -1;
 
+	if (!insn->cfi) {
+		/*
+		 * This can happen if stack validation isn't enabled or the
+		 * function is annotated with STACK_FRAME_NON_STANDARD.
+		 */
+		return 0;
+	}
+
+	/* Propagate insn->cfi to the prefix code */
+	cfi = cfi_hash_find_or_add(insn->cfi);
+	for (; prev != insn; prev = next_insn_same_sec(file, prev))
+		prev->cfi = cfi;
+
 	return 0;
 }
 
