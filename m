Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF36B735DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjFSTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFSTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:10:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C39C;
        Mon, 19 Jun 2023 12:10:49 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:10:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687201847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RArQM0+vEpbmY2TBMGIyzGSZCOddW5TaaQ+oLRvEaLo=;
        b=Tgb/SUOJ229Prfl8me5zen9JUzcr4j/7IrQG3vgwTn5T7KNmmPFKSERDusZt6uCasbqT2P
        b0ygboVWA0pUv0bex4pmvc681Pa53fwUHbYJTF9KYna6W3z7VSG0hDgb0vVujvdf6rY5bN
        gRuetMIjcjV+bPX3aTfk9BOW+f+fO8mud9uZEI0hrfwzeHMOdSmCAudHm/SH5uvRKgEH+j
        +a0v0wj5dwmjM3YiMqWkHlgRbK8TLmQalW2elboypwZDn/92MVHXG+LdipwYCAJxWhPHwR
        ZHX0QyCyPLQWvkjkYfmoEVySeOMim450k9epochhO+MhDKqzRb1J1WPalHwhDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687201847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RArQM0+vEpbmY2TBMGIyzGSZCOddW5TaaQ+oLRvEaLo=;
        b=E7pvXYdSVvDoR1MU2wlD+U7hft+Rs3RamhYeMwvFNVj3zvzx06m1SF6almagY2iM/K16Ql
        AJX7iqc64Bp8pbBA==
From:   "tip-bot2 for Dheeraj Kumar Srivastava" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Fix kernel panic when booting with
 intremap=off and x2apic_phys
Cc:     Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
References: <20230616212236.1389-1-dheerajkumar.srivastava@amd.com>
MIME-Version: 1.0
Message-ID: <168720184607.404.13278064522951862638.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     85d38d5810e285d5aec7fb5283107d1da70c12a9
Gitweb:        https://git.kernel.org/tip/85d38d5810e285d5aec7fb5283107d1da70c12a9
Author:        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
AuthorDate:    Sat, 17 Jun 2023 02:52:36 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jun 2023 20:59:40 +02:00

x86/apic: Fix kernel panic when booting with intremap=off and x2apic_phys

When booting with "intremap=off" and "x2apic_phys" on the kernel command
line, the physical x2APIC driver ends up being used even when x2APIC
mode is disabled ("intremap=off" disables x2APIC mode). This happens
because the first compound condition check in x2apic_phys_probe() is
false due to x2apic_mode == 0 and so the following one returns true
after default_acpi_madt_oem_check() having already selected the physical
x2APIC driver.

This results in the following panic:

   kernel BUG at arch/x86/kernel/apic/io_apic.c:2409!
   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc2-ver4.1rc2 #2
   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
   RIP: 0010:setup_IO_APIC+0x9c/0xaf0
   Call Trace:
    <TASK>
    ? native_read_msr
    apic_intr_mode_init
    x86_late_time_init
    start_kernel
    x86_64_start_reservations
    x86_64_start_kernel
    secondary_startup_64_no_verify
    </TASK>

which is:

setup_IO_APIC:
  apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
  for_each_ioapic(ioapic)
  	BUG_ON(mp_irqdomain_create(ioapic));

Return 0 to denote that x2APIC has not been enabled when probing the
physical x2APIC driver.

  [ bp: Massage commit message heavily. ]

Fixes: 9ebd680bd029 ("x86, apic: Use probe routines to simplify apic selection")
Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230616212236.1389-1-dheerajkumar.srivastava@amd.com
---
 arch/x86/kernel/apic/x2apic_phys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a..896bc41 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
