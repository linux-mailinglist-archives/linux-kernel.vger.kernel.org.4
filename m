Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700A601073
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJQNrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJQNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:47:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415952825;
        Mon, 17 Oct 2022 06:47:34 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666014451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqBa9Ui0a5BzY8tHtFFmljjsK0hmX5eiFPxQJ7f2bbc=;
        b=LRNjp5ifONGe7zYMKC/22iEY1mmXz8lpRQbCXrx4lfR8KxaG/O71MzNH7kSDFTU874lx9n
        LnKPROcNMoOCBjcnyCxhdePwiEInAp2kpyUbGrxI3y8lmyrEBAOkNCLkBSIzGoGJTSGky4
        zDUMPeFuVnwwPxan8cPq3FSdZu15K+9anxZhvx2oR1PME2/kaIouepOlHcLdvkU1xBA25f
        cW/wExufSMJWqYPQXMFhdulPJgPGr+ja/jPUe5BRzgRjxxdw5XuXkeB9fhT/r5c1PMQ8xF
        0+uQPro8dMJRnlanetOo8x5H4tFosf2wBlbSrI5YHA7OQew87yH2tdOkkD+cAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666014451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqBa9Ui0a5BzY8tHtFFmljjsK0hmX5eiFPxQJ7f2bbc=;
        b=kJ2iDCSuCKuNl1CPwReaMyDg8XpthNf9ioNYKP7udbZaVZZRD7d4AEGrYAuPEqOCr12f2M
        ZsjaqO3c99ji2XBw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Exclude dynamic states from init_fpstate
Cc:     Lin X Wang <lin.x.wang@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824191223.1248-4-chang.seok.bae@intel.com>
References: <20220824191223.1248-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <166601445015.401.6980293789787013355.tip-bot2@tip-bot2>
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

Commit-ID:     a401f45e38754953c9d402f8b3bc965707eecc91
Gitweb:        https://git.kernel.org/tip/a401f45e38754953c9d402f8b3bc965707eecc91
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Wed, 24 Aug 2022 12:12:23 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Oct 2022 15:44:25 +02:00

x86/fpu: Exclude dynamic states from init_fpstate

== Background ==

The XSTATE init code initializes all enabled and supported components.
Then, the init states are saved in the init_fpstate buffer that is
statically allocated in about one page.

The AMX TILE_DATA state is large (8KB) but its init state is zero. And the
feature comes only with the compacted format with these established
dependencies: AMX->XFD->XSAVES. So this state is excludable from
init_fpstate.

== Problem ==

But the buffer is formatted to include that large state. Then, this can be
the cause of a noisy splat like the below.

This came from XRSTORS for the task with init_fpstate in its XSAVE buffer.
It is reproducible on AMX systems when the running kernel is built with
CONFIG_DEBUG_PAGEALLOC=y and CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y:

 Bad FPU state detected at restore_fpregs_from_fpstate+0x57/0xd0, reinitializing FPU registers.
 ...
 RIP: 0010:restore_fpregs_from_fpstate+0x57/0xd0
  ? restore_fpregs_from_fpstate+0x45/0xd0
  switch_fpu_return+0x4e/0xe0
  exit_to_user_mode_prepare+0x17b/0x1b0
  syscall_exit_to_user_mode+0x29/0x40
  do_syscall_64+0x67/0x80
  ? do_syscall_64+0x67/0x80
  ? exc_page_fault+0x86/0x180
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

== Solution ==

Adjust init_fpstate to exclude dynamic states. XRSTORS from init_fpstate
still initializes those states when their bits are set in the
requested-feature bitmap.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Reported-by: Lin X Wang <lin.x.wang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Lin X Wang <lin.x.wang@intel.com>
Link: https://lore.kernel.org/r/20220824191223.1248-4-chang.seok.bae@intel.com

---
 arch/x86/kernel/fpu/xstate.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f5ef786..e77cabf 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -857,9 +857,12 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	update_regset_xstate_info(fpu_user_cfg.max_size,
 				  fpu_user_cfg.max_features);
 
-	/* Bring init_fpstate size and features up to date */
-	init_fpstate.size		= fpu_kernel_cfg.max_size;
-	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
+	/*
+	 * init_fpstate excludes dynamic states as they are large but init
+	 * state is zero.
+	 */
+	init_fpstate.size		= fpu_kernel_cfg.default_size;
+	init_fpstate.xfeatures		= fpu_kernel_cfg.default_features;
 
 	if (init_fpstate.size > sizeof(init_fpstate.regs)) {
 		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d), disabling XSAVE\n",
