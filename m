Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126616064F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJTPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJTPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:48:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028B19D88A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:48:21 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e710329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e710:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A97861EC06A7;
        Thu, 20 Oct 2022 17:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666280895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4fuPAbhEy9QJh4wCyzCfIyIGGrwgo5/5zpP7qxnXC/o=;
        b=D7qFDT1VsY4sP+85/zPuQZIDb3DBT/VS4F9NHdP/Rt5StwHo6hCqXK1AZ6bO3zPOxEHTRs
        0ndi0gmUWcAxFk9zHeOcynOdxUj53FYchTfz30KOhx+0kh+w/xbMf64o/R36KcaITNkgGR
        kmTD0uSd5zmcrzNDWqxvJN+E6SB86gc=
Date:   Thu, 20 Oct 2022 17:48:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2 1/5] x86/microcode: Rip out the subsys interface gunk
Message-ID: <Y1FtvA+bS6opRcqB@zn.tnic>
References: <Y1A5YHzmzab8LrYD@zn.tnic>
 <20221019175426.31025-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221019175426.31025-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of this one:

From: Borislav Petkov <bp@suse.de>
Date: Wed, 19 Oct 2022 18:13:06 +0200
Subject: x86/microcode: Rip out the subsys interface gunk

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

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6a41cee242f6..4c222e667567 100644
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

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
