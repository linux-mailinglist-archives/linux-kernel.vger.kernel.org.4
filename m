Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AB8736CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjFTNBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjFTNBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03119AB;
        Tue, 20 Jun 2023 06:00:53 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:00:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687266052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqBcLkeqh5aYZLHq2KtPr0BsS5m73Epy5K0pPEmT8hY=;
        b=YxdR8RPnZuF2m0qhyttRSqTE0GAnxOzZMGGaR+mZGxt+pznxLT8620EZuTHDN4XdELdGFM
        wWHpkZuswoq22IU5M4TXUS+Bc7tLdTxvqLfoQqPnIkCihTldbhKkdAV699HKTB7+c15V9D
        WjxApCK0zbfBS4XDw6GlNM3xeLVVOJ42i5e4GuMDaWqRJf6XMbOL2iTO0BuS0gVWTRIs0H
        f7LxyEm2dJc/9sevhAzNWwR7OWo9V/ck//uP4c+bHzWxJKKr9lcXeZUEjvL2FXhDFu6NIm
        wbUQCQQJyxkAgVs/CYny8/VgNzAvIwPPtm2oGopeYrMUEELi86gKjBKyy2lyYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687266052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqBcLkeqh5aYZLHq2KtPr0BsS5m73Epy5K0pPEmT8hY=;
        b=UGUxET9Ks98DFFpDaso9wT9wK9vHuEaJMlVWCgZMtbcI8VQ4RqD5vHTMJzNbAJWRVpYJnY
        C0c2iap+OtZC8aDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Remove pointless wmb()s from
 native_stop_other_cpus()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230615193330.378358382@linutronix.de>
References: <20230615193330.378358382@linutronix.de>
MIME-Version: 1.0
Message-ID: <168726605177.404.10010804348087139293.tip-bot2@tip-bot2>
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

Commit-ID:     2affa6d6db28855e6340b060b809c23477aa546e
Gitweb:        https://git.kernel.org/tip/2affa6d6db28855e6340b060b809c23477aa546e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Jun 2023 22:33:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jun 2023 14:51:46 +02:00

x86/smp: Remove pointless wmb()s from native_stop_other_cpus()

The wmb()s before sending the IPIs are not synchronizing anything.

If at all then the apic IPI functions have to provide or act as appropriate
barriers.

Remove these cargo cult barriers which have no explanation of what they are
synchronizing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615193330.378358382@linutronix.de

---
 arch/x86/kernel/smp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 935bc65..d842875 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -184,9 +184,6 @@ static void native_stop_other_cpus(int wait)
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		/* sync above data before sending IRQ */
-		wmb();
-
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
@@ -208,9 +205,6 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
-			/* Sync above data before sending IRQ */
-			wmb();
-
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
