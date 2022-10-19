Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144D604579
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiJSMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiJSMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:37:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202C1C39D3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b2so17066646plc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdtB7nMd/miz6z/bYLXsK5LnjcXiRmtDmCC/irDiq08=;
        b=ZNTnuvr/My0fIC2ty0kF+NAFIXY/CL8dJ6j3U15+FaRaF/zMLjmLjP7RA0RhEINB/Q
         3w2uMYHYl41k+ZnfbD2vHNNPCIJbx1DMZunEU9IVtXOTM8i1EWvw3lizhEP1uIVVHpeb
         Z1dDpqVHwqRauvg8lBU7lXpRbvoNKicxkCRQp7VW9F3I5jAuQuuGM2tgu3chMPlMa2rR
         FBh8UXYEnr/85LhHRLxRm6SxfFcjrH/dHuglFLGNCuRvUvXsbw70YyBsZovrBvn6Ddt7
         azqsKprRSFmZMRR/j/3lakEhpLBco3VuJP1dSh23uOdXEmBlGyFFihXnxm5V4/EUxzHG
         QeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdtB7nMd/miz6z/bYLXsK5LnjcXiRmtDmCC/irDiq08=;
        b=WicHGMmMEmY9sItxluHjh1bZvG5cK0V2UKiGeu0V75LdF/9HZQDw0UjrzFy3fSf8R1
         D+bhtcZwsf2mHqBpfK2EFXADYaSutGBG4wxSPSPD9sEipq09UCJgMgo+4dWca7IFjPeL
         UzG9VXEMfbl8bJUILf52kI8x2LnjK4pjRjf4cPEK1qQIixuPZkr7ReuJw85d8o17ALeu
         oZgy287qajqn6EqVLNn6UvnvChpvD+xsTNMeO5PV9cusJuV+8q59TRpMaGe1tGYj8XGJ
         eiVJeVbNMeqEA82XZGmeMuqk93P5gNvdlleQlXQU5PUY5TCLwXwX0uAtobO68UfQGgG/
         o4Cw==
X-Gm-Message-State: ACrzQf3lA27G//S6qfi8JgGtblRhkFzQ1UYB8ArDjPADJW5r+RCzdZv6
        m38PzCS7AgA7If/bK8qY52Rdmw==
X-Google-Smtp-Source: AMsMyM43lEAuHZJ2yzkU8GrvCn2JCt/aIDmh+HadtSOnQ5dQ4xwNgJKColdK/KeW3iyLTPXkt3UhLA==
X-Received: by 2002:a17:903:2286:b0:185:3948:be93 with SMTP id b6-20020a170903228600b001853948be93mr8216477plh.121.1666181809464;
        Wed, 19 Oct 2022 05:16:49 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.82.102])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b0017e93c158d7sm10529824pla.214.2022.10.19.05.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 05:16:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
Date:   Wed, 19 Oct 2022 17:46:19 +0530
Message-Id: <20221019121622.179024-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019121622.179024-1-apatel@ventanamicro.com>
References: <20221019121622.179024-1-apatel@ventanamicro.com>
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

From: Andrew Jones <ajones@ventanamicro.com>

riscv_cbom_block_size and riscv_init_cbom_blocksize() should always
be available and riscv_init_cbom_blocksize() should always be
invoked, even when compiling without RISCV_ISA_ZICBOM enabled. This
is because disabling RISCV_ISA_ZICBOM means "don't use zicbom
instructions in the kernel" not "pretend there isn't zicbom, even
when there is". When zicbom is available, whether the kernel enables
its use with RISCV_ISA_ZICBOM or not, KVM will offer it to guests.
Ensure we can build KVM and that the block size is initialized even
when compiling without RISCV_ISA_ZICBOM.

Fixes: 8f7e001e0325 ("RISC-V: Clean up the Zicbom block size probing")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/mm/cacheflush.c      | 41 +++++++++++++++++++++++++++++++++
 arch/riscv/mm/dma-noncoherent.c | 41 ---------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..f318b2553612 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_SMP
@@ -86,3 +88,42 @@ void flush_icache_pte(pte_t pte)
 		flush_icache_all();
 }
 #endif /* CONFIG_MMU */
+
+unsigned int riscv_cbom_block_size;
+EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
+
+#ifdef CONFIG_RISCV_ISA_ZICBOM
+void riscv_init_cbom_blocksize(void)
+{
+	struct device_node *node;
+	unsigned long cbom_hartid;
+	u32 val, probed_block_size;
+	int ret;
+
+	probed_block_size = 0;
+	for_each_of_cpu_node(node) {
+		unsigned long hartid;
+
+		ret = riscv_of_processor_hartid(node, &hartid);
+		if (ret)
+			continue;
+
+		/* set block-size for cbom extension if available */
+		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
+		if (ret)
+			continue;
+
+		if (!probed_block_size) {
+			probed_block_size = val;
+			cbom_hartid = hartid;
+		} else {
+			if (probed_block_size != val)
+				pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
+					cbom_hartid, hartid);
+		}
+	}
+
+	if (probed_block_size)
+		riscv_cbom_block_size = probed_block_size;
+}
+#endif
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index b0add983530a..d919efab6eba 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -8,13 +8,8 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <asm/cacheflush.h>
 
-unsigned int riscv_cbom_block_size;
-EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
-
 static bool noncoherent_supported;
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
@@ -77,42 +72,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	dev->dma_coherent = coherent;
 }
 
-#ifdef CONFIG_RISCV_ISA_ZICBOM
-void riscv_init_cbom_blocksize(void)
-{
-	struct device_node *node;
-	unsigned long cbom_hartid;
-	u32 val, probed_block_size;
-	int ret;
-
-	probed_block_size = 0;
-	for_each_of_cpu_node(node) {
-		unsigned long hartid;
-
-		ret = riscv_of_processor_hartid(node, &hartid);
-		if (ret)
-			continue;
-
-		/* set block-size for cbom extension if available */
-		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
-		if (ret)
-			continue;
-
-		if (!probed_block_size) {
-			probed_block_size = val;
-			cbom_hartid = hartid;
-		} else {
-			if (probed_block_size != val)
-				pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
-					cbom_hartid, hartid);
-		}
-	}
-
-	if (probed_block_size)
-		riscv_cbom_block_size = probed_block_size;
-}
-#endif
-
 void riscv_noncoherent_supported(void)
 {
 	WARN(!riscv_cbom_block_size,
-- 
2.34.1

