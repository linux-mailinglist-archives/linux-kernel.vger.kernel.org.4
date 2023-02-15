Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249BD6978E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjBOJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjBOJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:24:05 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0B522021
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:24:03 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxB9mxpOxj+98AAA--.2116S3;
        Wed, 15 Feb 2023 17:24:01 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb6upOxjWsczAA--.34752S5;
        Wed, 15 Feb 2023 17:24:01 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] LoongArch: ptrace: expose hardware breakpoints to debuggers
Date:   Wed, 15 Feb 2023 17:23:58 +0800
Message-Id: <20230215092358.30368-4-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230215092358.30368-1-zhangqing@loongson.cn>
References: <20230215092358.30368-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxjb6upOxjWsczAA--.34752S5
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3KryfWr1fZF48XryDJrykAFb_yoWktry3pF
        47C3yUtrWUtrZ2kr4ftws8Ar15Gw4IvrWxGrWfuw1Sya4jqrZ8K3W8Kr90vr4fC348ua4f
        Aa909w4Y9ayUX3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU4OzVUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement regset-based ptrace interface that exposes hardware
breakpoints to user-space debuggers to query and set instruction
and data breakpoints.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/uapi/asm/ptrace.h |   9 +
 arch/loongarch/kernel/ptrace.c           | 416 +++++++++++++++++++++++
 include/uapi/linux/elf.h                 |   2 +
 3 files changed, 427 insertions(+)

diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
index 46eb40932bb1..7ac4a0e44570 100644
--- a/arch/loongarch/include/uapi/asm/ptrace.h
+++ b/arch/loongarch/include/uapi/asm/ptrace.h
@@ -56,6 +56,15 @@ struct user_lasx_state {
 	uint64_t vregs[32*4];
 };
 
+struct user_watch_state {
+	uint16_t dbg_info;
+	struct {
+		uint64_t    addr;
+		uint64_t    mask;
+		uint32_t    ctrl;
+	}		dbg_regs[8];
+};
+
 #define PTRACE_SYSEMU			0x1f
 #define PTRACE_SYSEMU_SINGLESTEP	0x20
 
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 52a3ee4366f4..7b0ec3b29212 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/ptrace.h>
 #include <linux/regset.h>
 #include <linux/sched.h>
@@ -333,6 +334,399 @@ static int simd_set(struct task_struct *target,
 
 #endif /* CONFIG_CPU_HAS_LSX */
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+
+/*
+ * Handle hitting a HW-breakpoint.
+ */
+static void ptrace_hbptriggered(struct perf_event *bp,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	int i;
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+
+	for (i = 0; i < LOONGARCH_MAX_BRP; ++i)
+		if (current->thread.hbp_break[i] == bp)
+			break;
+
+	for (i = 0; i < LOONGARCH_MAX_WRP; ++i)
+		if (current->thread.hbp_watch[i] == bp)
+			break;
+
+	force_sig_ptrace_errno_trap(i, (void __user *)bkpt->address);
+}
+
+static struct perf_event *ptrace_hbp_get_event(unsigned int note_type,
+					       struct task_struct *tsk,
+					       unsigned long idx)
+{
+	struct perf_event *bp = ERR_PTR(-EINVAL);
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		if (idx >= LOONGARCH_MAX_BRP)
+			goto out;
+		idx = array_index_nospec(idx, LOONGARCH_MAX_BRP);
+		bp = tsk->thread.hbp_break[idx];
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		if (idx >= LOONGARCH_MAX_WRP)
+			goto out;
+		idx = array_index_nospec(idx, LOONGARCH_MAX_WRP);
+		bp = tsk->thread.hbp_watch[idx];
+		break;
+	}
+
+out:
+	return bp;
+}
+
+static int ptrace_hbp_set_event(unsigned int note_type,
+				struct task_struct *tsk,
+				unsigned long idx,
+				struct perf_event *bp)
+{
+	int err = -EINVAL;
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		if (idx >= LOONGARCH_MAX_BRP)
+			goto out;
+		idx = array_index_nospec(idx, LOONGARCH_MAX_BRP);
+		tsk->thread.hbp_break[idx] = bp;
+		err = 0;
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		if (idx >= LOONGARCH_MAX_WRP)
+			goto out;
+		idx = array_index_nospec(idx, LOONGARCH_MAX_WRP);
+		tsk->thread.hbp_watch[idx] = bp;
+		err = 0;
+		break;
+	}
+
+out:
+	return err;
+}
+
+static struct perf_event *ptrace_hbp_create(unsigned int note_type,
+					    struct task_struct *tsk,
+					    unsigned long idx)
+{
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	int err, type;
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		type = HW_BREAKPOINT_X;
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		type = HW_BREAKPOINT_RW;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	ptrace_breakpoint_init(&attr);
+
+	/*
+	 * Initialise fields to sane defaults
+	 * (i.e. values that will pass validation).
+	 */
+	attr.bp_addr	= 0;
+	attr.bp_len	= HW_BREAKPOINT_LEN_4;
+	attr.bp_type	= type;
+	attr.disabled	= 1;
+
+	bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL, tsk);
+	if (IS_ERR(bp))
+		return bp;
+
+	err = ptrace_hbp_set_event(note_type, tsk, idx, bp);
+	if (err)
+		return ERR_PTR(err);
+
+	return bp;
+}
+
+static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
+				     struct arch_hw_breakpoint_ctrl ctrl,
+				     struct perf_event_attr *attr)
+{
+	int err, len, type, offset;
+
+	err = arch_bp_generic_fields(ctrl, &len, &type, &offset);
+	if (err)
+		return err;
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		if ((type & HW_BREAKPOINT_X) != type)
+			return -EINVAL;
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		if ((type & HW_BREAKPOINT_RW) != type)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	attr->bp_len	= len;
+	attr->bp_type	= type;
+	attr->bp_addr	+= offset;
+
+	return 0;
+}
+
+static int ptrace_hbp_get_resource_info(unsigned int note_type, u16 *info)
+{
+	u8 num;
+	u16 reg = 0;
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		num = hw_breakpoint_slots(TYPE_INST);
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		num = hw_breakpoint_slots(TYPE_DATA);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg |= num;
+
+	*info = reg;
+	return 0;
+}
+
+static int ptrace_hbp_get_ctrl(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u32 *ctrl)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(note_type, tsk, idx);
+
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	*ctrl = bp ? encode_ctrl_reg(counter_arch_bp(bp)->ctrl) : 0;
+	return 0;
+}
+
+static int ptrace_hbp_get_mask(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 *mask)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(note_type, tsk, idx);
+
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	*mask = bp ? counter_arch_bp(bp)->mask : 0;
+	return 0;
+}
+
+static int ptrace_hbp_get_addr(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 *addr)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(note_type, tsk, idx);
+
+	if (IS_ERR(bp))
+		return PTR_ERR(bp);
+
+	*addr = bp ? counter_arch_bp(bp)->address : 0;
+	return 0;
+}
+
+static struct perf_event *ptrace_hbp_get_initialised_bp(unsigned int note_type,
+							struct task_struct *tsk,
+							unsigned long idx)
+{
+	struct perf_event *bp = ptrace_hbp_get_event(note_type, tsk, idx);
+
+	if (!bp)
+		bp = ptrace_hbp_create(note_type, tsk, idx);
+
+	return bp;
+}
+
+static int ptrace_hbp_set_ctrl(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u32 uctrl)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct arch_hw_breakpoint_ctrl ctrl;
+
+	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	decode_ctrl_reg(uctrl, &ctrl);
+	err = ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
+	if (err)
+		return err;
+
+	return modify_user_hw_breakpoint(bp, &attr);
+}
+
+static int ptrace_hbp_set_mask(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 mask)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	struct arch_hw_breakpoint *info;
+
+	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	info = counter_arch_bp(bp);
+	info->mask = mask;
+	err = modify_user_hw_breakpoint(bp, &attr);
+	return err;
+}
+
+static int ptrace_hbp_set_addr(unsigned int note_type,
+			       struct task_struct *tsk,
+			       unsigned long idx,
+			       u64 addr)
+{
+	int err;
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+
+	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
+	if (IS_ERR(bp)) {
+		err = PTR_ERR(bp);
+		return err;
+	}
+
+	attr = bp->attr;
+	attr.bp_addr = addr;
+	err = modify_user_hw_breakpoint(bp, &attr);
+	return err;
+}
+
+#define PTRACE_HBP_ADDR_SZ	sizeof(u64)
+#define PTRACE_HBP_MASK_SZ	sizeof(u64)
+#define PTRACE_HBP_CTRL_SZ	sizeof(u32)
+
+static int hw_break_get(struct task_struct *target,
+			const struct user_regset *regset,
+			struct membuf to)
+{
+	unsigned int note_type = regset->core_note_type;
+	int ret, idx = 0;
+	u16 info;
+	u32 ctrl;
+	u64 addr, mask;
+
+	/* Resource info */
+	ret = ptrace_hbp_get_resource_info(note_type, &info);
+	if (ret)
+		return ret;
+
+	membuf_write(&to, &info, sizeof(info));
+	/* (address, ctrl) registers */
+	while (to.left) {
+		ret = ptrace_hbp_get_addr(note_type, target, idx, &addr);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_get_mask(note_type, target, idx, &mask);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_get_ctrl(note_type, target, idx, &ctrl);
+		if (ret)
+			return ret;
+
+		membuf_store(&to, addr);
+		membuf_store(&to, mask);
+		membuf_store(&to, ctrl);
+		idx++;
+	}
+	return 0;
+}
+
+static int hw_break_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	unsigned int note_type = regset->core_note_type;
+	int ret, idx = 0, offset, limit;
+	u32 ctrl;
+	u64 addr, mask;
+
+	/* Resource info */
+	offset = offsetof(struct user_watch_state, dbg_regs);
+	user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, offset);
+
+	/* (address, ctrl) registers */
+	limit = regset->n * regset->size;
+	while (count && offset < limit) {
+		if (count < PTRACE_HBP_ADDR_SZ)
+			return -EINVAL;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
+					 offset, offset + PTRACE_HBP_ADDR_SZ);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
+		if (ret)
+			return ret;
+		offset += PTRACE_HBP_ADDR_SZ;
+
+		if (!count)
+			break;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &mask,
+					 offset, offset + PTRACE_HBP_ADDR_SZ);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_set_mask(note_type, target, idx, mask);
+		if (ret)
+			return ret;
+		offset += PTRACE_HBP_MASK_SZ;
+
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &mask,
+					 offset, offset + PTRACE_HBP_MASK_SZ);
+		if (ret)
+			return ret;
+
+		ret = ptrace_hbp_set_ctrl(note_type, target, idx, ctrl);
+		if (ret)
+			return ret;
+		offset += PTRACE_HBP_CTRL_SZ;
+		idx++;
+	}
+
+	return 0;
+}
+#endif
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -412,6 +806,10 @@ enum loongarch_regset {
 #ifdef CONFIG_CPU_HAS_LASX
 	REGSET_LASX,
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	REGSET_HW_BREAK,
+	REGSET_HW_WATCH,
+#endif
 };
 
 static const struct user_regset loongarch64_regsets[] = {
@@ -459,6 +857,24 @@ static const struct user_regset loongarch64_regsets[] = {
 		.set		= simd_set,
 	},
 #endif
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_HW_BREAK] = {
+		.core_note_type = NT_LOONGARCH_HW_BREAK,
+		.n = sizeof(struct user_watch_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+	[REGSET_HW_WATCH] = {
+		.core_note_type = NT_LOONGARCH_HW_WATCH,
+		.n = sizeof(struct user_watch_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.regset_get = hw_break_get,
+		.set = hw_break_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_loongarch64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 4c6a8fa5e7ed..3cf66946a0bb 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -444,6 +444,8 @@ typedef struct elf64_shdr {
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
 #define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
 #define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
+#define NT_LOONGARCH_HW_BREAK   0xa05   /* LoongArch hardware breakpoint registers */
+#define NT_LOONGARCH_HW_WATCH   0xa06   /* LoongArch hardware watchpoint registers */
 
 /* Note types with note name "GNU" */
 #define NT_GNU_PROPERTY_TYPE_0	5
-- 
2.36.0

