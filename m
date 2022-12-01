Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726963F309
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiLAOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiLAOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:39:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8ECA8FE1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:39:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE9FD62029
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6BFC433D6;
        Thu,  1 Dec 2022 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669905565;
        bh=s6ICiOAJJFwO6u7uP13cxjjC82jHSuTLzzoIQZoxdr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNTeI/BKZGk6hBCF/yAwVMC1CHBMGqNL+rxW+yTg8twEdGmtg0ijvJ405PVCnq2SJ
         FURQug7F6k7EfTflm0OzMHKkb36xU4UKDrQ11EhvYz3/Xw/pq1wKkF0o+Teh2oe3S4
         uYl0NOVcgqoNChE4HoQ2d7TANB32cMpWsUwdR+ggmlh7ePihjB7QlczQDvz6MDsuuz
         74iLg40BxdaZrMQeutfbYIKIsIdmZ4eQ8Cgh+kYjuW2hlTYRwpmNX4TKYjrBTSavgk
         c/tKSjHhAXSR06djwoo82kxV5GOukSHcniabmY/vep4mGiDwd8sTOtImg0rR0iHg9V
         1HbrEBQ7GqGgg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: [PATCH 3/3] arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can not handle a BRK
Date:   Thu,  1 Dec 2022 23:39:21 +0900
Message-Id: <166990556124.253128.2968612748605960211.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <166990553243.253128.13594802750635478633.stgit@devnote3>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Return DBG_HOOK_ERROR if kprobes can not handle a BRK because it
fails to find a kprobe corresponding to the address.

Since arm64 kprobes uses stop_machine based text patching for removing
BRK, it ensures all running kprobe_break_handler() is done at that point.
And after removing the BRK, it removes the kprobe from its hash list.
Thus, if the kprobe_break_handler() fails to find kprobe from hash list,
there is a bug.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |   79 +++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d2ae37f89774..ea56b22d4da8 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -298,7 +298,8 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 	return 0;
 }
 
-static void __kprobes kprobe_handler(struct pt_regs *regs)
+static int __kprobes
+kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
 {
 	struct kprobe *p, *cur_kprobe;
 	struct kprobe_ctlblk *kcb;
@@ -308,39 +309,45 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 	cur_kprobe = kprobe_running();
 
 	p = get_kprobe((kprobe_opcode_t *) addr);
+	if (WARN_ON_ONCE(!p)) {
+		/*
+		 * Something went wrong. This must be put by kprobe, but we
+		 * could not find corresponding kprobes. Let the kernel handle
+		 * this error case.
+		 */
+		return DBG_HOOK_ERROR;
+	}
 
-	if (p) {
-		if (cur_kprobe) {
-			if (reenter_kprobe(p, regs, kcb))
-				return;
-		} else {
-			/* Probe hit */
-			set_current_kprobe(p);
-			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-
-			/*
-			 * If we have no pre-handler or it returned 0, we
-			 * continue with normal processing.  If we have a
-			 * pre-handler and it returned non-zero, it will
-			 * modify the execution path and no need to single
-			 * stepping. Let's just reset current kprobe and exit.
-			 */
-			if (!p->pre_handler || !p->pre_handler(p, regs)) {
-				setup_singlestep(p, regs, kcb, 0);
-			} else
-				reset_current_kprobe();
-		}
+	if (cur_kprobe) {
+		/* Hit a kprobe inside another kprobe */
+		if (!reenter_kprobe(p, regs, kcb))
+			return DBG_HOOK_ERROR;
+	} else {
+		/* Probe hit */
+		set_current_kprobe(p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+		/*
+		 * If we have no pre-handler or it returned 0, we
+		 * continue with normal processing.  If we have a
+		 * pre-handler and it returned non-zero, it will
+		 * modify the execution path and no need to single
+		 * stepping. Let's just reset current kprobe and exit.
+		 */
+		if (!p->pre_handler || !p->pre_handler(p, regs))
+			setup_singlestep(p, regs, kcb, 0);
+		else
+			reset_current_kprobe();
 	}
-	/*
-	 * The breakpoint instruction was removed right
-	 * after we hit it.  Another cpu has removed
-	 * either a probepoint or a debugger breakpoint
-	 * at this address.  In either case, no further
-	 * handling of this interrupt is appropriate.
-	 * Return back to original instruction, and continue.
-	 */
+
+	return DBG_HOOK_HANDLED;
 }
 
+static struct break_hook kprobes_break_hook = {
+	.imm = KPROBES_BRK_IMM,
+	.fn = kprobe_breakpoint_handler,
+};
+
 static int __kprobes
 kprobe_breakpoint_ss_handler(struct pt_regs *regs, unsigned long esr)
 {
@@ -365,18 +372,6 @@ static struct break_hook kprobes_break_ss_hook = {
 	.fn = kprobe_breakpoint_ss_handler,
 };
 
-static int __kprobes
-kprobe_breakpoint_handler(struct pt_regs *regs, unsigned long esr)
-{
-	kprobe_handler(regs);
-	return DBG_HOOK_HANDLED;
-}
-
-static struct break_hook kprobes_break_hook = {
-	.imm = KPROBES_BRK_IMM,
-	.fn = kprobe_breakpoint_handler,
-};
-
 /*
  * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
  * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).

