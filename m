Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D325873CFE4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjFYJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFYJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:56:58 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C9189;
        Sun, 25 Jun 2023 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687687016; bh=UGMkiVgsD7TmU72TjAy44icKsVdzIhU52JRB8B10DPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtdTPfBenqcOclDJxFgwaklagBTEt6IfXBrI3jZtiM8hvv2cXxN8l+W71y2/tzae8
         A/Vzc2Fs/8C/4iXefzfUsLc2TBFNey8K3jZt0EH09+Q2vjA6SyHBv1eLticTEjHg6e
         Nn7tt+FN7On/I/nXjA7T4/1s0jlGxa/BRuQxdg+I=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BC5CD6015B;
        Sun, 25 Jun 2023 17:56:55 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH v3 1/8] LoongArch: Calculate various sizes in the linker script
Date:   Sun, 25 Jun 2023 17:56:37 +0800
Message-Id: <20230625095644.3156349-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230625095644.3156349-1-kernel@xen0n.name>
References: <20230625095644.3156349-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Rui <wangrui@loongson.cn>

Taking the address delta between symbols in different sections is not
supported by the LLVM IAS. Instead, do this in the linker script, so
the same data can be properly referenced in assembly.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/kernel/efi-header.S  | 6 +++---
 arch/loongarch/kernel/head.S        | 8 ++++----
 arch/loongarch/kernel/vmlinux.lds.S | 7 +++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/efi-header.S b/arch/loongarch/kernel/efi-header.S
index 8c1d229a2afa..5f23b85d78ca 100644
--- a/arch/loongarch/kernel/efi-header.S
+++ b/arch/loongarch/kernel/efi-header.S
@@ -24,7 +24,7 @@
 	.byte	0x02					/* MajorLinkerVersion */
 	.byte	0x14					/* MinorLinkerVersion */
 	.long	__inittext_end - .Lefi_header_end	/* SizeOfCode */
-	.long	_end - __initdata_begin			/* SizeOfInitializedData */
+	.long	_kernel_vsize				/* SizeOfInitializedData */
 	.long	0					/* SizeOfUninitializedData */
 	.long	__efistub_efi_pe_entry - _head		/* AddressOfEntryPoint */
 	.long	.Lefi_header_end - _head		/* BaseOfCode */
@@ -79,9 +79,9 @@
 		IMAGE_SCN_MEM_EXECUTE			/* Characteristics */
 
 	.ascii	".data\0\0\0"
-	.long	_end - __initdata_begin			/* VirtualSize */
+	.long	_kernel_vsize				/* VirtualSize */
 	.long	__initdata_begin - _head		/* VirtualAddress */
-	.long	_edata - __initdata_begin		/* SizeOfRawData */
+	.long	_kernel_rsize				/* SizeOfRawData */
 	.long	__initdata_begin - _head		/* PointerToRawData */
 
 	.long	0					/* PointerToRelocations */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 0d8180153ec0..53b883db0786 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -23,7 +23,7 @@ _head:
 	.word	MZ_MAGIC		/* "MZ", MS-DOS header */
 	.org	0x8
 	.dword	kernel_entry		/* Kernel entry point */
-	.dword	_end - _text		/* Kernel image effective size */
+	.dword	_kernel_asize		/* Kernel image effective size */
 	.quad	PHYS_LINK_KADDR		/* Kernel image load offset from start of RAM */
 	.org	0x38			/* 0x20 ~ 0x37 reserved */
 	.long	LINUX_PE_MAGIC
@@ -32,9 +32,9 @@ _head:
 pe_header:
 	__EFI_PE_HEADER
 
-SYM_DATA(kernel_asize, .long _end - _text);
-SYM_DATA(kernel_fsize, .long _edata - _text);
-SYM_DATA(kernel_offset, .long kernel_offset - _text);
+SYM_DATA(kernel_asize, .long _kernel_asize);
+SYM_DATA(kernel_fsize, .long _kernel_fsize);
+SYM_DATA(kernel_offset, .long _kernel_offset);
 
 #endif
 
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 0c7b041be9d8..79f238df029e 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -136,6 +136,13 @@ SECTIONS
 	DWARF_DEBUG
 	ELF_DETAILS
 
+	/* header symbols */
+	_kernel_asize = _end - _text;
+	_kernel_fsize = _edata - _text;
+	_kernel_offset = kernel_offset - _text;
+	_kernel_vsize = _end - __initdata_begin;
+	_kernel_rsize = _edata - __initdata_begin;
+
 	.gptab.sdata : {
 		*(.gptab.data)
 		*(.gptab.sdata)
-- 
2.40.0

