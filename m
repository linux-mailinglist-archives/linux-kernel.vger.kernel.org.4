Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C16638F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjAJF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjAJF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:15 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E441A79
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330147; x=1704866147;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=u9C72MWAdnebgAuucLCSxL3tgtUyaAcK7rWmwewvD48=;
  b=efiasDThEmkCC6b7qxFU1mv4C1VQd46UxmZCOOJsz+/ngF0yLbXYOmFH
   9Te1PtalasXkwT9lCS4HVHxM7CNi+uoSuliJFcDdmfZumqmhZI1ux/4Bw
   6GK2J76R9MbANfKK6tVSMlMEc2KslW65Ka6BHta5Fz2Le/FNFdF2PuXna
   igbGazyGm9dh3PEwaDNKdZqg2s1vyGYBtn1XBpVZCmDphA08jAoJ6FGJu
   WmvYCpZZO3mssqzr+PlLTYKTZozP5fq+5K0gFHFWjpZfynyD+PaDgGxUd
   gF02ImBcRjXLdsV4i1sORsqUOxxhJdxlkqoghAaMkg/E0nQhSjsD3kS3v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289958"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289958"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483739"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483739"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:39 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel alternatives
Date:   Mon,  9 Jan 2023 21:52:00 -0800
Message-Id: <20230110055204.3227669-4-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the kernel is mapped at virtual addresses
in the upper half of the address range. But kernel
deliberately initialized a temporary mm area
within the lower half of the address range
for text poking, see commit 4fc19708b165
("x86/alternatives: Initialize temporary mm
for patching").

LASS stops access to a lower half address in kernel,
and this can be deactivated if AC bit in EFLAGS
register is set. Hence use stac and clac instructions
around access to the address to avoid triggering a
LASS #GP fault.

Kernel objtool validation warns if the binary calls
to a non-whitelisted function that exists outside of
the stac/clac guard, or references any function with a
dynamic function pointer inside the guard; see section
9 in the document tools/objtool/Documentation/objtool.txt.

For these reasons, also considering text poking size is
usually small, simple modifications have been done
in function text_poke_memcpy() and text_poke_memset() to
avoid non-whitelisted function calls inside the stac/clac
guard.

Gcc may detect and replace the target with its built-in
functions. However, the replacement would break the
objtool validation criteria. Hence, add compiler option
-fno-builtin for the file.

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yian Chen <yian.chen@intel.com>
---
 arch/x86/include/asm/smap.h      | 13 +++++++++++++
 arch/x86/kernel/Makefile         |  2 ++
 arch/x86/kernel/alternative.c    | 21 +++++++++++++++++++--
 tools/objtool/arch/x86/special.c |  2 ++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index bab490379c65..6f7ac0839b10 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -39,6 +39,19 @@ static __always_inline void stac(void)
 	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
 }
 
+/* Deactivate/activate LASS via AC bit in EFLAGS register */
+static __always_inline void low_addr_access_begin(void)
+{
+	/* Note: a barrier is implicit in alternative() */
+	alternative("", __ASM_STAC, X86_FEATURE_LASS);
+}
+
+static __always_inline void low_addr_access_end(void)
+{
+	/* Note: a barrier is implicit in alternative() */
+	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bbc2bd4..f8a455fc56a2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -7,6 +7,8 @@ extra-y	+= vmlinux.lds
 
 CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
 
+CFLAGS_alternative.o	+= -fno-builtin
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_tsc.o = -pg
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7d8c3cbde368..4de8b54fb5f2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1530,14 +1530,31 @@ __ro_after_init unsigned long poking_addr;
 
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	const char *s = src;
+	char *d = dst;
+
+	/* The parameter dst ends up referencing to the global variable
+	 * poking_addr, which is mapped to the low half address space.
+	 * In kernel, accessing the low half address range is prevented
+	 * by LASS. So relax LASS prevention while accessing the memory
+	 * range.
+	 */
+	low_addr_access_begin();
+	while (len-- > 0)
+		*d++ = *s++;
+	low_addr_access_end();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
+	char *d = dst;
 
-	memset(dst, c, len);
+	/* The same comment as it is in function text_poke_memcpy */
+	low_addr_access_begin();
+	while (len-- > 0)
+		*d++ = c;
+	low_addr_access_end();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 7c97b7391279..3a34ebe3966a 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -6,11 +6,13 @@
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
+#define X86_FEATURE_LASS   (12 * 32 + 6)
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
 	switch (feature) {
 	case X86_FEATURE_SMAP:
+	case X86_FEATURE_LASS:
 		/*
 		 * If UACCESS validation is enabled; force that alternative;
 		 * otherwise force it the other way.
-- 
2.34.1

