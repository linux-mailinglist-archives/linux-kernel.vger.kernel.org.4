Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26955EDCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiI1Mce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiI1Mca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:32:30 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38287915F7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:32:29 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id h23-20020a197017000000b004977813cd43so4651481lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=JsFIRRYJ2T9TagGvX3xWTjwzlw12xCXMfZ5c7W97p44=;
        b=FI/rRBInCnWHnuN2dGpvZCvzhz3ex15QmBJNiZqcQewEhE1XXwLDQpMLVBembXx+NZ
         8Ksx1qY5ZxNbZnSAEfl5Pefz0U7T4c1XTkNXvIa5kOh7UrbLcELqZZ9DFQbSjNujzoZI
         DdS0An9I3TzRMDWzrkrLX2GcWvU67F3rXWH4EJ+8Tpbp7krbla92cE49cHIoapPQiP3a
         UkDvQb3S6zidubvXA3+yiZn9QLddxIqVl/XSWDU1NQWD5L2xHWn8+NAuSrPVD67RxxOf
         y/17LzkB6IVkbnkaf4v6w4rfJ24jjYLsn3wSxjcJg0maoN4pzwb/6/27rtQvnIVceF4P
         a5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=JsFIRRYJ2T9TagGvX3xWTjwzlw12xCXMfZ5c7W97p44=;
        b=zn6NP9lHZfqmJ0SfQB3Re2pl1gVahzUpdXZebwCssetfDdWRRdM1ELm1499Mtf0GVa
         zcOcbxnXMNKfiLNi4SKKet7JMvdVuzbwwKZ96dkW0gTvc10+qqzCQicFuGOvCKcn134j
         3DeLmLE+4uo2n3UH5UUQrF3x0iqhLfoLTn0bvRf5A13LMkikTfgLaQ/relsngwstqe8+
         aHCwFi63ME48nmcyCjqoFrM2XJSzy6ICmb1Khputn92jiwnC2fI7XkhX0e77rabBAaVZ
         wN1c/WoI55Nzecp20Q12c9ZQXDq/4XkgfUYYPI44audqe/VkHhmlLm+ur1Yovg/jprZ6
         mtPg==
X-Gm-Message-State: ACrzQf3JiPZwNh2IgFmyg/D4SL+rx6u58cc/Upja++sKZ6yuyYI/0OgU
        RtJyf31u/KP549GCC9P3n9WYVmE6uFk=
X-Google-Smtp-Source: AMsMyM7TdHDyxQ9jhSzFoaghSjQsnbdkOZBFSfedCadqIIjUK0N6a9//RbYrgMikASYo96tMEl2Zqvg9elo=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:6933:6590:440d:394])
 (user=glider job=sendgmr) by 2002:a05:6512:23a0:b0:499:4c84:b7a6 with SMTP id
 c32-20020a05651223a000b004994c84b7a6mr14207019lfv.390.1664368347413; Wed, 28
 Sep 2022 05:32:27 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:32:19 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928123219.1101883-1-glider@google.com>
Subject: [PATCH mm] x86: kmsan: handle CPU entry area
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among other data, CPU entry area holds exception stacks, so addresses
from this area can be passed to kmsan_get_metadata().

This previously led to kmsan_get_metadata() returning NULL, which in
turn resulted in a warning that triggered further attempts to call
kmsan_get_metadata() in the exception context, which quickly exhausted
the exception stack.

This patch allocates shadow and origin for the CPU entry area on x86 and
introduces arch_kmsan_get_meta_or_null(), which performs arch-specific
metadata mapping.

Signed-off-by: Alexander Potapenko <glider@google.com>
Fixes: 21d723a7c1409 ("kmsan: add KMSAN runtime core")
---
 MAINTAINERS                  |  1 +
 arch/x86/include/asm/kmsan.h | 32 ++++++++++++++++++++++++++++++++
 arch/x86/mm/Makefile         |  3 +++
 arch/x86/mm/kmsan_shadow.c   | 20 ++++++++++++++++++++
 mm/kmsan/shadow.c            |  6 +++++-
 5 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/mm/kmsan_shadow.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 517e71ea02156..3a39eb1fd3f6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11381,6 +11381,7 @@ L:	kasan-dev@googlegroups.com
 S:	Maintained
 F:	Documentation/dev-tools/kmsan.rst
 F:	arch/*/include/asm/kmsan.h
+F:	arch/*/mm/kmsan_*
 F:	include/linux/kmsan*.h
 F:	lib/Kconfig.kmsan
 F:	mm/kmsan/
diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
index a790b865d0a68..8fa6ac0e2d766 100644
--- a/arch/x86/include/asm/kmsan.h
+++ b/arch/x86/include/asm/kmsan.h
@@ -11,9 +11,41 @@
 
 #ifndef MODULE
 
+#include <asm/cpu_entry_area.h>
 #include <asm/processor.h>
 #include <linux/mmzone.h>
 
+DECLARE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_shadow);
+DECLARE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_origin);
+
+/*
+ * Functions below are declared in the header to make sure they are inlined.
+ * They all are called from kmsan_get_metadata() for every memory access in
+ * the kernel, so speed is important here.
+ */
+
+/*
+ * Compute metadata addresses for the CPU entry area on x86.
+ */
+static inline void *arch_kmsan_get_meta_or_null(void *addr, bool is_origin)
+{
+	unsigned long addr64 = (unsigned long)addr;
+	char *metadata_array;
+	unsigned long off;
+	int cpu;
+
+	if ((addr64 < CPU_ENTRY_AREA_BASE) ||
+	    (addr64 >= (CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE)))
+		return NULL;
+	cpu = (addr64 - CPU_ENTRY_AREA_BASE) / CPU_ENTRY_AREA_SIZE;
+	off = addr64 - (unsigned long)get_cpu_entry_area(cpu);
+	if ((off < 0) || (off >= CPU_ENTRY_AREA_SIZE))
+		return NULL;
+	metadata_array = is_origin ? cpu_entry_area_origin :
+				     cpu_entry_area_shadow;
+	return &per_cpu(metadata_array[off], cpu);
+}
+
 /*
  * Taken from arch/x86/mm/physaddr.h to avoid using an instrumented version.
  */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 39c0700c9955c..76b5a0f7533cc 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -43,6 +43,9 @@ obj-$(CONFIG_HIGHMEM)		+= highmem_32.o
 KASAN_SANITIZE_kasan_init_$(BITS).o := n
 obj-$(CONFIG_KASAN)		+= kasan_init_$(BITS).o
 
+KMSAN_SANITIZE_kmsan_shadow.o	:= n
+obj-$(CONFIG_KMSAN)		+= kmsan_shadow.o
+
 obj-$(CONFIG_MMIOTRACE)		+= mmiotrace.o
 mmiotrace-y			:= kmmio.o pf_in.o mmio-mod.o
 obj-$(CONFIG_MMIOTRACE_TEST)	+= testmmiotrace.o
diff --git a/arch/x86/mm/kmsan_shadow.c b/arch/x86/mm/kmsan_shadow.c
new file mode 100644
index 0000000000000..bee2ec4a3bfa8
--- /dev/null
+++ b/arch/x86/mm/kmsan_shadow.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * x86-specific bits of KMSAN shadow implementation.
+ *
+ * Copyright (C) 2022 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ */
+
+#include <asm/cpu_entry_area.h>
+#include <linux/percpu-defs.h>
+
+/*
+ * Addresses within the CPU entry area (including e.g. exception stacks) do not
+ * have struct page entries corresponding to them, so they need separate
+ * handling.
+ * arch_kmsan_get_meta_or_null() (declared in the header) maps the addresses in
+ * CPU entry area to addresses in cpu_entry_area_shadow/cpu_entry_area_origin.
+ */
+DEFINE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_shadow);
+DEFINE_PER_CPU(char[CPU_ENTRY_AREA_SIZE], cpu_entry_area_origin);
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 6e90a806a7045..21e3e196ec3cf 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -12,7 +12,6 @@
 #include <linux/cacheflush.h>
 #include <linux/memblock.h>
 #include <linux/mm_types.h>
-#include <linux/percpu-defs.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
@@ -126,6 +125,7 @@ void *kmsan_get_metadata(void *address, bool is_origin)
 {
 	u64 addr = (u64)address, pad, off;
 	struct page *page;
+	void *ret;
 
 	if (is_origin && !IS_ALIGNED(addr, KMSAN_ORIGIN_SIZE)) {
 		pad = addr % KMSAN_ORIGIN_SIZE;
@@ -136,6 +136,10 @@ void *kmsan_get_metadata(void *address, bool is_origin)
 	    kmsan_internal_is_module_addr(address))
 		return (void *)vmalloc_meta(address, is_origin);
 
+	ret = arch_kmsan_get_meta_or_null(address, is_origin);
+	if (ret)
+		return ret;
+
 	page = virt_to_page_or_null(address);
 	if (!page)
 		return NULL;
-- 
2.37.3.998.g577e59143f-goog

