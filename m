Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D270605930
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJTH7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiJTH7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:59:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6883180257
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so18521894pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDJV4ZwRVQLzE0DQMb9i2tBKWni84XeHMbgigRoQK/0=;
        b=RtIs+Fo57m4OyjqREQ+GmkLa1gtB+nd1wI1cynGPWeyR4VuzuTZWYwxJp3qb38jND+
         jXzllqItnzM8dXynZdtd4gBtlQcrTFv3q3wLdb9aYmU1re7J1CS7QNaEBpwC5Es4tMoP
         8fhXm+QGwvfvAnRFygQrEktJR97lrpRTNwcBmjOVjVyH0enR9liXz+TuLkEd3jbxNgtS
         0Q5pPUbWB2jqGj3mst8Fq1vF9FPWmupAtBR8zOnr4ZeSflblwpcDKp/m4D9umY0Ly4J6
         EgHMvrkLGNAoI6X8hUK3eiUWTy+WmHETYpx3tSzPJFfbAnLWn8XU2jYA24Eu1d6/08Ar
         W+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDJV4ZwRVQLzE0DQMb9i2tBKWni84XeHMbgigRoQK/0=;
        b=TgBb+aYLda1w0W6DSjRmXPwRaS3GkOmQNf5qF1X1MWZDoKq6q0hp7AIlB7GojRt/xw
         eIzIAcxdorCTQUK5sO4VTjuwg8RF5H1uRIol+Eg5J2kBTkhVLli6lBLJIv/fsiryjJrd
         lHE6FhWphm/oGsXGZiBuumvn0MAeO1jsziBsyPlfQZGU0fe3OsR+DYNGbicJlI4Mp4vL
         Hp+V1dTSTgqV+ZkyjVUQh0uTkQ5XHK2e7OziSSi7PH8Rsz5msf9dwEa23oueSYKBAKi5
         fq6zxw678VJVm4o41mjrZmtJY4UTWN27Fq8P+Tcw/BcxtTtiN8IA8YZ2MWV2+gIYjWQ8
         zs9Q==
X-Gm-Message-State: ACrzQf3AJ07GFObNT1ndNcoEgwufJkm6b8DgqAsMUoyUVP4TLn/HpSMI
        gI9TidAr5KB515a77jfL2/Umig==
X-Google-Smtp-Source: AMsMyM4+Y3j2NNCSyJHfzbf9XmZTArI3CBMgBB4JZwGFMWkS1y+U/PGzCotqjnP6BECxn5NkaxBZpA==
X-Received: by 2002:a63:2b4b:0:b0:440:2963:5863 with SMTP id r72-20020a632b4b000000b0044029635863mr10501248pgr.28.1666252748070;
        Thu, 20 Oct 2022 00:59:08 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.80.23])
        by smtp.gmail.com with ESMTPSA id h30-20020aa79f5e000000b0052dfe83e19csm13206438pfr.16.2022.10.20.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 00:59:07 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v5 3/4] RISC-V: Implement arch specific PMEM APIs
Date:   Thu, 20 Oct 2022 13:28:45 +0530
Message-Id: <20221020075846.305576-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020075846.305576-1-apatel@ventanamicro.com>
References: <20221020075846.305576-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
and if arch does not provide these APIs then NVDIMM PMEM driver will
always use MEMREMAP_WT to map persistent memory which in-turn maps as
UC memory type defined by the RISC-V Svpbmt specification.

Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
PMEM driver can use MEMREMAP_WB to map persistent memory.

Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig     |  1 +
 arch/riscv/mm/Makefile |  1 +
 arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/mm/pmem.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b48a3ae9843..025e2a1b1c60 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_PMEM_API
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index d76aabf4b94d..3b368e547f83 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -31,3 +31,4 @@ endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
 obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
+obj-$(CONFIG_ARCH_HAS_PMEM_API) += pmem.o
diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
new file mode 100644
index 000000000000..089df92ae876
--- /dev/null
+++ b/arch/riscv/mm/pmem.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/export.h>
+#include <linux/libnvdimm.h>
+
+#include <asm/cacheflush.h>
+
+void arch_wb_cache_pmem(void *addr, size_t size)
+{
+	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
+}
+EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
+
+void arch_invalidate_pmem(void *addr, size_t size)
+{
+	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
+}
+EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
-- 
2.34.1

