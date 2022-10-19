Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366B8604291
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJSLGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiJSLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:06:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD045D0CF1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:35:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666171124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dszFvwRRqgYPYmZS5tBZgKWOHRKBqULvHf1enENPjfw=;
        b=fXwEIkIYNl/xrJnRWxeLhInEkdPDTIU8JDE9a2rQDU7RxgXVk9Hy3TIgpetghsHqGOkARJ
        zHb9evHnq5Auj738FgDXfRxR6gFqfz9KxiTWQNDegcDWPEOh4JwmbdmSjvnPMngcOjmcUG
        0vj31prXr+bObGiFioMSFS3FuCoZmEemt0qNqfDgS4V+znZwD8NLjn2Kk02pJUXRM6rJ1q
        zmFy9ZnmVxNUnOK1YrFYHwoSIWMNzqAHsNKY88zp6i8qkQjY2QzOqVBUn1OhkHMqrCk1wz
        /FB3P+8OPdQ9rOUB3bd8LTAh2eALU8cw70f7kIL4c2EZNBu2az13+LU1rmu6Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666171124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dszFvwRRqgYPYmZS5tBZgKWOHRKBqULvHf1enENPjfw=;
        b=G1+GcVz73SDytlqMlIJx1ouAEOHATsZfxMmt5cQkpcUMIv1uqlJjlhMC5IZ+OtRkym/ZkN
        4hh4ME/WP6slQbCQ==
To:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Feng Tang <feng.tang@intel.com>, Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH v2] x86/tsc: Extend watchdog check exemption to
 4-Sockets platform
In-Reply-To: <20221013131200.973649-1-feng.tang@intel.com>
References: <20221013131200.973649-1-feng.tang@intel.com>
Date:   Wed, 19 Oct 2022 11:18:43 +0200
Message-ID: <87tu40p3ws.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2022 at 21:12, Feng Tang wrote:
> There is report again that the tsc clocksource on a 4 sockets x86
> Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> and disabled [1].
>
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduce to deal with these false
> alarms of tsc unstable issues, covering qualified platforms for 2
> sockets or smaller ones.
>
> Extend the exemption to 4 sockets to fix the issue.
>
> We also got similar reports on 8 sockets platform from internal test,
> but as Peter pointed out, there was tsc sync issues for 8-sockets
> platform, and it'd better be handled architecture by architecture,
> instead of directly changing the threshold to 8 here.
>
> Rui also proposed another way to disable 'jiffies' as clocksource
> watchdog [2], which can also solve this specific problem in an
> architecture independent way, with one limitation that some tsc false
> alarms are reported by other watchdogs like HPET in post-boot time,
> while 'jiffies' is mostly used in boot phase before hardware
> clocksources are initialized.

HPET is initialized early, but if HPET is disabled or not advertised
then the only other hardware clocksource is PMTIMER which is initialized
late via fs_initcall. PMTIMER is initialized late due to broken Pentium
era chipsets which are sorted with PCI quirks. For anything else we can
initialize it early. Something like the below.

I'm sure I said this more than once, but I'm happy to repeat myself
forever:

  Instead of proliferating lousy hacks, can the X86 vendors finaly get
  their act together and provide some architected information whether
  the TSC is trustworthy or not?

Thanks,

        tglx
---

--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/acpi_pmtmr.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -75,6 +76,14 @@ static void __init setup_default_timer_i
 void __init hpet_time_init(void)
 {
 	if (!hpet_enable()) {
+		/*
+		 * Some Pentium chipsets have broken HPETs and need
+		 * PCI quirks to run before init.
+		 */
+		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+		    boot_cpu_data.family != 5)
+			init_acpi_pm_clocksource();
+
 		if (!pit_timer_init())
 			return;
 	}
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -30,6 +30,7 @@
  * in arch/i386/kernel/acpi/boot.c
  */
 u32 pmtmr_ioport __read_mostly;
+static bool pmtmr_initialized __init_data;
 
 static inline u32 read_pmtmr(void)
 {
@@ -142,7 +143,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SE
  * Some boards have the PMTMR running way too fast. We check
  * the PMTMR rate against PIT channel 2 to catch these cases.
  */
-static int verify_pmtmr_rate(void)
+static int __init verify_pmtmr_rate(void)
 {
 	u64 value1, value2;
 	unsigned long count, delta;
@@ -172,14 +173,18 @@ static int verify_pmtmr_rate(void)
 /* Number of reads we try to get two different values */
 #define ACPI_PM_READ_CHECKS 10000
 
-static int __init init_acpi_pm_clocksource(void)
+int __init init_acpi_pm_clocksource(void)
 {
 	u64 value1, value2;
 	unsigned int i, j = 0;
+	int ret;
 
 	if (!pmtmr_ioport)
 		return -ENODEV;
 
+	if (pmtmr_initialized)
+		return 0;
+
 	/* "verify" this timing source: */
 	for (j = 0; j < ACPI_PM_MONOTONICITY_CHECKS; j++) {
 		udelay(100 * j);
@@ -210,10 +215,11 @@ static int __init init_acpi_pm_clocksour
 		return -ENODEV;
 	}
 
-	return clocksource_register_hz(&clocksource_acpi_pm,
-						PMTMR_TICKS_PER_SEC);
+	ret = clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
+	if (!ret)
+		pmtimer_initialized = true;
+	return ret;
 }
-
 /* We use fs_initcall because we want the PCI fixups to have run
  * but we still need to load before device_initcall
  */
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -13,6 +13,8 @@
 /* Overrun value */
 #define ACPI_PM_OVRRUN	(1<<24)
 
+extern int __init init_acpi_pm_clocksource(void);
+
 #ifdef CONFIG_X86_PM_TIMER
 
 extern u32 acpi_pm_read_verified(void);


