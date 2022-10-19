Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF9060470F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJSN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiJSN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:27:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3D102532
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e129so16200670pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDJV4ZwRVQLzE0DQMb9i2tBKWni84XeHMbgigRoQK/0=;
        b=HOkyp3/fLEtCt1yCpma/EVhFQK4FgiHrDx/1YMPDwT9KQrXtZ0+DK7VA6GhN48oRWA
         4sG0ELlR4Xx5kFHMLD3IcKQgSiGxSCIYHNPRD6e781OBC4699iRbnlkAlAhprF0gqYki
         acC7BoHMX02nQX6Pt26dFyxXVI1LBAdKELJ09Ghl43yGZrR73a3ii+p3UpqdhnFHmDS3
         0XiS8j+aXMQi6uBmUu0KnVCdN4N4RavsAQEqNU8PGVb2bh7fmWtfDPDtsrXzpGkESvGd
         aZAwD7ULTmeuMDJfShrg4v3kG6qvCUAGwnSOXlqQ+x8M/tR8DDnBRCjDLrLCFOns0lYR
         HzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDJV4ZwRVQLzE0DQMb9i2tBKWni84XeHMbgigRoQK/0=;
        b=qRLZx0IEUeSbZ51NoBUh4zRLh7GJJz5ytf4d2mC2uMo3X7KBC4xfB+NLF2D7Y9m/8R
         QftfAzEgiSh+YXfc9/rna9kU7I61Pyp1WLOuA7q9ut4MsnfHm+Fg7dg+NddrF7tS1e+O
         HfaXqz5DJZ4Ytx4O2zSt3nXcSRr4KMvZhgP/hsQmeiZ3JlNPFHNKvEOGnBawfh31r4Gm
         zzD5HCbLZik1UgBvPpyzHXHUqbMSxJKFM2QairXtoVdOD5U/I8AMp4nSUnq2nC67OYwZ
         y1Fw3ZZqgeBhxYL8tDHBIT3xcN0IxGC1juyKHipXavjYyVDXyY8liu+NEKVaumhQ1dF/
         rpVw==
X-Gm-Message-State: ACrzQf06lvoBdO+23aWzF/6KocYSqIyaFdyyzNCr9I1k8p0UmkVzEsSb
        jH5+uzxGlitGwiwTAIYemTazww==
X-Google-Smtp-Source: AMsMyM798d6sCpUdCwQ/ecSIilfJZ6v86SVZw+SrASHeVBqUCbXn5DWhzpkIIEZcuJRhURHhRtRArA==
X-Received: by 2002:a65:6b81:0:b0:461:4049:7df7 with SMTP id d1-20020a656b81000000b0046140497df7mr7235376pgw.593.1666185109034;
        Wed, 19 Oct 2022 06:11:49 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm10934478plc.283.2022.10.19.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:11:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v4 3/4] RISC-V: Implement arch specific PMEM APIs
Date:   Wed, 19 Oct 2022 18:41:27 +0530
Message-Id: <20221019131128.237026-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019131128.237026-1-apatel@ventanamicro.com>
References: <20221019131128.237026-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

