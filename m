Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8DA6A0707
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjBWLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjBWLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:06:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00A1553EED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:06:33 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJIS4SPdjFBsEAA--.2655S3;
        Thu, 23 Feb 2023 19:06:32 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK763SPdjgJg5AA--.39214S3;
        Thu, 23 Feb 2023 19:06:32 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: kdump: Add single kernel image implementation
Date:   Thu, 23 Feb 2023 19:06:30 +0800
Message-Id: <1677150391-12838-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677150391-12838-1-git-send-email-tangyouling@loongson.cn>
References: <1677150391-12838-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxK763SPdjgJg5AA--.39214S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr13Jry5tw47Ar4ruFWxWFg_yoWrJryUpr
        9xAr4kJrW8Grn5taykt34DWrWDJwn7KF1ag3W7AFyrCFW2vw1UZr1kAr9rWFyUt393t3y0
        gFyrGw1ava1UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07jOb18UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature depends on the kernel being relocatable.

Enable using single kernel image for kdump, and then no longer need to build
two kernels (production kernel and capture kernel share single kernel image).

Also enable CONFIG_CRASH_DUMP in loongson3_defconfig.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig                     | 12 +-----------
 arch/loongarch/Makefile                    |  4 ----
 arch/loongarch/configs/loongson3_defconfig |  1 +
 arch/loongarch/include/asm/addrspace.h     |  2 ++
 arch/loongarch/kernel/head.S               |  2 +-
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bafdfc8c7a4d..7342a36e8a15 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -513,6 +513,7 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
+	select RELOCATABLE
 	help
 	  Generate crash dump after being started by kexec. This should
 	  be normally only set in special crash dump kernels which are
@@ -522,17 +523,6 @@ config CRASH_DUMP
 
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
-config PHYSICAL_START
-	hex "Physical address where the kernel is loaded"
-	default "0x90000000a0000000"
-	depends on CRASH_DUMP
-	help
-	  This gives the XKPRANGE address where the kernel is loaded.
-	  If you plan to use kernel for capturing the crash dump change
-	  this value to start of the reserved region (the "X" value as
-	  specified in the "crashkernel=YM@XM" command line boot parameter
-	  passed to the panic-ed kernel).
-
 config RELOCATABLE
 	bool "Relocatable kernel"
 	help
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 768592998b39..f71edf574101 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -79,11 +79,7 @@ endif
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
-ifndef CONFIG_PHYSICAL_START
 load-y		= 0x9000000000200000
-else
-load-y		= $(CONFIG_PHYSICAL_START)
-endif
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index cb52774c80e8..7885f6e5de93 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -48,6 +48,7 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_NR_CPUS=64
 CONFIG_NUMA=y
 CONFIG_KEXEC=y
+CONFIG_CRASH_DUMP=y
 CONFIG_SUSPEND=y
 CONFIG_HIBERNATION=y
 CONFIG_ACPI=y
diff --git a/arch/loongarch/include/asm/addrspace.h b/arch/loongarch/include/asm/addrspace.h
index d342935e5a72..4edcb3c21cf5 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -125,4 +125,6 @@ extern unsigned long vm_map_base;
 #define ISA_IOSIZE	SZ_16K
 #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
+#define PHYS_LINK_ADDR	PHYSADDR(VMLINUX_LOAD_ADDRESS)
+
 #endif /* _ASM_ADDRSPACE_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 1d35becc01ee..7fb32aa26c2c 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -24,7 +24,7 @@ _head:
 	.org	0x8
 	.dword	kernel_entry		/* Kernel entry point */
 	.dword	_end - _text		/* Kernel image effective size */
-	.quad	0			/* Kernel image load offset from start of RAM */
+	.quad	PHYS_LINK_ADDR		/* Kernel image load offset from start of RAM */
 	.org	0x38			/* 0x20 ~ 0x37 reserved */
 	.long	LINUX_PE_MAGIC
 	.long	pe_header - _head	/* Offset to the PE header */
-- 
2.37.3

