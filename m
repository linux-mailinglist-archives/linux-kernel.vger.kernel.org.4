Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFF7339A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjFPTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjFPTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565B3A8C;
        Fri, 16 Jun 2023 12:17:00 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BvvSu6H6vVkBrXu/FX3I6M4fc3mykQ1OXzeO6E4gxJo=;
        b=WCBkg/lJ9xkeT7Scmdu3H7R9YBY6lyuMU3kj0UsLnxWjq3ewq63fIMAbkBfK4lI7jdTVzd
        01hmhvuF89/VQ6754E0A2VH2RYHOPfRGNK1svF43c3E9jpRTHAmsE1aT0p5zxW8pjbJjxr
        1Y1PFug5Zye5j7kTmVMv77BMtJiixviu23c6MEYr14BxdCgwH7CuHjHDhTv2NdVuIIjXi4
        TEfCi3rNakJsnjGDBI8Z/EK7c7LQLnDGV/vMfPkEWvKQeVDTwashkRyr8ImPSCSwJ7CJ6W
        VY7itt79N8BP6jhDErRLDBd9KB1/b3CEUR2GRmbK8G3O3UIJ+g/gK/stXkmNyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BvvSu6H6vVkBrXu/FX3I6M4fc3mykQ1OXzeO6E4gxJo=;
        b=ubK9ashOOCmjzQxG4KaQENhDQOMd+hJ2RNg0vZDiVYmQ+sjdwYPOgNSfyOaCg22NxaHVuY
        CyL7A3SJqGPGiNAQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack memory
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301906.404.6002060653010887598.tip-bot2@tip-bot2>
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

Commit-ID:     620050abea57490acf2a2fc0d8b90d46c7a7edb9
Gitweb:        https://git.kernel.org/tip/620050abea57490acf2a2fc0d8b90d46c7a7edb9
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:48 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

mm: Don't allow write GUPs to shadow stack memory

The x86 Control-flow Enforcement Technology (CET) feature includes a
new type of memory called shadow stack. This shadow stack memory has
some unusual properties, which requires some core mm changes to
function properly.

In userspace, shadow stack memory is writable only in very specific,
controlled ways. However, since userspace can, even in the limited
ways, modify shadow stack contents, the kernel treats it as writable
memory. As a result, without additional work there would remain many
ways for userspace to trigger the kernel to write arbitrary data to
shadow stacks via get_user_pages(, FOLL_WRITE) based operations. To
help userspace protect their shadow stacks, make this a little less
exposed by blocking writable get_user_pages() operations for shadow
stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections. This is required for debugging use
cases.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-23-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e846f0c..717d634 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1630,6 +1630,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
 	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
 
+	/*
+	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
+	 * shouldn't generally allow access to, but since they
+	 * are already Write=0, the below logic covers both cases.
+	 */
 	if (write)
 		need_pte_bits |= _PAGE_RW;
 
diff --git a/mm/gup.c b/mm/gup.c
index bbe4162..cc0dd52 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -978,7 +978,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
