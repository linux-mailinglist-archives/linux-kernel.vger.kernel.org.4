Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEF71388A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjE1HxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1HxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 03:53:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A99DE
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 00:53:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685260379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qlUJpstUp8GkAxNo3SCZ1B+h0hwX5UKSIsVt7FBPBlA=;
        b=gs94pY1jwBtUe9l/A8VtGMSo2Bs6oA7yoJb28bSVe3/ohtdFAnYCqLFnf9dL9H5dwcxPuT
        hFMLmtCOlRX6yWDHzqj83eJJGixTkkcIK1fJzQeNFnPHVnlR6EKKUJOneB9YwC4SYxAz3u
        beVv2/dZTaAGr3fHozhrs0SNKNr6QjLPbRGMDJoKHCVsvi5ZznCaFZvxYJpxzE3goS7oZq
        3tbBCtOvKcsyVWrC9hh/qazhIA6W3YEc+MX7iZIuqNUqfXoqxNmxRAR5Cdpe1la9NjyDFR
        d5z/gOb+azNVuiZM0sAw7Gr72/DSiSgvvTSkgBEpKfJVoyJTMYpSt7LIO/8/cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685260379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qlUJpstUp8GkAxNo3SCZ1B+h0hwX5UKSIsVt7FBPBlA=;
        b=xLfqp7eAPpb9y0iKs3C/jZIC9VVgiW5P3EfrWjxhuvWB7yJAcmk8aOAX1+Furw9Tp58UZf
        nbHGkeHkU/QgcuDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for 6.4-rc4
References: <168526035526.3457722.14103350194452732675.tglx@xen13>
Message-ID: <168526035832.3457722.15229575761840032304.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 28 May 2023 09:52:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2=
023-05-28

up to:  2e4be0d011f2: x86/show_trace_log_lvl: Ensure stack pointer is aligned=
, again


A set of unwinder and tooling fixes:

  - Ensure that the stack pointer on x86 is aligned again so that the
    unwinder does not read past the end of the stack

  - Discard .note.gnu.property section which has a pointlessly different
    alignment than the other note sections. That confuses tooling of all
    sorts including readelf, libbpf and pahole.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      vmlinux.lds.h: Discard .note.gnu.property section

Vernon Lovejoy (1):
      x86/show_trace_log_lvl: Ensure stack pointer is aligned, again


 arch/x86/kernel/dumpstack.c       | 7 +++++--
 include/asm-generic/vmlinux.lds.h | 9 ++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 0bf6779187dd..f18ca44c904b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,7 +195,6 @@ static void show_trace_log_lvl(struct task_struct *task, =
struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
=20
 	unwind_start(&state, task, regs, stack);
-	stack =3D stack ? : get_stack_pointer(task, regs);
 	regs =3D unwind_get_entry_regs(&state, &partial);
=20
 	/*
@@ -214,9 +213,13 @@ static void show_trace_log_lvl(struct task_struct *task,=
 struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for ( ; stack; stack =3D PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+	for (stack =3D stack ?: get_stack_pointer(task, regs);
+	     stack;
+	     stack =3D stack_info.next_sp) {
 		const char *stack_name;
=20
+		stack =3D PTR_ALIGN(stack, sizeof(long));
+
 		if (get_stack_info(stack, task, &stack_info, &visit_mask)) {
 			/*
 			 * We weren't on a valid stack.  It's possible that
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index d1f57e4868ed..cebdf1ca415d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -891,9 +891,16 @@
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NO=
TES.
+ *
+ * Also, discard .note.gnu.property, otherwise it forces the notes section to
+ * be 8-byte aligned which causes alignment mismatches with the kernel's cus=
tom
+ * 4-byte aligned notes.
  */
 #define NOTES								\
-	/DISCARD/ : { *(.note.GNU-stack) }				\
+	/DISCARD/ : {							\
+		*(.note.GNU-stack)					\
+		*(.note.gnu.property)					\
+	}								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		BOUNDED_SECTION_BY(.note.*, _notes)			\
 	} NOTES_HEADERS							\

