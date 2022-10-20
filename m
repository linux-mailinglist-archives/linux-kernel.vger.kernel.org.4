Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B6605F02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiJTLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiJTLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:36:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A81DD889
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:36:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DAB72187E;
        Thu, 20 Oct 2022 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666265781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KHnL53pJczBHTqmZO1LrKItRzowSRHTkckS9BjAXjoE=;
        b=lYmD0CMx11/mhtHCnBMiU+WOl6vGhTpj/AiSjI9Y+eV6rL+Dhg8BSZjQG7421+kDbaFA0U
        CWHhBrzKzEkziGciqXPpbYv4fDQ3jH6dX3UkmdjaRulsa6RdNE4FvubOZnffhyyS/Px4vG
        IzZ7CeB9/zCegnAa22lBFdmlAaSAuZo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D0EB13494;
        Thu, 20 Oct 2022 11:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jr9bEbUyUWPWBQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 20 Oct 2022 11:36:21 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: simplify sysenter and syscall setup
Date:   Thu, 20 Oct 2022 13:36:19 +0200
Message-Id: <20221020113619.17204-1-jgross@suse.com>
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

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/setup.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index cfa99e8f054b..0f33ed6d3a7b 100644
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
+	if (boot_cpu_has(X86_FEATURE_SYSENTER32) &&
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
+	if (boot_cpu_has(X86_FEATURE_SYSCALL32) &&
+	    register_callback(CALLBACKTYPE_syscall32, xen_entry_SYSCALL_compat))
+		setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
 
 static void __init xen_pvmmu_arch_setup(void)
-- 
2.35.3

