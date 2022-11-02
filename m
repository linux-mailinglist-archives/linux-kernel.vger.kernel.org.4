Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB9615D22
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiKBHsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiKBHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0ED25EA5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B1923373A;
        Wed,  2 Nov 2022 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfFxlGohZFf4CqpiCTKsxCFD+Xx0kKFUH3zzu8okq48=;
        b=nlpM0eoMXQa+ifbQPXqCnafiiovJrI9moEH/jBkqh1HjGfdpeGr28LiYWG70VhmAB2MiDu
        Ggyg4U4i/o8rU4Diuq2BXGJIA6kKEUweTCGXPH0MpEhTuEA1d8f20ljR8pmgxbHF9aCUiP
        VhOyq8U/FvwdZR524s9c7Ge3o/C25yA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F2691376E;
        Wed,  2 Nov 2022 07:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Zc9BqsgYmPacgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:55 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 07/16] x86/mtrr: Disentangle MTRR init from PAT init.
Date:   Wed,  2 Nov 2022 08:47:04 +0100
Message-Id: <20221102074713.21493-8-jgross@suse.com>
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

Add a main cache_cpu_init() init routine which initializes MTRR and/or
PAT support depending on what has been detected on the system.

Leave the MTRR-specific initialization in a MTRR-specific init function
where the smp_changes_mask setting happens now with caches disabled.

This global mask update was done with caches enabled before probably
because atomic operations while running uncached might have been quite
expensive.

But since only systems with a broken BIOS should ever require to set any
bit in smp_changes_mask, hurting those devices with a penalty of a few
microseconds during boot shouldn't be a real issue.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
V4:
- remove some comments (Borislav Petkov)
V5:
- rephrase commit message (Borislav Petkov)
---
 arch/x86/include/asm/cacheinfo.h   |  1 +
 arch/x86/include/asm/mtrr.h        |  2 ++
 arch/x86/kernel/cpu/cacheinfo.c    | 17 +++++++++++++++++
 arch/x86/kernel/cpu/mtrr/generic.c | 15 ++-------------
 4 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 6159874b4183..978bac70fd49 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -12,5 +12,6 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 void cache_disable(void);
 void cache_enable(void);
+void cache_cpu_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 12a16caed395..986249a2b9b6 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -50,6 +50,7 @@ extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
 void mtrr_enable(void);
+void mtrr_generic_set_state(void);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -91,6 +92,7 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
+#define mtrr_generic_set_state() do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c6a17e21301e..81ab99fe92bd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1120,3 +1120,20 @@ void cache_enable(void) __releases(cache_disable_lock)
 
 	raw_spin_unlock(&cache_disable_lock);
 }
+
+void cache_cpu_init(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cache_disable();
+
+	if (memory_caching_control & CACHE_MTRR)
+		mtrr_generic_set_state();
+
+	if (memory_caching_control & CACHE_PAT)
+		pat_init();
+
+	cache_enable();
+	local_irq_restore(flags);
+}
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index bfe13eedaca8..32aebed25e3f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -731,30 +731,19 @@ void mtrr_enable(void)
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 }
 
-static void generic_set_all(void)
+void mtrr_generic_set_state(void)
 {
 	unsigned long mask, count;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cache_disable();
 
 	/* Actually set the state */
 	mask = set_mtrr_state();
 
-	/* also set PAT */
-	pat_init();
-
-	cache_enable();
-	local_irq_restore(flags);
-
 	/* Use the atomic bitops to update the global mask */
 	for (count = 0; count < sizeof(mask) * 8; ++count) {
 		if (mask & 0x01)
 			set_bit(count, &smp_changes_mask);
 		mask >>= 1;
 	}
-
 }
 
 /**
@@ -854,7 +843,7 @@ int positive_have_wrcomb(void)
  * Generic structure...
  */
 const struct mtrr_ops generic_mtrr_ops = {
-	.set_all		= generic_set_all,
+	.set_all		= cache_cpu_init,
 	.get			= generic_get_mtrr,
 	.get_free_region	= generic_get_free_region,
 	.set			= generic_set_mtrr,
-- 
2.35.3

