Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A09662AE47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKOW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiKOW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D93134B;
        Tue, 15 Nov 2022 14:26:22 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OYuXmQLawd51qKNr64PRZ39cGPqFXSgjC1iFxxF37c=;
        b=Xbj2KfyFJHZ/kRj76l3gofj0dRBxMvU32m51cSYfXOfvosHg1uyOmkRUyDmi8KLdAvboTj
        yK3hfgMrKKMXF753AuFx2vKA96WbDeMalPCq8LdBTnZD/vgBl4HvSP+WJQqQvZ4scdmkNv
        VC7gH6dil0QN1yF+aEFJlnV0gxhwCLwIpA3ZB4uwAyhRN4eQMJRqUVvAPvzqixfwIXlTBf
        63in4ykEVGjZD6AamK2axkemAqtj3Xu/y5V/tNtKUqThqqZYUAt87e84qBg4y+k6ylE5Ly
        LhmqFO7F296g1PHEY/bM9+NTj9cMGYa5mTNSykwxjZQOTNQ5bjmv/K/DejiiwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OYuXmQLawd51qKNr64PRZ39cGPqFXSgjC1iFxxF37c=;
        b=/lmT9rn3OneJKE2GxJBJNntMQLAhMjORcqw2mVdfQ2GSoJKRxZUzxMPyORohDt/FaV+JD7
        RhtmuADlbs/HbjBg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kasan: Populate shadow for shared chunk of the CPU
 entry area
Cc:     syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com,
        Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-6-seanjc@google.com>
References: <20221110203504.1985010-6-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <166855117928.4906.1007702732315268156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f2089aa0cd8e52564240a93ea1e4bb643c0ed34c
Gitweb:        https://git.kernel.org/tip/f2089aa0cd8e52564240a93ea1e4bb643c0ed34c
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:04 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:30:00 +01:00

x86/kasan: Populate shadow for shared chunk of the CPU entry area

Popuplate the shadow for the shared portion of the CPU entry area, i.e.
the read-only IDT mapping, during KASAN initialization.  A recent change
modified KASAN to map the per-CPU areas on-demand, but forgot to keep a
shadow for the common area that is shared amongst all CPUs.

Map the common area in KASAN init instead of letting idt_map_in_cea() do
the dirty work so that it Just Works in the unlikely event more shared
data is shoved into the CPU entry area.

The bug manifests as a not-present #PF when software attempts to lookup
an IDT entry, e.g. when KVM is handling IRQs on Intel CPUs (KVM performs
direct CALL to the IRQ handler to avoid the overhead of INTn):

 BUG: unable to handle page fault for address: fffffbc0000001d8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 16c03a067 P4D 16c03a067 PUD 0
 Oops: 0000 [#1] PREEMPT SMP KASAN
 CPU: 5 PID: 901 Comm: repro Tainted: G        W          6.1.0-rc3+ #410
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:kasan_check_range+0xdf/0x190
  vmx_handle_exit_irqoff+0x152/0x290 [kvm_intel]
  vcpu_run+0x1d89/0x2bd0 [kvm]
  kvm_arch_vcpu_ioctl_run+0x3ce/0xa70 [kvm]
  kvm_vcpu_ioctl+0x349/0x900 [kvm]
  __x64_sys_ioctl+0xb8/0xf0
  do_syscall_64+0x2b/0x50
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Reported-by: syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110203504.1985010-6-seanjc@google.com
---
 arch/x86/mm/kasan_init_64.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index afc5e12..0302491 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -341,7 +341,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 
 void __init kasan_init(void)
 {
-	unsigned long shadow_cea_begin, shadow_cea_end;
+	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
@@ -384,6 +384,7 @@ void __init kasan_init(void)
 	}
 
 	shadow_cea_begin = kasan_mem_to_shadow_align_down(CPU_ENTRY_AREA_BASE);
+	shadow_cea_per_cpu_begin = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_PER_CPU);
 	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
 						      CPU_ENTRY_AREA_MAP_SIZE);
 
@@ -409,6 +410,15 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
 		(void *)shadow_cea_begin);
 
+	/*
+	 * Populate the shadow for the shared portion of the CPU entry area.
+	 * Shadows for the per-CPU areas are mapped on-demand, as each CPU's
+	 * area is randomly placed somewhere in the 512GiB range and mapping
+	 * the entire 512GiB range is prohibitively expensive.
+	 */
+	kasan_populate_shadow(shadow_cea_begin,
+			      shadow_cea_per_cpu_begin, 0);
+
 	kasan_populate_early_shadow((void *)shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
