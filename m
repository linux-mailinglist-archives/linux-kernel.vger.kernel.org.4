Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A181731578
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbjFOKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343784AbjFOKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:35:01 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317F297D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686825275;
  x=1718361275;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=N5F0WUYU45IWqZJe9HXUkJMQ38Qcy4Sg2+BO0tEm4Qs=;
  b=FYHeF9NwzM/p4dVKidwQhPUmDD/nZM5ekKh8oxQXtecn63FE9wnF0Psj
   Jbae6v3xz+vOYrfwOQMnR0kfYuBHvrriyOND6nNXKBfAG3K2Djg5w1yuo
   rB9Z13/+PRY/UjaYX4qcDjYas58kaquLlb1paf/1bLkuCrAOF9uhxegW1
   G4T87fIAElMiGyZ+6buTOl1RmTPjVy7qMLI36KPshC4KtNc+QwoZcYq1j
   n/2XYs1T7kKxwpbdzJp0D81lKz4/70iwOip1rj2AQ6hFikjnTtF0nwXyn
   1pPJ6BKzwgNk5TG55VIi7gZ/Rkbd9DtoFCRV6GHNgQudC++tIuPEf/iOa
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 15 Jun 2023 12:34:32 +0200
Subject: [PATCH] ARM: kexec: Make smp stop calls asynchronous
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230615-arm-smp-call-async-v1-1-58f4afb20f0f@axis.com>
X-B4-Tracking: v=1; b=H4sIADfpimQC/x2N0QrCMAwAf2Xk2UDX2qH+iviQ1dQF1joSEWXs3
 +18PI7jVjBWYYNLt4LyW0yetUF/6CBNVB+Mcm8M3vnghj4iaUErCyaaZyT71oThNMSQ89Gdo4c
 WjmSMo1JN054WshfrLhblLJ//7Xrbth9wJlWrfQAAAA==
To:     Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686825272; l=2227;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=r9H1QenBlIqwCnqnJ1Ys0LmHkHkdbbmsh2aKm0880Qk=;
 b=hlv5yW7GghIo24kUv304csMkuZHhJiBvtd5jLD345B60Z/owvNGmbfKlJWRNOI72WcBWSXQEo
 6E8H3gHyfSZAMG70puG5VssQa+o0K2/uOt0RF+qx9I5Ec1KJ3f2jtrT
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a panic is triggered by a hrtimer interrupt all online cpus will be
noitfied and set offline. But as highlighted by commit 19dbdcb8039c
("smp: Warn on function calls from softirq context") this call should
not be made synchronous with disabled interrupts:

  softdog: Initiating panic
  Kernel panic - not syncing: Software Watchdog Timer expired
  WARNING: CPU: 1 PID: 0 at kernel/smp.c:753 smp_call_function_many_cond
    unwind_backtrace:
      show_stack
      dump_stack_lvl
      __warn
      warn_slowpath_fmt
      smp_call_function_many_cond
      smp_call_function
      crash_smp_send_stop.part.0
      machine_crash_shutdown
      __crash_kexec
      panic
      softdog_fire
      __hrtimer_run_queues
      hrtimer_interrupt

Make the smp call for machine_crash_nonpanic_core() asynchronous.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 arch/arm/kernel/machine_kexec.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 46364b699cc3..5d07cf9e0044 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -94,16 +94,28 @@ static void machine_crash_nonpanic_core(void *unused)
 	}
 }
 
+static DEFINE_PER_CPU(call_single_data_t, cpu_stop_csd) =
+	CSD_INIT(machine_crash_nonpanic_core, NULL);
+
 void crash_smp_send_stop(void)
 {
 	static int cpus_stopped;
 	unsigned long msecs;
+	call_single_data_t *csd;
+	int cpu, this_cpu = raw_smp_processor_id();
 
 	if (cpus_stopped)
 		return;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	smp_call_function(machine_crash_nonpanic_core, NULL, false);
+	for_each_online_cpu(cpu) {
+		if (cpu == this_cpu)
+			continue;
+
+		csd = &per_cpu(cpu_stop_csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+
 	msecs = 1000; /* Wait at most a second for the other cpus to stop */
 	while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
 		mdelay(1);

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230615-arm-smp-call-async-38653ff40952

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

