Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9806407BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiLBNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiLBNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:35:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055710541;
        Fri,  2 Dec 2022 05:35:58 -0800 (PST)
Date:   Fri, 02 Dec 2022 13:35:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669988156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EczATHbMMI+edCCwReGmfQQNZinrPTAaTXeUFX0/jo=;
        b=wazTKousC/5O9zvWGXmh1Sx2XZLNyWEGCa1hnwlKcnjyvVgEEV8CngtpeRq+cYcmfv99rz
        L2dRQtUHm9FV0zDMMMWD+rBBMkiG42E7PlrlvND7UeApsS8vW8Yb7b5XNDNKUFCxGdz9Sp
        IUxFKtutLzPFRWMyf6JjlWDThqnZ4el5qSbR9kfGbgAs21gvw2LHgBZvJ7pP3S1VICPd8I
        0q+N34lCi49akT0g/GW5pu8JMPEkHAWZaOxqFbzpsdUMvyzfsbOt8f25mi518Hxvjk+L+b
        GYfMUgej7SouNZ77G5ZuJef539AUZ8KW62pa2Fy9dOD3sXYGbXNmcFLmDEdCxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669988156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EczATHbMMI+edCCwReGmfQQNZinrPTAaTXeUFX0/jo=;
        b=hs5ppUrLCF1drBKPWGlLe3b12BYXyW5Gpl//UfXegz6uw6Z6geTbRxXyTsWl9+UWqAGMJ4
        v56eAkwlXO3ztrCQ==
From:   tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Handle no CONFIG_X86_X2APIC on systems with
 x2APIC enabled by BIOS
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Robert Elliott (Servers)" <elliott@hpe.com>, mat.jonczyk@o2.pl,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
References: <d573ba1c-0dc4-3016-712a-cc23a8a33d42@molgen.mpg.de>
MIME-Version: 1.0
Message-ID: <166998815484.4906.5935864067171458557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e3998434da4f5b1f57f8d6a8a9f8502ee3723bae
Gitweb:        https://git.kernel.org/tip/e3998434da4f5b1f57f8d6a8a9f8502ee37=
23bae
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Tue, 29 Nov 2022 22:50:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:28:52 +01:00

x86/apic: Handle no CONFIG_X86_X2APIC on systems with x2APIC enabled by BIOS

A kernel that was compiled without CONFIG_X86_X2APIC was unable to boot on
platforms that have x2APIC already enabled in the BIOS before starting the
kernel.

The kernel was supposed to panic with an approprite error message in
validate_x2apic() due to the missing X2APIC support.

However, validate_x2apic() was run too late in the boot cycle, and the
kernel tried to initialize the APIC nonetheless. This resulted in an
earlier panic in setup_local_APIC() because the APIC was not registered.

In my experiments, a panic message in setup_local_APIC() was not visible
in the graphical console, which resulted in a hang with no indication
what has gone wrong.

Instead of calling panic(), disable the APIC, which results in a somewhat
working system with the PIC only (and no SMP). This way the user is able to
diagnose the problem more easily.

Disabling X2APIC mode is not an option because it's impossible on systems
with locked x2APIC.

The proper place to disable the APIC in this case is in check_x2apic(),
which is called early from setup_arch(). Doing this in
__apic_intr_mode_select() is too late.

Make check_x2apic() unconditionally available and remove the empty stub.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Robert Elliott (Servers) <elliott@hpe.com>
Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/d573ba1c-0dc4-3016-712a-cc23a8a33d42@molge=
n.mpg.de
Link: https://lore.kernel.org/lkml/20220911084711.13694-3-mat.jonczyk@o2.pl
Link: https://lore.kernel.org/all/20221129215008.7247-1-mat.jonczyk@o2.pl
---
 arch/x86/Kconfig            |  4 ++--
 arch/x86/include/asm/apic.h |  3 +--
 arch/x86/kernel/apic/apic.c | 13 ++++++++-----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ce..b2c0fce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -462,8 +462,8 @@ config X86_X2APIC
=20
 	  Some Intel systems circa 2022 and later are locked into x2APIC mode
 	  and can not fall back to the legacy APIC modes if SGX or TDX are
-	  enabled in the BIOS.  They will be unable to boot without enabling
-	  this option.
+	  enabled in the BIOS. They will boot with very reduced functionality
+	  without enabling this option.
=20
 	  If you don't know what to do here, say N.
=20
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3415321..3216da7 100644
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
=20
 #define x2apic_supported()	(boot_cpu_has(X86_FEATURE_X2APIC))
 #else /* !CONFIG_X86_X2APIC */
-static inline void check_x2apic(void) { }
 static inline void x2apic_setup(void) { }
 static inline int x2apic_enabled(void) { return 0; }
=20
 #define x2apic_mode		(0)
 #define	x2apic_supported()	(0)
 #endif /* !CONFIG_X86_X2APIC */
+extern void __init check_x2apic(void);
=20
 struct irq_data;
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c6876d3..20d9a60 100644
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
+	 * Checkme: Can we simply turn off x2APIC here instead of disabling the API=
C?
 	 */
-	panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please di=
sable x2apic in BIOS.\n");
+	pr_err("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2=
APIC.\n");
+	pr_err("Disabling APIC, expect reduced performance and functionality.\n");
+
+	disable_apic =3D 1;
+	setup_clear_cpu_cap(X86_FEATURE_APIC);
 }
-early_initcall(validate_x2apic);
=20
 static inline void try_to_enable_x2apic(int remap_mode) { }
 static inline void __x2apic_enable(void) { }
