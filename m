Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705665FF20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAFKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAFKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:47:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2636CFD8;
        Fri,  6 Jan 2023 02:47:44 -0800 (PST)
Date:   Fri, 06 Jan 2023 10:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673002061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCPmF4a7fJSy7N958ILHl30COeBhXJyN71lpqNDHdi4=;
        b=gNI9r51omTZ7ay/jxeNhhi8DdUpH7HxefHE5xsXPkpvwmOzP8XqzTuWuJJQXcYLeWovX6r
        3k0Zy213zyd5Q8kQXjaKADO+f0XFdsN4MKdaePzRKo1SZNodtAw5Ch9Kj7WuLRMrvSGr21
        /z990ZqHmIbdIEF8qLBl2VJGZpW02t8KwXe5L0z1vd7BkP4gtaRfxVrOA1v4FW8YzT13F1
        ZlSS7Yzy4KdbCcSmHFUtH0WZntz2uS7B3tNYHiskHcK5e4F5D8QmRqXhO5CGBelEUof6i4
        dHoEaApeDUtFUJhIQgBESZ3PoZuwzd99cgOFxGmI1E1M+k/ufMuY9mRMRRLYtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673002061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCPmF4a7fJSy7N958ILHl30COeBhXJyN71lpqNDHdi4=;
        b=xItUobodVDUSC86Sj9yLS7XaZDvDIEm+IEmdxLPy+yt3wvi7Tc23G6NUcpwDEiWqX/lD+x
        0W04LXc1JZamefAw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/signal/compat: Move sigaction_compat_abi() to signal_64.c
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221219193904.190220-3-brgerst@gmail.com>
References: <20221219193904.190220-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <167300206067.4906.9151776655307963512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6be9a8f18fb2ea88d37a69f076f7011fc012ae1a
Gitweb:        https://git.kernel.org/tip/6be9a8f18fb2ea88d37a69f076f7011fc012ae1a
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 19 Dec 2022 14:39:04 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Jan 2023 04:16:02 +01:00

x86/signal/compat: Move sigaction_compat_abi() to signal_64.c

Also remove the now-empty signal_compat.c.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221219193904.190220-3-brgerst@gmail.com
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/Makefile        |  1 -
 arch/x86/kernel/signal_64.c     | 13 +++++++++++++
 arch/x86/kernel/signal_compat.c | 15 ---------------
 3 files changed, 13 insertions(+), 16 deletions(-)
 delete mode 100644 arch/x86/kernel/signal_compat.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bb..dd61752 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -45,7 +45,6 @@ obj-y			+= head$(BITS).o
 obj-y			+= ebda.o
 obj-y			+= platform-quirks.o
 obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
-obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 9eea4e8..13a1e60 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -382,6 +382,19 @@ badframe:
 }
 #endif /* CONFIG_X86_X32_ABI */
 
+#ifdef CONFIG_COMPAT
+void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
+{
+	if (!act)
+		return;
+
+	if (in_ia32_syscall())
+		act->sa.sa_flags |= SA_IA32_ABI;
+	if (in_x32_syscall())
+		act->sa.sa_flags |= SA_X32_ABI;
+}
+#endif /* CONFIG_COMPAT */
+
 /*
 * If adding a new si_code, there is probably new data in
 * the siginfo.  Make sure folks bumping the si_code
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
deleted file mode 100644
index c4e9b85..0000000
--- a/arch/x86/kernel/signal_compat.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/compat.h>
-#include <linux/uaccess.h>
-#include <linux/ptrace.h>
-
-void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
-{
-	if (!act)
-		return;
-
-	if (in_ia32_syscall())
-		act->sa.sa_flags |= SA_IA32_ABI;
-	if (in_x32_syscall())
-		act->sa.sa_flags |= SA_X32_ABI;
-}
