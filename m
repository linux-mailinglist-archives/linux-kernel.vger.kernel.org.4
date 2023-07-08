Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11F574BAED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGHBMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGHBMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:12:16 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2561737
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:12:15 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56368c40e8eso1837670eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688778735; x=1691370735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lKe6yHyZy9K3PFiy7uwsh090/tMqL+ZOHLxwbJUQNU=;
        b=3xtx3kLk27Pt5nQRjo2gIABwLUOicjlR50GeIy3PIPo3T7ivLSyd0Mn3gjEwJzZM0r
         0dM6f2JeTRuxED/dJNaqCELwLP/w1FTo+GLHgNP34xh7mKbJ64eikyBDPxbg/DJfJvhx
         Y+cVCTchX1Y+56HFaSRczQptsqV3qq+Kgpfme7g5v27i80wMH/Qmbw0AYfYv2t1nCjW6
         uX/hFmbnWEGjyG+JKsxI/H0ErMxzzsryWUexcdUBjZwftfcYW2BCK7xlKqyuh3609j9J
         t8ostOouYIat8RZ6iWw8hSRqtnElpqSCQeRwT1TOVrpbUFlUkDBnyRauYk/bLjMvJq4c
         jJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778735; x=1691370735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lKe6yHyZy9K3PFiy7uwsh090/tMqL+ZOHLxwbJUQNU=;
        b=DFUur/46jleARozeInZXEcoMrYTm032qNkRx1/XP1V3sGWuIy24TWppMPaHpKs24vh
         boVkcjZlr6aVr3BwT6/rXnBbDQmBrW1siGfLrQF1vWOlZG7RdvWGS/dbJ6+j3ryqc9gb
         4QbzA0LXaUhmGBIFU4ae7MbhUsD48yzU6ecGUuWafTpZcfU2E9siJlUpSJuqal4MDDqU
         JVoZ0gvOEqkhmGCUSB1ak879P5BTcQQrlC/jDcZ0HGH1e8qeikxrXsLjTUwKKBeJtcJi
         SDV+dksaJZ37eYWMpcWLzDREgEGIZpi1iYbgncdPH6fXIRNu/PtLnzK+fwGGS8Zglrt/
         oflA==
X-Gm-Message-State: ABy/qLYDvdRU7GGvmOaI/KB1q5mYJ4W6UdOi9gzirund6CYjPgSDm6mT
        SAGNH4r+MYh0O+KGYQvNvQrQiw==
X-Google-Smtp-Source: APBJJlGg5nRKgYW+XdI1rMP/hwn173NFRuMlzbFPemjPeQPEYTIF5WuXBIKOFywdw6/fbn7CMjMf9Q==
X-Received: by 2002:a05:6358:e48b:b0:135:24ed:5108 with SMTP id by11-20020a056358e48b00b0013524ed5108mr8839615rwb.10.1688778734803;
        Fri, 07 Jul 2023 18:12:14 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902b41800b001b87d3e845bsm3830654plr.149.2023.07.07.18.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:12:14 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Subject: [PATCH v4 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
Date:   Fri,  7 Jul 2023 18:11:32 -0700
Message-ID: <20230708011156.2697409-2-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708011156.2697409-1-charlie@rivosinc.com>
References: <20230708011156.2697409-1-charlie@rivosinc.com>
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
currently depend on this assumption. A hint address passed to mmap will
cause the largest address space that fits entirely into the hint to be
used. If the hint is less than or equal to 1<<38, an sv39 address will
be used. An exception is that if the hint address is 0, then a sv48
address will be used. After an address space is completely full, the next
smallest address space will be used.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/elf.h       |  2 +-
 arch/riscv/include/asm/pgtable.h   | 13 ++++++++-
 arch/riscv/include/asm/processor.h | 43 +++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c24280774caf..5d3368d5585c 100644
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
index 75970ee2bda2..a8090ebea705 100644
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
 
+#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
+
 #define VMEMMAP_SHIFT \
 	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
 #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..63715c071e1b 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -13,20 +13,49 @@
 
 #include <asm/ptrace.h>
 
-/*
- * This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
-
-#define STACK_TOP		TASK_SIZE
 #ifdef CONFIG_64BIT
+#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
 #define STACK_TOP_MAX		TASK_SIZE_64
+
+#define arch_get_mmap_end(addr, len, flags)	\
+({	\
+	unsigned long mmap_end;	\
+	if ((addr) >= VA_USER_SV57)	\
+		mmap_end = STACK_TOP_MAX;	\
+	else if ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
+		mmap_end = VA_USER_SV48;	\
+	else	\
+		mmap_end = VA_USER_SV39;	\
+	mmap_end;	\
+})
+
+#define arch_get_mmap_base(addr, base)	\
+({	\
+	unsigned long mmap_base;	\
+	if ((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57))	\
+		mmap_base = base + (VA_USER_SV57 - DEFAULT_MAP_WINDOW);	\
+	else if ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
+		mmap_base = base + (VA_USER_SV48 - DEFAULT_MAP_WINDOW);	\
+	else	\
+		mmap_base = base + (VA_USER_SV39 - DEFAULT_MAP_WINDOW);	\
+	mmap_base;	\
+})
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

