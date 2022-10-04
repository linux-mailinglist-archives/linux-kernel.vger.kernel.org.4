Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE65F3DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJDIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJDIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F9010FE5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85098219B0;
        Tue,  4 Oct 2022 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tj4aELXaya1CaSjViiaKMXOfNXjJijcbMqgP3t4oiQA=;
        b=HVmgXUg+EIcCSmyVSFKEIollTXBD3At3iVM/zHCr25HtbpymoSptLLUWjnA0/Be+iOT1Tc
        ++I16uI7wsxXrt8/PKZvURJRNN98Kx0z3rLS6O6a9gZ7n4miZlcshAOLB/JODEsblBGbFz
        vxy5n8J7L55Bo34U6G74wbfBJEkjW0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BE01139EF;
        Tue,  4 Oct 2022 08:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 16syEavqO2OGSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:23 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 10/16] x86/mtrr: get rid of mtrr_enabled bool
Date:   Tue,  4 Oct 2022 10:10:17 +0200
Message-Id: <20221004081023.32402-11-jgross@suse.com>
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

There is no need for keeping mtrr_enabled, as it can easily be replaced
by testing mtrr_if to be not NULL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9e1b478ac896..7eed5387e828 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,7 +59,6 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool mtrr_enabled;
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
@@ -299,7 +298,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	int i, replace, error;
 	mtrr_type ltype;
 
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return -ENXIO;
 
 	error = mtrr_if->validate_add_page(base, size, type);
@@ -447,7 +446,7 @@ static int mtrr_check(unsigned long base, unsigned long size)
 int mtrr_add(unsigned long base, unsigned long size, unsigned int type,
 	     bool increment)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -476,7 +475,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return -ENODEV;
 
 	max = num_var_ranges;
@@ -536,7 +535,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
  */
 int mtrr_del(int reg, unsigned long base, unsigned long size)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -562,7 +561,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
-	if (pat_enabled() || !mtrr_enabled)
+	if (pat_enabled() || !mtrr_if)
 		return 0;  /* Success!  (We don't need to do anything.) */
 
 	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
@@ -751,22 +750,21 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (mtrr_if) {
-		mtrr_enabled = true;
 		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
 		init_table();
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
-			mtrr_enabled = get_mtrr_state();
-
-			if (mtrr_enabled) {
+			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 				cache_cpu_init();
+			} else {
+				mtrr_if = NULL;
 			}
 		}
 	}
 
-	if (!mtrr_enabled) {
+	if (!mtrr_if) {
 		pr_info("Disabled\n");
 
 		/*
@@ -807,7 +805,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
@@ -852,7 +850,7 @@ void mtrr_bp_restore(void)
 
 static int __init mtrr_init_finialize(void)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_if)
 		return 0;
 
 	if (memory_caching_control & CACHE_MTRR) {
-- 
2.35.3

