Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11276645772
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiLGKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLGKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:20:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57829CE10
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:20:00 -0800 (PST)
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF9681EC01E0;
        Wed,  7 Dec 2022 11:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670408399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hDwchu5WKWCgmm4vmsqSytCqDgC46MDaYK7Byjk/kcs=;
        b=UsWNFmf1WL++RlApKVLd3IgqwoP/G3Xb0EMWUlob3QYFwZuov/9f8jQ+NDtV263XJM9Zvk
        NT0RHmrdQTSz11yh4B2q+1+1EN3nBwZgIZ4iEVYVX6mppAp74PG43jC7zvIMCYLg7zx+Wn
        +kADImrNJjaljc5LaS50UDvd/3HsKp4=
Date:   Wed, 7 Dec 2022 11:19:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y5BozkPot12L5d9w@zn.tnic>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116214643.6384-8-eric.devolder@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:46:43PM -0500, Eric DeVolder wrote:
> When CPU or memory is hot un/plugged, the crash elfcorehdr, which
> describes the CPUs and memory in the system, must also be updated.
> 
> A new elfcorehdr is generated from the available CPUs and memory
> into a buffer, and then installed over the top of the existing
> elfcorehdr. The segment containing the elfcorehdr is identified
> at run time in crash_core:handle_hotplug_event(), which works for
> both the kexec_load() and kexec_file_load() syscalls.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES description.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/Kconfig             |   9 +++
>  arch/x86/include/asm/kexec.h |  15 +++++
>  arch/x86/kernel/crash.c      | 106 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 3 deletions(-)

Some quick cleanups ontop, there's potential for more:

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ffee99046942..486509030d3a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2091,13 +2091,16 @@ config CRASH_DUMP
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
 config CRASH_HOTPLUG
-	bool "kernel updates of crash elfcorehdr"
+	bool "Update the crash elfcorehdr on system configuration changes"
 	default n
 	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
 	help
-	  Enable the kernel to directly update the crash elfcorehdr (which
-	  contains the list of CPUs and memory regions to be dumped upon
-	  a crash) in response to hot plug/unplug of CPUs or memory.
+	  Enable direct updates to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug of CPUs or memory. This is a much
+	  more advanced approach than userspace attempting that.
+
+	  If unsure, say Y.
 
 config KEXEC_JUMP
 	bool "kexec jump"
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index d2238bcf8106..d26f208e582e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -413,25 +413,32 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers_sz	= kbuf.bufsz;
 	kbuf.memsz		= kbuf.bufsz;
 
-#ifdef CONFIG_CRASH_HOTPLUG
-	/* Ensure elfcorehdr segment large enough for hotplug changes */
-	unsigned long pnum = 2; /* VMCOREINFO and kernel_map */
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		pnum += CONFIG_NR_CPUS_DEFAULT;
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		pnum += CRASH_MAX_MEMORY_RANGES;
-	if (pnum < (unsigned long)PN_XNUM) {
-		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
-		kbuf.memsz += sizeof(Elf64_Ehdr);
-		image->elfcorehdr_index = image->nr_segments;
-		image->elfcorehdr_index_valid = true;
-		/* Mark as usable to crash kernel, else crash kernel fails on boot */
-		image->elf_headers_sz = kbuf.memsz;
-	} else {
-		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		/*
+		 * Ensure the elfcorehdr segment large enough for hotplug changes.
+		 * Start with VMCOREINFO and kernel_map:
+		 */
+		unsigned long pnum = 2;
+
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+			pnum += CONFIG_NR_CPUS_DEFAULT;
+
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+			}
 	}
-#endif
 
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
@@ -463,10 +470,9 @@ int crash_load_segments(struct kimage *image)
  */
 void arch_crash_handle_hotplug_event(struct kimage *image)
 {
+	void *elfbuf, *old_elfcorehdr;
 	unsigned long mem, memsz;
-	unsigned long elfsz = 0;
-	void *elfbuf = NULL;
-	void *ptr;
+	unsigned long elfsz;
 
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
@@ -489,26 +495,24 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 		goto out;
 	}
 
-	/*
-	 * Copy new elfcorehdr over the old elfcorehdr at destination.
-	 */
-	ptr = arch_map_crash_pages(mem, memsz);
-	if (ptr) {
-		/*
-		 * Temporarily invalidate the crash image while the
-		 * elfcorehdr is updated.
-		 */
-		xchg(&kexec_crash_image, NULL);
-		memcpy_flushcache(ptr, elfbuf, elfsz);
-		xchg(&kexec_crash_image, image);
-		arch_unmap_crash_pages(ptr);
-		pr_debug("updated elfcorehdr\n");
-	} else {
+	/* Copy new elfcorehdr over the old elfcorehdr at destination. */
+	old_elfcorehdr = arch_map_crash_pages(mem, memsz);
+	if (!old_elfcorehdr) {
 		pr_err("updating elfcorehdr failed\n");
+		goto out;
 	}
 
+	/*
+	 * Temporarily invalidate the crash image while the elfcorehdr
+	 * is updated.
+	 * */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	arch_unmap_crash_pages(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
 out:
-	if (elfbuf)
-		vfree(elfbuf);
+	vfree(elfbuf);
 }
 #endif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
