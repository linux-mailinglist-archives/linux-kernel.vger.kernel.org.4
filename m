Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08E62640C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiKKV7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiKKV6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763FD120;
        Fri, 11 Nov 2022 13:58:30 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bxk/LqkCTIlL7XGZQRhhKiALh3By2qhlAFvAGZ6vI1s=;
        b=Kg8lrfsl8Mbu914DFkXj5x/WG5jAHov4/0fpgOd+o0PP+gti7rcJG4AN9/nv0kW9CPvhj4
        iFwIbqsIzGm7jU2Mezj9IP6x4CVxDEAOqtFxldOWzz3YRmw2DB0jDM/gTZYGnZdESWwn7/
        0yF71aLOKDqSyxc2i2Vtv8a1qgEslisfyB4aQjjVkXL1KukeVnWXl5apGjMDXFCqdArTy6
        o3S0wYSTiYdpRzVVdwBVShHBTVvkiVEDOpOXGRxsuE1tAZmzzQDNyBSw3kcd7BpPV3or9B
        vCAzRLc/Qd1K3vUjc0aomHworcc/YI5c4lXf8V7wb36LKNqC8FZ9CngjpoDR1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bxk/LqkCTIlL7XGZQRhhKiALh3By2qhlAFvAGZ6vI1s=;
        b=aK9r+duuu+jotxIjyjppWfVQbEEDbsRopagJWw2Uu0A9wdwr2xemFT7sbfoHMB7UKTXf2D
        ru7pnr75coQ9w6BA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Reduce untagged_addr() overhead until the first
 LAM user
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390744.4906.11752257947836048759.tip-bot2@tip-bot2>
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

Commit-ID:     5c1d422f576eb106744ee09e019c4087f8ef0eab
Gitweb:        https://git.kernel.org/tip/5c1d422f576eb106744ee09e019c4087f8ef0eab
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:32 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:28:08 -08:00

x86/mm: Reduce untagged_addr() overhead until the first LAM user

Use static key to reduce untagged_addr() overhead.

The key only gets enabled when the first process enables LAM.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221109165140.9137-9-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/uaccess.h | 8 ++++++--
 arch/x86/kernel/process_64.c   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 0db6f54..1d2c792 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -23,6 +23,8 @@ static inline bool pagefault_disabled(void);
 #endif
 
 #ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
+
 /*
  * Mask out tag bits from the address.
  *
@@ -31,8 +33,10 @@ static inline bool pagefault_disabled(void);
  */
 #define untagged_addr(mm, addr)	({					\
 	u64 __addr = (__force u64)(addr);				\
-	s64 sign = (s64)__addr >> 63;					\
-	__addr &= (mm)->context.untag_mask | sign;			\
+	if (static_branch_likely(&tagged_addr_key)) {			\
+		s64 sign = (s64)__addr >> 63;				\
+		__addr &= (mm)->context.untag_mask | sign;		\
+	}								\
 	(__force __typeof__(addr))__addr;				\
 })
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b8f2558..457f79b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -743,6 +743,9 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+DEFINE_STATIC_KEY_FALSE(tagged_addr_key);
+EXPORT_SYMBOL_GPL(tagged_addr_key);
+
 static void enable_lam_func(void *mm)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
@@ -798,6 +801,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	static_branch_enable(&tagged_addr_key);
 out:
 	mmap_write_unlock(mm);
 	return ret;
