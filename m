Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE405EF297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiI2JrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiI2Jqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:46:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C79D01EA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:45:26 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdSzP6smwz1P6yq;
        Thu, 29 Sep 2022 17:41:05 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:23 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 17:45:22 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>, <Julia.Lawall@inria.fr>,
        <akpm@linux-foundation.org>, <andreyknvl@gmail.com>,
        <elver@google.com>, <wangkefeng.wang@huawei.com>,
        <zhouchengming@bytedance.com>, <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH 3/3] arm64: module/ftrace: Fix mcount-based ftrace initialization failure
Date:   Thu, 29 Sep 2022 17:41:34 +0800
Message-ID: <20220929094134.99512-4-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929094134.99512-1-lihuafei1@huawei.com>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a6253579977e ("arm64: ftrace: consistently handle PLTs.")
makes ftrace_make_nop() always validate the 'old' instruction that will
be replaced. However, in the mcount-based implementation,
ftrace_init_nop() also calls ftrace_make_nop() to do the initialization,
and the 'old' target address is MCOUNT_ADDR at this time. with
CONFIG_MODULE_PLT support, the distance between MCOUNT_ADDR and callsite
may exceed 128M, at which point ftrace_find_callable_addr() will fail
because it cannot find an available PLT.

We can reproduce this problem by forcing the module to alloc memory away
from the kernel:

  ftrace_test: loading out-of-tree module taints kernel.
  ftrace: no module PLT for _mcount
  ------------[ ftrace bug ]------------
  ftrace failed to modify
  [<ffff800029180014>] 0xffff800029180014
   actual:   44:00:00:94
  Initializing ftrace call sites
  ftrace record flags: 2000000
   (0)
   expected tramp: ffff80000802eb3c
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 157 at kernel/trace/ftrace.c:2120 ftrace_bug+0x94/0x270
  Modules linked in:
  CPU: 3 PID: 157 Comm: insmod Tainted: G           O       6.0.0-rc6-00151-gcd722513a189-dirty #22
  Hardware name: linux,dummy-virt (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : ftrace_bug+0x94/0x270
  lr : ftrace_bug+0x21c/0x270
  sp : ffff80000b2bbaf0
  x29: ffff80000b2bbaf0 x28: 0000000000000000 x27: ffff0000c4d38000
  x26: 0000000000000001 x25: ffff800009d7e000 x24: ffff0000c4d86e00
  x23: 0000000002000000 x22: ffff80000a62b000 x21: ffff8000098ebea8
  x20: ffff0000c4d38000 x19: ffff80000aa24158 x18: ffffffffffffffff
  x17: 0000000000000000 x16: 0a0d2d2d2d2d2d2d x15: ffff800009aa9118
  x14: 0000000000000000 x13: 6333626532303830 x12: 3030303866666666
  x11: 203a706d61727420 x10: 6465746365707865 x9 : 3362653230383030
  x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : 000000000000bff4
  x5 : 0000000000057fa8 x4 : 0000000000000000 x3 : 0000000000000001
  x2 : ad2cb14bb5438900 x1 : 0000000000000000 x0 : 0000000000000022
  Call trace:
   ftrace_bug+0x94/0x270
   ftrace_process_locs+0x308/0x430
   ftrace_module_init+0x44/0x60
   load_module+0x15b4/0x1ce8
   __do_sys_init_module+0x1ec/0x238
   __arm64_sys_init_module+0x24/0x30
   invoke_syscall+0x54/0x118
   el0_svc_common.constprop.4+0x84/0x100
   do_el0_svc+0x3c/0xd0
   el0_svc+0x1c/0x50
   el0t_64_sync_handler+0x90/0xb8
   el0t_64_sync+0x15c/0x160
  ---[ end trace 0000000000000000 ]---
  ---------test_init-----------

In fact, in .init.plt or .plt or both of them, we have the mcount PLT.
If we save the mcount PLT entry address, we can determine what the 'old'
instruction should be when initializing the nop instruction.

Fixes: a6253579977e ("arm64: ftrace: consistently handle PLTs.")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/arm64/include/asm/module.h |  7 +++++++
 arch/arm64/kernel/ftrace.c      | 29 ++++++++++++++++++++++++++++-
 arch/arm64/kernel/module-plts.c | 16 ++++++++++++++++
 arch/arm64/kernel/module.c      | 11 +++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 8096d30c5e39..943d37d66c10 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -20,6 +20,11 @@ struct mod_arch_specific {
 
 	/* for CONFIG_DYNAMIC_FTRACE */
 	struct plt_entry	*ftrace_trampolines;
+
+#if defined(CONFIG_DYNAMIC_FTRACE) && !defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+	struct plt_entry	*mcount_plt_init;
+	struct plt_entry	*mcount_plt;
+#endif
 };
 #endif
 
@@ -58,5 +63,7 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
 }
 
 struct plt_entry get_plt_entry(u64 dst, void *pc);
+struct plt_entry *find_plt_entry(struct module *mod, const Elf_Shdr *sechdrs,
+				 u64 dest, bool init_sec);
 
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index ea5dc7c90f46..a61f41fa8e73 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -77,6 +77,17 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 	return NULL;
 }
 
+static struct plt_entry *get_mcount_plt(struct module *mod, unsigned long addr,
+					unsigned long loc)
+{
+#if defined(CONFIG_ARM64_MODULE_PLTS) && !defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+	if (addr == MCOUNT_ADDR)
+		return !within_module_init(loc, mod) ? mod->arch.mcount_plt :
+						       mod->arch.mcount_plt_init;
+#endif
+	return NULL;
+}
+
 /*
  * Find the address the callsite must branch to in order to reach '*addr'.
  *
@@ -127,7 +138,22 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
+
 	plt = get_ftrace_plt(mod, *addr);
+	if (plt) {
+		*addr = (unsigned long)plt;
+		return true;
+	}
+
+	/*
+	 * For the mcount-based implementation, we might call from
+	 * ftrace_init_nop(), and '*addr' should be MCOUNT_ADDR. We have saved
+	 * the mcount PLT entry address, see module_set_mcount_plt(). So here
+	 * we can still find the appropriate PLT based on whether the 'pc' is
+	 * in the init section or core section to make the 'old' instructions
+	 * that need to be replaced.
+	 */
+	plt = get_mcount_plt(mod, *addr, pc);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
@@ -209,7 +235,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 #endif
 
 /*
- * Turn off the call to ftrace_caller() in instrumented function
+ * Turn off the call to ftrace_caller() in instrumented function, or initialize
+ * the _mcount call to nop.
  */
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 5a0a8f552a61..5e553a1bf2a8 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -70,6 +70,22 @@ static bool in_init(const struct module *mod, void *loc)
 	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
 }
 
+struct plt_entry *find_plt_entry(struct module *mod, const Elf_Shdr *sechdrs,
+				 u64 dest, bool init_sec)
+{
+	struct mod_plt_sec *pltsec = !init_sec ? &mod->arch.core :
+						 &mod->arch.init;
+	struct plt_entry *plts = (struct plt_entry *)sechdrs[pltsec->plt_shndx].sh_addr;
+	struct plt_entry plt = get_plt_entry(dest, &plt);
+	int i;
+
+	for (i = 0; i < pltsec->plt_num_entries; i++)
+		if (plt_entries_equal(&plt, &plts[i]))
+			return &plts[i];
+
+	return 0;
+}
+
 u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
 			  void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym)
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f2d4bb14bfab..9ed0909e2729 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -520,6 +520,15 @@ static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
 	return 0;
 }
 
+static void module_set_mcount_plt(const Elf_Shdr *sechdrs, struct module *mod)
+{
+#if defined(CONFIG_ARM64_MODULE_PLTS) && defined(CONFIG_DYNAMIC_FTRACE) && \
+	!defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+	mod->arch.mcount_plt_init = find_plt_entry(mod, sechdrs, MCOUNT_ADDR, true);
+	mod->arch.mcount_plt = find_plt_entry(mod, sechdrs, MCOUNT_ADDR, false);
+#endif
+}
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
@@ -529,5 +538,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (s)
 		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
 
+	module_set_mcount_plt(sechdrs, me);
+
 	return module_init_ftrace_plt(hdr, sechdrs, me);
 }
-- 
2.17.1

