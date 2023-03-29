Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2F6CD14B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC2Eym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjC2Eyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:54:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3D3AA6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:54:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u1so8093492wmn.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680065674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktbMUCpwKr4p6sxSafOqlZuluRkmcCN6C+8Lyu2qvAc=;
        b=4X7ifeA/SGmd5f+PrymDHio4j1xNhUrnthuq1Wov3mtXUT8875BfSubfmgak5IIJwz
         QL6Do9Vy3s0gGYmeUieXjJfEhsHN2s1Rc4dIqt+B+I8gIHCQ6ZOuaaUGWRhWhS+Twosv
         TosP9XCyPv4IF3ILX78Zz5NGkhVf5jvOLbYOhA53tWPxCd2PToqZvtb3YeyfsJZPJb+u
         FF/k19pYOl2V/lK2KrrIGEijTrAHtnRRNO7ZYzxDjZBfRDitSg0rmEm85z43dKcpfzRp
         /hf6rokfCu6eYDu4gOA18iGUaXVxzH2Qy3cMGjoPzk9mpqOme9dgqqJ69ENBbmrnf1wf
         MVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680065674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktbMUCpwKr4p6sxSafOqlZuluRkmcCN6C+8Lyu2qvAc=;
        b=IRL01p75w/jKAKlAj92VZDCMnJSCv3DT7h3GplRXS3Xkx4aJ7TItG/Z86oEyyhzyBS
         vOo/8151RR0HuiJxRHjlVP9nxfP5ji9ZWnZZ4oG4RO1+hoOU3x0vMB9oRxG9v3lU/U1K
         KBtnal5SzJnfWYIvep8APbI91YJzFwJV4s1mvxE2Dz6FdiwH9sqfNqqBlNxCNMjlpvDg
         lxRjEMUjqUxEFFLsp9MVeuyQXtsu+xLKCCTZUwKuXeNdJG9+C5o8X6KBWUJlmXVMQ+jo
         Zhx+YqaaLTazdvHKqe9HwcEG7jVHWiiOf+QpK/66YJ//VmcAolVP9zDHKV9AXpY5i/Ej
         k6yw==
X-Gm-Message-State: AO0yUKUzHlC0R3c8cF1j3vW9fzqYYONCVvBd/NmLI71o4p88V012HbLX
        dMNzChUWhusnuc7unvEn8w/PaQ==
X-Google-Smtp-Source: AK7set8KyrHOxCHh16uvCtOCDVkCarPqxygWiKW2Mqp0rpgc5a8LupWu2x+qke+olNk5QXh69XyzWQ==
X-Received: by 2002:a7b:c3c7:0:b0:3ed:ff92:dd2a with SMTP id t7-20020a7bc3c7000000b003edff92dd2amr14084380wmj.12.1680065673979;
        Tue, 28 Mar 2023 21:54:33 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q18-20020a7bce92000000b003ef71d541cbsm831127wmj.1.2023.03.28.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 21:54:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v9 1/6] riscv: Prepare EFI header for relocatable kernels
Date:   Wed, 29 Mar 2023 06:53:24 +0200
Message-Id: <20230329045329.64565-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329045329.64565-1-alexghiti@rivosinc.com>
References: <20230329045329.64565-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ld does not handle relocations correctly as explained here [1],
a fix for that was proposed by Nelson there but we have to support older
toolchains and then provide this fix.

Note that llvm does not need this fix and is then excluded.

[1] https://sourceware.org/pipermail/binutils/2023-March/126690.html

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/set_memory.h |  3 +++
 arch/riscv/kernel/efi-header.S      | 19 ++++++++++++++++---
 arch/riscv/kernel/vmlinux.lds.S     |  5 ++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index a2c14d4b3993..ec11001c3fe0 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -56,4 +56,7 @@ bool kernel_page_present(struct page *page);
 #define SECTION_ALIGN L1_CACHE_BYTES
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
+#define PECOFF_SECTION_ALIGNMENT        0x1000
+#define PECOFF_FILE_ALIGNMENT           0x200
+
 #endif /* _ASM_RISCV_SET_MEMORY_H */
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 8e733aa48ba6..515b2dfbca75 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -6,6 +6,7 @@
 
 #include <linux/pe.h>
 #include <linux/sizes.h>
+#include <asm/set_memory.h>
 
 	.macro	__EFI_PE_HEADER
 	.long	PE_MAGIC
@@ -33,7 +34,11 @@ optional_header:
 	.byte	0x02					// MajorLinkerVersion
 	.byte	0x14					// MinorLinkerVersion
 	.long	__pecoff_text_end - efi_header_end	// SizeOfCode
-	.long	__pecoff_data_virt_size			// SizeOfInitializedData
+#ifdef __clang__
+	.long   __pecoff_data_virt_size			// SizeOfInitializedData
+#else
+	.long	__pecoff_data_virt_end - __pecoff_text_end	// SizeOfInitializedData
+#endif
 	.long	0					// SizeOfUninitializedData
 	.long	__efistub_efi_pe_entry - _start		// AddressOfEntryPoint
 	.long	efi_header_end - _start			// BaseOfCode
@@ -91,9 +96,17 @@ section_table:
 		IMAGE_SCN_MEM_EXECUTE			// Characteristics
 
 	.ascii	".data\0\0\0"
-	.long	__pecoff_data_virt_size			// VirtualSize
+#ifdef __clang__
+	.long   __pecoff_data_virt_size			// VirtualSize
+#else
+	.long	__pecoff_data_virt_end - __pecoff_text_end	// VirtualSize
+#endif
 	.long	__pecoff_text_end - _start		// VirtualAddress
-	.long	__pecoff_data_raw_size			// SizeOfRawData
+#ifdef __clang__
+	.long   __pecoff_data_raw_size			// SizeOfRawData
+#else
+	.long	__pecoff_data_raw_end - __pecoff_text_end	// SizeOfRawData
+#endif
 	.long	__pecoff_text_end - _start		// PointerToRawData
 
 	.long	0					// PointerToRelocations
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 53a8ad65b255..1c38294580c0 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -27,9 +27,6 @@ ENTRY(_start)
 
 jiffies = jiffies_64;
 
-PECOFF_SECTION_ALIGNMENT = 0x1000;
-PECOFF_FILE_ALIGNMENT = 0x200;
-
 SECTIONS
 {
 	/* Beginning of code and text segment */
@@ -132,6 +129,7 @@ SECTIONS
 #ifdef CONFIG_EFI
 	.pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
 	__pecoff_data_raw_size = ABSOLUTE(. - __pecoff_text_end);
+	__pecoff_data_raw_end = ABSOLUTE(.);
 #endif
 
 	/* End of data section */
@@ -142,6 +140,7 @@ SECTIONS
 #ifdef CONFIG_EFI
 	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
 	__pecoff_data_virt_size = ABSOLUTE(. - __pecoff_text_end);
+	__pecoff_data_virt_end = ABSOLUTE(.);
 #endif
 	_end = .;
 
-- 
2.37.2

