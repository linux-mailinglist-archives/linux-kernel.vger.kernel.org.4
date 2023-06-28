Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6774120F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF1NPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjF1NPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD82119
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e12db357so6180926f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687958107; x=1690550107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEDUaqobIEXKBJUJL2QuyVEVDAnOAPT+PycLhsHH0e4=;
        b=PzpxfbdG1hP8JaT6dGu5MFaJuWjRSgEZs4u66K6iR/KAiam4nJBUjYSvQ8TGXoy+4q
         v3msqKsXNd1yS7SRhQcy7ZL8ICOg8OxVsNenTnJDmuHHE8o0XnzV17PUmR1OaqTFJUHb
         l80kTHBXJUsESLmsFFexDiSxsOPxOGvvD/4t7V9fnRf0eAA+AtbX/IyAKiXIbpophLiG
         0Lu6napv/3ofoE5nfu0y1S7R6XrhGd53UBqqOr+9cYm+QU9rQa7eNEfhv3Vp08SLGuil
         o/frg8rQgA65BNf+0YiOOOUxHToVQf0mEehTnG/XL4E8vslfJFMrz5UYOTH2oNXNmBS+
         ODIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958107; x=1690550107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEDUaqobIEXKBJUJL2QuyVEVDAnOAPT+PycLhsHH0e4=;
        b=ejnmrpF/QIVYEFUO0g1qRV61u82mivXJTsMcFAdkSNFv2EHk9kJvMVOmlbgivGvFcg
         RgXsqnNwpZ7nrmzo5mWuzYk71FWm8kl8xn/HQDsr7ildGd133V1mgJmBoxClv34cTD3a
         gFfNG3uxGluMz8JN+5VyqxP1rJrunFubv0ehO48rA0sE6V8Azcr61aDjEIRNZ9fYaCtC
         Ll7qmrgkL1AMgOnMqwxHEmGRfSIq2fJ0myKui4JO03LfbDk0fQdsXrJWCDT6t0GPhOxb
         WEQq0MErmjHp02kiBNQpwpsv5si97+TpasMSiUyfvNzaZdDn2ra5LZcDgygzTRfh/hWa
         pwBw==
X-Gm-Message-State: ABy/qLabNaqBeJB8HBSLlWteRftMa3hUQjWgb7GeSCJgYOjX6vPW7xdj
        yzIlaOPxK9tLe7m985Wf3cJAvg==
X-Google-Smtp-Source: APBJJlFWGkJY32HwEpO3mKHGbpfiLr3WFCRee+GHsQt33NWy53Chldwzwg/XwfF9jbPeqO/4lWMJ8A==
X-Received: by 2002:adf:eb11:0:b0:314:122a:9fe0 with SMTP id s17-20020adfeb11000000b00314122a9fe0mr35636wrn.8.1687958107035;
        Wed, 28 Jun 2023 06:15:07 -0700 (PDT)
Received: from vermeer.tail79c99.ts.net ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000050b00b003110dc7f408sm13456946wrf.41.2023.06.28.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:15:06 -0700 (PDT)
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
Subject: [PATCH v2 3/3] RISC-V: Implement archrandom when Zkr is available
Date:   Wed, 28 Jun 2023 15:14:35 +0200
Message-ID: <20230628131442.3022772-4-sameo@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628131442.3022772-1-sameo@rivosinc.com>
References: <20230628131442.3022772-1-sameo@rivosinc.com>
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
 arch/riscv/include/asm/archrandom.h | 70 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h        |  9 ++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/riscv/include/asm/archrandom.h

diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
new file mode 100644
index 000000000000..8987cd0b891d
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
+#define SEED_RETRY_LOOPS 10
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

