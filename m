Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB86C1C99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjCTQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjCTQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2A6360A4;
        Mon, 20 Mar 2023 09:41:11 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J/8sbBkUrMYVwa6yCJB34Puf1d3o2m9JzKzS51LSE2U=;
        b=L81HIhqaL1/Pj+M5RbW861ULU5P63gwhBkRLJ2shjtFOVCCBnthlG3BoEmORPITxtwXYca
        cjtd3uga/TuFJz2rHYkCJqtqfExljUCTOjMqJ1Kfc27GicPxlhVr/UloM0ONuAplu24Jt4
        Bq6kgn6a9DJz7u09tKVm3puemhk3/wkk085BadD2BDMVIEMPli2EYsVbRy4f9jcLagRLX8
        ju+IELfDJprqLsv2TD3YQWUORl55WVzAqtP3Ua9VTpw1zDwQaN8NNlCpD1QZSTFmXdMDW/
        2VC9iwFt8EIQhbnmDSHIyOd1l0CBzL4qU24ve2if9dKBB8SbbfKYmt6DMx9tAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J/8sbBkUrMYVwa6yCJB34Puf1d3o2m9JzKzS51LSE2U=;
        b=zFVVrbsqzjle29Yet+bEVD48q+K4zRV2lm7cW4AQ1VzNre1SjxI461yTErvne3vDF/7fAb
        kNVOLKnkn3pWefAg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] s390/mm: Introduce pmd_mkwrite_kernel()
Cc:     David Hildenbrand <david@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036821.5837.14275108500633316328.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     8df0f3f28add4397ff89e808fc9d52ff9a1de26e
Gitweb:        https://git.kernel.org/tip/8df0f3f28add4397ff89e808fc9d52ff9a1de26e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

s390/mm: Introduce pmd_mkwrite_kernel()

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One of these changes is to allow for pmd_mkwrite() to create different
types of writable memory (the existing conventionally writable type and
also the new shadow stack type). Future patches will convert pmd_mkwrite()
to take a VMA in order to facilitate this, however there are places in the
kernel where pmd_mkwrite() is called outside of the context of a VMA.
These are for kernel memory. So create a new variant called
pmd_mkwrite_kernel() and switch the kernel users over to it. Have
pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
will introduce changes to make pmd_mkwrite() take a VMA.

Only do this for architectures that need it because they call pmd_mkwrite()
in arch code without an associated VMA. Since it will only currently be
used in arch code, so do not include it in arch_pgtable_helpers.rst.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/
Link: https://lore.kernel.org/all/20230319001535.23210-13-rick.p.edgecombe%40intel.com
---
 arch/s390/include/asm/pgtable.h | 7 ++++++-
 arch/s390/mm/pageattr.c         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index d4943f2..deeb918 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1491,7 +1491,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_PROTECT));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_kernel(pmd_t pmd)
 {
 	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_WRITE));
 	if (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY)
@@ -1499,6 +1499,11 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 	return pmd;
 }
 
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	return pmd_mkwrite_kernel(pmd);
+}
+
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
 	pmd = clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_DIRTY));
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 4ee5fe5..7b6967d 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -146,7 +146,7 @@ static void modify_pmd_page(pmd_t *pmdp, unsigned long addr,
 	if (flags & SET_MEMORY_RO)
 		new = pmd_wrprotect(new);
 	else if (flags & SET_MEMORY_RW)
-		new = pmd_mkwrite(pmd_mkdirty(new));
+		new = pmd_mkwrite_kernel(pmd_mkdirty(new));
 	if (flags & SET_MEMORY_NX)
 		new = set_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_NOEXEC));
 	else if (flags & SET_MEMORY_X)
