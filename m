Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665A617BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKCLhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiKCLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:37:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4F12AAB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:37:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0F0C1F88F;
        Thu,  3 Nov 2022 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667475427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbTtzDPkc2Z0HXkinvq56o0oqCsbj4jxT6+YNZSa1dg=;
        b=sydXpXUw5sQi1V2fXzxjPOxoy9NCGXsDl7dVXLB2uiATJ0WdQuSvpKrLSfJQeqn7lbc6HD
        eZ8w6V0z388egjWyFL7OwV/sXlJj+XSBK+ln7dSy6iaQz308OfrscYVGsz+ovc+m45MSLX
        7UwWZlVGoaJbGnwNV071MwGELevOpy8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ABA613480;
        Thu,  3 Nov 2022 11:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3qiHHOOnY2McHwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 03 Nov 2022 11:37:07 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] x86: switch to cpu_feature_enabled() for X86_FEATURE_XENPV
Date:   Thu,  3 Nov 2022 12:36:36 +0100
Message-Id: <20221103113636.25543-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221103113636.25543-1-jgross@suse.com>
References: <20221103113636.25543-1-jgross@suse.com>
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

Convert the remaining cases of static_cpu_has(X86_FEATURE_XENPV) and
boot_cpu_has(X86_FEATURE_XENPV) to use cpu_feature_enabled(), allowing
more efficient code in case the kernel is configured without
CONFIG_XEN_PV.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/cpu/amd.c    | 2 +-
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 arch/x86/kernel/cpu/hygon.c  | 2 +-
 arch/x86/kernel/process_64.c | 4 ++--
 arch/x86/kernel/topology.c   | 2 +-
 arch/x86/mm/cpu_entry_area.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 860b60273df3..697fe881e967 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -985,7 +985,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_3DNOWPREFETCH);
 
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
-	if (!cpu_has(c, X86_FEATURE_XENPV))
+	if (!cpu_feature_enabled(X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
 	/*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index da7c361f47e0..7f78e1527c5e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1302,7 +1302,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_has(X86_FEATURE_XENPV)) {
+	if (cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 21fd425088fe..1c27645fd429 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -339,7 +339,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_ARAT);
 
 	/* Hygon CPUs don't reset SS attributes on SYSRET, Xen does. */
-	if (!cpu_has(c, X86_FEATURE_XENPV))
+	if (!cpu_feature_enabled(X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
 	check_null_seg_clears_base(c);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6b3418bff326..e2f469175be8 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -165,7 +165,7 @@ static noinstr unsigned long __rdgsbase_inactive(void)
 
 	lockdep_assert_irqs_disabled();
 
-	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		gsbase = rdgsbase();
 		native_swapgs();
@@ -190,7 +190,7 @@ static noinstr void __wrgsbase_inactive(unsigned long gsbase)
 {
 	lockdep_assert_irqs_disabled();
 
-	if (!static_cpu_has(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		wrgsbase(gsbase);
 		native_swapgs();
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index 8617d1ed9d31..1b83377274b8 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -106,7 +106,7 @@ int arch_register_cpu(int num)
 	 * Xen PV guests don't support CPU0 hotplug at all.
 	 */
 	if (c->x86_vendor != X86_VENDOR_INTEL ||
-	    boot_cpu_has(X86_FEATURE_XENPV))
+	    cpu_feature_enabled(X86_FEATURE_XENPV))
 		cpu0_hotpluggable = 0;
 
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b76a0b6..c83799753d44 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -147,7 +147,7 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	 * On Xen PV, the GDT must be read-only because the hypervisor
 	 * requires it.
 	 */
-	pgprot_t gdt_prot = boot_cpu_has(X86_FEATURE_XENPV) ?
+	pgprot_t gdt_prot = cpu_feature_enabled(X86_FEATURE_XENPV) ?
 		PAGE_KERNEL_RO : PAGE_KERNEL;
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
-- 
2.35.3

