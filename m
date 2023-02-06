Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5268C75C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBFUP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBFUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:15:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15829E20
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:15:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so9571286pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3E7gTy1SZ/rYCbfPiq6VlVdMXLKt386NsSmOIvpWA4=;
        b=d7Hb5NLdauK+98+KYLb/5jnKRBJ18m6p1tGFFJIg+5BAzF9yTJrYEN83GG6vZFh36v
         yr6yVgcyJ0S3/UU5WvW8M1/P37bmvL4Qp6ruOAw+JCf/J5yfqQXc+gcdzmQMVDGFrTIX
         ajvfH5AbA9VwC8DX/Tz8SjG+NMTj4W8ZCQyWa0DERSaTTLttMrQ+n4U267it20SgXkDw
         miF94exCJq5BxV7x6FTNeEfXwfzPfrQWoY+YdVLwg5nN9N7XnIOJR77DL4AomYm4z3Hn
         SPOD+nriiYYT8z1W9e5yUDnA6YrYR7vt0joB6qLOww83G9Z7FYGE8w7rRbAvB21rawh5
         A4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3E7gTy1SZ/rYCbfPiq6VlVdMXLKt386NsSmOIvpWA4=;
        b=pJ2bO/9NDm2Amh2WCbtce5NK40nT8BZoQ8PtKKGulGC2FazAnusT2zYHwMH+TkT4BK
         9pkpJwTlzpx5AzI7xtlShnaDweZ4Djwc3TVi5Y4dLDZz0IxS1/byrdtnSq1I+NSumec+
         qsKmyagx4T0KvejnNZkwHVI5rmnzmTTHkezSt0Z7e5VzJHuwH/8VwjZwh7TEpdDxaz9S
         87eFldq5ShDwAFpA8H2hZGmmkPdzL/0kLhiWG06YIvghCRPkjzNpnZAoWjdsh74naxfw
         D6fM5vs9sqf4ebgcVIOi3sqNu1ruwJtkaSr3EsyNgqTnb8HhQ944SZYi+srcTotcfFN3
         l/ng==
X-Gm-Message-State: AO0yUKUsPT+50DF2TcDVpW+wREQlNHQ4frM5aDVdPjHHnaYqzB2wnYbY
        78wDjNuSKvuqy9J5tgGQ9pBwNw==
X-Google-Smtp-Source: AK7set89wInCODEUg3p17p5zHU1W/mDyBIfYFOL5qrDCXusDtTme4YBO8NalJNVzABW6CNbgFZA8XQ==
X-Received: by 2002:a05:6a20:8421:b0:bf:bcfb:1fc2 with SMTP id c33-20020a056a20842100b000bfbcfb1fc2mr884580pzd.45.1675714521714;
        Mon, 06 Feb 2023 12:15:21 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ab4a000000b004df4fbb9823sm6425079pgp.68.2023.02.06.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:15:21 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/6] RISC-V: Move struct riscv_cpuinfo to new header
Date:   Mon,  6 Feb 2023 12:14:50 -0800
Message-Id: <20230206201455.1790329-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for tracking and exposing microarchitectural details to
userspace (like whether or not unaligned accesses are fast), move the
riscv_cpuinfo struct out to its own new cpufeatures.h header. It will
need to be used by more than just cpu.c.

Signed-off-by: Evan Green <evan@rivosinc.com>
---

(no changes since v1)

 arch/riscv/include/asm/cpufeature.h | 21 +++++++++++++++++++++
 arch/riscv/kernel/cpu.c             |  8 ++------
 2 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature.h

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
new file mode 100644
index 000000000000..66c251d98290
--- /dev/null
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022 Rivos, Inc
+ */
+
+#ifndef _ASM_CPUFEATURE_H
+#define _ASM_CPUFEATURE_H
+
+/*
+ * These are probed via a device_initcall(), via either the SBI or directly
+ * from the cooresponding CSRs.
+ */
+struct riscv_cpuinfo {
+	unsigned long mvendorid;
+	unsigned long marchid;
+	unsigned long mimpid;
+};
+
+DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
+
+#endif
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..684e5419d37d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
 #include <asm/sbi.h>
@@ -70,12 +71,7 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
-struct riscv_cpuinfo {
-	unsigned long mvendorid;
-	unsigned long marchid;
-	unsigned long mimpid;
-};
-static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
+DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
 {
-- 
2.25.1

