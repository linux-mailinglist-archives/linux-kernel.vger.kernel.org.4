Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87557624229
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKJMV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKJMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EEC71F2B;
        Thu, 10 Nov 2022 04:21:49 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG/9a6H6NEua6gewILu/XAdkJNWyOE+MgdGKSbBLNCA=;
        b=BBQGl5Oqsopv35OV7GkuHsZaXiQ2SGD572zmJpaN80Qzv8Xp/4x/JMsynv3t7zTDsaJilg
        b0UMsRIxD2r+nERQEIT3O3rXIdcuCHhHlHkDw3I+O6OEDsqzbl62cVCtwOHDrXHtnmtx9a
        kUA917fHCcixMWmlTCMwHj9c+qSyG5uhLreVgTx72UBFPYC7g48YoR7xO1xK346+0dgF02
        6x7MFiEXcC2YE9A1LzXas3BT0BrNEnL1kTuXFUAiAqOym7jrwuHctyhtlnKb8gS7L5xPYX
        A/9czB7kjtMfi5o7657WqN7pkv9xRxkQGYIXzo8QiefmyfGscdvoqHdTV/mQTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG/9a6H6NEua6gewILu/XAdkJNWyOE+MgdGKSbBLNCA=;
        b=dz9wxP/Mp9nI2mtFR7Yf8dlrdhW6Sv4bGugw5sVyr56T9YpDysCMi/vBWO3jEXLWvmZBEr
        CrKMvvkwu6CeKkAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Switch cache_ap_init() to hotplug callback
Cc:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-15-jgross@suse.com>
References: <20221102074713.21493-15-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808290694.4906.14728095964138728478.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     30f89e524becdbaa483b34902b079c9d4dfaa4a3
Gitweb:        https://git.kernel.org/tip/30f89e524becdbaa483b34902b079c9d4dfaa4a3
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:45 +01:00

x86/cacheinfo: Switch cache_ap_init() to hotplug callback

Instead of explicitly calling cache_ap_init() in
identify_secondary_cpu() use a CPU hotplug callback instead. By
registering the callback only after having started the non-boot CPUs
and initializing cache_aps_delayed_init with "true", calling
set_cache_aps_delayed_init() at boot time can be dropped.

It should be noted that this change results in cache_ap_init() being
called a little bit later when hotplugging CPUs. By using a new
hotplug slot right at the start of the low level bringup this is not
problematic, as no operations requiring a specific caching mode are
performed that early in CPU initialization.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-15-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cacheinfo.h |  1 -
 arch/x86/kernel/cpu/cacheinfo.c  | 18 +++++++++++++++---
 arch/x86/kernel/cpu/common.c     |  1 -
 arch/x86/kernel/smpboot.c        |  2 --
 include/linux/cpuhotplug.h       |  1 +
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index a0ef46e..ce9685f 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -16,7 +16,6 @@ void set_cache_aps_delayed_init(bool val);
 bool get_cache_aps_delayed_init(void);
 void cache_bp_init(void);
 void cache_bp_restore(void);
-void cache_ap_init(void);
 void cache_aps_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c830f85..f4e5aa2 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/sched.h>
 #include <linux/capability.h>
 #include <linux/sysfs.h>
@@ -1139,7 +1140,7 @@ static void cache_cpu_init(void)
 	local_irq_restore(flags);
 }
 
-static bool cache_aps_delayed_init;
+static bool cache_aps_delayed_init = true;
 
 void set_cache_aps_delayed_init(bool val)
 {
@@ -1174,10 +1175,10 @@ void cache_bp_restore(void)
 		cache_cpu_init();
 }
 
-void cache_ap_init(void)
+static int cache_ap_init(unsigned int cpu)
 {
 	if (!memory_caching_control || get_cache_aps_delayed_init())
-		return;
+		return 0;
 
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid MTRR entries
@@ -1194,6 +1195,8 @@ void cache_ap_init(void)
 	 */
 	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
 				       cpu_callout_mask);
+
+	return 0;
 }
 
 /*
@@ -1207,3 +1210,12 @@ void cache_aps_init(void)
 	stop_machine(cache_rendezvous_handler, NULL, cpu_online_mask);
 	set_cache_aps_delayed_init(false);
 }
+
+static int __init cache_ap_register(void)
+{
+	cpuhp_setup_state_nocalls(CPUHP_AP_CACHECTRL_STARTING,
+				  "x86/cachectrl:starting",
+				  cache_ap_init, NULL);
+	return 0;
+}
+core_initcall(cache_ap_register);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fd058b5..bf4ac1c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1949,7 +1949,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	cache_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 1b61a48..82b311c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1429,8 +1429,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_cache_aps_delayed_init(true);
-
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f614479..0d277b4 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -140,6 +140,7 @@ enum cpuhp_state {
 	 */
 	CPUHP_AP_IDLE_DEAD,
 	CPUHP_AP_OFFLINE,
+	CPUHP_AP_CACHECTRL_STARTING,
 	CPUHP_AP_SCHED_STARTING,
 	CPUHP_AP_RCUTREE_DYING,
 	CPUHP_AP_CPU_PM_STARTING,
