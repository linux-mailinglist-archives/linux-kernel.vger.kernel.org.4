Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F1669B27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjAMO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjAMO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E804D71D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:46:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A64E3B82163
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C6C433F0;
        Fri, 13 Jan 2023 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673621171;
        bh=bhJdLBWsY2gx6AsQzO84a64x8hRuQO6VoHRS+yuhugs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s37cdjjiAP/akoDJK2wu0NF7+p/MLPgPilAOkQTl+i/26fR21U3j0u4aKsZL+s1U+
         czJZcY5v1zBI/cqW0bFJNLzjJ+nOCmfckeL8rrNQ3S1J5PUqeJyaaNbgbk71Qjrmdw
         CpNX5CO6T0GYLQ+eYb+QcxTHQ7FAEN90OcMJW53TJu5bLBkZ7Rxw3VU9//BQspNulY
         ht+TGdlf2bXTK8y/MYUahtdXNXvvC9L2BP+Tywak1rV66cpn07VviJsJDQFsar3f6y
         8wOvJSvKodf9J5WfZeBzjbFmjGRnOhjA6OD9582g3fSElauRNthEBQi6IkpzsZSvWG
         aBZUEvY6qE3aA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Add "Code:" to RISC-V splats
Date:   Fri, 13 Jan 2023 15:45:51 +0100
Message-Id: <20230113144552.138081-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113144552.138081-1-bjorn@kernel.org>
References: <20230113144552.138081-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Add "Code:" output to RISC-V splats. Mimic x86-64's byte-for-byte
dumps.

An example:
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Oops [#1]
  Modules linked in:
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-00063-g0ce8b1377b2b-dirty #3
  Hardware name: riscv-virtio,qemu (DT)
  epc : kernel_init+0xc8/0x10e
   ra : kernel_init+0x70/0x10e
  epc : ffffffff80bd9938 ra : ffffffff80bd98e0 sp : ff2000000060bec0
   gp : ffffffff81730b28 tp : ff6000007ff00000 t0 : 7974697275636573
   t1 : 0000000000000000 t2 : 3030303270393d6e s0 : ff2000000060bee0
   s1 : ffffffff81732028 a0 : 0000000000000000 a1 : ff6000008157e600
   a2 : 0000000000000002 a3 : ffffffff8176a470 a4 : 0000000000000000
   a5 : 000000000000000a a6 : 0000000000000118 a7 : ff6000008157e600
   s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
   s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
   s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
   s11: 0000000000000000 t3 : ffffffff81185ff0 t4 : 0000000000000022
   t5 : 000000000000003d t6 : 0000000000000000
  status: 0000000200000120 badaddr: 0000000000000000 cause: 000000000000000f
  [<ffffffff80003528>] ret_from_exception+0x0/0x16
  Code: 2a 86 79 d1 8c 60 17 a5 69 00 13 05 65 38 ef d0 2e db a9 47 <1c> c1 17 a5
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  SMP: stopping secondary CPUs
  ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 549bde5c970a..efadff4190e0 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -29,6 +29,33 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
+static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+{
+#define PROLOGUE_SIZE 20
+#define EPILOGUE_SIZE 3
+#define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
+	u8 opcodes[OPCODE_BUFSIZE];
+	unsigned long prologue = regs->epc - PROLOGUE_SIZE;
+
+	if (user_mode(regs))
+		return;
+
+	switch (copy_from_kernel_nofault(opcodes, (u8 *)prologue, sizeof(opcodes))) {
+	case 0:
+		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
+		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
+		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
+		break;
+	case -EPERM:
+		/* No access to the user space stack of other tasks. Ignore. */
+		break;
+	default:
+		printk("%sCode: Unable to access opcode bytes at 0x%lx.\n",
+		       loglvl, prologue);
+		break;
+	}
+}
+
 void die(struct pt_regs *regs, const char *str)
 {
 	static int die_counter;
@@ -43,8 +70,10 @@ void die(struct pt_regs *regs, const char *str)
 
 	pr_emerg("%s [#%d]\n", str, ++die_counter);
 	print_modules();
-	if (regs)
+	if (regs) {
 		show_regs(regs);
+		dump_kernel_instr(KERN_EMERG, regs);
+	}
 
 	cause = regs ? regs->cause : -1;
 	ret = notify_die(DIE_OOPS, str, regs, 0, cause, SIGSEGV);
-- 
2.37.2

