Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510AF6F14BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjD1J4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345643AbjD1J4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:56:12 -0400
Received: from out187-19.us.a.mail.aliyun.com (out187-19.us.a.mail.aliyun.com [47.90.187.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E715B95;
        Fri, 28 Apr 2023 02:55:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---.STCEQ.F_1682675669;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEQ.F_1682675669)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:54:29 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Wang Yong" <yongw.kernel@gmail.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Jiapeng Chong" <jiapeng.chong@linux.alibaba.com>,
        "Alexander Lobakin" <alexandr.lobakin@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Michael Roth" <michael.roth@amd.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Nikunj A Dadhania" <nikunj@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH RFC 43/43] x86/boot: Extend relocate range for PIE kernel image
Date:   Fri, 28 Apr 2023 17:51:23 +0800
Message-Id: <872c71b61815d2dc582f3e3a9e7069fb4f6436eb.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow PIE kernel image to be relocated in unused holes in top 512G of
address space.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 Documentation/x86/x86_64/mm.rst  |  4 +++
 arch/x86/Kconfig                 | 11 +++++++
 arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.c  |  4 ++-
 arch/x86/boot/compressed/misc.h  |  9 ++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index 35e5e18c83d0..b456501a5b69 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -149,6 +149,10 @@ Note that if CONFIG_RANDOMIZE_MEMORY is enabled, the direct mapping of all
 physical memory, vmalloc/ioremap space and virtual memory map are randomized.
 Their order is preserved but their base will be offset early at boot time.
 
+Note that if EXTENDED_RANDOMIZE_BASE is enabled, the kernel image area
+including kernel image, module area and fixmap area is randomized as a whole
+in top 512G of address space.
+
 Be very careful vs. KASLR when changing anything here. The KASLR address
 range must not overlap with anything except the KASAN shadow area, which is
 correct as KASAN disables KASLR.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f8020991184..6d18d4333389 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2266,6 +2266,17 @@ config RANDOMIZE_BASE
 
 	  If unsure, say Y.
 
+config EXTENDED_RANDOMIZE_BASE
+	bool "Randomize the address of the kernel image (PIE)"
+	default y
+	depends on X86_PIE && RANDOMIZE_BASE
+	help
+	  This packs kernel image, module area and fixmap area as a
+	  whole, and allows it to be randomized in top 512G of virtual
+	  address space when PIE is enabled.
+
+	  If unsure, say Y.
+
 # Relocation on x86 needs some additional build support
 config X86_NEED_RELOCS
 	def_bool y
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 454757fbdfe5..e0e092fe7fe2 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -871,3 +871,58 @@ void choose_random_location(unsigned long input,
 		random_addr = find_random_virt_addr(LOAD_PHYSICAL_ADDR, output_size);
 	*virt_addr = random_addr;
 }
+
+#ifdef CONFIG_EXTENDED_RANDOMIZE_BASE
+struct kernel_image_slot {
+	unsigned long start;
+	unsigned long end;
+	unsigned long pud_slots;
+};
+
+/*
+ * Currently, there are two unused hole in top 512G, see
+ * Documentation/x86/x86_64/mm.rst, use the hole as the kernel image base.
+ */
+struct kernel_image_slot available_slots[] = {
+	{
+		.start = 0xffffff8000000000UL,
+		.end = 0xffffffeeffffffffUL,
+	},
+	{
+		.start = 0xffffffff00000000UL,
+		.end = 0xffffffffffffffffUL,
+	},
+};
+
+unsigned long pie_randomize(void)
+{
+	unsigned long total, slot;
+	int i;
+
+	if (cmdline_find_option_bool("nokaslr"))
+		return 0;
+
+	total = 0;
+	for (i = 0; i < ARRAY_SIZE(available_slots); i++) {
+		available_slots[i].pud_slots = (available_slots[i].end -
+						available_slots[i].start + 1UL) /
+						PUD_SIZE - 1UL;
+		total += available_slots[i].pud_slots;
+	}
+
+	slot = kaslr_get_random_long("PIE slot") % total;
+	for (i = 0; i < ARRAY_SIZE(available_slots); i++) {
+		if (slot < available_slots[i].pud_slots)
+			break;
+
+		slot -= available_slots[i].pud_slots;
+	}
+
+	if (i == ARRAY_SIZE(available_slots) || slot >= available_slots[i].pud_slots) {
+		warn("PIE randomize disabled: available slots are bad!");
+		return 0;
+	}
+
+	return (available_slots[i].start + slot * PUD_SIZE) - __START_KERNEL_map;
+}
+#endif
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 014ff222bf4b..e111b55edb8b 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -210,8 +210,10 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * needed if KASLR has chosen a different starting address offset
 	 * from __START_KERNEL_map.
 	 */
-	if (IS_ENABLED(CONFIG_X86_64))
+	if (IS_ENABLED(CONFIG_X86_64)) {
 		delta = virt_addr - LOAD_PHYSICAL_ADDR;
+		delta += pie_randomize();
+	}
 
 	if (!delta) {
 		debug_putstr("No relocation needed... ");
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 2f155a0e3041..f50717092902 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -113,6 +113,15 @@ static inline void choose_random_location(unsigned long input,
 }
 #endif
 
+#ifdef CONFIG_EXTENDED_RANDOMIZE_BASE
+unsigned long pie_randomize(void);
+#else
+static inline unsigned long pie_randomize(void)
+{
+	return 0;
+}
+#endif
+
 /* cpuflags.c */
 bool has_cpuflag(int flag);
 
-- 
2.31.1

