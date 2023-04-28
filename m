Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6BD6F14C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjD1J6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbjD1J63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:58:29 -0400
Received: from out187-24.us.a.mail.aliyun.com (out187-24.us.a.mail.aliyun.com [47.90.187.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D52C6EAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:57:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.STFoGhB_1682675630;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGhB_1682675630)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:50 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>
Subject: [PATCH RFC 37/43] x86/xen: Pin up to VSYSCALL_ADDR when vsyscall page is out of fixmap area
Date:   Fri, 28 Apr 2023 17:51:17 +0800
Message-Id: <13975abd9b8b2e2e1e2efd3be6c341542b08af24.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vsyscall page is moved out of fixmap area, then FIXADDR_TOP would be
below vsyscall page. So it should pin up to VSYSCALL_ADDR if vsyscall is
enabled.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/xen/mmu_pv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a59bc013ee5b..28392f3478a0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -587,6 +587,12 @@ static void xen_p4d_walk(struct mm_struct *mm, p4d_t *p4d,
 	xen_pud_walk(mm, pud, func, last, limit);
 }
 
+#ifdef CONFIG_X86_VSYSCALL_EMULATION
+#define __KERNEL_MAP_TOP	(VSYSCALL_ADDR + PAGE_SIZE)
+#else
+#define __KERNEL_MAP_TOP	FIXADDR_TOP
+#endif
+
 /*
  * (Yet another) pagetable walker.  This one is intended for pinning a
  * pagetable.  This means that it walks a pagetable and calls the
@@ -594,7 +600,7 @@ static void xen_p4d_walk(struct mm_struct *mm, p4d_t *p4d,
  * at every level.  It walks the entire pagetable, but it only bothers
  * pinning pte pages which are below limit.  In the normal case this
  * will be STACK_TOP_MAX, but at boot we need to pin up to
- * FIXADDR_TOP.
+ * __KERNEL_MAP_TOP.
  *
  * We must skip the Xen hole in the middle of the address space, just after
  * the big x86-64 virtual hole.
@@ -609,7 +615,7 @@ static void __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
 
 	/* The limit is the last byte to be touched */
 	limit--;
-	BUG_ON(limit >= FIXADDR_TOP);
+	BUG_ON(limit >= __KERNEL_MAP_TOP);
 
 	/*
 	 * 64-bit has a great big hole in the middle of the address
@@ -797,7 +803,7 @@ static void __init xen_after_bootmem(void)
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 	SetPagePinned(virt_to_page(level3_user_vsyscall));
 #endif
-	xen_pgd_walk(&init_mm, xen_mark_pinned, FIXADDR_TOP);
+	xen_pgd_walk(&init_mm, xen_mark_pinned, __KERNEL_MAP_TOP);
 }
 
 static void xen_unpin_page(struct mm_struct *mm, struct page *page,
-- 
2.31.1

