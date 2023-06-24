Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DB573CACE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjFXMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjFXMU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:20:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11D2129
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa86011753so602215e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609257; x=1690201257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=VAuIn5wmrft6ouJxQrKuyMshqzgPOFFMp3cLYRFjWEUWrbZGQ8XF6H1vCQtgoU+hFS
         DET3mgt3Dg75nvp7UHdGyH9gK5rjRBBGEONXmIvNkoPxYNXpmfrrOEsKaCJl/VpxOS7y
         SRGO0kk8bcyZmm6CxiZeHT4I71gLxrXew6U2gDxOWngaFRQ39qoiOy/yJT+VCs+FkeBv
         TFBEBwlMTFvc7CtPyasehlUTiDNnv3sikuzPp3WmAq8F26uQLaJ9JNhdBJ4STrX8ycVJ
         oIkybPrQT52yhyJk6Qg2XMUNCBbalV8KdxJrm3tB4UUeLKmPAZ0h62NFyQMs+PF7U0Ng
         QPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609257; x=1690201257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQDAxN5g1vMcAJWLoIEgGtbs3vH3NsC3JS3eiLLd1tc=;
        b=TJXhZkBF37mnUbTNAGEVL0BqGaKl+I0ITV6GMVwkDQA28U9P3bYtY4RlrpChPBvqJH
         G/7PYxO5syMclWeRsKZDe1pZp4IggRu+W+Iiw5gICrRQJqn6iJyau1LiWzYHhSChPwot
         ody/sfaXqDjYHm8kATg+SGMcWrQZslAGQgeudc07J0C1+/JkV1uuLLtxjnSGeF2bdBvY
         mbLiIGCmtem1dnSK0430Hld9UQ77VNFzI4hoB4W8WxJWkuXUJ2rhNsbCWAFp1FHIsCdQ
         rgq1cMlnyzo7+4K3q9EYSR7LBleeND6LcRm8sEzE3voDj11w4h+usnTAhnmMLTGCTv4M
         IftA==
X-Gm-Message-State: AC+VfDxbxaxDI29m5MyV3ctYPC+tiu8Azqei9uYkRtkzUo6CYlWRN7Bm
        IfPNAJujJe8Scm6qfAZiu9EXqg==
X-Google-Smtp-Source: ACHHUZ40aNXF8GUQdKojrSBWRvtDelAZZelDb3OI5i9UIVBbqRPN27EP9AAhdB6gqYMhg9yBAApZVw==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr25057066wmh.3.1687609256330;
        Sat, 24 Jun 2023 05:20:56 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:20:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Stafford Horne <shorne@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/6] riscv: remove unused functions in traps_misaligned.c
Date:   Sat, 24 Jun 2023 14:20:44 +0200
Message-Id: <20230624122049.7886-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230624122049.7886-1-cleger@rivosinc.com>
References: <20230624122049.7886-1-cleger@rivosinc.com>
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

