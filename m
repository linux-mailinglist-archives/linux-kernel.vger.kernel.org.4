Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23F36B8DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCNIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCNIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:54:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA1D308
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16806164D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38380C433D2;
        Tue, 14 Mar 2023 08:54:45 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
Date:   Tue, 14 Mar 2023 16:54:33 +0800
Message-Id: <20230314085433.4078119-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch maintains cache coherency in hardware, but when works with
LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is similar
to WriteCombine) is out of the scope of cache coherency machanism for
PCIe devices (this is a PCIe protocol violation, may be fixed in newer
chipsets).

This means WUC can only used for write-only memory regions now, so this
option is disabled by default (means WUC falls back to SUC for ioremap).
You can enable this option if the kernel is ensured to run on bug-free
hardwares.

Suggested-by: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig          | 14 ++++++++++++++
 arch/loongarch/include/asm/io.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0d11738a861a..e3f5c422636f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -446,6 +446,20 @@ config ARCH_IOREMAP
 	  protection support. However, you can enable LoongArch DMW-based
 	  ioremap() for better performance.
 
+config ARCH_WRITECOMBINE
+	bool "Enable WriteCombine (WUC) for ioremap()"
+	help
+	  LoongArch maintains cache coherency in hardware, but with LS7A
+	  chipsets the WUC attribute (Weak-ordered UnCached, which is similar
+	  to WriteCombine) is out of the scope of cache coherency machanism
+	  for PCIe devices (this is a PCIe protocol violation, may be fixed
+	  in newer chipsets).
+
+	  This means WUC can only used for write-only memory regions now, so
+	  this option is disabled by default (means WUC falls back to SUC for
+	  ioremap). You can enable this option if the kernel is ensured to run
+	  on bug-free hardwares.
+
 config ARCH_STRICT_ALIGN
 	bool "Enable -mstrict-align to prevent unaligned accesses" if EXPERT
 	default y
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 402a7d9e3a53..079ef897ed1a 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -54,8 +54,13 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  * @offset:    bus address of the memory
  * @size:      size of the resource to map
  */
+#ifdef CONFIG_ARCH_WRITECOMBINE
 #define ioremap_wc(offset, size)	\
 	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_WUC))
+#else
+#define ioremap_wc(offset, size)	\
+	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_SUC))
+#endif
 
 #define ioremap_cache(offset, size)	\
 	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
-- 
2.39.1

