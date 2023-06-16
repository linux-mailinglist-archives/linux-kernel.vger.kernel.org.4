Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F904733991
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjFPTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbjFPTRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162613ABA;
        Fri, 16 Jun 2023 12:17:03 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tYYsMHQPnLj+RcnsJ9zbquqDMxHbBWpPDi2+feo8dnI=;
        b=Y8ZFjEx5ODIBUq3st6vsxQe6Wis8RRBbJvtwa+q7fKBUz9ClzJWOH5GldBUVFySlPAgjeO
        ON06q/CrKyQF6RYlOMA4Y3xz1gXKwrci2DDNqoQg9XIZr40c7m5oW8C5Ki/tN/tL117sVr
        7VZopR0bdUQ+PVsiCvVbW6jnVvF7IYml31f4CS3+yit8x2UdKl5QG5M0sPUL+RKNPJPoyD
        Q4KjPfxBYrjZbiJZtb/avUYdPTopfwaO+kzKFiy5d7cTwnUh96586KEs6rOLC4EhMEmMEt
        XV6vlp5NOKYB36QFf5aZ0wOQslGrg6Ui98aYwC1XJLL78VDZwUyPzzmdNg+ckA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tYYsMHQPnLj+RcnsJ9zbquqDMxHbBWpPDi2+feo8dnI=;
        b=wHkA75oBgpTbdsdMJsOuBBoiZTeH4PaCqKo2lqdOtMo4a3vDQy5aNRwKuLff7x7lJqoUOp
        TN97SQtzFiaIj7BA==
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Introduce VM_SHADOW_STACK for shadow stack memory
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302216.404.12911348456654033456.tip-bot2@tip-bot2>
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

Commit-ID:     73fd9387a772fa69b3a92646e8dc82d46762a7e8
Gitweb:        https://git.kernel.org/tip/73fd9387a772fa69b3a92646e8dc82d46762a7e8
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

mm: Introduce VM_SHADOW_STACK for shadow stack memory

New hardware extensions implement support for shadow stack memory, such
as x86 Control-flow Enforcement Technology (CET). Add a new VM flag to
identify these areas, for example, to be used to properly indicate shadow
stack PTEs to the hardware.

Shadow stack VMA creation will be tightly controlled and limited to
anonymous memory to make the implementation simpler and since that is all
that is required. The solution will rely on pte_mkwrite() to create the
shadow stack PTEs, so it will not be required for vm_get_page_prot() to
learn how to create shadow stack memory. For this reason document that
VM_SHADOW_STACK should not be mixed with VM_SHARED.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-15-rick.p.edgecombe%40intel.com
---
 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7897a7d..6ccb570 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -566,6 +566,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
+    ss    shadow stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 420510f..38b19a7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f52c1e..fb17cbd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -319,11 +319,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -339,6 +341,12 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5 /* Should not be set with VM_SHARED */
+#else
+# define VM_SHADOW_STACK	VM_NONE
+#endif
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
