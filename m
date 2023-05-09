Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003EB6FCDE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjEISh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEISh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:37:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB662126
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:37:24 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01C901EC0338;
        Tue,  9 May 2023 20:37:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683657443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uZBxm4/mI0TbVT4vVosHk4oYlGuPEwWCxuD7POwmsR4=;
        b=dIzqqgXpZv9nXbM6cX0PK2WpnHXcvI96BiK+COoH8T04uipxXDXisRFTm/W7iMDy0OVp2O
        tlhA7Lgzv7P0I3FJGELQ/ZT8NmTRJxDdQBTH8SAh4Oum8+/FfhaV2yemqhDjz2A8Q2lVew
        6abOm40jVAXSI99pV9E+k0wv7Obdisw=
Date:   Tue, 9 May 2023 20:37:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 06/16] x86/mtrr: replace vendor tests in MTRR code
Message-ID: <20230509183715.GEZFqS20XTUZqpJEZ/@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-7-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502120931.20719-7-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:09:21PM +0200, Juergen Gross wrote:
> Modern CPUs all share the same MTRR interface implemented via
> generic_mtrr_ops.
> 
> At several places in MTRR code this generic interface is deduced via
> is_cpu(INTEL) tests, which is only working due to X86_VENDOR_INTEL
> being 0 (the is_cpu() macro is testing mtrr_if->vendor, which isn't
> explicitly set in generic_mtrr_ops).
> 
> Test the generic CPU feature X86_FEATURE_MTRR instead.

Doesn't work for the MTRRs disabled case - mtrr_trim_uncached_memory()
gets called directly, where mtrr_if can be NULL.

[    0.006508] MTRRs disabled by BIOS
[    0.006522] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.006597] !mtrr_if
[    0.006609] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1+ #1
[    0.006626] Hardware name: Acer AOA150/, BIOS v0.3309 10/06/2008
[    0.006638] Call Trace:
[    0.006663]  dump_stack_lvl+0x6a/0xdc
[    0.006697]  dump_stack+0xd/0x14
[    0.006719]  mtrr_trim_uncached_memory+0x317/0x440
[    0.006761]  ? __this_cpu_preempt_check+0xf/0x1c
[    0.006814]  ? _raw_spin_unlock+0x27/0x50
[    0.006835]  ? cache_enable+0x3d/0x44
[    0.006869]  setup_arch+0x746/0xcac
[    0.006887]  ? vprintk_default+0x15/0x1c
[    0.006922]  ? vprintk+0x55/0x64
[    0.006953]  start_kernel+0x56/0x630
[    0.006974]  ? idt_setup_early_handler+0x82/0x9c
[    0.007007]  i386_start_kernel+0x48/0x48
[    0.007027]  startup_32_smp+0x156/0x158

I've done this ontop. mtrr_enabled() must be used now before caller
needs to do any mtrr_if-> accesses.

And yes, the MTRR code needs more scrubbing.

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 4a979086f00e..ed5f84c20ac2 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -689,6 +689,9 @@ int __init mtrr_cleanup(void)
 	int index_good;
 	int i;
 
+	if (!mtrr_enabled())
+		return 0;
+
 	if (!cpu_feature_enabled(X86_FEATURE_MTRR) || enable_mtrr_cleanup < 1)
 		return 0;
 
@@ -882,6 +885,9 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 	/* extra one for all 0 */
 	int num[MTRR_NUM_TYPES + 1];
 
+	if (!mtrr_enabled())
+		return 0;
+
 	/*
 	 * Make sure we only trim uncachable memory on machines that
 	 * support the Intel MTRR architecture:
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index bcde9a754f62..ec8670bb5d88 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,10 +59,6 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool mtrr_enabled(void)
-{
-	return !!mtrr_if;
-}
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 DEFINE_MUTEX(mtrr_mutex);
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 81babff29c59..4463a8db6f4e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -80,3 +80,12 @@ extern const struct mtrr_ops centaur_mtrr_ops;
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(void);
 void generic_rebuild_map(void);
+
+/*
+ * Must be used by code which uses mtrr_if to call platform-specific
+ * MTRR manipulation functions.
+ */
+static inline bool mtrr_enabled(void)
+{
+	return !!mtrr_if;
+}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
