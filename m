Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B08615F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiKBJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiKBJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF86286CF;
        Wed,  2 Nov 2022 02:12:50 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHIjnJe16gue8Q322qjop+qto5RQegQc/YhsoeJNQZk=;
        b=K/+nbRmMRJ/hi3/8hgsrsGcHenLBDwU/y99wDRZ4hF/2xwkFG+x5NqiKDicOccXxuoVdXf
        6EoO0X2HRgoTpUQO9NBnNF6H5WR1Em1GijgGOeZ2bnlImLO/n/f95PJ6rPNomG5tOScFhS
        lMu9XCEgj38kXP70pDqaQ0+ztpTae2HNn14FFxEWyl+LAjlJNEepjI7QlN6xuRWipr1QdV
        Siwf//9n+DcH7j7tNKAbuUJ5on/IDa6Xz/MLHMPqzdQoLoBAQQfwpsvmKwWxrxSSEAu31X
        pnYgvF60MI+sdQ5G8y8DusVejL/e383Yn95kYhBHVo8UtocCF0RgsduIKQY44Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHIjnJe16gue8Q322qjop+qto5RQegQc/YhsoeJNQZk=;
        b=t6dRcYm4kj8bGJTyIAjShfC4MZiEQLSUgxhs5h+gB5Yjnl3S6roa/lBlLCQqAF3VlDvwrr
        exAiveu5SPcKUrDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Implement native set_memory_rox()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738036738.7716.557888530898749563.tip-bot2@tip-bot2>
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

Commit-ID:     b38994948567e6d6b62947401c57f4ab2efe070c
Gitweb:        https://git.kernel.org/tip/b38994948567e6d6b62947401c57f4ab2efe070c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 29 Oct 2022 13:19:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:59 +01:00

x86/mm: Implement native set_memory_rox()

Provide a native implementation of set_memory_rox(), avoiding the
double set_memory_ro();set_memory_x(); calls.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h |  3 +++
 arch/x86/mm/pat/set_memory.c      | 10 ++++++++++
 include/linux/set_memory.h        |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index b45c4d2..a5e8964 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -6,6 +6,9 @@
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
+#define set_memory_rox set_memory_rox
+int set_memory_rox(unsigned long addr, int numpages);
+
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
  * address range. The attributes include:
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 97342c4..f275605 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2025,6 +2025,16 @@ int set_memory_ro(unsigned long addr, int numpages)
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
 }
 
+int set_memory_rox(unsigned long addr, int numpages)
+{
+	pgprot_t clr = __pgprot(_PAGE_RW);
+
+	if (__supported_pte_mask & _PAGE_NX)
+		clr.pgprot |= _PAGE_NX;
+
+	return change_page_attr_clear(&addr, numpages, clr, 0);
+}
+
 int set_memory_rw(unsigned long addr, int numpages)
 {
 	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_RW), 0);
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 023ebc6..95ac839 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -14,6 +14,7 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef set_memory_rox
 static inline int set_memory_rox(unsigned long addr, int numpages)
 {
 	int ret = set_memory_ro(addr, numpages);
@@ -21,6 +22,7 @@ static inline int set_memory_rox(unsigned long addr, int numpages)
 		return ret;
 	return set_memory_x(addr, numpages);
 }
+#endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
 static inline int set_direct_map_invalid_noflush(struct page *page)
