Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678462422D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKJMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKJMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE171F30;
        Thu, 10 Nov 2022 04:21:52 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYme4y0NdY1CFBDiAkYLwqCEg2kqXX9VkyPt73hmCKM=;
        b=rjXl5id+SbTBLA4a1dW9CU2jXH3C03fyzlVvENQVPPj2aUJyAR0szdpHF8tnxwSuF4xBUW
        rQeR4WYA16bUFy1fUK8P7g7EEz8SVFiyCcpYAYtpOjB574HeR7EeJCalCsARiAlrM4hemc
        HB7miVUyd+pKesOAPhynhdMajH1jizN8nB8dGvMSeFSIHI2EvNN7gUoUymWWZsZ0EE4nxn
        Jj7TSNa2RQEBsvvWB729k80Ugye3emZFvkDrlrhPz66QDObzDh4ziseOvJ++VBH2M1ZWuS
        NkUnM8G1w6MwqHm+CkQAClBkRw6TYVJ2VVxuw/BQmBIJhmSa1Vy9+V6MdP3gFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYme4y0NdY1CFBDiAkYLwqCEg2kqXX9VkyPt73hmCKM=;
        b=yVGhYbTWKE9AURUpKMkhTriiEiOyjOsT/qGBkgBpWnMsQTN/ITQt4lZaHcSC6qykf1RM9U
        vY2uX2OLcSsifdAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Let cache_aps_delayed_init replace
 mtrr_aps_delayed_init
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-12-jgross@suse.com>
References: <20221102074713.21493-12-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291032.4906.11200342657381640879.tip-bot2@tip-bot2>
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

Commit-ID:     955d0e0805912641230fb46c380aa625f78ecaca
Gitweb:        https://git.kernel.org/tip/955d0e0805912641230fb46c380aa625f78ecaca
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:45 +01:00

x86/mtrr: Let cache_aps_delayed_init replace mtrr_aps_delayed_init

In order to prepare decoupling MTRR and PAT replace the MTRR-specific
mtrr_aps_delayed_init flag with a more generic cache_aps_delayed_init
one.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-12-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cacheinfo.h |  2 ++
 arch/x86/include/asm/mtrr.h      |  2 --
 arch/x86/kernel/cpu/cacheinfo.c  | 12 ++++++++++++
 arch/x86/kernel/cpu/mtrr/mtrr.c  | 18 +++++-------------
 arch/x86/kernel/smpboot.c        |  5 +++--
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 978bac7..e443fcc 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -13,5 +13,7 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cache_disable(void);
 void cache_enable(void);
 void cache_cpu_init(void);
+void set_cache_aps_delayed_init(bool val);
+bool get_cache_aps_delayed_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 986249a..5d31219 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -43,7 +43,6 @@ extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_ap_init(void);
-extern void set_mtrr_aps_delayed_init(void);
 extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
@@ -87,7 +86,6 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
 #define mtrr_ap_init() do {} while (0)
-#define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 31684bf..063d556 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1137,3 +1137,15 @@ void cache_cpu_init(void)
 	cache_enable();
 	local_irq_restore(flags);
 }
+
+static bool cache_aps_delayed_init;
+
+void set_cache_aps_delayed_init(bool val)
+{
+	cache_aps_delayed_init = val;
+}
+
+bool get_cache_aps_delayed_init(void)
+{
+	return cache_aps_delayed_init;
+}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index f671be9..15ee6d7 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -68,7 +68,6 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
-static bool mtrr_aps_delayed_init;
 
 static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
@@ -175,7 +174,8 @@ static int mtrr_rendezvous_handler(void *info)
 	if (data->smp_reg != ~0U) {
 		mtrr_if->set(data->smp_reg, data->smp_base,
 			     data->smp_size, data->smp_type);
-	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
+	} else if (get_cache_aps_delayed_init() ||
+		   !cpu_online(smp_processor_id())) {
 		cache_cpu_init();
 	}
 	return 0;
@@ -782,7 +782,7 @@ void __init mtrr_bp_init(void)
 
 void mtrr_ap_init(void)
 {
-	if (!memory_caching_control || mtrr_aps_delayed_init)
+	if (!memory_caching_control || get_cache_aps_delayed_init())
 		return;
 
 	/*
@@ -816,14 +816,6 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-void set_mtrr_aps_delayed_init(void)
-{
-	if (!memory_caching_control)
-		return;
-
-	mtrr_aps_delayed_init = true;
-}
-
 /*
  * Delayed MTRR initialization for all AP's
  */
@@ -837,11 +829,11 @@ void mtrr_aps_init(void)
 	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
 	 * then we are done.
 	 */
-	if (!mtrr_aps_delayed_init)
+	if (!get_cache_aps_delayed_init())
 		return;
 
 	set_mtrr(~0U, 0, 0, 0);
-	mtrr_aps_delayed_init = false;
+	set_cache_aps_delayed_init(false);
 }
 
 void mtrr_bp_restore(void)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f3ea02..13c71ab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -58,6 +58,7 @@
 #include <linux/overflow.h>
 
 #include <asm/acpi.h>
+#include <asm/cacheinfo.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
@@ -1428,7 +1429,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_mtrr_aps_delayed_init();
+	set_cache_aps_delayed_init(true);
 
 	smp_quirk_init_udelay();
 
@@ -1439,7 +1440,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_thaw_secondary_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	set_cache_aps_delayed_init(true);
 }
 
 void arch_thaw_secondary_cpus_end(void)
