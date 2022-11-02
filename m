Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5585E616728
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiKBQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiKBQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:09:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95552B1AF;
        Wed,  2 Nov 2022 09:09:02 -0700 (PDT)
Date:   Wed, 02 Nov 2022 16:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667405341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAxxY47SOfNP0WUkTp6VcHa2VWY1wYWp1foEsG9fWAk=;
        b=JW893CoRs0pLOvktc+THQ+8Bii9ITNEeTn0T1qJAEbX2+GSirVTFDNpKqnxNdce8TPopu2
        ioYCDNNzn8g63VHgwUR3iL4sToLej+TaOpfh34QBohJzFnDiT5AgJhsQEV4Zfv+FZYowrw
        JnSg/9wQk866kx8c3MPoUnLznE1W5v6a1+JvpYqveF8utvll8qelTe6WtAk3QATM+uw1e0
        kwr/J6nSOpWQgM8XxUcIMxdEpEe7hEwG8wJIXpfxATbr1N5ONckiEDnqqIZisfxTnJv5m0
        VgMWgsc/7ifP6EXhXgSePneL+im2n7RESW88mIJw1DJL5mzL4eH1dZesNw/CBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667405341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAxxY47SOfNP0WUkTp6VcHa2VWY1wYWp1foEsG9fWAk=;
        b=r0Xxrb2etHVxMinpeNO6lziZwPi5UAtfacwOiECFvR46Yw5T4IYemDApxzfz+/7cJVoZ/0
        ozZg8RTAc2n1H5Bw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Rip out the subsys interface gunk
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028142638.28498-2-bp@alien8.de>
References: <20221028142638.28498-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166740534039.6127.1049032930807424667.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     b6f86689d5b740f2cc3ac3a1032c7374b24381cc
Gitweb:        https://git.kernel.org/tip/b6f86689d5b740f2cc3ac3a1032c7374b24381cc
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 19 Oct 2022 18:13:06 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 16:45:46 +01:00

x86/microcode: Rip out the subsys interface gunk

This is a left-over from the old days when CPU hotplug wasn't as robust
as it is now. Currently, microcode gets loaded early on the CPU init
path and there's no need to attempt to load it again, which that subsys
interface callback is doing.

The only other thing that the subsys interface init path was doing is
adding the

  /sys/devices/system/cpu/cpu*/microcode/

hierarchy.

So add a function which gets called on each CPU after all the necessary
driver setup has happened. Use schedule_on_each_cpu() which can block
because the sysfs creating code does kmem_cache_zalloc() which can block
too and the initial version of this where it did that setup in an IPI
handler of on_each_cpu() can cause a deadlock of the sort:

  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

as the IPI handler runs in IRQ context.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221028142638.28498-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 78 ++++++---------------------
 1 file changed, 20 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6a41cee..4c222e6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -601,8 +601,8 @@ static enum ucode_state microcode_resume_cpu(int cpu)
 
 static enum ucode_state microcode_init_cpu(int cpu, bool refresh_fw)
 {
-	enum ucode_state ustate;
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	enum ucode_state ustate;
 
 	if (uci->valid)
 		return UCODE_OK;
@@ -636,44 +636,6 @@ static enum ucode_state microcode_update_cpu(int cpu)
 	return microcode_init_cpu(cpu, false);
 }
 
-static int mc_device_add(struct device *dev, struct subsys_interface *sif)
-{
-	int err, cpu = dev->id;
-
-	if (!cpu_online(cpu))
-		return 0;
-
-	pr_debug("CPU%d added\n", cpu);
-
-	err = sysfs_create_group(&dev->kobj, &mc_attr_group);
-	if (err)
-		return err;
-
-	if (microcode_init_cpu(cpu, true) == UCODE_ERROR)
-		return -EINVAL;
-
-	return err;
-}
-
-static void mc_device_remove(struct device *dev, struct subsys_interface *sif)
-{
-	int cpu = dev->id;
-
-	if (!cpu_online(cpu))
-		return;
-
-	pr_debug("CPU%d removed\n", cpu);
-	microcode_fini_cpu(cpu);
-	sysfs_remove_group(&dev->kobj, &mc_attr_group);
-}
-
-static struct subsys_interface mc_cpu_interface = {
-	.name			= "microcode",
-	.subsys			= &cpu_subsys,
-	.add_dev		= mc_device_add,
-	.remove_dev		= mc_device_remove,
-};
-
 /**
  * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
@@ -713,6 +675,9 @@ static int mc_cpu_down_prep(unsigned int cpu)
 	struct device *dev;
 
 	dev = get_cpu_device(cpu);
+
+	microcode_fini_cpu(cpu);
+
 	/* Suspend is in progress, only remove the interface */
 	sysfs_remove_group(&dev->kobj, &mc_attr_group);
 	pr_debug("CPU%d removed\n", cpu);
@@ -720,6 +685,18 @@ static int mc_cpu_down_prep(unsigned int cpu)
 	return 0;
 }
 
+static void setup_online_cpu(struct work_struct *work)
+{
+	int cpu = smp_processor_id();
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
+	memset(uci, 0, sizeof(*uci));
+
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+
+	mc_cpu_online(cpu);
+}
+
 static struct attribute *cpu_root_microcode_attrs[] = {
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
@@ -755,23 +732,17 @@ static int __init microcode_init(void)
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
 
-	cpus_read_lock();
-	mutex_lock(&microcode_mutex);
-	error = subsys_interface_register(&mc_cpu_interface);
-	mutex_unlock(&microcode_mutex);
-	cpus_read_unlock();
-
-	if (error)
-		goto out_pdev;
-
 	error = sysfs_create_group(&cpu_subsys.dev_root->kobj,
 				   &cpu_root_microcode_group);
 
 	if (error) {
 		pr_err("Error creating microcode group!\n");
-		goto out_driver;
+		goto out_pdev;
 	}
 
+	/* Do per-CPU setup */
+	schedule_on_each_cpu(setup_online_cpu);
+
 	register_syscore_ops(&mc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
 				  mc_cpu_starting, NULL);
@@ -782,15 +753,6 @@ static int __init microcode_init(void)
 
 	return 0;
 
- out_driver:
-	cpus_read_lock();
-	mutex_lock(&microcode_mutex);
-
-	subsys_interface_unregister(&mc_cpu_interface);
-
-	mutex_unlock(&microcode_mutex);
-	cpus_read_unlock();
-
  out_pdev:
 	platform_device_unregister(microcode_pdev);
 	return error;
