Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A97687C75
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBBLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBBLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:41:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC78C405
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:41:44 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6xf20bBgznVBy;
        Thu,  2 Feb 2023 19:39:38 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 19:41:41 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Hui Wang <hw.huiwang@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Changbin Du <changbin.du@huawei.com>,
        Guo Ren <guoren@kernel.org>, Zong Li <zong.li@sifive.com>
Subject: [PATCH v4] riscv: patch: Fixup lockdep warning in stop_machine
Date:   Thu, 2 Feb 2023 19:41:16 +0800
Message-ID: <20230202114116.3695793-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task of ftrace_arch_code_modify(_post)_prepare() caller is
stop_machine, whose caller and work thread are of different tasks. The
lockdep checker needs the same task context, or it's wrong. That means
it's a bug here to use lockdep_assert_held because we don't guarantee
the same task context.

kernel/locking/lockdep.c:
int __lock_is_held(const struct lockdep_map *lock, int read)
{
        struct task_struct *curr = current;
        int i;

        for (i = 0; i < curr->lockdep_depth; i++) {
			^^^^^^^^^^^^^^^^^^^
                struct held_lock *hlock = curr->held_locks + i;
					  ^^^^^^^^^^^^^^^^
                if (match_held_lock(hlock, lock)) {
                        if (read == -1 || !!hlock->read == read)
                                return LOCK_STATE_HELD;

The __lock_is_held depends on current held_locks records; if
stop_machine makes the checker running on another task, that's wrong.

Here is the log:
[   15.761523] ------------[ cut here ]------------
[   15.762125] WARNING: CPU: 0 PID: 15 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x72/0x364
[   15.763258] Modules linked in:
[   15.764154] CPU: 0 PID: 15 Comm: migration/0 Not tainted 6.1.0-rc1-00014-g66924be85884-dirty #377
[   15.765339] Hardware name: riscv-virtio,qemu (DT)
[   15.765985] Stopper: multi_cpu_stop+0x0/0x192 <- stop_cpus.constprop.0+0x90/0xe2
[   15.766711] epc : patch_insn_write+0x72/0x364
[   15.767011]  ra : patch_insn_write+0x70/0x364
[   15.767276] epc : ffffffff8000721e ra : ffffffff8000721c sp : ff2000000067bca0
[   15.767622]  gp : ffffffff81603f90 tp : ff60000002432a00 t0 : 7300000000000000
[   15.767919]  t1 : 0000000000000000 t2 : 73695f6b636f6c5f s0 : ff2000000067bcf0
[   15.768238]  s1 : 0000000000000008 a0 : 0000000000000000 a1 : 0000000000000000
[   15.768537]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[   15.768837]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
[   15.769139]  s2 : ffffffff80009faa s3 : ff2000000067bd10 s4 : ffffffffffffffff
[   15.769447]  s5 : 0000000000000001 s6 : 0000000000000001 s7 : 0000000000000003
[   15.769740]  s8 : 0000000000000002 s9 : 0000000000000004 s10: 0000000000000003
[   15.770027]  s11: 0000000000000002 t3 : 0000000000000000 t4 : ffffffff819af097
[   15.770323]  t5 : ffffffff819af098 t6 : ff2000000067ba28
[   15.770574] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[   15.771102] [<ffffffff80007520>] patch_text_nosync+0x10/0x3a
[   15.771421] [<ffffffff80009c66>] ftrace_update_ftrace_func+0x74/0x10a
[   15.771704] [<ffffffff800fa17e>] ftrace_modify_all_code+0xb0/0x16c
[   15.771958] [<ffffffff800fa24c>] __ftrace_modify_code+0x12/0x1c
[   15.772196] [<ffffffff800e110e>] multi_cpu_stop+0x14a/0x192
[   15.772454] [<ffffffff800e0a34>] cpu_stopper_thread+0x96/0x14c
[   15.772699] [<ffffffff8003f4ea>] smpboot_thread_fn+0xf8/0x1cc
[   15.772945] [<ffffffff8003ac9c>] kthread+0xe2/0xf8
[   15.773160] [<ffffffff80003e98>] ret_from_exception+0x0/0x14
[   15.773471] ---[ end trace 0000000000000000 ]---

By the way, this also fixes the same issue for patch_text().

Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Zong Li <zong.li@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
Changes in v4:
 - preserve and update comments.

Changes in v3:
 - denote this also fixes function patch_text().

Changes in v2:
 - Rewrite commit log with lockdep explanation [Guo Ren]
 - Rebase on v6.1 [Guo Ren]

v1:
https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
---
 arch/riscv/kernel/ftrace.c |  5 ++---
 arch/riscv/kernel/patch.c  | 15 ++++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 2086f6585773..f73660e73822 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -126,9 +126,8 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 /*
  * This is called early on, and isn't wrapped by
  * ftrace_arch_code_modify_{prepare,post_process}() and therefor doesn't hold
- * text_mutex, which triggers a lockdep failure.  SMP isn't running so we could
- * just directly poke the text, but it's simpler to just take the lock
- * ourselves.
+ * text_mutex. SMP isn't running so we could just directly poke the text, but
+ * it's simpler to just take the lock ourselves.
  */
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 {
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 765004b60513..8eb243703efe 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -49,19 +49,20 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
+/*
+ * Before reaching here, it was expected to lock the text_mutex
+ * already, so we don't need to give another lock here and could
+ * ensure that it was safe between each cores. We do not add
+ * lockdep assertion here since it would trigger a false positive
+ * when called by stop_machine (The lockdep checker requires the
+ * same task context).
+ */
 static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
 
-	/*
-	 * Before reaching here, it was expected to lock the text_mutex
-	 * already, so we don't need to give another lock here and could
-	 * ensure that it was safe between each cores.
-	 */
-	lockdep_assert_held(&text_mutex);
-
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
 
-- 
2.25.1

