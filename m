Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E95B4CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiIKIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIKIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:48:02 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BA32AB9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:58 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 1431 invoked from network); 11 Sep 2022 10:47:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886075; bh=EEWcK86o8siWHIRVvCobtyOrQ5S49tGsbSTHibxrknY=;
          h=From:To:Cc:Subject;
          b=a766HbVdIybswzOWh0FriZsWUZ7LhlkO89osBxZxSDEHs1ar6Il+JCf+SD44mffxU
           PUBmPAa+sSF1YgB8KdryjchX2OyOy4H6uInsZSeGhyq8faXkFe+uZT0XyUTJtVf97c
           ju3QQ6wSAVe2g/9qLvKV6ooym0sjlPBzyGCW60nk=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:55 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 10/10] x86/Kconfig: remove CONFIG_ISA_BUS
Date:   Sun, 11 Sep 2022 10:47:11 +0200
Message-Id: <20220911084711.13694-11-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 709a00b38453fef752ad8eb2bfa52bbe
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [sVPk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ISA_BUS was used only as a dependency for a single Industrial IO
driver: CONFIG_CIO_DAC ("Measurement Computing CIO-DAC IIO driver"). At
least grepping the kernel source for "ISA_BUS" did not provide any other
meaningful results.

There are more configuration options that select CONFIG_ISA_BUS_API, but
did not depend on CONFIG_ISA_BUS. Most of these are for Industrial IO and
GPIO drivers.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
v2: add "Acked by: William Breathitt Gray"

 arch/x86/Kconfig        | 11 -----------
 drivers/iio/dac/Kconfig |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)


diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4612c356da4c..c8218d310d55 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2759,17 +2759,6 @@ config PCI_CNB20LE_QUIRK
 
 	  You should say N unless you know you need this.
 
-config ISA_BUS
-	bool "ISA bus support on modern systems" if EXPERT
-	help
-	  Expose ISA bus device drivers and options available for selection and
-	  configuration. Enable this option if your target machine has an ISA
-	  bus. ISA is an older system, displaced by PCI and newer bus
-	  architectures -- if your target machine is modern, it probably does
-	  not have an ISA bus.
-
-	  If unsure, say N.
-
 # x86_64 have no ISA slots, but can have ISA-style DMA.
 config ISA_DMA_API
 	bool "ISA-style DMA support" if (X86_64 && EXPERT)
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80521bd28d0f..e32245c013b0 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -275,7 +275,7 @@ config AD8801
 
 config CIO_DAC
 	tristate "Measurement Computing CIO-DAC IIO driver"
-	depends on X86 && (ISA_BUS || PC104)
+	depends on X86
 	select ISA_BUS_API
 	help
 	  Say yes here to build support for the Measurement Computing CIO-DAC
-- 
2.25.1

