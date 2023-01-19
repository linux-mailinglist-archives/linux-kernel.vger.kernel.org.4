Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0036732F3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjASHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjASHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:50:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621812715
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CAA61B9D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD978C433F0;
        Thu, 19 Jan 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674114491;
        bh=x+6hysZetLjXNJoPmPem8KkgdCayvnvdD0vD47hnXTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCKr7WQy84g91clObcCPN4ujLE8G6ryfwyrIb5kQIjfphSjUsiJwo8tCw/cjD6DMa
         bVtPv9K1Gig0mN0oAsG2pyKregWutfWQ37Hx4kc3B95uR0V/nTMMJU6VkcnluddWi7
         oXpAwRGF5pQnalavt9hFymGUXIwrnDHCdxCs1tYcuAZMLF98Mda1apRykl3jicBKA8
         cerShorkhdTiuHpSQCh/dO/yDv2KjkxGcMUN0V4YKB6tqaB4Er3hd3Nl6a2rkdp44T
         P6H6mED9rtxyyE9FBsrDmSpLN4hFGddeBxEKvwB0gn7ARk+aKnjWk1R9I4MrFwJz5S
         wjIykZaESbsjg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] riscv: Add instruction dump to RISC-V splats
Date:   Thu, 19 Jan 2023 08:47:37 +0100
Message-Id: <20230119074738.708301-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230119074738.708301-1-bjorn@kernel.org>
References: <20230119074738.708301-1-bjorn@kernel.org>
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

Add instruction dump (Code:) output to RISC-V splats. Dump 16b
parcels.

An example:
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Oops [#1]
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc3-00302-g840ff44c571d-dirty #27
  Hardware name: riscv-virtio,qemu (DT)
  epc : kernel_init+0xc8/0x10e
   ra : kernel_init+0x70/0x10e
  epc : ffffffff80bd9a40 ra : ffffffff80bd99e8 sp : ff2000000060bec0
   gp : ffffffff81730b28 tp : ff6000007ff00000 t0 : 7974697275636573
   t1 : 0000000000000000 t2 : 3030303270393d6e s0 : ff2000000060bee0
   s1 : ffffffff81732028 a0 : 0000000000000000 a1 : ff60000080dd1780
   a2 : 0000000000000002 a3 : ffffffff8176a470 a4 : 0000000000000000
   a5 : 000000000000000a a6 : 0000000000000081 a7 : ff60000080dd1780
   s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
   s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
   s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
   s11: 0000000000000000 t3 : ffffffff81186018 t4 : 0000000000000022
   t5 : 000000000000003d t6 : 0000000000000000
  status: 0000000200000120 badaddr: 0000000000000000 cause: 000000000000000f
  [<ffffffff80003528>] ret_from_exception+0x0/0x16
  Code: 862a d179 608c a517 0069 0513 2be5 d0ef db2e 47a9 (c11c) a517
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
  SMP: stopping secondary CPUs
  ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/kernel/traps.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 549bde5c970a..fbdcdbc792d3 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -29,6 +29,27 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
+static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+{
+	char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
+	const u16 *insns = (u16 *)instruction_pointer(regs);
+	long bad;
+	u16 val;
+	int i;
+
+	for (i = -10; i < 2; i++) {
+		bad = get_kernel_nofault(val, &insns[i]);
+		if (!bad) {
+			p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
+		} else {
+			printk("%sCode: Unable to access instruction at 0x%px.\n",
+			       loglvl, &insns[i]);
+			return;
+		}
+	}
+	printk("%sCode: %s\n", loglvl, str);
+}
+
 void die(struct pt_regs *regs, const char *str)
 {
 	static int die_counter;
@@ -43,8 +64,10 @@ void die(struct pt_regs *regs, const char *str)
 
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

