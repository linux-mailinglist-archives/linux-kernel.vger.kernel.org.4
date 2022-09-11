Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026B35B4CBF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIKIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIKIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:58 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C894832A8A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:55 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 33916 invoked from network); 11 Sep 2022 10:47:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886072; bh=cRz0HbGLs7FSStcgbrNdUbSH64ygwZ0Op1wX151XXck=;
          h=From:To:Cc:Subject;
          b=l0xQefst3EiOCTDZ22Lzyb17t1bnRaZ7hkAiN6HmGCc8uao6oAMIGJw9e7q7jXhfh
           iNtQUVijemJzzuSNgSjoY+UQ+4PkvCm55MIVHKWeEOiUnx1yn/oPVKhT6ka9QAzCgG
           bTWHZ4XxrPwJLHgjhn+9QFA7s9TrSn4E4NIqa/MU=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:52 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Ira W . Snyder" <ira.snyder@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 08/10] x86/Kconfig: make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
Date:   Sun, 11 Sep 2022 10:47:09 +0200
Message-Id: <20220911084711.13694-9-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 59c754a3d27abd7d35107f6069d1709c
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [EeN0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was unable to find a good description of the ServerWorks CNB20LE
chipset. However, it was probably exclusively used with the Pentium III
processor (this CPU model was used in all references to it that I
found where the CPU model was provided: dmesgs in [1] and [2];
[3] page 2; [4]-[7]).

As is widely known, the Pentium III processor did not support the 64-bit
mode, support for which was introduced by Intel a couple of years later.
So it is safe to assume that no systems with the CNB20LE chipset have
amd64 and the CONFIG_PCI_CNB20LE_QUIRK may now depend on X86_32.

Additionally, I have determined that most computers with the CNB20LE
chipset did have ACPI support and this driver was inactive on them.
I have submitted a patch to remove this driver, but it was met with
resistance [8].

[1] Jim Studt, Re: Problem with ServerWorks CNB20LE and lost interrupts
Linux Kernel Mailing List, https://lkml.org/lkml/2002/1/11/111

[2] RedHat Bug 665109 - e100 problems on old Compaq Proliant DL320
https://bugzilla.redhat.com/show_bug.cgi?id=665109

[3] R. Hughes-Jones, S. Dallison, G. Fairey, Performance Measurements on
Gigabit Ethernet NICs and Server Quality Motherboards,
http://datatag.web.cern.ch/papers/pfldnet2003-rhj.doc

[4] "Hardware for Linux",
Probe #d6b5151873 of Intel STL2-bd A28808-302 Desktop Computer (STL2)
https://linux-hardware.org/?probe=d6b5151873

[5] "Hardware for Linux", Probe #0b5d843f10 of Compaq ProLiant DL380
https://linux-hardware.org/?probe=0b5d843f10

[6] Ubuntu Forums, Dell Poweredge 2400 - Adaptec SCSI Bus AIC-7880
https://ubuntuforums.org/showthread.php?t=1689552

[7] Ira W. Snyder, "BISECTED: 2.6.35 (and -git) fail to boot: APIC problems"
https://lkml.org/lkml/2010/8/13/220

[8] Bjorn Helgaas, "Re: [PATCH] x86/pci: drop ServerWorks / Broadcom
CNB20LE PCI host bridge driver"
https://lore.kernel.org/lkml/20220318165535.GA840063@bhelgaas/T/

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ira W. Snyder <ira.snyder@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
---
v2: make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
    (previously only help text and description were changed)
    upgrade short description.

 arch/x86/Kconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fdfe8b7e895a..31f778b0cd0b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2739,13 +2739,21 @@ config MMCONF_FAM10H
 	depends on X86_64 && PCI_MMCONFIG && ACPI
 
 config PCI_CNB20LE_QUIRK
-	bool "Read CNB20LE Host Bridge Windows" if EXPERT
-	depends on PCI
+	bool "Read PCI host bridge windows from the CNB20LE chipset" if EXPERT
+	depends on X86_32 && PCI
 	help
 	  Read the PCI windows out of the CNB20LE host bridge. This allows
 	  PCI hotplug to work on systems with the CNB20LE chipset which do
 	  not have ACPI.
 
+	  The ServerWorks (later Broadcom) CNB20LE was a chipset designed
+	  most probably only for Pentium III.
+
+	  To find out if you have such a chipset, search for a PCI device with
+	  1166:0009 PCI IDs, for example by executing
+		lspci -nn | grep '1166:0009'
+	  The code is inactive if there is none.
+
 	  There's no public spec for this chipset, and this functionality
 	  is known to be incomplete.
 
-- 
2.25.1

