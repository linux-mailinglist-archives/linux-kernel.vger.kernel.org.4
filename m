Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91A6341A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiKVQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiKVQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:38:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B101F2E4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:38:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D479D220D2;
        Tue, 22 Nov 2022 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669135105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+I+NFNsrgPcwpbYEM36avO5tqcTUKJxcOE3LZCYPOzk=;
        b=mIeCRU+eOEDZ+OxRe+gCqjBZczpRwBm/KW58ozh1UH86f5tQUWNDvcunZtdRU/vZhsghVv
        5Qyx86hbts/r7eOFaBgz4LnhJvZifALmN1l/dwRLsQGJ6xZYKkZhA/NnS2QQQOLKWFa25m
        bI3AF5u5BQU60zoM+MW/P+MiIhpuBwA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 974BC13AA1;
        Tue, 22 Nov 2022 16:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8I+QIwH7fGM0PgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Nov 2022 16:38:25 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/3] x86/realmode: add trampoline reference structure
Date:   Tue, 22 Nov 2022 17:38:09 +0100
Message-Id: <20221122163810.29752-3-jgross@suse.com>
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

Add a new struct trampoline_ref containing the relevant pointers for
handling the realmode trampoline. Use a central pointer for accessing
this new structure in preparation of adding support of replacing it
with a dummy trampoline.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/realmode.h | 12 +++++++++++-
 arch/x86/realmode/init.c        | 13 +++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 1eb3d4232e81..778d6cb1db6c 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -14,6 +14,13 @@
 #include <linux/types.h>
 #include <asm/io.h>
 
+/* Pointers for installing the realmode trampoline. */
+struct trampoline_ref {
+	unsigned char *blob;
+	unsigned char *blob_end;
+	unsigned char *relocs;
+};
+
 /* This must match data at realmode/rm/header.S */
 struct real_mode_header {
 	u32	text_start;
@@ -56,6 +63,8 @@ struct trampoline_header {
 };
 
 extern struct real_mode_header *real_mode_header;
+extern struct trampoline_ref *real_mode_trampoline __initdata;
+
 extern unsigned char real_mode_blob_end[];
 
 extern unsigned long initial_code;
@@ -78,7 +87,8 @@ extern unsigned char secondary_startup_64_no_verify[];
 
 static inline size_t real_mode_size_needed(void)
 {
-	return PAGE_ALIGN(real_mode_blob_end - real_mode_blob);
+	return PAGE_ALIGN(real_mode_trampoline->blob_end -
+			  real_mode_trampoline->blob);
 }
 
 static inline void set_real_mode_mem(phys_addr_t mem)
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 37a3658efaa0..5a670a9ed2f7 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -12,6 +12,15 @@
 #include <asm/sev.h>
 
 struct real_mode_header *real_mode_header;
+
+static __initdata struct trampoline_ref realmode_trampoline = {
+	.blob = real_mode_blob,
+	.blob_end = real_mode_blob_end,
+	.relocs = real_mode_relocs,
+};
+
+struct trampoline_ref *real_mode_trampoline __initdata = &realmode_trampoline;
+
 u32 *trampoline_cr4_features;
 
 /* Hold the pgd entry used on booting additional CPUs */
@@ -111,12 +120,12 @@ static void __init setup_real_mode(void)
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
-	memcpy(base, real_mode_blob, size);
+	memcpy(base, real_mode_trampoline->blob, size);
 
 	phys_base = __pa(base);
 	real_mode_seg = phys_base >> 4;
 
-	rel = (u32 *) real_mode_relocs;
+	rel = (u32 *) real_mode_trampoline->relocs;
 
 	/* 16-bit segment relocations. */
 	count = *rel++;
-- 
2.35.3

