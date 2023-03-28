Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACE46CB809
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjC1HaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1HaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:30:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B7A1B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:30:10 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6B6D420FD8EC;
        Tue, 28 Mar 2023 00:30:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B6D420FD8EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679988609;
        bh=X1+IXhaGBjoGy3PxhXS/a18fqB4QyfwW9CTWlMUwUws=;
        h=From:To:Subject:Date:From;
        b=hfoLWg8vj4WLbrpXLideKpAKb+qy6NNoJmu7RNCjwZrbjObyuXkmbs47llhcP0FWk
         5SsfcCYJtja8MlJyn6ChESUIJcCdPMBrvgfb/UEvp7FFkC5tK6GI2mQJQaLjXKFL8A
         KEOXGjf0lyMCZJJ+EdqgRPLy7zUdiuh6R8ZTNF/g=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, ssengar@linux.microsoft.com
Subject: [PATCH v2] x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()
Date:   Tue, 28 Mar 2023 00:30:04 -0700
Message-Id: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
registered, but ioapic_dynirq_base is 0 in case of device tree setups.

Consolidate this and zero check for both ioapic_dynirq_base and gsi_top,
which is used in the case that no IO/APIC is registered.

Fixes: 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines")
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
[V2]
- Edit commit message
- Consolidated the 0 check for ioapic_dynirq_base as well

 arch/x86/kernel/apic/io_apic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1f83b052bb74..f980b38b0227 100644
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
-- 
2.34.1

