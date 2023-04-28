Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116236F1E91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbjD1TG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbjD1TGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:06:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FC5BB3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:06:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a92513abebso3111865ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682708784; x=1685300784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D89w6evzZY62CLS4sdNOFd++5ex0CVlzqlNfXr51rew=;
        b=XPVZ6NCnCoFjxC6YD2341V82cfMAkgxl5sflhiaJXJU2xKzgKMRbGhs4dKR8/Z06V+
         RCMLENzoJS4+vECYinsrQZ93ZGQhwXZu31j8vh+dVZeaXYW02Um0jzM2usQa9xLFwxLt
         IqY8lSLpX9zyrVsDFrqNG3w4NyaLXjbnFD1X0+x0IgjrG5PmTvVmrKyx1lP/QPdWLhQH
         4xxLUgei2rY0T6+/D1EpLEcGT4ireXhDFp7V5aeVYxeM36cM9d3X26S66c3RcsIescMb
         0/A+XN4VNXladtgHPJfw62c3KPy5qS/77aBeq8Z7XFIf99mmmKtKkKb/sSkZG6fm1oZq
         a40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708784; x=1685300784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D89w6evzZY62CLS4sdNOFd++5ex0CVlzqlNfXr51rew=;
        b=jIayXEgmLdk8AihEldLKf08S7k1rwMi2slV5qeUOsFWDhiIJHuSoCC/zpHTCZwYwlp
         gi2NB+onTLWix1viZOyAS+yyz1Rlsj1AEMIUPJzws6m1DW6ZWG+CdPSkSxTGXbTZJRq8
         i4yfJp/s7ly5pGKASNTz+8qEB7sUdEmXi5FhvDCCZx7lMoL9Nuoyq0FGLeppF4afKdUW
         5IwcdMErucGB7LYINAejkuTEi/kBFSEoBrafeAakm/u3JM2tmO6oCWbP1a4r3J/Dtg2X
         zH8X/XKmHtfYyQZ3E5DTxdLsq7Hfiu4S3Jiwyd2C4zf07a6VqvT0VOG1RVCHezNNXmlM
         qUWw==
X-Gm-Message-State: AC+VfDzv+kZVQyAA67X2zJlLgn/dbhcfGHFV1w48Q2zbC5B5ise6E+4Z
        Bpa62hUVpVEhOI2lERuPL8ARDQ==
X-Google-Smtp-Source: ACHHUZ7UgLi06zYN/mzndnkISKYeWfeQNbW1Slx9WdjlgKjYR1dXTKYuyf1VE7ibwkyN5CUMaLS03w==
X-Received: by 2002:a17:902:d503:b0:1a0:57dd:b340 with SMTP id b3-20020a170902d50300b001a057ddb340mr7968392plg.64.1682708783816;
        Fri, 28 Apr 2023 12:06:23 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902d70f00b001a6c58e95d7sm13580733ply.269.2023.04.28.12.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:06:23 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] RISC-V: Track ISA extensions per hart
Date:   Fri, 28 Apr 2023 12:06:07 -0700
Message-Id: <20230428190609.3239486-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428190609.3239486-1-evan@rivosinc.com>
References: <20230428190609.3239486-1-evan@rivosinc.com>
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

The kernel maintains a mask of ISA extensions ANDed together across all
harts. Let's also keep a bitmap of ISA extensions for each CPU. Although
the kernel is currently unlikely to enable a feature that exists only on
some CPUs, we want the ability to report asymmetric CPU extensions
accurately to usermode.

Note that riscv_fill_hwcaps() runs before the per_cpu_offsets are built,
which is why I've used a [NR_CPUS] array rather than per_cpu() data.

Signed-off-by: Evan Green <evan@rivosinc.com>
---

 arch/riscv/include/asm/cpufeature.h | 10 ++++++++++
 arch/riscv/kernel/cpufeature.c      | 18 ++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 808d5403f2ac..23fed53b8815 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -6,6 +6,9 @@
 #ifndef _ASM_CPUFEATURE_H
 #define _ASM_CPUFEATURE_H
 
+#include <linux/bitmap.h>
+#include <asm/hwcap.h>
+
 /*
  * These are probed via a device_initcall(), via either the SBI or directly
  * from the corresponding CSRs.
@@ -16,8 +19,15 @@ struct riscv_cpuinfo {
 	unsigned long mimpid;
 };
 
+struct riscv_isainfo {
+	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
+};
+
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 DECLARE_PER_CPU(long, misaligned_access_speed);
 
+/* Per-cpu ISA extensions. */
+extern struct riscv_isainfo hart_isa[NR_CPUS];
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1a80474e308e..0e9d66580478 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/hwcap.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
@@ -25,6 +26,9 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
+/* Per-cpu ISA extensions. */
+struct riscv_isainfo hart_isa[NR_CPUS];
+
 /* Performance information */
 DEFINE_PER_CPU(long, misaligned_access_speed);
 
@@ -112,14 +116,17 @@ void __init riscv_fill_hwcap(void)
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
 	for_each_of_cpu_node(node) {
+		struct riscv_isainfo *isainfo;
 		unsigned long this_hwcap = 0;
-		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
+		unsigned int cpu_id;
 
 		rc = riscv_of_processor_hartid(node, &hartid);
 		if (rc < 0)
 			continue;
 
+		cpu_id = riscv_hartid_to_cpuid(hartid);
+		isainfo = &hart_isa[cpu_id];
 		if (of_property_read_string(node, "riscv,isa", &isa)) {
 			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
 			continue;
@@ -136,7 +143,6 @@ void __init riscv_fill_hwcap(void)
 		/* The riscv,isa DT property must start with rv64 or rv32 */
 		if (temp == isa)
 			continue;
-		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
 			const char *ext_end = isa;
@@ -214,7 +220,7 @@ void __init riscv_fill_hwcap(void)
 				if ((ext_end - ext == sizeof(name) - 1) &&	\
 				     !memcmp(ext, name, sizeof(name) - 1) &&	\
 				     riscv_isa_extension_check(bit))		\
-					set_bit(bit, this_isa);			\
+					set_bit(bit, isainfo->isa);		\
 			} while (false)						\
 
 			if (unlikely(ext_err))
@@ -224,7 +230,7 @@ void __init riscv_fill_hwcap(void)
 
 				if (riscv_isa_extension_check(nr)) {
 					this_hwcap |= isa2hwcap[nr];
-					set_bit(nr, this_isa);
+					set_bit(nr, isainfo->isa);
 				}
 			} else {
 				/* sorted alphabetically */
@@ -253,9 +259,9 @@ void __init riscv_fill_hwcap(void)
 			elf_hwcap = this_hwcap;
 
 		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
-			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+			bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 		else
-			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+			bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RISCV_ISA_EXT_MAX);
 	}
 
 	/* We don't support systems with F but without D, so mask those out
-- 
2.25.1

