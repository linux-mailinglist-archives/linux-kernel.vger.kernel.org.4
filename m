Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568B71277F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbjEZN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjEZN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:28:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC8B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:28:20 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2215B21B0A;
        Fri, 26 May 2023 13:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685107699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6yvhh592Q06cVFtClLtKEZXEcpjQOvzte1sHIMrItU0=;
        b=EnHyiSYBs4ZUIosM4GKx272iFBJk01FgNBO4hiXNEc/pK8MFYCztsoVfNu7sK6AzbMJ9gI
        P2e0uQ0j5TxEm3Bz7B3p4aFvPbk/78CtclTYWnyAAdfSGBQDeEMvI8a/vvTBO4TRTXw0Ic
        RFbCOl9e8OUiTZO2eGm70gjlN6e8Q+0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CB67613684;
        Fri, 26 May 2023 13:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qlW8LvKzcGSNaAAAGKfGzw
        (envelope-from <nik.borisov@suse.com>); Fri, 26 May 2023 13:28:18 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [RFC PATCH] x86/entry: Disable ia32 syscalls and introduce a boot time toggle
Date:   Fri, 26 May 2023 16:28:06 +0300
Message-Id: <20230526132806.1475900-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
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
is the support for 32bit syscalls on a 64bit kernel. Ideally the compat
support should be disabled for the majority of the time, yet in the few
cases where it might be needed it'd be good if there is some toggle
which would allow users to turn on back compat support.

This patch aims to cater for this use case by disabling ia32 syscalls
and introducing a boot time parameter 'ia32_enabled' which if set to
'true' brings backs 32bit syscall support.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

Rather than being a final implementation I'd like this to serve as a conversation
starter and agree on a final solution that's acceptable to everyone.

 arch/x86/entry/common.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..6063727a75fe 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/init.h>

 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -96,6 +97,20 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 	return (int)regs->orig_ax;
 }

+int ia32_enabled = 0;
+
+static int __init ia32_enabled_parsecmdline(char *arg)
+{
+	if (!strcmp(arg, "true"))
+		ia32_enabled = 1;
+	else
+		pr_crit("Unsupported ia32_enabled=%s, ia32 syscalls disabled\n",
+			arg);
+
+	return 0;
+}
+early_param("ia32_enabled", ia32_enabled_parsecmdline);
+
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
@@ -107,7 +122,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 	 */
 	unsigned int unr = nr;

-	if (likely(unr < IA32_NR_syscalls)) {
+	if (likely(unr < IA32_NR_syscalls) && ia32_enabled) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[unr](regs);
 	} else if (nr != -1) {
--
2.34.1

