Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034E7320F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbjFOUeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFOUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:33:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8E12711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:33:56 -0700 (PDT)
Message-ID: <20230615193330.378358382@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686861234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1+WMbgfctMXWtOKcGKW/wJHvdbPeyuqNojFzRQeoCU8=;
        b=nUb0Dcd9Wxw6PxWAFilnXXJDm3n0Hf3nSKfqXxWsDlM7mbktaUcmJctrcP9SYfyabnw2hC
        5qyHXKmjYRXGw+qgkO1C4Jde5AlWm4C+rOpMSBFJXGXKZL3zU2Jmp+TbGHUoRIBY92hvdY
        C9fJFhu+lqjrx3t0EQzpEbBZXwcbMEGQxTgFKXB2WwO/C4a9OzrjqH1l2lBzElxvquE1r+
        WIg38DEhP61uumeEFZsfRX4iKLRh9ITsbMPB2iCwWEVMAMSrBrftJWdcinwGmes0wKsBF4
        xD9Iw4pDCKXMhaVLpeWAQ3nC8BGmRXj4b5EGW+5NWXq+JdMWKyNXNIUxLO1SgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686861234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1+WMbgfctMXWtOKcGKW/wJHvdbPeyuqNojFzRQeoCU8=;
        b=vfWJWIssuqpvGT6HKL9HUhoEwkD5Lk4wGLv8q2r4naRUuPPfJ2L5kKHHKCsTr4Sc8Fo3p2
        W1YK1YIMjsjup5Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch v3 3/7] x86/smp: Remove pointless wmb()s from native_stop_other_cpus()
References: <20230615190036.898273129@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 15 Jun 2023 22:33:54 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wmb()s before sending the IPIs are not synchronizing anything.

If at all then the apic IPI functions have to provide or act as appropriate
barriers.

Remove these cargo cult barriers which have no explanation of what they are
synchronizing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Remove second instance and reword changelog - PeterZ
---
 arch/x86/kernel/smp.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -184,9 +184,6 @@ static void native_stop_other_cpus(int w
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		/* sync above data before sending IRQ */
-		wmb();
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
@@ -210,9 +207,6 @@ static void native_stop_other_cpus(int w
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
 			u32 dm;
 
-			/* Sync above data before sending IRQ */
-			wmb();
-
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;

