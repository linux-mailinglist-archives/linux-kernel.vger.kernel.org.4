Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009946011E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiJQO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D2F69183;
        Mon, 17 Oct 2022 07:54:01 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4Ok/fbnGAmjEVN0Qr/zdNfOqF8J2v/Ks5qkqOG/fFc=;
        b=yVJTgeMUxjMngVvb5cLb/vARREnRTPx6OfvRt7NMqoAA7dR//AE7tLi8iQx/qPLr2Kml5e
        Qbz68jzRhZbKlny1d+X+PlPo2BtTPtPOX9MlnvW4kZjKUiv78Kj5XEQCR5xc1lX1DZ1nRN
        wzIzCzzCCWWlJk5wWtZ3SxzDuSlU9oWBIXGhqH5t1vuZsfabILcIccL1aOBjzj+i+ifB2N
        tOUSYBK8pp/i2S0j7RGv9IpAJKcL4KU9B+uLiKvyYgp02GhOJ2yFc1VColL42NYBIsAf/J
        oIANLUe09cCFeS4N7+MYb5VUFE3ZmL0LTN16LKfMQX0tpJoCgmlYcPDuBZWrJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4Ok/fbnGAmjEVN0Qr/zdNfOqF8J2v/Ks5qkqOG/fFc=;
        b=Q9FZRN/CyyJW86hEx72s2W78KVpFK61a5YeQ7Bcp0zSN84DLzpXQYH4a+ur1xT3IMd9RS4
        23ujCG8mPy17LwBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Allow symbol range comparisons for IBT/ENDBR
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.434642471@infradead.org>
References: <20220915111146.434642471@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843692.401.16934924351803630402.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     08ef8c40112b8cd157515cd532f65cb82c934a76
Gitweb:        https://git.kernel.org/tip/08ef8c40112b8cd157515cd532f65cb82c934a76
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:08 +02:00

objtool: Allow symbol range comparisons for IBT/ENDBR

A semi common pattern is where code checks if a code address is
within a specific range. All text addresses require either ENDBR or
ANNOTATE_ENDBR, however the ANNOTATE_NOENDBR past the range is
unnatural.

Instead, suppress this warning when this is exactly at the end of a
symbol that itself starts with either ENDBR/ANNOTATE_ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.434642471@infradead.org
---
 arch/x86/entry/entry_64_compat.S |  1 -
 tools/objtool/check.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 1dfee86..bc45ea7 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -128,7 +128,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	popfq
 	jmp	.Lsysenter_flags_fixed
 SYM_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
-	ANNOTATE_NOENDBR // is_sysenter_singlestep
 SYM_CODE_END(entry_SYSENTER_compat)
 
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1461c88..3f46f46 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4033,6 +4033,24 @@ static void mark_endbr_used(struct instruction *insn)
 		list_del_init(&insn->call_node);
 }
 
+static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
+{
+	struct symbol *sym = find_symbol_containing(insn->sec, insn->offset-1);
+	struct instruction *first;
+
+	if (!sym)
+		return false;
+
+	first = find_insn(file, sym->sec, sym->offset);
+	if (!first)
+		return false;
+
+	if (first->type != INSN_ENDBR && !first->noendbr)
+		return false;
+
+	return insn->offset == sym->offset + sym->len;
+}
+
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
@@ -4105,9 +4123,19 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 		}
 
+		/*
+		 * Accept anything ANNOTATE_NOENDBR.
+		 */
 		if (dest->noendbr)
 			continue;
 
+		/*
+		 * Accept if this is the instruction after a symbol
+		 * that is (no)endbr -- typical code-range usage.
+		 */
+		if (noendbr_range(file, dest))
+			continue;
+
 		WARN_FUNC("relocation to !ENDBR: %s",
 			  insn->sec, insn->offset,
 			  offstr(dest->sec, dest->offset));
