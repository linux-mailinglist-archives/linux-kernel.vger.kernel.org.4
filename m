Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE5E72E2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbjFMMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242277AbjFMMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5EDCE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:18:01 -0700 (PDT)
Message-ID: <20230613121615.820042015@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5gDoXglY/QeknUv64+zoXgi0Yj9FIJUXTEG9+0wz2Ho=;
        b=HDk3SkzLXmBKoEWWYdQhk62//czfpnloAdjufIsu9ln9M1Ia/twdJgubGCHXveDMBLSNoE
        LcBehRNNf84MCUSreODAFngI8vbo5637kUizdmU11YQUkLMBe3dJ5H4qozl7NIwF926g4v
        wX9JzZ/FoxH2riOgkVUFD9OcFG+ZITkwbm0TemDdm8QjlvAYEiZZ3hgNpvc0jVP6fWGNku
        pxm7wv4RNQSIUdSOYJ7NDMMkuGhH/9hFmX53oIsFzR+n8MXD2MuvpfQu6Cn0QmPgOE2MhQ
        SWf+ZWcbJkxe/q6+biIZolgD+kuNNrPqqgxy9dg8eaK8mJ/5rqOz86XU7WOPeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5gDoXglY/QeknUv64+zoXgi0Yj9FIJUXTEG9+0wz2Ho=;
        b=He364tdunJPaA7wqlPfGXiIfHsYqZG8Q3qlaaiQgoJafWURCpUyvS8b5vE+6oVNLgXvshQ
        rsW/e3A/5tZYG/CQ==
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
Subject: [patch V2 4/8] x86/smp: Acquire stopping_cpu unconditionally
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:17:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to acquire the stopping_cpu atomic_t only when there is
more than one online CPU.

Make it unconditional to prepare for fixing the kexec() problem when there
are present but "offline" CPUs which play dead in mwait_play_dead().

They need to be brought out of mwait before kexec() as kexec() can
overwrite text, pagetables, stacks and the monitored cacheline of the
original kernel. The latter causes mwait to resume execution which
obviously causes havoc on the kexec kernel which results usually in triple
faults.

Move the acquire out of the num_online_cpus() > 1 condition so the upcoming
'kick mwait' fixup is properly protected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/smp.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -153,6 +153,12 @@ static void native_stop_other_cpus(int w
 	if (reboot_force)
 		return;
 
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
+		return;
+
+	atomic_set(&stop_cpus_count, num_online_cpus() - 1);
+
 	/*
 	 * Use an own vector here because smp_call_function
 	 * does lots of things not suitable in a panic situation.
@@ -167,13 +173,7 @@ static void native_stop_other_cpus(int w
 	 * code.  By syncing, we give the cpus up to one second to
 	 * finish their work before we force them off with the NMI.
 	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
-
-		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
-
+	if (atomic_read(&stop_cpus_count) > 0) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*

