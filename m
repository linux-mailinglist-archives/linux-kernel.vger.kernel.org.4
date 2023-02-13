Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7279D693D94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBMEyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBMEyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84BE06C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so10977705pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtGFk1nMQnbVrTZQtdZEMWvYWxpeM1anGce2t/6Js4o=;
        b=XnLJLE7Snc5+Dado4616bI2S9bt5BoOzPfFJwGy4sODs4id84UZRmeTgvHINl309vQ
         14Su83K/zKRWWRUylX+LvkRt46rw/1NmQPiL7ZTYRBArkznoYvQmmpzl5Z1rM4XkHXqf
         rBcFShV4hBPXc5uzWruqviGPXly8kLMjn2buoQyVJ78MB0g/unbDmmax/ZZW+MA5RiWQ
         ogB0M9oUzUW0WJhaa+KIDOkbwCoO/Z1xc2lVmLfl1RBXdxIvi47/x8V3ynUmXwT9kABH
         Wq7UQVpnuXOK+7FT7G8jAwG2P+Mvs0HLCPCDYEFwFUpPExstyaOaxnJUASc2Rtwb889R
         YtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtGFk1nMQnbVrTZQtdZEMWvYWxpeM1anGce2t/6Js4o=;
        b=q0nywThvYoWuXcw2OUe6OOto0VsmBicTRFyzkpfuc0BnPDD3DuD5S0AC4YTKHmSR5J
         l6qLHpQzCL1etsnrLbWigfdhXt/F214rt4Wpnz5gke+y5jWhbNVQmyzMqqMhg6+uRFf4
         FXZvRvMTWIbnwr2HdRSXEcSPoumS6Rszpr+Hzs/Yy9CwHcSEzNqQgW9c9NHKNBwPEnEw
         Fi3VHXXMD4NvuEmABV7HRLVDHoLF7RWzMNoSLTRo14++FunVth6b+XE+1O4GvyUri4TJ
         w+/JqUNri75U/CST5hTFL6LoM/HbppXMXj5PHM+JYxFjEGopti8qsJ3q0ZegFEsy2GLK
         b8eg==
X-Gm-Message-State: AO0yUKWNmHQ9WPOP7aSJTGNA/57d4TZK2BPNkp9B+3K28vgfimzpDSWB
        Gj/+X4W/8wbGQeyawx37N4h8+HnWhEBisXTB
X-Google-Smtp-Source: AK7set8VQlMzUrEmfd8Da16vinMvIuF6MGR4zXdfBxivo1pKWlmTbhvBvyR/CFhAZRsTG7lVovToSw==
X-Received: by 2002:a17:902:e545:b0:199:60:b9c8 with SMTP id n5-20020a170902e54500b001990060b9c8mr29757414plf.45.1676264050773;
        Sun, 12 Feb 2023 20:54:10 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:10 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 06/20] riscv: Implementing "PROT_SHADOWSTACK" on riscv
Date:   Sun, 12 Feb 2023 20:53:35 -0800
Message-Id: <20230213045351.3945824-7-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchimplements new mmap protection flag "PROT_SHADOWSTACK" on riscv

Zisslpcfi extension on riscv uses R=0, W=1, X=0 as shadow stack PTE
encoding. This encoding is reserved if Zisslpcfi is not implemented or
backward cfi is not enabled for the respective mode.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/mman.h    | 19 +++++++++++++++++++
 arch/riscv/include/asm/pgtable.h |  1 +
 arch/riscv/kernel/sys_riscv.c    | 22 ++++++++++++++++++++++
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/mman.h

diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
new file mode 100644
index 000000000000..9c8499294a60
--- /dev/null
+++ b/arch/riscv/include/asm/mman.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <uapi/asm/mman.h>
+
+static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+	unsigned long pkey __always_unused)
+{
+	unsigned long ret = 0;
+
+	ret = (prot & PROT_SHADOWSTACK)?VM_WRITE:0;
+	return ret;
+}
+#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+
+#endif /* ! __ASM_MMAN_H__ */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4eba9a98d0e3..74dbe122f2fa 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -159,6 +159,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
 #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
 					 _PAGE_EXEC | _PAGE_WRITE)
+#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
 #define PAGE_COPY_EXEC		PAGE_EXEC
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 5d3f2fbeb33c..c3cf6b94c710 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,6 +18,28 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
+	/*
+	 * If only PROT_WRITE is specified then extend that to PROT_READ
+	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
+	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
+	 * If user wants to create shadow stack then they should specify PROT_SHADOWSTACK
+	 * protection
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		prot |= PROT_READ;
+
+	/*
+	 * PROT_SHADOWSTACK is new protection flag. If specified with other like PROT_WRITE or
+	 * PROT_READ PROT_SHADOWSTACK takes precedence. We can do either of following
+	 *   - ensure no other protection flags are specified along with it and return EINVAL
+	 *   OR
+	 *   - ensure we clear other protection flags.
+	 * Choosing to follow former, if any other bit is set in prot, we return EINVAL
+	 * Other architectures can treat different combinations for PROT_SHADOWSTACK
+	 */
+	if (unlikely((prot & PROT_SHADOWSTACK) && (prot & ~PROT_SHADOWSTACK)))
+		return -EINVAL;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 478d6763a01a..ba8138c90450 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -294,7 +294,7 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READ,
-	[VM_WRITE]					= PAGE_COPY,
+	[VM_WRITE]					= PAGE_SHADOWSTACK,
 	[VM_WRITE | VM_READ]				= PAGE_COPY,
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
-- 
2.25.1

