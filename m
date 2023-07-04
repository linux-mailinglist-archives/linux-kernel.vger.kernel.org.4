Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B927473B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGDOKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGDOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:10:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C7E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:10:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-656bc570a05so1191169b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688479810; x=1691071810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=x3kmJaGRhNFiyR+5vFpSXLIa9I/mlBp1FZIlHR7iUWNbemQ2AzC7VjP/ef5O2LNqQ3
         gmLryl1+KAIA1T/8iQaZh1jUujXJtzNWUcyyQzos3podLdmJ+n403ueH+A3QJfYo9CVd
         s9C6UM+TXW8lzy9VxwBaLgt8VTxzsRJtNmuP5YRH+hefRCko72ghRzzDDSeMNcZ4OjiZ
         B/Og/WST6QGTSeWZkH/DtF4t4sWbs6qCSyD25ztKlA5EqvqGMRI0/9Z2tBkifZkGVn2v
         XPsBHp77Icmh++/Rxhwpx4Vf3RNw9lTC7M7FZ7ooLktOPvGrBhqi95HJO+fqd3F63xtK
         N3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479810; x=1691071810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=eqNDcDx7RWBRREWwADUDZhVvCFU/VkRhRuj/gRWFAp72Mm+vIwfPlkme+6rJFpX59q
         LTlq1o41FYGT5NqCdS7M3mynm4mxdvKf09qKfflDSgJYrCIknMYlwvsowGnmHGFzF1tV
         8O8PsBTILOMuWBLHHv5X+wrnBus/i0EJuNCR5boWmD/8z3gncHDz5/jjaTsMxDZ2x4kb
         8Qppacij2063cDGTmBDeN3y0/n1pcFtnI94S1+mKCfX6gOIwnuwyRkdLyzB7pUXUFWgw
         YZDHabawwQfg1iNJfbromPp8cSW5/ha3Xwfk/JQKCTkHcaj2mr05KDiykn9j304uZm87
         Uhmg==
X-Gm-Message-State: AC+VfDxwDixkLH9wpydvPvrA04rXkx0fFoYKBbTRJz8bptXeGdMmX4TU
        KQFQ36okhmwm+LlVm+1EbXw3Tw==
X-Google-Smtp-Source: ACHHUZ61pGxqIwJDLzs0Ls4ahG6yCuywecUKKdvw7/wiQX3e1lNH2vE+lgotJfY9hRYQbqxpXQYWYA==
X-Received: by 2002:a05:6a20:8e19:b0:12d:77e:ba3 with SMTP id y25-20020a056a208e1900b0012d077e0ba3mr19091770pzj.0.1688479809970;
        Tue, 04 Jul 2023 07:10:09 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:ef7b:e0f7:d376:e859])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b042c0939fsm17183735pls.99.2023.07.04.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:10:09 -0700 (PDT)
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
Subject: [RFC V2 PATCH 1/9] riscv: remove unused functions in traps_misaligned.c
Date:   Tue,  4 Jul 2023 16:09:16 +0200
Message-Id: <20230704140924.315594-2-cleger@rivosinc.com>
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

Replace macros by the only two function calls that are done from this
file, store_u8() and load_u8().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 46 +++++-----------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 378f5b151443..e7bfb33089c1 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -151,51 +151,19 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-#define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
-static inline type load_##type(const type *addr)			\
-{									\
-	type val;							\
-	asm (#insn " %0, %1"						\
-	: "=&r" (val) : "m" (*addr));					\
-	return val;							\
-}
+static inline u8 load_u8(const u8 *addr)
+{
+	u8 val;
 
-#define DECLARE_UNPRIVILEGED_STORE_FUNCTION(type, insn)			\
-static inline void store_##type(type *addr, type val)			\
-{									\
-	asm volatile (#insn " %0, %1\n"					\
-	: : "r" (val), "m" (*addr));					\
-}
+	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
 
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u8, lbu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u16, lhu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s8, lb)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s16, lh)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s32, lw)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u8, sb)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u16, sh)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u32, sw)
-#if defined(CONFIG_64BIT)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lwu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u64, ld)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u64, sd)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, ld)
-#else
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lw)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, lw)
-
-static inline u64 load_u64(const u64 *addr)
-{
-	return load_u32((u32 *)addr)
-		+ ((u64)load_u32((u32 *)addr + 1) << 32);
+	return val;
 }
 
-static inline void store_u64(u64 *addr, u64 val)
+static inline void store_u8(u8 *addr, u8 val)
 {
-	store_u32((u32 *)addr, val);
-	store_u32((u32 *)addr + 1, val >> 32);
+	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
 }
-#endif
 
 static inline ulong get_insn(ulong mepc)
 {
-- 
2.40.1

