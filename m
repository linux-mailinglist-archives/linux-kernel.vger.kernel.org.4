Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560946CAA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjC0QcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjC0QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:32:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE926BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13so8200253pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679934737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgq06+KbGbQ52Tcr41GFnnU7gGDLnmn/MKHrb/zsB6A=;
        b=7a1xdjg6ZAk+TLmtQSrhgtjf5MOB7t+IqWSR1MW5vYia586Lu2WUi3+hDs42tX1zSy
         aV4zbtXgvUz5zCcpwWfjK+aDGiXT3gVYSU0D37f8UpQEpWf+81ciqsoXo3/DPrqNAGbC
         LA0JP+W0vYgRYL8CEZk9G9gHZ/NIQpQtcCzOMwH9sjH/Y++9f7r60rcCU2kb2+AJ2OML
         +HQXIHf0GXXv6yZ3G02ay9mPUxSCdOSPbU4SJsg5k+9LepfiErsYr3xmTOe0zG8vQqrl
         guzf+TVZqD3qzoRcYVruOYI4QDfF1wn0weG5T/RioFAY6WAImCgLdqpqgOk7h4X2W7tl
         MckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgq06+KbGbQ52Tcr41GFnnU7gGDLnmn/MKHrb/zsB6A=;
        b=Oy1IdvU20PYzQa70XXONzy0nS7/P2BBJcEFUIw99xN4CFJ3PJX3A/DAswlktvU3jX7
         ZJbKnr18q9xhZb7wR7aWE6/fuUH3MUpNgBAX4YdTzcd85F0OZ59wx42M26bQtGT4kALB
         BpEXQpBHJ3oT55eS+a/dQk45sMLt4QNpqhyrOJQ78P0EdClgpzQbIX3gsRxH6PjGK2ps
         UhZ9VkJr5mXyzEH/sHR7oMczZ5BudaYzdvNCAA7pQVFeD1JEl72xeauT0JP579qjAnvn
         FR+rIU9/XBLfbGuQH2iSRI6Xw7CZXYN9nX5SCj19SBt2YtxAL2hWyxVj+W4jXAxld+LL
         HvgA==
X-Gm-Message-State: AAQBX9egPWw9Jtcb1ljFPuHZYuZadgJIL9QWsI4fcLUjdLueFdsYCNY/
        avMLcKLBcAA+uXvrBCz8SyA94g==
X-Google-Smtp-Source: AKy350Zudio1TyvHfzzITc+dUT3hT43EMyUo1f9sOd/vqofLTXeYeRHZcTD/12bHLw0Z1AYzTYfTrg==
X-Received: by 2002:a17:903:746:b0:1a0:44e7:59dc with SMTP id kl6-20020a170903074600b001a044e759dcmr11310228plb.40.1679934737000;
        Mon, 27 Mar 2023 09:32:17 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001a1faeac240sm8963524plb.186.2023.03.27.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:32:16 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v5 1/6] RISC-V: Move struct riscv_cpuinfo to new header
Date:   Mon, 27 Mar 2023 09:31:58 -0700
Message-Id: <20230327163203.2918455-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163203.2918455-1-evan@rivosinc.com>
References: <20230327163203.2918455-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---

Changes in v5:
 - Added tags

Changes in v3:
 - Updated copyright date in cpufeature.h
 - Fixed typo in cpufeature.h comment (Conor)

Changes in v2:
 - Factored the move of struct riscv_cpuinfo to its own header

 arch/riscv/include/asm/cpufeature.h | 21 +++++++++++++++++++++
 arch/riscv/kernel/cpu.c             |  8 ++------
 2 files changed, 23 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature.h

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
new file mode 100644
index 000000000000..66ebaae449c8
--- /dev/null
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022-2023 Rivos, Inc
+ */
+
+#ifndef _ASM_CPUFEATURE_H
+#define _ASM_CPUFEATURE_H
+
+/*
+ * These are probed via a device_initcall(), via either the SBI or directly
+ * from the corresponding CSRs.
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
index 8400f0cc9704..dafd0caa4f1d 100644
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

