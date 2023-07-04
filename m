Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10F37473BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGDOKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjGDOK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:10:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A803610A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:10:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b867f9198dso5148375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479826; x=1691071826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP9LYFgOAjVow+h4CXKR68tZiOwggsdorDJAE/dJK2A=;
        b=pYjDpVSeZeTuytuJLr3GPhFpEWF9LCgMQRXoR5oOr/k5mdYt8DhDctQQKJnZASFmgT
         kdKEH2cTcqEIpm5lw1W754SPdG5AQDTOMkq3e0mrGXsrWkcVKCZ8m3d1pSAweRrvK62G
         ow9UIJEAjMznprBt+XIWaUjHOlVl+3M7ENW9lTuORu4pRtjBbLyyxw3mInyMscFrHA1y
         4dqQWTl/CwSfDfTFBWHg7Hp9KR/AGkX3LAX24+MmF6Pydl1t0lxtVZyZ+qx1xLdQR/zO
         s0Sav4ta/c5+XMKQhfO1NqsLN+O8Nfh3Dn0EQNf66+zcWSUh5FVWnPvIzfkEeaK5X4++
         L1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479826; x=1691071826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP9LYFgOAjVow+h4CXKR68tZiOwggsdorDJAE/dJK2A=;
        b=S/kQey5vUj9nxcVmD84XuvKizKJJnxuovs1UEAQZ+rwCv8UkD2mvD9+rV8Rg5poci+
         y1L8+xbUz8jWnyFkzNc7LMQ+17c6CQi8rTh6LKlP0GNDNCDnTdcqBmrmUCmgi2gXWmV2
         /9p9YuCm5y6kBmFs58fWosZUxXxiHi2gy74sdfUAk3+9+wmH/54fRF2nO7YbnTcYN6B8
         CbYARFd1dRKZcyBRTSPsDlgJeE+fuaVvvxxqyQFL/oSGAw0U8xXg6uwbB3e47D1MjVDh
         M4WaZYeKZcgWU5baiu2mrNNmZYsuwo16IQ5Ri543OzavcUwU9Qwr3y56uy5GxrptRo7X
         ZAoA==
X-Gm-Message-State: ABy/qLaLwgKa1g10ebuF7ShElxaqFm7Nix94/S6ckSRxEYuqP8Uw4gdE
        D6hjxVH+PUiTFn5PKrUAt6jpmw==
X-Google-Smtp-Source: APBJJlHicEwS4uP/iuupus1vVIadXFyTj6jwkGefEbPWSlascGFaY876ZMt3mvzrTKvWDbF92RyLFg==
X-Received: by 2002:a17:902:ec88:b0:1a6:6bdb:b548 with SMTP id x8-20020a170902ec8800b001a66bdbb548mr13222771plg.1.1688479826153;
        Tue, 04 Jul 2023 07:10:26 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:10:25 -0700 (PDT)
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
Subject: [RFC V2 PATCH 2/9] riscv: avoid missing prototypes warning
Date:   Tue,  4 Jul 2023 16:09:17 +0200
Message-Id: <20230704140924.315594-3-cleger@rivosinc.com>
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

Declare handle_misaligned_store/load() functions in entry-common.h and
include that file in traps_misaligned.c file to avoid warnings.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/entry-common.h | 3 +++
 arch/riscv/kernel/traps.c             | 2 --
 arch/riscv/kernel/traps_misaligned.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 6e4dee49d84b..58e9e2976e1b 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -8,4 +8,7 @@
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
+int handle_misaligned_load(struct pt_regs *regs);
+int handle_misaligned_store(struct pt_regs *regs);
+
 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c258b78c925..7fcaf2fd27a1 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -155,8 +155,6 @@ DO_ERROR_INFO(do_trap_load_misaligned,
 DO_ERROR_INFO(do_trap_store_misaligned,
 	SIGBUS, BUS_ADRALN, "Oops - store (or AMO) address misaligned");
 #else
-int handle_misaligned_load(struct pt_regs *regs);
-int handle_misaligned_store(struct pt_regs *regs);
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e7bfb33089c1..0cccac4822a8 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/entry-common.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
-- 
2.40.1

