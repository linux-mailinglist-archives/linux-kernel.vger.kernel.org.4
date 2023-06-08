Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFABB728456
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbjFHP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFHP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:56:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E692D78;
        Thu,  8 Jun 2023 08:56:19 -0700 (PDT)
Date:   Thu, 08 Jun 2023 15:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686239768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tuM5H6dKcVbkf17tJtrD+wwLgAEUVhTL/oSDY8dt4fU=;
        b=ToWxqc6om6LA3T9lhScIy3vQiKfQJAA8wPHMnZDWjweWTqVzTlhjjBNwvCh+BIoHhBvMzW
        1yjQNZ39FD7jYpLwbgTOsXWcAXIUIJyAMcefH2HFMDX1s7sv8oOW+4Cl3tvzTnaFF98jc7
        aaPvQLAQLPl9r0YlqBYmQkQA8KwIMuzuNsdLjAGyfgT+Vjuc4iFRtJnfq3JxmnYoWr0bmD
        xiwtf3Xhyt/STUy+6UCS9u8yMuY/CEl2gaE5yU68vBMmPXuTyjEjbxX3EqILeeRaPAzZ1t
        8xXgaYDN+7PxoqWf4fOhdB1RQYGE7XitMNyiiqzZ6YVXOL8E2u7hPNZcO6w7fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686239768;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tuM5H6dKcVbkf17tJtrD+wwLgAEUVhTL/oSDY8dt4fU=;
        b=PfW4JI9Wd/DUJF993JhbL/8kD2J8OldbhzzEnZwcF8zkTY05sVRJkyDcl4aZW3RdexwAUi
        TZcrtXVrwUcJh6Aw==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Add hardcoded hypervisor interrupts to /proc/stat
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168623976753.404.15778077002111483150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     504dba50b0c3fa02ec513d7d0405ddffba2d1c0a
Gitweb:        https://git.kernel.org/tip/504dba50b0c3fa02ec513d7d0405ddffba2d1c0a
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Mon, 27 Feb 2023 10:46:08 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 08 Jun 2023 08:28:08 -07:00

x86/irq: Add hardcoded hypervisor interrupts to /proc/stat

Some hypervisor interrupts (such as for Hyper-V VMbus and Hyper-V timers)
have hardcoded interrupt vectors on x86 and don't have Linux IRQs assigned.
These interrupts are shown in /proc/interrupts, but are not reported in
the first field of the "intr" line in /proc/stat because the x86 version
of arch_irq_stat_cpu() doesn't include them.

Fix this by adding code to arch_irq_stat_cpu() to include these interrupts,
similar to existing interrupts that don't have Linux IRQs.

Use #if IS_ENABLED() because unlike all the other nearby #ifdefs,
CONFIG_HYPERV can be built as a module.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/1677523568-50263-1-git-send-email-mikelley%40microsoft.com
---
 arch/x86/kernel/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 766ffe3..9f668d2 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -211,6 +211,13 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 #ifdef CONFIG_X86_MCE_THRESHOLD
 	sum += irq_stats(cpu)->irq_threshold_count;
 #endif
+#ifdef CONFIG_X86_HV_CALLBACK_VECTOR
+	sum += irq_stats(cpu)->irq_hv_callback_count;
+#endif
+#if IS_ENABLED(CONFIG_HYPERV)
+	sum += irq_stats(cpu)->irq_hv_reenlightenment_count;
+	sum += irq_stats(cpu)->hyperv_stimer0_count;
+#endif
 #ifdef CONFIG_X86_MCE
 	sum += per_cpu(mce_exception_count, cpu);
 	sum += per_cpu(mce_poll_count, cpu);
