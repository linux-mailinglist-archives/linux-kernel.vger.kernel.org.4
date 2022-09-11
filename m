Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7214A5B4CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIKIrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIKIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:48 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7EB326D5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:45 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 7264 invoked from network); 11 Sep 2022 10:47:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886062; bh=xMO31db5QByxeHy3dEPk7AqhTc7ZGedQ1wSzgYZM5tY=;
          h=From:To:Cc:Subject;
          b=RhbSFudB/a6d3gWRrQ5nfCuJ1E3Q77hIYwMHSLrWV+gibMCzw0tPYs6TPtijm5QfG
           BO9GWtQolrZH9jhsqU0yCbNeT1SLA0UJ7gn23wvJ6uT0Y1F4xMq6ml7ZDbxRVYHoMp
           Ul0f+7mOlCQcxZVRpJmPWwPsxPWfxGIlJ/rA+TUw=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:42 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and improve help text
Date:   Sun, 11 Sep 2022 10:47:02 +0200
Message-Id: <20220911084711.13694-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 956a311e2ea846f6bb889a890c480a94
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000002 [QRGG]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
present, enable CONFIG_X86_X2APIC by default as it gives performance
and functionality benefits. Additionally, if the BIOS has already
switched APIC to x2APIC mode, but CONFIG_X86_X2APIC is disabled, the
kernel will panic in arch/x86/kernel/apic/apic.c .

Also improve the help text, which was confusing and really did not
describe what the feature is about.

Help text references and discussion:

Both Intel [1] and AMD [3] spell the name as "x2APIC", not "x2apic".

"It allows faster access to the local APIC"
        [2], chapter 2.1, page 15:
        "More efficient MSR interface to access APIC registers."

"x2APIC was introduced in Intel CPUs around 2008":
        I was unable to find specific information which Intel CPUs
        support x2APIC. Wikipedia claims it was "introduced with the
        Nehalem microarchitecture in November 2008", but I was not able
        to confirm this independently. At least some Nehalem CPUs do not
        support x2APIC [1].

        The documentation [2] is dated June 2008. Linux kernel also
        introduced x2APIC support in 2008, so the year seems to be
        right.

"and in AMD EPYC CPUs in 2019":
        [3], page 15:
        "AMD introduced an x2APIC in our EPYC 7002 Series processors for
        the first time."

"It is also frequently emulated in virtual machines, even when the host
CPU does not support it."
        [1]

"If this configuration option is disabled, the kernel will not boot on
some platforms that have x2APIC enabled."
        According to some BIOS documentation [4], the x2APIC may be
        "disabled", "enabled", or "force enabled" on this system.
        I think that "enabled" means "made available to the operating
        system, but not already turned on" and "force enabled" means
        "already switched to x2APIC mode when the OS boots". Only in the
        latter mode a kernel without CONFIG_X86_X2APIC will panic in
        validate_x2apic() in arch/x86/kernel/apic/apic.c .

	QEMU 4.2.1 and my Intel HP laptop (bought in 2019) use the
	"enabled" mode and the kernel does not panic.

[1] "Re: [Qemu-devel] [Question] why x2apic's set by default without host sup"
        https://lists.gnu.org/archive/html/qemu-devel/2013-07/msg03527.html

[2] Intel® 64 Architecture x2APIC Specification,
        ( https://www.naic.edu/~phil/software/intel/318148.pdf )

[3] Workload Tuning Guide for AMD EPYC ™ 7002 Series Processor Based
        Servers Application Note,
        https://developer.amd.com/wp-content/resources/56745_0.80.pdf

[4] UEFI System Utilities and Shell Command Mobile Help for HPE ProLiant
        Gen10, ProLiant Gen10 Plus Servers and HPE Synergy:
        Enabling or disabling Processor x2APIC Support
        https://techlibrary.hpe.com/docs/iss/proliant-gen10-uefi/s_enable_disable_x2APIC_support.html

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>

---
v2: language fixes by Mr Randy Dunlap, change option name
---
 arch/x86/Kconfig | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..28133b5d3f12 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -440,15 +440,27 @@ config X86_FEATURE_NAMES
 	  If in doubt, say Y.
 
 config X86_X2APIC
-	bool "Support x2apic"
+	bool "x2APIC interrupt controller architecture support"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
+	default y
 	help
-	  This enables x2apic support on CPUs that have this feature.
+	  x2APIC is an interrupt controller architecture, a component of which
+	  (the local APIC) is present in the CPU. It allows faster access to
+	  the local APIC and supports a larger number of CPUs in the system
+	  than the predecessors.
 
-	  This allows 32-bit apic IDs (so it can support very large systems),
-	  and accesses the local apic via MSRs not via mmio.
+	  x2APIC was introduced in Intel CPUs around 2008 and in AMD EPYC CPUs
+	  in 2019, but it can be disabled by the BIOS. It is also frequently
+	  emulated in virtual machines, even when the host CPU does not support
+	  it. Support in the CPU can be checked by executing
+		cat /proc/cpuinfo | grep x2apic
 
-	  If you don't know what to do here, say N.
+	  If this configuration option is disabled, the kernel will not boot on
+	  some platforms that have x2APIC enabled.
+
+	  Say N if you know that your platform does not have x2APIC.
+
+	  Otherwise, say Y.
 
 config X86_MPPARSE
 	bool "Enable MPS table" if ACPI
-- 
2.25.1

