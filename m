Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120573B5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFWLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjFWLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:14:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9BB7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:14:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 522791F74D;
        Fri, 23 Jun 2023 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687518856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vd0DHG16TEfVtLv+nXFsC8K54PSpOG5XQkdb5dg46oc=;
        b=o03RIBvCt1I0D3RN0/t1RkTpGK5BsUaQ1nksDEO9nbj/odlwBWpIPyJNKLLOCNLwW+F0M6
        RkIx5+EHrv3//LrqZDb2lGJ/bLBDf098Jw54KrLgh1dzkY4wO2u2ugWytoQdp5X8GnnoiT
        svsFuJpfGqRo9rvXBzD2zitLqAuIuAc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F05A81331F;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ACb3N4d+lWTcFAAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 23 Jun 2023 11:14:15 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4 6/6] x86: Make IA32_EMULATION boot time configurable
Date:   Fri, 23 Jun 2023 14:14:09 +0300
Message-Id: <20230623111409.3047467-7-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623111409.3047467-1-nik.borisov@suse.com>
References: <20230623111409.3047467-1-nik.borisov@suse.com>
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
to a variety of legacy software. This stems from the conjecture that
compat layer is likely rarely tested and could have latent security
bugs. Ideally distributions will set their default policy and also
give users the ability to override it as appropriate.

To enable this use case, introduce CONFIG_IA32_EMULATION_DEFAULT_DISABLED
compile time option, which controls whether 32bit processes/syscalls
should be allowed or not. This option is aimed mainly at distributions
to set their preferred default behavior in their kernels.

To allow users to override the distro's policy, introduce the 'ia32_emulation'
parameter which allows overriding CONFIG_IA32_EMULATION_DEFAULT_DISABLED
state at boot time.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 arch/x86/Kconfig                                | 9 +++++++++
 arch/x86/entry/common.c                         | 9 ++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..99ff94e963b8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1865,6 +1865,12 @@
 			 0 -- machine default
 			 1 -- force brightness inversion
 
+	ia32_emulation=		[X86-64]
+			Format: <bool>
+			When true, allows loading 32-bit programs and executing 32-bit
+			syscalls, essentially overriding IA32_EMULATION_DEFAULT_DISABLED at
+			boot time. When false, unconditionally disables IA32 emulation.
+
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..15f313399ed4 100644
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
+	  Make IA32 emulation disabled by default. This prevents loading 32-bit
+	  processes and access to 32-bit syscalls. If unsure, leave it to its
+	  default value.
+
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ef5a154a7413..b5dd1e226c99 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -97,7 +98,13 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_IA32_EMULATION
-bool __ia32_enabled = true;
+bool __ia32_enabled = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int ia32_emulation_override_cmdline(char *arg)
+{
+	return kstrtobool(arg, &__ia32_enabled);
+}
+early_param("ia32_emulation", ia32_emulation_override_cmdline);
 #endif
 
 /*
-- 
2.34.1

