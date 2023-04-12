Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79E66DFA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDLPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:55:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FB40FB;
        Wed, 12 Apr 2023 08:55:51 -0700 (PDT)
Date:   Wed, 12 Apr 2023 15:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681314950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyJPOKJL8+7PQlCso7HQtQzxVvaJLCpeyOybz5yLnSM=;
        b=lwj7Gv9H1KVkoBLmvX/XSgDZwo1kHBkjV9cqV8VFW8qDK0eAg0ZI+eeO1eHCegSO++XkQt
        DinfwyY60QU6zaYyJAdcjlEjTYF1n4vaijWll3nglLgPb+bsQZCfro61bK+Nd1nRmBKLX1
        P5Vfab6H9db+4q8J+MfpzluVDEe5gt94e9yeqP+1x56Eg/+PEfaxBFA9dGZZyO1HrgN0F5
        oVxLO4S/kbfN0/fV3dHv8CQbczFJG+aVZQgDD1M51g/LIfDO+2i9z2mgAUfomPD0RdUgpv
        hqtl3UTJHWsU6uszjJuskHFlQA5Vhjf7XPD8Zja4XlwIFZihQ8tlhDZdB1HC9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681314950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyJPOKJL8+7PQlCso7HQtQzxVvaJLCpeyOybz5yLnSM=;
        b=xAgSbDNPxDPg3ceO3tXHmodpHf/GIqE5R/zPTpdyYe9Y/YasA5gUz8xAbleHa6+hOrfO42
        r458FjoyPI8f2QCw==
From:   "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Message-ID: <168131494872.404.16905626584604172948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5af507bef93c09a94fb8f058213b489178f4cbe5
Gitweb:        https://git.kernel.org/tip/5af507bef93c09a94fb8f058213b489178f4cbe5
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Tue, 28 Mar 2023 00:30:04 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 12 Apr 2023 17:45:50 +02:00

x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

arch_dynirq_lower_bound() is invoked by the core interrupt code to
retrieve the lowest possible Linux interrupt number for dynamically
allocated interrupts like MSI.

The x86 implementation uses this to exclude the IO/APIC GSI space.
This works correctly as long as there is an IO/APIC registered, but
returns 0 if not. This has been observed in VMs where the BIOS does
not advertise an IO/APIC.

0 is an invalid interrupt number except for the legacy timer interrupt
on x86. The return value is unchecked in the core code, so it ends up
to allocate interrupt number 0 which is subsequently considered to be
invalid by the caller, e.g. the MSI allocation code.

The function has already a check for 0 in the case that an IO/APIC is
registered, as ioapic_dynirq_base is 0 in case of device tree setups.

Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
which is used in the case that no IO/APIC is registered.

Fixes: 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com

---
 arch/x86/kernel/apic/io_apic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1f83b05..f980b38 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2477,17 +2477,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret = ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
 
 #ifdef CONFIG_X86_32
