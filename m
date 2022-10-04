Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC25F490A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJDSHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJDSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:07:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980461EED6;
        Tue,  4 Oct 2022 11:07:36 -0700 (PDT)
Date:   Tue, 04 Oct 2022 18:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664906854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Buvg75iS92I0UDfCpd9qBltTzuOjiTg3cDhwVij++wM=;
        b=FDMZR+RbsYW7/ifV8mB/kXtIyI8yIGA4mTCcG7JScD8ye2PcWeGeyyFIVj2gFjol14KyMp
        0i/K2YzsSzzTHF6k/YDXX4BcIkiaQFKU0Yoya8LwFDmExpMLnApDEkGISyFYMX8D7vLe6N
        NUyjU1oHR+CFCAyBrZf6a7aoMfi3ipjUN97syIuy+UQiIFQbFi0uzJbZfwmK2AMCygNQj5
        xyxQytKzfnlT15p/+v8m2SCsrofAKF8HMwq+DY9FBLnOvWNCwFHQKUz7ElhszRJxRIzkFv
        5CTiexlH3vu7vnmoEklGvRPtD5mfH3wUdgYfykQgHUJ+vkhcWdAMeOuAe7uReg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664906854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Buvg75iS92I0UDfCpd9qBltTzuOjiTg3cDhwVij++wM=;
        b=ujBCuTNnHoa+qAvRxKfhlLEiUp7WTu1eB0KEnnn5exCvZw2l7LcP5kOwzsYN/rZ66+qj/V
        skDw0GlaTaNQvIBg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Ease W^X enforcement back to just a warning
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166490685242.401.17129977356268001359.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e9935b87c46236e8d7dd0acb847a31952db25228
Gitweb:        https://git.kernel.org/tip/e9935b87c46236e8d7dd0acb847a31952db25228
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 03 Oct 2022 13:23:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 04 Oct 2022 11:00:24 -07:00

x86/mm: Ease W^X enforcement back to just a warning

Currently, the "change_page_attr" (CPA) code refuses to create
W+X mappings on 64-bit kernels.  There have been reports both
from 32-bit[1] and from BPF[2] users where this change kept the
system from booting.

These reports are showing up even after about a month of soak
time in -next.

To avoid breaking anything, never enforce W^X.  Always warn
and return the requested permissions even if a problem is
detected.

1. https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/
2. https://lore.kernel.org/bpf/c84cc27c1a5031a003039748c3c099732a718aec.camel@kernel.org/T/#u

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index efe882c..97342c4 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -580,7 +580,7 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 }
 
 /*
- * Validate and enforce strict W^X semantics.
+ * Validate strict W^X semantics.
  */
 static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
 				  unsigned long pfn, unsigned long npg)
@@ -595,7 +595,7 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if (IS_ENABLED(CONFIG_X86_32))
 		return new;
 
-	/* Only enforce when NX is supported: */
+	/* Only verify when NX is supported: */
 	if (!(__supported_pte_mask & _PAGE_NX))
 		return new;
 
@@ -606,13 +606,17 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 		return new;
 
 	end = start + npg * PAGE_SIZE - 1;
-	WARN_ONCE(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
+	WARN_ONCE(1, "CPA detected W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
 		  (unsigned long long)pgprot_val(old),
 		  (unsigned long long)pgprot_val(new),
 		  start, end, pfn);
 
-	/* refuse the transition into WX */
-	return old;
+	/*
+	 * For now, allow all permission change attempts by returning the
+	 * attempted permissions.  This can 'return old' to actively
+	 * refuse the permission change at a later time.
+	 */
+	return new;
 }
 
 /*
