Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1E733996
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjFPTS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345949AbjFPTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149863AA4;
        Fri, 16 Jun 2023 12:17:02 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lEavE7KzI6HFgILgkppc2+zKlgu3cU9oGtjf05hXZiI=;
        b=T/wl2KxqdGaA9sp6tQSlUzgVPtt58NZMGYSW2KlPg0RgldgtqfWqResDNeFMfaxJXiypyR
        +9LDA9n0nvZNDXcidXo4Xnw9KstyIEhykg80AQVmjzwDDK8qKpuIoAzXV43u589WHLe4aH
        6nC9x4evSBVywLIUfKSYaOgkwfvbwv2SicwdgGNCPEDU1PQKIP7rqMj6xdd0+dSNxwk9ad
        zyknQ4V4pzV5Q/B0BP6ld3GO7Lnw2jz5nQd5fJZ8JRamBPKU4Lavg0zgfUVvPhQgsu9E01
        snwUlOiIDSuXCma6BQtv7KefEYN0lMtGy1Efo7C+p9nMWK6wIWJvNnl6GCWvQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lEavE7KzI6HFgILgkppc2+zKlgu3cU9oGtjf05hXZiI=;
        b=NvKB0d/aVj7dCLxSUY8eliIwz8diaGzzEexKcdvXQ/rBKFR5RPj1khLHv39NfKW2sOnfoJ
        Y7Y6HmUX7O7XwvBg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm/mmap: Add shadow stack pages to memory accounting
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302024.404.10992834029172607426.tip-bot2@tip-bot2>
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

Commit-ID:     6538963ccabd17c61265a8fb497c76727f6bc638
Gitweb:        https://git.kernel.org/tip/6538963ccabd17c61265a8fb497c76727f6bc638
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

mm/mmap: Add shadow stack pages to memory accounting

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-20-rick.p.edgecombe%40intel.com
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 68410c6..dd2ded3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -535,14 +535,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 }
 
 /*
- * Stack area - automatically grows in one direction
+ * Stack area (including shadow stacks)
  *
  * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
  * do_mmap() forbids all other combinations.
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return (flags & VM_STACK) == VM_STACK;
+	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
 }
 
 /*
