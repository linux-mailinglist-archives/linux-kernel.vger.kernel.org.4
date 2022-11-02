Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D0615D2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiKBHtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiKBHsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2D275E7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 236111F8D0;
        Wed,  2 Nov 2022 07:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mPWpLwJy7yzhex6eU7j5tLklymwcAzwe+PPdkowDuM=;
        b=jK+xtRHuGxgvIkpvOFSz7r4XQb0A4BZmX2KszjLMCulWag7FTQL5eJPNj8vloNmCtmUGAR
        VD6ozlxoai+mtixWWex89re4ODBn3w+t6Si82LwdfzTxwfv9MLOyQuOKiL0IJmCbI0saFh
        neFoGFASCrsQr0TiitJCiVMjDmtHjd8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDD681376E;
        Wed,  2 Nov 2022 07:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VZ/XMNIgYmNIcwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:34 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 14/16] x86: switch cache_ap_init() to hotplug callback
Date:   Wed,  2 Nov 2022 08:47:11 +0100
Message-Id: <20221102074713.21493-15-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
V4:
- new patch
---
 arch/x86/include/asm/cacheinfo.h |  1 -
 arch/x86/kernel/cpu/cacheinfo.c  | 18 +++++++++++++++---
 arch/x86/kernel/cpu/common.c     |  1 -
 arch/x86/kernel/smpboot.c        |  2 --
 include/linux/cpuhotplug.h       |  1 +
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index a0ef46e9f453..ce9685fc78d8 100644
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
index 1aaf830254df..231cf1ff0641 100644
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
index fd058b547f8d..bf4ac1cb93d7 100644
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
index 1b61a480c966..82b311c718bc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1429,8 +1429,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_cache_aps_delayed_init(true);
-
 	smp_quirk_init_udelay();
 
 	speculative_store_bypass_ht_init();
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..0d277b4b025a 100644
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
-- 
2.35.3

