Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12073398B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346086AbjFPTSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbjFPTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486E3AA0;
        Fri, 16 Jun 2023 12:17:01 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aAl/1nKouUGkA9YwDiMxcvdjyiCHmtGy7kE2Y0zKh/g=;
        b=fAhpWuJnrsZphcNsTcZW4zQHpvLx1Vc0datiFQEhgQWKCn1dS8YIx2UdByFv0CgkRm1XCQ
        INxBf37enC6V17CgUJjXofvw1zn4ZrCyYM2Zhyava/hYuJsDlA12ZfPTTtCTLaLJ23MmN0
        TjJweHNVrvikn2llll7ptTxzPcrSBM0jfMMFFhBpJ84MwizIXQoqe5qbZgv67ZnlSuoheO
        r2kfZFudQMuwBfkpq5UrKXv/FzMKVvGnCj/8TrrQqtln4kLKFlR/xoY/gcmNm/OtENExXj
        JgiJcsj3vDOs9kToYVFMYIYpk/jsiQguYOr6oWWtv5+kQiKh5fDMXDzavUbwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aAl/1nKouUGkA9YwDiMxcvdjyiCHmtGy7kE2Y0zKh/g=;
        b=RUxEww1kuuwR7WE2kaUzEetBionuU7AceChwpXUU54HCVDWC6kkYEN0rcosjkbGIMfypul
        08gIHvJ9sYJKUNBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Introduce MAP_ABOVE4G
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301982.404.16613830920105754282.tip-bot2@tip-bot2>
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

Commit-ID:     4aab2283e268be7df1d0e446d63f01e87713e6d5
Gitweb:        https://git.kernel.org/tip/4aab2283e268be7df1d0e446d63f01e87713e6d5
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

x86/mm: Introduce MAP_ABOVE4G

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which require some core mm changes to function
properly.

One of the properties is that the shadow stack pointer (SSP), which is a
CPU register that points to the shadow stack like the stack pointer points
to the stack, can't be pointing outside of the 32 bit address space when
the CPU is executing in 32 bit mode. It is desirable to prevent executing
in 32 bit mode when shadow stack is enabled because the kernel can't easily
support 32 bit signals.

On x86 it is possible to transition to 32 bit mode without any special
interaction with the kernel, by doing a "far call" to a 32 bit segment.
So the shadow stack implementation can use this address space behavior
as a feature, by enforcing that shadow stack memory is always mapped
outside of the 32 bit address space. This way userspace will trigger a
general protection fault which will in turn trigger a segfault if it
tries to transition to 32 bit mode with shadow stack enabled.

This provides a clean error generating border for the user if they try
attempt to do 32 bit mode shadow stack, rather than leave the kernel in a
half working state for userspace to be surprised by.

So to allow future shadow stack enabling patches to map shadow stacks
out of the 32 bit address space, introduce MAP_ABOVE4G. The behavior
is pretty much like MAP_32BIT, except that it has the opposite address
range. The are a few differences though.

If both MAP_32BIT and MAP_ABOVE4G are provided, the kernel will use the
MAP_ABOVE4G behavior. Like MAP_32BIT, MAP_ABOVE4G is ignored in a 32 bit
syscall.

Since the default search behavior is top down, the normal kaslr base can
be used for MAP_ABOVE4G. This is unlike MAP_32BIT which has to add its
own randomization in the bottom up case.

For MAP_32BIT, only the bottom up search path is used. For MAP_ABOVE4G
both are potentially valid, so both are used. In the bottomup search
path, the default behavior is already consistent with MAP_ABOVE4G since
mmap base should be above 4GB.

Without MAP_ABOVE4G, the shadow stack will already normally be above 4GB.
So without introducing MAP_ABOVE4G, trying to transition to 32 bit mode
with shadow stack enabled would usually segfault anyway. This is already
pretty decent guard rails. But the addition of MAP_ABOVE4G is some small
complexity spent to make it make it more complete.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-21-rick.p.edgecombe%40intel.com
---
 arch/x86/include/uapi/asm/mman.h | 1 +
 arch/x86/kernel/sys_x86_64.c     | 6 +++++-
 include/linux/mman.h             | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 775dbd3..5a0256e 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_MMAN_H
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
+#define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 #define arch_calc_vm_prot_bits(prot, key) (		\
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 8cc653f..c783aeb 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -193,7 +193,11 @@ get_unmapped_area:
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = PAGE_SIZE;
+	if (!in_32bit_syscall() && (flags & MAP_ABOVE4G))
+		info.low_limit = SZ_4G;
+	else
+		info.low_limit = PAGE_SIZE;
+
 	info.high_limit = get_mmap_base(0);
 
 	/*
diff --git a/include/linux/mman.h b/include/linux/mman.h
index cee1e4b..40d9441 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -15,6 +15,9 @@
 #ifndef MAP_32BIT
 #define MAP_32BIT 0
 #endif
+#ifndef MAP_ABOVE4G
+#define MAP_ABOVE4G 0
+#endif
 #ifndef MAP_HUGE_2MB
 #define MAP_HUGE_2MB 0
 #endif
@@ -50,6 +53,7 @@
 		| MAP_STACK \
 		| MAP_HUGETLB \
 		| MAP_32BIT \
+		| MAP_ABOVE4G \
 		| MAP_HUGE_2MB \
 		| MAP_HUGE_1GB)
 
