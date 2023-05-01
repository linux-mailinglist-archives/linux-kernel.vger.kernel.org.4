Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D26F2E13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjEADT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjEADQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8730FD;
        Sun, 30 Apr 2023 20:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F57617C3;
        Mon,  1 May 2023 03:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C872DC433EF;
        Mon,  1 May 2023 03:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910381;
        bh=ode1mSl3ZeNCClS8uQpprqfFvnpf01KMroNObvblLpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+UA+3XlMo+Joa1+NB0u0TklXsfHekiOOx3iC/mqAcnkT1I6DxKMmA+vvb1g7LDVV
         BRtu0oziH8hk3Pur6pCUNtW1ZvZi4DjG9d0kTIk8nw+6fcWvsv4AJlqykeV0Uxb3Dl
         oVpaKwc/dhv8INktEpEPSeFzsWSC05iPPWzcdzZdGIxzoA9WExiMZcP954U6STVM6a
         mxlUSRLFXZu6VQ+6kKT7qpT5H1c+OaBa5SSrzF+ON0SFj2F6C9BQIWOcJ9brcQzo8T
         oGiy0TXHYogN8HnLI4RTPtI70dwbZ8CvvEg8Rfu+hwb/ODpohv9jX9SMfY87hg0ybn
         oYFblFJlervEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        chenhuacai@kernel.org, git@xen0n.name, isaku.yamahata@intel.com,
        kan.liang@linux.intel.com, maz@kernel.org, liuqi115@huawei.com,
        chao.gao@intel.com, jgross@suse.com, nnac123@linux.ibm.com,
        maobibo@loongson.cn, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 4/9] firmware: arm_sdei: Fix sleep from invalid context BUG
Date:   Sun, 30 Apr 2023 23:06:04 -0400
Message-Id: <20230501030611.3255082-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030611.3255082-1-sashal@kernel.org>
References: <20230501030611.3255082-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit d2c48b2387eb89e0bf2a2e06e30987cf410acad4 ]

Running a preempt-rt (v6.2-rc3-rt1) based kernel on an Ampere Altra
triggers:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
  in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
  preempt_count: 0, expected: 0
  RCU nest depth: 0, expected: 0
  3 locks held by cpuhp/0/24:
    #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
    #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
    #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
  irq event stamp: 36
  hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
  hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
  softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
  Hardware name: WIWYNN Mt.Jade Server [...]
  Call trace:
    dump_backtrace+0x114/0x120
    show_stack+0x20/0x70
    dump_stack_lvl+0x9c/0xd8
    dump_stack+0x18/0x34
    __might_resched+0x188/0x228
    rt_spin_lock+0x70/0x120
    sdei_cpuhp_up+0x3c/0x130
    cpuhp_invoke_callback+0x250/0xf08
    cpuhp_thread_fun+0x120/0x248
    smpboot_thread_fn+0x280/0x320
    kthread+0x130/0x140
    ret_from_fork+0x10/0x20

sdei_cpuhp_up() is called in the STARTING hotplug section,
which runs with interrupts disabled. Use a CPUHP_AP_ONLINE_DYN entry
instead to execute the cpuhp cb later, with preemption enabled.

SDEI originally got its own cpuhp slot to allow interacting
with perf. It got superseded by pNMI and this early slot is not
relevant anymore. [1]

Some SDEI calls (e.g. SDEI_1_0_FN_SDEI_PE_MASK) take actions on the
calling CPU. It is checked that preemption is disabled for them.
_ONLINE cpuhp cb are executed in the 'per CPU hotplug thread'.
Preemption is enabled in those threads, but their cpumask is limited
to 1 CPU.
Move 'WARN_ON_ONCE(preemptible())' statements so that SDEI cpuhp cb
don't trigger them.

Also add a check for the SDEI_1_0_FN_SDEI_PRIVATE_RESET SDEI call
which acts on the calling CPU.

[1]:
https://lore.kernel.org/all/5813b8c5-ae3e-87fd-fccc-94c9cd08816d@arm.com/

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Link: https://lore.kernel.org/r/20230216084920.144064-1-pierre.gondois@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_sdei.c | 37 ++++++++++++++++++++-----------------
 include/linux/cpuhotplug.h  |  1 -
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index e497785cd99fe..b0e8752174c6f 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -44,6 +44,8 @@ static asmlinkage void (*sdei_firmware_call)(unsigned long function_id,
 /* entry point from firmware to arch asm code */
 static unsigned long sdei_entry_point;
 
+static int sdei_hp_state;
+
 struct sdei_event {
 	/* These three are protected by the sdei_list_lock */
 	struct list_head	list;
@@ -305,8 +307,6 @@ int sdei_mask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to mask CPU[%u]: %d\n",
@@ -319,6 +319,7 @@ int sdei_mask_local_cpu(void)
 
 static void _ipi_mask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_mask_local_cpu();
 }
 
@@ -326,8 +327,6 @@ int sdei_unmask_local_cpu(void)
 {
 	int err;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PE_UNMASK, 0, 0, 0, 0, 0, NULL);
 	if (err && err != -EIO) {
 		pr_warn_once("failed to unmask CPU[%u]: %d\n",
@@ -340,6 +339,7 @@ int sdei_unmask_local_cpu(void)
 
 static void _ipi_unmask_cpu(void *ignored)
 {
+	WARN_ON_ONCE(preemptible());
 	sdei_unmask_local_cpu();
 }
 
@@ -347,6 +347,8 @@ static void _ipi_private_reset(void *ignored)
 {
 	int err;
 
+	WARN_ON_ONCE(preemptible());
+
 	err = invoke_sdei_fn(SDEI_1_0_FN_SDEI_PRIVATE_RESET, 0, 0, 0, 0, 0,
 			     NULL);
 	if (err && err != -EIO)
@@ -393,8 +395,6 @@ static void _local_event_enable(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_enable(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -485,8 +485,6 @@ static void _local_event_unregister(void *data)
 	int err;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON_ONCE(preemptible());
-
 	err = sdei_api_event_unregister(arg->event->event_num);
 
 	sdei_cross_call_return(arg, err);
@@ -575,8 +573,6 @@ static void _local_event_register(void *data)
 	struct sdei_registered_event *reg;
 	struct sdei_crosscall_args *arg = data;
 
-	WARN_ON(preemptible());
-
 	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
 	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
 				      reg, 0, 0);
@@ -756,6 +752,8 @@ static int sdei_pm_notifier(struct notifier_block *nb, unsigned long action,
 {
 	int rv;
 
+	WARN_ON_ONCE(preemptible());
+
 	switch (action) {
 	case CPU_PM_ENTER:
 		rv = sdei_mask_local_cpu();
@@ -804,7 +802,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_entry_point);
 
 	err = sdei_unregister_shared();
 	if (err)
@@ -825,12 +823,15 @@ static int sdei_device_thaw(struct device *dev)
 		return err;
 	}
 
-	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "SDEI",
 				&sdei_cpuhp_up, &sdei_cpuhp_down);
-	if (err)
+	if (err < 0) {
 		pr_warn("Failed to re-register CPU hotplug notifier...\n");
+		return err;
+	}
 
-	return err;
+	sdei_hp_state = err;
+	return 0;
 }
 
 static int sdei_device_restore(struct device *dev)
@@ -862,7 +863,7 @@ static int sdei_reboot_notifier(struct notifier_block *nb, unsigned long action,
 	 * We are going to reset the interface, after this there is no point
 	 * doing work when we take CPUs offline.
 	 */
-	cpuhp_remove_state(CPUHP_AP_ARM_SDEI_STARTING);
+	cpuhp_remove_state(sdei_hp_state);
 
 	sdei_platform_reset();
 
@@ -1044,13 +1045,15 @@ static int sdei_probe(struct platform_device *pdev)
 		goto remove_cpupm;
 	}
 
-	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "SDEI",
 				&sdei_cpuhp_up, &sdei_cpuhp_down);
-	if (err) {
+	if (err < 0) {
 		pr_warn("Failed to register CPU hotplug notifier...\n");
 		goto remove_reboot;
 	}
 
+	sdei_hp_state = err;
+
 	return 0;
 
 remove_reboot:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 15835f37bd5f2..8134cc3b99cdc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -111,7 +111,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
-	CPUHP_AP_ARM_SDEI_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
-- 
2.39.2

