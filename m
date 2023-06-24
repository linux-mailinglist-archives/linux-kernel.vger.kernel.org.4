Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA173CAD3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjFXMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjFXMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:21:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F54268C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3111f6551d7so429362f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687609264; x=1690201264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH8JAFU+k8uhqJtfQAQWAcCTeqzZxdaoJtc5uAAK8o4=;
        b=ih9THep4/PLcg79d8XyCVmDshSYavCmqoUjBG8qo21Y+yZfHTx+0uT2XQWB/HXkYOe
         EKBHn6KgCwYpZOeDR8y7wJI0tzkydSi/+xjKM70SM8NC4lpS6dj/fk8SybBL9u6z8O6b
         vN+7OkR8JjPC86p1D08ozTd9CICSnIpBRQEATak+DqmemQ5yPObs6Ho6kiiuA6JwUDYy
         OS5gW7u288JpTEV6Tjhp0tpL1XGN084+EdRlMqsqr3t/ogJGNMmeYCL4A6mXTQ3z/asS
         CiISJtZNmZpiNcsD3tXoPP5n9lCE9bM0MeZlrd1XLJTr9KASDo9x6damR/gLg0MCd0AG
         Jn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687609264; x=1690201264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH8JAFU+k8uhqJtfQAQWAcCTeqzZxdaoJtc5uAAK8o4=;
        b=C9sDOyKy2ycSpQfryq3748pbNf3Qp4UPIdiiNmvFix0WFTH3efktuI/izCfkvc0YNe
         3LBc+1ctryaE/+yAdKZfyFR36VJL/ZjY4W2eSyqDijsmnuCcw/Aoh2j4HNCrBK3Yeo1M
         vF5HWXVLKf4dwc+/lbSOuN/maIJnISB87ep2fabgVjo9eI5ANM9bBskPRVoSY8ppYt+Z
         6NBmYUVC/zToXXG+2dmuBt+cKnyQyTZkbjBsgQGpycnWnV5n/mfRGTsKE6nhIt8XNgxh
         hdWxdCpR670hNj/5Upr09NFjtiTivfmKe4eahXDah3acXA3sfKRMeyRujff4UQ7Y48pH
         z94g==
X-Gm-Message-State: AC+VfDwY6aelKUO19QU4RvpIy/OGxHFU3lOUcnbon7QeDBozFi3P+QBs
        HTpbntpSdjfDtHzNSRHwwrcMDw==
X-Google-Smtp-Source: ACHHUZ4/sQw+nU+u/j9srxKAfjdDjXZTYXcECdccA7helmryviefMAEAlSbykXAXiBWmOVjK3XV9Pg==
X-Received: by 2002:adf:ed83:0:b0:311:1a93:71ad with SMTP id c3-20020adfed83000000b003111a9371admr17688641wro.3.1687609264118;
        Sat, 24 Jun 2023 05:21:04 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y15-20020a7bcd8f000000b003f8f9ab6f30sm2058823wmj.20.2023.06.24.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 05:21:03 -0700 (PDT)
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
Subject: [RFC PATCH 6/6] riscv: add floating point insn support to misaligned access emulation
Date:   Sat, 24 Jun 2023 14:20:49 +0200
Message-Id: <20230624122049.7886-7-cleger@rivosinc.com>
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

This support is partially based of openSBI misaligned emulation floating
point instruction support. It provides support for the existing
floating point instructions (both for 32/64 bits as well as compressed
ones). Since floating point registers are not aprt of the pt_regs
struct, we need to modify them directly using some assembly. We also
dirty the pt_regs status in case we modify them to be sure context
switch will save them. With this support, Linux is on par with openSBI
support.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/fpu.S              | 118 ++++++++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c | 130 ++++++++++++++++++++++++++-
 2 files changed, 244 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
index dd2205473de7..27f2e35ce8c2 100644
--- a/arch/riscv/kernel/fpu.S
+++ b/arch/riscv/kernel/fpu.S
@@ -104,3 +104,121 @@ ENTRY(__fstate_restore)
 	csrc CSR_STATUS, t1
 	ret
 ENDPROC(__fstate_restore)
+
+
+#define get_f32(which) fmv.x.s a0, which; j 2f
+#define put_f32(which) fmv.s.x which, a1; j 2f
+#if __riscv_xlen == 64
+# define get_f64(which) fmv.x.d a0, which; j 2f
+# define put_f64(which) fmv.d.x which, a1; j 2f
+#else
+# define get_f64(which) fsd which, 0(a1); j 2f
+# define put_f64(which) fld which, 0(a1); j 2f
+#endif
+
+.macro fp_access_prologue
+	/*
+	 * Compute jump offset to store the correct FP register since we don't
+	 * have indirect FP register access
+	 */
+	sll t0, a0, 3
+	la t2, 1f
+	add t0, t0, t2
+	li t1, SR_FS
+	csrs CSR_STATUS, t1
+	jr t0
+1:
+.endm
+
+.macro fp_access_epilogue
+2:
+	csrc CSR_STATUS, t1
+	ret
+.endm
+
+#define fp_access_body(__access_func) \
+	__access_func(f0); \
+	__access_func(f1); \
+	__access_func(f2); \
+	__access_func(f3); \
+	__access_func(f4); \
+	__access_func(f5); \
+	__access_func(f6); \
+	__access_func(f7); \
+	__access_func(f8); \
+	__access_func(f9); \
+	__access_func(f10); \
+	__access_func(f11); \
+	__access_func(f12); \
+	__access_func(f13); \
+	__access_func(f14); \
+	__access_func(f15); \
+	__access_func(f16); \
+	__access_func(f17); \
+	__access_func(f18); \
+	__access_func(f19); \
+	__access_func(f20); \
+	__access_func(f21); \
+	__access_func(f22); \
+	__access_func(f23); \
+	__access_func(f24); \
+	__access_func(f25); \
+	__access_func(f26); \
+	__access_func(f27); \
+	__access_func(f28); \
+	__access_func(f29); \
+	__access_func(f30); \
+	__access_func(f31)
+
+
+/*
+ * Disable compressed instructions set to keep a constant offset between FP
+ * load/store/move instructions
+ */
+.option norvc
+/*
+ * put_f32_reg - Set a FP register from a register containing the value
+ * a0 = FP register index to be set
+ * a1 = value to be loaded in the FP register
+ */
+SYM_FUNC_START(put_f32_reg)
+	fp_access_prologue
+	fp_access_body(put_f32)
+	fp_access_epilogue
+SYM_FUNC_END(put_f32_reg)
+
+/*
+ * get_f32_reg - Get a FP register value and return it
+ * a0 = FP register index to be retrieved
+ */
+SYM_FUNC_START(get_f32_reg)
+	fp_access_prologue
+	fp_access_body(get_f32)
+	fp_access_epilogue
+SYM_FUNC_END(put_f32_reg)
+
+/*
+ * put_f64_reg - Set a 64 bits FP register from a value or a pointer.
+ * a0 = FP register index to be set
+ * a1 = value/pointer to be loaded in the FP register (when xlen == 32 bits, we
+ * load the value to a pointer).
+ */
+SYM_FUNC_START(put_f64_reg)
+	fp_access_prologue
+	fp_access_body(put_f64)
+	fp_access_epilogue
+SYM_FUNC_END(put_f64_reg)
+
+/*
+ * put_f64_reg - Get a 64 bits FP register value and returned it or store it to
+ *	 	 a pointer.
+ * a0 = FP register index to be retrieved
+ * a1 = If xlen == 32, pointer which should be loaded with the FP register value
+ *	or unused if xlen == 64. In which case the FP register value is returned
+ *	through a0
+ */
+SYM_FUNC_START(get_f64_reg)
+	fp_access_prologue
+	fp_access_body(get_f64)
+	fp_access_epilogue
+SYM_FUNC_END(get_f64_reg)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b828a0f3d4f7..0c02d6ef6a85 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -153,6 +153,93 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
+#ifdef CONFIG_FPU
+
+#define FP_GET_RD(insn)		(insn >> 7 & 0x1F)
+
+extern void put_f32_reg(unsigned long fp_reg, unsigned long value);
+
+static inline void set_f32_rd(unsigned long insn, struct pt_regs *regs,
+			      unsigned long val)
+{
+	unsigned long fp_reg = FP_GET_RD(insn);
+
+	put_f32_reg(fp_reg, val);
+	regs->status |= SR_FS_DIRTY;
+}
+
+extern void put_f64_reg(unsigned long fp_reg, unsigned long value);
+
+static inline void set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
+{
+	unsigned long fp_reg = FP_GET_RD(insn);
+	unsigned long value;
+
+#if __riscv_xlen == 32
+	value = (unsigned long) &val;
+#else
+	value = val;
+#endif
+	put_f64_reg(fp_reg, value);
+	regs->status |= SR_FS_DIRTY;
+}
+
+#if __riscv_xlen == 32
+extern void get_f64_reg(unsigned long fp_reg, u64 *value);
+
+static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
+		      struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	u64 val;
+
+	get_f64_reg(fp_reg, &val);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+#else
+
+extern unsigned long get_f64_reg(unsigned long fp_reg);
+
+static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	unsigned long val;
+
+	val = get_f64_reg(fp_reg);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+
+#endif
+
+#define GET_F64_RS2(insn, regs) (get_f64_rs(insn, 20, regs))
+#define GET_F64_RS2C(insn, regs) (get_f64_rs(insn, 2, regs))
+#define GET_F64_RS2S(insn, regs) (get_f64_rs(RVC_RS2S(insn), 0, regs))
+
+extern unsigned long get_f32_reg(unsigned long fp_reg);
+
+static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	unsigned long val;
+
+	val = get_f32_reg(fp_reg);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+
+#define GET_F32_RS2(insn, regs) (get_f32_rs(insn, 20, regs))
+#define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
+#define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
+
+#endif
+
 #ifdef CONFIG_RISCV_M_MODE
 static inline int load_u8(const u8 *addr, u8 *r_val)
 {
@@ -347,15 +434,21 @@ int handle_misaligned_load(struct pt_regs *regs)
 		return -1;
 	}
 
+	if (!IS_ENABLED(CONFIG_FPU) && fp)
+		return -1;
+
 	val.data_u64 = 0;
 	for (i = 0; i < len; i++) {
 		if (load_u8((void *)(addr + i), &val.data_bytes[i]))
 			return -1;
 	}
 
-	if (fp)
-		return -1;
-	SET_RD(insn, regs, val.data_ulong << shift >> shift);
+	if (!fp)
+		SET_RD(insn, regs, val.data_ulong << shift >> shift);
+	else if (len == 8)
+		set_f64_rd(insn, regs, val.data_u64);
+	else
+		set_f32_rd(insn, regs, val.data_ulong);
 
 	regs->epc = epc + INSN_LEN(insn);
 
@@ -368,7 +461,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr;
-	int i, len = 0;
+	int i, len = 0, fp = 0;
 
 	/*
 	 * When running in supervisor mode, we only handle misaligned accesses
@@ -394,6 +487,14 @@ int handle_misaligned_store(struct pt_regs *regs)
 	} else if ((insn & INSN_MASK_SD) == INSN_MATCH_SD) {
 		len = 8;
 #endif
+	} else if ((insn & INSN_MASK_FSD) == INSN_MATCH_FSD) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2(insn, regs);
+	} else if ((insn & INSN_MASK_FSW) == INSN_MATCH_FSW) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2(insn, regs);
 	} else if ((insn & INSN_MASK_SH) == INSN_MATCH_SH) {
 		len = 2;
 #if defined(CONFIG_64BIT)
@@ -412,11 +513,32 @@ int handle_misaligned_store(struct pt_regs *regs)
 		   ((insn >> SH_RD) & 0x1f)) {
 		len = 4;
 		val.data_ulong = GET_RS2C(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSD) == INSN_MATCH_C_FSD) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2S(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSDSP) == INSN_MATCH_C_FSDSP) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2C(insn, regs);
+#if !defined(CONFIG_64BIT)
+	} else if ((insn & INSN_MASK_C_FSW) == INSN_MATCH_C_FSW) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2S(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSWSP) == INSN_MATCH_C_FSWSP) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2C(insn, regs);
+#endif
 	} else {
 		regs->epc = epc;
 		return -1;
 	}
 
+	if (!IS_ENABLED(CONFIG_FPU) && fp)
+		return -1;
+
 	for (i = 0; i < len; i++) {
 		if (store_u8((void *)(addr + i), val.data_bytes[i]))
 			return -1;
-- 
2.40.1

