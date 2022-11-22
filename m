Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D586F6341AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiKVQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKVQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:38:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1F1DDEF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:38:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E9571F86C;
        Tue, 22 Nov 2022 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669135111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W81+a3w29o+2kJo/uKGKHkjczRGs9DSxwdSixl+/5NM=;
        b=ffdpOp0+DsrHVZg8DrFMLNS7LXGnNIErwkB8BlJypLISgN8W9iGkeM7HIK10YTkOSpFqti
        pgU9/Yo32npE4wwk3YyPZs7oaRSNolja4Mz2ZfRz198hqR3BYTFqlZFdnS3P5wKS9+v8Mp
        5K+UqxdHbt3Zlq2PMITyuUNGwM6uXyU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42D6413AA1;
        Tue, 22 Nov 2022 16:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id stvRDgf7fGM7PgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Nov 2022 16:38:31 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 3/3] x86/xen: add a dummy trampoline for Xen PV guests
Date:   Tue, 22 Nov 2022 17:38:10 +0100
Message-Id: <20221122163810.29752-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221122163810.29752-1-jgross@suse.com>
References: <20221122163810.29752-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a Xen PV guest there is no need for setting up the
realmode trampoline, as realmode isn't supported in this environment.

Trying to setup the trampoline has been proven to be problematic in
some cases, especially when trying to debug early boot problems with
Xen requiring to keep the EFI boot-services memory mapped (some
firmware variants seem to claim basically all memory below 1M for boot
services).

Setup a dummy trampoline in order to make init_real_mode() happy.
In order to avoid too tight coupling between the Xen PV specific code
and the trampoline handling, modify the trampoline handling to do
nothing if the detected trampoline size is 0.

Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/realmode/init.c    |  6 ++++++
 arch/x86/xen/enlighten_pv.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 5a670a9ed2f7..538328ce5ff5 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -110,6 +110,9 @@ static void __init setup_real_mode(void)
 	int i;
 #endif
 
+	if (!size)
+		return;
+
 	base = (unsigned char *)real_mode_header;
 
 	/*
@@ -204,6 +207,9 @@ static void __init set_real_mode_permissions(void)
 	unsigned long text_start =
 		(unsigned long) __va(real_mode_header->text_start);
 
+	if (!size)
+		return;
+
 	set_memory_nx((unsigned long) base, size >> PAGE_SHIFT);
 	set_memory_ro((unsigned long) base, ro_size >> PAGE_SHIFT);
 	set_memory_x((unsigned long) text_start, text_size >> PAGE_SHIFT);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 038da45f057a..a6194a6a6806 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -71,6 +71,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/realmode.h>
 #ifdef CONFIG_X86_IOPL_IOPERM
 #include <asm/io_bitmap.h>
 #endif
@@ -137,12 +138,28 @@ static void __init xen_pv_init_platform(void)
 	xen_init_time_ops();
 }
 
+static struct real_mode_header xen_rm_header;
+
+static __initdata struct trampoline_ref xen_dummy_trampoline = {
+	.blob = (unsigned char *)&xen_rm_header,
+	.blob_end = (unsigned char *)&xen_rm_header,
+};
+
+/* Setup dummy trampoline of size 0 with no relocations. */
+static void __init xen_setup_trampoline(void)
+{
+	real_mode_header = &xen_rm_header;
+	real_mode_trampoline = &xen_dummy_trampoline;
+}
+
 static void __init xen_pv_guest_late_init(void)
 {
 #ifndef CONFIG_SMP
 	/* Setup shared vcpu info for non-smp configurations */
 	xen_setup_vcpu_info_placement();
 #endif
+
+	xen_setup_trampoline();
 }
 
 static __read_mostly unsigned int cpuid_leaf5_ecx_val;
-- 
2.35.3

