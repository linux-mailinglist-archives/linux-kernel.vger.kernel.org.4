Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4244F5EE135
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiI1QHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiI1QHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:07:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7EA3D37
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:07:33 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ee329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ee:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6852B1EC058B;
        Wed, 28 Sep 2022 18:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664381248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KoPBLOevuUuBIzvcma69Mz+NkzFMtuTSrKRMwbtrRc4=;
        b=nZeRv/il5cfZqetpYHQbFePApFFYc04uQSnNsY1KxxSsl80foO70/7PeGu+y9PW+x6WU6r
        nxn76mISeUk2DSqY09Rh4jYea4uuT1W6E35tOfZN50QhJiSFVCJgtTeeCROiUzKOjPD+mx
        5APWdaLW64hecT/xFidfi2Bh1W84PlM=
Date:   Wed, 28 Sep 2022 18:07:24 +0200
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
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <YzRxPAoN+XmOfJzV@zn.tnic>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:12:31PM -0500, Eric DeVolder wrote:
> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.

Please do not use lkml.org to refer to lkml messages. We have a
perfectly fine archival system at lore.kernel.org. You simply do

https://lore.kernel.org/r/<Message-ID>

when you want to point to a previous mail.

> David points out that terminology is tricky here due to differing behaviors.
> And perhaps that is your point in asking for guidance text. It can be
> complicated

Which means you need an explanation how to use this even more.

And why is CONFIG_CRASH_MAX_MEMORY_RANGES even a Kconfig item and not
something you discover from the hardware?

Your help text talks about System RAM entries in /proc/iomem which means
that those entries are present somewhere in the kernel and you can read
them out and do the proper calculations dynamically instead of doing the
static CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES thing.

> , but it all comes down to System RAM entries.
> 
> I could perhaps offer an overly simplified example such that for 1GiB block
> size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow for 32TiB
> of memory?

Yes, and stick it somewhere in Documentation/admin-guide/kdump/ and
refer to it in that help text so that people can find it and read how to
use your new option.

> The kbuf.bufsz value is obtained via a call to prepare_elf_headers(); I can
> not initialize it at its declaration.

Sorry, I meant this:

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 8fc7d678ac72..ee6fd9f1b2b9 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 	/* Ensure elfcorehdr segment large enough for hotplug changes */
@@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers_sz = kbuf.memsz;
 	image->elfcorehdr_index = image->nr_segments;
 	image->elfcorehdr_index_valid = true;
-#else
-	kbuf.memsz = kbuf.bufsz;
 #endif
+
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);

> I'm at a loss as to what to do differently here. You've raised this issue
> before and I went back and looked at the suggestions then and I don't see
> how that applies to this situation. How is this situation different than the
> #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?

See the diff at the end. I'm not saying this is how you should do it
but it should give you a better idea. The logic being, the functions
in the .c file don't really need ifdeffery around them - you're adding
1-2 functions and crash.c is not that big - so they can be built in
unconditionally. You'd need the ifdeffery *in the header only* when
crash.c is not being built.

But I've done it with ifdeffery in the .c file now because yes, the
kexec code is a minefield of ifdeffery. Hell, there's ifdeffery even in
the headers for structs. Ifdeffery you don't really need. Someone should
clean that up and simplify this immensely.

> Currently there is a concurrent effort for PPC support by Sourabh
> Jain, and in that effort arch_map_crash_pages() is using __va(paddr).

Why?

> I do not know the nuances between kmap_local_page() and __va() to
> answer the question.

kmap_local_page() is a generic interface and it should work on any arch.

And it is documented even:

$ git grep kmap_local_page Documentation/

> If kmap_local_page() works for all archs, then I'm happy to drop these
> arch_ variants and use it directly.

Yes, pls do.

---

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 432073385b2d..b73c9628cd85 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -205,6 +205,17 @@ void *arch_kexec_kernel_image_load(struct kimage *image);
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
+
+#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
+void arch_unmap_crash_pages(void **ptr);
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action);
+#else
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size) { return NULL; }
+void arch_unmap_crash_pages(void **ptr) { }
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
+#endif
+
 #endif
 #endif
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 8fc7d678ac72..a526c893abe8 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -395,8 +395,9 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
 	/* Ensure elfcorehdr segment large enough for hotplug changes */
@@ -407,9 +408,8 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers_sz = kbuf.memsz;
 	image->elfcorehdr_index = image->nr_segments;
 	image->elfcorehdr_index_valid = true;
-#else
-	kbuf.memsz = kbuf.bufsz;
 #endif
+
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -425,7 +425,8 @@ int crash_load_segments(struct kimage *image)
 }
 #endif /* CONFIG_KEXEC_FILE */
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+#ifdef CONFIG_CRASH_MAX_MEMORY_RANGES
+
 /*
  * NOTE: The addresses and sizes passed to this routine have
  * already been fully aligned on page boundaries. There is no
@@ -462,8 +463,7 @@ void arch_unmap_crash_pages(void **ptr)
  * is prepared in a kernel buffer, and then it is written on top
  * of the existing/old elfcorehdr.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image,
-	unsigned int hp_action)
+void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action)
 {
 	struct kexec_segment *ksegment;
 	unsigned char *ptr = NULL;
@@ -513,4 +513,5 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
 	if (elfbuf)
 		vfree(elfbuf);
 }
-#endif
+
+#endif /* CONFIG_CRASH_MAX_MEMORY_RANGES */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index a48577a36fb8..0f79ad4c4f80 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -27,6 +27,19 @@ extern struct resource crashk_res;
 extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem_range {
+	u64 start, end;
+};
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct crash_mem_range ranges[];
+};
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -237,19 +250,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem_range {
-	u64 start, end;
-};
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct crash_mem_range ranges[];
-};
-
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 5bc5159d9cb1..f6b5d835f826 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -622,6 +622,15 @@ static int __init crash_save_vmcoreinfo_init(void)
 subsys_initcall(crash_save_vmcoreinfo_init);
 
 #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+
+void __weak *arch_map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	return NULL;
+}
+
+void __weak arch_unmap_crash_pages(void **ptr) { }
+void __weak arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action) { }
+
 /*
  * To accurately reflect hot un/plug changes, the elfcorehdr (which
  * is passed to the crash kernel via the elfcorehdr= parameter)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
