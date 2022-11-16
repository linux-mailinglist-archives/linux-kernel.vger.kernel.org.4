Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C962CEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiKPXeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiKPXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:33:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A792F02E;
        Wed, 16 Nov 2022 15:33:55 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668641633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MsnW/9b3W7fq8fblOzT42xDM/SlxUnTHjHj4eknSx64=;
        b=pPIVnLwpbnzGuO/1R3bbImKCDpkvN3zvwtmBH3mHwlbGtE1UVdxZd2ncs8w1axYHh1aKvP
        Z4E1oUlmDqRX311OylQtYS5sbbyK+yixI46UbJlApS1FK5LJ1UJyYG9I4hSYotg8uA589B
        CdA8ccQsDzLq37RXsYd1oCkJ5Xqq55i1+TLOE3To3AcMG1dk2gteZzQlEPRrRdwOQallQD
        XbhULjCTebRl01sRlV2O+lUBQ015yZ0afrkT9Tk6N6si39jTA/X+MaLrdVb7bk4NxCw8oJ
        PRxl0iTLDaPu9plhsxS5J7pFGBu5e4XwFpx/z0BvmbQPODylB0gfIaoT0Efq9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668641633;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MsnW/9b3W7fq8fblOzT42xDM/SlxUnTHjHj4eknSx64=;
        b=xC7p0Hhv+SGDHTS1V5SNMT6NY9Zr3CLCTZTj1Jy/IZpD52Noyp+0VbkeQPvTVIkh+3vobh
        m/M8UwZxD5xbBxAQ==
From:   "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add a pkru argument to copy_uabi_to_xstate()
Cc:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166864163188.4906.12947671892582185831.tip-bot2@tip-bot2>
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

Commit-ID:     2c87767c35ee9744f666ccec869d5fe742c3de0a
Gitweb:        https://git.kernel.org/tip/2c87767c35ee9744f666ccec869d5fe742c3de0a
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Tue, 15 Nov 2022 15:09:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 16 Nov 2022 15:03:30 -08:00

x86/fpu: Add a pkru argument to copy_uabi_to_xstate()

In preparation for moving PKRU handling code out of
fpu_copy_uabi_to_guest_fpstate() and into copy_uabi_to_xstate(), add an
argument that copy_uabi_from_kernel_to_xstate() can use to pass the
canonical location of the PKRU value. For
copy_sigframe_from_user_to_xstate() the kernel will actually restore the
PKRU value from the fpstate, but pass in the thread_struct's pkru location
anyways for consistency.

Signed-off-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221115230932.7126-4-khuey%40kylehuey.com
---
 arch/x86/kernel/fpu/xstate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d6f414a..d657c8b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1200,8 +1200,18 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 }
 
 
+/**
+ * copy_uabi_to_xstate - Copy a UABI format buffer to the kernel xstate
+ * @fpstate:	The fpstate buffer to copy to
+ * @kbuf:	The UABI format buffer, if it comes from the kernel
+ * @ubuf:	The UABI format buffer, if it comes from userspace
+ * @pkru:	unused
+ *
+ * Converts from the UABI format into the kernel internal hardware
+ * dependent format.
+ */
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
-			       const void __user *ubuf)
+			       const void __user *ubuf, u32 *pkru)
 {
 	struct xregs_state *xsave = &fpstate->regs.xsave;
 	unsigned int offset, size;
@@ -1270,7 +1280,7 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
  */
 int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u32 *pkru)
 {
-	return copy_uabi_to_xstate(fpstate, kbuf, NULL);
+	return copy_uabi_to_xstate(fpstate, kbuf, NULL, pkru);
 }
 
 /*
@@ -1281,7 +1291,7 @@ int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf, u
 int copy_sigframe_from_user_to_xstate(struct task_struct *tsk,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf);
+	return copy_uabi_to_xstate(tsk->thread.fpu.fpstate, NULL, ubuf, &tsk->thread.pkru);
 }
 
 static bool validate_independent_components(u64 mask)
