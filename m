Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF274C3EB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGIL4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 07:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjGIL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 07:56:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D621A7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 04:56:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso41075715e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688903768; x=1691495768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHYLymmcuaoqqfmNSUbFnocPVHqWILXfzwDmQ0dJduU=;
        b=kdkPUVVoTrKfrnbi2rIqcPrI38H252mgEq9dWEtC8wIXWp/VM4EmS3G2xyRNogbD0w
         1zsqpg11vQ+j+xqL6N73cAOK7kffGusm/lsT6yXFoZ6Gz0LX2p5kB9VYaLRbuyEb7PwU
         MIoISkGP1Vnty/4hlrMogwzyouRfOhzQsLg3r0WNzfrFHyQ5LJdYA1FZ8o4okCnoR6Sz
         osxGoKcA6sJ3jzMT1gTM+9V5xsM0z0ct1lzC6CtJ3JFLE43blMvHn9gNtWL2eUsDlano
         I9Yu39kJMlGymCtKB6yZdRfiHvBhOOvP3eHTTZop4Zi6i+FdhVLWMsfnwmM3POtt2ZUr
         Ce1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688903768; x=1691495768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHYLymmcuaoqqfmNSUbFnocPVHqWILXfzwDmQ0dJduU=;
        b=fzDkCWap88K4K7bnsbkR/wHb4QrSB4rsT9dT3S64csR7EcRdYmUG+xcgIxpLWB3MeM
         Wwcno2hZqjnjaRJcQUExyvLK7b4v0x4+y06KTspWp7EFmDtVCLlorOmqcg0F4WFMGaY9
         WLjEn/Vvf5xLn0qVfv9nMgWht2Ky04bi8PrQCe+Mp1uRKa6uPzqWkhjQqLm+6Yc/8zAm
         TunQYOWHnxdwsQRevXldIVs7Iyv9g2T+AY1U1dUstSmJpN/S44Z1pJDpauqzKER+41Io
         e4cr1K0ZgO61iLaoosS8C9SclzTTx9MQLVC2pWZ4DFVyz1lVj0Doy5UX33+h4F/vsubF
         6vNA==
X-Gm-Message-State: ABy/qLaCH1txtc7DUziccGlPq9vZuSbTebZwnowBQ36K+m7uqeLzKOE1
        5vwvoAMALGRxZpMjZnvgnjz3Ag==
X-Google-Smtp-Source: APBJJlGBayCeXEMwCggP+P7xtLc4lMgQ3SnaG9W7VfCF1g79e5queiWB9ETcSEiGaocbDuQB9CDUZw==
X-Received: by 2002:a7b:ca5a:0:b0:3fb:ff34:a846 with SMTP id m26-20020a7bca5a000000b003fbff34a846mr6403473wml.22.1688903768196;
        Sun, 09 Jul 2023 04:56:08 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c02c200b003fc007d8a92sm6194101wmn.45.2023.07.09.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 04:56:07 -0700 (PDT)
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
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] RISC-V: Implement archrandom when Zkr is available
Date:   Sun,  9 Jul 2023 13:55:46 +0200
Message-ID: <20230709115549.2666557-5-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709115549.2666557-1-sameo@rivosinc.com>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Zkr extension is ratified and provides 16 bits of entropy seed when
reading the SEED CSR.

We can implement arch_get_random_seed_longs() by doing multiple csrrw to
that CSR and filling an unsigned long with valid entropy bits.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
---
 arch/riscv/include/asm/archrandom.h | 70 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h        |  9 ++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/riscv/include/asm/archrandom.h

diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
new file mode 100644
index 000000000000..38f3cced0fd0
--- /dev/null
+++ b/arch/riscv/include/asm/archrandom.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel interface for the RISCV arch_random_* functions
+ *
+ * Copyright (c) 2023 by Rivos Inc.
+ *
+ */
+
+#ifndef ASM_RISCV_ARCHRANDOM_H
+#define ASM_RISCV_ARCHRANDOM_H
+
+#include <asm/csr.h>
+
+#define SEED_RETRY_LOOPS 100
+
+static inline bool __must_check csr_seed_long(unsigned long *v)
+{
+	unsigned int retry = SEED_RETRY_LOOPS, valid_seeds = 0;
+	const int needed_seeds = sizeof(long) / sizeof(u16);
+	u16 *entropy = (u16 *)v;
+
+	do {
+		/*
+		 * The SEED CSR (0x015) must be accessed with a read-write
+		 * instruction.
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
+			pr_err_once("archrandom: Unrecoverable error\n");
+			return false;
+
+		case SEED_OPST_BIST:
+		case SEED_OPST_WAIT:
+		default:
+			continue;
+		}
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
+	if (!max_longs)
+		return 0;
+
+	/*
+	 * If Zkr is supported and csr_seed_long succeeds, we return one long
+	 * worth of entropy.
+	 */
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))
+		return 1;
+
+	return 0;
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

