Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06D16E84C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjDSWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjDSWVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:21:33 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7EB44C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:20:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b603bb360so252173a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681942736; x=1684534736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpkP1wnIrltbLZeAb/TZzxnsq9NvqWT39c9WofSyiOk=;
        b=Nzsbq++D21vwA8dGs2TEhUmfLPFSaig0puRkykWSASC64dxd/vGkpSKeFxQXOJxyon
         5Ou4PoViyNfDX1Gfoq/jlBl1G1RhaiR4JLXaKzD7kt+niF6AKE+yOb7DVxkMfV9AiHsx
         mTPuZ/MAZl6BEVu8xpX5HBzOXWWYp6VQYr3Mp0sTKgkIRgLhxoSPyTdHc4vxQBKRTjC6
         nzaETrxZRtdvV7d/S3g19DaIk1Y5S0BgV4Ei7fF0jUB1ujpfDWT04dllTpouA2v7Akvc
         l3myGSmdOxw+gPB2lOjj2aqYoHDlOR0Rr4q6kW0PPflSvA1d+iZ7docwAXBz+likDSY4
         tCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942736; x=1684534736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpkP1wnIrltbLZeAb/TZzxnsq9NvqWT39c9WofSyiOk=;
        b=Xi/ZQk+3LLibdCoAVSrmyKIsQQymeWnRxPnc0uHJnzb/Z1HSD8JYNLrJfnRph8aFxT
         5uHRiA5N2GlbYcoNFgz4VzHEXEPLYjY6lFePi0FssfzN2xNEP6T9jumJ1miYn2aqDOp+
         SxK13oHR7V2y145H4aInJ+ZqEtGXNYiNMohtiLT3j24QSGX7N2KqZrz/x4HOtRMErcrw
         CNYNOsnUB1cyJ6XW94SJ6W/2f5PXxLRkAC7ZmSkbSKEHGSzvaPheKwo4u/0zuViCR3zK
         fxt2PofpAatZKX9jojed0ybdJad2XNi0jQPn3/MVj0+ZGrOMhQ2VD6QvZNMD71ovaY6K
         htZw==
X-Gm-Message-State: AAQBX9ceTvF6PFjVOpY8LlZ+N8wRqBzP2OOzxF+9+BgBKN39VsFRRwKD
        nKgi1ftnJtFL10ZFvBPi08oKPN3F8Agod6DnOnU=
X-Google-Smtp-Source: AKy350bCoBKIrFcroX21XtHTuZqvJehyqLN918v9CE2Osbf4jkMqvKMUa5z+Sio4RKf3jpe/KHP4Bg==
X-Received: by 2002:a17:90a:f415:b0:247:6be7:8cc0 with SMTP id ch21-20020a17090af41500b002476be78cc0mr3832862pjb.35.1681942736133;
        Wed, 19 Apr 2023 15:18:56 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id jn11-20020a170903050b00b00196807b5189sm11619190plb.292.2023.04.19.15.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:18:55 -0700 (PDT)
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
Subject: [RFC 39/48] RISC-V: Implement COVG SBI extension
Date:   Wed, 19 Apr 2023 15:17:07 -0700
Message-Id: <20230419221716.3603068-40-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419221716.3603068-1-atishp@rivosinc.com>
References: <20230419221716.3603068-1-atishp@rivosinc.com>
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

COVG extension defines the guest side interface for running a guest
in CoVE. These functions allow a CoVE guest to share/unshare memory, ask
host to trap and emulate MMIO regions and allow/deny
injection of interrupts from host.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/cove/Makefile          |   2 +-
 arch/riscv/cove/cove_guest_sbi.c  | 109 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/covg_sbi.h |  38 +++++++++++
 3 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/cove/cove_guest_sbi.c
 create mode 100644 arch/riscv/include/asm/covg_sbi.h

diff --git a/arch/riscv/cove/Makefile b/arch/riscv/cove/Makefile
index 03a0cac..a95043b 100644
--- a/arch/riscv/cove/Makefile
+++ b/arch/riscv/cove/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RISCV_COVE_GUEST)	+= core.o
+obj-$(CONFIG_RISCV_COVE_GUEST)	+= core.o cove_guest_sbi.o
diff --git a/arch/riscv/cove/cove_guest_sbi.c b/arch/riscv/cove/cove_guest_sbi.c
new file mode 100644
index 0000000..af22d5e
--- /dev/null
+++ b/arch/riscv/cove/cove_guest_sbi.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * COVG SBI extensions related helper functions.
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ * Authors:
+ *     Rajnesh Kanwal <rkanwal@rivosinc.com>
+ */
+
+#include <linux/errno.h>
+#include <asm/sbi.h>
+#include <asm/covg_sbi.h>
+
+int sbi_covg_add_mmio_region(unsigned long addr, unsigned long len)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_ADD_MMIO_REGION, addr, len,
+			0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_remove_mmio_region(unsigned long addr, unsigned long len)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_REMOVE_MMIO_REGION, addr,
+			len, 0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_share_memory(unsigned long addr, unsigned long len)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_SHARE_MEMORY, addr, len, 0,
+			0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_unshare_memory(unsigned long addr, unsigned long len)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_UNSHARE_MEMORY, addr, len, 0,
+			0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_allow_external_interrupt(unsigned long id)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_ALLOW_EXT_INTERRUPT, id, 0,
+			0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_allow_all_external_interrupt(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_ALLOW_EXT_INTERRUPT, -1, 0,
+			0, 0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_deny_external_interrupt(unsigned long id)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_DENY_EXT_INTERRUPT, id, 0, 0,
+			0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
+
+int sbi_covg_deny_all_external_interrupt(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_COVG, SBI_EXT_COVG_DENY_EXT_INTERRUPT, -1, 0, 0,
+			0, 0, 0);
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+
+	return 0;
+}
diff --git a/arch/riscv/include/asm/covg_sbi.h b/arch/riscv/include/asm/covg_sbi.h
new file mode 100644
index 0000000..31283de
--- /dev/null
+++ b/arch/riscv/include/asm/covg_sbi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * COVG SBI extension related header file.
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ * Authors:
+ *     Rajnesh Kanwal <rkanwal@rivosinc.com>
+ */
+
+#ifndef __RISCV_COVG_SBI_H__
+#define __RISCV_COVG_SBI_H__
+
+#ifdef CONFIG_RISCV_COVE_GUEST
+
+int sbi_covg_add_mmio_region(unsigned long addr, unsigned long len);
+int sbi_covg_remove_mmio_region(unsigned long addr, unsigned long len);
+int sbi_covg_share_memory(unsigned long addr, unsigned long len);
+int sbi_covg_unshare_memory(unsigned long addr, unsigned long len);
+int sbi_covg_allow_external_interrupt(unsigned long id);
+int sbi_covg_allow_all_external_interrupt(void);
+int sbi_covg_deny_external_interrupt(unsigned long id);
+int sbi_covg_deny_all_external_interrupt(void);
+
+#else
+
+static inline int sbi_covg_add_mmio_region(unsigned long addr, unsigned long len) { return 0; }
+static inline int sbi_covg_remove_mmio_region(unsigned long addr, unsigned long len) { return 0; }
+static inline int sbi_covg_share_memory(unsigned long addr, unsigned long len) { return 0; }
+static inline int sbi_covg_unshare_memory(unsigned long addr, unsigned long len) { return 0; }
+static inline int sbi_covg_allow_external_interrupt(unsigned long id) { return 0; }
+static inline int sbi_covg_allow_all_external_interrupt(void) { return 0; }
+static inline int sbi_covg_deny_external_interrupt(unsigned long id) { return 0; }
+static inline int sbi_covg_deny_all_external_interrupt(void) { return 0; }
+
+#endif
+
+#endif /* __RISCV_COVG_SBI_H__ */
-- 
2.25.1

