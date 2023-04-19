Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D996E84D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjDSWXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjDSWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:22:58 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99750BB91
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:21:10 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-63b73203e0aso2787340b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942734; x=1684534734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI5JEqEayPS5t0DearmNB32dGieY2Rp85qRqyRU4954=;
        b=c61/p77dAtF7ITFaJtJ2ThSiNokGE55QUnDMhiyOWQfpvPZA4LwEm0dNNepuTh8/vI
         ETC0NUKHH0B7ioWMNIOCRl7AjZHuiWQCd9YRt/w8gX3X03F0aRKluujbAxJMyKQ218iz
         HyGwjvHTZ57PibWhtCDK2NRKMiLlH7ybE/Z877P0tsYOxOH43juir+xqANUqGBHB7/WR
         aQibBdjDGfMJsGQ2duTavnD7648VTHs+6zw4IzdBl5zGyzuHnyd08ri5ZAx79ZyGdHPQ
         +HVr9NAcGBE4GY7Q3b9IwiUkw1Xx2A9JUqYVhhUubWWiX//8s8ew3EPoW97k6emKoi+z
         u1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942734; x=1684534734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI5JEqEayPS5t0DearmNB32dGieY2Rp85qRqyRU4954=;
        b=FAIx4eATNwM7tMYU4QYfiP4jgNcB1OkIqiMMpsFNQNcg1cJX3/K4OQ8rpTtLbIFr7B
         k4hE/rWIw5cgQGFR7O2bmk9H6VHm6MrjHHlZlGP2YlP7+Mza5wiwbtVJH941uPVBqIZQ
         w0FJiq3U95vgNoHJs3ldr65QJesnr4kjmaD9MR1MBMxSUSU2c+vmFpEm5m37U0j6fnsA
         u0PJvtuo8UpR3dgpakiBtAUoRFXAREcmDuHwa6/LmkZtIVJ1sLWP2kVW5qrOQ2gEO7Sh
         sjCQFgSyN1gQjSNsGVippCH+e2HZxwIm63NxCRUk3WXyBUL7adL30SNguVTFuXrqQtr6
         6CsQ==
X-Gm-Message-State: AAQBX9elrxZEkowS7Vi9bysqAiXklHl2cg7BhapGCcgyFdLFYf5GvZf1
        ZCLXnU+1lpEXcQVTSferyTNlA7wOcDsE9YPCIdw=
X-Google-Smtp-Source: AKy350bHPqgey3c6g8HqkR9B9xlgHTWq+fR92XQNeVK1lT0G63M1RyCGum2kegw8LaA3eJtSnsnKXQ==
X-Received: by 2002:a17:90a:6002:b0:246:865d:419a with SMTP id y2-20020a17090a600200b00246865d419amr3928528pji.6.1681942733866;
        Wed, 19 Apr 2023 15:18:53 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:53 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC 38/48] RISC-V: Add CoVE guest config and helper functions
Date:   Wed, 19 Apr 2023 15:17:06 -0700
Message-Id: <20230419221716.3603068-39-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Introduce a separate config for the guest running in CoVE so that
it can be enabled separately if required. However, the default config
will enable both CoVE host & guest configs in order to make single
image work as both host & guest. Introduce a helper function to
detect if a guest is TVM or not at run time. The TSM only enables
the CoVE guest SBI extension for TVMs.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/Kbuild             |  2 ++
 arch/riscv/Kconfig            |  6 ++++++
 arch/riscv/cove/Makefile      |  2 ++
 arch/riscv/cove/core.c        | 28 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/cove.h | 27 +++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |  2 ++
 6 files changed, 67 insertions(+)
 create mode 100644 arch/riscv/cove/Makefile
 create mode 100644 arch/riscv/cove/core.c
 create mode 100644 arch/riscv/include/asm/cove.h

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index afa83e3..ecd661e 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-$(CONFIG_RISCV_COVE_GUEST) += cove/
+
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
 obj-y += errata/
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8462941..49c3006 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -512,6 +512,12 @@ config RISCV_COVE_HOST
 	    That means the platform should be capable of running TEE VM (TVM)
 	    using KVM and TEE Security Manager (TSM).
 
+config RISCV_COVE_GUEST
+	bool "Guest Support for Confidential VM Extension(CoVE)"
+	default n
+	help
+	  Enables support for running TVMs on platforms supporting CoVE.
+
 endmenu # "Confidential VM Extension(CoVE) Support"
 
 endmenu # "Platform type"
diff --git a/arch/riscv/cove/Makefile b/arch/riscv/cove/Makefile
new file mode 100644
index 0000000..03a0cac
--- /dev/null
+++ b/arch/riscv/cove/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RISCV_COVE_GUEST)	+= core.o
diff --git a/arch/riscv/cove/core.c b/arch/riscv/cove/core.c
new file mode 100644
index 0000000..7218fe7
--- /dev/null
+++ b/arch/riscv/cove/core.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Confidential Computing Platform Capability checks
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ * Authors:
+ *     Rajnesh Kanwal <rkanwal@rivosinc.com>
+ */
+
+#include <linux/export.h>
+#include <linux/cc_platform.h>
+#include <asm/sbi.h>
+#include <asm/cove.h>
+
+static bool is_tvm;
+
+bool is_cove_guest(void)
+{
+	return is_tvm;
+}
+EXPORT_SYMBOL_GPL(is_cove_guest);
+
+void riscv_cove_sbi_init(void)
+{
+	if (sbi_probe_extension(SBI_EXT_COVG) > 0)
+		is_tvm = true;
+}
diff --git a/arch/riscv/include/asm/cove.h b/arch/riscv/include/asm/cove.h
new file mode 100644
index 0000000..c4d609d
--- /dev/null
+++ b/arch/riscv/include/asm/cove.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TVM helper functions
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ * Authors:
+ *     Rajnesh Kanwal <rkanwal@rivosinc.com>
+ */
+
+#ifndef __RISCV_COVE_H__
+#define __RISCV_COVE_H__
+
+#ifdef CONFIG_RISCV_COVE_GUEST
+void riscv_cove_sbi_init(void);
+bool is_cove_guest(void);
+#else /* CONFIG_RISCV_COVE_GUEST */
+static inline bool is_cove_guest(void)
+{
+	return false;
+}
+static inline void riscv_cove_sbi_init(void)
+{
+}
+#endif /* CONFIG_RISCV_COVE_GUEST */
+
+#endif /* __RISCV_COVE_H__ */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 7b2b065..20b0280 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -35,6 +35,7 @@
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
 #include <asm/efi.h>
+#include <asm/cove.h>
 
 #include "head.h"
 
@@ -272,6 +273,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_setup();
 	sbi_init();
+	riscv_cove_sbi_init();
 	jump_label_init();
 	parse_early_param();
 
-- 
2.25.1

