Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09CA748CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjGETB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjGETBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:01:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8741BDD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:00:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b7e6512973so40604215ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688583646; x=1691175646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwDbFN4IMu/IT2sUnJpiyfq5VoW3RyrrIlVKWP8Zp3M=;
        b=B5MuAnjyPA5HWnw/0ZMD7sikNOclxpF4lGSvciWQB87w4rFYSUNfLNK+HsQp492Rf+
         ZxPO1vU+712n7WlePRMhOn6SczHHo9fE6HIJLL8ZyJ/POLpUb9mOET4MxYE1D1KL66+R
         yc7XK/MLgV48J/rmUICg/JfoMi8RwOcb8Rdc0L6L7JA3HWXsHZEe5vqnDO4wpHtksNG0
         6hykpWJqcBzzZvBlwkUnF6EpCUytPeXyckLHmbzX+YnvS2NJrlzxgyDFU30U93nh8Azf
         WSn1iuqn7dcZTohfbd3Vdke/R26c1Z9YtPFh/+P4RJkaVsr6lp0+b0KcwUXVO3bdjKSZ
         UYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688583646; x=1691175646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwDbFN4IMu/IT2sUnJpiyfq5VoW3RyrrIlVKWP8Zp3M=;
        b=f99hSI8pZEA+UMvYu0PmnYAgzyj0yl2JeY/aPp5VZ5meUdkQioBNNno+7Vn6LErVdL
         k/34sZq3R81/edu7icU2vPqiYkEdDwXvoD4y6BNWyGO9+894pk9GihtUrexwJDPzu0gR
         NUotrGllnqPn+anQtM5Ku15bsH+M5/xf4mG4/nluM+VN2QyMQt9tEWnjZYBXi7w+QxUa
         vmeoz2ljjpdQgIZi2kmwODRXu9Tf8lO7aylxb6dHdT4lBMBo9+KvRcAGwFikJe3Blr4r
         UgmgKHZT23MoW5HIIekSPNP3dypCZTDd4vnTfdtatxYyOq2eQ1Av9sU4x9rX2ifncvW5
         3Z4Q==
X-Gm-Message-State: ABy/qLaeiqmK/R+XPOpu58SaeSD7YEhTZH4FbEsl9rk0CCGd1oN6Kgun
        4LuEbPevxj1pHwwRHnYIPCj6Ng==
X-Google-Smtp-Source: APBJJlH1wVrF+VXjCSlnhXGll6mNEEZtDOZVaG2jB+/RzM+hSnYSGeB7ar+eRFwz/kyrKSD8lH/V1g==
X-Received: by 2002:a17:903:495:b0:1b8:a372:9c25 with SMTP id jj21-20020a170903049500b001b8a3729c25mr3944409plb.9.1688583646025;
        Wed, 05 Jul 2023 12:00:46 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902aa8700b001b0358848b0sm19323359plr.161.2023.07.05.12.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:00:45 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
Subject: [RESEND PATCH v3 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Wed,  5 Jul 2023 11:59:41 -0700
Message-ID: <20230705190002.384799-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190002.384799-1-charlie@rivosinc.com>
References: <20230705190002.384799-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sv48 the default address space for mmap as some applications
currently depend on this assumption. The RISC-V specification enforces
that bits outside of the virtual address range are not used, so
restricting the size of the default address space as such should be
temporary. A hint address passed to mmap will cause the largest address
space that fits entirely into the hint to be used. If the hint is less
than or equal to 1<<38, an sv39 address will be used. An exception is
that if the hint address is 0, then a sv48 address will be used. After
an address space is completely full, the next smallest address space
will be used.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/elf.h       |  2 +-
 arch/riscv/include/asm/pgtable.h   | 13 +++++++++++-
 arch/riscv/include/asm/processor.h | 34 ++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 30e7d2455960..1b57f13a1afd 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
  * the loader.  We need to make sure that it is out of the way of the program
  * that it will "exec", and that there is sufficient room for the brk.
  */
-#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
+#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
 
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_COMPAT
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..752e210c7547 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -57,18 +57,29 @@
 #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
 #endif
 
+
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
+#define VA_BITS_SV39 39
+#define VA_BITS_SV48 48
+#define VA_BITS_SV57 57
+
+#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
+#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
+#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
+
 #define VA_BITS		(pgtable_l5_enabled ? \
-				57 : (pgtable_l4_enabled ? 48 : 39))
+				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
 #else
 #define VA_BITS		32
 #endif
 
+#define DEFAULT_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+
 #define VMEMMAP_SHIFT \
 	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..468a1f4b9da4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,20 +12,40 @@
 
 #include <asm/ptrace.h>
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
-
-#define STACK_TOP		TASK_SIZE
 #ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (DEFAULT_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags) \
+	((addr) >= VA_USER_SV57 ? STACK_TOP_MAX :   \
+	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
+						 VA_USER_SV48 : \
+						 VA_USER_SV39)
+
+#define arch_get_mmap_base(addr, base) \
+	(((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) ?   \
+		 VA_USER_SV57 - (DEFAULT_MAP_WINDOW - base) : \
+	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
+		 VA_USER_SV48 - (DEFAULT_MAP_WINDOW - base) : \
+	  (addr == 0) ? \
+		 base : \
+		 VA_USER_SV39 - (DEFAULT_MAP_WINDOW - base))
+
 #else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
 #define STACK_TOP_MAX		TASK_SIZE
 #endif
 #define STACK_ALIGN		16
 
+
+#define STACK_TOP		DEFAULT_MAP_WINDOW
+
+/*
+ * This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
+
 #ifndef __ASSEMBLY__
 
 struct task_struct;
-- 
2.41.0

