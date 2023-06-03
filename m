Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3320721252
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjFCUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjFCUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:07:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CAE75
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:07:24 -0700 (PDT)
Message-ID: <20230603200459.717231106@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685822818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=I7I2EKoHeo/byjwgLE4HOlJ+wED05lzaQv+BpbzI77U=;
        b=IUrevXDafhxQpLh0SuAslVuhafF3e085DF4EC0XDwrP8KirhfW70LxmVA0yQBkAN089fV1
        xgb04EKn2nBiZfcWHV5dd+hXBzRkvKtJjfnzqmLOKKeyZVQVx0Hijqxe8a+fqRITiQK6Uy
        6rwJNJk4Uekr62dY1ag1j7pylEXmWsP/PGDQGhVrJCilWws69mT0bMHRlqrXlowbUT/xG+
        DhArg3tMUWupx+ywukQnAg37tt6FcMEsgrjQINvqgOrZSqe3Z7TtL20/Dze4ygSRVAQQtv
        3pFA2DdRTl+ylJ35vrK5DBRkV7SbvE6mb+QakAAnipAa23n6w4vFP6viBqi/1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685822818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=I7I2EKoHeo/byjwgLE4HOlJ+wED05lzaQv+BpbzI77U=;
        b=NSZ+nkDqpgXAzT5LDYYjC92Jhe41A25OJcBNQ50l8zJv063WLDMznbCPeL21GpuzRk1VZ7
        ZKh5N99eICdZnGDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch 2/6] x86/smp: Acquire stopping_cpu unconditionally
References: <20230603193439.502645149@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat,  3 Jun 2023 22:06:58 +0200 (CEST)
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
---
 arch/x86/kernel/smp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -152,6 +152,10 @@ static void native_stop_other_cpus(int w
 	if (reboot_force)
 		return;
 
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
+		return;
+
 	/*
 	 * Use an own vector here because smp_call_function
 	 * does lots of things not suitable in a panic situation.
@@ -167,10 +171,6 @@ static void native_stop_other_cpus(int w
 	 * finish their work before we force them off with the NMI.
 	 */
 	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*

