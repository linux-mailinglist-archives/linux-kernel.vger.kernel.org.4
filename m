Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5372E2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbjFMMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbjFMMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5B10C6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:18:02 -0700 (PDT)
Message-ID: <20230613121615.874928734@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tVfoJ5rLMlFkeEBpRbPrXavA+I9P+UPy7NG09ZxG1es=;
        b=3Uwe3XzBEhnjJMIexwevv7CpqOvhCrzYSk5hZZIbs9UG6BnDKAnSMlinOnDqUrOhDyi8JM
        fAfqYqAodrOAb0kN+GyZiwgGTwZJJTMyfgSWAqmOZNz1GZCxOZmfcIni2i3Vf6znFC8Bfw
        JF1Pc5X9WRVpGvSTxXzMblqMnXa1vCmz+UaUCZjOA19bSXeszZTf4krYoaa7FdyWwwuFUa
        kqFR2xKDEHzq5zJeETAqHydDhiAlQP4dxsYR0l7Soep0wbngULTmfzzUXaWULM2V3y51u2
        hJgVWvUL1TmSQdcFY3IoTCDzFtlJX+SBa2FZEVzCDN8T3pssZj+nJFXSOo6NlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tVfoJ5rLMlFkeEBpRbPrXavA+I9P+UPy7NG09ZxG1es=;
        b=xhpN5AOuS/th5GqtT7cDKbuzAUDRbLG/yXjcoQ9RpGNpaFGApOFq1F/RqoiRVrIDFUuF2q
        RFKz4M60uLO8r/Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [patch V2 5/8] x86/smp: Use dedicated cache-line for mwait_play_dead()
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:18:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Monitoring idletask::thread_info::flags in mwait_play_dead() has been an
obvious choice as all what is needed is a cache line which is not written
by other CPUs.

But there is a use case where a "dead" CPU needs to be brought out of that
mwait(): kexec().

The CPU needs to be brought out of mwait before kexec() as kexec() can
overwrite text, pagetables, stacks and the monitored cacheline of the
original kernel. The latter causes mwait to resume execution which
obviously causes havoc on the kexec kernel which results usually in triple
faults.

Use a dedicated per CPU storage to prepare for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/smpboot.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,17 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -1758,10 +1769,10 @@ EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
@@ -1796,13 +1807,6 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
-
 	wbinvd();
 
 	while (1) {
@@ -1814,9 +1818,9 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 


