Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71D6011CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJQOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJQOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB667C9E;
        Mon, 17 Oct 2022 07:53:57 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJc7DbHTNMd0bpaV8Ivmr2gk8YnUAWvEEF6/nru1WAU=;
        b=iQ7bWd7c82Mo2Sg4OM4SHRc4Lh4nxjC22tcY+J/TdpFyCgvG5lHAQLVcgbXHDlv8S+ul2k
        I7Kej3lVgDz8zbQ53bMY76HiUdcfuHhJRpkgYaDf71xTz48cNLwOX6/L7ov0jZsoUNQ0L6
        az5dMOuql5j86wr1csBsG27GTZXzgtqh6EMiH6Au919uqwjkrBp+It7cwLYGxlKZNnWM33
        5+R09RwmJ6o9UynyT8z7nMorznIv65yRZ2T9tzJ2DA22Qxixrbbcody+63JxRLv3CB6vm6
        xb2iSPXsifUGjgF9M6/GeO151m1QQUV0uIlVKwB+FUtcycJB0EYSw/AsX0BcDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJc7DbHTNMd0bpaV8Ivmr2gk8YnUAWvEEF6/nru1WAU=;
        b=kqenss5/7mYx6pp2olicniMfjiD8LGVBc0bB3HMPU8ZE/YvH5Q70TDFMMJUImgX95B7GZu
        ogV+qOi7xqy5cABQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/paravirt: Make struct paravirt_call_site
 unconditionally available
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.367853167@infradead.org>
References: <20220915111147.367853167@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842588.401.15991551413916524608.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     239f2e248ef12840178a3ed1a217f19b5fbfde26
Gitweb:        https://git.kernel.org/tip/239f2e248ef12840178a3ed1a217f19b5fbfde26
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:12 +02:00

x86/paravirt: Make struct paravirt_call_site unconditionally available

For the upcoming call thunk patching it's less ifdeffery when the data
structure is unconditionally available. The code can then be trivially
fenced off with IS_ENABLED().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.367853167@infradead.org
---
 arch/x86/include/asm/paravirt.h       |  4 ++--
 arch/x86/include/asm/paravirt_types.h | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1be66c1..2851bc2 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -4,13 +4,13 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 
+#include <asm/paravirt_types.h>
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
 #include <asm/nospec-branch.h>
 
-#include <asm/paravirt_types.h>
-
 #ifndef __ASSEMBLY__
 #include <linux/bug.h>
 #include <linux/types.h>
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f3d6015..e137d94 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_H
 #define _ASM_X86_PARAVIRT_TYPES_H
 
+#ifndef __ASSEMBLY__
+/* These all sit in the .parainstructions section to tell us what to patch. */
+struct paravirt_patch_site {
+	u8 *instr;		/* original instructions */
+	u8 type;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+};
+#endif
+
+#ifdef CONFIG_PARAVIRT
+
 /* Bitmask of what can be clobbered: usually at least eax. */
 #define CLBR_EAX  (1 << 0)
 #define CLBR_ECX  (1 << 1)
@@ -593,16 +604,9 @@ unsigned long paravirt_ret0(void);
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
-/* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch_site {
-	u8 *instr;		/* original instructions */
-	u8 type;		/* type of this instruction */
-	u8 len;			/* length of original instruction */
-};
-
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
 #endif	/* __ASSEMBLY__ */
-
+#endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
