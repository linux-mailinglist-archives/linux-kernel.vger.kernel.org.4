Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED85F3DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJDIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJDILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D065E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9155219B8;
        Tue,  4 Oct 2022 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjhFAyaLqHCvH39OzmLQawxoUpOV57qVfOb8KdlLKqU=;
        b=Qu9GfqpWZThC6n5lS+NuScgyxncCUmPfeWruyEnqHwTG9ERA0mk8rsajox67GNb7YtVuXc
        1G6o9U3YnjxUwvRFTcba0qKXfcyvaMaC7iA0KzALvb+9Pm0BWPUJdgv/Y9wrfY5cxb2YaY
        8NDDpZyzE+9oRJk6wE5xC3GPLOmfZeo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DCD9139EF;
        Tue,  4 Oct 2022 08:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YNlOJaXqO2NxSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:17 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 09/16] x86/mtrr: simplify mtrr_bp_init()
Date:   Tue,  4 Oct 2022 10:10:16 +0200
Message-Id: <20221004081023.32402-10-jgross@suse.com>
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

In case of the generic cache interface being used (Intel CPUs or a
64-bit system), the initialization sequence of the boot CPU is more
complicated as necessary:

- check if MTRR enabled, if yes, call mtrr_bp_pat_init() which will
  disable caching, set the PAT MSR, and reenable caching

- call mtrr_cleanup(), in case that changed anything, call
  cache_cpu_init() doing the same caching disable/enable dance as
  above, but this time with setting the (modified) MTRR state (even
  if MTRR was disabled) AND setting the PAT MSR (again even with
  disabled MTRR)

The sequence can be simplified a lot while removing potential
inconsistencies:

- check if MTRR enabled, if yes, call mtrr_cleanup() and then
  cache_cpu_init()

This ensures to:

- no longer disable/enable caching more than once

- avoid to set MTRRs and/or the PAT MSR on the boot processor in case
  of MTRR cleanups even if MTRRs meant to be disabled

With that mtrr_bp_pat_init() can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mtrr/generic.c | 14 --------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  6 +-----
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  1 -
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index af8422c96b92..2f2485d6657f 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -442,20 +442,6 @@ static void __init print_mtrr_state(void)
 		pr_debug("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
 }
 
-/* PAT setup for BP. We need to go through sync steps here */
-void __init mtrr_bp_pat_init(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cache_disable();
-
-	pat_init();
-
-	cache_enable();
-	local_irq_restore(flags);
-}
-
 /* Grab all of the MTRR state for this CPU into *state */
 bool __init get_mtrr_state(void)
 {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 501ca1747d55..9e1b478ac896 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -759,12 +759,8 @@ void __init mtrr_bp_init(void)
 			mtrr_enabled = get_mtrr_state();
 
 			if (mtrr_enabled) {
-				mtrr_bp_pat_init();
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
-			}
-
-			if (mtrr_cleanup(phys_addr)) {
-				changed_by_mtrr_cleanup = 1;
+				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 				cache_cpu_init();
 			}
 		}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 3b1883185185..c98928ceee6a 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -50,7 +50,6 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
-void mtrr_bp_pat_init(void);
 
 extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
 
-- 
2.35.3

