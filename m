Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98DA69E80C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBUTJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBUTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:09:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5E2D15D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s5so6098039plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PlwZzP1OOkIe8VY/GWOoEev+10r3VEkS4WO6Gk8l2k=;
        b=QQBnZajvWt8L0J2op7Y8kbVD/inXT8jI1jPRtrAaF1l32CC/UmkDKZntxGEkxJT9A6
         RXUSdeohaBNYxrUQ0keb/sWyK7iBM1289G/b7aRD5jchfFz3o4/HGm4ySSqAa1DsvEwY
         IFoMRUFDU+aQ1bFAs+wWir3DnVgSR8eE5W6ixGdGxdQr+vORYiuR7OBS1iAFoNih8X56
         tYuBPx3j25tO75A0wH5LzIduopQFOwGLI4EMG+UU7vXPk6D9HoyAqtEgibBGTc90hnLk
         7IpYLiiJAU3s9OgqZJQa1VBtSf8nmzaZIld31oJqqb3L3Ph5b6DDIH+rsXj4ab3Uks2r
         0hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PlwZzP1OOkIe8VY/GWOoEev+10r3VEkS4WO6Gk8l2k=;
        b=kU4caqs4/XtPlIixKsKg5shViBFLNu2uNM6CIN1pEL5w0kxEi3vdo5xazo5Rgou7wd
         k9/ynSLDn8UPB5ZGNYxbrN2jeggnnGp1KwFKfnNabkuYICgjzH+21RePXmABUXld/y5G
         o0v5xD8b/gJv80lMwGPHEN8irUWBGK5vndI2YwUQyH6gbmr+8d0CFBnK6KD7I6odt4wS
         McX33kGH5EwdEIFWSsCwSc7T2NngpjqT93qLOBiuF/add+eiww9dVLigtkCG7SIudE79
         8L2ldbXYlSDhESd44cMONoPVlz15sYXvM5UiyYiWPmBV3FDT6A5A5K9o47ir5alob8o2
         DIqw==
X-Gm-Message-State: AO0yUKVC15AOPOcJ48gKzF2MhesEu4pVqqW2uaHxSGZI+KfT+5VlI/dl
        7KOP4wRhMrxoqhqAiEebB53tnQ==
X-Google-Smtp-Source: AK7set9Q85lvtHtrFPYHZWf/kOfD/8K3nKYkOZE+80ANPB1/PRLs2yUzrjgynto2OVVHbsuyXfrBAg==
X-Received: by 2002:a17:902:e886:b0:199:15bb:8316 with SMTP id w6-20020a170902e88600b0019915bb8316mr8643038plg.68.1677006561719;
        Tue, 21 Feb 2023 11:09:21 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0019602b2c00csm1583863pls.175.2023.02.21.11.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:09:21 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/7] RISC-V: Move struct riscv_cpuinfo to new header
Date:   Tue, 21 Feb 2023 11:08:52 -0800
Message-Id: <20230221190858.3159617-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221190858.3159617-1-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---

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

