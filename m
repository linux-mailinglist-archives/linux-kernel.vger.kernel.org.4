Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88B73FE6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjF0Ojk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjF0OjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:39:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E44227
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a5fd1f46so28885091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687876707; x=1690468707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEVMNWZBLS5DhwYM44VfQcdvAzGjTI9zLgPIzTOkT24=;
        b=v9B9fq/vnNw5vf4/XMj+DEzij4XdCJ6Qu3k6rdu3hoknkqAcbiibMohh2vV1/Xvhlm
         PVaQZZfTbieNjPjrodFPdFF6p6fpJKmmnsJQx91yFtgkyLi0YcnJSBLXQh4oYYljL26q
         IGt46axPduHixlBtVb/5lQePN3POydzxHqBhIZFUqEjbKyyaTtHxN8xOgSenCmW4HRqU
         TLC4AhqDMkMlYe2TP6NJOJpaqjrNqF/guZWbSEh+/mYnMkAfhdVrabcJI5aZwTcCn4Ki
         CI+2GPpo2kDgHTQ+TxX6K4o0XuQtjUcASMJnhRuvVXQVHTtf7qPEnvwiHK41v+237soc
         aO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876707; x=1690468707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEVMNWZBLS5DhwYM44VfQcdvAzGjTI9zLgPIzTOkT24=;
        b=fYH1De3azmeJrgWh16WXQoNsLnQO1Gy6B7s1cs2FPh0YwCiQMLDFf1YseiQaf31NS5
         nGxuUjvOty1WWypKBmlZR9CaPnIB9PF2rHzpCzdszrrV6mceudXZb6inbZ/AWTrCCb7V
         IHIzj7HfVmAvaFis9Lyiwok1r09VZGuVrELINIUotbnmxy2a5dDnTSQTqA0LObwsNnNW
         XqsUST6EKDzJkxT5W80rz9yyTcn3MpW+rJ18XdO1JIr2Gmd8YlfEitKDG8vVAw8aIoeP
         CRykGM+0l2zsYPCPUjmT4ZruDeOh0RuBXNG35AeJoZdmmaK9RGsEPQPv82jLJnzp+FP0
         5C3w==
X-Gm-Message-State: AC+VfDyRXPFQSa7bq7NeuHCx0NCi34KQ1fRwTxlhrjpcQgbZVMRZygUP
        bEkAh9E2azQ+O1G/eMTlZ3kK4A==
X-Google-Smtp-Source: ACHHUZ5gRueMgICNs3RdPFGz2gRhMpqeYApnug8Cx+udx1fIHBUDvYkXd9ZgIOxCf+aCf1+CRY+/zA==
X-Received: by 2002:a05:6512:2512:b0:4fb:52f1:9aab with SMTP id be18-20020a056512251200b004fb52f19aabmr5533732lfb.66.1687876706673;
        Tue, 27 Jun 2023 07:38:26 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f8fac0ad4bsm10894793wml.17.2023.06.27.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:38:26 -0700 (PDT)
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>
Subject: [PATCH 3/3] RISC-V: Implement archrandom when Zkr is available
Date:   Tue, 27 Jun 2023 16:37:44 +0200
Message-ID: <20230627143747.1599218-4-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627143747.1599218-1-sameo@rivosinc.com>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
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

The Zkr extension is ratified and provides 16 bits of entropy seed when
reading the SEED CSR.

We can implement arch_get_random_seed_longs() by doing multiple csrrw to
that CSR and filling an unsigned long with valid entropy bits.

Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 arch/riscv/include/asm/archrandom.h | 66 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h        |  9 ++++
 2 files changed, 75 insertions(+)
 create mode 100644 arch/riscv/include/asm/archrandom.h

diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
new file mode 100644
index 000000000000..3d01aab2800a
--- /dev/null
+++ b/arch/riscv/include/asm/archrandom.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel interface for the RISCV arch_random_* functions
+ *
+ * Copyright (c) 2022 by Rivos Inc.
+ *
+ */
+
+#ifndef ASM_RISCV_ARCHRANDOM_H
+#define ASM_RISCV_ARCHRANDOM_H
+
+#include <asm/csr.h>
+
+#define PR_PREFIX "Zkr Extension: "
+#define SEED_RETRY_LOOPS 10
+
+static inline bool __must_check csr_seed_long(unsigned long *v)
+{
+	unsigned int retry = SEED_RETRY_LOOPS;
+	unsigned int needed_seeds = sizeof(unsigned long) / 2, valid_seeds = 0;
+	u16 *entropy = (u16 *)v;
+
+	do {
+		/*
+		 * The SEED CSR (0x015) must be accessed with a read-write
+		 * instruction. Moreover, implementations must ignore the write
+		 * value, its purpose is to signal polling for new seed.
+		 */
+		unsigned long csr_seed = csr_swap(CSR_SEED, 0);
+
+		switch (csr_seed & SEED_OPST_MASK) {
+		case SEED_OPST_ES16:
+			entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
+			if (valid_seeds == needed_seeds)
+				return true;
+			break;
+
+		case SEED_OPST_DEAD:
+			pr_err_once(PR_PREFIX "Unrecoverable error\n");
+			return false;
+
+		case SEED_OPST_BIST:
+			pr_info(PR_PREFIX "On going Built-in Self Test\n");
+			fallthrough;
+
+		case SEED_OPST_WAIT:
+		default:
+			continue;
+		}
+
+	} while (--retry);
+
+	return false;
+}
+
+static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
+{
+	return 0;
+}
+
+static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
+{
+	return max_longs && riscv_isa_extension_available(NULL, ZKR) && csr_seed_long(v) ? 1 : 0;
+}
+
+#endif /* ASM_RISCV_ARCHRANDOM_H */
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index b98b3b6c9da2..7d0ca9082c66 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -389,6 +389,15 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+/* Scalar Crypto Extension - Entropy */
+#define CSR_SEED		0x015
+#define SEED_OPST_MASK		_AC(0xC0000000, UL)
+#define SEED_OPST_BIST		_AC(0x00000000, UL)
+#define SEED_OPST_WAIT		_AC(0x40000000, UL)
+#define SEED_OPST_ES16		_AC(0x80000000, UL)
+#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
+#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.41.0

