Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B35F3DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJDIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJDILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332838C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:10:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C8E1219BD;
        Tue,  4 Oct 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BdNeASTIsigsn6I6gmyehllEZ5HmkU4n1YF0DHyGpbk=;
        b=Ix0S2B9lhA4qEUjm+JLZOCjYCs/xP8J4zXUnkK6JaypVlLNIcDCZ5kJQYpvfJyqsoMYgUk
        5k6xl8jVh0n4Pgq4XmMDSdAl0Ho3+5c16a33gQSr9hiiw7fnkmcD8glAFy7vK2K2eHIDpa
        crTzy2P1dMQQRDuD5Y+1T6F/RmP/4ms=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14949139EF;
        Tue,  4 Oct 2022 08:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MpbcA4/qO2NTSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:10:55 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 05/16] x86/mtrr: split MTRR specific handling from cache dis/enabling
Date:   Tue,  4 Oct 2022 10:10:12 +0200
Message-Id: <20221004081023.32402-6-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
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
index aebdc90a2489..164d753e9867 100644
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
+	if (boot_cpu_has(X86_FEATURE_MTRR))
+		mtrr_disable();
 
 	/* Again, only flush caches if we have to. */
 	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
@@ -781,8 +793,8 @@ void cache_enable(void) __releases(cache_disable_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
-	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+	if (boot_cpu_has(X86_FEATURE_MTRR))
+		mtrr_enable();
 
 	/* Enable caches */
 	write_cr0(read_cr0() & ~X86_CR0_CD);
-- 
2.35.3

