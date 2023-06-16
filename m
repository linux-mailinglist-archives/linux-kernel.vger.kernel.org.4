Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2627331BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjFPM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345507AbjFPM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:57:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8CA2133
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:57:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B940021A25;
        Fri, 16 Jun 2023 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686920270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HnsyB1P/ICCV757zk+6euS2EyB47mj2mUlXSxGGY818=;
        b=mMPwEUKUKo16qmq3bYFPzOSUdQDMHVtJnDG4oUlBcIDYN5D9EYrvkj7rXVhdP38MCpsYCq
        zyVBtUn4Pg1OiWnq9gm8pBiZWhGvIe3zPghHk+GwSkuSX8/uw39dIvAjzaoDB548mLqFyX
        F9SDZW2pRXcyCUwNhIpEtBaHYj3vURg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62D221330B;
        Fri, 16 Jun 2023 12:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gNN4FU5cjGTjNwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 16 Jun 2023 12:57:50 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 1/5] x86: Make IA32_EMULATION boot time configurable
Date:   Fri, 16 Jun 2023 15:57:26 +0300
Message-Id: <20230616125730.1164989-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616125730.1164989-1-nik.borisov@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
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
possible but at the same time they'd want to retain flexibility to cater
to a variety of legacy software. One such avenue where a balance has to
be struck is in supporting 32bit syscalls/processes on 64bit kernels. Ideally
it should be possible for the distribution to set their own policy and
give users the ability to override those policies as appropriate.

In order to support this usecase, introduce
CONFIG_IA32_EMULATION_DEFAULT_DISABLED compile time option, which
controls whether 32bit processes/syscalls should be allowed or not. This
allows distributions to set their preferred default behavior in their
kernel configs.

On the other hand, in order to allow users to override the distro's
policy, introduce the 'ia32_mode' parameter which allows overriding
CONFIG_IA32_EMULATION_DEFAULT_DISABLED state at boot time.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/x86/Kconfig                                |  9 +++++++++
 arch/x86/entry/common.c                         | 16 ++++++++++++++++
 arch/x86/include/asm/ia32.h                     | 16 +++++++++++++++-
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..59b1e86ecd9d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1865,6 +1865,11 @@
 			 0 -- machine default
 			 1 -- force brightness inversion
 
+	ia32_mode=		[X86-64]
+			Format: ia32_mode=disabled, ia32_mode=enabled
+			Allows overriding the compile-time state of
+			IA32_EMULATION_DEFAULT_DISABLED at boot time
+
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..8bec431c97ce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3038,6 +3038,15 @@ config IA32_EMULATION
 	  64-bit kernel. You should likely turn this on, unless you're
 	  100% sure that you don't have any 32-bit programs left.
 
+config IA32_EMULATION_DEFAULT_DISABLED
+	bool "IA32 emulation disabled by default"
+	default n
+	depends on IA32_EMULATION
+	help
+	  Make IA32 emulation disabled by default. This prevents loading 32bit
+	  processes and access to 32bit syscalls. If unsure, leave it to its
+	  default value.
+
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..35bacf2f8be5 100644
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
+bool __ia32_enabled = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int ia32_mode_override_cmdline(char *arg)
+{
+	if (!strcmp(arg, "disabled"))
+		__ia32_enabled = false;
+	else if (!strcmp(arg, "enabled"))
+		__ia32_enabled = true;
+
+	return 1;
+}
+__setup("ia32_mode=", ia32_mode_override_cmdline);
+#endif
+
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index fada857f0a1e..c35e4a6d3317 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -68,6 +68,20 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 #endif
 
-#endif /* CONFIG_IA32_EMULATION */
+extern bool __ia32_enabled;
+
+static inline bool ia32_enabled(void)
+{
+	return __ia32_enabled;
+}
+
+#else /* CONFIG_IA32_EMULATION */
+
+static inline bool ia32_enabled(void)
+{
+	return IS_ENABLED(CONFIG_X86_32);
+}
+
+#endif
 
 #endif /* _ASM_X86_IA32_H */
-- 
2.34.1

