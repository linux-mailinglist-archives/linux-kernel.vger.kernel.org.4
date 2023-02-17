Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1669AB01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBQMG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBQMGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:06:55 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F88644DD;
        Fri, 17 Feb 2023 04:06:53 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PJ9R10kjGzDsWL;
        Fri, 17 Feb 2023 20:02:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 20:06:49 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <tiwai@suse.de>, <jolsa@kernel.org>,
        <vbabka@suse.cz>, <keescook@chromium.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <namhyung@kernel.org>, <bp@alien8.de>,
        <bhe@redhat.com>, <eric.devolder@oracle.com>, <hpa@zytor.com>,
        <jroedel@suse.de>, <dave.hansen@linux.intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <x86@kernel.org>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH v4] x86/kdump: terminate watchdog NMI interrupt to avoid kdump crashes
Date:   Fri, 17 Feb 2023 20:06:04 +0800
Message-ID: <20230217120604.435608-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cpu panics within the NMI interrupt context, there could be
unhandled NMI interrupts in the background which are blocked by processor
until next IRET instruction executes. Since that, it prevents nested
NMI handler execution.

In case of IRET execution during kdump reboot and no proper NMIs handler
registered at that point (such as during EFI loader), we need to ensure
watchdog no work any more, or kdump would crash later. So call
perf_event_exit_cpu() at the very last moment in the panic shutdown.

!! Here I know it's not allowed to call perf_event_exit_cpu() within nmi
context, because of mutex_lock, smp_call_function and so on.
Is there any experts know about the similar function which allowed to call
within atomic context (Neither x86_pmu_disable() nor x86_pmu_disable_all()
do work after my practice)?

Thank you in advance.

Here provide one of test case to reproduce the concerned issue:
  1. # cat uncorrected
     CPU 1 BANK 4
     STATUS uncorrected 0xc0
     MCGSTATUS  EIPV MCIP
     ADDR 0x1234
     RIP 0xdeadbabe
     RAISINGCPU 0
     MCGCAP SER CMCI TES 0x6
  2. # modprobe mce_inject
  3. # mce-inject uncorrected

Mce-inject would trigger kernel panic under NMI interrupt context. In
addition, we need another NMI interrupt raise (such as from watchdog)
during panic process. Set proper watchdog threshold value and/or add an
artificial delay to make sure watchdog interrupt raise during the panic
procedure and the involved issue would occur.

Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
  v1: add dummy NMI interrupt handler in EFI loader
  v2: tidy up changelog, add comments (by Ingo Molnar)
  v3: add iret_to_self() to deal with blocked NMIs in advance
  v4: call perf_event_exit_cpu() to terminate watchdog in panic shutdown

 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 305514431f26..f46df94bbdad 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/perf_event.h>

 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -170,6 +171,15 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	/*
+	 * If the cpu panics within the NMI interrupt context,
+	 * we need to ensure no more NMI interrupts blocked by
+	 * processor. In case of IRET execution during kdump
+	 * path and no proper NMIs handler registered at that
+	 * point, here terminate watchdog in panic shutdown.
+	 */
+	perf_event_exit_cpu(smp_processor_id());
 	crash_save_cpu(regs, safe_smp_processor_id());
 }

--
2.25.1

