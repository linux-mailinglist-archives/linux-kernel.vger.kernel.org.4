Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9785B4CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIKIsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIKIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:47:55 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255E326EF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:53 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 30425 invoked from network); 11 Sep 2022 10:47:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886071; bh=vUGG4h11dmwbPg9Po6mR8WRcjsY0PHAOs81BBUqS6tM=;
          h=From:To:Cc:Subject;
          b=n1xTeLn5RnuDf6FOLlLYzf0W1G8+ab/5Zeh4g6x/Eh/0cc9KHq53x96FJuOupdV3z
           PVeshC0bIS0G39y1qdw19tG6p0qG1VXM68j/Lqi3QfiQaK6Ivd+mKM+yMFF1bzB/Nb
           K+wa6a6hUiiBdBKgQqoN3RIqaXWBtpwlLMWSbkD4=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:51 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 07/10] x86/Kconfig: document CONFIG_PCI_MMCONFIG
Date:   Sun, 11 Sep 2022 10:47:08 +0200
Message-Id: <20220911084711.13694-8-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: c60b6b189b5153b31458cc8e16b615a9
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gROE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration option had no help text, so add it.

CONFIG_EXPERT is enabled on some distribution kernels, so people using a
distribution kernel's configuration as a starting point will see this
option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

---
I would like someone to confirm that PCI Express is required for
MMCONFIG support.
---
 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 31c2c574c67d..fdfe8b7e895a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2712,6 +2712,19 @@ config PCI_MMCONFIG
 	default y
 	depends on PCI && (ACPI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
+	help
+	  Add support for accessing the PCI configuration space as a memory
+	  mapped area. It is the recommended method if the system supports
+	  this (it must have PCI Express and ACPI for it to be available).
+
+	  In the unlikely case that enabling this configuration option causes
+	  problems, the mechanism can be switched off with the 'pci=nommconf'
+	  command line parameter.
+
+	  Say 'n' only if you are sure that your platform does not support this
+	  access method or you have problems caused by it.
+
+	  Say 'y' otherwise.
 
 config PCI_OLPC
 	def_bool y
-- 
2.25.1

