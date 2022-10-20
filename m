Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E78605F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJTL75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJTL7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:59:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DCE3C8FE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:59:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53C0920A44;
        Thu, 20 Oct 2022 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666267188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oySpgM5g+r0WCk6Eq8kGRfyxgEAOWxWakiY/c8kh3qw=;
        b=JGPhQj1ZV+Sm3I4LVtq4L2JrCJZGFxiejo9qvyBgS68IuVh2HOzZyizIwaITr4r3lBXAam
        rB78ZqWe8tgRiWX2mcORmHaemwL1xdxp0yjq8zNmUfeecmJtUvLa7dUoD6pFb8YPEHLFd4
        /SlQGRy9MJC4I/CPIUhDGbvRjCNvmiM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1077413494;
        Thu, 20 Oct 2022 11:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zs6/AjQ4UWNSFAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 11:59:48 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v2] x86/xen: simplify sysenter and syscall setup
Date:   Thu, 20 Oct 2022 13:59:46 +0200
Message-Id: <20221020115946.18772-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_enable_sysenter() and xen_enable_syscall() can be simplified a lot.

While at it, switch to use cpu_feature_enabled() instead of
boot_cpu_has().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use cpu_feature_enabled() (Borislav Petkov)
---
 arch/x86/xen/setup.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index cfa99e8f054b..4f4309500559 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -910,17 +910,9 @@ static int register_callback(unsigned type, const void *func)
 
 void xen_enable_sysenter(void)
 {
-	int ret;
-	unsigned sysenter_feature;
-
-	sysenter_feature = X86_FEATURE_SYSENTER32;
-
-	if (!boot_cpu_has(sysenter_feature))
-		return;
-
-	ret = register_callback(CALLBACKTYPE_sysenter, xen_entry_SYSENTER_compat);
-	if(ret != 0)
-		setup_clear_cpu_cap(sysenter_feature);
+	if (cpu_feature_enabled(X86_FEATURE_SYSENTER32) &&
+	    register_callback(CALLBACKTYPE_sysenter, xen_entry_SYSENTER_compat))
+		setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
 }
 
 void xen_enable_syscall(void)
@@ -934,12 +926,9 @@ void xen_enable_syscall(void)
 		   mechanism for syscalls. */
 	}
 
-	if (boot_cpu_has(X86_FEATURE_SYSCALL32)) {
-		ret = register_callback(CALLBACKTYPE_syscall32,
-					xen_entry_SYSCALL_compat);
-		if (ret != 0)
-			setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
-	}
+	if (cpu_feature_enabled(X86_FEATURE_SYSCALL32) &&
+	    register_callback(CALLBACKTYPE_syscall32, xen_entry_SYSCALL_compat))
+		setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
 
 static void __init xen_pvmmu_arch_setup(void)
-- 
2.35.3

