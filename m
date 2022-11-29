Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6869A63CAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiK2Vu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiK2Vu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:50:26 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A956E548
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:50:21 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 12337 invoked from network); 29 Nov 2022 22:50:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1669758618; bh=IVD3U7umaa5f2mOjx5X7KPJ6YQ8eaBe3vZYbgDlLhjQ=;
          h=From:To:Cc:Subject;
          b=Qc47TciVr80fpve617IfPe5eySDEB4VUAlTd0DL3y+17YDHdRDxLhseXmqLBaLCoV
           zlvNVamTdnDg8MH1F7H4v7z1QgHiuTXMwuXWytofrmBbV6xvz2B/ZKYwltb59nZ+FS
           CzA22h826hNNSd179GjC4937Q0I9IcB3jg2YoLGg=
Received: from aaeq124.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.120.124])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <x86@kernel.org>; 29 Nov 2022 22:50:18 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Robert Elliott <elliott@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Johan Hovold <johan@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Yinghai Lu <yinghai@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Subject: [PATCH] x86/apic: handle no CONFIG_X86_X2APIC on systems with x2APIC enabled by BIOS
Date:   Tue, 29 Nov 2022 22:50:08 +0100
Message-Id: <20221129215008.7247-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: f0dc8ad877cb05c45d5d1b2524f54152
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [ARN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel that was compiled without CONFIG_X86_X2APIC was unable to boot
on platforms that have x2APIC turned on by BIOS [1]. The kernel was
supposed to panic with an approprite error message in validate_x2apic()
in arch/x86/kernel/apic/apic.c .

However, validate_x2apic() was run too late in the boot cycle, and the
kernel tried to initialize the APIC nonetheless. This resulted in an
earlier panic in setup_local_APIC() on

	/*
	 * Double-check whether this APIC is really registered.
	 * This is meaningless in clustered apic mode, so we skip it.
	 */
	BUG_ON(!apic->apic_id_registered());

during execution of

	Call Trace:
	 <TASK>
	 ? _printk+0x63/0x7e
	 apic_intr_mode_init+0xde/0xfc
	 x86_late_time_init+0x1b/0x2f
	 start_kernel+0x5db/0x69b
	 secondary_startup_64_no_verify+0xe0/0xeb
	 </TASK>

In my experiments, a panic message in setup_local_APIC() was not visible
in the graphical console, which resulted in a hang with no indication
what has gone wrong. [2]

Instead of calling panic(), disable the APIC, which should result in a
somewhat working system with the PIC only (and no SMP). This way the
user would be able to diagnose the problem more easily. Implementation
of this is much simpler then disabling the x2APIC mode only, which may
not be possible on newer systems with locked x2APIC.

The proper place to disable the APIC in this case is in check_x2apic(),
which is called early from setup_arch(). Doing this in
__apic_intr_mode_select() is too late, and in my experiments resulted in
a broken system with no working PCI interrupts and "failed to register
GSI" warnings on the screen.

The check_x2apic() function was empty on kernels without
CONFIG_X86_X2APIC. Modify arch/x86/include/asm/apic.h to remove the
empty inline stub and provide proper declaration irrespective of
CONFIG_X86_X2APIC setting.


[1] Here I differentiate between two cases:
    1. APIC already switched into the x2APIC mode by BIOS, it is in
       x2APIC mode when kernel starts booting.
    2. x2APIC made available by BIOS to the operating system, but is
       in legacy mode when kernel starts booting.

    Only in case 1. the kernel did not boot without CONFIG_X86_X2APIC.

[2] Tested with CONFIG_FB_EFI and CONFIG_EARLY_PRINTK enabled.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lkml.org/lkml/2020/2/21/1627
Reported-by: Robert Elliott (Servers) <elliott@hpe.com>
Link: https://lore.kernel.org/lkml/20220911084711.13694-3-mat.jonczyk@o2.pl/
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---

A separate patch to enable CONFIG_X86_X2APIC by default and update the
help text of this option is being worked on.

 arch/x86/Kconfig            |  4 ++--
 arch/x86/include/asm/apic.h |  3 +--
 arch/x86/kernel/apic/apic.c | 13 ++++++++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..b2c0fce3f257 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -462,8 +462,8 @@ config X86_X2APIC
 
 	  Some Intel systems circa 2022 and later are locked into x2APIC mode
 	  and can not fall back to the legacy APIC modes if SGX or TDX are
-	  enabled in the BIOS.  They will be unable to boot without enabling
-	  this option.
+	  enabled in the BIOS. They will boot with very reduced functionality
+	  without enabling this option.
 
 	  If you don't know what to do here, say N.
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321c8240..3216da7074ba 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -249,7 +249,6 @@ static inline u64 native_x2apic_icr_read(void)
 extern int x2apic_mode;
 extern int x2apic_phys;
 extern void __init x2apic_set_max_apicid(u32 apicid);
-extern void __init check_x2apic(void);
 extern void x2apic_setup(void);
 static inline int x2apic_enabled(void)
 {
@@ -258,13 +257,13 @@ static inline int x2apic_enabled(void)
 
 #define x2apic_supported()	(boot_cpu_has(X86_FEATURE_X2APIC))
 #else /* !CONFIG_X86_X2APIC */
-static inline void check_x2apic(void) { }
 static inline void x2apic_setup(void) { }
 static inline int x2apic_enabled(void) { return 0; }
 
 #define x2apic_mode		(0)
 #define	x2apic_supported()	(0)
 #endif /* !CONFIG_X86_X2APIC */
+extern void __init check_x2apic(void);
 
 struct irq_data;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c6876d3ea4b1..20d9a604da7c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1931,16 +1931,19 @@ void __init check_x2apic(void)
 	}
 }
 #else /* CONFIG_X86_X2APIC */
-static int __init validate_x2apic(void)
+void __init check_x2apic(void)
 {
 	if (!apic_is_x2apic_enabled())
-		return 0;
+		return;
 	/*
-	 * Checkme: Can we simply turn off x2apic here instead of panic?
+	 * Checkme: Can we simply turn off x2APIC here instead of disabling the APIC?
 	 */
-	panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please disable x2apic in BIOS.\n");
+	pr_err("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2APIC.\n");
+	pr_err("Disabling APIC, expect reduced performance and functionality.\n");
+
+	disable_apic = 1;
+	setup_clear_cpu_cap(X86_FEATURE_APIC);
 }
-early_initcall(validate_x2apic);
 
 static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }

base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
-- 
2.25.1

