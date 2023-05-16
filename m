Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E827048AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjEPJLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjEPJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580722D55;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Te3ghZBp6wpNyW2Ta4F0OhsvLt52lAei2YT8fMwsGOE=;
        b=oMRzZwaE8MG0/fI/DWq80Ngrg6GhItOzLl+yL1oFIPi9aBIU0fF9Rmct1J9SJ7MhZCJloj
        zSkQ7Kmv1IxL35tO90h5R1MdE+21aBclONqV3UnExHUGGjj9iPxs/ZCA6S5rqZYR7PlGp8
        3wTmdybKZycE7H3WKax+dSETsPRGNVoYVGefmw9mjK0VWp3YDzJ7XnEXxxXuoos+IEfNBL
        n8lDC74hLoyh0sHlo+xLPM1qkpCTwmEWZI+20YTkpk8DaPjjVFVtAL4lVkj9K27w3sneXZ
        HXUwCwDjZlClm1u2ZSToR8Hra7G+EbWmZcbNwr2b4sSEj3EvAjTDdsoAPeytkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Te3ghZBp6wpNyW2Ta4F0OhsvLt52lAei2YT8fMwsGOE=;
        b=AaeadbfmMZ92AWeTi8Ym6VDoIj1PVMCNUZKk2X00wlvBsmEe2yExSxXvmzn7UshgA9n+yY
        UX1IuTmi76uMQ9DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/xen/smp_pv: Remove wait for CPU online
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.369512093@linutronix.de>
References: <20230512205256.369512093@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819921.404.10642421522981044037.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     2de7fd26d90729c4e3430f9924b199dea810a9bc
Gitweb:        https://git.kernel.org/tip/2de7fd26d90729c4e3430f9924b199dea810a9bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:54 +02:00

x86/xen/smp_pv: Remove wait for CPU online

Now that the core code drops sparse_irq_lock after the idle thread
synchronized, it's pointless to wait for the AP to mark itself online.

Whether the control CPU runs in a wait loop or sleeps in the core code
waiting for the online operation to complete makes no difference.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.369512093@linutronix.de
---
 arch/x86/xen/smp_pv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a6f9128..be40927 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -340,11 +340,11 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 
 	xen_pmu_init(cpu);
 
-	rc = HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL);
-	BUG_ON(rc);
-
-	while (cpu_report_state(cpu) != CPU_ONLINE)
-		HYPERVISOR_sched_op(SCHEDOP_yield, NULL);
+	/*
+	 * Why is this a BUG? If the hypercall fails then everything can be
+	 * rolled back, no?
+	 */
+	BUG_ON(HYPERVISOR_vcpu_op(VCPUOP_up, xen_vcpu_nr(cpu), NULL));
 
 	return 0;
 }
