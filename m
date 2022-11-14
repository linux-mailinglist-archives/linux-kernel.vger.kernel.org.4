Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8561A6278B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiKNJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiKNJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:07:27 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF111EC55
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:12 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n186so10769561oih.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoWw75G040ie7NtRU1t+qmFKMYccQlQoZxH65ktuUwc=;
        b=iw9Zn5wy3+2CheYk+HVFSGRBQPMEZOzZdXThvNA5wyIVOJtvxvOTQ2Di46U4JtsTht
         05BGqmPk7xhqxM5lMFWPJFdT5j3kWYNpuQa1womt+KcVO4WC9osXK7+IkZl5OH7VAOxd
         4bDH4oJvu4vVDT5aTyrn+FeQ79E+/PLS50EkGAWgqiXo2Oh70O24CxX4ljF3Vf+E/GNp
         Gq5pA4bbJ4wMqrr8dUGIDyGV6oZK32en879tDPV3UPAfuDdsrL9lNS5ehqBSakIVmYe1
         gcHvYbnQZSdtrqOt3z3BXSic/bL5gCQ67z8CqVvnFbMJb9PjRASxShXBN7Fkwn75e9T3
         Ux4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoWw75G040ie7NtRU1t+qmFKMYccQlQoZxH65ktuUwc=;
        b=yX+G73Ehtuh5EutpEWLlLRMSUEOYhlHgD3wG1vLZQZidRCX1lI0AkCy1LdxdlpXkh3
         yApp/nKPuJ+mYE0ori4sMh8aTMLMsv3taU8Gmdhpmucozv/nMqeb0iRDKFG3Nkm3gKEn
         MQ6318k8gDZs/T3FMH1glZ+OYmfwwwJrdBT2tatGymBBz2yJrJbddn4P8t9tHNhCMAsk
         5FfVg5knImH7DdWU+/f023x0+v6q3xUWmn5mVJa1K3+9CXVwGFZQ2nV2ZTOxmRF20PK1
         ShpPbCkQLZVTYJEzYM5RqUmH0gShraQj+f3Jby0NPwMp2rJuqaDdrAGyHBvRnTSl6sRE
         srqA==
X-Gm-Message-State: ANoB5pm3AqQAIc9EYoQ9L8F8Gi1W9xVZKrLAGadwxJZe/Dy3ifMJo/ch
        Vj3KSxodKaNtkIqSwDd/qY2s5A==
X-Google-Smtp-Source: AA0mqf7m8kcUu9r7qqVEnPOsTVHBFEw7ibiEt7s/gaYqgSEg0zIa+JeX1KtG63NZnHWjukxkKfep0Q==
X-Received: by 2002:aca:110a:0:b0:35a:c54:3ad2 with SMTP id 10-20020aca110a000000b0035a0c543ad2mr5146218oir.89.1668416771563;
        Mon, 14 Nov 2022 01:06:11 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020aca2402000000b00354948e04e4sm3432939oic.2.2022.11.14.01.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:06:11 -0800 (PST)
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
Subject: [PATCH v6 2/3] RISC-V: Implement arch specific PMEM APIs
Date:   Mon, 14 Nov 2022 14:35:35 +0530
Message-Id: <20221114090536.1662624-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
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
index fa78595a6089..c0e22648bd16 100644
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
index d76aabf4b94d..b4f35da889bf 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,6 +13,7 @@ obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
 obj-y += cacheflush.o
 obj-y += context.o
+obj-y += pmem.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
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

