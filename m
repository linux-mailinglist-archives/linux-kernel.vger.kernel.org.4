Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB750732B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjFPJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjFPJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003C26BE;
        Fri, 16 Jun 2023 02:24:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mL3QMF2j8SJISmK4/qknqDlQf1IQcpG/IDVIlueffE=;
        b=Os+Tlmc/Ntxb2VNy9Lr87lcoIZG2EpYjnbuRHVEbVE9Ir2dKEG4YomX2+e1/eeiv2F3DVg
        vxW3BgAs9IZXoLbIS6s/mtMI2vy85tJ9RTTASa67DtAZN07o8Ap063FXcmD/LDWXalKevT
        sTQCvHwyhycmsmkX9UhXovUFJuVDvofvSarGn5ehOaJd1gmHJ3IkMwFYFk5KHRj1nJlAd1
        LMhHxgMiTBkj2EeXH2sy1ZdHP+JxsdXXxnltc1P/+yHpUEOsGx2VtJSNQlvDjSpySdVPmt
        nzh/jko/InMbI74URiaRRKYKf5jHA52Zkeo8+ZxNweeqK95WnkWtD0UQkA7Ktw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mL3QMF2j8SJISmK4/qknqDlQf1IQcpG/IDVIlueffE=;
        b=vZ5UCN+D7lXnnDgEKqgodXMknwzAFR8mV3AiJxSixoYsHC1zuqnxO9i1cUr0mA+wJmk8kv
        HwfD2SzGSC9qSYDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] um/cpu: Switch to arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.493148694@linutronix.de>
References: <20230613224545.493148694@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748579.404.16291691505743551206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9349b5cd0908f8afe95529fc7a8cbb1417df9b0c
Gitweb:        https://git.kernel.org/tip/9349b5cd0908f8afe95529fc7a8cbb1417df9b0c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

um/cpu: Switch to arch_cpu_finalize_init()

check_bugs() is about to be phased out. Switch over to the new
arch_cpu_finalize_init() implementation.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Richard Weinberger <richard@nod.at>
Link: https://lore.kernel.org/r/20230613224545.493148694@linutronix.de

---
 arch/um/Kconfig            | 1 +
 arch/um/include/asm/bugs.h | 7 -------
 arch/um/kernel/um_arch.c   | 3 ++-
 3 files changed, 3 insertions(+), 8 deletions(-)
 delete mode 100644 arch/um/include/asm/bugs.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 541a9b1..887cfb6 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_EPHEMERAL_INODES
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
diff --git a/arch/um/include/asm/bugs.h b/arch/um/include/asm/bugs.h
deleted file mode 100644
index 4473942..0000000
--- a/arch/um/include/asm/bugs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_BUGS_H
-#define __UM_BUGS_H
-
-void check_bugs(void);
-
-#endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0a23a98..918fed7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -430,7 +431,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 }
 
-void __init check_bugs(void)
+void __init arch_cpu_finalize_init(void)
 {
 	arch_check_bugs();
 	os_check_bugs();
