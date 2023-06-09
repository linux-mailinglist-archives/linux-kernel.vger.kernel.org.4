Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3307297EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbjFILNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjFILNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:13:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA01FF3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:13:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BBEC21A16;
        Fri,  9 Jun 2023 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686309195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecoq/MeSTUdA9EHpJzCSHxssfrpaWGQ/APku+m/fpZA=;
        b=DTuVqxzMbPp0jvWo/EQZo+YOwoS2sLnSLXu2c3YigVj41K9ewnilOGCS46mjfhWGY4TFz/
        j71rmdWB6fMiPW/WTvPsJuxwHvT/r758wfvAqxrjGgfXnU9WbYJJ4Zm6t5IBw382/oBfSc
        338bCt/HcpI3g0TU1WFuhY0FTrGN6jk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBADB139C8;
        Fri,  9 Jun 2023 11:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDnuMkoJg2ReIwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 09 Jun 2023 11:13:14 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 1/4] x86: Introduce CONFIG_IA32_EMULATION_DEFAULT_DISABLED Kconfig option
Date:   Fri,  9 Jun 2023 14:13:08 +0300
Message-Id: <20230609111311.4110901-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609111311.4110901-1-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distributions would like to reduce their attack surface as much as
possible but at the same time they have to cater to a wide variety of
legacy software. One such avenue where distros have to strike a balance
is the support for 32bit syscalls on a 64bit kernel. Ideally
distributions would have a way to set that policy in their kernel config
files and at the same time users should also have the ability to
override this decision. Introduce such mechanism in the face of
CONFIG_IA32_EMULATION_DEFAULT_DISABLED compile time option, which
defaults to 'N' i.e retains current behavio in case
CONFIG_IA32_EMULATION is enabled. If, however, a distributor would like
to change this policy they can do so via the newly introduced
CONFIG_IA32_EMULATION_DEFAULT_DISABLED. As a final note allow users to
override the decision via the ia32_mode boot time parameter.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/x86/Kconfig                                |  5 +++++
 arch/x86/entry/common.c                         | 16 ++++++++++++++++
 arch/x86/include/asm/traps.h                    |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..7c01ab8bcd56 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1865,6 +1865,10 @@
 			 0 -- machine default
 			 1 -- force brightness inversion

+	ia32_mode=		[X86-64]
+			Format: ia32_mode=disabled, ia32_mode=enabled
+			Allows to override the compile-time IA32_EMULATION option at boot time
+
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..9c32fd720701 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3038,6 +3038,11 @@ config IA32_EMULATION
 	  64-bit kernel. You should likely turn this on, unless you're
 	  100% sure that you don't have any 32-bit programs left.

+config IA32_EMULATION_DEFAULT_DISABLED
+	bool "IA32 Emulation default disabled"
+	default n
+	depends on IA32_EMULATION
+
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..6da89575e03e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/init.h>

 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -96,6 +97,21 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 	return (int)regs->orig_ax;
 }

+#ifdef CONFIG_IA32_EMULATION
+bool ia32_disabled = IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int ia32_mode_override_cmdline(char *arg)
+{
+	if (!strcmp(arg, "disabled"))
+		ia32_disabled = true;
+	else if (!strcmp(arg, "enabled"))
+		ia32_disabled = false;
+
+	return 1;
+}
+__setup("ia32_mode=", ia32_mode_override_cmdline);
+#endif
+
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 47ecfff2c83d..dd93aac3718b 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -20,6 +20,10 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *e

 extern bool ibt_selftest(void);

+#ifdef CONFIG_IA32_EMULATION
+extern bool ia32_disabled;
+#endif
+
 #ifdef CONFIG_X86_F00F_BUG
 /* For handling the FOOF bug */
 void handle_invalid_op(struct pt_regs *regs);
--
2.34.1

