Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB45E8901
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiIXHRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiIXHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:17:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5A138F3D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD7A7B80DB0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F5FC433C1;
        Sat, 24 Sep 2022 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664003823;
        bh=W/lbTX+WSgjuWQqS2TBfREhcV1CmEhSyDNWcK2dsrV0=;
        h=From:To:Cc:Subject:Date:From;
        b=Icur9l9vILk2f7uLKspBUUJa1PlzMCC26Ge+bRyZ06dlIxqari4DMCqbqzr0f9Frb
         aZimyN64e/CQlRXiwGOWfZqZZNkLmHzLe64LhVnLlsaZDzqmlDqBw/eygIYx98eEis
         Hc2t5fZh3CUQCu5JzOKgMp3uj2CUUjHXtgTiY3Ajx+rI4Kbh82in5kLRf7Z7Q0yl2j
         DenThKWYNz1HJ37agGRFM22O1aoPsqYV2Z3zA+OX7Fif8vsE6fj/xWtw+118Yfm/fd
         ISUWdqvofVCNEnF91y6PDu1xIoXb/GhHQXWyJuAFioJJ8Ulc4s0bJlHf09MmF7MJc/
         41ek/pHvnz8XA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v3] riscv: vdso: fix NULL deference in vdso_join_timens() when vfork
Date:   Sat, 24 Sep 2022 15:07:37 +0800
Message-Id: <20220924070737.3048-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing tools/testing/selftests/timens/vfork_exec.c got below
kernel log:

[    6.838454] Unable to handle kernel access to user memory without uaccess routines at virtual address 0000000000000020
[    6.842255] Oops [#1]
[    6.842871] Modules linked in:
[    6.844249] CPU: 1 PID: 64 Comm: vfork_exec Not tainted 6.0.0-rc3-rt15+ #8
[    6.845861] Hardware name: riscv-virtio,qemu (DT)
[    6.848009] epc : vdso_join_timens+0xd2/0x110
[    6.850097]  ra : vdso_join_timens+0xd2/0x110
[    6.851164] epc : ffffffff8000635c ra : ffffffff8000635c sp : ff6000000181fbf0
[    6.852562]  gp : ffffffff80cff648 tp : ff60000000fdb700 t0 : 3030303030303030
[    6.853852]  t1 : 0000000000000030 t2 : 3030303030303030 s0 : ff6000000181fc40
[    6.854984]  s1 : ff60000001e6c000 a0 : 0000000000000010 a1 : ffffffff8005654c
[    6.856221]  a2 : 00000000ffffefff a3 : 0000000000000000 a4 : 0000000000000000
[    6.858114]  a5 : 0000000000000000 a6 : 0000000000000008 a7 : 0000000000000038
[    6.859484]  s2 : ff60000001e6c068 s3 : ff6000000108abb0 s4 : 0000000000000000
[    6.860751]  s5 : 0000000000001000 s6 : ffffffff8089dc40 s7 : ffffffff8089dc38
[    6.862029]  s8 : ffffffff8089dc30 s9 : ff60000000fdbe38 s10: 000000000000005e
[    6.863304]  s11: ffffffff80cc3510 t3 : ffffffff80d1112f t4 : ffffffff80d1112f
[    6.864565]  t5 : ffffffff80d11130 t6 : ff6000000181fa00
[    6.865561] status: 0000000000000120 badaddr: 0000000000000020 cause: 000000000000000d
[    6.868046] [<ffffffff8008dc94>] timens_commit+0x38/0x11a
[    6.869089] [<ffffffff8008dde8>] timens_on_fork+0x72/0xb4
[    6.870055] [<ffffffff80190096>] begin_new_exec+0x3c6/0x9f0
[    6.871231] [<ffffffff801d826c>] load_elf_binary+0x628/0x1214
[    6.872304] [<ffffffff8018ee7a>] bprm_execve+0x1f2/0x4e4
[    6.873243] [<ffffffff8018f90c>] do_execveat_common+0x16e/0x1ee
[    6.874258] [<ffffffff8018f9c8>] sys_execve+0x3c/0x48
[    6.875162] [<ffffffff80003556>] ret_from_syscall+0x0/0x2
[    6.877484] ---[ end trace 0000000000000000 ]---

This is because the mm->context.vdso_info is NULL in vfork case. From
another side, mm->context.vdso_info either points to vdso info
for RV64 or vdso info for compat, there's no need to bloat riscv's
mm_context_t, we can handle the difference when setup the additional
page for vdso.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 3092eb456375 ("riscv: compat: vdso: Add setup additional pages implementation")
---
Hi Palmer,

I tried to keep the v2 origin idea w/ forward declaration, but the
result is stil larger than yours. So I reused your code and modify it
a bit -- move the forward declaration after struct __vdso_info
definition. I dunno how to handle this case so I added your
"Suggested-by", feel free to correct me.

since v2:
 - Per Palmer suggestion, keep the fixes smaller while leave the clean
   up to next development window.
 - add Suggested-by tag, in fact Palmer demostrates the code in email.

since v1:
 - add "Fixes" tag
 - fix build error when CONFIG_COMPAT is enabled.
---
 arch/riscv/include/asm/mmu.h |  1 -
 arch/riscv/kernel/vdso.c     | 13 ++++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index cedcf8ea3c76..0099dc116168 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -16,7 +16,6 @@ typedef struct {
 	atomic_long_t id;
 #endif
 	void *vdso;
-	void *vdso_info;
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..4abc9aebdfae 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -60,6 +60,11 @@ struct __vdso_info {
 	struct vm_special_mapping *cm;
 };
 
+static struct __vdso_info vdso_info;
+#ifdef CONFIG_COMPAT
+static struct __vdso_info compat_vdso_info;
+#endif
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *new_vma)
 {
@@ -114,15 +119,18 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm = task->mm;
 	struct vm_area_struct *vma;
-	struct __vdso_info *vdso_info = mm->context.vdso_info;
 
 	mmap_read_lock(mm);
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long size = vma->vm_end - vma->vm_start;
 
-		if (vma_is_special_mapping(vma, vdso_info->dm))
+		if (vma_is_special_mapping(vma, vdso_info.dm))
 			zap_page_range(vma, vma->vm_start, size);
+#ifdef CONFIG_COMPAT
+		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+			zap_page_range(vma, vma->vm_start, size);
+#endif
 	}
 
 	mmap_read_unlock(mm);
@@ -264,7 +272,6 @@ static int __setup_additional_pages(struct mm_struct *mm,
 
 	vdso_base += VVAR_SIZE;
 	mm->context.vdso = (void *)vdso_base;
-	mm->context.vdso_info = (void *)vdso_info;
 
 	ret =
 	   _install_special_mapping(mm, vdso_base, vdso_text_len,
-- 
2.34.1

