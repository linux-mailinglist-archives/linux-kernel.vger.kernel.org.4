Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628D634336
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiKVSEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKVSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1669DFC;
        Tue, 22 Nov 2022 10:04:49 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:04:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669140288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM9Haxtja/rzotjBDL/zaDOhtdRf7kjx78vBOLGk9f8=;
        b=jrht4SGaTiyC/2ftjGt73WocBAavHHSeLtcZ/ptd6YE75KknzoavcGbUYu0CaTn65RWagY
        jZ/lyQkpo7FdgITx6OCp/N6RN6utL0HbYnb9XHwLWTcxntxXz37zdsDyYNDFzQEBEWgqD8
        5KiIp0Xc/AAal0e7Irq8IDA3SajkK4i6zF4Qn1NXDs6s5hRe/F2yoQuC3RRVmMobj+bMOu
        NQXGym8QT8iFJTtxv6ZOQqAxSNt6a5TBnyAfLN/d2vZ3Sz4I5nAKhXFziaOocWfxdqlA4W
        qFyCv1IvMwoNhCPADB9yptGWezQQVWYCO2tJqGPNebEzfhHWXFseDmSCr+HqfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669140288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM9Haxtja/rzotjBDL/zaDOhtdRf7kjx78vBOLGk9f8=;
        b=2gdgU5tIEm7HbhTPFqEZSWVk6aGU65XJ1OBs+qZrJO+MarWtY2TVLRjHcVbHS23mCAIScp
        LSDXP2rjGV+G0gAw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Switch to cpu_feature_enabled() for X86_FEATURE_XENPV
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104072701.20283-6-jgross@suse.com>
References: <20221104072701.20283-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166914028671.4906.3926993921929501636.tip-bot2@tip-bot2>
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

Commit-ID:     6007878a782eb96f50a71c3a06cf3e931cf8aac1
Gitweb:        https://git.kernel.org/tip/6007878a782eb96f50a71c3a06cf3e931cf8aac1
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 04 Nov 2022 08:27:01 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 16:18:19 +01:00

x86/cpu: Switch to cpu_feature_enabled() for X86_FEATURE_XENPV

Convert the remaining cases of static_cpu_has(X86_FEATURE_XENPV) and
boot_cpu_has(X86_FEATURE_XENPV) to use cpu_feature_enabled(), allowing
more efficient code in case the kernel is configured without
CONFIG_XEN_PV.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221104072701.20283-6-jgross@suse.com
---
 arch/x86/kernel/cpu/amd.c    | 2 +-
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 arch/x86/kernel/cpu/hygon.c  | 2 +-
 arch/x86/kernel/process_64.c | 4 ++--
 arch/x86/kernel/topology.c   | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 860b602..697fe88 100644
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
index e254f07..9e84b68 100644
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
index 21fd425..1c27645 100644
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
index 6b3418b..e2f4691 100644
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
index 8617d1e..1b83377 100644
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
