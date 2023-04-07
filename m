Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46B6DB6F0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjDGXLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDGXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:11:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8C7281
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:11:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m18so70084plx.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680909075; x=1683501075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qJSx8+ImAcMnjiqAry1hxSsn47JERJ47bfiyaja2dk=;
        b=FUJf4sHnWDSsfV8R5zEgAN5n2hSjTFeHRqKnxfMgpyHCH9bhi4rbwdc8iI/XpYGzEF
         tQ3bajD+Pt9tAK7Zs2c4YPLcKFkEOGPFZ6apeZX4HbpJ3eDwTQtJ4l9c+DtfDVcGeM9w
         LuMBubC2CD2p0879xsgii38Vc9YI5NJ6Yg53cHCQ3zI4GUJoFHP4+yEOnYLO4shEsKnm
         2DGZwNKITPMIcOeZAgMSxoorbTNWbrUUl7bgWGWiPZDqBtIEN7SszCDcOgQIOhuHAziL
         fF61wSaI/n2G1wrytVbuHdVWXSaabxJ1vjx5n1AStmUoOvFqqj2zfbTY7GlD4nCO78ie
         73jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909075; x=1683501075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qJSx8+ImAcMnjiqAry1hxSsn47JERJ47bfiyaja2dk=;
        b=fz90PiRHD24OU2tdQvBB4RTnGHZqxsT9nknlIokSkTgDAVxXJfiUx8hIdJzMNGVZ08
         NMb+X1VEZDxEceYfTbImniPg6M8W3qcAMXPQHhFf39FSGaETws527dHqainHYnJI1N8X
         l6IXQiEi/d+VclPmw11QU97yKYYVc65M6gOG2YDJ1SZ9FJST6xXWKNJ3RlWI25GEZCLW
         vRbqitmjvzvZpnjumpiUOyCqOVqT67YM6dH13q6DFfwlPfp1+0+ubPRfFhDKNmoDuMX/
         4tIxybgwT6XoI0MVj8Rs5+89nH05OpLV4UTPY9dkRsPDi3Xp/voNkcFrYGjd74LObnBv
         zj1A==
X-Gm-Message-State: AAQBX9dVbfrqo598ToQSo0pWPW0a4WyA6kzKoY94RzGkeOa1TPIKZmi0
        Q/UwE+ODE8e7PR4M7ZQiJL8Umg==
X-Google-Smtp-Source: AKy350YOI1JvTjyJnVhuHF0/GZe506qbmhTfWethAuEj8TDysJJtkcdLAPJ8nISY8Nvsa/qV1un2tA==
X-Received: by 2002:a17:90b:38c5:b0:23d:5196:eca8 with SMTP id nn5-20020a17090b38c500b0023d5196eca8mr4260918pjb.20.1680909074953;
        Fri, 07 Apr 2023 16:11:14 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm3361526pls.216.2023.04.07.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:11:14 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v6 1/6] RISC-V: Move struct riscv_cpuinfo to new header
Date:   Fri,  7 Apr 2023 16:10:58 -0700
Message-Id: <20230407231103.2622178-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407231103.2622178-1-evan@rivosinc.com>
References: <20230407231103.2622178-1-evan@rivosinc.com>
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
Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
---

(no changes since v5)

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

