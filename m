Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA186DFFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDLUbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjDLUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B522114
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07AAB63911
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FEDC433EF;
        Wed, 12 Apr 2023 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331472;
        bh=8GhW4AZ4NxnljR80VEjsxcBXtn1G+kAae3SO1+2smj8=;
        h=From:To:Cc:Subject:Date:From;
        b=kOeueKX/ojHULbe/OAn33tWHUyiznA4fa4jpuvvFRzcivr/9P2SnKR8yrILtGpQqR
         kt8kMhBN0bMH0REcxm2bItuuZr5c7XlIydCJfp1M+Dgsm9zItqSQua6RWjkvOkYcSh
         G5OjH9lGtvLVhd+A44kIlYzmIi7i2QBT3GJgMal/8toKGRgEOB6eO+WAMpFUimPTzY
         Oc8w7fXdEh1QJyAMaIDfD2zzL9ltNeoeKayZT/cCYerLVIx/6fjjgqzwzmw6bRaV0Z
         EKzW4DkK2rZBuT65SVox3ED8AQQeTh5MRQHUCdx1Kvll/Px0MfxLW5vdk7xrN3do3X
         ktjsgWdWJJZNA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/unwind/orc: Add 'unwind_debug' cmdline option
Date:   Wed, 12 Apr 2023 13:31:05 -0700
Message-Id: <6afb9e48a05fd2046bfad47e69b061b43dfd0e0e.1681331449.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Sometimes the one-line ORC unwinder warnings aren't very helpful.  Add a
new 'unwind_debug' cmdline option which will dump the full stack
contents of the current task when an error condition is encountered.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 arch/x86/kernel/unwind_orc.c                  | 49 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6221a1d057dd..60838db8c663 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6530,6 +6530,12 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
+	unwind_debug	[X86-64]
+			Enable unwinder debug output.  This can be
+			useful for debugging certain unwinder error
+			conditions, including corrupt stacks and
+			bad/missing unwinder metadata.
+
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 5fbcb229f707..7891727f534e 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -13,8 +13,14 @@
 
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task == current && !state->error)			\
+	static bool dumped_before;					\
+	if (state->task == current && !state->error) {			\
 		orc_warn(args);						\
+		if (unwind_debug && !dumped_before) {			\
+			dumped_before = true;				\
+			unwind_dump(state);				\
+		}							\
+	}								\
 })
 
 extern int __start_orc_unwind_ip[];
@@ -23,8 +29,49 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
 static bool orc_init __ro_after_init;
+static bool unwind_debug __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
+static int __init unwind_debug_cmdline(char *str)
+{
+	unwind_debug = true;
+
+	return 0;
+}
+early_param("unwind_debug", unwind_debug_cmdline);
+
+static void unwind_dump(struct unwind_state *state)
+{
+	static bool dumped_before;
+	unsigned long word, *sp;
+	struct stack_info stack_info = {0};
+	unsigned long visit_mask = 0;
+
+	if (dumped_before)
+		return;
+
+	dumped_before = true;
+
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
+
+	for (sp = __builtin_frame_address(0); sp;
+	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
+		if (get_stack_info(sp, state->task, &stack_info, &visit_mask))
+			break;
+
+		for (; sp < stack_info.end; sp++) {
+
+			word = READ_ONCE_NOCHECK(*sp);
+
+			printk_deferred("%0*lx: %0*lx (%pB)\n", BITS_PER_LONG/4,
+					(unsigned long)sp, BITS_PER_LONG/4,
+					word, (void *)word);
+		}
+	}
+}
+
 static inline unsigned long orc_ip(const int *ip)
 {
 	return (unsigned long)ip + *ip;
-- 
2.39.2

