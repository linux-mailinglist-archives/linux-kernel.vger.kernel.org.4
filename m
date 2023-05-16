Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27ED7048AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjEPJLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjEPJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE02D53;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dz97XQ5meyngqjRIFPYPmInwSGxHK9PFZi+D8liCts=;
        b=nOO10I37aXxk1FFG76fYu7Q43IDEhTKJ/gM/e66DNuJBhOC45ZmeMx4P+K7IE0BVjineZo
        ARpBzNoRMbXrw71wMLwoh/8oJsDAVIWSN8vGxZBiIK2nFu7bAqLBBo9imndvq1aX8Q5BgK
        7KxEQxFJCM//iJhQvBAFChheAvdsRkFo8yZmAActgwQyEFFBpoyeUBJQHUMZgRiHAfFSTZ
        3vNpBPX6wSUQB9tTV3k+vxWAH7lJSjRqSbZjTM1mmxTEh4DVlHpobFWNk723knS8aMBqlz
        fpscwW6DW1+83tcVfwxvBcglckx9QrtdkE4IWxR/ulXhwldxIS3Jn1YgS/HyPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Dz97XQ5meyngqjRIFPYPmInwSGxHK9PFZi+D8liCts=;
        b=o4ty2sWqQiQ/1JbpLIY8Du3+gJJcROiyCxFY1zrUJPGjgPuQqX/hx6vYruBMmktGNBs7oV
        wHS6bVA+SEv75kAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/xen/hvm: Get rid of DEAD_FROZEN handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.423407127@linutronix.de>
References: <20230512205256.423407127@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819895.404.9292905514858665876.tip-bot2@tip-bot2>
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

Commit-ID:     ab24eb9abb9c60c45119370731735b79ed79f36c
Gitweb:        https://git.kernel.org/tip/ab24eb9abb9c60c45119370731735b79ed79f36c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:55 +02:00

x86/xen/hvm: Get rid of DEAD_FROZEN handling

No point in this conditional voodoo. Un-initializing the lock mechanism is
safe to be called unconditionally even if it was already invoked when the
CPU died.

Remove the invocation of xen_smp_intr_free() as that has been already
cleaned up in xen_cpu_dead_hvm().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.423407127@linutronix.de
---
 arch/x86/xen/enlighten_hvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1cd28e..a6820ca 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -161,13 +161,12 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	int rc = 0;
 
 	/*
-	 * This can happen if CPU was offlined earlier and
-	 * offlining timed out in common_cpu_die().
+	 * If a CPU was offlined earlier and offlining timed out then the
+	 * lock mechanism is still initialized. Uninit it unconditionally
+	 * as it's safe to call even if already uninited. Interrupts and
+	 * timer have already been handled in xen_cpu_dead_hvm().
 	 */
-	if (cpu_report_state(cpu) == CPU_DEAD_FROZEN) {
-		xen_smp_intr_free(cpu);
-		xen_uninit_lock_cpu(cpu);
-	}
+	xen_uninit_lock_cpu(cpu);
 
 	if (cpu_acpi_id(cpu) != U32_MAX)
 		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
