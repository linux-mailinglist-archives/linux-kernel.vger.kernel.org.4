Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13661634338
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiKVSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKVSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B16A6BD;
        Tue, 22 Nov 2022 10:04:51 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669140290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV+Vu5nExTKWPYOeBZhl4AtcbxNOQy4jUkV4cFJwyCk=;
        b=JGYnRvQBJAZmRl0wXCdCqaEx+94V6gBRQx9N1vRdRJE8mg4LM1vaJsNuXdJA4DcVjZ+hdb
        06OqbC1KlMGS2Pf011Cs5nd7hcvQGAOoAjVsQ74omelnaBEm484I8SWtMuUYteUqfuGG2m
        CF/979fqPKA7OxJ9XkWfPJYzQFAMcK6m9+nkNMtJ7wT2ebZY445YB9H03CmOtL7Zn29zlN
        bOxkZQX41cjdXpOtoibdUsvthqBVk2gxjdl/Jkc6csJSiTVoh2uFjA5GSzUSxEP8abl6t0
        Kr1sf3lhv0JdFbJuUVGe8OJuKheAQtMCnFsFpj3kJVWmYCXDHYnpCHscToNGaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669140290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV+Vu5nExTKWPYOeBZhl4AtcbxNOQy4jUkV4cFJwyCk=;
        b=599Fus7PCHoxiMmnuulpUUu59Q2nMRpG7wYqHdgUT88HEcj/lM62GH8JscHA7nXAu6QGyl
        TVJNE1MPjnUd6UBg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Drop 32-bit Xen PV guest code in update_task_stack()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104072701.20283-4-jgross@suse.com>
References: <20221104072701.20283-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166914028910.4906.12824058487983110591.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dfbd9e4059c4edad4d92ef7f3deb4954f76e4ba0
Gitweb:        https://git.kernel.org/tip/dfbd9e4059c4edad4d92ef7f3deb4954f76e4ba0
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 04 Nov 2022 08:26:59 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 16:14:15 +01:00

x86/cpu: Drop 32-bit Xen PV guest code in update_task_stack()

Testing for Xen PV guest mode in a 32-bit only code section can be
dropped, as Xen PV guests are supported in 64-bit mode only.

While at it, switch from boot_cpu_has() to cpu_feature_enabled() in the
64-bit part of the code.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221104072701.20283-4-jgross@suse.com
---
 arch/x86/include/asm/switch_to.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c08eb0f..5c91305 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -66,13 +66,10 @@ static inline void update_task_stack(struct task_struct *task)
 {
 	/* sp0 always points to the entry trampoline stack, which is constant: */
 #ifdef CONFIG_X86_32
-	if (static_cpu_has(X86_FEATURE_XENPV))
-		load_sp0(task->thread.sp0);
-	else
-		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
 	/* Xen PV enters the kernel on the thread stack. */
-	if (static_cpu_has(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
 }
