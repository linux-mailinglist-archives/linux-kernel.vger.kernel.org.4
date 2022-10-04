Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD425F3DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJDIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJDILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B680B7E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92034219B8;
        Tue,  4 Oct 2022 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTFT5yEVOlKLOCaID7kgIamryAoTtu6/XvN1SSiAlzw=;
        b=kdiuydR83doqu1zgH2Q8g4k2CIkun36JJJGgvvNCCQMV2tEdZHUbekXwdIcZM7nMikm5Q4
        H0Nlw6ZjnS8JsX5zY9S5O6cVo10sGeeqJ39GuhG3Qtm3GXGhDO2K5tsNRpWMVbY5NKvtzf
        RRSwXaEvmcXc8HBpb2Psl3bj31FSeEk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 575A1139EF;
        Tue,  4 Oct 2022 08:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M44mFJrqO2NeSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 07/16] x86/mtrr: split generic_set_all()
Date:   Tue,  4 Oct 2022 10:10:14 +0200
Message-Id: <20221004081023.32402-8-jgross@suse.com>
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

Split generic_set_all() into multiple parts, while moving the main
function body into cacheinfo.c.

Prepare the support of PAT without needing MTRR support by
moving the main function body of generic_set_all() into cacheinfo.c
while renaming it to cache_cpu_init(). The MTRR specific parts are
moved into a dedicated small function called by cache_cpu_init() in
order to make cache_cpu_init() as MTRR agnostic as possible.

The setting of smp_changes_mask is merged into the (new) function
mtrr_generic_set_state() used to call set_mtrr_state(). It was
probably split in ancient times, as atomic operations while running
uncached might be quite expensive, but OTOH only systems with a
broken BIOS should ever require to set any bit in smp_changes_mask,
so just hurting those devices with a penalty of a few microseconds
during boot shouldn't be a real issue.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
V4:
- remove some comments (Borislav Petkov)
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
index ff32b2b1ca23..49b60a427fc9 100644
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

