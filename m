Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CB5FA007
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJJOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:16:50 -0400
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D262BE0F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:16:47 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 004F1C0F57
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:16:45 +0100 (IST)
Received: (qmail 20666 invoked from network); 10 Oct 2022 14:16:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Oct 2022 14:16:45 -0000
Date:   Mon, 10 Oct 2022 15:16:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Intermittent boot failure after 6492fed7d8c9 (v6.0-rc1)
Message-ID: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

I'm seeing intermittent boot failures after 6492fed7d8c9 ("rtc: rtc-cmos:
Do not check ACPI_FADT_LOW_POWER_S0") due to a NULL pointer exception
early in boot. It fails to boot 5 times after 10 boot attempts and I've
only observed it on one machine so far. Either a revert or the patch below
fixes it but it's unlikely it is the correct fix.

--- drivers/rtc/rtc-cmos.c.orig	2022-10-10 15:11:50.335756567 +0200
+++ drivers/rtc/rtc-cmos.c	2022-10-10 15:11:53.211756691 +0200
@@ -1209,7 +1209,7 @@
 	 * Or else, ACPI SCI is enabled during suspend/resume only,
 	 * update rtc irq in that case.
 	 */
-	if (cmos_use_acpi_alarm())
+	if (cmos_use_acpi_alarm() && cmos)
 		cmos_interrupt(0, (void *)cmos->rtc);
 	else {
 		/* Fix me: can we use cmos_interrupt() here as well? */

Boot failure looks like the below, it's not a vanilla kernel but the
applied patch is not relevant and it's known to fail on a vanilla kernel.
The machine has a E5-2698 v4 CPU plugged into a SGI C2112-4GP3 platform
with a X10DRT-P-Series motherboard.

[   10.924167][    C1] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   10.928016][    C1] #PF: supervisor read access in kernel mode
[   10.928016][    C1] #PF: error_code(0x0000) - not-present page
[   10.928016][    C1] PGD 0 P4D 0 
[   10.928016][    C1] Oops: 0000 [#1] PREEMPT SMP PTI
[   10.928016][    C1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-mm-pcpnoirq-v1r2 #1 6debc4647ebcbe3e91270f1109aebc1e85510e3e
[   10.928016][    C1] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
[   10.928016][    C1] RIP: 0010:rtc_handler+0x73/0xd0
[   10.928016][    C1] Code: df e8 41 62 f9 ff bf 04 00 00 00 e8 a3 bf e7 ff 31 f6 bf 04 00 00 00 e8 08 c2 e7 ff b8 01 00 00 00 5b 5d 41 5c c3 cc cc cc cc <48> 8b 75 00 31 ff e8 72 fe ff ff eb c0 bf 0b 00 00 00 e8 56 81 77
[   10.928016][    C1] RSP: 0000:ffffaf7f8003eec0 EFLAGS: 00010002
[   10.928016][    C1] RAX: ffffffffad6d0c00 RBX: ffff94049801a000 RCX: 0000000000000000
[   10.928016][    C1] RDX: 0000000000000040 RSI: ffffffffadf00460 RDI: ffff94049801a000
[   10.928016][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000004d0
[   10.928016][    C1] R10: 0000000000000000 R11: ffffaf7f8003eff8 R12: 0000000000000000
[   10.928016][    C1] R13: ffffffffae228d82 R14: 0000000000000004 R15: 0000000000000000
[   10.928016][    C1] FS:  0000000000000000(0000) GS:ffff94037ea80000(0000) knlGS:0000000000000000
[   10.928016][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.928016][    C1] CR2: 0000000000000000 CR3: 00000002c7e26001 CR4: 00000000003706e0
[   10.928016][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.928016][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.928016][    C1] Call Trace:
[   10.928016][    C1]  <IRQ>
[   10.928016][    C1]  acpi_ev_fixed_event_detect+0x14a/0x18c
[   10.928016][    C1]  acpi_ev_sci_xrupt_handler+0x2c/0x6e
[   10.928016][    C1]  acpi_irq+0x18/0x40
[   10.928016][    C1]  __handle_irq_event_percpu+0x3e/0x2d0
[   10.928016][    C1]  handle_irq_event_percpu+0xf/0x40
[   10.928016][    C1]  handle_irq_event+0x34/0x60
[   10.928016][    C1]  handle_fasteoi_irq+0x7b/0x140
[   10.928016][    C1]  __common_interrupt+0x4b/0x100
[   10.928016][    C1]  common_interrupt+0x58/0xa0
[   10.928016][    C1]  </IRQ>
[   10.928016][    C1]  <TASK>
[   10.928016][    C1]  asm_common_interrupt+0x22/0x40
[   10.928016][    C1] RIP: 0010:cmos_wake_setup.part.9+0x2f/0x120
[   10.928016][    C1] Code: 80 3d 65 16 4a 01 00 53 48 89 fb 0f 84 a5 00 00 00 48 89 da 48 c7 c6 00 0c 6d ad bf 04 00 00 00 e8 53 b8 e7 ff bf 04 00 00 00 <e8> 98 c6 e7 ff 31 f6 bf 04 00 00 00 e8 fd c8 e7 ff 0f b6 0d 34 ce
[   10.928016][    C1] RSP: 0000:ffffaf7f800d7ca8 EFLAGS: 00000246
[   10.928016][    C1] RAX: 0000000000000000 RBX: ffff94049801a000 RCX: 0000000000000004
[   10.928016][    C1] RDX: ffffffffadefef10 RSI: ffffffffadefee20 RDI: 0000000000000004
[   10.928016][    C1] RBP: ffffffffaeaf98a0 R08: 0000000000000000 R09: 0000000000000000
[   10.928016][    C1] R10: 0000000000000000 R11: 000000000000000a R12: ffffffffad6d1750
[   10.928016][    C1] R13: 0000000000000000 R14: ffff93c5111191a0 R15: ffffffffaefe47f8
[   10.928016][    C1]  ? rdinit_setup+0x2f/0x2f
[   10.928016][    C1]  ? cmos_do_probe+0x570/0x570
[   10.928016][    C1]  ? cmos_wake_setup.part.9+0x2a/0x120
[   10.928016][    C1]  cmos_pnp_probe+0x6c/0xa0
[   10.928016][    C1]  pnp_device_probe+0x5b/0xb0
[   10.928016][    C1]  ? driver_sysfs_add+0x75/0xe0
[   10.928016][    C1]  really_probe+0x109/0x3e0
[   10.928016][    C1]  ? pm_runtime_barrier+0x4f/0xa0
[   10.928016][    C1]  __driver_probe_device+0x79/0x170
[   10.928016][    C1]  driver_probe_device+0x1f/0xa0
[   10.928016][    C1]  __driver_attach+0x11e/0x180
[   10.928016][    C1]  ? __device_attach_driver+0x110/0x110
[   10.928016][    C1]  bus_for_each_dev+0x79/0xc0
[   10.928016][    C1]  bus_add_driver+0x1ba/0x250
[   10.928016][    C1]  ? rtc_dev_init+0x34/0x34
[   10.928016][    C1]  driver_register+0x5f/0x100
[   10.928016][    C1]  ? rtc_dev_init+0x34/0x34
[   10.928016][    C1]  cmos_init+0x12/0x70
[   10.928016][    C1]  do_one_initcall+0x5b/0x310
[   10.928016][    C1]  ? rcu_read_lock_held_common+0xe/0x50
[   10.928016][    C1]  ? rcu_read_lock_sched_held+0x23/0x80
[   10.928016][    C1]  kernel_init_freeable+0x2b7/0x319
[   10.928016][    C1]  ? rest_init+0x1b0/0x1b0
[   10.928016][    C1]  kernel_init+0x16/0x140
[   10.928016][    C1]  ret_from_fork+0x22/0x30
[   10.928016][    C1]  </TASK>
[   10.928016][    C1] Modules linked in:
[   10.928016][    C1] CR2: 0000000000000000
[   10.928016][    C1] ---[ end trace 0000000000000000 ]---
[   10.928016][    C1] RIP: 0010:rtc_handler+0x73/0xd0
[   10.928016][    C1] Code: df e8 41 62 f9 ff bf 04 00 00 00 e8 a3 bf e7 ff 31 f6 bf 04 00 00 00 e8 08 c2 e7 ff b8 01 00 00 00 5b 5d 41 5c c3 cc cc cc cc <48> 8b 75 00 31 ff e8 72 fe ff ff eb c0 bf 0b 00 00 00 e8 56 81 77
[   10.928016][    C1] RSP: 0000:ffffaf7f8003eec0 EFLAGS: 00010002
[   10.928016][    C1] RAX: ffffffffad6d0c00 RBX: ffff94049801a000 RCX: 0000000000000000
[   10.928016][    C1] RDX: 0000000000000040 RSI: ffffffffadf00460 RDI: ffff94049801a000
[   10.928016][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000004d0
[   10.928016][    C1] R10: 0000000000000000 R11: ffffaf7f8003eff8 R12: 0000000000000000
[   10.928016][    C1] R13: ffffffffae228d82 R14: 0000000000000004 R15: 0000000000000000
[   10.928016][    C1] FS:  0000000000000000(0000) GS:ffff94037ea80000(0000) knlGS:0000000000000000
[   10.928016][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.928016][    C1] CR2: 0000000000000000 CR3: 00000002c7e26001 CR4: 00000000003706e0
[   10.928016][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.928016][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.928016][    C1] Kernel panic - not syncing: Fatal exception in interrupt
[   10.928016][    C1] Kernel Offset: 0x2be00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   10.928016][    C1] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

-- 
Mel Gorman
SUSE Labs
