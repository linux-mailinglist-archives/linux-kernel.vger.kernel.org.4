Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F35F3DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJDINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJDIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FE65F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 46BC7219B8;
        Tue,  4 Oct 2022 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJa/dAa21xOVGetzO/ryAsH/eOO4Um4qAZoEyJh4VLY=;
        b=Fvn+Y6N82fq4DL9aBZfloJXupWQ/sxaLlU3k4rU43r2FI/bOPlsKrkJEuYuQ8A04kcIIgw
        lUdTSJ9qdaHceYwG32j2Y8LKRYFkO1r2Y+T1uJfJptZkWBgRKTr7L0wLGqjfRK0wG+GOAE
        B2ErVBZ8QBT8pFFECt8lT6mp8+Aah78=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BB37139EF;
        Tue,  4 Oct 2022 08:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I39wAcLqO2O5SAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 14/16] x86: switch cache_ap_init() to hotplug callback
Date:   Tue,  4 Oct 2022 10:10:21 +0200
Message-Id: <20221004081023.32402-15-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of explicitly calling cache_ap_init() in
identify_secondary_cpu() use a cpu hotplug callback instead. By
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
index 77fe39a11679..f6c521687535 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -15,7 +15,6 @@ void cache_enable(void);
 void set_cache_aps_delayed_init(void);
 void cache_bp_init(void);
 void cache_bp_restore(void);
-void cache_ap_init(void);
 void cache_aps_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 40c304314513..48ce48827f87 100644
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
 
 void set_cache_aps_delayed_init(void)
 {
@@ -1169,10 +1170,10 @@ void cache_bp_restore(void)
 		cache_cpu_init();
 }
 
-void cache_ap_init(void)
+static int cache_ap_init(unsigned int cpu)
 {
 	if (!memory_caching_control || cache_aps_delayed_init)
-		return;
+		return 0;
 
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
@@ -1189,6 +1190,8 @@ void cache_ap_init(void)
 	 */
 	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
 				       cpu_callout_mask);
+
+	return 0;
 }
 
 /*
@@ -1202,3 +1205,12 @@ void cache_aps_init(void)
 	stop_machine(cache_rendezvous_handler, NULL, cpu_online_mask);
 	cache_aps_delayed_init = false;
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
index fb225a02455f..d90be0a80560 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1429,8 +1429,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_cache_aps_delayed_init();
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

