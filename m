Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB71C66975A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjAMMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbjAMMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA95472B;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tU7xkA9KuMwEryWI7gO1xNJIVv2jk6wF1JG0bF/3e24=;
        b=hiMLFCuEVVfG7LDn1Sv1jtrXhx/ISEX5W/w1gfoG9hkoFcJ39vkHQFFno8GFXxjSFMdQUr
        JBn8Y8+ADaz/AACR9YPE3kmK/+4Vb1HPo9HAmfvl7mTgOLwjTy3kTa+h74ei1tM6MTMVlb
        OnV0FoBq/512UhFBmWya+jxDb/mKlwY8BmNaq4k2oNsfBqppdkkNFuMuzpDDLCS/c21vtK
        NbidV/+GVHm8uU4vO1XYX9lZ7okouI2B0IADgErldX4tlBVsZaOnMfxo+0BGtPc1Xl/L2r
        rlcqVyeX+BHrc136EQHO5XI+G7oPcmWiS6J1qmlS2U6LS+iem3SuLFlCFdd/oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tU7xkA9KuMwEryWI7gO1xNJIVv2jk6wF1JG0bF/3e24=;
        b=tFfmIOso4RExrUJtxR01ctfxfFB9EiysLiSMV6VFVXN7Cuh0dxbIabl2e2euo6yJwJmerN
        KalDBu2d58Ij/UAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, tdx: Make TDX code noinstr clean
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.111485720@infradead.org>
References: <20230112195541.111485720@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306922.4906.15745599332550388182.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c3982c1a36f70bd4521a9852246ea50105912084
Gitweb:        https://git.kernel.org/tip/c3982c1a36f70bd4521a9852246ea50105912084
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, tdx: Make TDX code noinstr clean

objtool found a few cases where this code called out into instrumented
code:

  vmlinux.o: warning: objtool: __halt+0x2c: call to hcall_func.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __halt+0x3f: call to __tdx_hypercall() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __tdx_hypercall+0x66: call to __tdx_hypercall_failed() leaves .noinstr.text section

Fix it by:

  - moving TDX tdcall assembly methods into .noinstr.text (they are already noistr-clean)
  - marking __tdx_hypercall_failed() as 'noinstr'
  - annotating hcall_func() as __always_inline

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.111485720@infradead.org
---
 arch/x86/boot/compressed/vmlinux.lds.S | 1 +
 arch/x86/coco/tdx/tdcall.S             | 2 ++
 arch/x86/coco/tdx/tdx.c                | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b237..b22f34b 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -34,6 +34,7 @@ SECTIONS
 		_text = .; 	/* Text */
 		*(.text)
 		*(.text.*)
+		*(.noinstr.text)
 		_etext = . ;
 	}
 	.rodata : {
diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 508c173..ad0d51f 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -31,6 +31,8 @@
 					  TDX_R12 | TDX_R13 | \
 					  TDX_R14 | TDX_R15 )
 
+.section .noinstr.text, "ax"
+
 /*
  * __tdx_module_call()  - Used by TDX guests to request services from
  * the TDX module (does not include VMM services) using TDCALL instruction.
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8804174..70e8015 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -64,8 +64,9 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 }
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
-void __tdx_hypercall_failed(void)
+noinstr void __tdx_hypercall_failed(void)
 {
+	instrumentation_begin();
 	panic("TDVMCALL failed. TDX module bug?");
 }
 
@@ -75,7 +76,7 @@ void __tdx_hypercall_failed(void)
  * Reusing the KVM EXIT_REASON macros makes it easier to connect the host and
  * guest sides of these calls.
  */
-static u64 hcall_func(u64 exit_reason)
+static __always_inline u64 hcall_func(u64 exit_reason)
 {
 	return exit_reason;
 }
