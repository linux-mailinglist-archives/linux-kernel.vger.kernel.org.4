Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0A62CEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiKPXeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbiKPXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:34:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D449B46;
        Wed, 16 Nov 2022 15:33:57 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BIb2nOVzdKV7fJjQ2ycPYqfNNp5cI/HfWI1S6RSu83A=;
        b=TzLuM7xkr9NGQcEE4rtRFVJ3FAdWJ6s7Lwsz+mIUPibLFIVgOcGNsZy/ODX1llcgJRyOUV
        iofAfo6/93+FSn0NV5nlYQc6DSBm2geIak1nizbEENY3g097YT/UCeHMM0O1ARFX/fC7R4
        G7rfS7MaJTwrxgWWgEpaAsy9uDMN0uoyZn1gsp4g5oBF2xwn+p29j6pdXSUugg8SgwcEff
        smB0vuBXMeKg2g/NAPAuqLYZ+5r33LHv3JWNsdV8WvZyXo3Y/RGKJbt/2TfvUH6RGRjS1Q
        FY5BodTwYJp9tjPhpV6PRoB21Cz/v3moJMQOuJf/pxsupGDFPtwgG+ylZG2xPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BIb2nOVzdKV7fJjQ2ycPYqfNNp5cI/HfWI1S6RSu83A=;
        b=M2PZen7bnALy83U5Ul57cGLH1B3FQ842UYYAALaQOXC0ahXq7pqDg+bdyCdZS4w9VFkeQ3
        w1aHwfgYOX8ZL/Dg==
From:   "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Take task_struct* in
 copy_sigframe_from_user_to_xstate()
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166864163463.4906.1952742397458403904.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6a877d2450ace4f27c012519e5a1ae818f931983
Gitweb:        https://git.kernel.org/tip/6a877d2450ace4f27c012519e5a1ae818f931983
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:27 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 16 Nov 2022 15:02:30 -08:00

x86/fpu: Take task_struct* in copy_sigframe_from_user_to_xstate()

This will allow copy_sigframe_from_user_to_xstate() to grab the address of
thread_struct's pkru value in a later patch.

Signed-off-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221115230932.7126-2-khuey%40kylehuey.com
---
 arch/x86/kernel/fpu/signal.c | 2 +-
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 arch/x86/kernel/fpu/xstate.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 91d4b6d..558076d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -396,7 +396,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 
 	fpregs = &fpu->fpstate->regs;
 	if (use_xsave() && !fx_only) {
-		if (copy_sigframe_from_user_to_xstate(fpu->fpstate, buf_fx))
+		if (copy_sigframe_from_user_to_xstate(tsk, buf_fx))
 			return false;
 	} else {
 		if (__copy_from_user(&fpregs->fxsave, buf_fx,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c2dde46..c88c60b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1278,10 +1278,10 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate,
+int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(fpstate, NULL, ubuf);
+	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf);
 }
 
 static bool validate_independent_components(u64 mask)
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 5ad4703..f08ee27 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -47,7 +47,7 @@ extern void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 				    enum xstate_copy_mode mode);
 extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
-extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const void __user *ubuf);
+extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void __user *ubuf);
 
 
 extern void fpu__init_cpu_xstate(void);
