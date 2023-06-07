Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0E7255C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjFGHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjFGHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:34:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEAF1732
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:29:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E50891FDAA;
        Wed,  7 Jun 2023 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686122981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqq6UhRIP8V5iprW/mRk4CtPTff+2A8nkYP1uvN5Ufk=;
        b=J13oiSBuySdL0XZnaC2j/NGbglep5cLPbEzW87z2t/fZFd51RaIx3uI+TXjdOTeSMDMfkM
        01TXfZY3GqA4y3OSrSQBSxasos2+p5lA0FEwiqyfEJSi6d33N+aUp6T2mWKP47KUUDcgYn
        LnqFergeIjaZdQpGuBy2+I8vWFY55mg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96ECC13776;
        Wed,  7 Jun 2023 07:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kJ9OIuUxgGSUIQAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Wed, 07 Jun 2023 07:29:41 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 1/3] x86: Introduce ia32_disabled boot parameter
Date:   Wed,  7 Jun 2023 10:29:34 +0300
Message-Id: <20230607072936.3766231-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607072936.3766231-1-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
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
is the support for 32bit syscalls on a 64bit kernel. Ideally we'd have
the ability to disable the the compat support at boot time. This would
allow the decision whether it should be disabled/enabled can be
delegated to system administrators.

This patch simply introduces ia32_disable boot parameter which aims at
disabling 32 bit process support even if CONFIG_IA32_EMULATION has been
selected at build time.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/common.c      | 12 ++++++++++++
 arch/x86/include/asm/traps.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..817518768ba2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -96,6 +97,17 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 	return (int)regs->orig_ax;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+bool ia32_disabled = false;
+
+static int ia32_disabled_cmdline(char *arg)
+{
+	ia32_disabled = true;
+	return 1;
+}
+__setup("ia32_disabled", ia32_disabled_cmdline);
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

