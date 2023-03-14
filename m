Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A06B9E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCNSeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCNSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:34:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D51A660
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:33:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso1736958pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678818753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tga5shMHyjc0TB9sW2hC3q3qhXdH8jnVVmQsmewODbI=;
        b=fqdENcGiupBXLWJzcac75bZHKj70wOfrBAIlfGPvxgr7ssgFuE2Pf58C/qEZjdxlZw
         Dt4Fn4iy/JmCqs+dRf5tBs676FfzjpVWwNOBa/NduDczdGAGUHdLmd67xbvFLUOEyI35
         pSz5+LCMRdzzljXC068womITkk7ozLxH5T3+0JohxZIunhBOITQEGM7okiH0VW5lHSU3
         MPI4aaMN53SpTf6XUApffLj9DNn6W1WOxT6iPtwlA6vn8DlKpMIlY7PG7ACn5IYJl/Eb
         VF4hyc0UJFBJi+OLGqtpdE1C3TfFAYepbKoZXDLzzO7I/9BNf7dzlS7F7gGEhuESTwqn
         OWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tga5shMHyjc0TB9sW2hC3q3qhXdH8jnVVmQsmewODbI=;
        b=hUgz5Ez7i0B5Ns0zawzepAfivOsH/A+RId7bICXJjUXwJECNAMjdYxCWbt+yxB0HUg
         8ohO7+D+hkSWGY2F1HphoKRWLUASXfKK7PiEvo/gHDIKFOekbtIZTcRMgiMzOc7NCRx+
         GFc3B4JQRgb7w0SRUH2YcuzAXM/B/krA7W0WFIGrcPZAjAsSh70X9gmjYOKI0SbXDokR
         dtbXnhmzCfO2Q4SyGGYmagsQkVEk9ILBHtNcwh88A8oY3sV7Mm6Ifu8O1iuQW166bVQO
         Hf56iwAjHXPSxPOdXS/2kjGR5O8lZLYmq6/xF4cjkme1OL6s7pILti8Fkk/a+U9ethrs
         NSBQ==
X-Gm-Message-State: AO0yUKVv37q2l36oEwzeKL0j4ZHS4VHDxTVibDjoamWLxMP8m2ZpgtGt
        zK8bUN22cxLNOUZp48xEEGtpWQ==
X-Google-Smtp-Source: AK7set9v9zIkmYb9ikpU9Da6c1URJ3+lBxePQISeL3aEwed0jfmqNAFJLGyZD2Ib8PdTkZhgH0knog==
X-Received: by 2002:a17:902:facf:b0:19e:dc0e:1269 with SMTP id ld15-20020a170902facf00b0019edc0e1269mr55859plb.7.1678818752836;
        Tue, 14 Mar 2023 11:32:32 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id kn3-20020a170903078300b0019d397b0f18sm2072019plb.214.2023.03.14.11.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:32:32 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/6] RISC-V: Move struct riscv_cpuinfo to new header
Date:   Tue, 14 Mar 2023 11:32:15 -0700
Message-Id: <20230314183220.513101-2-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314183220.513101-1-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
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

(no changes since v3)

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

