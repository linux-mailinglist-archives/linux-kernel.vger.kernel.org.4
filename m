Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C185B4CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiIKIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIKIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:51 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3757B326EF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:49 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 19897 invoked from network); 11 Sep 2022 10:47:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886067; bh=ytVUabcF3vmy7D2bxgeIeTy4DuPXfvw1Pn6BnaoFuVk=;
          h=From:To:Cc:Subject;
          b=scdnoTTOmj6GWOZurAL+1+y7veg9A2l480GexiEOWJwH8Cyp88j/2FVMl/hRohyVY
           T1Onp1nXD5fNQ9Bh8KyaZEjrhTFsxuUHgee+O4K2yC757wVfEOdUtnZHuRHNYz29vx
           PtN+8bYAEZAfLD821T6xL/ryJ75ThZmSYUa2PotQ=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:47 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 04/10] x86/Kconfig: drop X86_32_NON_STANDARD
Date:   Sun, 11 Sep 2022 10:47:05 +0200
Message-Id: <20220911084711.13694-5-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 7632475a2feec6673217b18624fa99e5
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [0XO0]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch drops the "Support non-standard 32-bit SMP architectures"
configuration option. Currently, the only such an architecture is
STA2X11, so this option is useless. STA2X11 could now be selected
independently.

The dependency of X86_BIGSMP on X86_32_NON_STANDARD was dropped in
2009, in
commit 26f7ef14a76b ("x86: don't treat bigsmp as non-standard")
but the help text for X86_32_NON_STANDARD was not updated since.

CONFIG_X86_32_NON_STANDARD was used only in arch/x86/Kconfig, so it
could be dropped easily.

X86_32_NON_STANDARD depended on SMP, so
        (!SMP && !X86_32_NON_STANDARD) == !SMP
and
        (SMP || X86_32_NON_STANDARD) == SMP

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 70bf4df73fa2..28f0c32fc65a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -706,18 +706,6 @@ config X86_RDC321X
 	  as R-8610-(G).
 	  If you don't have one of these chips, you should say N here.
 
-config X86_32_NON_STANDARD
-	bool "Support non-standard 32-bit SMP architectures"
-	depends on X86_32 && SMP
-	depends on X86_EXTENDED_PLATFORM
-	help
-	  This option compiles in the bigsmp and STA2X11 default
-	  subarchitectures.  It is intended for a generic binary
-	  kernel. If you select them all, kernel will probe it one by
-	  one and will fallback to default.
-
-# Alphabetically sorted list of Non standard 32 bit platforms
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():
@@ -729,7 +717,8 @@ config X86_SUPPORTS_MEMORY_FAILURE
 
 config STA2X11
 	bool "STA2X11 Companion Chip Support"
-	depends on X86_32_NON_STANDARD && PCI
+	depends on X86_32 && SMP
+	depends on X86_EXTENDED_PLATFORM && PCI
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
@@ -1077,7 +1066,7 @@ config UP_LATE_INIT
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
 	default PCI_MSI
-	depends on X86_32 && !SMP && !X86_32_NON_STANDARD
+	depends on X86_32 && !SMP
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -1102,7 +1091,7 @@ config X86_UP_IOAPIC
 
 config X86_LOCAL_APIC
 	def_bool y
-	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
+	depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
 
-- 
2.25.1

