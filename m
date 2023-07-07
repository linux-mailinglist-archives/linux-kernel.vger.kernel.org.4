Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855AA74B22B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGGNtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjGGNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:49:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89084211C;
        Fri,  7 Jul 2023 06:49:04 -0700 (PDT)
Date:   Fri, 07 Jul 2023 13:49:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688737741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOp3f4wh/6xnl+G448V8SHs5VAzAGxRkAFRFPsNd6ro=;
        b=eefyaulPDjU4YtiKUPSsEkFVXilAuwpCAXf/IPnxeF50v9mFWwkvnqQN4rEgo4lUHcXZ1S
        sajBuZXLJttONqBTavkECkCeJAWAO6F8XmdoEQdpuRosscwy1WqWx5Rg3bbYLBq1ZMUJ/e
        hyqNJVYrOC3lyOxps/utEgKU2Pn5RMKDkQcVMiezs//23QXuODHohmv8lW5/ui20S/Rk6F
        SCndamPQu+4SsKr9lZqL4mlnlDBhxvd3baeE+btN95R4vI+CivV8bsvnn2jVZRD1kgphlj
        R6+JZH9br1yn5gxjt+SVf0IlHgFCmTuLzOazdRR0TJDoniLWoRtPNnaRJWIAUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688737741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOp3f4wh/6xnl+G448V8SHs5VAzAGxRkAFRFPsNd6ro=;
        b=vBWSWY76UFRUBiHRIiWzmDnyuHuZtY0uHSzZgEvmB7x7tmzQSyRWvZ43GyMlH+nholizRD
        yNtHJpw847o3L3BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Don't send INIT to boot CPU
Cc:     Baokun Li <libaokun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87ttui91jo.ffs@tglx>
References: <87ttui91jo.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168873774104.404.4503374695287410422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b1472a60a584694875a05cf8bcba8bdf0dc1cd3a
Gitweb:        https://git.kernel.org/tip/b1472a60a584694875a05cf8bcba8bdf0dc1cd3a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 05 Jul 2023 10:59:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Jul 2023 15:42:31 +02:00

x86/smp: Don't send INIT to boot CPU

Parking CPUs in INIT works well, except for the crash case when the CPU
which invokes smp_park_other_cpus_in_init() is not the boot CPU. Sending
INIT to the boot CPU resets the whole machine.

Prevent this by validating that this runs on the boot CPU. If not fall back
and let CPUs hang in HLT.

Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
Reported-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/87ttui91jo.ffs@tglx
---
 arch/x86/kernel/smpboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4ee4339..7417d9b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1473,6 +1473,14 @@ bool smp_park_other_cpus_in_init(void)
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
 
+	/*
+	 * If this is a crash stop which does not execute on the boot CPU,
+	 * then this cannot use the INIT mechanism because INIT to the boot
+	 * CPU will reset the machine.
+	 */
+	if (this_cpu)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		if (cpu == this_cpu)
 			continue;
