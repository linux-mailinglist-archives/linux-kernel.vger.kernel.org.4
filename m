Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19417473BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGDOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjGDOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:11:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1B5113
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:11:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b741fd0c5so321327a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479875; x=1691071875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxIfI7L8QtMZ5B4oD7tB4oC/oAl/mItJTbe2vhSQwvU=;
        b=Q0HCtGy+m+yqgXytqQhl/oK/eRqrAUZnmyhcGucvrKtV+vyH0fl6JF9MeLRXDOdikh
         kPD+LCMVMPGrvC9PK21P8R53FGTVvNsLJqEqSrZNgIL2c4Qy00fTOc7ZMXjo8TuWc/K8
         lnf7IimmS/UtfgM6Tvjl0MMcBjh0EmsM7LjhwDySn+LpOwCCGErHVJmOl8wYh5prwvUi
         xzfIJsrD6G0EJGc6a+GUHpRSdG15iOY51qIiQ/R5qosZ8nIO9Bs6/pTlva1ZQqaxUYck
         nP8AFGSPtsKDYQbqU6M+Wy+YpGcN0yNJQ9YSxw+hgmOGOhb8OyGBCe0sJXYtS0nMbjvL
         AvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479875; x=1691071875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxIfI7L8QtMZ5B4oD7tB4oC/oAl/mItJTbe2vhSQwvU=;
        b=BpLyfZwEqGiT6CXpRHxUviP+JIZy+KaBI8dxXypkUqV3L+t5fkh0QOBovYJEBu72Vu
         m5w1yO49Qa5i/xLh2F/jCJvVKNt4KGeMAPh203WN1NQyqRnfqQsthejFkYAreeEqSfSp
         PhMwMlQeVIcVYWO77pxNIVcZKaGkBU/liER5JCo820Q1Gb7JKYwQIhnRtWBPWMi5+m/n
         Z8gYAZ8qDo4S5ePuRYc88MSwWPK9Ld6EPqZYH7OsEbY7IKoIEYCCTknuuUHSuf/eNDUW
         9FNBLhgZOc51vRDR2qDUw6ZYjNCdHsBH5oS6KLZMOdlMaIT48Ci8MVQXgDUWifLVgvoq
         DsKg==
X-Gm-Message-State: ABy/qLZlSIXlEO2S6pw/BL4dOAc2riBC7e0+7BuCWBPKw9eCOTtHW/Yw
        R6tDl1U5kEuJslW/GfEOrk7flA==
X-Google-Smtp-Source: APBJJlHa+Mx7cFJFRV4cvt3iY38HAoWgJj0SrcNe9F1wszSRZftWoIzwW9Ulq7ysrP6tB0kmo0UcdA==
X-Received: by 2002:a17:903:28c7:b0:1b7:f3e6:5727 with SMTP id kv7-20020a17090328c700b001b7f3e65727mr13626965plb.2.1688479875116;
        Tue, 04 Jul 2023 07:11:15 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:11:14 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 PATCH 5/9] riscv: add support for sysctl unaligned_enabled control
Date:   Tue,  4 Jul 2023 16:09:20 +0200
Message-Id: <20230704140924.315594-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704140924.315594-1-cleger@rivosinc.com>
References: <20230704140924.315594-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sysctl tuning option allows the user to disable misaligned access
handling globally on the system. This will also be used by misaligned
detection code to temporarily disable misaligned access handling.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/Kconfig                   | 1 +
 arch/riscv/kernel/traps_misaligned.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c69572fbe613..99fd951def39 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -139,6 +139,7 @@ config RISCV
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
 	select SPARSE_IRQ
+	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 804f6c5e0e44..39ec6caa6234 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -287,6 +287,9 @@ union reg_data {
 	u64 data_u64;
 };
 
+/* sysctl hooks */
+int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
+
 int handle_misaligned_load(struct pt_regs *regs)
 {
 	union reg_data val;
@@ -297,6 +300,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+	if (!unaligned_enabled)
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
@@ -387,6 +393,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+	if (!unaligned_enabled)
+		return -1;
+
 	if (get_insn(regs, epc, &insn))
 		return -1;
 
-- 
2.40.1

