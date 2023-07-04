Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961877473C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjGDOMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjGDOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:11:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE8FF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:11:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b87b9a8652so3779775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479907; x=1691071907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuTcFW+DQo5Mx+nRwuPd1unzmxWKunsazuyjaErlxZk=;
        b=NIi0ovTyku0azaEtW/PoaDIbjTtvXx9iGqBIWZyGJFx7jlmzPxLeWyWo4Z7Nvqe5GT
         PJ6J7AGKB2u7OCWCJCA2QnAKpKoG825dHzY44D/uGqudXs1r6VV6/L9nKs2skx7U2P/o
         GOkfg1mIAmkhd2xQfpF9HurFbZBkJKfIemOH3JcLYecUvwRQBT0xBrz1u7/UJAXGu/bL
         e/7Y9aDfDVkrW3qNx037QCRpPX/DugMi0ZVEgQYVB0kbjFXxoIDV9zCfdC3gYyG47X2h
         ZokJovqD2e6r8bypNTml+4wi0ALsby9mOCF7WN6cal2vXu3QsshKNoNX56BNB4T6nSqU
         JBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479907; x=1691071907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuTcFW+DQo5Mx+nRwuPd1unzmxWKunsazuyjaErlxZk=;
        b=LeK4a/MZu54R3bW7E5GtIU1axHqrvZgC4WTaSkuP1Q2KtETmJsJUguNloRCtwDpb41
         33rsS/V3QuMS4vA3W4mlZJDp/+CsLfiGbwvTpj5nQygrXxuXD9GBWJWmPHue45oz8GVn
         Hoc1dpkuw7MJU4jrv5zdiUbR+918w5wm2ROpn9UkZoOreX4SyHiCaXtOzdGeXugjLTs+
         ql9WZT6v/3UUiyOAPVXtsCTC93QCRsdrDI0kP+GytmUfE5vcSGAdvhtD9IH3obIyNJW0
         AK39jLP86iU7BzhIz7HBn+KODSLF9E/fRyoz+hdkl0ALNdX85ZT2ZKDz0RHvs6hmJySy
         crdw==
X-Gm-Message-State: ABy/qLbMR8X2DH2ulNPZh5wuGcZD0rqpkeRk7RQlDgE6ItqW1rUepJeO
        hQQYxPUSUjW/jtxly0yidWnxRw==
X-Google-Smtp-Source: APBJJlHMbxfzESqCVaJXPyMu3D8RPz7R0/e0tLfbYZwlMqUdJidHRdMR0LJoHlFFQnNAxcaIIBBZvg==
X-Received: by 2002:a17:902:b210:b0:1b1:9272:55e2 with SMTP id t16-20020a170902b21000b001b1927255e2mr13376436plr.3.1688479907657;
        Tue, 04 Jul 2023 07:11:47 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:11:47 -0700 (PDT)
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
Subject: [RFC V2 PATCH 7/9] riscv: report misaligned accesses emulation to hwprobe
Date:   Tue,  4 Jul 2023 16:09:22 +0200
Message-Id: <20230704140924.315594-8-cleger@rivosinc.com>
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

hwprobe provides a way to report if misaligned access are emulated. In
order to correctly populate that feature, if the SBI delegated us
misaligned access handling, then we can check if it actually traps when
doing a misaligned access. This can be checked using an exception table
entry which will actually be used when a misaligned access is done from
kernel mode.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  |  2 ++
 arch/riscv/kernel/setup.c            |  2 ++
 arch/riscv/kernel/traps_misaligned.c | 32 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 808d5403f2ac..7e968499db49 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -20,4 +20,6 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 DECLARE_PER_CPU(long, misaligned_access_speed);
 
+void __init misaligned_emulation_init(void);
+
 #endif
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..820a8158e4f7 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -23,6 +23,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
@@ -284,6 +285,7 @@ void __init setup_arch(char **cmdline_p)
 
 	init_resources();
 	sbi_init();
+	misaligned_emulation_init();
 
 #ifdef CONFIG_KASAN
 	kasan_init();
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 39ec6caa6234..243ef9314734 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -14,6 +14,8 @@
 #include <asm/ptrace.h>
 #include <asm/csr.h>
 #include <asm/entry-common.h>
+#include <asm/hwprobe.h>
+#include <asm/cpufeature.h>
 
 #define INSN_MATCH_LB			0x3
 #define INSN_MASK_LB			0x707f
@@ -441,3 +443,33 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	return 0;
 }
+
+void __init misaligned_emulation_init(void)
+{
+	int cpu;
+	unsigned long emulated = 1, tmp_var;
+
+	/* Temporarily disable unaligned accesses support so that we fixup the
+	 * exception for code below.
+	 */
+	unaligned_enabled = 0;
+
+	__asm__ __volatile__ (
+		"1:\n"
+		"	ld %[tmp], 1(%[ptr])\n"
+		"	li %[emulated], 0\n"
+		"2:\n"
+		_ASM_EXTABLE(1b, 2b)
+	: [emulated] "+r" (emulated), [tmp] "=r" (tmp_var)
+	: [ptr] "r" (&tmp_var)
+	: "memory" );
+
+	unaligned_enabled = 1;
+	if (!emulated)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu(misaligned_access_speed, cpu) =
+					RISCV_HWPROBE_MISALIGNED_EMULATED;
+	}
+}
-- 
2.40.1

