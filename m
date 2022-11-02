Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA4615D20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKBHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiKBHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:47:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2825EA8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA2E43373A;
        Wed,  2 Nov 2022 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wg1ltP5S2ST2D2shywYpbJwrHqpg2nHmgpqKBsh6EzQ=;
        b=MPB5tr1NRV+9NntC9d7piW075UGauYq/F0wIwl3hrWXHrOLpkt91GvuDjQ/bqOTrZjDpEU
        QX1BhBHf7jqkHc6qAYj9wTU4zVgjLARKDa3oAWOcyUM9u1SYh2gdoCx+sKKvTRrgd+a9qB
        owZ9Lyo3qx/EzoklDjpwBt/Ya9F0nZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B225A1376E;
        Wed,  2 Nov 2022 07:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zk5BKp8gYmO9cgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:43 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 05/16] x86/mtrr: split MTRR specific handling from cache dis/enabling
Date:   Wed,  2 Nov 2022 08:47:02 +0100
Message-Id: <20221102074713.21493-6-jgross@suse.com>
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

Split the MTRR specific actions from cache_disable() and cache_enable()
into the new functions mtrr_disable() and mtrr_enable().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- carved out from other patch (Borislav Petkov)
V5:
- use cpu_feature_enabled() (Borislav Petkov)
---
 arch/x86/include/asm/mtrr.h        |  4 ++++
 arch/x86/kernel/cpu/mtrr/generic.c | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 76d726074c16..12a16caed395 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -48,6 +48,8 @@ extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
+void mtrr_disable(void);
+void mtrr_enable(void);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -87,6 +89,8 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 #define set_mtrr_aps_delayed_init() do {} while (0)
 #define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
+#define mtrr_disable() do {} while (0)
+#define mtrr_enable() do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index aebdc90a2489..4edf0827f7ee 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -716,6 +716,21 @@ static unsigned long set_mtrr_state(void)
 	return change_mask;
 }
 
+void mtrr_disable(void)
+{
+	/* Save MTRR state */
+	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+
+	/* Disable MTRRs, and set the default type to uncached */
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+}
+
+void mtrr_enable(void)
+{
+	/* Intel (P6) standard MTRRs */
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+}
+
 /*
  * Disable and enable caches. Needed for changing MTRRs and the PAT MSR.
  *
@@ -764,11 +779,8 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
-	/* Save MTRR state */
-	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
-
-	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_disable();
 
 	/* Again, only flush caches if we have to. */
 	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
@@ -781,8 +793,8 @@ void cache_enable(void) __releases(cache_disable_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
-	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_enable();
 
 	/* Enable caches */
 	write_cr0(read_cr0() & ~X86_CR0_CD);
-- 
2.35.3

