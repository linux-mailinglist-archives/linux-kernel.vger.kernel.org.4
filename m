Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B097749443
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGFDdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjGFDcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:32:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316C1BC8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:32:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686708c986so305188b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688614364; x=1691206364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X54Cbu5zOMSO9e4vO2L+KNC0L67rHLP6N1OU6Cg3wA8=;
        b=zKJJNZDxACZFWxRB/zHvfSWKhUbPKItCK9lk7EtkWevhCtdWzJp57LMr7M5SO4p889
         0CEiHoOsfhUxrxRMxAOHQLCywtikLQX2OGGV+bpxtN+jTpHfVSeyyPdIIIC5Wq0/MDpt
         6TV8xKx/89fEhdUG01aTS1EBWXNSz833xGU9iSxfFYTnU6hcpPzki+i8Gka177fS/dfN
         Xf5Ikzkgi7UOGvY+SkskucsCEtYH0OZlRBSr30r3SKHrN83Ru3p3d+JduZjia9Vy2lpw
         WXaYeBvWbvGBmnzlNn3c4ko+ygBEiZNgGcJjq84w5pgjn3GjSCuCTuPEi0DPa1GsQDD9
         M6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614364; x=1691206364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X54Cbu5zOMSO9e4vO2L+KNC0L67rHLP6N1OU6Cg3wA8=;
        b=YJsmuvAOnzKBupgcNH2g+VmrgIdGHjgfe1mJAq1o/X+LdVhIu64ZHusENRO3ZBRylt
         8/MPe5MfVcRgzPg8ROsq6Xx+Y25euh+vDxjwFt87z8GpErYaaxkazf4p51DoVG3efmqI
         BVHrZ2U9ALlVY5g4yNi0dtj9BqfQriq57DvZtq2VVpsu8zFArqTQ9dpnhw6zVQiy30bD
         w8zC7afP0Mw9ZQ6zz/aPltGH1umhZs5weN15yT7PnympiPU2lgS5YhPMFXn4ySn7bAS8
         07x9alpoIqmfSCSityvyS9QdIdtqZunLUuPOz4yOc1Xn/V+w5ijOIt0SqUkEvTNcL5V+
         oCYQ==
X-Gm-Message-State: ABy/qLbdIG+PMU7F0UHFbgbVKk6I0Twy8fa0t2c4xZ+s/5O5rDbxUgx5
        qtEi3lw/OQbKyV73uwnSLxqw2AktzQZVF+hyHTY=
X-Google-Smtp-Source: APBJJlEibChBqnf08BaWR2lS6f718PlTQs2OsmFSQ3SEhFbZq18oY01nl+i2/jd3tsACHZQGlvlb+Q==
X-Received: by 2002:a05:6a00:841:b0:668:9fb6:b311 with SMTP id q1-20020a056a00084100b006689fb6b311mr777400pfk.32.1688614363983;
        Wed, 05 Jul 2023 20:32:43 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id fk13-20020a056a003a8d00b006589cf6d88bsm239785pfb.145.2023.07.05.20.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:32:43 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 05 Jul 2023 20:30:18 -0700
Subject: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
In-Reply-To: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, charlie@rivosinc.com,
        evan@rivosinc.com, heiko@sntech.de, linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vendor extensions in hwprobe, add the ability to query if the
0.7.1 vector extension is available. It is determined to be available
only if the kernel is compiled with vector support, and the user is
using the c906.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.vendor                       | 11 +++++++++++
 arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
 arch/riscv/kernel/sys_riscv.c                   | 20 ++++++++++++++++++++
 arch/riscv/vendor_extensions/Makefile           |  2 ++
 arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
 arch/riscv/vendor_extensions/thead/extensions.c | 24 ++++++++++++++++++++++++
 6 files changed, 81 insertions(+)

diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
index 213ac3e6fed5..b8b9d15153eb 100644
--- a/arch/riscv/Kconfig.vendor
+++ b/arch/riscv/Kconfig.vendor
@@ -1,3 +1,14 @@
 menu "Vendor extensions selection"
 
+config VENDOR_EXTENSIONS_THEAD
+	bool "T-HEAD vendor extensions"
+	depends on RISCV_ALTERNATIVE
+	default n
+	help
+	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. Disabling
+	  this Kconfig will disable all T-HEAD vendor extensions. Please say "Y"
+	  here if your platform uses T-HEAD vendor extensions.
+
+	  Otherwise, please say "N" here to avoid unnecessary overhead.
+
 endmenu # "Vendor extensions selection"
diff --git a/arch/riscv/include/asm/extensions.h b/arch/riscv/include/asm/extensions.h
new file mode 100644
index 000000000000..27ce294a3d65
--- /dev/null
+++ b/arch/riscv/include/asm/extensions.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 by Rivos Inc.
+ */
+#ifndef __ASM_EXTENSIONS_H
+#define __ASM_EXTENSIONS_H
+
+#include <asm/hwprobe.h>
+#include <linux/cpumask.h>
+
+#define THEAD_ISA_EXT0 (RISCV_HWPROBE_VENDOR_EXTENSION_SPACE)
+#define THEAD_ISA_EXT0_V0_7_1 (1 << 0)
+
+int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
+		  const struct cpumask *cpus);
+#endif
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 2351a5f7b8b1..58b12eaeaf46 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -13,6 +13,7 @@
 #include <asm/vector.h>
 #include <asm/switch_to.h>
 #include <asm/uaccess.h>
+#include <asm/extensions.h>
 #include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
 #include <vdso/vsyscall.h>
@@ -192,6 +193,25 @@ static int hwprobe_vendor(__u64 mvendorid, struct riscv_hwprobe *pair,
 			 const struct cpumask *cpus)
 {
 	switch (mvendorid) {
+#ifdef CONFIG_VENDOR_EXTENSIONS_THEAD
+	case THEAD_VENDOR_ID:
+		struct riscv_hwprobe marchid = {
+			.key = RISCV_HWPROBE_KEY_MARCHID,
+			.value = 0
+		};
+		struct riscv_hwprobe mimpid = {
+			.key = RISCV_HWPROBE_KEY_MIMPID,
+			.value = 0
+		};
+
+		hwprobe_arch_id(&marchid, cpus);
+		hwprobe_arch_id(&mimpid, cpus);
+		if (marchid.value != -1ULL && mimpid.value != -1ULL)
+			hwprobe_thead(marchid.value, mimpid.value, pair, cpus);
+		else
+			return -1;
+		break;
+#endif
 	default:
 		return -1;
 	}
diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendor_extensions/Makefile
index e815895e9372..38c3e80469fd 100644
--- a/arch/riscv/vendor_extensions/Makefile
+++ b/arch/riscv/vendor_extensions/Makefile
@@ -1,3 +1,5 @@
 ifdef CONFIG_RELOCATABLE
 KBUILD_CFLAGS += -fno-pie
 endif
+
+obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) += thead/
diff --git a/arch/riscv/vendor_extensions/thead/Makefile b/arch/riscv/vendor_extensions/thead/Makefile
new file mode 100644
index 000000000000..7cf43c629b66
--- /dev/null
+++ b/arch/riscv/vendor_extensions/thead/Makefile
@@ -0,0 +1,8 @@
+ifdef CONFIG_FTRACE
+CFLAGS_REMOVE_extensions.o = $(CC_FLAGS_FTRACE)
+endif
+ifdef CONFIG_KASAN
+KASAN_SANITIZE_extensions.o := n
+endif
+
+obj-y += extensions.o
diff --git a/arch/riscv/vendor_extensions/thead/extensions.c b/arch/riscv/vendor_extensions/thead/extensions.c
new file mode 100644
index 000000000000..a177501bc99c
--- /dev/null
+++ b/arch/riscv/vendor_extensions/thead/extensions.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 by Rivos Inc.
+ */
+
+#include <asm/extensions.h>
+
+int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
+		  const struct cpumask *cpus)
+{
+	pair->value = 0;
+	switch (pair->key) {
+	case THEAD_ISA_EXT0:
+#ifdef CONFIG_RISCV_ISA_V
+		if (marchid == 0 && mimpid == 0)
+			pair->value |= THEAD_ISA_EXT0_V0_7_1;
+#endif
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}

-- 
2.41.0

