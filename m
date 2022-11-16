Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB7B62CEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiKPXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiKPXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:33:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255212080;
        Wed, 16 Nov 2022 15:33:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:33:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gk+s0SNCcfObphvn8Ft52sS0EKw2mqTbk1QEtC2x6vA=;
        b=TVWgb44rauKqGZktdyXjWIGiz45maiSqU/KI4qpINbBRUvkh77XD3LgRRr82AfG12VpVwL
        +J/9lr6icP5CPsYqwTWYVEobXOyRJroCzgahzHoNRzid32dZaDUQ/+R8Ro96SBzURgM7Fs
        PkLz7lnHf+K1mscNoa22BXsw46g/2yY8fmPgVqXZN4zfYB5dSWQqeBhjemmCzSl+Bg0YGe
        FDB4yDUIO8SskcWU6nd7u9IAfNDzHrvCy37u/WyiJhMwI/M1Xo6FmLSNUR6e6LakAJfRJj
        flgFMysndR6cfyiRdXfDtZRwoNWXaDbN40UFkNTC7xNdXSJ657ZTCMicYePQEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gk+s0SNCcfObphvn8Ft52sS0EKw2mqTbk1QEtC2x6vA=;
        b=OS7TpIGk/3UpQIg3BNv37tEM5PGXWxiEXMr2UyP3hThM02HKLoU6J01TnDaJQc4ZtNY4x7
        g9eDgVQ78Le+BAAw==
From:   "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Emulate XRSTOR's behavior if the xfeatures
 PKRU bit is not set
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166864162920.4906.12352601470149595048.tip-bot2@tip-bot2>
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

Commit-ID:     d7e5aceace514a2b1b3ca3dc44f93f1704766ca7
Gitweb:        https://git.kernel.org/tip/d7e5aceace514a2b1b3ca3dc44f93f1704766ca7
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:31 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 16 Nov 2022 15:06:34 -08:00

x86/fpu: Emulate XRSTOR's behavior if the xfeatures PKRU bit is not set

The hardware XRSTOR instruction resets the PKRU register to its hardware
init value (namely 0) if the PKRU bit is not set in the xfeatures mask.
Emulating that here restores the pre-5.14 behavior for PTRACE_SET_REGSET
with NT_X86_XSTATE, and makes sigreturn (which still uses XRSTOR) and
ptrace behave identically. KVM has never used XRSTOR and never had this
behavior, so KVM opts-out of this emulation by passing a NULL pkru pointer
to copy_uabi_to_xstate().

Fixes: e84ba47e313d ("x86/fpu: Hook up PKRU into ptrace()")
Signed-off-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221115230932.7126-6-khuey%40kylehuey.com
---
 arch/x86/kernel/fpu/core.c   |  8 ++++++++
 arch/x86/kernel/fpu/xstate.c | 15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 46b935b..8d0f601 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,6 +404,14 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
+	/*
+	 * Nullify @vpkru to preserve its current value if PKRU's bit isn't set
+	 * in the header.  KVM's odd ABI is to leave PKRU untouched in this
+	 * case (all other components are eventually re-initialized).
+	 */
+	if (!(ustate->xsave.header.xfeatures & XFEATURE_MASK_PKRU))
+		vpkru = NULL;
+
 	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a8cf604..714166c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1219,8 +1219,14 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
  *	it is harmless.
  * 2.	When called from ptrace the PKRU register will be restored from the
  *	thread_struct's pkru field. A pointer to that is passed in @pkru.
+ *	The kernel will restore it manually, so the XRSTOR behavior that resets
+ *	the PKRU register to the hardware init value (0) if the corresponding
+ *	xfeatures bit is not set is emulated here.
  * 3.	When called from KVM the PKRU register will be restored from the vcpu's
- *	pkru field. A pointer to that is passed in @pkru.
+ *	pkru field. A pointer to that is passed in @pkru. KVM hasn't used
+ *	XRSTOR and hasn't had the PKRU resetting behavior described above. To
+ *	preserve that KVM behavior, it passes NULL for @pkru if the xfeatures
+ *	bit is not set.
  */
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf, u32 *pkru)
@@ -1277,6 +1283,13 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 
 		xpkru = __raw_xsave_addr(xsave, XFEATURE_PKRU);
 		*pkru = xpkru->pkru;
+	} else {
+		/*
+		 * KVM may pass NULL here to indicate that it does not need
+		 * PKRU updated.
+		 */
+		if (pkru)
+			*pkru = 0;
 	}
 
 	/*
