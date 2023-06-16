Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C897339A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbjFPTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbjFPTRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B293A82;
        Fri, 16 Jun 2023 12:17:04 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V1fBaDsUl+9k5SZLqSIJ9Oo8MPX0J+YZOQ1n9yrpp9w=;
        b=OQHxCVOCbwkplnggYIek69RjySzUt4wcAft1VpZ5KlKoYA14fpW1C/0xfrHmgAsdUnjZ/v
        o41V1KjALW6KqtvKRwJeQ8I6I3LPSPh11hrhusufV8P7I8tN6Al/Ks9qlXhxcL0nk76Unf
        QQJ7uDYaZY7eETgGen4QYZDJxzLW2Pv/5yM1SDOhAgB+ryc5oZheMoCMENhoDHfqvvukAY
        uLNBkKiGKPOEiWvs1knLhnLTml7Xo9ds7VMdDotii7ER4TF24h2IjRRzy54owF88QcvcVB
        KOJgbj5F++hl64oRoukK23kzdU8nUtzj/I4XmQ5ZEXM8D+B+KTKE+CS1oxhY5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V1fBaDsUl+9k5SZLqSIJ9Oo8MPX0J+YZOQ1n9yrpp9w=;
        b=hHf6XJ35Fw4Qw7au8DwaB9D1JseMVQ0R74hRzMCgCOafHhLpQP8BldXvJcQ8XeLcgq7gG1
        VM5jIgdIRs8NqJDg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302255.404.6530532908295082254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     eb310c4caf713ff12237526bb94b0de229118137
Gitweb:        https://git.kernel.org/tip/eb310c4caf713ff12237526bb94b0de229118137
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:39 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

x86/mm: Remove _PAGE_DIRTY from kernel RO pages

New processors that support Shadow Stack regard Write=0,Dirty=1 PTEs as
shadow stack pages.

In normal cases, it can be helpful to create Write=1 PTEs as also Dirty=1
if HW dirty tracking is not needed, because if the Dirty bit is not already
set the CPU has to set Dirty=1 when the memory gets written to. This
creates additional work for the CPU. So traditional wisdom was to simply
set the Dirty bit whenever you didn't care about it. However, it was never
really very helpful for read-only kernel memory.

When CR4.CET=1 and IA32_S_CET.SH_STK_EN=1, some instructions can write to
such supervisor memory. The kernel does not set IA32_S_CET.SH_STK_EN, so
avoiding kernel Write=0,Dirty=1 memory is not strictly needed for any
functional reason. But having Write=0,Dirty=1 kernel memory doesn't have
any functional benefit either, so to reduce ambiguity between shadow stack
and regular Write=0 pages, remove Dirty=1 from any kernel Write=0 PTEs.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-14-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable_types.h | 8 +++++---
 arch/x86/mm/pat/set_memory.c         | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 91062b4..b639b8d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -218,10 +218,12 @@ enum page_cache_mode {
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
 
-#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
+#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
+#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|   0|   0|___G)
+#define __PAGE_KERNEL		 (__PP|__RW|   0|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_EXEC	 (__PP|__RW|   0|___A|   0|___D|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
-#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|   0|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
 #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
 #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf7..fc627ac 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2073,12 +2073,12 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW | _PAGE_DIRTY), 0);
 }
 
 int set_memory_rox(unsigned long addr, int numpages)
 {
-	pgprot_t clr = __pgprot(_PAGE_RW);
+	pgprot_t clr = __pgprot(_PAGE_RW | _PAGE_DIRTY);
 
 	if (__supported_pte_mask & _PAGE_NX)
 		clr.pgprot |= _PAGE_NX;
